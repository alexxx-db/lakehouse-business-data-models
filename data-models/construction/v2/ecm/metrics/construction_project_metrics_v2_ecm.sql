-- Metric views for domain: project | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive portfolio-level KPIs for active construction projects: budget health, schedule performance, contract value, and physical progress. Used in portfolio reviews, board decks, and PMO steering dashboards."
  source: "`vibe_construction_v1`.`project`.`construction_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, Closed, On Hold) — primary filter for portfolio views."
    - name: "project_type"
      expr: project_type
      comment: "Classification of project type (e.g. Civil, MEP, Infrastructure) for portfolio segmentation."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (e.g. EPC, Design-Build, CM) — drives risk and performance benchmarking."
    - name: "region"
      expr: region
      comment: "Geographic region of the project for regional performance comparison."
    - name: "country_code"
      expr: country_code
      comment: "Country where the project is located for regulatory and currency segmentation."
    - name: "pmo_classification"
      expr: pmo_classification
      comment: "PMO tier or classification (e.g. Major, Standard, Minor) for governance-level filtering."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk rating of the project — used to prioritise safety oversight resources."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the project is a joint venture — affects governance and reporting obligations."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level for sustainability portfolio reporting."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned project start date for pipeline and backlog analysis."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month bucket of planned completion date for delivery schedule tracking."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of projects in the portfolio. Baseline headcount for all portfolio KPIs."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Sum of all contract values across the portfolio. Primary revenue backlog indicator for executive reporting."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Sum of approved budgets across all projects. Used to assess total capital commitment and budget adequacy."
    - name: "avg_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across active projects. Key schedule health indicator for portfolio steering."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across projects. CPI < 1.0 signals cost overrun risk requiring executive intervention."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across projects. SPI < 1.0 signals schedule slippage requiring corrective action."
    - name: "total_retention_exposure"
      expr: SUM(CAST(retention_pct AS DOUBLE) * contract_value / 100.0)
      comment: "Estimated total retention amount held across the portfolio (retention_pct × contract_value). Cash flow risk indicator for finance leadership."
    - name: "avg_jv_partner_share_pct"
      expr: AVG(CASE WHEN is_joint_venture = TRUE THEN jv_partner_share_pct ELSE NULL END)
      comment: "Average JV partner equity share percentage on joint venture projects. Used to assess risk exposure and profit attribution in JV structures."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average daily liquidated damages rate across projects. Indicates contractual penalty exposure if schedule slips."
    - name: "projects_at_schedule_risk"
      expr: COUNT(CASE WHEN spi < 1.0 THEN 1 END)
      comment: "Count of projects with SPI below 1.0 (behind schedule). Triggers executive escalation and resource reallocation decisions."
    - name: "projects_at_cost_risk"
      expr: COUNT(CASE WHEN cpi < 1.0 THEN 1 END)
      comment: "Count of projects with CPI below 1.0 (over budget). Drives cost recovery actions and contingency drawdown decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_evm_period_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) period-level KPIs for project cost and schedule performance. Used in monthly project reviews, PMO dashboards, and client reporting to assess budget health and forecast accuracy."
  source: "`vibe_construction_v1`.`project`.`evm_period_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for filtering EVM metrics to a specific project."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for drill-down EVM analysis at work package level."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Reporting period month bucket for time-series EVM trend analysis."
    - name: "measurement_level"
      expr: measurement_level
      comment: "Level at which EVM is measured (e.g. Project, Phase, WBS) for hierarchical drill-down."
    - name: "forecast_method"
      expr: forecast_method
      comment: "EAC forecast method used (e.g. CPI-based, ETC-based) — affects forecast reliability assessment."
    - name: "record_status"
      expr: record_status
      comment: "Status of the EVM record (e.g. Approved, Draft) for data quality filtering."
    - name: "cpi_trend"
      expr: cpi_trend
      comment: "CPI trend direction (Improving/Declining/Stable) for executive narrative reporting."
    - name: "spi_trend"
      expr: spi_trend
      comment: "SPI trend direction for schedule performance narrative."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of EVM values for multi-currency portfolio consolidation."
    - name: "data_date"
      expr: DATE_TRUNC('month', data_date)
      comment: "Data date month bucket — the as-of date for EVM snapshot analysis."
  measures:
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value). Core EVM measure of value delivered against plan."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value). Baseline against which schedule performance is measured."
    - name: "total_acwp"
      expr: SUM(CAST(acwp AS DOUBLE))
      comment: "Total Actual Cost of Work Performed. Compared to BCWP to determine cost variance and CPI."
    - name: "total_eac"
      expr: SUM(CAST(eac AS DOUBLE))
      comment: "Total Estimate at Completion across all WBS elements. Primary forecast of final project cost for executive decision-making."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total approved budget at completion (BAC). Denominator for variance at completion calculations."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (BCWP - ACWP) across the portfolio. Negative values indicate cost overrun requiring management action."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance (BCWP - BCWS) across the portfolio. Negative values indicate schedule slippage."
    - name: "total_etc"
      expr: SUM(CAST(etc AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost forecast. Used for cash flow planning and budget adequacy assessment."
    - name: "total_vac"
      expr: SUM(CAST(vac AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC). Negative VAC signals projected cost overrun at project end."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across EVM records. CPI < 1.0 triggers cost recovery escalation."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across EVM records. SPI < 1.0 triggers schedule recovery planning."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index. TCPI > 1.2 indicates the remaining work efficiency target is unrealistic — signals need for re-baseline."
    - name: "avg_physical_percent_complete"
      expr: AVG(CAST(physical_percent_complete AS DOUBLE))
      comment: "Average physical percent complete across EVM records. Compared to schedule percent complete to detect productivity gaps."
    - name: "period_bcwp"
      expr: SUM(CAST(period_bcwp AS DOUBLE))
      comment: "Total earned value in the current period only. Used for period-over-period productivity trend analysis."
    - name: "period_acwp"
      expr: SUM(CAST(period_acwp AS DOUBLE))
      comment: "Total actual cost in the current period only. Compared to period BCWP for in-period cost efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost account-level budget control KPIs for project cost management. Used by project controls teams and finance to monitor budget consumption, cost variance, and forecast accuracy at the work package level."
  source: "`vibe_construction_v1`.`project`.`cost_account`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level cost account aggregation."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for hierarchical cost drill-down."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g. Labour, Material, Equipment, Subcontract) for cost category analysis."
    - name: "account_status"
      expr: account_status
      comment: "Status of the cost account (e.g. Active, Closed) for filtering live accounts."
    - name: "phase_code"
      expr: phase_code
      comment: "Project phase code for phase-level cost performance analysis."
    - name: "is_subcontract_scope"
      expr: is_subcontract_scope
      comment: "Flag indicating subcontract scope — used to separate self-perform vs subcontracted cost performance."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag for lump sum vs re-measurable accounts — affects cost control methodology."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost account values for multi-currency project reporting."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Reporting period month for time-series cost trend analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across cost accounts. Baseline for all budget variance calculations."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred. Primary cost performance indicator compared against budget."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed cost (purchase orders, subcontracts). Represents financial obligations not yet invoiced."
    - name: "total_cost_to_complete"
      expr: SUM(CAST(cost_to_complete_amount AS DOUBLE))
      comment: "Total estimated cost to complete remaining work. Used for EAC and cash flow forecasting."
    - name: "total_forecast_cost_at_completion"
      expr: SUM(CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Total forecast cost at completion (EAC). Key executive metric for final cost projection."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (budget minus actual). Negative values indicate overrun requiring corrective action."
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order value incorporated into cost accounts. Tracks scope growth impact on budget."
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget remaining. Declining contingency signals increasing project risk exposure."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value_amount AS DOUBLE))
      comment: "Total earned value across cost accounts. Used to compute portfolio-level CPI."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across cost accounts. CPI < 1.0 triggers cost recovery escalation."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across cost accounts. Drives schedule recovery decisions."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across cost accounts. Compared to budget consumption to detect productivity gaps."
    - name: "budget_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed by actual costs. Exceeding 100% signals budget overrun requiring executive action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project cost forecast KPIs tracking EAC movement, variance at completion, and forecast accuracy. Used in monthly project reviews and client reporting to assess financial trajectory and management reserve adequacy."
  source: "`vibe_construction_v1`.`project`.`forecast`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level forecast aggregation."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for drill-down forecast analysis."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g. Approved, Draft, Submitted) for filtering authoritative forecasts."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. Monthly, Quarterly, Final) for period-type segmentation."
    - name: "cost_trend_indicator"
      expr: cost_trend_indicator
      comment: "Cost trend direction (Improving/Declining/Stable) for executive narrative."
    - name: "schedule_trend_indicator"
      expr: schedule_trend_indicator
      comment: "Schedule trend direction for executive narrative."
    - name: "is_client_reported"
      expr: is_client_reported
      comment: "Flag indicating whether this forecast is reported to the client — used to separate internal vs client-facing forecasts."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of forecast values for multi-currency consolidation."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Reporting period month for time-series forecast trend analysis."
  measures:
    - name: "total_eac_cost"
      expr: SUM(CAST(eac_cost AS DOUBLE))
      comment: "Total Estimate at Completion cost across all forecast records. Primary financial forecast metric for executive decision-making."
    - name: "total_bac_cost"
      expr: SUM(CAST(bac_cost AS DOUBLE))
      comment: "Total Budget at Completion. Baseline against which EAC is compared to determine overrun/underrun."
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual cost incurred to date across forecast records. Tracks cash out against plan."
    - name: "total_etc_cost"
      expr: SUM(CAST(etc_cost AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost to finish the project. Used for cash flow planning."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC). Negative values indicate projected overrun — triggers executive intervention."
    - name: "total_eac_movement"
      expr: SUM(CAST(eac_movement AS DOUBLE))
      comment: "Total EAC movement from prior period. Tracks forecast volatility — large movements signal instability in cost control."
    - name: "total_contingency_remaining"
      expr: SUM(CAST(contingency_remaining AS DOUBLE))
      comment: "Total contingency budget remaining across projects. Declining contingency signals increasing risk exposure."
    - name: "total_management_reserve_remaining"
      expr: SUM(CAST(management_reserve_remaining AS DOUBLE))
      comment: "Total management reserve remaining. Used by senior leadership to assess buffer adequacy against residual risks."
    - name: "total_risk_provision_amount"
      expr: SUM(CAST(risk_provision_amount AS DOUBLE))
      comment: "Total risk provision included in forecasts. Indicates quantified risk exposure carried in the financial plan."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across forecast records. CPI < 1.0 signals cost overrun trajectory."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across forecast records. SPI < 1.0 signals schedule slippage trajectory."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index. TCPI > 1.2 indicates unrealistic remaining efficiency target — signals re-baseline need."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across forecast records. Compared to cost consumption to detect productivity gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone performance KPIs tracking contractual commitments, schedule adherence, and liquidated damages exposure. Used in client reporting, contract management, and executive schedule reviews."
  source: "`vibe_construction_v1`.`project`.`project_milestone`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level milestone tracking."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Achieved, At Risk, Delayed) — primary filter for milestone health dashboards."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. Contractual, Internal, Payment) for category-level analysis."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Business category of the milestone for portfolio-level grouping."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Flag for contractual milestones — these carry LD exposure and require priority tracking."
    - name: "is_ld_trigger"
      expr: is_ld_trigger
      comment: "Flag indicating whether missing this milestone triggers liquidated damages — highest priority for executive attention."
    - name: "is_payment_trigger"
      expr: is_payment_trigger
      comment: "Flag indicating whether milestone achievement triggers a payment certificate — cash flow critical."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag for critical path milestones — delays here directly impact project completion date."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for benchmarking milestone performance across delivery approaches."
    - name: "planned_date"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned milestone date month bucket for schedule pipeline analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of milestones. Baseline for milestone completion rate calculations."
    - name: "achieved_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Achieved' THEN 1 END)
      comment: "Count of milestones with Achieved status. Numerator for milestone completion rate."
    - name: "milestone_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieved. Key schedule adherence KPI for client and executive reporting."
    - name: "contractual_milestones_at_risk"
      expr: COUNT(CASE WHEN is_contractual = TRUE AND milestone_status NOT IN ('Achieved') THEN 1 END)
      comment: "Count of contractual milestones not yet achieved. Directly indicates LD exposure and contract compliance risk."
    - name: "ld_trigger_milestones_overdue"
      expr: COUNT(CASE WHEN is_ld_trigger = TRUE AND milestone_status NOT IN ('Achieved') AND planned_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of LD-trigger milestones past their planned date and not achieved. Quantifies active liquidated damages exposure."
    - name: "total_ld_exposure_amount"
      expr: SUM(CASE WHEN is_ld_trigger = TRUE AND milestone_status NOT IN ('Achieved') THEN ld_rate_per_day ELSE 0 END)
      comment: "Sum of daily LD rates for all unachieved LD-trigger milestones. Indicates daily financial penalty accrual rate."
    - name: "total_payment_trigger_amount"
      expr: SUM(CASE WHEN is_payment_trigger = TRUE THEN payment_amount ELSE 0 END)
      comment: "Total payment amount tied to payment-trigger milestones. Tracks milestone-linked revenue recognition potential."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones. Indicates overall milestone progress maturity."
    - name: "payment_milestones_achieved"
      expr: COUNT(CASE WHEN is_payment_trigger = TRUE AND milestone_status = 'Achieved' THEN 1 END)
      comment: "Count of payment-trigger milestones achieved. Directly drives revenue recognition and cash collection."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk register KPIs for quantified risk exposure, mitigation effectiveness, and escalation tracking. Used in risk reviews, board reporting, and insurance/contingency adequacy assessments."
  source: "`vibe_construction_v1`.`project`.`risk_register`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level risk aggregation."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Closed, Mitigated) — primary filter for active risk dashboards."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (e.g. Commercial, Technical, HSE, Regulatory) for category-level risk analysis."
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk for sub-category drill-down."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Qualitative probability rating (e.g. High/Medium/Low) for risk heat map analysis."
    - name: "cost_impact_rating"
      expr: cost_impact_rating
      comment: "Qualitative cost impact rating for risk prioritisation."
    - name: "schedule_impact_rating"
      expr: schedule_impact_rating
      comment: "Qualitative schedule impact rating for schedule risk prioritisation."
    - name: "mitigation_response_type"
      expr: mitigation_response_type
      comment: "Risk response strategy (e.g. Mitigate, Transfer, Accept) for response effectiveness analysis."
    - name: "hse_risk_flag"
      expr: hse_risk_flag
      comment: "Flag for HSE-related risks — these require mandatory escalation and safety review."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag for risks escalated to senior management — used to track escalation volume and resolution."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the risk was identified for trend analysis of risk emergence rate."
  measures:
    - name: "total_open_risks"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Total count of open risks. Baseline for risk portfolio size and trend monitoring."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total quantified cost impact of all risks. Gross risk exposure used for contingency adequacy assessment."
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Total contingency allocated to risks. Compared to cost impact to assess contingency coverage ratio."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score (probability × impact) across open risks. Tracks overall risk profile severity over time."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation. Compared to pre-mitigation score to measure mitigation effectiveness."
    - name: "high_probability_risks"
      expr: COUNT(CASE WHEN probability_rating = 'High' THEN 1 END)
      comment: "Count of high-probability risks. Drives prioritisation of mitigation resources and management attention."
    - name: "escalated_risks"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of risks escalated to senior management. Tracks escalation volume as a governance health indicator."
    - name: "hse_risks_open"
      expr: COUNT(CASE WHEN hse_risk_flag = TRUE AND risk_status = 'Open' THEN 1 END)
      comment: "Count of open HSE risks. Mandatory safety governance metric — any increase triggers immediate HSE review."
    - name: "risk_mitigation_effectiveness"
      expr: ROUND(100.0 * (1 - AVG(CAST(residual_risk_score AS DOUBLE)) / NULLIF(AVG(CAST(risk_score AS DOUBLE)), 0)), 2)
      comment: "Percentage reduction in average risk score after mitigation. Measures the effectiveness of risk response strategies."
    - name: "contingency_coverage_ratio"
      expr: ROUND(SUM(CAST(contingency_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_impact_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of contingency allocated to total cost impact. Values below 1.0 indicate under-provisioned contingency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project change order KPIs tracking scope growth, cost impact, and approval cycle performance. Used in contract management reviews, client reporting, and budget control to manage change order risk."
  source: "`vibe_construction_v1`.`project`.`project_change_order`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level change order aggregation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change order (e.g. Approved, Pending, Rejected) — primary filter for pending exposure."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g. Scope, Design, Client-Directed) for root cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the change order — used to identify systemic causes of scope growth."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag for disputed change orders — these carry commercial and legal risk requiring executive attention."
    - name: "is_ld_applicable"
      expr: is_ld_applicable
      comment: "Flag indicating LD applicability — change orders with LD exposure require priority resolution."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for benchmarking change order frequency across delivery approaches."
    - name: "submitted_date"
      expr: DATE_TRUNC('month', submitted_date)
      comment: "Month of change order submission for trend analysis of scope change rate."
  measures:
    - name: "total_change_orders"
      expr: COUNT(1)
      comment: "Total number of change orders. Baseline for change order frequency and approval rate calculations."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. Measures cumulative scope growth and budget pressure."
    - name: "total_approved_cost_impact"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost impact of approved change orders only. Represents confirmed budget additions."
    - name: "total_pending_cost_impact"
      expr: SUM(CASE WHEN approval_status = 'Pending' THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost impact of pending change orders. Represents unresolved budget exposure requiring management decision."
    - name: "total_disputed_cost_impact"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost impact of disputed change orders. Indicates commercial dispute exposure requiring legal/commercial resolution."
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct cost component of change orders. Used to separate direct vs overhead cost growth."
    - name: "total_overhead_and_profit"
      expr: SUM(CAST(overhead_and_profit_amount AS DOUBLE))
      comment: "Total overhead and profit claimed on change orders. Tracks margin impact of scope changes."
    - name: "total_contingency_drawn"
      expr: SUM(CAST(contingency_drawn_amount AS DOUBLE))
      comment: "Total contingency drawn down through change orders. Tracks contingency depletion rate."
    - name: "change_order_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change orders approved. Low approval rates indicate commercial disputes or scope disagreements."
    - name: "avg_cost_impact_per_co"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Tracks whether scope changes are becoming larger or more frequent."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_commissioning_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commissioning package completion and punch list KPIs for project handover readiness. Used in handover reviews, client acceptance meetings, and DLP management to track completion status and outstanding defects."
  source: "`vibe_construction_v1`.`project`.`commissioning_package`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level commissioning aggregation."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the commissioning package (e.g. In Progress, Complete, Handed Over) — primary filter for handover dashboards."
    - name: "package_type"
      expr: package_type
      comment: "Type of commissioning package (e.g. Mechanical, Electrical, Civil) for discipline-level tracking."
    - name: "fat_status"
      expr: fat_status
      comment: "Factory Acceptance Test status — prerequisite for site commissioning."
    - name: "sat_status"
      expr: sat_status
      comment: "Site Acceptance Test status — prerequisite for handover certificate issuance."
    - name: "operational_readiness_verified"
      expr: operational_readiness_verified
      comment: "Flag indicating operational readiness has been verified — required for client handover."
    - name: "pre_commissioning_complete"
      expr: pre_commissioning_complete
      comment: "Flag indicating pre-commissioning activities are complete — gates progression to commissioning."
    - name: "area_location"
      expr: area_location
      comment: "Physical area or location of the commissioning package for site-area level tracking."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Planned completion month for commissioning schedule pipeline analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of commissioning packages. Baseline for completion rate calculations."
    - name: "packages_handed_over"
      expr: COUNT(CASE WHEN package_status = 'Handed Over' THEN 1 END)
      comment: "Count of packages successfully handed over to client. Primary handover progress KPI."
    - name: "handover_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN package_status = 'Handed Over' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commissioning packages handed over. Key project completion KPI for client and executive reporting."
    - name: "avg_punch_list_closure_pct"
      expr: AVG(CAST(punch_list_closure_pct AS DOUBLE))
      comment: "Average punch list closure percentage across packages. Tracks defect resolution progress — must reach 100% for final handover."
    - name: "packages_with_open_cat_a"
      expr: COUNT(CASE WHEN operational_readiness_verified = FALSE THEN 1 END)
      comment: "Count of packages where operational readiness is not yet verified. Indicates packages blocking final handover."
    - name: "packages_overdue"
      expr: COUNT(CASE WHEN planned_completion_date < CURRENT_DATE() AND package_status NOT IN ('Handed Over', 'Complete') THEN 1 END)
      comment: "Count of commissioning packages past planned completion date and not yet complete. Drives schedule recovery actions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_budget_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget revision KPIs tracking budget changes, scope growth, and revision approval patterns. Used in budget governance reviews and finance reporting to monitor budget stability and change control effectiveness."
  source: "`vibe_construction_v1`.`project`.`project_budget_revision`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level budget revision aggregation."
    - name: "revision_status"
      expr: revision_status
      comment: "Status of the budget revision (e.g. Approved, Pending, Rejected) — primary filter for pending exposure."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of budget revision (e.g. Scope Change, Contingency Draw, Reallocation) for root cause analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category being revised for category-level budget movement analysis."
    - name: "client_approved_flag"
      expr: client_approved_flag
      comment: "Flag indicating client approval — client-approved revisions affect contract value and billing."
    - name: "evm_baseline_flag"
      expr: evm_baseline_flag
      comment: "Flag indicating whether this revision updates the EVM baseline — affects performance measurement."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for benchmarking revision frequency across delivery approaches."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the revision became effective for time-series budget movement analysis."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of budget revisions. High revision frequency signals poor initial scope definition or change control weakness."
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Total net budget revision amount. Measures cumulative budget growth or reduction across the project."
    - name: "total_budget_after_revision"
      expr: SUM(CAST(budget_after_revision AS DOUBLE))
      comment: "Total budget after all revisions. Current authorised budget baseline for cost control."
    - name: "total_budget_before_revision"
      expr: SUM(CAST(budget_before_revision AS DOUBLE))
      comment: "Total budget before revisions. Used to calculate net budget movement."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency included in budget revisions. Tracks contingency adequacy across revision cycles."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve included in budget revisions. Tracks senior leadership buffer adequacy."
    - name: "total_contract_budget_impact"
      expr: SUM(CAST(contract_budget_impact AS DOUBLE))
      comment: "Total contract budget impact of revisions. Measures how much of the budget change flows through to contract value."
    - name: "approved_revision_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN revision_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of budget revisions approved. Low approval rates indicate governance bottlenecks or poor justification quality."
    - name: "avg_revision_amount"
      expr: AVG(CAST(revision_amount AS DOUBLE))
      comment: "Average budget revision amount. Tracks whether individual revisions are growing in size — a signal of scope control deterioration."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_progress_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical progress measurement KPIs for earned value and billing eligibility tracking. Used in monthly progress reviews, payment application preparation, and schedule performance reporting."
  source: "`vibe_construction_v1`.`project`.`progress_measurement`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level progress aggregation."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element for drill-down progress analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g. Verified, Pending, Rejected) — filter for authoritative progress data."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g. Physical, Milestone, Weighted Steps) for methodology analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering/construction discipline for discipline-level progress tracking."
    - name: "is_billing_eligible"
      expr: is_billing_eligible
      comment: "Flag indicating whether the measured progress is eligible for billing — drives payment application preparation."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag for milestone-based measurements — these trigger payment and contractual obligations."
    - name: "measurement_date"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of measurement for time-series progress trend analysis."
  measures:
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value from progress measurements. Core EVM input for project performance reporting."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value for the measurement period. Baseline for schedule variance calculation."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total budget at completion across measurement records. Used for EAC and VAC calculations."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance from progress measurements. Negative values indicate cost overrun."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance from progress measurements. Negative values indicate schedule slippage."
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total installed quantity across all measurement records. Physical productivity indicator for construction operations."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total installed quantity in the current period. Tracks period productivity for resource efficiency analysis."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across measurement records. Overall project progress indicator."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index from progress measurements. CPI < 1.0 triggers cost recovery actions."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index from progress measurements. SPI < 1.0 triggers schedule recovery planning."
    - name: "billing_eligible_earned_value"
      expr: SUM(CASE WHEN is_billing_eligible = TRUE THEN earned_value ELSE 0 END)
      comment: "Total earned value eligible for billing. Directly drives payment application amounts and cash collection."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project baseline KPIs tracking budget at completion, variance at completion, and baseline revision history. Used in PMO governance reviews to assess baseline stability and re-baselining frequency."
  source: "`vibe_construction_v1`.`project`.`project_baseline`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level baseline aggregation."
    - name: "baseline_status"
      expr: baseline_status
      comment: "Status of the baseline (e.g. Active, Superseded, Draft) — filter for current authoritative baseline."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (e.g. Original, Revised, Re-baseline) for baseline evolution analysis."
    - name: "is_current_baseline"
      expr: is_current_baseline
      comment: "Flag for the current active baseline — used to filter to the authoritative performance measurement baseline."
    - name: "is_client_approved"
      expr: is_client_approved
      comment: "Flag indicating client approval of the baseline — client-approved baselines govern contractual performance measurement."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for benchmarking baseline performance across delivery approaches."
    - name: "approval_level"
      expr: approval_level
      comment: "Governance level at which the baseline was approved — indicates authority and formality of the baseline."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the baseline became effective for baseline lifecycle analysis."
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total budget at completion across baselines. Tracks authorised project budget across revision cycles."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value incorporated in baselines. Tracks contract value evolution through change orders."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total variance at completion across baselines. Negative values indicate projected overrun against baseline."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency in baselines. Tracks contingency adequacy across baseline revisions."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve in baselines. Senior leadership buffer adequacy indicator."
    - name: "total_co_value_incorporated"
      expr: SUM(CAST(co_value_incorporated AS DOUBLE))
      comment: "Total change order value incorporated into baselines. Measures cumulative scope growth formalised in the baseline."
    - name: "baseline_revision_count"
      expr: COUNT(CASE WHEN baseline_type != 'Original' THEN 1 END)
      comment: "Count of non-original baselines. High re-baselining frequency signals poor initial planning or excessive scope change."
    - name: "avg_budget_after_revision"
      expr: AVG(CAST(budget_after_revision AS DOUBLE))
      comment: "Average budget after revision across baseline records. Tracks typical budget revision magnitude."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_team_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project team resource KPIs tracking staffing levels, man-day utilisation, mobilisation status, and key personnel compliance. Used in resource management reviews and project staffing decisions."
  source: "`vibe_construction_v1`.`project`.`team_member`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level team resource aggregation."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status (e.g. Active, Demobilised, Pending) — primary filter for active headcount."
    - name: "role_category"
      expr: role_category
      comment: "Role category (e.g. Engineering, Management, HSE) for workforce composition analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering/construction discipline for discipline-level staffing analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g. Direct, Seconded, Contractor) for workforce mix analysis."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilisation status (e.g. Mobilised, Pending, Demobilised) for site readiness tracking."
    - name: "is_key_personnel"
      expr: is_key_personnel
      comment: "Flag for key personnel — contractually required roles whose absence triggers client notification obligations."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (e.g. Site, Office, Remote) for location-based resource planning."
    - name: "assignment_start_date"
      expr: DATE_TRUNC('month', assignment_start_date)
      comment: "Month of assignment start for mobilisation pipeline analysis."
  measures:
    - name: "total_team_members"
      expr: COUNT(1)
      comment: "Total number of team member assignments. Baseline headcount for resource planning."
    - name: "active_team_members"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN 1 END)
      comment: "Count of currently active team members. Tracks live project headcount for resource adequacy assessment."
    - name: "total_planned_man_days"
      expr: SUM(CAST(planned_man_days AS DOUBLE))
      comment: "Total planned man-days across all assignments. Baseline for labour resource planning and cost estimation."
    - name: "total_actual_man_days"
      expr: SUM(CAST(actual_man_days AS DOUBLE))
      comment: "Total actual man-days expended. Compared to planned to assess labour productivity and cost performance."
    - name: "man_day_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_man_days AS DOUBLE)) / NULLIF(SUM(CAST(planned_man_days AS DOUBLE)), 0), 2)
      comment: "Percentage of planned man-days actually utilised. Values significantly above 100% indicate labour cost overrun."
    - name: "total_labour_cost"
      expr: SUM(CAST(actual_man_days AS DOUBLE) * CAST(cost_rate_daily AS DOUBLE))
      comment: "Total estimated labour cost (actual man-days × daily rate). Key input for project cost-to-complete calculations."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across team members. Low averages indicate under-utilised resources; high averages indicate overloading."
    - name: "key_personnel_count"
      expr: COUNT(CASE WHEN is_key_personnel = TRUE AND assignment_status = 'Active' THEN 1 END)
      comment: "Count of active key personnel. Contractual compliance metric — gaps trigger client notification obligations."
    - name: "hse_induction_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_induction_status = 'Complete' THEN 1 END) / NULLIF(COUNT(CASE WHEN assignment_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active team members with completed HSE induction. Mandatory safety compliance KPI — below 100% is a reportable gap."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project deliverable submission and acceptance KPIs tracking contractual document delivery performance. Used in document control reviews, client reporting, and contract compliance monitoring."
  source: "`vibe_construction_v1`.`project`.`deliverable`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level deliverable aggregation."
    - name: "deliverable_status"
      expr: deliverable_status
      comment: "Current status of the deliverable (e.g. Issued, Accepted, Overdue) — primary filter for delivery health dashboards."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (e.g. Drawing, Report, Specification) for category-level tracking."
    - name: "deliverable_category"
      expr: deliverable_category
      comment: "Business category of the deliverable for portfolio-level grouping."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the deliverable for discipline-level performance tracking."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Client acceptance status (e.g. Accepted, Rejected, Under Review) — tracks client approval cycle performance."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Flag for contractual deliverables — these carry compliance obligations and potential LD exposure."
    - name: "is_handover_required"
      expr: is_handover_required
      comment: "Flag for deliverables required at handover — gates project completion and final payment."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the deliverable for resource prioritisation."
    - name: "planned_issue_date"
      expr: DATE_TRUNC('month', planned_issue_date)
      comment: "Planned issue month for deliverable pipeline analysis."
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of deliverables. Baseline for completion rate calculations."
    - name: "accepted_deliverables"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END)
      comment: "Count of client-accepted deliverables. Primary delivery performance KPI."
    - name: "deliverable_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables accepted by client. Low rates indicate quality or scope alignment issues."
    - name: "overdue_deliverables"
      expr: COUNT(CASE WHEN planned_issue_date < CURRENT_DATE() AND deliverable_status NOT IN ('Issued', 'Accepted') THEN 1 END)
      comment: "Count of deliverables past planned issue date and not yet issued. Tracks delivery schedule compliance."
    - name: "contractual_deliverables_overdue"
      expr: COUNT(CASE WHEN is_contractual = TRUE AND planned_issue_date < CURRENT_DATE() AND deliverable_status NOT IN ('Issued', 'Accepted') THEN 1 END)
      comment: "Count of contractual deliverables overdue. Indicates contract compliance risk and potential LD exposure."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across deliverables. Overall deliverable progress indicator."
    - name: "avg_weight_factor"
      expr: AVG(CAST(weight_factor AS DOUBLE))
      comment: "Average weight factor of deliverables. Used to assess whether high-weight deliverables are progressing proportionally."
    - name: "handover_deliverables_pending"
      expr: COUNT(CASE WHEN is_handover_required = TRUE AND acceptance_status != 'Accepted' THEN 1 END)
      comment: "Count of handover-required deliverables not yet accepted. Directly gates project completion and final payment release."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project phase performance KPIs tracking budget, schedule, and gate approval status. Used in phase gate reviews and PMO governance to assess readiness to proceed to the next project phase."
  source: "`vibe_construction_v1`.`project`.`phase`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for project-level phase aggregation."
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the phase (e.g. Active, Complete, On Hold) — primary filter for active phase dashboards."
    - name: "phase_type"
      expr: phase_type
      comment: "Type of phase (e.g. Design, Procurement, Construction, Commissioning) for phase-type benchmarking."
    - name: "gate_approval_status"
      expr: gate_approval_status
      comment: "Gate approval status (e.g. Approved, Pending, Rejected) — gates progression to next phase."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag for critical path phases — delays here directly impact project completion date."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Flag indicating HSE plan approval — mandatory before phase commencement."
    - name: "quality_plan_approved"
      expr: quality_plan_approved
      comment: "Flag indicating quality plan approval — mandatory before phase commencement."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for benchmarking phase performance across delivery approaches."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned phase start month for schedule pipeline analysis."
  measures:
    - name: "total_phases"
      expr: COUNT(1)
      comment: "Total number of project phases. Baseline for phase completion rate calculations."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across phases. Baseline for phase-level budget performance."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across phases. Compared to budget to assess phase cost performance."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across phases. Core EVM input for phase-level performance reporting."
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Total contingency budget across phases. Tracks contingency adequacy at phase level."
    - name: "total_ld_exposure"
      expr: SUM(CAST(ld_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across phases. Quantifies financial penalty risk from phase delays."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across phases. Overall project progress indicator at phase level."
    - name: "avg_deliverables_completion_pct"
      expr: AVG(CAST(deliverables_completion_pct AS DOUBLE))
      comment: "Average deliverables completion percentage across phases. Tracks document delivery progress alongside physical progress."
    - name: "phase_budget_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of phase budget consumed by actual costs. Exceeding 100% signals phase cost overrun."
    - name: "phases_pending_gate_approval"
      expr: COUNT(CASE WHEN gate_approval_status = 'Pending' THEN 1 END)
      comment: "Count of phases awaiting gate approval. Governance bottleneck indicator — delays gate approval block project progression."
$$;