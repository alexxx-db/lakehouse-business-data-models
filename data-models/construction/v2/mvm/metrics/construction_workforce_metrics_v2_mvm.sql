-- Metric views for domain: workforce | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core labor productivity and cost metrics derived from approved timesheet records. Drives payroll accuracy, overtime management, and billable utilization analysis."
  source: "`vibe_construction_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Calendar date of work performed; used for daily, weekly, and monthly trend analysis."
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period identifier for grouping labor costs into pay cycles."
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval state (e.g. Approved, Pending, Rejected); used to filter billable and payroll-ready records."
    - name: "craft_classification"
      expr: craft_classification
      comment: "Craft or trade classification of the worker (e.g. Ironworker, Electrician); enables labor mix analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift designation (Day, Night, Swing) for shift-based productivity and cost comparisons."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type (Regular, Overtime, Double-Time) for compensation structure analysis."
    - name: "work_classification"
      expr: work_classification
      comment: "Classification of work performed (e.g. Direct, Indirect, Rework) for productivity and quality analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Boolean flag indicating whether the timesheet hours are billable to a client or project."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which labor costs are recorded; supports multi-currency reporting."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded at time of work; used to analyze weather-related productivity impacts."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours worked across all timesheets. Core input for payroll and productivity benchmarking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime signals schedule pressure, crew shortages, or poor planning."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. High double-time is a leading cost risk indicator requiring executive attention."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked including regular, overtime, and double-time. Primary labor volume KPI."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost amount across all timesheet records. Core financial KPI for project cost control."
    - name: "avg_labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Average blended labor cost per hour. Tracks effective labor rate versus budget and contract rates."
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours. A key schedule health and cost risk indicator; high values trigger workforce reallocation decisions."
    - name: "billable_hours_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_billable = TRUE THEN total_hours ELSE 0 END) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are billable to clients. Directly impacts revenue recovery and project margin."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity recorded on timesheets. Used to compute unit productivity rates."
    - name: "labor_productivity_rate"
      expr: ROUND(SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 4)
      comment: "Production output per labor hour. Core field productivity KPI used to benchmark crews and identify underperformance."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN timesheet_id END)
      comment: "Count of approved timesheets. Tracks payroll readiness and approval cycle efficiency."
    - name: "timesheet_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN timesheet_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of timesheets that have been approved. Low approval rates indicate payroll processing risk and administrative bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular line-level labor cost and productivity metrics. Enables detailed cost code analysis, rework identification, and payroll posting status tracking."
  source: "`vibe_construction_v1`.`workforce`.`timesheet_line`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of work for the timesheet line; supports daily and weekly labor trend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the timesheet line; used to isolate approved vs. pending labor costs."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft code identifying the trade or skill classification for the line item."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for the work performed; enables shift-level cost and productivity comparisons."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the line item hours are billable to a client or project."
    - name: "is_rework"
      expr: is_rework
      comment: "Flags rework labor; rework hours and costs are a direct quality and efficiency KPI."
    - name: "posted_to_job_cost_flag"
      expr: posted_to_job_cost_flag
      comment: "Indicates whether the line has been posted to job cost; tracks financial close completeness."
    - name: "posted_to_payroll_flag"
      expr: posted_to_payroll_flag
      comment: "Indicates whether the line has been posted to payroll; tracks payroll processing completeness."
    - name: "work_location_code"
      expr: work_location_code
      comment: "Work location code for geographic or zone-level labor analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the labor cost amount for multi-currency project reporting."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours at the line level. Foundation for detailed cost code and craft-level labor analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours at the line level. Enables cost code-level overtime analysis for budget variance management."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours at the line level. High double-time on specific cost codes signals schedule or resource risk."
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked at the line level across all pay types."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost at the line level. Enables granular cost code and craft-level financial control."
    - name: "rework_hours"
      expr: SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END)
      comment: "Total hours classified as rework. Rework hours represent pure waste and directly erode project margin."
    - name: "rework_cost"
      expr: SUM(CASE WHEN is_rework = TRUE THEN labor_cost_amount ELSE 0 END)
      comment: "Total labor cost attributed to rework. A critical quality KPI; high rework cost triggers quality process intervention."
    - name: "rework_hours_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Rework hours as a percentage of total hours. Directly measures quality failure rate in field execution."
    - name: "unposted_labor_cost"
      expr: SUM(CASE WHEN posted_to_job_cost_flag = FALSE THEN labor_cost_amount ELSE 0 END)
      comment: "Labor cost not yet posted to job cost. Tracks financial close risk; high unposted amounts distort project cost reporting."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output at the line level. Used for unit cost and productivity rate calculations by cost code."
    - name: "unit_labor_cost"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(production_quantity AS DOUBLE)), 0), 4)
      comment: "Labor cost per unit of production. Benchmarks actual unit cost against estimate to identify cost overruns by work type."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew deployment, utilization, and mobilization metrics. Supports workforce planning, assignment efficiency, and HSE compliance tracking across projects."
  source: "`vibe_construction_v1`.`workforce`.`crew_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the crew assignment (e.g. Active, Completed, Cancelled); used to filter active workforce."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g. Direct, Indirect, Subcontract); drives cost classification and reporting."
    - name: "craft_type"
      expr: craft_type
      comment: "Craft or trade type for the assignment; enables trade mix and workforce composition analysis."
    - name: "crew_role"
      expr: crew_role
      comment: "Role of the worker within the crew (e.g. Foreman, Journeyman, Apprentice)."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the assignment; supports shift-based workforce planning."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation of the assigned worker; used for union vs. open-shop workforce analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the assignment is billable to the client; impacts revenue recognition."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Indicates overtime eligibility; used in labor cost forecasting and budget risk analysis."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Indicates per diem eligibility; used to forecast and control mobilization-related costs."
    - name: "work_location"
      expr: work_location
      comment: "Physical work location for the assignment; supports site-level workforce distribution analysis."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "Indicates whether HSE site orientation has been completed; a mandatory safety compliance gate."
  measures:
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN crew_assignment_id END)
      comment: "Number of currently active crew assignments. Primary headcount KPI for real-time workforce visibility."
    - name: "total_assignment_count"
      expr: COUNT(1)
      comment: "Total crew assignments across all statuses. Used as denominator for assignment rate and completion metrics."
    - name: "total_labor_rate_cost"
      expr: SUM(CAST(labor_rate AS DOUBLE))
      comment: "Sum of contracted labor rates across assignments. Approximates total committed labor cost exposure."
    - name: "avg_labor_rate"
      expr: ROUND(AVG(CAST(labor_rate AS DOUBLE)), 2)
      comment: "Average labor rate across crew assignments. Benchmarks actual rates against budget and contract targets."
    - name: "total_per_diem_cost"
      expr: SUM(CASE WHEN per_diem_eligible_flag = TRUE THEN per_diem_rate ELSE 0 END)
      comment: "Total per diem cost for eligible assignments. Per diem is a significant mobilization cost driver on remote projects."
    - name: "avg_assignment_duration_days"
      expr: ROUND(AVG(DATEDIFF(assignment_end_date, assignment_start_date)), 1)
      comment: "Average duration of crew assignments in days. Short average durations indicate high crew turnover and mobilization cost risk."
    - name: "hse_orientation_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_orientation_completed_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments where HSE orientation is completed. Non-compliance is a regulatory and safety liability; tracked at executive level."
    - name: "billable_assignment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments flagged as billable. Low billable percentage signals revenue leakage or misclassification."
    - name: "unique_workers_assigned"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with assignments. Measures actual deployed headcount for workforce planning."
    - name: "unique_crews_deployed"
      expr: COUNT(DISTINCT crew_id)
      comment: "Count of distinct crews deployed. Used to assess crew utilization and identify idle or over-allocated crews."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_worker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Craft worker workforce composition, cost, and compliance metrics. Supports headcount management, labor rate benchmarking, and workforce readiness analysis."
  source: "`vibe_construction_v1`.`workforce`.`craft_worker`"
  dimensions:
    - name: "worker_status"
      expr: worker_status
      comment: "Current employment status of the craft worker (e.g. Active, Terminated, On Leave); primary workforce segmentation dimension."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g. Direct Hire, Agency, Subcontract); drives cost structure and workforce strategy decisions."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the worker (e.g. Apprentice, Journeyman, Master); used for workforce capability and succession planning."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilization state of the worker (e.g. Mobilized, Demobilized, Standby); tracks field deployment readiness."
    - name: "union_affiliation_flag"
      expr: union_affiliation_flag
      comment: "Indicates union membership; used for union vs. open-shop workforce composition and cost analysis."
    - name: "supervisory_role_flag"
      expr: supervisory_role_flag
      comment: "Indicates whether the worker holds a supervisory role; used for supervision ratio analysis."
    - name: "osha_certification_flag"
      expr: osha_certification_flag
      comment: "Indicates OSHA certification status; a mandatory safety compliance dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the worker's compensation; supports multi-currency workforce cost analysis."
  measures:
    - name: "active_worker_count"
      expr: COUNT(CASE WHEN worker_status = 'Active' THEN craft_worker_id END)
      comment: "Number of currently active craft workers. Primary headcount KPI for workforce capacity planning."
    - name: "total_worker_count"
      expr: COUNT(1)
      comment: "Total craft workers in the workforce registry. Used as denominator for workforce composition ratios."
    - name: "avg_hourly_base_rate"
      expr: ROUND(AVG(CAST(hourly_base_rate AS DOUBLE)), 2)
      comment: "Average base hourly rate across craft workers. Benchmarks labor cost competitiveness and budget alignment."
    - name: "total_hourly_base_rate_exposure"
      expr: SUM(CAST(hourly_base_rate AS DOUBLE))
      comment: "Sum of all base hourly rates for active workforce. Approximates maximum hourly labor cost exposure for budgeting."
    - name: "avg_overtime_rate_multiplier"
      expr: ROUND(AVG(CAST(overtime_rate_multiplier AS DOUBLE)), 3)
      comment: "Average overtime rate multiplier across the workforce. Higher multipliers increase overtime cost sensitivity."
    - name: "union_worker_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_affiliation_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of craft workers with union affiliation. Drives labor relations strategy and collective bargaining cost projections."
    - name: "osha_certified_worker_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_certification_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workers with valid OSHA certification. A critical safety compliance KPI; low rates trigger regulatory risk."
    - name: "supervisory_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN supervisory_role_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(CASE WHEN supervisory_role_flag = FALSE THEN craft_worker_id END), 0), 2)
      comment: "Ratio of supervisors to non-supervisory workers. Optimal supervision ratios are critical for safety and productivity on construction sites."
    - name: "mobilized_worker_count"
      expr: COUNT(CASE WHEN mobilization_status = 'Mobilized' THEN craft_worker_id END)
      comment: "Number of workers currently mobilized on site. Tracks actual field deployment versus planned headcount."
    - name: "osha_expiry_within_30_days_count"
      expr: COUNT(CASE WHEN osha_certification_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN craft_worker_id END)
      comment: "Workers whose OSHA certification expires within 30 days. A proactive compliance risk metric requiring immediate renewal action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance, expiry risk, and regulatory readiness metrics. Ensures the workforce maintains required credentials for site access and regulatory compliance."
  source: "`vibe_construction_v1`.`workforce`.`craft_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Safety, Trade License, Equipment Operator); used to segment compliance by credential category."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification (e.g. Basic, Advanced, Master); used for workforce capability tiering."
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification state of the certification (e.g. Verified, Pending, Expired); primary compliance filter."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification; used to track regulatory body compliance coverage."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country of certification issuance; supports multi-jurisdiction compliance reporting."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the certification satisfies a regulatory requirement; critical for compliance audits."
    - name: "project_requirement_flag"
      expr: project_requirement_flag
      comment: "Indicates whether the certification is required for project site access; gates workforce deployment."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the certification requires periodic renewal; drives proactive renewal workflow."
    - name: "site_access_required_flag"
      expr: site_access_required_flag
      comment: "Indicates whether the certification is required for site access; a hard gate for worker deployment."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records in the system. Baseline for certification portfolio coverage analysis."
    - name: "verified_certification_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN craft_certification_id END)
      comment: "Number of certifications with verified status. Tracks credential validation completeness across the workforce."
    - name: "certification_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN craft_certification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that are verified. Low verification rates indicate compliance risk and potential site access issues."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE THEN craft_certification_id END)
      comment: "Number of certifications that have already expired. Expired certifications are an immediate regulatory and site safety liability."
    - name: "expiring_within_30_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN craft_certification_id END)
      comment: "Certifications expiring within 30 days. A leading indicator of upcoming compliance risk requiring proactive renewal action."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN craft_certification_id END)
      comment: "Certifications expiring within 90 days. Used for medium-term renewal planning and workforce readiness forecasting."
    - name: "regulatory_compliance_certification_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN craft_certification_id END)
      comment: "Count of certifications that satisfy regulatory requirements. Tracks regulatory compliance portfolio breadth."
    - name: "avg_training_hours_required"
      expr: ROUND(AVG(CAST(training_hours_required AS DOUBLE)), 1)
      comment: "Average training hours required per certification. Used to estimate workforce training investment and scheduling impact."
    - name: "total_training_hours_required"
      expr: SUM(CAST(training_hours_required AS DOUBLE))
      comment: "Total training hours required across all certifications. Quantifies the training burden for workforce compliance maintenance."
    - name: "unique_certified_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Number of distinct workers holding at least one certification. Measures certified workforce coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce staffing plan performance metrics tracking headcount accuracy, labor hour variance, and planning effectiveness. Drives workforce forecasting and resource allocation decisions."
  source: "`vibe_construction_v1`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the staffing plan (e.g. Draft, Approved, Active, Closed); used to filter actionable plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of staffing plan (e.g. Initial, Revised, Final); tracks planning iteration and maturity."
    - name: "plan_version"
      expr: plan_version
      comment: "Version identifier of the staffing plan; used to compare plan revisions and track forecast evolution."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Workforce sourcing strategy (e.g. Direct Hire, Agency, Subcontract); drives procurement and HR strategy decisions."
    - name: "baseline_flag"
      expr: baseline_flag
      comment: "Indicates whether this is the baseline staffing plan; used to isolate baseline vs. revised plan comparisons."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Indicates whether worker accommodation is required; drives camp and logistics cost planning."
    - name: "transportation_required_flag"
      expr: transportation_required_flag
      comment: "Indicates whether transportation is required; drives mobilization cost forecasting."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of the staffing plan period; used for time-phased workforce planning analysis."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End date of the staffing plan period; used to assess plan horizon and coverage."
  measures:
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(total_planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all staffing plans. Primary workforce capacity planning KPI."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours recorded against staffing plans. Used to compute plan accuracy and variance."
    - name: "total_labor_hours_variance"
      expr: SUM(CAST(labor_hours_variance AS DOUBLE))
      comment: "Total variance between planned and actual labor hours. Negative variance indicates overrun; positive indicates underrun."
    - name: "labor_hours_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_hours_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_planned_labor_hours AS DOUBLE)), 0), 2)
      comment: "Labor hours variance as a percentage of planned hours. Measures staffing plan accuracy; large deviations trigger replanning."
    - name: "avg_planned_labor_hours_per_plan"
      expr: ROUND(AVG(CAST(total_planned_labor_hours AS DOUBLE)), 1)
      comment: "Average planned labor hours per staffing plan. Used to benchmark plan scope and complexity."
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Total number of staffing plans. Used as denominator for plan-level performance averages."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN staffing_plan_id END)
      comment: "Number of approved staffing plans. Tracks planning governance and approval cycle efficiency."
    - name: "plans_with_accommodation_count"
      expr: COUNT(CASE WHEN accommodation_required_flag = TRUE THEN staffing_plan_id END)
      comment: "Number of staffing plans requiring worker accommodation. Drives camp capacity and logistics cost planning."
    - name: "plans_with_transportation_count"
      expr: COUNT(CASE WHEN transportation_required_flag = TRUE THEN staffing_plan_id END)
      comment: "Number of staffing plans requiring transportation. Quantifies mobilization logistics scope and cost exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_cost_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost code rate and burden metrics. Supports cost estimation accuracy, prevailing wage compliance, and union classification management."
  source: "`vibe_construction_v1`.`workforce`.`labor_cost_code`"
  dimensions:
    - name: "cost_code_status"
      expr: cost_code_status
      comment: "Status of the labor cost code (e.g. Active, Inactive); used to filter valid codes for cost estimation."
    - name: "craft_discipline"
      expr: craft_discipline
      comment: "Craft discipline associated with the cost code (e.g. Civil, Mechanical, Electrical); enables discipline-level cost analysis."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level tier for the cost code; used for workforce capability and rate tiering analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for the cost code; used for cost classification and budget roll-up reporting."
    - name: "is_prevailing_wage_applicable"
      expr: is_prevailing_wage_applicable
      comment: "Indicates whether prevailing wage rules apply; a regulatory compliance dimension for public sector projects."
    - name: "is_union_classification"
      expr: is_union_classification
      comment: "Indicates whether the cost code is a union classification; drives labor relations and collective bargaining analysis."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level associated with the cost code; used to correlate labor cost with safety risk exposure."
    - name: "requires_site_access_clearance"
      expr: requires_site_access_clearance
      comment: "Indicates whether site access clearance is required; gates workforce deployment for sensitive work scopes."
  measures:
    - name: "active_cost_code_count"
      expr: COUNT(CASE WHEN cost_code_status = 'Active' THEN labor_cost_code_id END)
      comment: "Number of active labor cost codes. Tracks cost code library completeness for project estimating."
    - name: "avg_hourly_base_rate"
      expr: ROUND(AVG(CAST(hourly_rate_base AS DOUBLE)), 2)
      comment: "Average base hourly rate across labor cost codes. Benchmarks labor rate assumptions in project estimates."
    - name: "avg_burden_rate_pct"
      expr: ROUND(AVG(CAST(burden_rate_percentage AS DOUBLE)), 2)
      comment: "Average burden rate percentage across cost codes. Burden rates significantly impact total labor cost; deviations affect project margin."
    - name: "avg_overtime_multiplier"
      expr: ROUND(AVG(CAST(overtime_multiplier AS DOUBLE)), 3)
      comment: "Average overtime multiplier across labor cost codes. Used to model overtime cost sensitivity in project budgets."
    - name: "prevailing_wage_code_count"
      expr: COUNT(CASE WHEN is_prevailing_wage_applicable = TRUE THEN labor_cost_code_id END)
      comment: "Number of cost codes subject to prevailing wage requirements. Tracks regulatory compliance scope on public sector projects."
    - name: "union_classification_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_union_classification = TRUE THEN labor_cost_code_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of labor cost codes that are union classifications. Informs union labor cost exposure and collective bargaining strategy."
    - name: "max_hourly_base_rate"
      expr: MAX(hourly_rate_base)
      comment: "Maximum base hourly rate across all labor cost codes. Identifies peak labor rate exposure for budget risk analysis."
    - name: "min_hourly_base_rate"
      expr: MIN(hourly_rate_base)
      comment: "Minimum base hourly rate across all labor cost codes. Used to assess rate range and identify below-market classifications."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew performance, productivity, and safety metrics. Enables crew-level benchmarking, safety incident tracking, and workforce deployment optimization."
  source: "`vibe_construction_v1`.`workforce`.`crew`"
  dimensions:
    - name: "crew_status"
      expr: crew_status
      comment: "Current operational status of the crew (e.g. Active, Standby, Demobilized); primary crew deployment filter."
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (e.g. Civil, Mechanical, Electrical); enables trade-based crew performance comparison."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the crew (e.g. Day, Night, Rotating); used for shift-based productivity analysis."
    - name: "is_union_crew"
      expr: is_union_crew
      comment: "Indicates whether the crew is a union crew; used for union vs. open-shop performance benchmarking."
    - name: "home_location"
      expr: home_location
      comment: "Home base location of the crew; used for mobilization cost and logistics planning."
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety performance rating of the crew; a key leading indicator for site safety management."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality performance rating of the crew; used for crew selection and performance management."
  measures:
    - name: "active_crew_count"
      expr: COUNT(CASE WHEN crew_status = 'Active' THEN crew_id END)
      comment: "Number of currently active crews. Primary crew deployment KPI for workforce capacity management."
    - name: "avg_hourly_rate"
      expr: ROUND(AVG(CAST(average_hourly_rate AS DOUBLE)), 2)
      comment: "Average blended hourly rate across crews. Used to benchmark crew cost competitiveness and budget alignment."
    - name: "avg_productivity_rate"
      expr: ROUND(AVG(CAST(productivity_rate AS DOUBLE)), 4)
      comment: "Average productivity rate across crews. Core field performance KPI; below-benchmark crews trigger intervention."
    - name: "union_crew_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_union_crew = TRUE THEN crew_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crews that are union crews. Informs labor relations strategy and collective agreement cost exposure."
    - name: "total_crew_hourly_rate_exposure"
      expr: SUM(CAST(average_hourly_rate AS DOUBLE))
      comment: "Sum of average hourly rates across all active crews. Approximates total crew labor cost rate exposure for budget planning."
$$;