-- Metric views for domain: workforce | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_worker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce metrics tracking craft worker headcount, experience distribution, union representation, and safety compliance rates for construction labor management."
  source: "`vibe_construction_v1`.`workforce`.`craft_worker`"
  dimensions:
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment arrangement (direct hire, agency, subcontractor) for workforce composition analysis."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilization status of the craft worker indicating readiness and deployment state."
    - name: "worker_status"
      expr: worker_status
      comment: "Active employment status of the craft worker for headcount and availability tracking."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill proficiency level of the craft worker for capability planning and rate determination."
    - name: "union_affiliation_flag"
      expr: union_affiliation_flag
      comment: "Indicates whether the worker is union-affiliated for labor relations and compliance tracking."
    - name: "osha_certification_flag"
      expr: osha_certification_flag
      comment: "Indicates whether the worker holds valid OSHA certification for safety compliance monitoring."
    - name: "supervisory_role_flag"
      expr: supervisory_role_flag
      comment: "Indicates whether the worker holds a supervisory role for organizational structure analysis."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the worker was hired for tenure and retention cohort analysis."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month the worker was hired for seasonal hiring pattern analysis."
    - name: "mobilization_year"
      expr: YEAR(mobilization_date)
      comment: "Year the worker was mobilized for deployment trend analysis."
  measures:
    - name: "total_craft_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Total unique craft workers for headcount tracking and workforce sizing."
    - name: "union_worker_count"
      expr: COUNT(DISTINCT CASE WHEN union_affiliation_flag = TRUE THEN craft_worker_id END)
      comment: "Count of union-affiliated workers for labor relations planning and compliance."
    - name: "union_representation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN union_affiliation_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workforce that is union-affiliated for labor relations strategy and negotiation planning."
    - name: "osha_certified_worker_count"
      expr: COUNT(DISTINCT CASE WHEN osha_certification_flag = TRUE THEN craft_worker_id END)
      comment: "Count of OSHA-certified workers for safety compliance and site access eligibility."
    - name: "osha_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN osha_certification_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workforce with valid OSHA certification for safety compliance monitoring and risk management."
    - name: "supervisory_worker_count"
      expr: COUNT(DISTINCT CASE WHEN supervisory_role_flag = TRUE THEN craft_worker_id END)
      comment: "Count of workers in supervisory roles for span-of-control and organizational structure analysis."
    - name: "supervisor_to_worker_ratio"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN supervisory_role_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workforce in supervisory roles for organizational efficiency and span-of-control optimization."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor productivity and cost metrics tracking actual hours worked, labor costs, billability, rework rates, and production efficiency for project cost control and workforce optimization."
  source: "`vibe_construction_v1`.`workforce`.`timesheet_line`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date when the work was performed for daily labor tracking and trend analysis."
    - name: "work_year"
      expr: YEAR(work_date)
      comment: "Year of work performance for annual labor trend and productivity analysis."
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work performance for monthly labor tracking and seasonal pattern analysis."
    - name: "work_week"
      expr: DATE_TRUNC('WEEK', work_date)
      comment: "Week of work performance for weekly labor tracking and short-term trend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the timesheet line for workflow and compliance tracking."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the labor hours are billable to the client for revenue recognition and margin analysis."
    - name: "is_rework"
      expr: is_rework
      comment: "Indicates whether the work is rework for quality cost tracking and process improvement."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift identifier for shift-based productivity and cost analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during work for productivity impact analysis and delay justification."
    - name: "posted_to_job_cost_flag"
      expr: posted_to_job_cost_flag
      comment: "Indicates whether the timesheet line has been posted to job cost for financial integration tracking."
    - name: "posted_to_payroll_flag"
      expr: posted_to_payroll_flag
      comment: "Indicates whether the timesheet line has been posted to payroll for payroll processing tracking."
  measures:
    - name: "total_labor_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total labor hours worked for workforce utilization and project progress tracking."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular-time hours worked for baseline labor capacity analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked for premium labor cost tracking and workforce stress monitoring."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked for premium labor cost tracking and schedule pressure analysis."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours worked as overtime for labor cost efficiency and workforce stress assessment."
    - name: "premium_hours_rate"
      expr: ROUND(100.0 * (SUM(CAST(overtime_hours AS DOUBLE)) + SUM(CAST(double_time_hours AS DOUBLE))) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours worked at premium rates (overtime + double-time) for labor cost control and schedule health monitoring."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost incurred for project cost tracking and budget variance analysis."
    - name: "avg_labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Average labor cost per hour worked for labor rate analysis and cost efficiency benchmarking."
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(total_hours AS DOUBLE) ELSE 0 END)
      comment: "Total billable labor hours for revenue recognition and client billing."
    - name: "non_billable_hours"
      expr: SUM(CASE WHEN is_billable = FALSE THEN CAST(total_hours AS DOUBLE) ELSE 0 END)
      comment: "Total non-billable labor hours for overhead cost tracking and efficiency improvement."
    - name: "billability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_billable = TRUE THEN CAST(total_hours AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of labor hours that are billable for revenue efficiency and margin optimization."
    - name: "rework_hours"
      expr: SUM(CASE WHEN is_rework = TRUE THEN CAST(total_hours AS DOUBLE) ELSE 0 END)
      comment: "Total hours spent on rework for quality cost tracking and process improvement prioritization."
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_rework = TRUE THEN CAST(total_hours AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of labor hours spent on rework for quality performance monitoring and cost-of-quality analysis."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity achieved for productivity tracking and earned value analysis."
    - name: "productivity_rate"
      expr: ROUND(SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 4)
      comment: "Production quantity per labor hour for productivity benchmarking and efficiency optimization."
    - name: "total_timesheet_lines"
      expr: COUNT(DISTINCT timesheet_line_id)
      comment: "Total unique timesheet line entries for transaction volume and data quality monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew deployment and mobilization metrics tracking assignment duration, per diem costs, site access compliance, and crew utilization for workforce logistics and cost management."
  source: "`vibe_construction_v1`.`workforce`.`crew_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the crew assignment for workforce deployment tracking and planning."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of crew assignment for workforce allocation and cost categorization."
    - name: "crew_role"
      expr: crew_role
      comment: "Role of the worker within the crew for skill mix and organizational structure analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the assignment for shift-based planning and cost analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the assignment is billable to the client for revenue and margin tracking."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Indicates whether the assignment is eligible for overtime for labor cost forecasting."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Indicates whether the assignment is eligible for per diem for travel cost tracking."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "Indicates whether HSE orientation has been completed for safety compliance tracking."
    - name: "ppe_issued_flag"
      expr: ppe_issued_flag
      comment: "Indicates whether PPE has been issued for safety equipment tracking and compliance."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month when the assignment started for mobilization trend analysis."
    - name: "assignment_start_year"
      expr: YEAR(assignment_start_date)
      comment: "Year when the assignment started for annual workforce deployment analysis."
  measures:
    - name: "total_crew_assignments"
      expr: COUNT(DISTINCT crew_assignment_id)
      comment: "Total unique crew assignments for workforce deployment volume and planning."
    - name: "active_assignments"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'Active' THEN crew_assignment_id END)
      comment: "Count of currently active crew assignments for real-time workforce deployment tracking."
    - name: "billable_assignments"
      expr: COUNT(DISTINCT CASE WHEN billable_flag = TRUE THEN crew_assignment_id END)
      comment: "Count of billable crew assignments for revenue-generating workforce tracking."
    - name: "billable_assignment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN billable_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of crew assignments that are billable for revenue efficiency and margin optimization."
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem costs for travel and subsistence expense tracking and budget management."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate per assignment for travel cost benchmarking and policy compliance."
    - name: "hse_orientation_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hse_orientation_completed_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments with completed HSE orientation for safety compliance monitoring and risk management."
    - name: "ppe_issuance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ppe_issued_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments with PPE issued for safety equipment compliance and readiness tracking."
    - name: "per_diem_eligible_assignments"
      expr: COUNT(DISTINCT CASE WHEN per_diem_eligible_flag = TRUE THEN crew_assignment_id END)
      comment: "Count of assignments eligible for per diem for travel cost forecasting and budget planning."
    - name: "overtime_eligible_assignments"
      expr: COUNT(DISTINCT CASE WHEN overtime_eligible_flag = TRUE THEN crew_assignment_id END)
      comment: "Count of assignments eligible for overtime for premium labor cost forecasting and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor mobilization cost and logistics metrics tracking mobilization expenses, accommodation costs, travel costs, and site readiness for workforce deployment planning and cost control."
  source: "`vibe_construction_v1`.`workforce`.`labor_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the labor mobilization for deployment tracking and planning."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilization (new hire, transfer, rotation) for workforce logistics categorization."
    - name: "travel_mode"
      expr: travel_mode
      comment: "Mode of travel used for mobilization for logistics planning and cost analysis."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Indicates whether accommodation is required for lodging cost tracking and logistics planning."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Indicates whether per diem is eligible for subsistence cost tracking and policy compliance."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "Indicates whether HSE orientation has been completed for safety compliance and site readiness."
    - name: "site_access_badge_issued_flag"
      expr: site_access_badge_issued_flag
      comment: "Indicates whether site access badge has been issued for security compliance and site readiness."
    - name: "mobilization_month"
      expr: DATE_TRUNC('MONTH', mobilization_date)
      comment: "Month of mobilization for seasonal deployment pattern analysis and planning."
    - name: "mobilization_year"
      expr: YEAR(mobilization_date)
      comment: "Year of mobilization for annual workforce deployment trend analysis."
  measures:
    - name: "total_mobilizations"
      expr: COUNT(DISTINCT labor_mobilization_id)
      comment: "Total unique labor mobilizations for workforce deployment volume and logistics planning."
    - name: "total_mobilization_cost"
      expr: SUM(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Total mobilization costs incurred for workforce deployment budget tracking and cost control."
    - name: "avg_mobilization_cost"
      expr: AVG(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Average mobilization cost per worker for deployment cost benchmarking and budget planning."
    - name: "total_travel_cost"
      expr: SUM(CAST(travel_cost_estimate AS DOUBLE))
      comment: "Total travel costs for workforce transportation expense tracking and logistics optimization."
    - name: "total_accommodation_cost"
      expr: SUM(CAST(accommodation_cost_estimate AS DOUBLE))
      comment: "Total accommodation costs for lodging expense tracking and budget management."
    - name: "avg_travel_cost"
      expr: AVG(CAST(travel_cost_estimate AS DOUBLE))
      comment: "Average travel cost per mobilization for transportation cost benchmarking and policy optimization."
    - name: "avg_accommodation_cost"
      expr: AVG(CAST(accommodation_cost_estimate AS DOUBLE))
      comment: "Average accommodation cost per mobilization for lodging cost benchmarking and vendor negotiation."
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem costs for subsistence expense tracking and budget management."
    - name: "accommodation_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accommodation_required_flag = TRUE THEN labor_mobilization_id END) / NULLIF(COUNT(DISTINCT labor_mobilization_id), 0), 2)
      comment: "Percentage of mobilizations requiring accommodation for lodging demand forecasting and cost planning."
    - name: "hse_orientation_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hse_orientation_completed_flag = TRUE THEN labor_mobilization_id END) / NULLIF(COUNT(DISTINCT labor_mobilization_id), 0), 2)
      comment: "Percentage of mobilizations with completed HSE orientation for safety compliance and site readiness tracking."
    - name: "site_access_badge_issuance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN site_access_badge_issued_flag = TRUE THEN labor_mobilization_id END) / NULLIF(COUNT(DISTINCT labor_mobilization_id), 0), 2)
      comment: "Percentage of mobilizations with site access badge issued for security compliance and deployment readiness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor rate and cost structure metrics tracking base rates, overtime rates, burden rates, and total loaded rates for labor cost estimation, bidding, and budget planning."
  source: "`vibe_construction_v1`.`workforce`.`labor_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of labor rate (standard, prevailing wage, union, etc.) for cost categorization and compliance."
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the labor rate (active, expired, pending) for rate management and validity tracking."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level associated with the labor rate for cost estimation and workforce planning."
    - name: "trade_classification"
      expr: trade_classification
      comment: "Trade classification for the labor rate for cost code mapping and budget allocation."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or union jurisdiction for the labor rate for regional cost analysis and compliance."
    - name: "certified_payroll_required_flag"
      expr: certified_payroll_required_flag
      comment: "Indicates whether certified payroll is required for compliance tracking and reporting."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year when the labor rate became effective for rate escalation and trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the labor rate for multi-currency cost analysis and reporting."
  measures:
    - name: "total_labor_rates"
      expr: COUNT(DISTINCT labor_rate_id)
      comment: "Total unique labor rates for rate card complexity and management tracking."
    - name: "avg_base_hourly_rate"
      expr: AVG(CAST(base_hourly_rate AS DOUBLE))
      comment: "Average base hourly rate for labor cost benchmarking and budget estimation."
    - name: "avg_overtime_hourly_rate"
      expr: AVG(CAST(overtime_hourly_rate AS DOUBLE))
      comment: "Average overtime hourly rate for premium labor cost estimation and budget planning."
    - name: "avg_double_time_hourly_rate"
      expr: AVG(CAST(double_time_hourly_rate AS DOUBLE))
      comment: "Average double-time hourly rate for premium labor cost estimation and schedule impact analysis."
    - name: "avg_total_loaded_hourly_rate"
      expr: AVG(CAST(total_loaded_hourly_rate AS DOUBLE))
      comment: "Average total loaded hourly rate including all burdens for true labor cost estimation and margin analysis."
    - name: "avg_overhead_percentage"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied to labor rates for indirect cost allocation and pricing strategy."
    - name: "avg_payroll_burden_percentage"
      expr: AVG(CAST(payroll_burden_percentage AS DOUBLE))
      comment: "Average payroll burden percentage for labor cost loading and true cost calculation."
    - name: "avg_profit_margin_percentage"
      expr: AVG(CAST(profit_margin_percentage AS DOUBLE))
      comment: "Average profit margin percentage applied to labor rates for pricing strategy and margin management."
    - name: "avg_fringe_benefit_rate"
      expr: AVG(CAST(fringe_benefit_rate AS DOUBLE))
      comment: "Average fringe benefit rate for labor cost loading and union compliance."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate for travel cost estimation and policy benchmarking."
    - name: "overtime_premium_percentage"
      expr: ROUND(100.0 * (AVG(CAST(overtime_hourly_rate AS DOUBLE)) - AVG(CAST(base_hourly_rate AS DOUBLE))) / NULLIF(AVG(CAST(base_hourly_rate AS DOUBLE)), 0), 2)
      comment: "Average overtime premium as percentage of base rate for premium labor cost analysis and schedule optimization."
    - name: "burden_multiplier"
      expr: ROUND(AVG(CAST(total_loaded_hourly_rate AS DOUBLE)) / NULLIF(AVG(CAST(base_hourly_rate AS DOUBLE)), 0), 2)
      comment: "Average multiplier from base rate to fully loaded rate for labor cost estimation and pricing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and headcount forecasting metrics tracking planned vs actual headcount, labor hour variance, and workforce composition for strategic workforce planning and project resourcing."
  source: "`vibe_construction_v1`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the staffing plan (draft, approved, active, closed) for planning workflow tracking."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of staffing plan (baseline, forecast, scenario) for planning categorization and analysis."
    - name: "baseline_flag"
      expr: baseline_flag
      comment: "Indicates whether this is the baseline staffing plan for variance analysis and change tracking."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Workforce sourcing strategy (direct hire, agency, subcontractor) for procurement and cost planning."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Indicates whether accommodation is required for lodging cost forecasting and logistics planning."
    - name: "transportation_required_flag"
      expr: transportation_required_flag
      comment: "Indicates whether transportation is required for travel cost forecasting and logistics planning."
    - name: "planning_period_start_year"
      expr: YEAR(planning_period_start_date)
      comment: "Year when the planning period starts for annual workforce planning and trend analysis."
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month when the planning period starts for monthly workforce planning and phasing analysis."
  measures:
    - name: "total_staffing_plans"
      expr: COUNT(DISTINCT staffing_plan_id)
      comment: "Total unique staffing plans for planning activity volume and governance tracking."
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(total_planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours for workforce capacity planning and budget estimation."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours worked for workforce utilization tracking and plan variance analysis."
    - name: "labor_hours_variance"
      expr: SUM(CAST(labor_hours_variance AS DOUBLE))
      comment: "Total variance between planned and actual labor hours for workforce planning accuracy and schedule performance."
    - name: "labor_hours_variance_percentage"
      expr: ROUND(100.0 * SUM(CAST(labor_hours_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_planned_labor_hours AS DOUBLE)), 0), 2)
      comment: "Percentage variance between planned and actual labor hours for workforce planning accuracy assessment and continuous improvement."
    - name: "avg_planned_headcount"
      expr: AVG(CAST(total_planned_headcount AS DOUBLE))
      comment: "Average planned headcount across staffing plans for workforce sizing and capacity planning."
    - name: "avg_peak_headcount"
      expr: AVG(CAST(peak_headcount AS DOUBLE))
      comment: "Average peak headcount across staffing plans for maximum workforce demand forecasting and logistics planning."
    - name: "avg_craft_labor_headcount"
      expr: AVG(CAST(craft_labor_headcount AS DOUBLE))
      comment: "Average craft labor headcount for direct labor workforce planning and productivity analysis."
    - name: "avg_supervision_headcount"
      expr: AVG(CAST(supervision_headcount AS DOUBLE))
      comment: "Average supervision headcount for organizational structure planning and span-of-control analysis."
    - name: "avg_subcontractor_headcount"
      expr: AVG(CAST(subcontractor_headcount AS DOUBLE))
      comment: "Average subcontractor headcount for procurement planning and make-vs-buy analysis."
    - name: "accommodation_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accommodation_required_flag = TRUE THEN staffing_plan_id END) / NULLIF(COUNT(DISTINCT staffing_plan_id), 0), 2)
      comment: "Percentage of staffing plans requiring accommodation for lodging cost forecasting and logistics planning."
    - name: "transportation_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN transportation_required_flag = TRUE THEN staffing_plan_id END) / NULLIF(COUNT(DISTINCT staffing_plan_id), 0), 2)
      comment: "Percentage of staffing plans requiring transportation for travel cost forecasting and logistics planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification and compliance metrics tracking certification coverage, expiry rates, regulatory compliance, and training hours for safety compliance, site access eligibility, and workforce qualification management."
  source: "`vibe_construction_v1`.`workforce`.`craft_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (safety, trade, regulatory) for compliance categorization and tracking."
    - name: "certification_level"
      expr: certification_level
      comment: "Level or grade of the certification for skill proficiency and qualification tracking."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification for compliance validation and audit readiness."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for accreditation tracking and vendor management."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country code of the issuing body for international compliance and reciprocity tracking."
    - name: "project_requirement_flag"
      expr: project_requirement_flag
      comment: "Indicates whether the certification is a project requirement for site access and eligibility tracking."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the certification is required for regulatory compliance for legal risk management."
    - name: "site_access_required_flag"
      expr: site_access_required_flag
      comment: "Indicates whether the certification is required for site access for security and safety compliance."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the certification requires renewal for expiry tracking and workforce planning."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year when the certification was issued for certification trend and training program analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year when the certification expires for expiry forecasting and renewal planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT craft_certification_id)
      comment: "Total unique certifications for workforce qualification tracking and compliance monitoring."
    - name: "project_required_certifications"
      expr: COUNT(DISTINCT CASE WHEN project_requirement_flag = TRUE THEN craft_certification_id END)
      comment: "Count of certifications that are project requirements for site access eligibility and workforce readiness."
    - name: "regulatory_compliance_certifications"
      expr: COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = TRUE THEN craft_certification_id END)
      comment: "Count of certifications required for regulatory compliance for legal risk management and audit readiness."
    - name: "site_access_certifications"
      expr: COUNT(DISTINCT CASE WHEN site_access_required_flag = TRUE THEN craft_certification_id END)
      comment: "Count of certifications required for site access for security compliance and workforce deployment."
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = TRUE THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications that meet regulatory compliance requirements for legal risk assessment and compliance monitoring."
    - name: "site_access_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN site_access_required_flag = TRUE THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications that enable site access for workforce deployment readiness and security compliance."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours_required AS DOUBLE))
      comment: "Total training hours required for certifications for training program planning and resource allocation."
    - name: "avg_training_hours_per_certification"
      expr: AVG(CAST(training_hours_required AS DOUBLE))
      comment: "Average training hours required per certification for training program benchmarking and cost estimation."
    - name: "renewal_required_certifications"
      expr: COUNT(DISTINCT CASE WHEN renewal_required_flag = TRUE THEN craft_certification_id END)
      comment: "Count of certifications requiring renewal for expiry tracking and workforce planning."
    - name: "renewal_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN renewal_required_flag = TRUE THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications requiring renewal for workforce planning and training budget forecasting."
$$;