-- Metric views for domain: project | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_commissioning_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commissioning package KPIs — tracks mechanical completion, punch list closure, FAT/SAT status, and handover readiness to manage project completion and client acceptance."
  source: "`vibe_construction_v1`.`project`.`commissioning_package`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level commissioning progress."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the commissioning package (e.g. In Progress, Mechanically Complete, Handed Over) — primary filter for commissioning dashboards."
    - name: "package_type"
      expr: package_type
      comment: "Type of commissioning package (e.g. Mechanical, Electrical, Instrumentation) — used to track completion by discipline."
    - name: "fat_status"
      expr: fat_status
      comment: "Factory Acceptance Test status — FAT completion is a prerequisite for site commissioning."
    - name: "sat_status"
      expr: sat_status
      comment: "Site Acceptance Test status — SAT completion is a prerequisite for handover."
    - name: "pre_commissioning_complete"
      expr: pre_commissioning_complete
      comment: "Indicates whether pre-commissioning activities are complete — prerequisite for commissioning start."
    - name: "operational_readiness_verified"
      expr: operational_readiness_verified
      comment: "Indicates whether operational readiness has been verified — required for client handover acceptance."
    - name: "area_location"
      expr: area_location
      comment: "Physical area or location of the commissioning package — used for area-based completion tracking."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month of planned commissioning completion — used for completion pipeline and handover forecasting."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of commissioning packages — baseline count for commissioning scope management."
    - name: "packages_mechanically_complete"
      expr: COUNT(CASE WHEN mechanical_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of packages that have achieved mechanical completion — key milestone for commissioning readiness."
    - name: "packages_handed_over"
      expr: COUNT(CASE WHEN handover_date IS NOT NULL THEN 1 END)
      comment: "Number of packages formally handed over to the client — measures final delivery progress."
    - name: "avg_punch_list_closure_pct"
      expr: AVG(CAST(punch_list_closure_pct AS DOUBLE))
      comment: "Average punch list closure percentage across packages — measures completion quality; low closure rates delay handover and trigger LD exposure."
    - name: "total_cat_a_punch_items"
      expr: COUNT(1)
      comment: "Total commissioning packages tracked — used as denominator for punch list ratio analysis (Cat A items stored as STRING, not summable)."
    - name: "packages_with_operational_readiness"
      expr: COUNT(CASE WHEN operational_readiness_verified = TRUE THEN 1 END)
      comment: "Number of packages with verified operational readiness — measures client acceptance readiness; directly linked to handover milestone achievement."
    - name: "packages_pre_commissioning_complete"
      expr: COUNT(CASE WHEN pre_commissioning_complete = TRUE THEN 1 END)
      comment: "Number of packages with pre-commissioning complete — measures readiness for commissioning start; pipeline indicator for completion schedule."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs for construction projects — tracks financial performance, schedule adherence, physical progress, and risk exposure across the project portfolio."
  source: "`vibe_construction_v1`.`project`.`construction_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, Closed, On Hold) — primary filter for portfolio health views."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project (e.g. Infrastructure, Commercial, Energy) — used to segment portfolio performance by sector."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (e.g. EPC, Design-Build, LSTK) — key driver of risk and margin profile."
    - name: "region"
      expr: region
      comment: "Geographic region of the project — enables regional portfolio performance comparison."
    - name: "country_code"
      expr: country_code
      comment: "Country where the project is located — supports country-level regulatory and financial reporting."
    - name: "pmo_classification"
      expr: pmo_classification
      comment: "PMO tier or classification (e.g. Major, Strategic, Standard) — used to prioritise executive oversight."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk classification of the project — critical for safety governance dashboards."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level — used for sustainability portfolio tracking."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Indicates whether the project is a joint venture — affects revenue recognition and risk sharing analysis."
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the contract — required for multi-currency portfolio consolidation."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned project start — used for pipeline and mobilisation trend analysis."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month of planned project completion — used for revenue recognition and resource release forecasting."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of construction projects — baseline portfolio size metric for executive dashboards."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Sum of all contract values — represents total revenue backlog and portfolio scale; key input for revenue forecasting."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Sum of approved project budgets — measures total authorised spend across the portfolio; compared against contract value to assess margin."
    - name: "avg_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across active projects — executive indicator of overall portfolio delivery pace."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across projects — CPI < 1.0 signals cost overrun; used by PMO to trigger corrective action."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across projects — SPI < 1.0 signals schedule slippage; drives acceleration decisions."
    - name: "total_jv_partner_share_pct"
      expr: AVG(CAST(jv_partner_share_pct AS DOUBLE))
      comment: "Average JV partner equity share across joint-venture projects — informs consolidated revenue and risk exposure reporting."
    - name: "total_retention_pct_avg"
      expr: AVG(CAST(retention_pct AS DOUBLE))
      comment: "Average retention percentage held across contracts — indicates cash flow impact from withheld retention funds."
    - name: "projects_with_ld_exposure"
      expr: COUNT(CASE WHEN liquidated_damages_rate > 0 THEN 1 END)
      comment: "Number of projects with an active liquidated damages rate — measures LD risk exposure count in the portfolio."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Sum of daily LD rates across all projects — proxy for total daily financial exposure from schedule delays."
    - name: "joint_venture_project_count"
      expr: COUNT(CASE WHEN is_joint_venture = TRUE THEN 1 END)
      comment: "Number of joint-venture projects — used to assess JV portfolio concentration and governance overhead."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per project — benchmark for project scale; used in bid strategy and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost account KPIs — tracks budget consumption, cost performance, and variance at the control account level for project cost management."
  source: "`vibe_construction_v1`.`project`.`cost_account`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level cost roll-ups."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables cost analysis at work-package level."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g. Labour, Material, Equipment, Subcontract) — used to analyse cost composition and identify overruns by category."
    - name: "account_status"
      expr: account_status
      comment: "Status of the cost account (e.g. Active, Closed, On Hold) — filters for active accounts in live cost reporting."
    - name: "phase_code"
      expr: phase_code
      comment: "Project phase associated with the cost account — enables phase-level cost performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost account values — required for multi-currency consolidation."
    - name: "is_subcontract_scope"
      expr: is_subcontract_scope
      comment: "Indicates whether the cost account covers subcontracted scope — used to separate direct and subcontract cost performance."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates lump-sum vs. remeasurable cost account — affects how cost variance is interpreted."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Month of the reporting period — enables period-over-period cost trend analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across cost accounts — represents authorised spend ceiling; compared to actual and committed costs."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred — primary measure of spend to date; compared to budget to assess overrun risk."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed cost (purchase orders, subcontracts) — represents financial obligations not yet invoiced; critical for cash flow management."
    - name: "total_cost_to_complete"
      expr: SUM(CAST(cost_to_complete_amount AS DOUBLE))
      comment: "Total estimated cost to complete remaining work — key input for EAC and cash flow forecasting."
    - name: "total_forecast_cost_at_completion"
      expr: SUM(CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Total forecasted final cost at completion — compared to approved budget to quantify projected overrun or saving."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (budget minus actual) — negative value signals cost overrun; primary cost control KPI."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value_amount AS DOUBLE))
      comment: "Total earned value across cost accounts — measures value of work performed; used in CPI calculation."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value_amount AS DOUBLE))
      comment: "Total planned value (BCWS) across cost accounts — baseline for schedule performance measurement."
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order value incorporated into cost accounts — measures scope growth impact on budget."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget remaining — measures risk buffer available; declining contingency signals increasing cost risk."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across cost accounts — CPI < 1.0 signals systemic cost inefficiency requiring management action."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across cost accounts — SPI < 1.0 signals schedule underperformance."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across cost accounts — overall work progress indicator at control account level."
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original (pre-change) budget — baseline for measuring scope growth and budget erosion over project life."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project deliverable KPIs — tracks deliverable completion, contractual compliance, and handover readiness to manage output delivery performance."
  source: "`vibe_construction_v1`.`project`.`deliverable`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level deliverable analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables deliverable analysis at work-package level."
    - name: "deliverable_status"
      expr: deliverable_status
      comment: "Current status of the deliverable (e.g. Issued, Accepted, Overdue) — primary filter for deliverable performance dashboards."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (e.g. Drawing, Report, Certificate, Model) — used to analyse completion by output type."
    - name: "deliverable_category"
      expr: deliverable_category
      comment: "Category of the deliverable (e.g. Design, Construction, Commissioning) — used to track completion by project phase."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the deliverable — enables discipline-level delivery performance tracking."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Client acceptance status (e.g. Accepted, Rejected, Under Review) — measures client satisfaction with deliverable quality."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Indicates whether the deliverable is a contractual obligation — contractual deliverables carry schedule and payment consequences."
    - name: "is_handover_required"
      expr: is_handover_required
      comment: "Indicates whether the deliverable is required for handover — handover-required deliverables are on the critical path to completion."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the deliverable — used to focus management attention on highest-priority outputs."
    - name: "planned_issue_date"
      expr: DATE_TRUNC('month', planned_issue_date)
      comment: "Month of planned issue date — used for deliverable pipeline and workload forecasting."
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of deliverables — baseline count for deliverable portfolio management."
    - name: "accepted_deliverables"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of client-accepted deliverables — measures successful delivery rate; compared to total for acceptance performance."
    - name: "overdue_deliverables"
      expr: COUNT(CASE WHEN deliverable_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue deliverables — direct indicator of delivery failure; triggers management escalation."
    - name: "contractual_deliverable_count"
      expr: COUNT(CASE WHEN is_contractual = TRUE THEN 1 END)
      comment: "Number of contractual deliverables — measures contractual obligation density; used for contract compliance reporting."
    - name: "handover_required_count"
      expr: COUNT(CASE WHEN is_handover_required = TRUE THEN 1 END)
      comment: "Number of deliverables required for handover — measures handover critical path deliverable count."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across deliverables — overall deliverable progress indicator."
    - name: "avg_weight_factor"
      expr: AVG(CAST(weight_factor AS DOUBLE))
      comment: "Average weight factor across deliverables — measures relative importance distribution; used in weighted progress calculations."
    - name: "eot_applicable_count"
      expr: COUNT(CASE WHEN eot_applicable = TRUE THEN 1 END)
      comment: "Number of deliverables with EOT applicable — measures scope of extension of time claims linked to deliverable delays."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_evm_period_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) period KPIs — the primary source of truth for cost and schedule performance at WBS and project level across reporting periods."
  source: "`vibe_construction_v1`.`project`.`evm_period_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping dimension for project-level EVM roll-ups."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables EVM analysis at work-package granularity."
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Foreign key to the reporting period — enables period-over-period EVM trend analysis."
    - name: "measurement_level"
      expr: measurement_level
      comment: "Level at which EVM is measured (e.g. Project, WBS, Control Account) — determines aggregation scope."
    - name: "forecast_method"
      expr: forecast_method
      comment: "EAC forecast method used (e.g. CPI-based, ETC-based) — affects EAC comparability across records."
    - name: "cpi_trend"
      expr: cpi_trend
      comment: "Trend direction of CPI (Improving, Stable, Declining) — early warning indicator for cost performance deterioration."
    - name: "spi_trend"
      expr: spi_trend
      comment: "Trend direction of SPI (Improving, Stable, Declining) — early warning indicator for schedule performance deterioration."
    - name: "record_status"
      expr: record_status
      comment: "Status of the EVM record (e.g. Approved, Draft, Submitted) — filters for approved data in executive reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of EVM financial values — required for multi-currency portfolio consolidation."
    - name: "data_date"
      expr: DATE_TRUNC('month', data_date)
      comment: "Month of the EVM data date — used for time-series trend charts of cost and schedule performance."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the reporting period start — used for period-over-period EVM comparison."
  measures:
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value) — baseline against which actual and earned performance is measured."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) — measures the value of work actually completed against the plan."
    - name: "total_acwp"
      expr: SUM(CAST(acwp AS DOUBLE))
      comment: "Total Actual Cost of Work Performed — measures actual spend; compared to BCWP to derive cost variance."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Sum of cost variances (BCWP - ACWP) — negative total signals portfolio-wide cost overrun requiring executive intervention."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Sum of schedule variances (BCWP - BCWS) — negative total signals portfolio-wide schedule slippage."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC) across all WBS elements — represents total authorised project budget."
    - name: "total_eac"
      expr: SUM(CAST(eac AS DOUBLE))
      comment: "Total Estimate at Completion — forecasted final cost; compared to BAC to quantify projected overrun or saving."
    - name: "total_vac"
      expr: SUM(CAST(vac AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC) — negative VAC signals projected cost overrun; key executive risk metric."
    - name: "total_etc"
      expr: SUM(CAST(etc AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost to finish all work; critical for cash flow forecasting."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index — CPI < 1.0 indicates cost inefficiency; used to benchmark project cost health."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index — SPI < 1.0 indicates schedule inefficiency; drives acceleration decisions."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index — TCPI > 1.0 means remaining work must be done more efficiently than to date; signals recovery difficulty."
    - name: "avg_physical_percent_complete"
      expr: AVG(CAST(physical_percent_complete AS DOUBLE))
      comment: "Average physical percent complete across WBS elements — overall portfolio delivery progress indicator."
    - name: "total_period_bcwp"
      expr: SUM(CAST(period_bcwp AS DOUBLE))
      comment: "Total earned value in the current period — measures period productivity; used in S-curve and burn rate analysis."
    - name: "total_period_acwp"
      expr: SUM(CAST(period_acwp AS DOUBLE))
      comment: "Total actual cost in the current period — measures period spend rate; compared to period BCWP for period cost efficiency."
    - name: "total_period_bcws"
      expr: SUM(CAST(period_bcws AS DOUBLE))
      comment: "Total planned value in the current period — baseline for period schedule performance assessment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project forecast KPIs — tracks EAC movement, cost variance trends, contingency consumption, and forecast accuracy to support financial completion planning."
  source: "`vibe_construction_v1`.`project`.`forecast`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level forecast analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables forecast analysis at work-package level."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g. Approved, Draft, Submitted) — filters for approved forecasts in executive reporting."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. Monthly, Quarterly, Final) — used to compare forecast types and assess frequency of updates."
    - name: "cost_trend_indicator"
      expr: cost_trend_indicator
      comment: "Direction of cost trend (Improving, Stable, Worsening) — early warning signal for cost overrun trajectory."
    - name: "schedule_trend_indicator"
      expr: schedule_trend_indicator
      comment: "Direction of schedule trend (Improving, Stable, Worsening) — early warning signal for schedule delay trajectory."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of forecast values — required for multi-currency portfolio consolidation."
    - name: "is_client_reported"
      expr: is_client_reported
      comment: "Indicates whether this forecast is reported to the client — used to distinguish internal vs. client-facing forecast versions."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Month of the reporting period — enables period-over-period forecast trend analysis."
  measures:
    - name: "total_eac_cost"
      expr: SUM(CAST(eac_cost AS DOUBLE))
      comment: "Total Estimate at Completion cost — forecasted final project cost; compared to BAC to quantify projected overrun or saving."
    - name: "total_bac_cost"
      expr: SUM(CAST(bac_cost AS DOUBLE))
      comment: "Total Budget at Completion — authorised budget baseline; compared to EAC to measure forecast variance."
    - name: "total_etc_cost"
      expr: SUM(CAST(etc_cost AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost to finish all work; critical for cash flow and funding adequacy assessment."
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual cost incurred to date — measures cumulative spend; combined with ETC to validate EAC."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (BAC minus EAC) — negative value signals projected overrun; primary financial completion risk metric."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion — measures projected final over/under-run against budget; key board-level financial KPI."
    - name: "total_eac_movement"
      expr: SUM(CAST(eac_movement AS DOUBLE))
      comment: "Total EAC movement from prior period — measures forecast volatility; large movements signal poor cost control or emerging risks."
    - name: "total_contingency_remaining"
      expr: SUM(CAST(contingency_remaining AS DOUBLE))
      comment: "Total contingency budget remaining — measures risk buffer available; declining contingency signals increasing cost risk."
    - name: "total_risk_provision"
      expr: SUM(CAST(risk_provision_amount AS DOUBLE))
      comment: "Total risk provision included in forecasts — measures quantified risk exposure incorporated into financial planning."
    - name: "total_management_reserve_remaining"
      expr: SUM(CAST(management_reserve_remaining AS DOUBLE))
      comment: "Total management reserve remaining — measures executive-held contingency buffer; used in final account risk assessment."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index from forecasts — CPI < 1.0 signals cost inefficiency; used to validate EAC reasonableness."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete from forecasts — overall portfolio delivery progress from the forecast perspective."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_handover_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Handover certificate KPIs — tracks formal project handover completion, DLP obligations, retention release eligibility, and contractual close-out status."
  source: "`vibe_construction_v1`.`project`.`handover_certificate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level handover analysis."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Status of the handover certificate (e.g. Issued, Accepted, Rejected) — primary filter for handover completion dashboards."
    - name: "handover_type"
      expr: handover_type
      comment: "Type of handover (e.g. Partial, Sectional, Final) — used to track handover completeness and DLP obligations."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model — used to compare handover performance across delivery models."
    - name: "commissioning_completed"
      expr: commissioning_completed
      comment: "Indicates whether commissioning was completed before handover — prerequisite for valid handover."
    - name: "retention_release_eligible"
      expr: retention_release_eligible
      comment: "Indicates whether retention is eligible for release — directly linked to cash flow from retention recovery."
    - name: "hse_clearance_obtained"
      expr: hse_clearance_obtained
      comment: "Indicates whether HSE clearance was obtained — mandatory prerequisite for handover in most jurisdictions."
    - name: "itp_completed"
      expr: itp_completed
      comment: "Indicates whether the Inspection and Test Plan was completed — quality prerequisite for handover."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the handover certificate was issued — used for handover completion trend analysis."
  measures:
    - name: "total_certificates"
      expr: COUNT(1)
      comment: "Total number of handover certificates — baseline count for handover portfolio management."
    - name: "accepted_certificates"
      expr: COUNT(CASE WHEN certificate_status = 'Accepted' THEN 1 END)
      comment: "Number of accepted handover certificates — measures successful handover completion; directly linked to DLP start and retention release."
    - name: "retention_release_eligible_count"
      expr: COUNT(CASE WHEN retention_release_eligible = TRUE THEN 1 END)
      comment: "Number of certificates eligible for retention release — measures cash flow opportunity from retention recovery."
    - name: "certificates_with_hse_clearance"
      expr: COUNT(CASE WHEN hse_clearance_obtained = TRUE THEN 1 END)
      comment: "Number of certificates with HSE clearance obtained — measures HSE compliance in handover process."
    - name: "certificates_commissioning_complete"
      expr: COUNT(CASE WHEN commissioning_completed = TRUE THEN 1 END)
      comment: "Number of certificates where commissioning was completed — measures quality of handover process."
    - name: "certificates_itp_complete"
      expr: COUNT(CASE WHEN itp_completed = TRUE THEN 1 END)
      comment: "Number of certificates with ITP completed — measures quality assurance compliance at handover."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project phase KPIs — tracks phase-level cost performance, schedule adherence, earned value, and gate approval status to manage project lifecycle governance."
  source: "`vibe_construction_v1`.`project`.`phase`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level phase analysis."
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the phase (e.g. Active, Complete, On Hold) — primary filter for phase performance dashboards."
    - name: "phase_type"
      expr: phase_type
      comment: "Type of phase (e.g. Design, Procurement, Construction, Commissioning) — used to compare performance across project lifecycle stages."
    - name: "gate_approval_status"
      expr: gate_approval_status
      comment: "Status of the phase gate approval (e.g. Approved, Pending, Rejected) — gate approvals are governance checkpoints for project continuation."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the phase is on the critical path — critical path phases have the highest schedule risk impact."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model — used to compare phase performance across delivery models."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the phase (e.g. High, Medium, Low) — used to prioritise management attention on high-risk phases."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Indicates whether the HSE plan for the phase is approved — mandatory governance requirement before phase commencement."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned phase start — used for resource mobilisation and cash flow planning."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across phases — represents authorised phase-level budget; compared to actual cost for phase cost control."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across phases — measures phase-level spend; compared to budget to assess overrun risk."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across phases — measures value of work performed at phase level; used in phase-level EVM."
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Total contingency budget across phases — measures risk buffer available at phase level."
    - name: "total_ld_exposure"
      expr: SUM(CAST(ld_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across phases — measures financial risk from phase schedule delays."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across phases — overall project delivery progress at phase level."
    - name: "avg_deliverables_completion_pct"
      expr: AVG(CAST(deliverables_completion_pct AS DOUBLE))
      comment: "Average deliverables completion percentage across phases — measures output delivery progress within each phase."
    - name: "avg_evm_weight_pct"
      expr: AVG(CAST(evm_weight_pct AS DOUBLE))
      comment: "Average EVM weight percentage across phases — measures relative phase contribution to overall project earned value."
    - name: "phases_gate_approved"
      expr: COUNT(CASE WHEN gate_approval_status = 'Approved' THEN 1 END)
      comment: "Number of phases with approved gate reviews — measures governance compliance; unapproved gates signal project continuation risk."
    - name: "critical_path_phase_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of phases on the critical path — measures schedule criticality concentration; used to focus management attention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_progress_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress measurement KPIs — tracks physical progress, earned value, and billing eligibility at the activity and WBS level to support payment certification and schedule control."
  source: "`vibe_construction_v1`.`project`.`progress_measurement`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level progress analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables progress analysis at work-package level."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g. Approved, Pending, Rejected) — filters for approved measurements in billing and EVM."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g. Physical, Milestone, Weighted Steps) — used to compare measurement methodology effectiveness."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. Units Complete, Percent Complete, Milestones) — affects comparability of progress data."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or construction discipline (e.g. Civil, Mechanical, Electrical) — enables discipline-level progress tracking."
    - name: "is_billing_eligible"
      expr: is_billing_eligible
      comment: "Indicates whether the measurement is eligible for billing — links progress to cash flow."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Indicates whether the measurement is milestone-based — milestone measurements have binary completion characteristics."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of measurement values — required for multi-currency portfolio consolidation."
    - name: "measurement_date"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of the progress measurement — used for period-over-period progress trend analysis."
  measures:
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value from progress measurements — measures value of work performed; primary input for EVM and payment certification."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value from progress measurements — schedule performance baseline; compared to earned value for SPI."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total budget at completion from progress measurements — authorised budget for measured work scope."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance from progress measurements — measures cost performance at activity level."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance from progress measurements — measures schedule performance at activity level."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across measured activities — overall work progress indicator."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index from progress measurements — CPI < 1.0 signals cost inefficiency at activity level."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index from progress measurements — SPI < 1.0 signals schedule underperformance at activity level."
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total installed quantity across all measurements — physical production output metric; used for productivity benchmarking."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total installed quantity in the current period — period productivity metric; used for burn rate and acceleration analysis."
    - name: "billing_eligible_measurement_count"
      expr: COUNT(CASE WHEN is_billing_eligible = TRUE THEN 1 END)
      comment: "Number of billing-eligible measurements — measures volume of progress available for payment certification."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project baseline KPIs — tracks baseline establishment, budget authorisation, and variance between baseline and current forecast to measure scope and cost control effectiveness."
  source: "`vibe_construction_v1`.`project`.`project_baseline`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level baseline analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables baseline analysis at work-package level."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (e.g. Original, Revised, Current) — used to compare baseline versions and measure scope growth."
    - name: "baseline_status"
      expr: baseline_status
      comment: "Status of the baseline (e.g. Approved, Superseded, Draft) — filters for approved baselines in performance reporting."
    - name: "is_current_baseline"
      expr: is_current_baseline
      comment: "Indicates whether this is the current active baseline — used to isolate the performance measurement baseline."
    - name: "is_client_approved"
      expr: is_client_approved
      comment: "Indicates whether the baseline has client approval — client-approved baselines are contractually binding."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model — used to compare baseline stability across delivery models."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of baseline values — required for multi-currency portfolio consolidation."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of baseline approval — used for baseline establishment timeline analysis."
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion across baselines — represents total authorised project budget at baseline; primary cost control reference."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value incorporated in baselines — measures revenue baseline for margin analysis."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) from baselines — schedule performance measurement baseline."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion from baselines — measures projected final over/under-run against baseline budget."
    - name: "total_co_value_incorporated"
      expr: SUM(CAST(co_value_incorporated AS DOUBLE))
      comment: "Total change order value incorporated into baselines — measures cumulative scope growth approved into the performance baseline."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget in baselines — measures risk buffer authorised at baseline; compared to current contingency remaining."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve in baselines — measures executive-held contingency; used in final account risk assessment."
    - name: "total_budget_revision_delta"
      expr: SUM(CAST(budget_after_revision AS DOUBLE) - CAST(budget_before_revision AS DOUBLE))
      comment: "Total net budget change from revisions — measures cumulative budget growth from baseline revisions; key scope control metric."
    - name: "approved_baseline_count"
      expr: COUNT(CASE WHEN baseline_status = 'Approved' THEN 1 END)
      comment: "Number of approved baselines — measures baseline governance compliance; multiple approved baselines per project may indicate poor change control."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_budget_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget revision KPIs — tracks frequency, magnitude, and drivers of budget changes to assess cost control discipline and scope management effectiveness."
  source: "`vibe_construction_v1`.`project`.`project_budget_revision`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level budget revision analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables budget revision analysis at work-package level."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of budget revision (e.g. Scope Change, Risk Drawdown, Contingency Transfer) — identifies drivers of budget growth."
    - name: "revision_status"
      expr: revision_status
      comment: "Status of the revision (e.g. Approved, Pending, Rejected) — tracks pipeline of unapproved budget changes."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category affected (e.g. Labour, Material, Subcontract) — used to analyse cost category drivers of budget growth."
    - name: "client_approved_flag"
      expr: client_approved_flag
      comment: "Indicates whether the revision has client approval — client-approved revisions are contractually recognised."
    - name: "evm_baseline_flag"
      expr: evm_baseline_flag
      comment: "Indicates whether the revision updates the EVM performance baseline — flags revisions that affect earned value measurement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revision values — required for multi-currency portfolio consolidation."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the revision becomes effective — used for budget growth trend analysis over time."
  measures:
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Total net budget revision amount — measures cumulative budget growth; large positive values signal poor scope control."
    - name: "total_budget_after_revision"
      expr: SUM(CAST(budget_after_revision AS DOUBLE))
      comment: "Total budget after all revisions — current authorised budget; compared to original budget to measure scope growth."
    - name: "total_budget_before_revision"
      expr: SUM(CAST(budget_before_revision AS DOUBLE))
      comment: "Total budget before revisions — original budget baseline; used to calculate cumulative budget growth percentage."
    - name: "total_contract_budget_impact"
      expr: SUM(CAST(contract_budget_impact AS DOUBLE))
      comment: "Total contract budget impact of revisions — measures how much of the budget growth is recoverable from the client."
    - name: "total_internal_budget_impact"
      expr: SUM(CAST(internal_budget_impact AS DOUBLE))
      comment: "Total internal (non-recoverable) budget impact — measures cost absorbed by the contractor; direct margin erosion indicator."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency incorporated in budget revisions — measures risk buffer adjustments over time."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve incorporated in budget revisions — measures executive contingency adjustments."
    - name: "pending_revision_count"
      expr: COUNT(CASE WHEN revision_status = 'Pending' THEN 1 END)
      comment: "Number of pending budget revisions — measures unresolved budget change pipeline; high counts signal approval bottlenecks."
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of budget revisions — high revision frequency signals poor initial scope definition or cost control discipline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order KPIs — tracks scope growth, cost impact, schedule impact, and approval status of project change orders to manage contract risk."
  source: "`vibe_construction_v1`.`project`.`project_change_order`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level change order analysis."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g. Scope Addition, Scope Reduction, Variation) — used to categorise drivers of cost and schedule growth."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change order (e.g. Approved, Pending, Rejected) — tracks pipeline of unapproved changes representing financial risk."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause code for the change (e.g. Design Error, Client Request, Site Condition) — used for lessons-learned and risk analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model — used to compare change order frequency and value across delivery models."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Indicates whether the change order is under dispute — disputed COs represent unresolved financial risk."
    - name: "is_ld_applicable"
      expr: is_ld_applicable
      comment: "Indicates whether liquidated damages apply to this change — flags COs with direct LD financial exposure."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of change order approval — used for trend analysis of change order approval velocity."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the change order becomes effective — used for budget and schedule impact timing analysis."
  measures:
    - name: "total_change_orders"
      expr: COUNT(1)
      comment: "Total number of change orders — baseline volume metric; high counts signal scope instability."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders — measures cumulative scope growth in monetary terms; key budget risk indicator."
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct cost component of change orders — used to separate direct labour/material costs from overhead in change analysis."
    - name: "total_overhead_and_profit"
      expr: SUM(CAST(overhead_and_profit_amount AS DOUBLE))
      comment: "Total overhead and profit claimed in change orders — measures margin impact of scope changes."
    - name: "total_contingency_drawn"
      expr: SUM(CAST(contingency_drawn_amount AS DOUBLE))
      comment: "Total contingency consumed by change orders — measures rate of contingency erosion; signals increasing cost risk when high."
    - name: "pending_change_order_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of change orders awaiting approval — represents unresolved financial exposure requiring management action."
    - name: "disputed_change_order_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed change orders — measures contractual dispute risk; high counts signal relationship or scope definition issues."
    - name: "avg_cost_impact_per_co"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order — benchmark for change order materiality; used to prioritise review effort."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Total daily LD rate across LD-applicable change orders — measures daily financial exposure from schedule-linked changes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone KPIs — tracks on-time delivery, LD exposure, payment triggers, and contractual milestone performance across the project portfolio."
  source: "`vibe_construction_v1`.`project`.`project_milestone`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level milestone performance."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Achieved, At Risk, Overdue) — primary filter for milestone health dashboards."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. Contractual, Internal, Payment) — used to prioritise contractual and payment-linked milestones."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of the milestone (e.g. Design, Procurement, Construction, Commissioning) — enables phase-level milestone tracking."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Indicates whether the milestone is a contractual obligation — contractual milestones carry LD and payment consequences."
    - name: "is_ld_trigger"
      expr: is_ld_trigger
      comment: "Indicates whether missing this milestone triggers liquidated damages — flags highest-risk milestones for executive attention."
    - name: "is_payment_trigger"
      expr: is_payment_trigger
      comment: "Indicates whether achieving this milestone triggers a payment — links milestone performance to cash flow."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the milestone is on the critical path — critical path milestones have the highest schedule risk impact."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model — used to compare milestone performance across delivery models."
    - name: "planned_date"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Month of planned milestone date — used for milestone pipeline and workload forecasting."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of project milestones — baseline count for milestone portfolio management."
    - name: "achieved_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones achieved — measures delivery success rate; compared to total for on-time performance."
    - name: "overdue_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue milestones — direct indicator of schedule failure; triggers management escalation."
    - name: "ld_trigger_milestones_at_risk"
      expr: COUNT(CASE WHEN is_ld_trigger = TRUE AND milestone_status != 'Achieved' THEN 1 END)
      comment: "Number of LD-trigger milestones not yet achieved — measures active LD financial exposure count; highest-priority risk metric."
    - name: "total_payment_trigger_value"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment value linked to payment-trigger milestones — measures cash inflow dependent on milestone achievement."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Total daily LD rate across all LD-trigger milestones — measures maximum daily financial exposure from milestone delays."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones — overall milestone progress indicator for portfolio dashboards."
    - name: "contractual_milestone_count"
      expr: COUNT(CASE WHEN is_contractual = TRUE THEN 1 END)
      comment: "Number of contractual milestones — measures contractual obligation density; high counts indicate complex contract management requirements."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path milestones — measures schedule criticality; used to focus management attention on highest-impact milestones."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_regulatory_oversight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory oversight KPIs — tracks compliance status, open findings, and inspection frequency to manage regulatory risk and ensure project licence to operate."
  source: "`vibe_construction_v1`.`project`.`regulatory_oversight`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level regulatory compliance analysis."
    - name: "oversight_type"
      expr: oversight_type
      comment: "Type of regulatory oversight (e.g. Environmental, Safety, Planning, Building) — used to analyse compliance by regulatory domain."
    - name: "oversight_status"
      expr: oversight_status
      comment: "Current status of the oversight engagement (e.g. Active, Closed, Suspended) — primary filter for active regulatory obligations."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status with the regulatory requirement (e.g. Compliant, Non-Compliant, Conditional) — primary risk indicator for regulatory exposure."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Qualitative compliance rating from the regulatory authority — used to benchmark regulatory performance across projects."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the oversight engagement is currently active — filters for live regulatory obligations."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of regulatory reporting required (e.g. Monthly, Quarterly, Annual) — used to manage reporting workload."
    - name: "inspection_date"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of the most recent inspection — used for inspection frequency trend analysis."
  measures:
    - name: "total_oversight_engagements"
      expr: COUNT(1)
      comment: "Total number of regulatory oversight engagements — baseline count for regulatory compliance portfolio management."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant regulatory engagements — measures active regulatory breach risk; non-compliance can result in stop-work orders."
    - name: "active_oversight_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active regulatory oversight engagements — measures current regulatory obligation load on the project."
    - name: "corrective_actions_required_count"
      expr: COUNT(CASE WHEN corrective_actions_required IS NOT NULL AND corrective_actions_required != '' THEN 1 END)
      comment: "Number of oversight engagements with outstanding corrective actions — measures regulatory remediation workload."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reporting period KPIs — tracks period status, closure rates, and calendar coverage to support timely financial and progress reporting governance."
  source: "`vibe_construction_v1`.`project`.`reporting_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (e.g. Monthly, Quarterly, Annual) — used to filter for the appropriate reporting cadence."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reporting period — used for annual financial performance aggregation."
    - name: "is_closed"
      expr: is_closed
      comment: "Indicates whether the reporting period is closed — closed periods have finalised data; open periods may still be updated."
    - name: "is_current"
      expr: is_current
      comment: "Indicates whether this is the current active reporting period — used to filter for live period data in dashboards."
    - name: "calendar_type"
      expr: calendar_type
      comment: "Calendar type (e.g. Gregorian, Fiscal, Project) — used to align reporting periods with financial and project calendars."
    - name: "reporting_period_status"
      expr: reporting_period_status
      comment: "Status of the reporting period (e.g. Open, Closed, Locked) — used to manage data entry and reporting governance."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of the reporting period start — used for time-series alignment of period-based KPIs."
  measures:
    - name: "total_periods"
      expr: COUNT(1)
      comment: "Total number of reporting periods defined — baseline count for reporting calendar governance."
    - name: "closed_period_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Number of closed reporting periods — measures reporting closure compliance; unclosed periods delay financial consolidation."
    - name: "open_period_count"
      expr: COUNT(CASE WHEN is_closed = FALSE THEN 1 END)
      comment: "Number of open reporting periods — measures outstanding reporting obligations; multiple open periods signal governance issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk KPIs — tracks risk exposure, mitigation effectiveness, and residual risk to support proactive risk management and contingency planning."
  source: "`vibe_construction_v1`.`project`.`risk_register`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level risk analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Foreign key to the WBS element — enables risk analysis at work-package level."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Closed, Mitigated) — primary filter for active risk exposure dashboards."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk (e.g. Technical, Commercial, HSE, Regulatory) — used to analyse risk concentration by type."
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk (e.g. Threat, Opportunity) — used to separate downside risks from upside opportunities."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Qualitative probability rating (e.g. High, Medium, Low) — used for risk heat map analysis."
    - name: "cost_impact_rating"
      expr: cost_impact_rating
      comment: "Qualitative cost impact rating — used to prioritise risks by financial consequence."
    - name: "schedule_impact_rating"
      expr: schedule_impact_rating
      comment: "Qualitative schedule impact rating — used to prioritise risks by schedule consequence."
    - name: "mitigation_response_type"
      expr: mitigation_response_type
      comment: "Risk response strategy (e.g. Mitigate, Transfer, Accept, Avoid) — used to assess risk management strategy mix."
    - name: "hse_risk_flag"
      expr: hse_risk_flag
      comment: "Indicates whether the risk has an HSE dimension — HSE risks require mandatory escalation and reporting."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the risk has been escalated — escalated risks require executive attention and action."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the risk was identified — used for risk emergence trend analysis."
  measures:
    - name: "total_open_risks"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open risks — primary risk portfolio size metric; high counts signal inadequate risk closure."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total gross cost impact of all open risks — measures maximum financial exposure from the risk register; key input for contingency sizing."
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Total contingency allocated to risks — measures risk-specific contingency provisions; compared to total cost impact for coverage ratio."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score (probability × impact) — overall risk severity indicator; rising average signals deteriorating risk profile."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation — measures effectiveness of risk mitigation actions; compared to gross risk score."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score across open risks — measures likelihood-weighted risk exposure."
    - name: "escalated_risk_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated risks — measures risks requiring executive intervention; high counts signal systemic project issues."
    - name: "hse_risk_count"
      expr: COUNT(CASE WHEN hse_risk_flag = TRUE THEN 1 END)
      comment: "Number of HSE-flagged risks — measures safety and environmental risk exposure; mandatory reporting metric."
    - name: "avg_residual_probability_score"
      expr: AVG(CAST(residual_probability_score AS DOUBLE))
      comment: "Average residual probability score after mitigation — measures how effectively mitigation reduces risk likelihood."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_team_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project team member KPIs — tracks staffing levels, man-day utilisation, mobilisation status, and key personnel coverage to manage project human resource performance."
  source: "`vibe_construction_v1`.`project`.`team_member`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level staffing analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status (e.g. Active, Demobilised, Pending) — primary filter for active staffing dashboards."
    - name: "role_category"
      expr: role_category
      comment: "Category of the role (e.g. Management, Engineering, Supervision) — used to analyse staffing composition by function."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or construction discipline of the team member — enables discipline-level staffing analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g. Direct, Agency, Secondment) — used to analyse workforce composition and cost structure."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilisation status (e.g. Mobilised, Pending, Demobilised) — tracks workforce deployment readiness."
    - name: "is_key_personnel"
      expr: is_key_personnel
      comment: "Indicates whether the team member is designated key personnel — key personnel changes require client approval under most contracts."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (e.g. Site, Office, Remote) — used to analyse site vs. office staffing ratios."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the team member — used for local content compliance reporting and visa management."
    - name: "assignment_start_date"
      expr: DATE_TRUNC('month', assignment_start_date)
      comment: "Month of assignment start — used for mobilisation trend analysis and resource ramp-up tracking."
  measures:
    - name: "total_team_members"
      expr: COUNT(1)
      comment: "Total number of team member assignments — baseline headcount metric for project staffing dashboards."
    - name: "total_planned_man_days"
      expr: SUM(CAST(planned_man_days AS DOUBLE))
      comment: "Total planned man-days across all assignments — measures total planned labour input; used for resource planning and cost estimation."
    - name: "total_actual_man_days"
      expr: SUM(CAST(actual_man_days AS DOUBLE))
      comment: "Total actual man-days worked — measures actual labour consumption; compared to planned for productivity analysis."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across team members — measures workforce utilisation; low averages indicate under-deployment."
    - name: "total_daily_cost_rate"
      expr: SUM(CAST(cost_rate_daily AS DOUBLE))
      comment: "Total daily cost rate across all active assignments — measures total daily labour cost commitment; used for cash flow forecasting."
    - name: "key_personnel_count"
      expr: COUNT(CASE WHEN is_key_personnel = TRUE THEN 1 END)
      comment: "Number of key personnel on the project — measures contractual key personnel coverage; gaps require client notification."
    - name: "mobilised_member_count"
      expr: COUNT(CASE WHEN mobilization_status = 'Mobilised' THEN 1 END)
      comment: "Number of currently mobilised team members — measures active site presence; compared to planned staffing for mobilisation compliance."
    - name: "avg_cost_rate_daily"
      expr: AVG(CAST(cost_rate_daily AS DOUBLE))
      comment: "Average daily cost rate per team member — benchmark for workforce cost efficiency; used in bid rate validation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS element KPIs — tracks budget consumption, earned value, and physical progress at the work breakdown structure level to support cost and schedule control."
  source: "`vibe_construction_v1`.`project`.`wbs_element`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level WBS analysis."
    - name: "wbs_status"
      expr: wbs_status
      comment: "Current status of the WBS element (e.g. Active, Complete, On Hold) — primary filter for active WBS performance dashboards."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS element (e.g. Summary, Work Package, Control Account) — used to filter for appropriate aggregation level."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level of the WBS element — used to control aggregation depth in roll-up reports."
    - name: "charge_type"
      expr: charge_type
      comment: "Charge type (e.g. Direct, Indirect, Overhead) — used to separate direct project costs from overhead."
    - name: "responsible_discipline"
      expr: responsible_discipline
      comment: "Engineering or construction discipline responsible for the WBS element — enables discipline-level performance tracking."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model — used to compare WBS performance across delivery models."
    - name: "evm_enabled"
      expr: evm_enabled
      comment: "Indicates whether EVM is enabled for this WBS element — filters for EVM-tracked work packages."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates lump-sum vs. remeasurable WBS element — affects cost variance interpretation."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned WBS element start — used for resource and cash flow planning."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across WBS elements — represents total authorised budget at WBS level."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS elements — measures spend to date; compared to budget for cost control."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across WBS elements — measures value of work performed; primary EVM input."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) across WBS elements — schedule performance baseline."
    - name: "total_original_budget_cost"
      expr: SUM(CAST(original_budget_cost AS DOUBLE))
      comment: "Total original budget cost before changes — baseline for measuring scope growth and budget erosion."
    - name: "total_approved_budget_changes"
      expr: SUM(CAST(approved_budget_changes AS DOUBLE))
      comment: "Total approved budget changes incorporated — measures cumulative scope growth approved into the WBS."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across WBS elements — overall work progress indicator at WBS level."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity installed across WBS elements — physical production output metric for quantity-based work packages."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across WBS elements — production target baseline for quantity-based work packages."
    - name: "evm_enabled_element_count"
      expr: COUNT(CASE WHEN evm_enabled = TRUE THEN 1 END)
      comment: "Number of WBS elements with EVM enabled — measures EVM coverage; low coverage reduces earned value measurement reliability."
$$;
