-- Metric views for domain: workforce | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`workforce_time_entry_overtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overtime and labor utilization from time entry records"
  source: "`grocery_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "associate_id"
      expr: associate_id
      comment: "Associate ID for the time entry"
    - name: "department_code"
      expr: department_code
      comment: "Department code associated with the time entry"
    - name: "work_date"
      expr: work_date
      comment: "Date of the work entry"
    - name: "job_code"
      expr: job_code
      comment: "Job code for the work performed"
  measures:
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked (including regular and overtime)"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budget planning metrics"
  source: "`grocery_ecm`.`workforce`.`labor_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "department_id"
      expr: department_id
      comment: "Department identifier"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
  measures:
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Total budgeted full-time equivalents"
    - name: "average_labor_cost_percent_target"
      expr: AVG(CAST(labor_cost_percent_target AS DOUBLE))
      comment: "Average labor cost percent target across budget records"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`workforce_payroll_run_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key payroll financial aggregates"
  source: "`grocery_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the payroll period"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the payroll run"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (e.g., biweekly, monthly)"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll amount"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net payroll amount after deductions"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total payroll deductions"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`workforce_performance_review_scores`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review rating metrics"
  source: "`grocery_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department code of the reviewed associate"
    - name: "review_cycle_year"
      expr: review_cycle_year
      comment: "Fiscal year of the review cycle"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g., Completed, In Progress)"
  measures:
    - name: "average_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "average_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score"
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Number of performance reviews recorded"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`workforce_certification_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification compliance and coverage metrics"
  source: "`grocery_ecm`.`workforce`.`certification`"
  dimensions:
    - name: "department_id"
      expr: department_id
      comment: "Department associated with the certification"
    - name: "job_profile_id"
      expr: job_profile_id
      comment: "Job profile linked to the certification"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where certification applies"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired)"
    - name: "certification_category"
      expr: certification_category
      comment: "Category of the certification"
  measures:
    - name: "pass_rate"
      expr: AVG(CASE WHEN passed THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of certifications that have been passed"
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certification records"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`workforce_leave_request_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave request volume and approval metrics"
  source: "`grocery_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (e.g., Vacation, Sick, FMLA)"
    - name: "associate_id"
      expr: associate_id
      comment: "Associate ID for whom the leave is taken"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the leave request"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the leave request"
  measures:
    - name: "total_requested_hours"
      expr: SUM(CAST(requested_hours AS DOUBLE))
      comment: "Total leave hours requested"
    - name: "total_approved_hours"
      expr: SUM(CAST(approved_hours AS DOUBLE))
      comment: "Total leave hours approved"
    - name: "average_approved_hours"
      expr: AVG(CAST(approved_hours AS DOUBLE))
      comment: "Average approved leave hours per request"
$$;
