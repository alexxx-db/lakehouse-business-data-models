-- Metric views for domain: workforce | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_employee_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core headcount and tenure metrics for workforce planning"
  source: "`vibe_water_utilities_v1`.`workforce`.`employee`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department code the employee belongs to"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g., Full-Time, Part-Time)"
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired"
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Indicates if employee is a union member"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total number of unique employees in the workforce"
    - name: "active_employee_count"
      expr: SUM(CASE WHEN employment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of employees whose employment status is Active"
    - name: "average_years_of_service"
      expr: AVG(DATEDIFF(current_date(), hire_date) / 365.0)
      comment: "Average tenure of employees in years"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_labor_timesheet_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost and productivity metrics derived from timesheets"
  source: "`vibe_water_utilities_v1`.`workforce`.`labor_timesheet`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the labor"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee who logged the timesheet"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of labor activity"
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period for the timesheet"
    - name: "timesheet_date"
      expr: timesheet_date
      comment: "Date of the timesheet entry"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total labor hours recorded"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost incurred"
    - name: "average_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour"
    - name: "timesheet_record_count"
      expr: COUNT(1)
      comment: "Number of timesheet records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance review outcomes for talent management"
  source: "`vibe_water_utilities_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "reviewer_employee_id"
      expr: reviewer_employee_id
      comment: "Employee who performed the review"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (e.g., Annual, Mid-year)"
    - name: "review_period_start_date"
      expr: review_period_start_date
      comment: "Start date of the review period"
  measures:
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "avg_merit_increase_percentage"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage awarded"
    - name: "review_record_count"
      expr: COUNT(1)
      comment: "Number of performance review records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety performance and risk exposure metrics"
  source: "`vibe_water_utilities_v1`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of the safety incident"
    - name: "incident_date"
      expr: incident_date
      comment: "Date the incident occurred"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the incident took place"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the incident"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee primarily associated with the incident"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of safety incidents reported"
    - name: "recordable_incident_count"
      expr: SUM(CASE WHEN osha_recordable_flag THEN 1 ELSE 0 END)
      comment: "Count of OSHA recordable incidents"
    - name: "total_property_damage"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Aggregate property damage cost from incidents"
    - name: "total_environmental_release_volume"
      expr: SUM(CAST(environmental_release_volume AS DOUBLE))
      comment: "Total volume of environmental releases"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training investment and effectiveness metrics"
  source: "`vibe_water_utilities_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_course_id"
      expr: training_course_id
      comment: "Identifier of the training course"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee who took the training"
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training (e.g., Completed, InProgress)"
    - name: "training_type"
      expr: training_type
      comment: "Classification of training (e.g., Safety, Technical)"
    - name: "completion_date"
      expr: completion_date
      comment: "Date the training was completed"
  measures:
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for employee training"
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average score achieved across training records"
    - name: "certified_employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with training records"
    - name: "training_completion_count"
      expr: SUM(CASE WHEN training_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of training records marked as Completed"
$$;