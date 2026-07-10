-- Metric views for domain: project | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic project portfolio metrics providing executives with visibility into project health, cost performance, schedule adherence, and portfolio composition across all active projects."
  source: "`vibe_manufacturing_v1`.`project`.`project_header`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of project (e.g., capital, operational, R&D) for portfolio segmentation."
    - name: "project_category"
      expr: project_category
      comment: "Business category of the project for strategic grouping."
    - name: "project_phase"
      expr: project_phase
      comment: "Current lifecycle phase of the project (e.g., planning, execution, closeout)."
    - name: "priority"
      expr: priority
      comment: "Project priority level (e.g., high, medium, low) for resource allocation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level assigned to the project for risk-based portfolio steering."
    - name: "project_header_status"
      expr: project_header_status
      comment: "Current status of the project (e.g., active, on-hold, completed, cancelled)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which project financials are reported."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the project for regional portfolio analysis."
    - name: "sponsor_business_unit"
      expr: sponsor_business_unit
      comment: "Business unit sponsoring the project for accountability and cost allocation."
    - name: "planned_start_year_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned project start date for pipeline timing analysis."
    - name: "planned_end_year_month"
      expr: DATE_TRUNC('MONTH', planned_end_date)
      comment: "Month bucket of planned project end date for completion forecasting."
    - name: "governance_approval_status"
      expr: governance_approval_status
      comment: "Governance approval status of the project for compliance and gate tracking."
    - name: "is_template"
      expr: is_template
      comment: "Flag indicating whether the project is a template rather than an active project."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of projects in the portfolio. Baseline KPI for portfolio size and workload."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all projects. Drives capital allocation and financial planning decisions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all projects. Compared against budget to assess financial performance."
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per project. Indicates typical project investment size for benchmarking."
    - name: "avg_actual_cost_per_project"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per project. Used alongside avg budget to assess cost efficiency."
    - name: "avg_critical_path_duration_days"
      expr: AVG(CAST(critical_path_duration_days AS DOUBLE))
      comment: "Average critical path duration in days across projects. Informs schedule risk and resource planning."
    - name: "total_actual_work_hours"
      expr: SUM(CAST(actual_work_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across all projects. Key input for workforce capacity planning."
    - name: "total_planned_work_hours"
      expr: SUM(CAST(total_work_hours AS DOUBLE))
      comment: "Total planned labor hours across all projects. Baseline for workforce demand forecasting."
    - name: "avg_percent_complete"
      expr: AVG(CAST(actual_oee_percent AS DOUBLE))
      comment: "Average OEE percent across projects as a proxy for operational efficiency of project execution."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT project_header_id)
      comment: "Count of distinct projects. Used to validate portfolio size and avoid double-counting in aggregations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget performance metrics tracking budget utilization, variance, and financial health at the WBS and project level to support financial governance and reforecasting decisions."
  source: "`vibe_manufacturing_v1`.`project`.`project_budget`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget (e.g., labor, materials, equipment) for cost breakdown analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget record (e.g., approved, draft, locked)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual financial planning and reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency portfolio analysis."
    - name: "owner_role"
      expr: owner_role
      comment: "Role of the budget owner for accountability and governance reporting."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget (e.g., top-down, bottom-up) for process analysis."
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the budget is locked, indicating finalized vs. in-progress budgets."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month bucket of budget effective start date for temporal budget analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget amount. Primary financial baseline for project cost governance."
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original budget before revisions. Enables tracking of budget growth and scope creep."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after approved changes. Reflects current authorized spend ceiling."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (POs, contracts) against budget. Indicates financial exposure."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total actual spend against budget. Core metric for budget utilization tracking."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining budget available. Critical for go/no-go decisions on additional spend."
    - name: "total_transferred_in"
      expr: SUM(CAST(transferred_in_amount AS DOUBLE))
      comment: "Total budget transferred into projects. Tracks inter-project budget reallocation."
    - name: "total_transferred_out"
      expr: SUM(CAST(transferred_out_amount AS DOUBLE))
      comment: "Total budget transferred out of projects. Tracks inter-project budget reallocation."
    - name: "avg_budget_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(spent_amount AS DOUBLE)) / NULLIF(AVG(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Average budget utilization percentage. Key efficiency KPI showing how much of approved budget has been consumed."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of budget records. Used for governance audits and budget structure analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_cost_actual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actual project cost metrics enabling financial controllers and project managers to monitor cost posting patterns, variance, and fiscal period spend against plan."
  source: "`vibe_manufacturing_v1`.`project`.`cost_actual`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost posting for annual financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost posting for period-over-period cost trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost posting for multi-currency financial consolidation."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the cost posting (e.g., posted, reversed, pending) for financial accuracy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cost record for governance and audit compliance."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase during which the cost was incurred for phase-level cost analysis."
    - name: "is_budgeted"
      expr: is_budgeted
      comment: "Whether the cost was budgeted, enabling analysis of unplanned vs. planned spend."
    - name: "is_manual_entry"
      expr: is_manual_entry
      comment: "Whether the cost was manually entered, flagging potential data quality risks."
    - name: "overhead_allocation_flag"
      expr: overhead_allocation_flag
      comment: "Whether the cost includes overhead allocation for fully-loaded cost analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month bucket of posting date for monthly cost trend reporting."
  measures:
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total actual cost amount posted to projects. Primary financial performance metric for cost control."
    - name: "total_cost_controlling_currency"
      expr: SUM(CAST(amount_controlling_currency AS DOUBLE))
      comment: "Total cost in controlling currency for group-level financial consolidation."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount on cost records for budget vs. actual comparison."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. budget). Negative variance signals cost overrun requiring management action."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on project costs for tax reporting and compliance."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of resources consumed across cost postings for resource utilization analysis."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average cost variance percentage across postings. Indicates systemic over/under-spend patterns."
    - name: "cost_posting_count"
      expr: COUNT(1)
      comment: "Number of cost postings. Indicates cost posting activity volume and financial transaction load."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_earned_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) metrics providing executives and PMOs with schedule and cost performance indices to assess project health and forecast completion."
  source: "`vibe_manufacturing_v1`.`project`.`earned_value_record`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the EVM record for multi-currency portfolio analysis."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Method used to forecast EAC (e.g., CPI-based, ETC-based) for methodology consistency analysis."
    - name: "is_forecast"
      expr: is_forecast
      comment: "Whether the record is a forecast vs. actuals for separating reported vs. projected performance."
    - name: "reporting_date_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month bucket of reporting date for period-over-period EVM trend analysis."
    - name: "baseline_version"
      expr: baseline_version
      comment: "Baseline version against which EVM is measured for version-controlled performance tracking."
    - name: "approved_by"
      expr: approved_by
      comment: "Person who approved the EVM record for governance and accountability."
  measures:
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total Planned Value (BCWS) — the authorized budget for scheduled work. Baseline for schedule performance."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total Earned Value (BCWP) — the value of work actually performed. Core EVM performance indicator."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total Actual Cost (ACWP) — actual cost incurred for work performed. Used to compute cost variance."
    - name: "total_estimate_to_complete"
      expr: SUM(CAST(estimate_to_complete AS DOUBLE))
      comment: "Total Estimate to Complete (ETC) — remaining cost to finish the project. Drives reforecast decisions."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total Cost Variance (EV - AC). Negative value signals cost overrun requiring executive intervention."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total Schedule Variance (EV - PV). Negative value signals schedule slippage requiring corrective action."
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average Cost Performance Index (EV/AC). CPI < 1.0 indicates cost inefficiency across the portfolio."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average Schedule Performance Index (EV/PV). SPI < 1.0 indicates schedule underperformance."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across EVM records. High-level portfolio progress indicator."
    - name: "evm_record_count"
      expr: COUNT(1)
      comment: "Number of EVM records. Indicates EVM reporting coverage across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone performance metrics tracking on-time delivery, cost adherence, and payment milestone achievement to support schedule governance and contract management."
  source: "`vibe_manufacturing_v1`.`project`.`milestone`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., payment, phase gate, delivery) for milestone category analysis."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., pending, achieved, overdue) for schedule tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the milestone for risk-based prioritization."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the milestone for regulatory and contractual adherence tracking."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the milestone is on the critical path, enabling focus on schedule-critical deliverables."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of milestone financial values for multi-currency reporting."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month bucket of planned milestone date for schedule pipeline analysis."
    - name: "responsible_party_role"
      expr: responsible_party_role
      comment: "Role responsible for the milestone for accountability and workload analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of milestones. Baseline for schedule complexity and delivery tracking."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount tied to milestones. Critical for cash flow forecasting and contract billing."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred at milestone level for granular cost tracking."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost at milestone level for budget vs. actual comparison."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance at milestone level. Identifies milestones driving budget overruns."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average milestone completion percentage. Indicates overall schedule progress across the portfolio."
    - name: "avg_actual_duration_days"
      expr: AVG(CAST(actual_duration_days AS DOUBLE))
      comment: "Average actual duration of milestones in days. Compared to planned duration for schedule performance."
    - name: "avg_planned_duration_days"
      expr: AVG(CAST(planned_duration_days AS DOUBLE))
      comment: "Average planned duration of milestones in days. Baseline for schedule performance benchmarking."
    - name: "critical_milestone_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical milestones. Drives focus on schedule-critical deliverables in steering meetings."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project activity execution metrics providing schedule performance, labor efficiency, and cost variance insights at the work-package level for operational project control."
  source: "`vibe_manufacturing_v1`.`project`.`activity`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity (e.g., engineering, procurement, construction) for work breakdown analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (e.g., not started, in progress, complete) for schedule tracking."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the activity is on the critical path for schedule risk prioritization."
    - name: "is_on_critical_path"
      expr: is_on_critical_path
      comment: "Secondary critical path flag for activities identified via dynamic scheduling."
    - name: "milestone_flag"
      expr: milestone_flag
      comment: "Whether the activity represents a milestone for milestone-level reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of activity cost values for financial reporting."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned activity start for schedule pipeline analysis."
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month bucket of planned activity finish for completion forecasting."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of activities. Baseline for project complexity and workload assessment."
    - name: "total_labor_hours_estimated"
      expr: SUM(CAST(labor_hours_estimated AS DOUBLE))
      comment: "Total estimated labor hours across activities. Drives workforce demand planning."
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed. Compared to estimated for labor efficiency analysis."
    - name: "total_material_cost_estimated"
      expr: SUM(CAST(material_cost_estimated AS DOUBLE))
      comment: "Total estimated material cost across activities for procurement planning."
    - name: "total_material_cost_actual"
      expr: SUM(CAST(material_cost_actual AS DOUBLE))
      comment: "Total actual material cost. Compared to estimated for material cost variance analysis."
    - name: "total_equipment_cost_estimated"
      expr: SUM(CAST(equipment_cost_estimated AS DOUBLE))
      comment: "Total estimated equipment cost for capital planning and asset utilization."
    - name: "total_equipment_cost_actual"
      expr: SUM(CAST(equipment_cost_actual AS DOUBLE))
      comment: "Total actual equipment cost for equipment cost variance tracking."
    - name: "total_earned_value_bcwp"
      expr: SUM(CAST(earned_value_bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (BCWP) at activity level. Core EVM metric for activity-level performance."
    - name: "total_earned_value_bcws"
      expr: SUM(CAST(earned_value_bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (BCWS) at activity level. Schedule baseline for EVM."
    - name: "total_earned_value_acwp"
      expr: SUM(CAST(earned_value_acwp AS DOUBLE))
      comment: "Total Actual Cost of Work Performed (ACWP) at activity level. Actual spend for EVM cost variance."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across activities. Indicates overall execution progress."
    - name: "avg_float_days"
      expr: AVG(CAST(float_days AS DOUBLE))
      comment: "Average schedule float in days. Low float indicates schedule tightness and risk of delay."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Drives focus for schedule acceleration decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project financial commitment metrics tracking open obligations, consumed spend, and variance against budget to support cash flow management and financial close processes."
  source: "`vibe_manufacturing_v1`.`project`.`commitment`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of commitment (e.g., purchase order, contract, reservation) for obligation classification."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (e.g., open, partially consumed, closed) for liability tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the commitment for governance and financial control."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the commitment for multi-currency financial reporting."
    - name: "is_funds_reserved"
      expr: is_funds_reserved
      comment: "Whether funds are formally reserved against budget for funds management compliance."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for committed quantities for procurement and logistics analysis."
    - name: "commitment_date_month"
      expr: DATE_TRUNC('MONTH', commitment_date)
      comment: "Month bucket of commitment date for commitment pipeline and cash flow forecasting."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount across all project commitments. Represents total financial obligations."
    - name: "total_consumed_amount"
      expr: SUM(CAST(consumed_amount AS DOUBLE))
      comment: "Total consumed amount from commitments. Indicates how much of committed spend has been realized."
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (unconsumed) commitment amount. Represents outstanding financial obligations."
    - name: "total_net_committed_amount"
      expr: SUM(CAST(net_committed_amount AS DOUBLE))
      comment: "Total net committed amount after adjustments. Used for accurate financial exposure reporting."
    - name: "total_actual_spent_amount"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE))
      comment: "Total actual spend against commitments. Validates commitment-to-invoice matching."
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount on commitments for budget vs. commitment variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between committed and budgeted amounts. Signals budget pressure from commitments."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on commitments for tax liability forecasting."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total committed quantity across commitments for procurement volume analysis."
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Total number of commitments. Indicates financial obligation volume and procurement activity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project change request metrics tracking scope change frequency, cost and schedule impact, and approval cycle times to support change governance and project baseline integrity."
  source: "`vibe_manufacturing_v1`.`project`.`project_change_request`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change request (e.g., scope, cost, schedule) for change impact categorization."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change request (e.g., submitted, approved, rejected) for pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change request for governance compliance reporting."
    - name: "priority"
      expr: priority
      comment: "Priority of the change request for triage and resource allocation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change request for risk-based change management."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the change request is critical, requiring expedited review and approval."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of change request financial impacts for multi-currency reporting."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month bucket of change request submission date for change frequency trend analysis."
    - name: "project_change_request_status"
      expr: project_change_request_status
      comment: "Detailed status of the change request for workflow stage analysis."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests. High volume indicates scope instability requiring management attention."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change requests. Quantifies financial exposure from scope changes."
    - name: "total_cost_delta_amount"
      expr: SUM(CAST(cost_delta_amount AS DOUBLE))
      comment: "Total cost delta from approved changes. Tracks cumulative budget growth from change orders."
    - name: "avg_cost_impact_per_change"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change request. Benchmarks typical change cost for risk assessment."
    - name: "critical_change_request_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical change requests. Drives executive escalation and expedited approval processes."
    - name: "approved_change_request_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved change requests. Indicates approved scope growth and baseline revisions."
    - name: "pending_change_request_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Number of pending change requests. Indicates backlog in change approval pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project resource utilization and cost metrics enabling workforce planners and project managers to optimize resource allocation, identify over/under-utilization, and control labor costs."
  source: "`vibe_manufacturing_v1`.`project`.`resource_assignment`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of resource assignment (e.g., labor, equipment, subcontractor) for resource category analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (e.g., active, completed, cancelled) for workforce tracking."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the assigned resource for skill-based utilization analysis."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the assigned resource for competency-based resource planning."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the assignment for revenue recognition and client billing."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Whether the assignment involves overtime for labor cost and compliance monitoring."
    - name: "department_code"
      expr: department_code
      comment: "Department of the assigned resource for departmental workload analysis."
    - name: "resource_utilization_category"
      expr: resource_utilization_category
      comment: "Utilization category of the resource for capacity planning segmentation."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month bucket of assignment start for resource demand timeline analysis."
  measures:
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned resource hours. Primary input for capacity planning and workforce demand forecasting."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked. Compared to planned for labor efficiency and schedule performance."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. High overtime signals resource constraints and potential burnout risk."
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average resource allocation percentage. Values near 100% indicate fully loaded resources."
    - name: "avg_utilization_percent"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average resource utilization percentage. Key efficiency KPI for workforce productivity."
    - name: "total_cost_rate_amount"
      expr: SUM(CAST(cost_rate_amount AS DOUBLE))
      comment: "Total cost rate amount across assignments. Drives labor cost forecasting and project financial planning."
    - name: "resource_assignment_count"
      expr: COUNT(1)
      comment: "Total number of resource assignments. Indicates project staffing complexity and workforce demand."
    - name: "distinct_employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees assigned to projects. Measures workforce breadth and team size."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timesheet labor metrics enabling project controllers to track billable vs. non-billable hours, overtime, and labor cost accuracy for project financial management and workforce compliance."
  source: "`vibe_manufacturing_v1`.`project`.`timesheet`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity recorded on the timesheet for labor category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the timesheet for payroll and billing compliance."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the hours are billable to the client for revenue recognition and billing analysis."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category (e.g., direct, indirect, overhead) for cost allocation analysis."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labor grade of the employee for compensation and cost rate analysis."
    - name: "expense_flag"
      expr: expense_flag
      comment: "Whether the timesheet includes expense entries for expense management."
    - name: "department_code"
      expr: department_code
      comment: "Department of the employee for departmental labor cost analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-based labor analysis and scheduling optimization."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month bucket of work date for monthly labor cost trend reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the timesheet entry is compliant with labor regulations for compliance monitoring."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all timesheet entries. Primary labor input metric for project cost and billing."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Elevated overtime signals resource constraints and labor cost risk."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total labor cost from timesheets. Core financial metric for project cost control."
    - name: "total_expense_amount"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense amount from timesheet entries. Tracks project-related expenses for reimbursement."
    - name: "total_cost_rate"
      expr: SUM(CAST(cost_rate AS DOUBLE))
      comment: "Sum of cost rates across timesheet entries for blended rate analysis."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across timesheet entries. Benchmarks labor cost efficiency."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier. Indicates premium labor cost exposure from overtime."
    - name: "timesheet_entry_count"
      expr: COUNT(1)
      comment: "Total number of timesheet entries. Indicates labor recording activity and compliance coverage."
    - name: "distinct_employee_timesheet_count"
      expr: COUNT(DISTINCT timesheet_employee_id)
      comment: "Number of distinct employees submitting timesheets. Measures workforce engagement and time-tracking compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_procurement_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project procurement performance metrics tracking spend, delivery, and invoice status to support supply chain governance, cost control, and vendor performance management."
  source: "`vibe_manufacturing_v1`.`project`.`procurement_item`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "procurement_category"
      expr: procurement_category
      comment: "Category of procurement (e.g., materials, services, equipment) for spend category analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method (e.g., competitive bid, sole source) for sourcing strategy analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the procurement item for pipeline and delivery tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the procurement item for governance compliance."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status of the procurement item for accounts payable and cash flow management."
    - name: "is_invoiced"
      expr: is_invoiced
      comment: "Whether the item has been invoiced for invoice matching and payment processing."
    - name: "is_received"
      expr: is_received
      comment: "Whether the item has been received for goods receipt and delivery performance tracking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the procurement item for supply chain risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of procurement values for multi-currency spend analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month bucket of delivery date for procurement delivery timeline analysis."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated procurement cost. Baseline for project procurement budget planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual procurement cost. Compared to estimated for procurement cost variance analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement amount after discounts. Represents actual financial obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on procurement items for tax compliance and cost reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount achieved on procurement. Measures procurement negotiation effectiveness."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity procured across items for volume analysis and inventory planning."
    - name: "total_receipt_quantity"
      expr: SUM(CAST(receipt_quantity AS DOUBLE))
      comment: "Total quantity received. Compared to ordered quantity for delivery completeness tracking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across procurement items. Benchmarks pricing for vendor negotiations."
    - name: "procurement_item_count"
      expr: COUNT(1)
      comment: "Total number of procurement items. Indicates procurement activity volume and complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_invoice_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project billing and revenue metrics tracking invoice request amounts, approval status, and billing progress to support revenue recognition, cash flow, and contract billing governance."
  source: "`vibe_manufacturing_v1`.`project`.`invoice_request`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "invoice_request_status"
      expr: invoice_request_status
      comment: "Current status of the invoice request (e.g., draft, submitted, approved) for billing pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice request for financial governance."
    - name: "billing_basis"
      expr: billing_basis
      comment: "Basis for billing (e.g., milestone, time-and-material, fixed price) for contract type analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice request for multi-currency revenue reporting."
    - name: "is_advance"
      expr: is_advance
      comment: "Whether the invoice request is an advance payment for cash flow management."
    - name: "is_final"
      expr: is_final
      comment: "Whether the invoice request is the final billing for project closeout tracking."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice request for tax compliance analysis."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month bucket of invoice request date for monthly billing pipeline analysis."
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested for invoicing. Primary revenue pipeline metric for project billing."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross invoice request amount including taxes. Represents total billing exposure."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net invoice request amount after discounts. Represents net revenue to be recognized."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoice requests for tax liability reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount on invoice requests. Tracks revenue leakage from discounting."
    - name: "avg_percent_complete_at_billing"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average project percent complete at time of invoice request. Validates billing against progress."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to invoice requests for tax planning and compliance."
    - name: "invoice_request_count"
      expr: COUNT(1)
      comment: "Total number of invoice requests. Indicates billing activity volume and revenue pipeline depth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project settlement metrics tracking cost settlement amounts, receiver types, and financial close activities to support project accounting, asset capitalization, and period-end close."
  source: "`vibe_manufacturing_v1`.`project`.`settlement`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g., to cost center, to fixed asset, to G/L) for settlement routing analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (e.g., posted, reversed, pending) for financial close tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the settlement for financial governance and audit compliance."
    - name: "receiver_object_type"
      expr: receiver_object_type
      comment: "Type of receiver object (e.g., cost center, fixed asset, order) for settlement distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement for multi-currency financial reporting."
    - name: "is_manual_settlement"
      expr: is_manual_settlement
      comment: "Whether the settlement was manually created, flagging potential data quality risks."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the settlement is a reversal for net settlement analysis."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period of the settlement for period-end close and financial reporting."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month bucket of settlement date for monthly settlement activity analysis."
  measures:
    - name: "total_settlement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total settlement amount. Primary metric for project cost settlement and capitalization tracking."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross settlement amount including taxes for full financial exposure reporting."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net settlement amount after tax for net cost capitalization analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on settlements for tax compliance and reporting."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Total number of settlement records. Indicates settlement activity volume for period-end close monitoring."
    - name: "manual_settlement_count"
      expr: COUNT(CASE WHEN is_manual_settlement = TRUE THEN 1 END)
      comment: "Number of manual settlements. High manual settlement count signals process automation gaps."
    - name: "reversal_settlement_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of settlement reversals. High reversal count indicates data quality or process issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS element financial and schedule metrics providing project controllers with cost performance, schedule status, and billing element coverage across the work breakdown structure."
  source: "`vibe_manufacturing_v1`.`project`.`wbs_element`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS element (e.g., summary, work package, account assignment) for WBS structure analysis."
    - name: "wbs_element_status"
      expr: wbs_element_status
      comment: "Current status of the WBS element for project structure health monitoring."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status of the WBS element (e.g., on track, delayed) for schedule performance reporting."
    - name: "wbs_element_level"
      expr: wbs_element_level
      comment: "Hierarchical level of the WBS element for top-down cost rollup analysis."
    - name: "is_billing_element"
      expr: is_billing_element
      comment: "Whether the WBS element is a billing element for revenue recognition and client billing."
    - name: "billing_element_flag"
      expr: billing_element_flag
      comment: "Secondary billing element flag for billing coverage analysis."
    - name: "milestone_flag"
      expr: milestone_flag
      comment: "Whether the WBS element has an associated milestone for milestone-linked cost tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of WBS element financial values for multi-currency reporting."
    - name: "responsible_department_code"
      expr: responsible_department_code
      comment: "Department responsible for the WBS element for accountability and cost allocation."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned WBS start date for schedule pipeline analysis."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across WBS elements. Baseline for project cost planning and budget allocation."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred at WBS level. Core metric for cost performance monitoring."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance at WBS level. Identifies WBS elements driving budget overruns."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across WBS elements. Indicates overall project execution progress."
    - name: "wbs_element_count"
      expr: COUNT(1)
      comment: "Total number of WBS elements. Indicates project structural complexity."
    - name: "billing_element_count"
      expr: COUNT(CASE WHEN is_billing_element = TRUE THEN 1 END)
      comment: "Number of billing WBS elements. Drives revenue recognition and client billing coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project issue and risk metrics tracking open issues, resolution rates, cost impact, and severity distribution to support risk management and project governance decisions."
  source: "`vibe_manufacturing_v1`.`project`.`issue`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "issue_type"
      expr: issue_type
      comment: "Type of issue (e.g., technical, commercial, resource) for issue category analysis."
    - name: "issue_status"
      expr: issue_status
      comment: "Current status of the issue (e.g., open, in progress, resolved) for issue pipeline tracking."
    - name: "priority"
      expr: priority
      comment: "Priority of the issue for triage and escalation decisions."
    - name: "severity"
      expr: severity
      comment: "Severity of the issue for impact assessment and resource prioritization."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the issue for management visibility and intervention tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of issue cost values for financial impact reporting."
    - name: "raised_date_month"
      expr: DATE_TRUNC('MONTH', raised_date)
      comment: "Month bucket of issue raised date for issue trend analysis."
  measures:
    - name: "total_issues"
      expr: COUNT(1)
      comment: "Total number of issues. High issue count signals project health problems requiring management attention."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of issues. Quantifies financial impact of project problems."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of issues. Provides forward-looking financial risk exposure."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across issues. Indicates overall project risk exposure level."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average probability of issue occurrence. Used in expected value risk calculations."
    - name: "open_issue_count"
      expr: COUNT(CASE WHEN issue_status = 'OPEN' THEN 1 END)
      comment: "Number of open issues. Primary operational KPI for issue backlog management."
    - name: "high_priority_issue_count"
      expr: COUNT(CASE WHEN priority = 'HIGH' THEN 1 END)
      comment: "Number of high-priority issues. Drives executive escalation and resource reallocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_gate_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project gate review metrics tracking decision outcomes, financial reauthorization, and compliance status at governance gates to support portfolio steering and stage-gate process effectiveness."
  source: "`vibe_manufacturing_v1`.`project`.`gate_review`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "gate_type"
      expr: gate_type
      comment: "Type of gate review (e.g., phase gate, investment gate) for governance process analysis."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the gate review decision (e.g., proceed, hold, cancel) for portfolio steering."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the gate review (e.g., scheduled, completed, deferred) for governance pipeline."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at the gate for regulatory and governance adherence tracking."
    - name: "financial_status"
      expr: financial_status
      comment: "Financial health status at the gate for investment decision support."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessed at the gate for risk-based investment decisions."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the gate review is critical for expedited review prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of gate financial values for multi-currency portfolio reporting."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month bucket of gate review date for governance calendar analysis."
  measures:
    - name: "total_gate_reviews"
      expr: COUNT(1)
      comment: "Total number of gate reviews. Indicates governance activity and portfolio stage-gate coverage."
    - name: "total_reauthorized_amount"
      expr: SUM(CAST(reauthorized_amount AS DOUBLE))
      comment: "Total reauthorized investment amount at gate reviews. Tracks capital reallocation through governance."
    - name: "avg_reauthorized_amount"
      expr: AVG(CAST(reauthorized_amount AS DOUBLE))
      comment: "Average reauthorized amount per gate review. Benchmarks typical investment reauthorization size."
    - name: "proceed_decision_count"
      expr: COUNT(CASE WHEN decision_outcome = 'PROCEED' THEN 1 END)
      comment: "Number of gate reviews with proceed decisions. Indicates portfolio advancement rate."
    - name: "hold_decision_count"
      expr: COUNT(CASE WHEN decision_outcome = 'HOLD' THEN 1 END)
      comment: "Number of gate reviews with hold decisions. Signals projects requiring remediation before proceeding."
    - name: "cancel_decision_count"
      expr: COUNT(CASE WHEN decision_outcome = 'CANCEL' THEN 1 END)
      comment: "Number of gate reviews resulting in project cancellation. Tracks portfolio rationalization decisions."
    - name: "critical_gate_review_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical gate reviews. Drives executive prioritization of governance activities."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_progress_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project progress reporting metrics tracking cost and schedule performance trends, forecast accuracy, and reporting cadence to support PMO governance and executive steering."
  source: "`vibe_manufacturing_v1`.`project`.`progress_report`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "overall_status"
      expr: overall_status
      comment: "Overall project status (e.g., green, amber, red) for portfolio health dashboard."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status at time of report for schedule performance trend analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level reported for risk trend monitoring across the portfolio."
    - name: "reporting_cadence"
      expr: reporting_cadence
      comment: "Frequency of progress reporting (e.g., weekly, monthly) for governance process analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at time of report for regulatory adherence tracking."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the report flags critical issues requiring executive attention."
    - name: "report_date_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month bucket of report date for monthly portfolio performance trend analysis."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost reported across progress reports. Tracks cumulative project spend."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost at time of reporting for budget vs. actual trend analysis."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance reported. Tracks cumulative financial performance across reporting periods."
    - name: "avg_overall_percent_complete"
      expr: AVG(CAST(overall_percent_complete AS DOUBLE))
      comment: "Average overall percent complete across reports. Indicates portfolio-level execution progress."
    - name: "avg_forecast_percent_complete"
      expr: AVG(CAST(forecast_percent_complete AS DOUBLE))
      comment: "Average forecast percent complete. Compared to actual for forecast accuracy assessment."
    - name: "progress_report_count"
      expr: COUNT(1)
      comment: "Total number of progress reports. Indicates reporting compliance and PMO governance activity."
    - name: "critical_report_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of progress reports flagging critical issues. Drives executive escalation and intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project handover and closeout metrics tracking acceptance status, documentation completeness, warranty transfer, and final cost to support project closeout governance and asset transfer."
  source: "`vibe_manufacturing_v1`.`project`.`handover`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "handover_type"
      expr: handover_type
      comment: "Type of handover (e.g., internal, client, operational) for handover category analysis."
    - name: "handover_status"
      expr: handover_status
      comment: "Current status of the handover (e.g., pending, accepted, rejected) for closeout tracking."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Client or operations acceptance status for contractual obligation fulfillment."
    - name: "documentation_package_status"
      expr: documentation_package_status
      comment: "Status of the documentation package for handover completeness governance."
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Risk assessment status at handover for safety and compliance verification."
    - name: "outstanding_items_flag"
      expr: outstanding_items_flag
      comment: "Whether there are outstanding items at handover for punch list management."
    - name: "warranty_transfer_flag"
      expr: warranty_transfer_flag
      comment: "Whether warranty has been transferred at handover for asset management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of handover financial values for multi-currency reporting."
    - name: "handover_date_month"
      expr: DATE_TRUNC('MONTH', handover_date)
      comment: "Month bucket of handover date for closeout timeline analysis."
  measures:
    - name: "total_handovers"
      expr: COUNT(1)
      comment: "Total number of handovers. Indicates project closeout activity and portfolio completion rate."
    - name: "total_final_cost_amount"
      expr: SUM(CAST(final_cost_amount AS DOUBLE))
      comment: "Total final cost at handover. Represents actual project investment for capitalization and reporting."
    - name: "total_value_amount"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value delivered at handover. Measures business value realized from project investments."
    - name: "avg_final_cost_amount"
      expr: AVG(CAST(final_cost_amount AS DOUBLE))
      comment: "Average final cost per handover. Benchmarks project delivery cost for future planning."
    - name: "accepted_handover_count"
      expr: COUNT(CASE WHEN acceptance_status = 'ACCEPTED' THEN 1 END)
      comment: "Number of accepted handovers. Measures successful project delivery and client satisfaction."
    - name: "outstanding_items_handover_count"
      expr: COUNT(CASE WHEN outstanding_items_flag = TRUE THEN 1 END)
      comment: "Number of handovers with outstanding items. Indicates incomplete deliveries requiring follow-up."
    - name: "documentation_complete_count"
      expr: COUNT(CASE WHEN documentation_complete_flag = TRUE THEN 1 END)
      comment: "Number of handovers with complete documentation. Measures documentation compliance at closeout."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_commissioning_checklist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commissioning quality and completion metrics tracking checklist pass rates, punch list items, and cost performance to support project quality assurance and operational readiness decisions."
  source: "`vibe_manufacturing_v1`.`project`.`commissioning_checklist`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "checklist_type"
      expr: checklist_type
      comment: "Type of commissioning checklist (e.g., mechanical, electrical, safety) for system-level analysis."
    - name: "checklist_status"
      expr: checklist_status
      comment: "Current status of the checklist (e.g., in progress, complete, failed) for readiness tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the commissioning checklist for quality governance."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the commissioning activity for safety and quality prioritization."
    - name: "overall_pass"
      expr: overall_pass
      comment: "Whether the checklist passed overall for operational readiness determination."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the checklist is on the critical path for schedule-critical commissioning tracking."
    - name: "is_external_vendor_involved"
      expr: is_external_vendor_involved
      comment: "Whether an external vendor is involved for vendor performance and cost tracking."
    - name: "commissioning_date_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month bucket of commissioning date for readiness timeline analysis."
  measures:
    - name: "total_checklists"
      expr: COUNT(1)
      comment: "Total number of commissioning checklists. Indicates commissioning scope and complexity."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated commissioning cost. Drives commissioning budget planning and resource allocation."
    - name: "total_items"
      expr: SUM(CAST(total_items AS DOUBLE))
      comment: "Total number of checklist items across all commissioning checklists. Measures commissioning scope."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average commissioning completion percentage. Indicates overall operational readiness progress."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual commissioning duration in hours. Compared to estimated for schedule performance."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated commissioning duration in hours. Baseline for schedule planning."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours in commissioning. Signals resource constraints and schedule pressure."
    - name: "passed_checklist_count"
      expr: COUNT(CASE WHEN overall_pass = TRUE THEN 1 END)
      comment: "Number of checklists that passed overall. Measures commissioning quality and readiness rate."
$$;