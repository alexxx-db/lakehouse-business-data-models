-- Metric views for domain: workforce | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payroll financial KPIs for executive compensation oversight"
  source: "`agriculture_ecm`.`workforce`.`payroll`"
  dimensions:
    - name: "pay_period_month"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Payroll month for time‑based analysis"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier to allocate costs"
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type (e.g., salary, hourly)"
  measures:
    - name: "total_gross_wages"
      expr: SUM(CAST(gross_wages AS DOUBLE))
      comment: "Total gross wages paid in the payroll period"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay after deductions"
    - name: "average_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across all employees"
    - name: "total_overtime_earnings"
      expr: SUM(CAST(overtime_earnings AS DOUBLE))
      comment: "Total overtime earnings paid"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "three_fourths_guarantee_met_pct"
      expr: AVG(CASE WHEN three_fourths_guarantee_met THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of payroll rows where the three-fourths guarantee was met"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_labor_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor compliance metrics to monitor wage and hour regulations"
  source: "`agriculture_ecm`.`workforce`.`labor_compliance`"
  dimensions:
    - name: "growing_season_id"
      expr: growing_season_id
      comment: "Growing season identifier for seasonal analysis"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the worker"
    - name: "program_type"
      expr: program_type
      comment: "Compliance program type"
  measures:
    - name: "total_actual_hours_offered"
      expr: SUM(CAST(actual_hours_offered AS DOUBLE))
      comment: "Total hours of labor offered under contracts"
    - name: "total_actual_wage_cost"
      expr: SUM(actual_hourly_wage * actual_hours_offered)
      comment: "Total wage cost based on actual hourly wage and hours offered"
    - name: "average_aewr_hourly_rate"
      expr: AVG(CAST(aewr_hourly_rate AS DOUBLE))
      comment: "Average AEWR (Agricultural Employment Wage Rate) hourly rate"
    - name: "aewr_compliance_rate_pct"
      expr: AVG(CASE WHEN aewr_compliance_status = 'Compliant' THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of records compliant with AEWR"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit enrollment cost metrics for cost‑control and employee benefit strategy"
  source: "`agriculture_ecm`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (e.g., health, dental)"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Effective month of the enrollment"
  measures:
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contributions to benefit plans"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contributions to benefit plans"
    - name: "average_annual_employee_premium"
      expr: AVG(CAST(annual_employee_premium AS DOUBLE))
      comment: "Average annual premium per employee"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time entry metrics to assess labor utilization and cost"
  source: "`agriculture_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: DATE_TRUNC('day', work_date)
      comment: "Date of the time entry"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (e.g., day, night)"
  measures:
    - name: "total_hours_worked"
      expr: SUM(regular_hours + overtime_hours)
      comment: "Total hours worked including overtime"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay for the time entries"
    - name: "average_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across time entries"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident metrics for risk management and compliance"
  source: "`agriculture_ecm`.`workforce`.`safety_event`"
  dimensions:
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_datetime)
      comment: "Month of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Category of safety incident"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity level of the incident"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Count of safety incidents recorded"
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total monetary claim amount associated with incidents"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_training_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training event metrics to monitor workforce development and compliance"
  source: "`agriculture_ecm`.`workforce`.`training_event`"
  dimensions:
    - name: "training_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the training was scheduled"
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., safety, technical)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery (e.g., in‑person, online)"
  measures:
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total cost incurred for training events"
    - name: "average_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across trainings"
    - name: "completed_training_count"
      expr: SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of trainings completed"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan vs. actual labor cost and hour metrics for strategic workforce budgeting"
  source: "`agriculture_ecm`.`workforce`.`plan`"
  dimensions:
    - name: "plan_year"
      expr: year
      comment: "Fiscal year of the plan"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the plan (e.g., active, completed)"
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity associated with the plan"
  measures:
    - name: "total_actual_labor_cost_usd"
      expr: SUM(CAST(actual_labor_cost_usd AS DOUBLE))
      comment: "Total actual labor cost in USD for the plan period"
    - name: "total_planned_labor_cost_usd"
      expr: SUM(CAST(planned_labor_cost_usd AS DOUBLE))
      comment: "Total planned labor cost in USD for the plan period"
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours"
$$;
