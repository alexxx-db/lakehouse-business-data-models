-- Metric views for domain: schedule | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Activity-level schedule performance metrics tracking completion rates, critical path exposure, and schedule progress across all project activities."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (e.g. Not Started, In Progress, Completed) used to segment performance metrics."
    - name: "activity_type"
      expr: activity_type
      comment: "Classification of the activity type (e.g. Construction, Procurement, Engineering) for cross-type performance comparison."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Boolean flag indicating whether the activity lies on the project critical path, enabling focused monitoring of schedule-critical work."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of the planned activity start date for time-series trending of scheduled workload."
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month bucket of the planned activity finish date for workload distribution analysis."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month bucket of the actual activity start date for comparing planned vs actual start timing."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of scheduling constraint applied to the activity (e.g. Start No Earlier Than, Finish No Later Than) for constraint impact analysis."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of activities in scope. Baseline denominator for all activity-level rate calculations."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Executives use this to gauge schedule risk concentration and prioritise resource allocation."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all activities in scope. Key indicator of overall schedule progress used in steering meetings and project reviews."
    - name: "total_percent_complete_sum"
      expr: SUM(CAST(percent_complete AS DOUBLE))
      comment: "Sum of percent complete values across activities. Used as the numerator when computing weighted completion rates at higher aggregation levels."
    - name: "critical_path_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE AND activity_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical-path activities that are fully completed. A leading indicator of on-time project delivery; a drop triggers immediate executive intervention."
    - name: "schedule_start_variance_days"
      expr: AVG(CAST(DATEDIFF(actual_start_date, planned_start_date) AS DOUBLE))
      comment: "Average number of days between planned and actual start dates (positive = late start). Directly measures schedule adherence at activity level and drives corrective action."
    - name: "schedule_finish_variance_days"
      expr: AVG(CAST(DATEDIFF(actual_finish_date, planned_finish_date) AS DOUBLE))
      comment: "Average number of days between planned and actual finish dates (positive = late finish). Core schedule performance KPI used in project steering reviews."
    - name: "activities_not_started_count"
      expr: COUNT(CASE WHEN activity_status = 'Not Started' THEN 1 END)
      comment: "Count of activities that have not yet started. Tracks backlog of unstarted work and informs resource mobilisation decisions."
    - name: "activities_in_progress_count"
      expr: COUNT(CASE WHEN activity_status = 'In Progress' THEN 1 END)
      comment: "Count of activities currently in progress. Measures active workload volume for capacity and resource planning."
    - name: "activities_completed_count"
      expr: COUNT(CASE WHEN activity_status = 'Completed' THEN 1 END)
      comment: "Count of fully completed activities. Tracks delivery throughput and is used to compute overall schedule completion rate."
    - name: "overall_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN activity_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all activities that are fully completed. Top-level schedule health KPI reported to project owners and executives."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment cost and quantity performance metrics tracking planned vs actual cost, cost efficiency, and resource utilisation across schedule activities."
  source: "`vibe_construction_v1`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (e.g. Labour, Equipment, Material) for cost and utilisation analysis by resource category."
    - name: "labor_category"
      expr: labor_category
      comment: "Labour category of the assigned resource (e.g. Skilled, Unskilled, Supervisory) for workforce cost breakdown."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the assigned resource (e.g. Foreman, Operator, Engineer) enabling role-level cost and productivity analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (e.g. Active, Completed, Cancelled) for filtering active vs closed assignments."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the resource assignment for governance and cost commitment tracking."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the assignment is on the critical path, enabling cost focus on schedule-critical resources."
    - name: "wbs_code"
      expr: wbs_code
      comment: "Work Breakdown Structure code for the assignment, enabling cost roll-up by WBS hierarchy."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of the assignment start date for time-phased cost and resource analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the resource quantity (e.g. Hours, Days, Units) for quantity-based performance analysis."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all resource assignments. Baseline budget figure used in cost performance and variance reporting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all resource assignments. Core cost tracking KPI for project financial control."
    - name: "total_remaining_cost"
      expr: SUM(CAST(remaining_cost AS DOUBLE))
      comment: "Total remaining cost to complete all resource assignments. Used in Estimate-at-Completion (EAC) forecasting and cash flow planning."
    - name: "cost_variance"
      expr: SUM((CAST(planned_cost AS DOUBLE)) - (CAST(actual_cost AS DOUBLE)))
      comment: "Aggregate cost variance (Planned minus Actual). Positive = under budget; negative = over budget. Primary cost performance KPI for executive dashboards."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 4)
      comment: "Cost Performance Index (Planned Cost / Actual Cost). CPI > 1 indicates under-budget performance; CPI < 1 triggers cost corrective action. Standard EVM KPI."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned resource quantity across assignments. Used as the baseline for quantity variance and productivity analysis."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual resource quantity consumed. Compared against planned quantity to measure resource productivity and efficiency."
    - name: "quantity_variance"
      expr: SUM((CAST(planned_quantity AS DOUBLE)) - (CAST(actual_quantity AS DOUBLE)))
      comment: "Aggregate quantity variance (Planned minus Actual). Positive = less resource consumed than planned; negative = overrun. Drives resource reallocation decisions."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_quantity AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime cost (overtime quantity × overtime rate) across all assignments. Tracks premium labour spend and informs workforce scheduling decisions."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per resource assignment. Used to benchmark resource pricing and identify rate anomalies across the project."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_cost > planned_cost THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resource assignments where actual cost exceeded planned cost. Measures cost discipline and triggers budget review when elevated."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline activity metrics tracking schedule and cost variance against the approved project baseline, supporting earned value management and schedule health reporting."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay event metrics tracking the frequency, duration, cost impact, and critical path exposure of schedule delays across the project portfolio."
  source: "`vibe_construction_v1`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category of the delay event (e.g. Weather, Design, Procurement, Labour) for root-cause analysis and trend monitoring."
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event (e.g. Open, Resolved, Under Review) for tracking resolution progress."
    - name: "event_type"
      expr: event_type
      comment: "Type of delay event for classification and reporting to project owners and executives."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the delay event (e.g. Low, Medium, High, Critical) for risk-weighted delay analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the delay event for prioritisation of mitigation actions."
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Flag indicating whether the delay event impacts the critical path, enabling focused executive attention on schedule-threatening delays."
    - name: "eot_claim_status"
      expr: eot_claim_status
      comment: "Status of the Extension of Time (EOT) claim associated with the delay event for contractual and legal tracking."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency code for the delay cost impact, enabling multi-currency cost impact reporting."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month bucket of the delay event approval date for time-series delay trend analysis."
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total number of delay events recorded. Baseline frequency metric for delay trend monitoring and benchmarking."
    - name: "critical_path_delay_count"
      expr: COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END)
      comment: "Number of delay events that impact the critical path. Directly measures schedule-threatening delays and triggers executive escalation."
    - name: "critical_path_delay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delay events that impact the critical path. Key risk KPI — a rising rate signals increasing schedule delivery risk."
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total financial cost impact of all delay events. Core cost risk KPI used in project financial reviews and insurance/claim assessments."
    - name: "avg_cost_impact_per_delay"
      expr: AVG(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Average cost impact per delay event. Benchmarks the financial severity of delays and informs contingency reserve adequacy."
    - name: "open_delay_event_count"
      expr: COUNT(CASE WHEN delay_event_status = 'Open' THEN 1 END)
      comment: "Number of currently open (unresolved) delay events. Tracks outstanding schedule risk exposure requiring active management."
    - name: "eot_claim_count"
      expr: COUNT(CASE WHEN eot_claim_status IS NOT NULL AND eot_claim_status != '' THEN 1 END)
      comment: "Number of delay events with an active Extension of Time claim. Tracks contractual exposure and legal risk for project leadership."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_lookahead_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lookahead planning metrics tracking Percent Plan Complete (PPC), readiness rates, and short-interval schedule reliability using Last Planner System principles."
  source: "`vibe_construction_v1`.`schedule`.`lookahead_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the lookahead plan (e.g. Draft, Approved, Closed) for filtering active planning cycles."
    - name: "readiness_status"
      expr: readiness_status
      comment: "Overall readiness status of the lookahead plan (e.g. Ready, Not Ready, Partially Ready) for constraint resolution tracking."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Flag indicating whether the lookahead plan includes critical path activities, enabling focused reliability analysis."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of constraint blocking plan readiness (e.g. Material, Labour, Equipment, Design) for constraint root-cause analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the lookahead plan for risk-weighted schedule reliability analysis."
    - name: "work_front"
      expr: work_front
      comment: "Work front or zone associated with the lookahead plan for spatial schedule performance analysis."
    - name: "zone_code"
      expr: zone_code
      comment: "Zone code for the lookahead plan enabling geographic or sectional schedule performance breakdown."
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month bucket of the lookahead plan date for time-series PPC trend analysis."
    - name: "is_lps_enabled"
      expr: is_lps_enabled
      comment: "Flag indicating whether Last Planner System is enabled for this plan, enabling LPS vs non-LPS performance comparison."
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Flag indicating whether weather impacted the lookahead plan, enabling weather-adjusted PPC analysis."
  measures:
    - name: "avg_ppc_actual_percent"
      expr: AVG(CAST(ppc_actual_percent AS DOUBLE))
      comment: "Average actual Percent Plan Complete (PPC) across lookahead plans. The primary Last Planner System KPI measuring short-interval schedule reliability. Industry benchmark is 80%+."
    - name: "avg_ppc_target_percent"
      expr: AVG(CAST(ppc_target_percent AS DOUBLE))
      comment: "Average target PPC across lookahead plans. Used alongside actual PPC to measure performance against planning commitments."
    - name: "ppc_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppc_actual_percent >= ppc_target_percent THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans where actual PPC met or exceeded the target PPC. Measures planning reliability and commitment fulfilment rate."
    - name: "avg_percent_plan_complete"
      expr: AVG(CAST(percent_plan_complete AS DOUBLE))
      comment: "Average overall percent plan complete across all lookahead plans. Tracks short-interval schedule progress and is a leading indicator of project delivery performance."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all lookahead plans. Used to track near-term cost commitments and cash flow requirements."
    - name: "crew_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN crew_ready_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans where crew is confirmed ready. Measures workforce mobilisation effectiveness and is a leading indicator of PPC performance."
    - name: "material_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN material_ready_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans where materials are confirmed ready. Tracks supply chain reliability as a constraint on schedule execution."
    - name: "equipment_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN equipment_ready_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans where equipment is confirmed ready. Measures equipment availability as a constraint on planned work execution."
    - name: "fully_ready_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN crew_ready_flag = TRUE AND material_ready_flag = TRUE AND equipment_ready_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans where crew, material, and equipment are all confirmed ready. Composite readiness KPI — the strongest predictor of PPC achievement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule progress and earned value metrics tracking SPI, schedule variance, forecast completion, and critical path health across reporting periods."
  source: "`vibe_construction_v1`.`schedule`.`progress_update`"
  dimensions:
    - name: "progress_update_status"
      expr: progress_update_status
      comment: "Status of the progress update record (e.g. Draft, Submitted, Approved) for filtering authoritative reporting data."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of the progress update (e.g. Weekly, Bi-Weekly, Monthly) for time-series analysis at the correct reporting cadence."
    - name: "reporting_status"
      expr: reporting_status
      comment: "Reporting status of the progress update for data quality and completeness monitoring."
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Flag indicating whether the critical path changed in this reporting period. A critical path change is a high-priority alert for project leadership."
    - name: "path_drift_indicator"
      expr: path_drift_indicator
      comment: "Indicator of critical path drift direction (e.g. Ahead, On Track, Behind) for schedule health classification."
    - name: "update_source"
      expr: update_source
      comment: "Source system or method of the progress update (e.g. P6, Manual, MS Project) for data provenance and quality tracking."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month bucket of the reporting period start date for time-series schedule performance trending."
    - name: "reporting_date_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month bucket of the reporting date for aligning progress metrics to calendar periods."
  measures:
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI = BCWP / BCWS) across progress updates. SPI < 1 indicates schedule slippage; the primary EVM schedule health KPI for executive dashboards."
    - name: "avg_sv"
      expr: AVG(CAST(sv AS DOUBLE))
      comment: "Average Schedule Variance (SV = BCWP - BCWS) in cost units. Negative SV indicates behind-schedule performance and triggers corrective action."
    - name: "avg_sv_percent"
      expr: AVG(CAST(sv_percent AS DOUBLE))
      comment: "Average Schedule Variance percentage. Normalised SPI metric enabling cross-project schedule performance comparison."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) across all progress updates. Core EVM metric measuring the value of work actually accomplished."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value) across all progress updates. Baseline against which earned value is measured."
    - name: "avg_percent_complete_duration"
      expr: AVG(CAST(percent_complete_duration AS DOUBLE))
      comment: "Average duration-based percent complete across progress updates. Measures schedule progress by elapsed duration and is used in schedule health reporting."
    - name: "avg_percent_complete_units"
      expr: AVG(CAST(percent_complete_units AS DOUBLE))
      comment: "Average units-based percent complete across progress updates. Measures physical progress by resource units consumed, complementing duration-based completion."
    - name: "avg_total_float_days"
      expr: AVG(CAST(total_float AS DOUBLE))
      comment: "Average total float (schedule buffer) across progress updates. Declining float is an early warning of schedule risk and triggers proactive management action."
    - name: "critical_path_change_count"
      expr: COUNT(CASE WHEN is_critical_path_changed = TRUE THEN 1 END)
      comment: "Number of reporting periods where the critical path changed. Frequent critical path changes indicate schedule instability and elevated delivery risk."
    - name: "below_spi_threshold_count"
      expr: COUNT(CASE WHEN spi < 0.9 THEN 1 END)
      comment: "Number of progress updates where SPI fell below 0.9 (industry alert threshold). Tracks frequency of significant schedule underperformance requiring executive intervention."
    - name: "total_remaining_units"
      expr: SUM(CAST(remaining_units AS DOUBLE))
      comment: "Total remaining resource units to complete all in-scope activities. Used in resource demand forecasting and Estimate-to-Complete calculations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource capacity, cost, and utilisation metrics supporting workforce and equipment planning decisions across the project schedule."
  source: "`vibe_construction_v1`.`schedule`.`resource`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource (e.g. Labour, Equipment, Material, Subcontractor) for resource portfolio analysis."
    - name: "resource_status"
      expr: resource_status
      comment: "Current status of the resource (e.g. Active, Inactive, On Hold) for filtering available resources."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the resource (e.g. Foreman, Operator, Engineer) for role-level capacity and cost analysis."
    - name: "labor_category"
      expr: labor_category
      comment: "Labour category of the resource for workforce cost and capacity planning."
    - name: "is_external"
      expr: is_external
      comment: "Flag indicating whether the resource is external (subcontractor/rental) vs internal, enabling make-vs-buy cost analysis."
    - name: "procurement_source"
      expr: procurement_source
      comment: "Procurement source of the resource (e.g. Direct Hire, Subcontract, Rental) for supply chain and cost strategy analysis."
    - name: "site_location"
      expr: site_location
      comment: "Site location of the resource for geographic resource distribution and mobilisation planning."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the resource (e.g. Hours, Days, Units) for quantity-based capacity analysis."
  measures:
    - name: "total_resources"
      expr: COUNT(1)
      comment: "Total number of resources in the resource pool. Baseline capacity metric for resource planning and availability analysis."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average resource availability percentage across the resource pool. Measures overall capacity availability and informs resource allocation decisions."
    - name: "avg_utilisation_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average resource utilisation rate across the pool. High utilisation indicates capacity constraints; low utilisation indicates idle resource cost. Key efficiency KPI."
    - name: "avg_billing_rate_per_hour"
      expr: AVG(CAST(billing_rate_per_hour AS DOUBLE))
      comment: "Average billing rate per hour across resources. Used to benchmark resource cost levels and identify pricing anomalies."
    - name: "total_max_units_per_period"
      expr: SUM(CAST(max_units_per_period AS DOUBLE))
      comment: "Total maximum resource units available per period across the resource pool. Measures aggregate capacity ceiling for schedule feasibility analysis."
    - name: "external_resource_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_external = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resources that are external (subcontract/rental). Tracks external dependency exposure and informs make-vs-buy strategy decisions."
    - name: "avg_overtime_factor"
      expr: AVG(CAST(overtime_factor AS DOUBLE))
      comment: "Average overtime factor across resources. Used to estimate overtime cost premiums in schedule acceleration scenarios."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across resources. Benchmarks resource unit cost for budget estimation and procurement negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule baseline governance metrics tracking baseline version history, budget alignment, and schedule duration across approved project baselines."
  source: "`vibe_construction_v1`.`schedule`.`schedule_baseline`"
  dimensions:
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of schedule baseline (e.g. Original, Revised, Contract) for baseline version and change history analysis."
    - name: "schedule_baseline_status"
      expr: schedule_baseline_status
      comment: "Current status of the schedule baseline (e.g. Approved, Draft, Superseded) for filtering authoritative baselines."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating whether this is the current approved baseline, enabling current vs historical baseline comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the baseline budget values, enabling multi-currency baseline cost analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month bucket of the baseline approval date for tracking baseline change frequency over time."
    - name: "data_date_month"
      expr: DATE_TRUNC('MONTH', data_date)
      comment: "Month bucket of the baseline data date for time-phased baseline performance analysis."
  measures:
    - name: "total_baselines"
      expr: COUNT(1)
      comment: "Total number of schedule baselines. Tracks baseline revision frequency — excessive revisions indicate scope instability and schedule management issues."
    - name: "current_baseline_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of baselines marked as current. Should be 1 per project; deviations indicate data governance issues requiring correction."
    - name: "total_bcws_amount"
      expr: SUM(CAST(bcws_amount AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled across all baselines. Aggregate planned value metric used in portfolio-level EVM reporting."
    - name: "avg_bcws_amount"
      expr: AVG(CAST(bcws_amount AS DOUBLE))
      comment: "Average BCWS amount per baseline. Used to benchmark planned value sizing across projects and baseline versions."
    - name: "baseline_revision_count"
      expr: COUNT(CASE WHEN baseline_type != 'Original' THEN 1 END)
      comment: "Number of non-original (revised) baselines. A high revision count signals scope instability, change order volume, or schedule management challenges."
    - name: "approved_baseline_count"
      expr: COUNT(CASE WHEN schedule_baseline_status = 'Approved' THEN 1 END)
      comment: "Number of approved schedule baselines. Tracks governance compliance — all active projects should have at least one approved baseline."
$$;