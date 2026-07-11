-- Metric views for domain: project | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic project performance metrics tracking budget, schedule, and earned value KPIs for construction projects"
  source: "`vibe_construction_v1`.`project`.`construction_project`"
  dimensions:
    - name: "project_code"
      expr: project_code
      comment: "Unique project identifier code"
    - name: "project_name"
      expr: project_name
      comment: "Name of the construction project"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project (e.g., active, completed, on-hold)"
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g., commercial, residential, infrastructure)"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Project delivery model (e.g., design-bid-build, design-build, EPC)"
    - name: "region"
      expr: region
      comment: "Geographic region of the project"
    - name: "country_code"
      expr: country_code
      comment: "Country where the project is located"
    - name: "city"
      expr: city
      comment: "City where the project is located"
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "Health, safety, and environment risk classification"
    - name: "pmo_classification"
      expr: pmo_classification
      comment: "Project management office classification"
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level for sustainability"
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating if project is a joint venture"
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the project contract"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned project start"
    - name: "planned_start_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date))
      comment: "Quarter of planned project start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year of actual project start"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across projects - primary revenue metric"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved budget across projects"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per project"
    - name: "avg_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across projects"
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index - measures cost efficiency (>1 is under budget)"
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index - measures schedule efficiency (>1 is ahead of schedule)"
    - name: "project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct construction projects"
    - name: "avg_retention_pct"
      expr: AVG(CAST(retention_pct AS DOUBLE))
      comment: "Average retention percentage held by clients"
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate per day of delay"
    - name: "avg_jv_partner_share_pct"
      expr: AVG(CAST(jv_partner_share_pct AS DOUBLE))
      comment: "Average joint venture partner share percentage"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned value management and cost control metrics at the cost account level for project financial performance"
  source: "`vibe_construction_v1`.`project`.`cost_account`"
  dimensions:
    - name: "cost_code"
      expr: cost_code
      comment: "Cost code identifier"
    - name: "account_description"
      expr: account_description
      comment: "Description of the cost account"
    - name: "account_status"
      expr: account_status
      comment: "Status of the cost account"
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g., labor, material, equipment, subcontract)"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial reporting"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code"
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating if cost account is lump sum"
    - name: "is_subcontract_scope"
      expr: is_subcontract_scope
      comment: "Flag indicating if cost account is subcontract scope"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost account"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_date)
      comment: "Year of reporting period"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_date)
      comment: "Month of reporting period"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount - baseline for cost control"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred - ACWP in EVM"
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value_amount AS DOUBLE))
      comment: "Total earned value - BCWP in EVM, measures work completed"
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value_amount AS DOUBLE))
      comment: "Total planned value - BCWS in EVM, measures work scheduled"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed cost via purchase orders and contracts"
    - name: "total_forecast_cost_at_completion"
      expr: SUM(CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Total forecast cost at completion - EAC, critical for project outcome prediction"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (EV - AC) - positive means under budget"
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order amount approved"
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency amount available"
    - name: "total_cost_to_complete"
      expr: SUM(CAST(cost_to_complete_amount AS DOUBLE))
      comment: "Total estimated cost to complete remaining work - ETC"
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index - cost efficiency indicator"
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index - schedule efficiency indicator"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across cost accounts"
    - name: "cost_account_count"
      expr: COUNT(DISTINCT cost_account_id)
      comment: "Number of distinct cost accounts"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order impact metrics tracking cost and schedule impacts of project changes for scope and risk management"
  source: "`vibe_construction_v1`.`project`.`project_change_order`"
  dimensions:
    - name: "co_number"
      expr: co_number
      comment: "Change order number"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g., scope addition, design change, unforeseen condition)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of change order"
    - name: "originator"
      expr: originator
      comment: "Party that originated the change order"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the change"
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating if change order is disputed"
    - name: "is_ld_applicable"
      expr: is_ld_applicable
      comment: "Flag indicating if liquidated damages are applicable"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Project delivery model"
    - name: "cost_impact_currency"
      expr: cost_impact_currency
      comment: "Currency of cost impact"
    - name: "submitted_year"
      expr: YEAR(submitted_date)
      comment: "Year change order was submitted"
    - name: "submitted_quarter"
      expr: CONCAT('Q', QUARTER(submitted_date))
      comment: "Quarter change order was submitted"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year change order was approved"
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of change orders - critical for budget overrun tracking"
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct cost of change orders"
    - name: "total_overhead_and_profit"
      expr: SUM(CAST(overhead_and_profit_amount AS DOUBLE))
      comment: "Total overhead and profit on change orders"
    - name: "total_contingency_drawn"
      expr: SUM(CAST(contingency_drawn_amount AS DOUBLE))
      comment: "Total contingency amount drawn for change orders"
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order"
    - name: "change_order_count"
      expr: COUNT(DISTINCT project_change_order_id)
      comment: "Number of distinct change orders - volume indicator for project volatility"
    - name: "disputed_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN is_disputed = TRUE THEN project_change_order_id END)
      comment: "Number of disputed change orders - risk indicator"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone achievement and schedule performance metrics for tracking critical project deliverables and payment triggers"
  source: "`vibe_construction_v1`.`project`.`project_milestone`"
  dimensions:
    - name: "milestone_code"
      expr: milestone_code
      comment: "Milestone code identifier"
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the milestone"
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., design, procurement, construction, commissioning)"
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of milestone"
    - name: "is_contractual"
      expr: is_contractual
      comment: "Flag indicating if milestone is contractually binding"
    - name: "is_payment_trigger"
      expr: is_payment_trigger
      comment: "Flag indicating if milestone triggers payment"
    - name: "is_ld_trigger"
      expr: is_ld_trigger
      comment: "Flag indicating if milestone triggers liquidated damages"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating if milestone is on critical path"
    - name: "hse_clearance_required"
      expr: hse_clearance_required
      comment: "Flag indicating if HSE clearance is required"
    - name: "leed_related"
      expr: leed_related
      comment: "Flag indicating if milestone is LEED certification related"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for milestone completion"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Project delivery model"
    - name: "ld_currency_code"
      expr: ld_currency_code
      comment: "Currency code for liquidated damages"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year of planned milestone date"
    - name: "planned_quarter"
      expr: CONCAT('Q', QUARTER(planned_date))
      comment: "Quarter of planned milestone date"
    - name: "actual_year"
      expr: YEAR(actual_date)
      comment: "Year of actual milestone completion"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount tied to milestones - critical for cash flow management"
    - name: "total_ld_rate_per_day"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Total liquidated damages rate per day across milestones"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones"
    - name: "milestone_count"
      expr: COUNT(DISTINCT project_milestone_id)
      comment: "Number of distinct milestones"
    - name: "contractual_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_contractual = TRUE THEN project_milestone_id END)
      comment: "Number of contractual milestones - key for compliance tracking"
    - name: "payment_trigger_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_payment_trigger = TRUE THEN project_milestone_id END)
      comment: "Number of payment trigger milestones - critical for revenue recognition"
    - name: "ld_trigger_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_ld_trigger = TRUE THEN project_milestone_id END)
      comment: "Number of LD trigger milestones - risk exposure indicator"
    - name: "critical_path_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_path = TRUE THEN project_milestone_id END)
      comment: "Number of critical path milestones - schedule risk indicator"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk exposure and mitigation metrics for proactive risk management and contingency planning"
  source: "`vibe_construction_v1`.`project`.`risk_register`"
  dimensions:
    - name: "risk_code"
      expr: risk_code
      comment: "Risk code identifier"
    - name: "risk_title"
      expr: risk_title
      comment: "Title of the risk"
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk"
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g., technical, commercial, environmental)"
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk"
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating (e.g., low, medium, high)"
    - name: "cost_impact_rating"
      expr: cost_impact_rating
      comment: "Cost impact rating"
    - name: "schedule_impact_rating"
      expr: schedule_impact_rating
      comment: "Schedule impact rating"
    - name: "quality_impact_rating"
      expr: quality_impact_rating
      comment: "Quality impact rating"
    - name: "mitigation_response_type"
      expr: mitigation_response_type
      comment: "Type of mitigation response (e.g., avoid, transfer, mitigate, accept)"
    - name: "risk_proximity"
      expr: risk_proximity
      comment: "Proximity of risk occurrence"
    - name: "hse_risk_flag"
      expr: hse_risk_flag
      comment: "Flag indicating if risk is HSE related"
    - name: "regulatory_risk_flag"
      expr: regulatory_risk_flag
      comment: "Flag indicating if risk is regulatory related"
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Flag indicating if risk has insurance coverage"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating if risk requires escalation"
    - name: "affected_discipline"
      expr: affected_discipline
      comment: "Discipline affected by the risk"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost impacts"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year risk was identified"
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of risks - critical for contingency planning"
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Total contingency cost allocated to risks"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score - overall risk exposure indicator"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation - effectiveness of risk management"
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score"
    - name: "avg_residual_probability_score"
      expr: AVG(CAST(residual_probability_score AS DOUBLE))
      comment: "Average residual probability score after mitigation"
    - name: "risk_count"
      expr: COUNT(DISTINCT risk_register_id)
      comment: "Number of distinct risks - volume indicator for project complexity"
    - name: "hse_risk_count"
      expr: COUNT(DISTINCT CASE WHEN hse_risk_flag = TRUE THEN risk_register_id END)
      comment: "Number of HSE risks - safety exposure indicator"
    - name: "regulatory_risk_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_risk_flag = TRUE THEN risk_register_id END)
      comment: "Number of regulatory risks - compliance exposure indicator"
    - name: "escalated_risk_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN risk_register_id END)
      comment: "Number of escalated risks - critical attention required"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project forecast and estimate-at-completion metrics for financial outcome prediction and variance analysis"
  source: "`vibe_construction_v1`.`project`.`forecast`"
  dimensions:
    - name: "forecast_number"
      expr: forecast_number
      comment: "Forecast number identifier"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., monthly, quarterly, annual)"
    - name: "revision_number"
      expr: revision_number
      comment: "Revision number of the forecast"
    - name: "cost_trend_indicator"
      expr: cost_trend_indicator
      comment: "Cost trend indicator (e.g., improving, stable, deteriorating)"
    - name: "schedule_trend_indicator"
      expr: schedule_trend_indicator
      comment: "Schedule trend indicator"
    - name: "is_client_reported"
      expr: is_client_reported
      comment: "Flag indicating if forecast is reported to client"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for forecast amounts"
    - name: "reporting_currency_code"
      expr: reporting_currency_code
      comment: "Reporting currency code"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_date)
      comment: "Year of reporting period"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_date)
      comment: "Month of reporting period"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year forecast was approved"
  measures:
    - name: "total_eac_cost"
      expr: SUM(CAST(eac_cost AS DOUBLE))
      comment: "Total Estimate at Completion - critical forecast of final project cost"
    - name: "total_etc_cost"
      expr: SUM(CAST(etc_cost AS DOUBLE))
      comment: "Total Estimate to Complete - remaining cost to finish project"
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual cost incurred to date"
    - name: "total_bac_cost"
      expr: SUM(CAST(bac_cost AS DOUBLE))
      comment: "Total Budget at Completion - original baseline budget"
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total variance at completion (BAC - EAC) - expected profit/loss at project end"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance to date"
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value"
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value"
    - name: "total_eac_movement"
      expr: SUM(CAST(eac_movement AS DOUBLE))
      comment: "Total EAC movement from prior period - trend indicator"
    - name: "total_contingency_remaining"
      expr: SUM(CAST(contingency_remaining AS DOUBLE))
      comment: "Total contingency remaining - buffer available for risks"
    - name: "total_management_reserve_remaining"
      expr: SUM(CAST(management_reserve_remaining AS DOUBLE))
      comment: "Total management reserve remaining"
    - name: "total_risk_provision"
      expr: SUM(CAST(risk_provision_amount AS DOUBLE))
      comment: "Total risk provision amount"
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index"
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index"
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index - efficiency needed to meet budget"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete"
    - name: "forecast_count"
      expr: COUNT(DISTINCT forecast_id)
      comment: "Number of distinct forecasts"
$$;