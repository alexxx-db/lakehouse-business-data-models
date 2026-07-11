-- Metric views for domain: schedule | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core schedule activity performance metrics tracking critical path exposure, float consumption, schedule adherence, and completion rates across project activities. Used by project controls teams and executives to assess schedule health and identify at-risk work."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (Not Started, In Progress, Complete, On Hold) for filtering and grouping schedule health views."
    - name: "activity_type"
      expr: activity_type
      comment: "Classification of the activity type (Task, Milestone, WBS Summary, Level of Effort) to segment performance by work category."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the activity lies on the critical path, enabling executives to focus on schedule-driving work."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of scheduling constraint applied (ASAP, ALAP, MFO, MSO, etc.) to identify constrained activities that may limit float."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned start date for time-series trending of scheduled work volume."
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month bucket of planned finish date for workload distribution analysis."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month bucket of actual start date for comparing planned vs actual start timing."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of schedule activities. Baseline denominator for all activity-level rate calculations."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Executives use this to gauge schedule risk concentration and resource prioritization needs."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across all activities. Key indicator of overall schedule progress used in steering meetings and project reviews."
    - name: "critical_path_activity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities on the critical path. High values indicate a fragile schedule with limited float buffer, triggering risk escalation."
    - name: "activities_not_started"
      expr: COUNT(CASE WHEN activity_status = 'Not Started' AND planned_start_date <= CURRENT_DATE() THEN 1 END)
      comment: "Count of activities that should have started (planned start in the past) but have not yet begun. Direct indicator of schedule slippage requiring management intervention."
    - name: "activities_completed"
      expr: COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END)
      comment: "Count of completed activities. Used to track schedule throughput and compare against planned completion curves."
    - name: "schedule_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities marked complete. Core schedule performance KPI reported at project steering meetings and board reviews."
    - name: "activities_with_constraint"
      expr: COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type <> '' THEN 1 END)
      comment: "Number of activities with scheduling constraints applied. Excessive constraints reduce schedule flexibility and increase risk of cascading delays."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) and schedule performance metrics derived from periodic progress updates. Provides SPI, SV, and forecast accuracy KPIs used by project controls, PMO, and executive leadership to assess schedule health and predict completion."
  source: "`vibe_construction_v1`.`schedule`.`progress_update`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project schedule performance comparison and portfolio-level reporting."
    - name: "reporting_date"
      expr: reporting_date
      comment: "Date of the progress update for time-series trending of schedule performance indicators."
    - name: "reporting_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month bucket of reporting date for monthly schedule performance trend analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of progress reporting (Weekly, Bi-Weekly, Monthly) to contextualize update cadence and data freshness."
    - name: "progress_update_status"
      expr: progress_update_status
      comment: "Status of the progress update record (Draft, Submitted, Approved) for filtering to approved data only."
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Flag indicating whether the critical path changed in this update period. Critical path changes are high-priority events requiring executive attention."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month bucket of reporting period start for aligning EVM metrics to calendar periods."
  measures:
    - name: "total_progress_updates"
      expr: COUNT(1)
      comment: "Total number of progress update records. Baseline measure for update frequency and coverage analysis."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index (BCWP/BCWS) across updates. SPI < 1.0 signals schedule underperformance; used by PMO and executives to trigger corrective action."
    - name: "avg_sv"
      expr: AVG(CAST(sv AS DOUBLE))
      comment: "Average Schedule Variance (BCWP - BCWS) in currency units. Negative SV indicates work is behind plan; a primary EVM KPI for project steering meetings."
    - name: "avg_sv_percent"
      expr: AVG(CAST(sv_percent AS DOUBLE))
      comment: "Average Schedule Variance as a percentage of BCWS. Normalizes SV across projects of different sizes for portfolio-level comparison."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) across all updates. Core EVM metric representing the value of work actually accomplished."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value) across all updates. Represents the planned value of work that should have been completed."
    - name: "avg_percent_complete_duration"
      expr: AVG(CAST(percent_complete_duration AS DOUBLE))
      comment: "Average duration-based percent complete across updates. Measures schedule progress by time consumed vs planned duration."
    - name: "avg_percent_complete_units"
      expr: AVG(CAST(percent_complete_units AS DOUBLE))
      comment: "Average units-based percent complete across updates. Measures schedule progress by physical quantities installed vs planned."
    - name: "avg_total_float"
      expr: AVG(CAST(total_float AS DOUBLE))
      comment: "Average total float remaining across progress updates. Declining float signals increasing schedule risk and potential critical path shifts."
    - name: "critical_path_change_count"
      expr: COUNT(CASE WHEN is_critical_path_changed = TRUE THEN 1 END)
      comment: "Number of updates where the critical path changed. Frequent critical path changes indicate schedule instability requiring executive intervention."
    - name: "critical_path_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_path_changed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reporting periods where the critical path changed. High rates signal schedule volatility and poor baseline quality."
    - name: "avg_remaining_units"
      expr: AVG(CAST(remaining_units AS DOUBLE))
      comment: "Average remaining work units across updates. Tracks work-to-complete trajectory for resource planning and schedule recovery assessment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule baseline governance metrics tracking baseline versions, approval status, and schedule duration commitments. Used by PMO and project directors to manage baseline integrity and assess the frequency and impact of baseline revisions."
  source: "`vibe_construction_v1`.`schedule`.`schedule_baseline`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for comparing baseline management practices across projects."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (Original, Revised, Recovery, Contractual) to distinguish planned vs recovery schedules."
    - name: "schedule_baseline_status"
      expr: schedule_baseline_status
      comment: "Approval status of the baseline (Draft, Submitted, Approved, Superseded) for filtering to active baselines."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating the currently active baseline for each project. Enables filtering to current vs historical baselines."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of baseline approval for tracking baseline revision frequency over time."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year of baseline start date for multi-year project portfolio analysis."
  measures:
    - name: "total_baselines"
      expr: COUNT(1)
      comment: "Total number of schedule baselines. High counts per project indicate frequent re-baselining, which may signal poor initial planning or scope instability."
    - name: "approved_baselines"
      expr: COUNT(CASE WHEN schedule_baseline_status = 'Approved' THEN 1 END)
      comment: "Number of approved baselines. Governance metric ensuring only formally approved baselines are used for performance measurement."
    - name: "current_baselines"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of baselines flagged as current. Should be 1 per project; values > 1 indicate a data quality issue requiring immediate correction."
    - name: "avg_total_bcws"
      expr: AVG(CAST(bcws_amount AS DOUBLE))
      comment: "Average Budgeted Cost of Work Scheduled (planned value) across baselines. Represents the financial scale of schedule commitments for portfolio sizing."
    - name: "total_bcws_committed"
      expr: SUM(CAST(bcws_amount AS DOUBLE))
      comment: "Total planned value committed across all baselines. Portfolio-level measure of scheduled work value used in executive financial reviews."
    - name: "revised_baseline_count"
      expr: COUNT(CASE WHEN baseline_type <> 'Original' THEN 1 END)
      comment: "Number of non-original (revised/recovery) baselines. Elevated counts signal scope instability or poor schedule management, triggering PMO review."
    - name: "baseline_revision_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN baseline_type <> 'Original' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of baselines that are revisions rather than originals. High rates indicate chronic re-baselining, a key schedule governance risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule milestone performance metrics tracking on-time delivery, variance, and liquidated damages exposure. Critical for contract compliance monitoring, client reporting, and executive decision-making on schedule recovery investments."
  source: "`vibe_construction_v1`.`schedule`.`schedule_milestone`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project milestone performance comparison."
    - name: "schedule_milestone_status"
      expr: schedule_milestone_status
      comment: "Current status of the milestone (Not Started, In Progress, Achieved, At Risk, Delayed) for operational filtering."
    - name: "schedule_milestone_type"
      expr: schedule_milestone_type
      comment: "Type of milestone (Contractual, Internal, Payment, Regulatory) to prioritize contractual milestones with LD exposure."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the milestone is on the critical path, focusing executive attention on schedule-driving deliverables."
    - name: "ld_exposure_flag"
      expr: ld_exposure_flag
      comment: "Indicates whether the milestone carries liquidated damages exposure. LD milestones require priority monitoring and recovery planning."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the milestone (Low, Medium, High, Critical) for risk-stratified performance reporting."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month bucket of planned milestone date for time-series milestone delivery analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of schedule milestones. Baseline denominator for milestone performance rate calculations."
    - name: "milestones_achieved"
      expr: COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones successfully achieved. Core delivery KPI reported to clients and executives."
    - name: "milestone_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieved. Primary schedule delivery KPI for board and client reporting; below-target rates trigger recovery plan requirements."
    - name: "milestones_with_ld_exposure"
      expr: COUNT(CASE WHEN ld_exposure_flag = TRUE THEN 1 END)
      comment: "Number of milestones carrying liquidated damages exposure. Executives use this to quantify contractual penalty risk and prioritize recovery resources."
    - name: "ld_exposure_milestone_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ld_exposure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones with LD exposure. High rates indicate significant contractual risk concentration requiring executive attention."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Total daily liquidated damages rate across all LD-exposed milestones. Quantifies the maximum daily financial penalty if all LD milestones are delayed."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average daily LD rate per milestone. Used to benchmark contractual penalty exposure against industry norms and project value."
    - name: "milestones_at_risk_or_delayed"
      expr: COUNT(CASE WHEN schedule_milestone_status IN ('At Risk', 'Delayed') THEN 1 END)
      comment: "Number of milestones currently at risk or delayed. Immediate action trigger for project directors and executives to mobilize recovery resources."
    - name: "critical_path_milestones"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of milestones on the critical path. These milestones directly determine project completion date and carry the highest schedule risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay event analysis metrics quantifying schedule disruption frequency, cost impact, and EOT claim status. Used by project directors, commercial managers, and executives to manage delay risk, support EOT claims, and assess contractor/vendor accountability."
  source: "`vibe_construction_v1`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category of delay (Weather, Design, Procurement, Regulatory, Client, Contractor) for root cause analysis and accountability attribution."
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event (Open, Under Review, Approved, Rejected, Closed) for pipeline management."
    - name: "event_type"
      expr: event_type
      comment: "Type of delay event (Force Majeure, Excusable, Compensable, Non-Excusable) for contractual entitlement classification."
    - name: "eot_claim_status"
      expr: eot_claim_status
      comment: "Status of the associated EOT claim (Not Submitted, Submitted, Approved, Rejected) for commercial claim pipeline tracking."
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Indicates whether the delay event impacts the critical path. Critical path delays directly affect project completion and LD exposure."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the delay (Minor, Moderate, Major, Critical) for risk-stratified reporting."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month bucket of delay event start for time-series delay frequency trending."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of cost impact amounts for multi-currency project portfolio analysis."
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total number of delay events recorded. Baseline measure for delay frequency analysis and trend monitoring."
    - name: "critical_path_delay_count"
      expr: COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END)
      comment: "Number of delay events impacting the critical path. These directly threaten project completion date and LD exposure, requiring executive escalation."
    - name: "critical_path_delay_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delay events that impact the critical path. High rates indicate systemic schedule risk requiring strategic intervention."
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total financial cost impact of all delay events. Key commercial KPI for quantifying delay-related losses and supporting EOT/compensation claims."
    - name: "avg_cost_impact_per_event"
      expr: AVG(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Average cost impact per delay event. Benchmarks delay severity and informs contingency reserve adequacy assessments."
    - name: "open_delay_events"
      expr: COUNT(CASE WHEN delay_event_status = 'Open' THEN 1 END)
      comment: "Number of unresolved delay events. Large backlogs indicate inadequate delay management processes and growing commercial risk."
    - name: "eot_claim_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eot_claim_status <> 'Not Submitted' AND eot_claim_status IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delay events for which an EOT claim has been submitted. Low rates may indicate missed contractual entitlements, a commercial risk."
    - name: "approved_eot_events"
      expr: COUNT(CASE WHEN eot_claim_status = 'Approved' THEN 1 END)
      comment: "Number of delay events with approved EOT claims. Measures commercial recovery success and validates the quality of delay documentation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Extension of Time (EOT) claim metrics tracking claim volumes, approval rates, and extension days secured. Used by commercial managers and executives to manage contractual entitlements, assess claim success rates, and quantify schedule relief obtained."
  source: "`vibe_construction_v1`.`schedule`.`schedule_eot_claim`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project EOT claim performance comparison."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (Submitted, Under Review, Approved, Rejected, Withdrawn) for pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (Excusable, Compensable, Force Majeure) for contractual entitlement classification."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the claimed delay is on the critical path, which is a prerequisite for most EOT entitlements."
    - name: "claim_submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_date)
      comment: "Month of claim submission for tracking claim filing cadence and identifying periods of high schedule disruption."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of claim approval for tracking resolution cycle times and commercial team performance."
  measures:
    - name: "total_eot_claims"
      expr: COUNT(1)
      comment: "Total number of EOT claims submitted. High volumes indicate significant schedule disruption and active commercial management requirements."
    - name: "approved_eot_claims"
      expr: COUNT(CASE WHEN claim_status = 'Approved' THEN 1 END)
      comment: "Number of approved EOT claims. Measures commercial recovery success and the effectiveness of the claims management process."
    - name: "eot_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOT claims approved. Low approval rates may indicate poor claim substantiation or adversarial client relationships requiring executive attention."
    - name: "rejected_eot_claims"
      expr: COUNT(CASE WHEN claim_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected EOT claims. High rejection rates signal documentation quality issues or contractual entitlement gaps."
    - name: "critical_path_eot_claims"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of EOT claims asserting critical path impact. These are the highest-value claims as they directly support schedule extension entitlement."
    - name: "pending_eot_claims"
      expr: COUNT(CASE WHEN claim_status IN ('Submitted', 'Under Review') THEN 1 END)
      comment: "Number of EOT claims currently pending resolution. Large pending backlogs represent unresolved commercial risk and potential LD exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule risk register metrics quantifying risk exposure, probability-weighted impacts, and Monte Carlo simulation outcomes. Used by risk managers, project directors, and executives to assess schedule contingency adequacy and prioritize risk mitigation investments."
  source: "`vibe_construction_v1`.`schedule`.`schedule_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of schedule risk (Design, Procurement, Weather, Regulatory, Resource, External) for root cause analysis and mitigation planning."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (Open, Mitigated, Closed, Realized) for active risk portfolio management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the risk (Critical, High, Medium, Low) for executive attention and resource allocation decisions."
    - name: "response_type"
      expr: response_type
      comment: "Risk response strategy (Avoid, Mitigate, Transfer, Accept) for assessing the adequacy of risk treatment plans."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating of the risk occurring (Very Low, Low, Medium, High, Very High) for risk matrix analysis."
    - name: "owner_department"
      expr: owner_department
      comment: "Department responsible for managing the risk for accountability and escalation routing."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of risk assessment for tracking risk register evolution over time."
  measures:
    - name: "total_schedule_risks"
      expr: COUNT(1)
      comment: "Total number of schedule risks in the register. Baseline measure for risk portfolio size and management workload."
    - name: "open_schedule_risks"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open (unresolved) schedule risks. Large open risk counts indicate unmitigated schedule exposure requiring executive attention."
    - name: "high_priority_risks"
      expr: COUNT(CASE WHEN priority IN ('Critical', 'High') THEN 1 END)
      comment: "Number of high or critical priority schedule risks. These risks require immediate mitigation action and executive oversight."
    - name: "high_priority_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority IN ('Critical', 'High') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule risks rated high or critical priority. Elevated rates signal a high-risk schedule environment requiring contingency investment."
    - name: "avg_risk_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average risk score across all schedule risks. Composite measure of probability and impact used to benchmark schedule risk exposure across projects."
    - name: "total_risk_score"
      expr: SUM(CAST(score AS DOUBLE))
      comment: "Total aggregate risk score for the schedule risk register. Portfolio-level measure of cumulative schedule risk exposure."
    - name: "realized_risks"
      expr: COUNT(CASE WHEN risk_status = 'Realized' THEN 1 END)
      comment: "Number of risks that have materialized into actual schedule impacts. Used to validate risk model accuracy and improve future risk assessments."
    - name: "risk_realization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_status = 'Realized' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of identified risks that were realized. High rates indicate either poor risk mitigation effectiveness or systematic underestimation of risk probability."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule resource capacity and cost metrics tracking utilization rates, billing rates, and resource availability. Used by resource managers and project directors to optimize resource allocation, identify bottlenecks, and control resource costs."
  source: "`vibe_construction_v1`.`schedule`.`resource`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource (Labor, Equipment, Material, Subcontractor) for resource category analysis and cost allocation."
    - name: "resource_status"
      expr: resource_status
      comment: "Current status of the resource (Active, Inactive, On Leave, Terminated) for filtering to available resources."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category classification (Skilled, Unskilled, Supervisory, Professional) for workforce cost analysis."
    - name: "is_external"
      expr: is_external
      comment: "Indicates whether the resource is external (subcontractor/vendor) vs internal. Drives make-vs-buy analysis and cost benchmarking."
    - name: "is_overtime_allowed"
      expr: is_overtime_allowed
      comment: "Indicates whether overtime is permitted for this resource. Used in schedule recovery planning to identify resources available for acceleration."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the resource (Foreman, Engineer, Operator, etc.) for skills-based resource planning."
    - name: "material_category"
      expr: material_category
      comment: "Material category for material resources, enabling material cost and consumption analysis by category."
  measures:
    - name: "total_resources"
      expr: COUNT(1)
      comment: "Total number of resources in the schedule resource pool. Baseline measure for resource capacity planning."
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average resource utilization rate across all resources. Low utilization indicates idle capacity waste; high utilization signals overallocation risk and burnout."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average resource availability percentage. Declining availability signals capacity constraints that may delay scheduled activities."
    - name: "avg_billing_rate_per_hour"
      expr: AVG(CAST(billing_rate_per_hour AS DOUBLE))
      comment: "Average billing rate per hour across resources. Used for budget forecasting and benchmarking resource cost competitiveness."
    - name: "total_billing_rate_capacity"
      expr: SUM(CAST(billing_rate_per_hour AS DOUBLE))
      comment: "Total billing rate capacity across all resources. Represents the maximum hourly cost exposure if all resources are fully deployed."
    - name: "avg_overtime_factor"
      expr: AVG(CAST(overtime_factor AS DOUBLE))
      comment: "Average overtime cost multiplier across resources. Used to estimate the cost premium of schedule acceleration through overtime."
    - name: "avg_max_units_per_period"
      expr: AVG(CAST(max_units_per_period AS DOUBLE))
      comment: "Average maximum resource units available per period. Capacity ceiling metric used in resource leveling and schedule optimization."
    - name: "external_resource_count"
      expr: COUNT(CASE WHEN is_external = TRUE THEN 1 END)
      comment: "Number of external (subcontractor/vendor) resources. High external resource dependency increases supply chain risk and cost volatility."
    - name: "external_resource_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_external = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resources that are external. High rates indicate significant subcontractor dependency, a key risk and cost management concern."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_lookahead_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last Planner System (LPS) and lookahead planning metrics tracking Percent Plan Complete (PPC), readiness rates, and constraint management. Used by site managers and project directors to drive reliable weekly work planning and identify systemic constraint patterns."
  source: "`vibe_construction_v1`.`schedule`.`lookahead_plan`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project LPS performance comparison."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the lookahead plan (Draft, Active, Completed, Archived) for filtering to active planning cycles."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of constraint blocking planned activities (Design, Procurement, Permit, Resource, Access) for constraint root cause analysis."
    - name: "is_lps_enabled"
      expr: is_lps_enabled
      comment: "Indicates whether the Last Planner System is enabled for this plan. Used to track LPS adoption rates across projects."
    - name: "plan_date_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month bucket of plan date for time-series PPC trending and seasonal pattern analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the lookahead plan (Low, Medium, High) for risk-stratified planning performance analysis."
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Indicates whether weather is a constraint in this planning period. Used to separate weather-driven non-completions from controllable failures."
  measures:
    - name: "total_lookahead_plans"
      expr: COUNT(1)
      comment: "Total number of lookahead plans. Baseline measure for planning cadence and LPS process adherence."
    - name: "avg_ppc_actual"
      expr: AVG(CAST(ppc_actual_percent AS DOUBLE))
      comment: "Average actual Percent Plan Complete (PPC) across all lookahead plans. The primary LPS KPI; industry benchmark is 70%+. Below-target PPC triggers root cause analysis and process improvement."
    - name: "avg_ppc_target"
      expr: AVG(CAST(ppc_target_percent AS DOUBLE))
      comment: "Average target PPC across lookahead plans. Used to assess whether PPC targets are realistic and aligned with project performance expectations."
    - name: "avg_planned_cost"
      expr: AVG(CAST(planned_cost AS DOUBLE))
      comment: "Average planned cost per lookahead period. Used to track planned expenditure cadence and compare against actual cost burn rates."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all lookahead plans. Represents the near-term cost commitment pipeline for cash flow forecasting."
    - name: "avg_percent_plan_complete"
      expr: AVG(CAST(percent_plan_complete AS DOUBLE))
      comment: "Average overall percent plan complete across lookahead plans. Tracks cumulative planning reliability as a leading indicator of schedule performance."
    - name: "plans_with_constraints"
      expr: COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type <> '' THEN 1 END)
      comment: "Number of lookahead plans with active constraints. High constraint rates indicate systemic planning reliability issues requiring upstream process intervention."
    - name: "constraint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans with active constraints. Elevated rates signal that prerequisite work (design, procurement, permits) is not being completed ahead of construction, a key schedule risk."
    - name: "lps_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lps_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans using the Last Planner System. Tracks LPS implementation progress across the project portfolio, a leading indicator of schedule reliability improvement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_wbs_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS node cost and schedule performance metrics tracking earned value, budget adherence, and critical path exposure at the work breakdown structure level. Used by project controls and executives for hierarchical project performance reporting and cost-at-completion forecasting."
  source: "`vibe_construction_v1`.`schedule`.`wbs_node`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project WBS performance comparison."
    - name: "wbs_node_status"
      expr: wbs_node_status
      comment: "Current status of the WBS node (Active, Complete, On Hold, Cancelled) for filtering to active work packages."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS node (Summary, Work Package, Control Account) for hierarchical performance analysis."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Level of the WBS node in the hierarchy for drill-down analysis from summary to work package level."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the WBS node is on the critical path for prioritized performance monitoring."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Indicates whether the WBS node represents a milestone for milestone-specific performance tracking."
    - name: "change_order_indicator"
      expr: change_order_indicator
      comment: "Indicates whether the WBS node has associated change orders, flagging scope-changed work packages for variance analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned start date for time-phased WBS performance analysis."
  measures:
    - name: "total_wbs_nodes"
      expr: COUNT(1)
      comment: "Total number of WBS nodes. Baseline measure for WBS structure complexity and management overhead."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across all WBS nodes. Represents the total authorized budget for the project scope, a primary financial control metric."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across WBS nodes. Represents the time-phased cost plan used as the performance measurement baseline."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS nodes. Core financial performance metric compared against budget and earned value."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across WBS nodes. Measures overall project progress for executive status reporting."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(budgeted_cost AS DOUBLE)))
      comment: "Total cost variance (Actual Cost minus Budget) across WBS nodes. Negative values indicate cost overrun; a primary financial KPI for executive review."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of budget consumed by actual costs. Values approaching or exceeding 100% trigger cost-at-completion forecasting and corrective action."
    - name: "critical_path_node_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of WBS nodes on the critical path. Used to assess schedule risk concentration and prioritize resource allocation."
    - name: "change_order_node_count"
      expr: COUNT(CASE WHEN change_order_indicator = TRUE THEN 1 END)
      comment: "Number of WBS nodes with associated change orders. High counts indicate significant scope change activity requiring commercial management attention."
    - name: "change_order_node_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_order_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WBS nodes affected by change orders. Elevated rates signal scope instability and potential budget overrun risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment cost and performance metrics tracking planned vs actual cost, quantity variances, and overtime utilization across schedule activities. Used by project controls and resource managers to optimize resource deployment and control labor and equipment costs."
  source: "`vibe_construction_v1`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of assigned resource (Labor, Equipment, Material, Subcontractor) for cost category analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (Planned, Active, Complete, Cancelled) for filtering to active assignments."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the assignment (Pending, Approved, Rejected) for governance and cost commitment tracking."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category of the assigned resource for workforce cost analysis by skill level."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the assigned resource for skills-based cost and utilization analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the assignment is on the critical path for prioritized resource management."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of assignment start date for time-phased resource cost trending."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the resource assignment (Compliant, Non-Compliant, Pending Review) for regulatory and contractual compliance monitoring."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of resource assignments. Baseline measure for resource deployment volume and schedule loading."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all resource assignments. Represents the budgeted resource cost for scheduled activities."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across resource assignments. Core cost performance metric compared against planned cost."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(planned_cost AS DOUBLE)))
      comment: "Total cost variance (Actual minus Planned) across resource assignments. Negative values indicate cost overrun; triggers corrective action in project reviews."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 4)
      comment: "Cost Performance Index (Planned Cost / Actual Cost) across assignments. CPI < 1.0 indicates cost overrun; used as a leading indicator for cost-at-completion forecasting."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned resource quantity across assignments. Used for productivity analysis and resource demand forecasting."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual resource quantity consumed. Compared against planned quantity to assess resource productivity and consumption efficiency."
    - name: "total_remaining_cost"
      expr: SUM(CAST(remaining_cost AS DOUBLE))
      comment: "Total remaining cost to complete across all active assignments. Key input for cost-at-completion forecasting and cash flow planning."
    - name: "total_overtime_quantity"
      expr: SUM(CAST(overtime_quantity AS DOUBLE))
      comment: "Total overtime quantity across resource assignments. High overtime volumes indicate schedule pressure and increased labor cost risk."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per resource assignment. Used to benchmark resource cost competitiveness and identify rate anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline activity performance metrics comparing baseline commitments against current schedule status. Used by project controls and PMO to measure schedule variance, assess baseline integrity, and identify activities deviating from the approved plan."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier for cross-project baseline performance comparison."
  measures:
    - name: "total_baseline_activities"
      expr: COUNT(1)
      comment: "Total number of baseline activities. Baseline denominator for all baseline performance rate calculations."
$$;