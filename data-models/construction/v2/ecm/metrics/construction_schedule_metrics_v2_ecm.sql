-- Metric views for domain: schedule | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core schedule activity performance metrics tracking critical path exposure, schedule progress, and float consumption across construction project activities."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current lifecycle status of the activity (e.g. Not Started, In Progress, Complete) used to segment performance metrics."
    - name: "activity_type"
      expr: activity_type
      comment: "Classification of the activity (e.g. Construction, Procurement, Engineering) enabling type-level schedule analysis."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the activity lies on the critical path, enabling focused monitoring of schedule-driving work."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of scheduling constraint applied to the activity, useful for identifying constrained activities that may drive delays."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of the planned start date for trend analysis of activity starts over time."
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month bucket of the planned finish date for workload and completion forecasting."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month bucket of the actual start date for comparing planned vs actual start trends."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of schedule activities. Baseline denominator for all activity-level rate calculations."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Executives use this to gauge schedule risk concentration and resource prioritisation needs."
    - name: "completed_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END)
      comment: "Number of activities with a completed status. Tracks overall schedule execution progress."
    - name: "activity_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities completed. A primary schedule health KPI used in steering meetings to assess delivery pace against plan."
    - name: "critical_path_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE AND activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical path activities completed. Directly indicates whether the project end date is at risk."
    - name: "avg_percent_complete"
      expr: ROUND(AVG(CAST(percent_complete AS DOUBLE)), 2)
      comment: "Average percent complete across all activities. Provides a weighted view of overall schedule progress for executive dashboards."
    - name: "late_activity_count"
      expr: COUNT(CASE WHEN actual_finish_date > planned_finish_date AND activity_status != 'Complete' THEN 1 END)
      comment: "Number of activities running past their planned finish date. A leading indicator of schedule slippage requiring management intervention."
    - name: "late_activity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_finish_date > planned_finish_date AND activity_status != 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities that are late. Used in project reviews to benchmark schedule discipline and identify systemic delay patterns."
    - name: "not_started_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Not Started' THEN 1 END)
      comment: "Number of activities not yet started. Helps leadership identify mobilisation gaps and resource readiness issues."
    - name: "constrained_activity_count"
      expr: COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type != '' THEN 1 END)
      comment: "Number of activities with scheduling constraints applied. High constraint counts indicate schedule rigidity and potential delay risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule baseline vs actuals variance metrics enabling earned value analysis, baseline deviation tracking, and schedule performance benchmarking."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_lookahead_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Short-interval activity execution metrics tracking planned vs actual duration, cost variance, and non-completion analysis for operational schedule control."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_lookahead_activities"
      expr: COUNT(1)
      comment: "Total number of lookahead activities planned. Baseline denominator for PPC and completion rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource cost and quantity performance metrics for schedule activities, enabling earned value, cost variance, and resource utilisation analysis."
  source: "`vibe_construction_v1`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (e.g. Labor, Equipment, Material) for cost and quantity analysis by resource category."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor classification (e.g. Skilled, Unskilled, Supervisory) enabling workforce cost breakdown."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (e.g. Active, Closed, Pending) for filtering active vs historical records."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the resource assignment, used to segregate approved vs unapproved cost commitments."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code associated with the assignment for cost roll-up and budget alignment analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for resource quantities (e.g. Hours, m3, tonnes) enabling productivity rate calculations."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of the assignment start date for time-phased cost and resource loading analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the assigned activity is on the critical path, enabling cost-at-risk analysis for critical work."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all resource assignments. Baseline budget figure for cost performance measurement."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across resource assignments. Core cost tracking metric for project financial control."
    - name: "total_remaining_cost"
      expr: SUM(CAST(remaining_cost AS DOUBLE))
      comment: "Total remaining cost to complete assigned resources. Used in EAC (Estimate at Completion) forecasting."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) - SUM(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Difference between planned and actual cost (positive = under budget). A primary cost performance KPI for executive reporting."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of planned cost to actual cost (CPI). CPI < 1.0 signals cost overrun; used by project controls to trigger corrective action."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned resource quantity across assignments. Baseline for productivity and resource utilisation analysis."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual resource quantity consumed. Compared against planned quantity to assess resource efficiency."
    - name: "quantity_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned resource quantity actually consumed. Rates above 100% indicate over-consumption and potential cost overrun."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining resource quantity to be consumed. Feeds resource demand forecasting and procurement planning."
    - name: "total_overtime_cost"
      expr: ROUND(SUM(overtime_quantity * overtime_rate), 2)
      comment: "Total overtime cost derived from overtime quantity and rate. Executives monitor this to control premium labour spend."
    - name: "avg_cost_rate"
      expr: ROUND(AVG(CAST(cost_rate AS DOUBLE)), 2)
      comment: "Average cost rate per resource unit across assignments. Used to benchmark resource pricing and identify rate anomalies."
    - name: "critical_path_planned_cost"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN planned_cost ELSE 0 END)
      comment: "Total planned cost for critical path resource assignments. Quantifies the financial exposure on schedule-driving activities."
    - name: "critical_path_actual_cost"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN actual_cost ELSE 0 END)
      comment: "Total actual cost incurred on critical path activities. Enables focused cost control on schedule-critical work."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay event impact metrics quantifying cost and schedule disruption from delay events, enabling root cause analysis and EOT claim substantiation."
  source: "`vibe_construction_v1`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category of the delay event (e.g. Weather, Design, Procurement, Labour) for root cause analysis and risk pattern identification."
    - name: "event_type"
      expr: event_type
      comment: "Type of delay event enabling classification between excusable, compensable, and non-excusable delays."
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event record (e.g. Open, Closed, Under Review) for pipeline management."
    - name: "eot_claim_status"
      expr: eot_claim_status
      comment: "Status of the associated EOT claim, linking delay events to their contractual resolution outcomes."
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Indicates whether the delay event impacts the critical path, prioritising events with direct end-date consequences."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity rating of the delay event (e.g. High, Medium, Low) for risk-stratified delay management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the delay event for portfolio-level delay risk aggregation."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month bucket of the delay event start for trend analysis of delay frequency and seasonality."
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total number of delay events recorded. Baseline metric for delay frequency analysis and trend monitoring."
    - name: "critical_path_delay_event_count"
      expr: COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END)
      comment: "Number of delay events impacting the critical path. These events directly threaten the project completion date and require executive escalation."
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total financial impact of all delay events. Quantifies the monetary cost of schedule disruption for executive financial reporting."
    - name: "avg_cost_impact_per_event"
      expr: ROUND(AVG(CAST(impact_on_cost_amount AS DOUBLE)), 2)
      comment: "Average cost impact per delay event. Benchmarks the typical financial consequence of a delay event for risk provisioning."
    - name: "high_severity_delay_count"
      expr: COUNT(CASE WHEN severity_level = 'High' THEN 1 END)
      comment: "Number of high-severity delay events. A leading indicator of significant schedule and cost disruption requiring immediate management response."
    - name: "open_delay_event_count"
      expr: COUNT(CASE WHEN delay_event_status = 'Open' THEN 1 END)
      comment: "Number of delay events still open and unresolved. Unresolved events represent ongoing schedule risk and potential claim exposure."
    - name: "critical_path_cost_impact"
      expr: SUM(CASE WHEN impact_on_critical_path = TRUE THEN impact_on_cost_amount ELSE 0 END)
      comment: "Total cost impact of critical path delay events. Represents the financial exposure directly linked to end-date risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_lookahead_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Short-interval schedule (lookahead) performance metrics tracking Percent Plan Complete (PPC), readiness, and constraint management for operational schedule control."
  source: "`vibe_construction_v1`.`schedule`.`lookahead_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the lookahead plan (e.g. Draft, Approved, Closed) for filtering active planning cycles."
    - name: "readiness_status"
      expr: readiness_status
      comment: "Overall readiness status of the lookahead plan, indicating whether all constraints are resolved for planned work."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of constraint blocking planned activities (e.g. Material, Equipment, Permit) for constraint resolution prioritisation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the lookahead plan for risk-stratified short-interval schedule management."
    - name: "is_lps_enabled"
      expr: is_lps_enabled
      comment: "Indicates whether Last Planner System is enabled for this plan, enabling LPS vs traditional planning performance comparison."
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Flags plans impacted by weather constraints for weather risk analysis and seasonal planning."
    - name: "plan_date_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month bucket of the plan date for trend analysis of PPC and readiness over time."
    - name: "work_front"
      expr: work_front
      comment: "Work front or zone associated with the lookahead plan for location-based schedule performance analysis."
  measures:
    - name: "avg_ppc_actual_percent"
      expr: ROUND(AVG(CAST(ppc_actual_percent AS DOUBLE)), 2)
      comment: "Average Percent Plan Complete (PPC) across lookahead cycles. The primary Last Planner System KPI; PPC below 80% signals systemic planning reliability issues."
    - name: "avg_ppc_target_percent"
      expr: ROUND(AVG(CAST(ppc_target_percent AS DOUBLE)), 2)
      comment: "Average PPC target across lookahead plans. Used to assess whether planning targets are realistic and consistently met."
    - name: "ppc_achievement_gap"
      expr: ROUND(AVG(CAST(ppc_target_percent AS DOUBLE)) - AVG(CAST(ppc_actual_percent AS DOUBLE)), 2)
      comment: "Gap between target and actual PPC. A positive gap indicates planning reliability shortfall; used to drive continuous improvement in short-interval planning."
    - name: "avg_percent_plan_complete"
      expr: ROUND(AVG(CAST(percent_plan_complete AS DOUBLE)), 2)
      comment: "Average overall plan completion percentage across lookahead plans. Tracks execution fidelity against the short-interval schedule."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all lookahead plans. Provides a short-interval cost commitment view for cash flow management."
    - name: "crew_ready_plan_count"
      expr: COUNT(CASE WHEN crew_ready_flag = TRUE THEN 1 END)
      comment: "Number of lookahead plans where crew is confirmed ready. Low crew readiness rates indicate workforce mobilisation gaps."
    - name: "material_ready_plan_count"
      expr: COUNT(CASE WHEN material_ready_flag = TRUE THEN 1 END)
      comment: "Number of lookahead plans where materials are confirmed ready. Material readiness is a leading indicator of production continuity."
    - name: "equipment_ready_plan_count"
      expr: COUNT(CASE WHEN equipment_ready_flag = TRUE THEN 1 END)
      comment: "Number of lookahead plans where equipment is confirmed ready. Equipment readiness gaps are a common cause of short-interval schedule failures."
    - name: "full_readiness_plan_count"
      expr: COUNT(CASE WHEN crew_ready_flag = TRUE AND material_ready_flag = TRUE AND equipment_ready_flag = TRUE THEN 1 END)
      comment: "Number of lookahead plans where crew, material, and equipment are all confirmed ready. Full readiness is the strongest predictor of PPC achievement."
    - name: "full_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN crew_ready_flag = TRUE AND material_ready_flag = TRUE AND equipment_ready_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans achieving full resource readiness. A leading KPI for short-interval schedule reliability used in weekly production meetings."
    - name: "constrained_plan_count"
      expr: COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type != '' THEN 1 END)
      comment: "Number of lookahead plans with active constraints. High constraint counts indicate systemic planning obstacles requiring management resolution."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned value and schedule performance metrics derived from periodic progress updates, enabling SPI, SV, and forecast completion tracking."
  source: "`vibe_construction_v1`.`schedule`.`progress_update`"
  dimensions:
    - name: "progress_update_status"
      expr: progress_update_status
      comment: "Status of the progress update record (e.g. Draft, Approved, Submitted) for filtering authoritative vs draft data."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of the reporting cycle (e.g. Weekly, Monthly) enabling trend analysis at the appropriate cadence."
    - name: "reporting_status"
      expr: reporting_status
      comment: "Submission status of the reporting period update, used to identify overdue or incomplete reporting cycles."
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Flags updates where the critical path changed, enabling rapid identification of schedule re-sequencing events."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month bucket of the reporting period start for time-series trend analysis of schedule performance."
    - name: "reporting_date_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month bucket of the reporting date for aligning progress updates to calendar periods."
    - name: "update_source"
      expr: update_source
      comment: "Source system or method of the progress update (e.g. P6, Manual) for data quality and provenance analysis."
  measures:
    - name: "avg_spi"
      expr: ROUND(AVG(CAST(spi AS DOUBLE)), 4)
      comment: "Average Schedule Performance Index (BCWP/BCWS) across reporting periods. SPI < 1.0 indicates schedule underperformance; a primary EVM KPI for executive dashboards."
    - name: "avg_sv"
      expr: ROUND(AVG(CAST(sv AS DOUBLE)), 2)
      comment: "Average Schedule Variance (BCWP - BCWS) across reporting periods. Negative SV signals work is behind plan; used to quantify schedule slippage in cost terms."
    - name: "avg_sv_percent"
      expr: ROUND(AVG(CAST(sv_percent AS DOUBLE)), 2)
      comment: "Average Schedule Variance as a percentage of BCWS. Normalises SV across projects of different sizes for portfolio-level comparison."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) across all reporting periods. Core EVM metric representing the value of work actually accomplished."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled across all reporting periods. Planned value baseline for EVM calculations."
    - name: "avg_percent_complete_duration"
      expr: ROUND(AVG(CAST(percent_complete_duration AS DOUBLE)), 2)
      comment: "Average duration-based percent complete across reporting periods. Tracks overall schedule progress against the time baseline."
    - name: "avg_percent_complete_units"
      expr: ROUND(AVG(CAST(percent_complete_units AS DOUBLE)), 2)
      comment: "Average units-based percent complete across reporting periods. Provides a physical progress measure independent of duration."
    - name: "total_actual_units"
      expr: SUM(CAST(actual_units AS DOUBLE))
      comment: "Total actual units of work completed across all reporting periods. Feeds productivity rate and resource efficiency analysis."
    - name: "avg_total_float"
      expr: ROUND(AVG(CAST(total_float AS DOUBLE)), 2)
      comment: "Average total float across progress updates. Declining float over time is a leading indicator of schedule compression and end-date risk."
    - name: "critical_path_change_count"
      expr: COUNT(CASE WHEN is_critical_path_changed = TRUE THEN 1 END)
      comment: "Number of reporting periods where the critical path changed. Frequent changes signal schedule instability requiring executive attention."
    - name: "total_remaining_units"
      expr: SUM(CAST(remaining_units AS DOUBLE))
      comment: "Total remaining units of work to be completed. Used in completion forecasting and resource demand planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule resource capacity and cost metrics tracking availability, utilisation rates, and billing rates to support resource planning and cost optimisation decisions."
  source: "`vibe_construction_v1`.`schedule`.`resource`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource (e.g. Labor, Equipment, Material, Subcontractor) for resource category analysis."
    - name: "resource_status"
      expr: resource_status
      comment: "Current status of the resource (e.g. Active, Inactive, On Hold) for filtering available vs unavailable resources."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor classification of the resource for workforce cost and capacity analysis."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the resource (e.g. Foreman, Engineer, Operator) for role-based capacity and cost analysis."
    - name: "is_external"
      expr: is_external
      comment: "Indicates whether the resource is external (subcontractor/vendor) vs internal, enabling make-vs-buy cost analysis."
    - name: "is_overtime_allowed"
      expr: is_overtime_allowed
      comment: "Flags resources where overtime is permitted, relevant for schedule acceleration cost modelling."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month bucket of the resource effective start date for resource availability timeline analysis."
  measures:
    - name: "total_resources"
      expr: COUNT(1)
      comment: "Total number of schedule resources in the resource pool. Baseline for capacity planning and resource sufficiency analysis."
    - name: "avg_availability_percentage"
      expr: ROUND(AVG(CAST(availability_percentage AS DOUBLE)), 2)
      comment: "Average resource availability percentage across the resource pool. Low availability signals capacity constraints that may impact schedule delivery."
    - name: "avg_utilisation_rate"
      expr: ROUND(AVG(CAST(utilization_rate AS DOUBLE)), 2)
      comment: "Average resource utilisation rate. High utilisation (>90%) indicates over-allocation risk; low utilisation indicates inefficiency."
    - name: "avg_billing_rate_per_hour"
      expr: ROUND(AVG(CAST(billing_rate_per_hour AS DOUBLE)), 2)
      comment: "Average billing rate per hour across resources. Used to benchmark resource cost levels and identify pricing anomalies."
    - name: "total_max_units_per_period"
      expr: SUM(CAST(max_units_per_period AS DOUBLE))
      comment: "Total maximum resource units available per period across the resource pool. Represents the aggregate capacity ceiling for schedule loading."
    - name: "external_resource_count"
      expr: COUNT(CASE WHEN is_external = TRUE THEN 1 END)
      comment: "Number of external resources in the schedule resource pool. High external resource dependency increases supply chain and cost risk."
    - name: "external_resource_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_external = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule resources that are external. Executives use this to assess subcontractor dependency and associated delivery risk."
    - name: "avg_overtime_factor"
      expr: ROUND(AVG(CAST(overtime_factor AS DOUBLE)), 4)
      comment: "Average overtime cost multiplier across resources. Used in schedule acceleration cost modelling to estimate premium time costs."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule baseline governance metrics tracking baseline versions, approval status, and BCWS values to support baseline integrity and change control analysis."
  source: "`vibe_construction_v1`.`schedule`.`schedule_baseline`"
  dimensions:
    - name: "schedule_baseline_status"
      expr: schedule_baseline_status
      comment: "Status of the schedule baseline (e.g. Approved, Draft, Superseded) for filtering authoritative vs draft baselines."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (e.g. Original, Revised, Recovery) enabling analysis of baseline evolution and change history."
    - name: "is_current"
      expr: is_current
      comment: "Indicates whether this is the current approved baseline, ensuring metrics are computed against the authoritative schedule."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the baseline cost values for multi-currency project portfolio analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month bucket of the baseline approval date for tracking baseline change frequency over the project lifecycle."
    - name: "data_date_month"
      expr: DATE_TRUNC('MONTH', data_date)
      comment: "Month bucket of the baseline data date for time-series analysis of baseline snapshots."
  measures:
    - name: "total_baselines"
      expr: COUNT(1)
      comment: "Total number of schedule baselines. High counts indicate frequent re-baselining which may signal poor initial planning or scope instability."
    - name: "current_baseline_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of baselines flagged as current. Should be 1 per project; multiple current baselines indicate a data governance issue."
    - name: "approved_baseline_count"
      expr: COUNT(CASE WHEN schedule_baseline_status = 'Approved' THEN 1 END)
      comment: "Number of approved schedule baselines. Tracks the history of formally approved schedule versions for audit and governance purposes."
    - name: "total_bcws_amount"
      expr: SUM(CAST(bcws_amount AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled across all baselines. Represents the total planned value committed in approved baselines."
    - name: "avg_bcws_per_baseline"
      expr: ROUND(AVG(CAST(bcws_amount AS DOUBLE)), 2)
      comment: "Average BCWS per baseline version. Tracks how the planned value has evolved across baseline revisions, indicating scope growth or reduction."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule risk metrics tracking risk exposure, Monte Carlo probability dates, and mitigation status to support proactive schedule risk management."
  source: "`vibe_construction_v1`.`schedule`.`schedule_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the schedule risk (e.g. Design, Procurement, Weather, Regulatory) for root cause and category-level risk analysis."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the schedule risk (e.g. Open, Mitigated, Closed) for active risk portfolio management."
    - name: "priority"
      expr: priority
      comment: "Priority rating of the schedule risk (e.g. High, Medium, Low) for risk-stratified management attention."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating of the risk occurring, enabling likelihood-weighted risk analysis."
    - name: "response_type"
      expr: response_type
      comment: "Type of risk response strategy (e.g. Mitigate, Accept, Transfer) for response effectiveness analysis."
    - name: "owner_department"
      expr: owner_department
      comment: "Department responsible for managing the schedule risk, enabling accountability and escalation tracking."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month bucket of the risk assessment date for trend analysis of risk profile evolution over time."
  measures:
    - name: "total_schedule_risks"
      expr: COUNT(1)
      comment: "Total number of schedule risks identified. Baseline metric for risk register completeness and portfolio size."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open schedule risks. Executives monitor this to assess the current risk exposure level of the project schedule."
    - name: "high_priority_risk_count"
      expr: COUNT(CASE WHEN priority = 'High' THEN 1 END)
      comment: "Number of high-priority schedule risks. A key risk dashboard metric triggering executive review and mitigation investment decisions."
    - name: "avg_risk_score"
      expr: ROUND(AVG(CAST(score AS DOUBLE)), 2)
      comment: "Average risk score across all schedule risks. Tracks the overall risk severity level of the schedule risk register over time."
    - name: "total_risk_score"
      expr: SUM(CAST(score AS DOUBLE))
      comment: "Total aggregate risk score across all schedule risks. A portfolio-level risk exposure index used in project risk reporting."
    - name: "mitigated_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Mitigated' THEN 1 END)
      comment: "Number of schedule risks successfully mitigated. Tracks the effectiveness of the risk response programme."
    - name: "risk_mitigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_status = 'Mitigated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule risks that have been mitigated. A measure of risk management programme effectiveness for executive reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_wbs_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS node cost and schedule performance metrics enabling earned value analysis, budget variance tracking, and critical path monitoring at the work breakdown structure level."
  source: "`vibe_construction_v1`.`schedule`.`wbs_node`"
  dimensions:
    - name: "wbs_node_status"
      expr: wbs_node_status
      comment: "Current status of the WBS node (e.g. Active, Complete, On Hold) for filtering active vs completed work packages."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS node (e.g. Summary, Work Package, Control Account) enabling analysis at the appropriate WBS hierarchy level."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level of the WBS node for drill-down analysis from project summary to work package level."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the WBS node is on the critical path for focused cost and schedule monitoring of critical work."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the WBS node for risk-stratified work package management."
    - name: "earned_value_method"
      expr: earned_value_method
      comment: "EVM measurement method applied to the WBS node (e.g. 0/100, Milestone, % Complete) for EVM methodology analysis."
    - name: "change_order_indicator"
      expr: change_order_indicator
      comment: "Flags WBS nodes affected by change orders, enabling change-driven cost and schedule impact analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of the WBS node planned start date for time-phased work package analysis."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across all WBS nodes. The authoritative project budget baseline for cost performance measurement."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS nodes. Core cost tracking metric for project financial control at the WBS level."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across WBS nodes. Used as the BCWS baseline for earned value calculations."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(budgeted_cost AS DOUBLE)) - SUM(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Total cost variance (budget minus actual) across WBS nodes. Negative variance signals cost overrun requiring executive intervention."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(budgeted_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 4)
      comment: "WBS-level Cost Performance Index (budget/actual). CPI < 1.0 indicates cost overrun; a primary EVM KPI for project controls."
    - name: "avg_percent_complete"
      expr: ROUND(AVG(CAST(percent_complete AS DOUBLE)), 2)
      comment: "Average percent complete across WBS nodes. Provides a weighted view of overall project progress at the WBS level."
    - name: "critical_path_budgeted_cost"
      expr: SUM(CASE WHEN critical_path_flag = TRUE THEN budgeted_cost ELSE 0 END)
      comment: "Total budgeted cost for critical path WBS nodes. Quantifies the financial value of schedule-critical work packages."
    - name: "critical_path_actual_cost"
      expr: SUM(CASE WHEN critical_path_flag = TRUE THEN actual_cost ELSE 0 END)
      comment: "Total actual cost incurred on critical path WBS nodes. Enables focused cost control on schedule-driving work packages."
    - name: "change_order_affected_node_count"
      expr: COUNT(CASE WHEN change_order_indicator = TRUE THEN 1 END)
      comment: "Number of WBS nodes affected by change orders. High counts indicate scope instability with cost and schedule implications."
    - name: "high_risk_node_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of WBS nodes rated as high risk. A leading indicator of work packages likely to experience cost or schedule overruns."
$$;
