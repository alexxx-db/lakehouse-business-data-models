-- Metric views for domain: workforce | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core labor cost and hours metrics derived from approved timesheets. Enables project cost control, overtime management, and payroll burden analysis for construction workforce."
  source: "`vibe_construction_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the timesheet labor hours and costs are charged to — primary grouping for job cost reporting."
    - name: "work_date"
      expr: work_date
      comment: "Calendar date of work performed — enables daily, weekly, and period-over-period labor trend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval state (Approved, Pending, Rejected) — used to filter billable vs. unapproved labor."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay classification (Regular, Overtime, Double-Time, Per Diem) — drives payroll cost breakdown."
    - name: "craft_classification"
      expr: craft_classification
      comment: "Trade or craft classification of the worker — enables labor cost analysis by discipline."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift worked (Day, Night, Swing) — used to analyze shift differential cost impact."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the labor is charged to — enables earned value and cost-at-completion analysis."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Finance cost code for the labor charge — supports budget vs. actual job costing."
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the hours are billable to the client — separates billable from non-billable labor."
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period identifier — used for payroll cycle reporting and period-end accruals."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours worked across all timesheets. Core input for labor productivity and cost-at-completion forecasting."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred. Elevated overtime signals schedule pressure or crew under-staffing requiring management intervention."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. High double-time is a leading indicator of cost overrun and worker fatigue risk."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours (regular + overtime + double-time) charged across all timesheets. Primary labor volume KPI for project staffing dashboards."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost amount from all timesheets. Direct input to project cost control and budget variance reporting."
    - name: "avg_labor_cost_per_hour"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per timesheet record. Tracks blended labor rate trends over time and across projects."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity reported on timesheets. Used to compute field productivity rates (units installed per hour)."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved timesheets. Tracks payroll processing readiness and approval cycle efficiency."
    - name: "pending_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of timesheets awaiting approval. High pending count signals bottlenecks in the approval workflow that delay payroll."
    - name: "billable_hours_total"
      expr: SUM(CASE WHEN is_billable = TRUE THEN total_hours ELSE 0 END)
      comment: "Total hours flagged as billable to the client. Used to compute billing utilization and support progress payment applications."
    - name: "non_billable_hours_total"
      expr: SUM(CASE WHEN is_billable = FALSE THEN total_hours ELSE 0 END)
      comment: "Total non-billable hours (rework, downtime, overhead). Elevated non-billable hours indicate inefficiency or scope gaps."
    - name: "overtime_hours_ratio_numerator"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Numerator for overtime ratio calculation (overtime hours). Combine with total_hours_worked in BI to compute overtime intensity percentage."
    - name: "distinct_workers_on_timesheets"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with timesheet entries. Measures active workforce size on the project for headcount reporting."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular labor cost and productivity metrics at the timesheet line level. Enables activity-level earned value, cost code variance, and rework cost analysis."
  source: "`vibe_construction_v1`.`workforce`.`timesheet_line`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the line-level labor cost is charged to — primary dimension for job cost reporting."
    - name: "work_date"
      expr: work_date
      comment: "Date of work for the timesheet line — enables daily productivity and cost trend analysis."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Finance cost code for the line item — supports budget vs. actual variance at the cost code level."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element charged — enables earned value management at the work package level."
    - name: "activity_id"
      expr: activity_id
      comment: "Schedule activity the labor is charged to — links labor cost to schedule progress for EVM analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Line-level approval status — used to separate approved from pending labor costs in financial reporting."
    - name: "is_rework"
      expr: is_rework
      comment: "Flag indicating rework hours — rework cost is a key quality and productivity KPI in construction."
    - name: "is_billable"
      expr: is_billable
      comment: "Billable flag at line level — enables precise billable vs. non-billable cost segregation."
    - name: "posted_to_job_cost_flag"
      expr: posted_to_job_cost_flag
      comment: "Indicates whether the line has been posted to job cost — tracks financial close completeness."
    - name: "posted_to_payroll_flag"
      expr: posted_to_payroll_flag
      comment: "Indicates whether the line has been posted to payroll — tracks payroll processing completeness."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours at line level. Granular input for activity-level productivity and earned value calculations."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours at line level. Enables overtime cost attribution to specific activities and cost codes."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours at line level. Supports premium pay cost analysis by activity and WBS element."
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours at line level. Primary volume measure for activity-level labor input tracking."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost at line level. Enables cost code and activity-level budget vs. actual variance analysis."
    - name: "rework_hours_total"
      expr: SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END)
      comment: "Total hours classified as rework. Rework hours as a share of total hours is a leading quality KPI — high rework signals design or workmanship issues."
    - name: "rework_cost_total"
      expr: SUM(CASE WHEN is_rework = TRUE THEN labor_cost_amount ELSE 0 END)
      comment: "Total labor cost attributed to rework. Direct measure of quality failure cost — used in cost-of-quality reporting."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity at line level. Combined with total hours, enables unit-rate productivity benchmarking by activity."
    - name: "unposted_job_cost_lines"
      expr: COUNT(CASE WHEN posted_to_job_cost_flag = FALSE THEN 1 END)
      comment: "Count of lines not yet posted to job cost. High unposted count indicates financial close risk and delayed cost visibility."
    - name: "unposted_payroll_lines"
      expr: COUNT(CASE WHEN posted_to_payroll_flag = FALSE THEN 1 END)
      comment: "Count of lines not yet posted to payroll. Tracks payroll processing backlog and compliance risk for timely worker payment."
    - name: "distinct_activities_charged"
      expr: COUNT(DISTINCT activity_id)
      comment: "Number of distinct schedule activities with labor charges. Measures breadth of active work fronts on the project."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_production_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field productivity and production rate metrics. Enables earned value management, productivity factor analysis, and variance-driven corrective action for construction operations."
  source: "`vibe_construction_v1`.`workforce`.`production_rate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the production rate record belongs to — primary grouping for project-level productivity dashboards."
    - name: "work_date"
      expr: work_date
      comment: "Date of production measurement — enables daily and weekly productivity trend analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the production is attributed to — enables earned value analysis at work package level."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for the production activity — supports budget vs. actual productivity benchmarking."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade discipline (e.g., Concrete, Steel, MEP) — enables productivity comparison across trades."
    - name: "shift"
      expr: shift
      comment: "Shift during which production was recorded — used to compare day vs. night shift productivity."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantity (e.g., LF, CY, EA) — required for meaningful rate comparisons."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether the production record involved rework — used to segregate rework from productive output."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates a safety incident occurred during the production period — used to correlate safety events with productivity loss."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during production — used to analyze weather-related productivity impacts for EOT claims."
  measures:
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total quantity of work physically installed or completed. Primary output measure for earned value and schedule performance."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity for the period. Compared against actual quantity to compute quantity variance and schedule performance index."
    - name: "total_expended_hours"
      expr: SUM(CAST(expended_hours AS DOUBLE))
      comment: "Total labor hours expended on production activities. Input to productivity factor and cost performance index calculations."
    - name: "total_earned_hours"
      expr: SUM(CAST(earned_hours AS DOUBLE))
      comment: "Total earned hours (budgeted hours for work completed). Core EVM metric — compared to expended hours to compute CPI."
    - name: "total_variance_hours"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Total hours variance (earned minus expended). Negative variance signals labor cost overrun requiring management intervention."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned). Negative variance indicates production is behind schedule."
    - name: "avg_actual_production_rate"
      expr: AVG(CAST(actual_production_rate AS DOUBLE))
      comment: "Average actual production rate across all records. Benchmarked against planned rate to assess crew and trade performance."
    - name: "avg_planned_production_rate"
      expr: AVG(CAST(planned_production_rate AS DOUBLE))
      comment: "Average planned production rate. Used as the baseline for productivity factor calculation and look-ahead planning."
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor (actual rate / planned rate). Values below 1.0 indicate underperformance; used to forecast cost-at-completion."
    - name: "rework_production_records"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Count of production records involving rework. Elevated rework count signals quality issues driving productivity loss."
    - name: "safety_incident_production_records"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of production records with associated safety incidents. Used to quantify productivity impact of safety events."
    - name: "distinct_crews_producing"
      expr: COUNT(DISTINCT crew_id)
      comment: "Number of distinct crews with production records. Measures breadth of active production fronts on the project."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew deployment, utilization, and labor rate metrics. Enables workforce planning, mobilization efficiency, and crew cost analysis across projects."
  source: "`vibe_construction_v1`.`workforce`.`crew_assignment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the crew assignment is associated with — primary dimension for project workforce planning."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the crew assignment (Active, Completed, Cancelled) — used to filter active workforce deployments."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (Direct Hire, Agency, Subcontractor) — enables sourcing strategy analysis."
    - name: "craft_type"
      expr: craft_type
      comment: "Craft or trade type of the assigned worker — enables workforce composition analysis by discipline."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the assignment — used to analyze shift coverage and premium pay exposure."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the crew is assigned to — enables workforce allocation analysis at work package level."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the assignment is billable to the client — used to compute billable utilization rate."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "HSE orientation completion status — tracks safety compliance for site access readiness."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation of the assigned worker — used for labor relations and prevailing wage compliance reporting."
    - name: "assignment_start_date"
      expr: assignment_start_date
      comment: "Start date of the crew assignment — used for workforce ramp-up and mobilization timeline analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of crew assignments. Baseline headcount metric for workforce deployment tracking."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN 1 END)
      comment: "Number of currently active crew assignments. Measures live workforce size on the project for daily headcount reporting."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate across crew assignments. Tracks blended labor cost rate for budget forecasting and bid benchmarking."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate for eligible assignments. Used to forecast and control accommodation and subsistence costs."
    - name: "per_diem_eligible_assignments"
      expr: COUNT(CASE WHEN per_diem_eligible_flag = TRUE THEN 1 END)
      comment: "Count of assignments with per diem eligibility. Drives per diem cost accrual and budget allocation for remote projects."
    - name: "hse_orientation_pending_count"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = FALSE AND assignment_status = 'Active' THEN 1 END)
      comment: "Active assignments where HSE orientation is not yet completed. A leading safety compliance KPI — workers on site without orientation represent regulatory risk."
    - name: "distinct_workers_assigned"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with assignments. Measures unique workforce headcount deployed across projects."
    - name: "distinct_crews_deployed"
      expr: COUNT(DISTINCT crew_id)
      comment: "Count of distinct crews deployed. Used for crew utilization and resource allocation analysis."
    - name: "billable_assignment_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Number of billable crew assignments. Used to compute billable utilization rate and support client invoicing."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor mobilization cost and logistics metrics. Enables mobilization budget control, travel cost management, and workforce deployment efficiency analysis."
  source: "`vibe_construction_v1`.`workforce`.`labor_mobilization`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Destination project for the mobilization — primary dimension for project-level mobilization cost reporting."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the mobilization (Planned, In Progress, Completed, Cancelled) — used to track mobilization pipeline."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilization (Initial, Remobilization, Demobilization) — enables cost analysis by mobilization phase."
    - name: "travel_mode"
      expr: travel_mode
      comment: "Mode of travel (Air, Road, Rail) — used to analyze and optimize travel cost by mode."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Whether the worker is eligible for per diem — drives per diem cost accrual and budget planning."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Whether accommodation is required — used to forecast and control accommodation costs for remote projects."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "HSE orientation completion at mobilization — tracks safety readiness before workers commence on site."
    - name: "mobilization_date"
      expr: mobilization_date
      comment: "Date of mobilization — used for ramp-up timeline analysis and schedule compliance tracking."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft code of the mobilized worker — enables mobilization cost analysis by trade discipline."
  measures:
    - name: "total_mobilization_cost"
      expr: SUM(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Total mobilization cost including travel and accommodation. Primary cost KPI for workforce deployment budget control."
    - name: "total_travel_cost_estimate"
      expr: SUM(CAST(travel_cost_estimate AS DOUBLE))
      comment: "Total estimated travel cost across all mobilizations. Used to track travel spend against mobilization budget."
    - name: "total_accommodation_cost_estimate"
      expr: SUM(CAST(accommodation_cost_estimate AS DOUBLE))
      comment: "Total estimated accommodation cost. Elevated accommodation costs on remote projects require proactive budget management."
    - name: "avg_mobilization_cost"
      expr: AVG(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Average mobilization cost per worker. Benchmarked against budget rates to identify cost overruns by trade or project."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate for mobilized workers. Used to validate per diem rates against labor agreement entitlements."
    - name: "total_per_diem_eligible_mobilizations"
      expr: COUNT(CASE WHEN per_diem_eligible_flag = TRUE THEN 1 END)
      comment: "Count of mobilizations with per diem eligibility. Drives per diem liability accrual for project cost forecasting."
    - name: "hse_orientation_pending_at_mobilization"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = FALSE THEN 1 END)
      comment: "Mobilizations where HSE orientation is not yet completed. Workers mobilized without orientation represent a safety and regulatory compliance risk."
    - name: "distinct_workers_mobilized"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct workers mobilized. Measures workforce deployment scale and supports headcount planning."
    - name: "total_mobilizations"
      expr: COUNT(1)
      comment: "Total number of mobilization records. Baseline volume metric for mobilization activity tracking."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce staffing plan metrics for headcount planning, labor hours forecasting, and sourcing strategy analysis across construction projects."
  source: "`vibe_construction_v1`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the staffing plan applies to — primary dimension for project workforce planning dashboards."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the staffing plan (Draft, Approved, Active, Closed) — used to filter active vs. historical plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of staffing plan (Initial, Revised, Final) — enables version and revision tracking."
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Trade discipline the staffing plan covers — enables workforce demand analysis by trade."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the staffing plan is associated with — enables resource planning at work package level."
    - name: "baseline_flag"
      expr: baseline_flag
      comment: "Indicates whether this is the approved baseline staffing plan — used to compare actuals against the approved baseline."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy (Direct Hire, Agency, Subcontract) — used to analyze workforce sourcing mix and cost implications."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start of the planning period — used for time-phased workforce demand analysis."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End of the planning period — used to define the horizon for workforce demand forecasting."
  measures:
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(total_planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all staffing plans. Primary input for project labor budget and resource leveling."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours recorded against staffing plans. Compared to planned hours to compute labor hours variance."
    - name: "total_labor_hours_variance"
      expr: SUM(CAST(labor_hours_variance AS DOUBLE))
      comment: "Total variance between planned and actual labor hours. Negative variance indicates labor overrun requiring corrective action."
    - name: "avg_labor_hours_variance"
      expr: AVG(CAST(labor_hours_variance AS DOUBLE))
      comment: "Average labor hours variance per staffing plan. Used to assess planning accuracy and improve future estimates."
    - name: "approved_staffing_plans"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of approved staffing plans. Tracks planning governance compliance — unapproved plans indicate resource commitment risk."
    - name: "distinct_projects_with_staffing_plans"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with staffing plans. Measures workforce planning coverage across the project portfolio."
    - name: "total_staffing_plans"
      expr: COUNT(1)
      comment: "Total number of staffing plan records. Baseline volume metric for planning activity tracking."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Craft worker certification compliance metrics. Enables certification expiry tracking, regulatory compliance monitoring, and site access readiness management."
  source: "`vibe_construction_v1`.`workforce`.`craft_certification`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the certification is verified for — enables project-level compliance reporting."
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Trade the certification applies to — used to analyze certification compliance by discipline."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (OSHA, First Aid, Trade License, etc.) — enables compliance gap analysis by certification category."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification (Entry, Journeyman, Master) — used for workforce capability and skill level analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification (Verified, Pending, Expired) — primary compliance status dimension."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the certification is required for regulatory compliance — used to prioritize renewal actions."
    - name: "site_access_required_flag"
      expr: site_access_required_flag
      comment: "Indicates whether the certification is required for site access — workers with expired site-access certs must be barred from site."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the certification requires renewal — used to drive proactive renewal workflows."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification — used to validate certification authenticity and track issuing authority compliance."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Certification expiry date — primary time dimension for expiry risk monitoring and renewal scheduling."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of craft certifications on record. Baseline metric for certification portfolio size."
    - name: "verified_certifications"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of certifications with verified status. Measures workforce compliance readiness — low verified count signals site access risk."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN verification_status = 'Expired' THEN 1 END)
      comment: "Number of expired certifications. Expired certifications on site-access-required trades represent immediate regulatory and safety risk."
    - name: "site_access_certs_at_risk"
      expr: COUNT(CASE WHEN site_access_required_flag = TRUE AND verification_status = 'Expired' THEN 1 END)
      comment: "Expired certifications that are required for site access. Critical safety KPI — workers with these certs must be removed from site immediately."
    - name: "regulatory_certs_expired"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE AND verification_status = 'Expired' THEN 1 END)
      comment: "Expired certifications required for regulatory compliance. Drives immediate corrective action to avoid regulatory penalties."
    - name: "distinct_certified_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with at least one certification record. Measures certified workforce size."
    - name: "avg_training_hours_required"
      expr: AVG(CAST(training_hours_required AS DOUBLE))
      comment: "Average training hours required per certification. Used to plan training schedules and estimate training cost for workforce development."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_apprenticeship_progression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Apprenticeship program compliance and progression metrics. Enables DOL compliance monitoring, apprentice-to-journeyman ratio tracking, and workforce development pipeline analysis."
  source: "`vibe_construction_v1`.`workforce`.`apprenticeship_progression`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project where apprenticeship hours are being earned — enables project-level apprenticeship compliance reporting."
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Trade the apprenticeship is in — used to analyze apprenticeship pipeline by discipline."
    - name: "apprenticeship_status"
      expr: apprenticeship_status
      comment: "Current status of the apprenticeship (Active, Completed, Suspended, Cancelled) — primary status dimension."
    - name: "apprenticeship_level"
      expr: apprenticeship_level
      comment: "Current level within the apprenticeship program — used to analyze progression distribution across levels."
    - name: "apprenticeship_type"
      expr: apprenticeship_type
      comment: "Type of apprenticeship (Union, Non-Union, JATC) — used for compliance reporting by program type."
    - name: "dol_compliance_flag"
      expr: dol_compliance_flag
      comment: "DOL compliance status — non-compliant apprenticeships represent regulatory risk on federally funded projects."
    - name: "state_apprenticeship_compliance_flag"
      expr: state_apprenticeship_compliance_flag
      comment: "State-level apprenticeship compliance status — used for state prevailing wage and apprenticeship ratio compliance."
    - name: "prevailing_wage_classification"
      expr: prevailing_wage_classification
      comment: "Prevailing wage classification for the apprentice — used for certified payroll and Davis-Bacon compliance."
    - name: "wage_progression_step"
      expr: wage_progression_step
      comment: "Current wage step in the apprenticeship progression — used to track wage advancement and forecast labor cost increases."
  measures:
    - name: "total_apprenticeships"
      expr: COUNT(1)
      comment: "Total number of apprenticeship progression records. Baseline metric for apprenticeship program scale."
    - name: "active_apprenticeships"
      expr: COUNT(CASE WHEN apprenticeship_status = 'Active' THEN 1 END)
      comment: "Number of currently active apprenticeships. Measures live apprenticeship pipeline for workforce development planning."
    - name: "completed_apprenticeships"
      expr: COUNT(CASE WHEN apprenticeship_status = 'Completed' THEN 1 END)
      comment: "Number of completed apprenticeships (journeyman graduates). Measures workforce development output and pipeline conversion rate."
    - name: "total_ojt_hours_accumulated"
      expr: SUM(CAST(ojt_hours_accumulated AS DOUBLE))
      comment: "Total on-the-job training hours accumulated across all apprentices. Measures apprenticeship program investment and progress toward journeyman qualification."
    - name: "total_technical_instruction_hours"
      expr: SUM(CAST(technical_instruction_hours AS DOUBLE))
      comment: "Total technical instruction hours completed. Used to verify compliance with DOL minimum classroom training requirements."
    - name: "avg_apprentice_to_journeyman_ratio"
      expr: AVG(CAST(apprentice_to_journeyman_ratio AS DOUBLE))
      comment: "Average apprentice-to-journeyman ratio. Monitored for compliance with union agreement and DOL ratio requirements — violations risk project shutdown."
    - name: "dol_non_compliant_count"
      expr: COUNT(CASE WHEN dol_compliance_flag = FALSE THEN 1 END)
      comment: "Number of apprenticeships not in DOL compliance. Any non-zero count on federally funded projects requires immediate corrective action."
    - name: "distinct_apprentices"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers in apprenticeship programs. Measures the breadth of the workforce development pipeline."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor rate benchmarking and cost structure metrics. Enables bid pricing validation, prevailing wage compliance, and labor cost forecasting across projects and trades."
  source: "`vibe_construction_v1`.`workforce`.`labor_rate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the labor rate applies to — enables project-specific rate analysis and bid benchmarking."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of labor rate (Prevailing Wage, Union, Open Shop, Government) — primary classification for rate compliance analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the rate (Active, Expired, Pending) — used to filter current vs. historical rates."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction the rate applies to — used for prevailing wage compliance by location."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level the rate applies to (Apprentice, Journeyman, Foreman) — enables rate analysis by skill tier."
    - name: "trade_classification"
      expr: trade_classification
      comment: "Trade classification for the rate — used to benchmark rates across trades and disciplines."
    - name: "certified_payroll_required_flag"
      expr: certified_payroll_required_flag
      comment: "Indicates certified payroll is required — flags rates subject to Davis-Bacon or state prevailing wage reporting."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of the rate — used for rate escalation analysis and contract pricing validation."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Effective end date of the rate — used to identify expiring rates requiring renewal before project completion."
  measures:
    - name: "avg_base_hourly_rate"
      expr: AVG(CAST(base_hourly_rate AS DOUBLE))
      comment: "Average base hourly rate across all rate records. Used for bid pricing benchmarking and labor budget development."
    - name: "avg_total_loaded_hourly_rate"
      expr: AVG(CAST(total_loaded_hourly_rate AS DOUBLE))
      comment: "Average fully loaded hourly rate (base + burden + fringe). The true all-in labor cost used for project cost forecasting and bid pricing."
    - name: "avg_overtime_hourly_rate"
      expr: AVG(CAST(overtime_hourly_rate AS DOUBLE))
      comment: "Average overtime hourly rate. Used to quantify overtime cost premium exposure in project labor budgets."
    - name: "avg_fringe_benefit_rate"
      expr: AVG(CAST(fringe_benefit_rate AS DOUBLE))
      comment: "Average fringe benefit rate. Fringe benefits are a significant component of total labor cost — tracked for budget accuracy."
    - name: "avg_payroll_burden_percentage"
      expr: AVG(CAST(payroll_burden_percentage AS DOUBLE))
      comment: "Average payroll burden percentage. Used to validate burden rates against industry benchmarks and contract pricing assumptions."
    - name: "avg_overhead_percentage"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied to labor rates. Used to ensure overhead recovery in project pricing."
    - name: "avg_profit_margin_percentage"
      expr: AVG(CAST(profit_margin_percentage AS DOUBLE))
      comment: "Average profit margin percentage in labor rates. Used to validate bid pricing margins against company targets."
    - name: "certified_payroll_rate_count"
      expr: COUNT(CASE WHEN certified_payroll_required_flag = TRUE THEN 1 END)
      comment: "Number of rates subject to certified payroll requirements. Drives compliance reporting workload estimation for prevailing wage projects."
    - name: "distinct_projects_with_rates"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with labor rate records. Measures rate governance coverage across the project portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_site_access_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site access control and workforce presence metrics. Enables site security compliance, HSE induction tracking, and workforce headcount verification on construction sites."
  source: "`vibe_construction_v1`.`workforce`.`site_access_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project site the access record belongs to — primary dimension for site-level workforce presence reporting."
    - name: "access_direction"
      expr: access_direction
      comment: "Direction of access (Entry, Exit) — used to compute time-on-site and concurrent headcount."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status of the access event (Authorized, Denied, Pending) — used to track unauthorized access attempts."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Classification of the worker (Direct, Subcontractor, Visitor) — enables workforce composition analysis on site."
    - name: "induction_status"
      expr: induction_status
      comment: "Site induction status of the worker — workers accessing site without completed induction represent a safety compliance risk."
    - name: "ppe_compliance_status"
      expr: ppe_compliance_status
      comment: "PPE compliance status at point of entry — non-compliant PPE is a leading safety indicator."
    - name: "health_screening_status"
      expr: health_screening_status
      comment: "Health screening status at entry — used for workforce health and safety compliance monitoring."
    - name: "access_zone"
      expr: access_zone
      comment: "Zone of the site accessed — used for zone-level access control and hazard area monitoring."
    - name: "access_method"
      expr: access_method
      comment: "Method of access verification (Badge, Biometric, Manual) — used to assess access control system effectiveness."
  measures:
    - name: "total_access_events"
      expr: COUNT(1)
      comment: "Total number of site access events. Baseline metric for site traffic volume and security activity."
    - name: "denied_access_events"
      expr: COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END)
      comment: "Number of denied access events. Elevated denials indicate unauthorized personnel attempts or expired credentials — requires security investigation."
    - name: "ppe_non_compliant_entries"
      expr: COUNT(CASE WHEN ppe_compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of site entries with PPE non-compliance. A leading safety KPI — high non-compliance rates require immediate HSE intervention."
    - name: "induction_incomplete_entries"
      expr: COUNT(CASE WHEN induction_status != 'Completed' THEN 1 END)
      comment: "Number of site entries where induction is not completed. Workers on site without induction represent a regulatory and safety risk."
    - name: "distinct_workers_on_site"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with site access records. Measures unique workforce presence for headcount verification and muster reporting."
    - name: "avg_duration_on_site_minutes"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature reading at site entry. Used for health screening trend monitoring — elevated readings may indicate health risk events requiring protocol activation."
    - name: "escort_required_entries"
      expr: COUNT(CASE WHEN escort_required_flag = TRUE THEN 1 END)
      comment: "Number of access events requiring escort. Measures visitor and restricted-access management workload on site."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor agreement financial terms and compliance metrics. Enables union contract cost analysis, wage rate benchmarking, and labor relations risk management."
  source: "`vibe_construction_v1`.`workforce`.`labor_agreement`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the labor agreement applies to — enables project-level labor relations and cost analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the labor agreement (Active, Expired, Negotiating) — used to identify agreements requiring renewal."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of labor agreement (CBA, PLA, Open Shop) — primary classification for labor relations analysis."
    - name: "jurisdiction_type"
      expr: jurisdiction_type
      comment: "Jurisdiction type (Local, State, Federal) — used for prevailing wage and regulatory compliance analysis."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade category covered by the agreement — enables wage rate analysis by discipline."
    - name: "multi_employer_agreement_flag"
      expr: multi_employer_agreement_flag
      comment: "Indicates a multi-employer agreement — used to identify agreements with broader industry implications."
    - name: "no_strike_clause_flag"
      expr: no_strike_clause_flag
      comment: "Indicates presence of a no-strike clause — a key labor relations risk indicator for project continuity."
    - name: "hiring_hall_required_flag"
      expr: hiring_hall_required_flag
      comment: "Indicates hiring hall requirement — affects workforce sourcing strategy and mobilization lead times."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the agreement — used for agreement lifecycle and renewal timeline analysis."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the agreement — used to proactively identify agreements requiring renegotiation."
  measures:
    - name: "avg_base_wage_rate"
      expr: AVG(CAST(base_wage_rate AS DOUBLE))
      comment: "Average base wage rate across labor agreements. Used for bid pricing benchmarking and labor cost budget development."
    - name: "avg_fringe_benefit_rate"
      expr: AVG(CAST(fringe_benefit_rate AS DOUBLE))
      comment: "Average fringe benefit rate. Fringe benefits significantly impact total labor cost — tracked for budget accuracy."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across agreements. Used to quantify overtime cost premium exposure in project labor budgets."
    - name: "avg_training_fund_rate"
      expr: AVG(CAST(training_fund_rate AS DOUBLE))
      comment: "Average training fund contribution rate. Tracks workforce development investment mandated by labor agreements."
    - name: "avg_pension_rate"
      expr: AVG(CAST(pension_rate AS DOUBLE))
      comment: "Average pension contribution rate. A significant labor cost component — tracked for total compensation cost analysis."
    - name: "active_agreements_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active labor agreements. Measures the scope of active labor relations obligations."
    - name: "expiring_agreements_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Baseline count of active agreements for expiry monitoring. Used alongside expiration_date dimension to identify agreements expiring within planning horizon."
    - name: "no_strike_agreements_count"
      expr: COUNT(CASE WHEN no_strike_clause_flag = TRUE THEN 1 END)
      comment: "Number of agreements with no-strike clauses. Measures project continuity protection through labor relations risk management."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_carbon_reduction_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce carbon reduction participation metrics. Enables sustainability reporting, ESG target tracking, and workforce engagement in carbon reduction initiatives."
  source: "`vibe_construction_v1`.`workforce`.`carbon_reduction_participation`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project where carbon reduction participation occurred — enables project-level ESG and sustainability reporting."
    - name: "carbon_reduction_initiative_id"
      expr: carbon_reduction_initiative_id
      comment: "Carbon reduction initiative the worker participated in — used to measure initiative-level workforce engagement."
    - name: "participation_role"
      expr: participation_role
      comment: "Role of the worker in the carbon reduction initiative — used to analyze participation by role type."
    - name: "start_date"
      expr: start_date
      comment: "Start date of participation — used for time-phased sustainability reporting."
    - name: "end_date"
      expr: end_date
      comment: "End date of participation — used to measure participation duration and initiative completion."
  measures:
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total workforce hours contributed to carbon reduction initiatives. Primary ESG KPI measuring workforce investment in sustainability programs."
    - name: "avg_hours_contributed"
      expr: AVG(CAST(hours_contributed AS DOUBLE))
      comment: "Average hours contributed per participation record. Used to benchmark individual engagement levels against program targets."
    - name: "distinct_workers_participating"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers participating in carbon reduction initiatives. Measures workforce engagement breadth for ESG reporting."
    - name: "distinct_initiatives_engaged"
      expr: COUNT(DISTINCT carbon_reduction_initiative_id)
      comment: "Count of distinct carbon reduction initiatives with workforce participation. Measures diversity of sustainability program engagement."
    - name: "total_participation_records"
      expr: COUNT(1)
      comment: "Total number of participation records. Baseline volume metric for sustainability program activity tracking."
$$;
