-- Metric views for domain: workforce | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`workforce_employee_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key workforce headcount and tenure metrics for active employees"
  source: "`oil_gas_ecm`.`workforce`.`employee`"
  filter: termination_date IS NULL
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the employee"
    - name: "department"
      expr: department
      comment: "Department where the employee works"
    - name: "work_location"
      expr: work_location
      comment: "Geographic work location of the employee"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the employee was hired"
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of active employees"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`workforce_employee_average_tenure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average employee tenure metric"
  source: "`oil_gas_ecm`.`workforce`.`employee`"
  filter: termination_date IS NULL
  dimensions:
    - name: "department"
      expr: department
      comment: "Department of the employee"
    - name: "work_location"
      expr: work_location
      comment: "Work location of the employee"
  measures:
    - name: "average_tenure_years"
      expr: AVG(DATEDIFF(current_date, hire_date) / 365.0)
      comment: "Average tenure in years for active employees"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`workforce_payroll_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and overtime metrics for financial analysis"
  source: "`oil_gas_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the payroll record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll amounts"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of the payroll payment"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay paid to employees"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after deductions"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay amount"
    - name: "average_overtime_hours"
      expr: AVG(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Average overtime hours per payroll record"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`workforce_leave_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave request volume and approval metrics for workforce planning"
  source: "`oil_gas_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (e.g., vacation, sick)"
  measures:
    - name: "total_requested_days"
      expr: SUM(CAST(number_of_days AS DOUBLE))
      comment: "Total number of leave days requested"
    - name: "count_requests"
      expr: COUNT(1)
      comment: "Number of leave requests submitted"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training participation and performance metrics for skill development"
  source: "`oil_gas_ecm`.`workforce`.`workforce_training_record`"
  dimensions:
    - name: "training_course_id"
      expr: training_course_id
      comment: "Identifier of the training course"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee who attended the training"
    - name: "training_month"
      expr: DATE_TRUNC('month', training_date)
      comment: "Month when the training occurred"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Indicates if the training was mandatory"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total training sessions recorded"
    - name: "completed_sessions"
      expr: SUM(CASE WHEN attendance_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of training sessions completed"
    - name: "average_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training sessions"
$$;
