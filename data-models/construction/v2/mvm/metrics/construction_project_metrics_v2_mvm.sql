-- Metric views for domain: project | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the construction project portfolio — contract value, budget performance, schedule adherence, and delivery health across all active projects."
  source: "`vibe_construction_v1`.`project`.`construction_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, Closed, On Hold) — primary filter for portfolio health views."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project type (e.g. Civil, MEP, Infrastructure) — used to segment portfolio by work category."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contractual delivery model (e.g. EPC, Design-Build, EPCM) — key dimension for benchmarking performance across procurement strategies."
    - name: "region"
      expr: region
      comment: "Geographic region of the project — enables regional portfolio analysis and resource allocation decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country where the project is located — supports country-level regulatory and financial reporting."
    - name: "pmo_classification"
      expr: pmo_classification
      comment: "PMO tier or classification assigned to the project — used to segment by strategic importance or complexity."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "Health, Safety and Environment risk level assigned to the project — critical for safety governance dashboards."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Indicates whether the project is a joint venture — affects revenue recognition, risk sharing, and reporting boundaries."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED sustainability certification level — used for ESG and green-building portfolio reporting."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the project was planned to start — enables cohort analysis of project vintage and pipeline timing."
    - name: "planned_completion_year"
      expr: DATE_TRUNC('YEAR', planned_completion_date)
      comment: "Year the project is planned to complete — used for workload forecasting and revenue recognition scheduling."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted revenue across the portfolio — primary top-line KPI for executive portfolio reviews and revenue forecasting."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Sum of approved project budgets — baseline for cost performance and budget utilisation analysis."
    - name: "active_project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct active projects in the portfolio — headline capacity and workload indicator for PMO steering."
    - name: "avg_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across projects — portfolio-level completion health indicator for executive dashboards."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across projects — values below 1.0 signal cost overruns requiring executive intervention."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across projects — values below 1.0 indicate schedule slippage across the portfolio."
    - name: "total_jv_partner_share_pct"
      expr: AVG(CAST(jv_partner_share_pct AS DOUBLE))
      comment: "Average joint-venture partner equity share — informs consolidated revenue recognition and risk exposure for JV projects."
    - name: "avg_retention_pct"
      expr: AVG(CAST(retention_pct AS DOUBLE))
      comment: "Average contractual retention percentage held by clients — impacts cash flow forecasting and working capital management."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average daily liquidated damages rate across projects — quantifies financial exposure from schedule delays for risk management."
    - name: "budget_to_contract_ratio"
      expr: ROUND(SUM(CAST(approved_budget AS DOUBLE)) / NULLIF(SUM(CAST(contract_value AS DOUBLE)), 0), 4)
      comment: "Ratio of approved budget to contract value — values approaching or exceeding 1.0 signal margin erosion and require corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost control KPIs at the cost account level — tracks budget consumption, earned value, cost variance, and forecast accuracy to drive project financial governance."
  source: "`vibe_construction_v1`.`project`.`cost_account`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g. Labour, Material, Subcontract, Overhead) — primary dimension for cost breakdown analysis."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the cost account (e.g. Open, Closed, Pending) — used to filter active vs. closed accounts in reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the cost account is denominated — required for multi-currency portfolio consolidation."
    - name: "is_subcontract_scope"
      expr: is_subcontract_scope
      comment: "Indicates whether the cost account covers subcontracted scope — enables subcontract cost exposure analysis."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates whether the account is priced as a lump sum — affects how cost variance and progress are interpreted."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code associated with the account — enables financial reporting alignment with the general ledger."
    - name: "reporting_period"
      expr: DATE_TRUNC('MONTH', reporting_period_date)
      comment: "Reporting month for the cost account snapshot — enables period-over-period cost trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities (e.g. m3, tonnes, hours) — supports productivity and unit-rate benchmarking."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across cost accounts — baseline for all cost performance calculations."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred to date — primary cost consumption KPI for project financial control."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed cost (contracts awarded but not yet invoiced) — critical for cash flow and exposure management."
    - name: "total_cost_to_complete"
      expr: SUM(CAST(cost_to_complete_amount AS DOUBLE))
      comment: "Total estimated cost to complete remaining scope — key input to Estimate at Completion and final cost forecasting."
    - name: "total_forecast_cost_at_completion"
      expr: SUM(CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Total Estimate at Completion (EAC) across cost accounts — the definitive forecast of final project cost for executive reporting."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (budget minus actual) — negative values indicate cost overrun requiring management intervention."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value_amount AS DOUBLE))
      comment: "Total earned value (BCWP) — measures the budgeted value of work actually performed, core EVM KPI."
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget held across cost accounts — tracks risk reserve consumption and remaining buffer."
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total approved change order value absorbed into cost accounts — measures scope growth impact on project budget."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across cost accounts — portfolio-level efficiency indicator; below 1.0 signals systemic cost overrun."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across cost accounts — below 1.0 indicates schedule slippage in the work breakdown."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across cost accounts — overall progress indicator for the project scope."
    - name: "budget_utilisation_rate"
      expr: ROUND(SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of actual cost to approved budget — values above 1.0 indicate budget overrun; used in executive cost health scorecards."
    - name: "eac_vs_budget_variance_rate"
      expr: ROUND((SUM(CAST(forecast_cost_at_completion AS DOUBLE)) - SUM(CAST(approved_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 4)
      comment: "Percentage deviation of EAC from approved budget — quantifies forecast cost growth as a proportion of original budget for steering decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order management KPIs — tracks volume, financial impact, approval cycle, and disputed change orders to govern scope creep and contract risk."
  source: "`vibe_construction_v1`.`project`.`change_order`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the change order (e.g. Approved, Pending, Rejected) — primary filter for change order pipeline management."
    - name: "change_type"
      expr: change_type
      comment: "Category of change (e.g. Scope, Design, Client-Directed) — identifies root cause of scope growth for trend analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the change order — enables Pareto analysis of change drivers to reduce future scope creep."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model under which the change order was raised — benchmarks change order frequency across contract types."
    - name: "cost_impact_currency"
      expr: cost_impact_currency
      comment: "Currency of the cost impact — required for multi-currency portfolio consolidation."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flags change orders under commercial dispute — disputed COs represent unresolved financial risk requiring legal/commercial attention."
    - name: "is_ld_applicable"
      expr: is_ld_applicable
      comment: "Indicates whether liquidated damages apply to this change order — critical for financial exposure quantification."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the change order — used to triage approval workload and escalation decisions."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month the change order was submitted — enables trend analysis of change order volume over time."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the change order was approved — used to measure approval cycle time and backlog aging."
  measures:
    - name: "total_change_order_count"
      expr: COUNT(DISTINCT change_order_id)
      comment: "Total number of distinct change orders — headline volume KPI for scope change governance and contract management."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of all change orders — quantifies cumulative scope growth value for executive financial reporting."
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct cost component of change orders — separates direct labour/material cost from overhead for margin analysis."
    - name: "total_overhead_and_profit"
      expr: SUM(CAST(overhead_and_profit_amount AS DOUBLE))
      comment: "Total overhead and profit claimed on change orders — monitors margin recovery on scope changes."
    - name: "total_contingency_drawn"
      expr: SUM(CAST(contingency_drawn_amount AS DOUBLE))
      comment: "Total contingency drawn down through change orders — tracks risk reserve consumption rate for project financial health."
    - name: "disputed_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN is_disputed = TRUE THEN change_order_id END)
      comment: "Number of change orders currently under commercial dispute — a leading indicator of contract relationship health and legal exposure."
    - name: "disputed_cost_impact"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial value of disputed change orders — quantifies unresolved commercial risk on the balance sheet."
    - name: "avg_cost_impact_per_co"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order — benchmarks change order size and identifies outliers driving disproportionate cost growth."
    - name: "ld_applicable_co_count"
      expr: COUNT(DISTINCT CASE WHEN is_ld_applicable = TRUE THEN change_order_id END)
      comment: "Number of change orders where liquidated damages apply — quantifies LD exposure events for contract risk management."
    - name: "overhead_recovery_rate"
      expr: ROUND(SUM(CAST(overhead_and_profit_amount AS DOUBLE)) / NULLIF(SUM(CAST(direct_cost_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of overhead and profit to direct cost on change orders — measures margin recovery efficiency on scope changes; below target triggers commercial review."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_evm_period_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) period KPIs — provides period-level BCWP, BCWS, ACWP, CPI, SPI, EAC, and VAC to drive project performance governance and forecast accuracy."
  source: "`vibe_construction_v1`.`project`.`evm_period_record`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the EVM record — required for multi-currency portfolio consolidation."
    - name: "measurement_level"
      expr: measurement_level
      comment: "Level at which EVM is measured (e.g. WBS, Phase, Project) — determines granularity of performance reporting."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Method used to forecast EAC (e.g. CPI-based, ETC-based) — affects comparability of EAC across projects."
    - name: "progress_measurement_method"
      expr: progress_measurement_method
      comment: "Method used to measure physical progress (e.g. Milestone, Weighted Steps) — impacts earned value reliability."
    - name: "record_status"
      expr: record_status
      comment: "Status of the EVM record (e.g. Submitted, Approved, Draft) — filters for approved records in official reporting."
    - name: "cpi_trend"
      expr: cpi_trend
      comment: "Trend direction of CPI (Improving, Stable, Declining) — leading indicator for executive intervention decisions."
    - name: "spi_trend"
      expr: spi_trend
      comment: "Trend direction of SPI (Improving, Stable, Declining) — schedule health trend for PMO steering meetings."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Reporting period month — primary time dimension for period-over-period EVM trend analysis."
    - name: "data_date_month"
      expr: DATE_TRUNC('MONTH', data_date)
      comment: "Data date month of the EVM snapshot — used to align EVM records to the correct reporting cycle."
  measures:
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) — measures the budgeted value of completed work; core EVM performance numerator."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value) — the baseline against which schedule performance is measured."
    - name: "total_acwp"
      expr: SUM(CAST(acwp AS DOUBLE))
      comment: "Total Actual Cost of Work Performed — the actual spend incurred for completed work; denominator for CPI calculation."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC) — the authorised total budget for all work; baseline for VAC and TCPI calculations."
    - name: "total_eac"
      expr: SUM(CAST(eac AS DOUBLE))
      comment: "Total Estimate at Completion — the current best forecast of total project cost; primary financial completion KPI."
    - name: "total_etc"
      expr: SUM(CAST(etc AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost to finish all work; drives cash flow forecasting and resource planning."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total Cost Variance (BCWP minus ACWP) — negative values indicate cost overrun; triggers corrective action in project controls."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total Schedule Variance (BCWP minus BCWS) — negative values indicate schedule slippage; key input to delay and LD risk assessment."
    - name: "total_vac"
      expr: SUM(CAST(vac AS DOUBLE))
      comment: "Total Variance at Completion (BAC minus EAC) — negative VAC signals projected cost overrun at project completion."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across EVM records — portfolio efficiency indicator; below 1.0 triggers executive cost review."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across EVM records — below 1.0 indicates systemic schedule underperformance."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index — values above 1.0 indicate the remaining work must be done more efficiently than past performance; a recovery difficulty indicator."
    - name: "avg_physical_percent_complete"
      expr: AVG(CAST(physical_percent_complete AS DOUBLE))
      comment: "Average physical percent complete across EVM records — overall portfolio progress indicator for executive dashboards."
    - name: "period_bcwp_total"
      expr: SUM(CAST(period_bcwp AS DOUBLE))
      comment: "Total earned value generated in the current reporting period — measures period productivity for progress payment and performance reviews."
    - name: "period_acwp_total"
      expr: SUM(CAST(period_acwp AS DOUBLE))
      comment: "Total actual cost incurred in the current reporting period — period cash burn rate for treasury and cash flow management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project cost forecast KPIs — tracks EAC movement, cost variance, contingency consumption, and forecast accuracy to support financial completion governance."
  source: "`vibe_construction_v1`.`project`.`forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. Monthly, Quarterly, Final) — determines the reporting cycle and comparability of forecast records."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Approval status of the forecast (e.g. Draft, Approved, Submitted) — filters for authorised forecasts in official reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Base currency of the forecast — required for multi-currency consolidation."
    - name: "reporting_currency_code"
      expr: reporting_currency_code
      comment: "Reporting currency for client-facing forecast submissions — enables currency translation analysis."
    - name: "cost_trend_indicator"
      expr: cost_trend_indicator
      comment: "Direction of cost trend (Improving, Stable, Worsening) — leading indicator for executive cost intervention decisions."
    - name: "schedule_trend_indicator"
      expr: schedule_trend_indicator
      comment: "Direction of schedule trend — used alongside cost trend to assess overall project health trajectory."
    - name: "is_client_reported"
      expr: is_client_reported
      comment: "Indicates whether this forecast was submitted to the client — separates internal and external reporting views."
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_date)
      comment: "Reporting month of the forecast — primary time dimension for period-over-period forecast trend analysis."
  measures:
    - name: "total_eac_cost"
      expr: SUM(CAST(eac_cost AS DOUBLE))
      comment: "Total Estimate at Completion cost across all forecasts — the definitive projected final cost for executive financial reporting."
    - name: "total_bac_cost"
      expr: SUM(CAST(bac_cost AS DOUBLE))
      comment: "Total Budget at Completion — the authorised baseline budget against which EAC is compared to determine overrun or underrun."
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual cost incurred to date across all forecast records — measures cumulative spend for cash flow and budget consumption tracking."
    - name: "total_etc_cost"
      expr: SUM(CAST(etc_cost AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost to finish all work; primary input to cash flow forecasting and resource planning."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (BAC minus EAC) — negative values indicate projected overrun; triggers executive corrective action."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion — the projected final over/underrun against the authorised budget; key board-level financial KPI."
    - name: "total_eac_movement"
      expr: SUM(CAST(eac_movement AS DOUBLE))
      comment: "Total EAC movement from prior period — measures forecast volatility; large movements trigger governance review and client notification."
    - name: "total_contingency_remaining"
      expr: SUM(CAST(contingency_remaining AS DOUBLE))
      comment: "Total contingency remaining across projects — tracks risk reserve adequacy; depletion signals elevated financial risk."
    - name: "total_management_reserve_remaining"
      expr: SUM(CAST(management_reserve_remaining AS DOUBLE))
      comment: "Total management reserve remaining — the last line of financial defence before overrun; monitored at board level."
    - name: "total_risk_provision"
      expr: SUM(CAST(risk_provision_amount AS DOUBLE))
      comment: "Total risk provision included in forecasts — quantifies the financial allowance for identified risks in the project portfolio."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index from forecast records — portfolio efficiency indicator for executive steering meetings."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average forecast percent complete — overall portfolio progress indicator aligned to financial completion milestones."
    - name: "eac_overrun_rate"
      expr: ROUND(SUM(CAST(eac_cost AS DOUBLE)) / NULLIF(SUM(CAST(bac_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of EAC to BAC — values above 1.0 indicate projected cost overrun; the primary financial health ratio for project portfolio governance."
    - name: "contingency_consumption_rate"
      expr: ROUND(1.0 - (SUM(CAST(contingency_remaining AS DOUBLE)) / NULLIF(SUM(CAST(risk_provision_amount AS DOUBLE)), 0)), 4)
      comment: "Proportion of risk provision consumed — high values indicate risk reserves are nearly exhausted, triggering contingency replenishment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone delivery KPIs — tracks contractual milestone achievement, schedule variance, payment trigger status, and LD exposure to govern project delivery commitments."
  source: "`vibe_construction_v1`.`project`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Achieved, Overdue, At Risk) — primary filter for delivery health dashboards."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. Contractual, Internal, Payment) — segments milestones by commercial and operational significance."
    - name: "category"
      expr: category
      comment: "Category of the milestone (e.g. Design, Procurement, Construction, Handover) — enables phase-aligned delivery tracking."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Indicates whether the milestone is a contractual obligation — contractual milestones carry LD and payment implications."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the milestone is on the critical path — critical path milestones directly determine project completion date."
    - name: "is_payment_trigger"
      expr: is_payment_trigger
      comment: "Indicates whether milestone achievement triggers a client payment — directly linked to revenue recognition and cash flow."
    - name: "is_ld_trigger"
      expr: is_ld_trigger
      comment: "Indicates whether missing this milestone triggers liquidated damages — quantifies financial penalty exposure from delays."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model under which the milestone is tracked — enables benchmarking of milestone performance across contract types."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for achieving the milestone — enables accountability tracking and escalation routing."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Planned achievement month — primary time dimension for milestone schedule analysis and look-ahead reporting."
  measures:
    - name: "total_milestone_count"
      expr: COUNT(DISTINCT milestone_id)
      comment: "Total number of milestones in the portfolio — baseline volume KPI for delivery governance and PMO workload tracking."
    - name: "contractual_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_contractual = TRUE THEN milestone_id END)
      comment: "Number of contractual milestones — quantifies the volume of legally binding delivery commitments across the portfolio."
    - name: "payment_trigger_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_payment_trigger = TRUE THEN milestone_id END)
      comment: "Number of milestones that trigger client payments — directly linked to revenue recognition and cash flow forecasting."
    - name: "ld_trigger_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_ld_trigger = TRUE THEN milestone_id END)
      comment: "Number of milestones that trigger liquidated damages if missed — quantifies LD exposure events for contract risk management."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment value linked to milestone achievement — maps delivery schedule to revenue recognition and cash inflow forecasting."
    - name: "total_ld_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Total daily LD rate across all LD-trigger milestones — quantifies maximum daily financial penalty exposure from schedule delays."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones — portfolio-level progress indicator for executive delivery dashboards."
    - name: "critical_path_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_path = TRUE THEN milestone_id END)
      comment: "Number of milestones on the critical path — the subset of milestones that directly determine project completion date."
    - name: "payment_milestone_value_at_risk"
      expr: SUM(CASE WHEN is_payment_trigger = TRUE AND is_ld_trigger = TRUE THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total payment value on milestones that are both payment triggers and LD triggers — quantifies the highest-risk commercial milestones requiring priority management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk KPIs — tracks risk exposure, probability-weighted cost impact, mitigation coverage, and escalation status to support proactive risk governance."
  source: "`vibe_construction_v1`.`project`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Mitigated, Closed, Escalated) — primary filter for active risk portfolio management."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk (e.g. Commercial, Technical, HSE, Regulatory) — enables risk portfolio analysis by type for targeted mitigation."
    - name: "risk_type"
      expr: risk_type
      comment: "Sub-type of the risk — provides finer-grained classification for risk trend analysis."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Qualitative probability rating (e.g. Low, Medium, High) — used for risk matrix visualisation and prioritisation."
    - name: "cost_impact_rating"
      expr: cost_impact_rating
      comment: "Qualitative cost impact rating — combined with probability to determine risk priority for management attention."
    - name: "schedule_impact_rating"
      expr: schedule_impact_rating
      comment: "Qualitative schedule impact rating — identifies risks with potential to delay project completion."
    - name: "mitigation_response_type"
      expr: mitigation_response_type
      comment: "Type of mitigation response (e.g. Avoid, Transfer, Mitigate, Accept) — tracks risk response strategy distribution."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the risk has been escalated to senior management — flags risks requiring executive attention."
    - name: "hse_risk_flag"
      expr: hse_risk_flag
      comment: "Indicates whether the risk has an HSE dimension — critical for safety governance and regulatory compliance reporting."
    - name: "regulatory_risk_flag"
      expr: regulatory_risk_flag
      comment: "Indicates whether the risk has a regulatory dimension — flags risks with potential compliance and legal consequences."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the risk cost impact — required for multi-currency risk exposure consolidation."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was identified — enables trend analysis of risk emergence rate over the project lifecycle."
  measures:
    - name: "total_open_risk_count"
      expr: COUNT(DISTINCT risk_register_id)
      comment: "Total number of risks in the register — headline risk portfolio volume KPI for governance dashboards."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total gross cost impact of all risks — maximum financial exposure if all risks materialise; key input to contingency sizing."
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Total contingency cost allocated to risks — measures the financial provision made against identified risk exposure."
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across the register — aggregate risk exposure index for portfolio-level risk heat mapping."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score — portfolio risk severity indicator; rising averages signal deteriorating risk environment requiring management intervention."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation — measures the effectiveness of risk mitigation actions across the portfolio."
    - name: "escalated_risk_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN risk_register_id END)
      comment: "Number of escalated risks — quantifies the volume of risks requiring senior management attention and decision."
    - name: "hse_risk_count"
      expr: COUNT(DISTINCT CASE WHEN hse_risk_flag = TRUE THEN risk_register_id END)
      comment: "Number of risks with an HSE dimension — critical safety governance KPI for regulatory compliance and incident prevention."
    - name: "regulatory_risk_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_risk_flag = TRUE THEN risk_register_id END)
      comment: "Number of risks with regulatory implications — tracks compliance exposure for legal and governance reporting."
    - name: "probability_weighted_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE) * CAST(probability_score AS DOUBLE))
      comment: "Probability-weighted cost impact (EMV) — the statistically expected financial loss from the risk portfolio; the most rigorous risk exposure KPI for contingency planning."
    - name: "mitigation_effectiveness_rate"
      expr: ROUND(1.0 - (AVG(CAST(residual_risk_score AS DOUBLE)) / NULLIF(AVG(CAST(risk_score AS DOUBLE)), 0)), 4)
      comment: "Proportion of risk score eliminated by mitigation actions — measures the overall effectiveness of the risk response programme; low values indicate mitigation plans need strengthening."
    - name: "contingency_coverage_rate"
      expr: ROUND(SUM(CAST(contingency_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_impact_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of contingency provision to gross cost impact — measures how well the contingency budget covers identified risk exposure; below target triggers contingency replenishment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_progress_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical progress and earned value KPIs at the measurement record level — tracks installed quantities, earned value, schedule and cost performance to govern construction productivity."
  source: "`vibe_construction_v1`.`project`.`progress_measurement`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the progress measurement record (e.g. Submitted, Verified, Approved) — filters for authorised measurements in official reporting."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g. Physical, Financial, Milestone) — determines how progress is quantified and earned value is calculated."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. Weighted Steps, Milestone, Units Complete) — affects comparability of progress across work packages."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or construction discipline (e.g. Civil, Structural, Electrical) — enables productivity benchmarking by trade."
    - name: "work_area"
      expr: work_area
      comment: "Physical work area or zone on site — enables spatial analysis of construction progress and resource deployment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the measurement financial values — required for multi-currency portfolio consolidation."
    - name: "is_billing_eligible"
      expr: is_billing_eligible
      comment: "Indicates whether the measurement is eligible for client billing — links physical progress to revenue recognition."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source system or method of the measurement (e.g. Procore, Manual, Survey) — used to assess data quality and reliability."
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for installed quantities — required for productivity rate calculations and unit-cost benchmarking."
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Reporting period month — primary time dimension for period-over-period progress trend analysis."
  measures:
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value from progress measurements — the budgeted value of physically completed work; core EVM KPI."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) from progress measurements — the baseline against which schedule performance is measured."
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity physically installed to date — primary productivity output KPI for construction operations management."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the current reporting period — measures period productivity for crew performance and schedule recovery assessment."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity across all work packages — baseline for quantity productivity and unit-rate variance analysis."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total budget at completion from progress records — the authorised budget for all measured work packages."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance from progress measurements — negative values indicate cost overrun on measured work packages."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance from progress measurements — negative values indicate schedule slippage on measured work packages."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across all measurement records — overall construction progress indicator for executive dashboards."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index from progress measurements — below 1.0 signals cost inefficiency in construction execution."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index from progress measurements — below 1.0 indicates construction is behind planned schedule."
    - name: "quantity_productivity_rate"
      expr: ROUND(SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of installed to budgeted quantity — measures construction productivity efficiency; below 1.0 indicates quantity underperformance requiring crew or method review."
    - name: "earned_value_schedule_efficiency"
      expr: ROUND(SUM(CAST(earned_value AS DOUBLE)) / NULLIF(SUM(CAST(planned_value AS DOUBLE)), 0), 4)
      comment: "Ratio of earned value to planned value — equivalent to SPI at the measurement level; directly measures whether construction is delivering value on schedule."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project baseline governance KPIs — tracks baseline revisions, budget changes, schedule extensions, and variance at completion to govern scope and cost baseline integrity."
  source: "`vibe_construction_v1`.`project`.`project_baseline`"
  dimensions:
    - name: "baseline_status"
      expr: baseline_status
      comment: "Status of the baseline (e.g. Active, Superseded, Draft) — filters for the current approved baseline in performance reporting."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (e.g. Original, Revised, Client-Approved) — distinguishes original contract baseline from approved revisions."
    - name: "approval_level"
      expr: approval_level
      comment: "Level at which the baseline was approved (e.g. PMO, Board, Client) — indicates governance authority and baseline credibility."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model associated with the baseline — enables benchmarking of baseline stability across contract types."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the baseline financial values — required for multi-currency portfolio consolidation."
    - name: "is_current_baseline"
      expr: is_current_baseline
      comment: "Indicates whether this is the currently active baseline — primary filter to isolate the governing baseline for performance measurement."
    - name: "is_client_approved"
      expr: is_client_approved
      comment: "Indicates whether the baseline has been approved by the client — client-approved baselines are contractually binding."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the baseline became effective — used to track baseline revision frequency over the project lifecycle."
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion across baselines — the authorised total project budget; primary financial baseline KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value captured in baselines — the revenue baseline against which cost performance is measured."
    - name: "total_co_value_incorporated"
      expr: SUM(CAST(co_value_incorporated AS DOUBLE))
      comment: "Total change order value incorporated into baselines — measures cumulative scope growth absorbed into the authorised baseline."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget in baselines — tracks the risk reserve included in the authorised project budget."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve in baselines — the discretionary budget held above contingency for unforeseen events."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion across baselines — negative values indicate projected overrun against the authorised baseline."
    - name: "budget_revision_growth_rate"
      expr: ROUND((SUM(CAST(budget_after_revision AS DOUBLE)) - SUM(CAST(budget_before_revision AS DOUBLE))) / NULLIF(SUM(CAST(budget_before_revision AS DOUBLE)), 0), 4)
      comment: "Percentage growth in budget from pre- to post-revision — measures the magnitude of baseline budget changes; high values indicate scope instability."
    - name: "co_incorporation_rate"
      expr: ROUND(SUM(CAST(co_value_incorporated AS DOUBLE)) / NULLIF(SUM(CAST(budget_at_completion AS DOUBLE)), 0), 4)
      comment: "Ratio of change order value to total budget at completion — measures the proportion of the budget attributable to scope changes; high values signal poor scope definition at project outset."
    - name: "baseline_revision_count"
      expr: COUNT(DISTINCT project_baseline_id)
      comment: "Total number of baseline records — proxy for baseline revision frequency; high counts indicate scope instability and governance concerns."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Breakdown Structure (WBS) element KPIs — tracks budget consumption, earned value, quantity productivity, and cost variance at the WBS level to govern scope execution."
  source: "`vibe_construction_v1`.`project`.`wbs_element`"
  dimensions:
    - name: "wbs_status"
      expr: wbs_status
      comment: "Current status of the WBS element (e.g. Active, Completed, On Hold) — primary filter for active scope tracking."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS element (e.g. Summary, Work Package, Control Account) — determines the level of cost and schedule control applied."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level of the WBS element — enables drill-down analysis from project summary to work package level."
    - name: "charge_type"
      expr: charge_type
      comment: "Charge type for the WBS element (e.g. Direct, Indirect, Overhead) — used for cost allocation and margin analysis."
    - name: "responsible_discipline"
      expr: responsible_discipline
      comment: "Engineering or construction discipline responsible for the WBS element — enables discipline-level productivity and cost analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model associated with the WBS element — enables benchmarking across contract types."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the WBS element financial values — required for multi-currency portfolio consolidation."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates whether the WBS element is priced as a lump sum — affects how cost variance and progress are interpreted."
    - name: "evm_enabled"
      expr: evm_enabled
      comment: "Indicates whether EVM is applied to this WBS element — filters for EVM-controlled scope in performance reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities — required for productivity rate and unit-cost benchmarking."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Planned start month of the WBS element — enables schedule-aligned analysis of scope execution timing."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across WBS elements — the authorised cost baseline for all scope items."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS elements — primary cost consumption KPI for scope-level financial control."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across WBS elements — the budgeted value of physically completed scope; core EVM KPI."
    - name: "total_original_budget_cost"
      expr: SUM(CAST(original_budget_cost AS DOUBLE))
      comment: "Total original budget cost before any approved changes — baseline for measuring scope growth and budget revision impact."
    - name: "total_approved_budget_changes"
      expr: SUM(CAST(approved_budget_changes AS DOUBLE))
      comment: "Total approved budget changes (change orders) absorbed into WBS elements — measures cumulative scope growth at the work package level."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) across WBS elements — the time-phased budget baseline for schedule performance measurement."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity installed across WBS elements — measures physical output for productivity and unit-rate analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across WBS elements — baseline for quantity productivity analysis."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across WBS elements — overall scope completion indicator for executive dashboards."
    - name: "budget_consumption_rate"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of actual cost to budgeted cost at WBS level — values above 1.0 indicate budget overrun on individual work packages; drives targeted corrective action."
    - name: "scope_growth_rate"
      expr: ROUND(SUM(CAST(approved_budget_changes AS DOUBLE)) / NULLIF(SUM(CAST(original_budget_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of approved budget changes to original budget — measures the magnitude of scope growth from the original contract; high values indicate poor scope definition or client-driven changes."
    - name: "quantity_productivity_rate"
      expr: ROUND(SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to planned quantity — measures construction productivity at the WBS level; below 1.0 indicates quantity underperformance requiring crew or method review."
$$;