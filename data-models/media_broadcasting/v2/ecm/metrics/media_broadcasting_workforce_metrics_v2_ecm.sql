-- Metric views for domain: workforce | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost, earnings, deductions and net pay analytics for labor cost steering across cost centers and pay periods."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_end"
      expr: DATE_TRUNC('MONTH', pay_period_end_date)
      comment: "Month of the pay period end for trending payroll cost over time."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Processing status of the payroll record (e.g. processed, pending, void)."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Payroll frequency (weekly, biweekly, monthly) for cadence-based cost analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "How payment was disbursed for treasury/operational analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll amounts for multi-entity consolidation."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost — the primary labor cost driver for budget vs actual steering."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees, relevant to cash outflow planning."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions withheld, used for benefits/tax remittance reconciliation."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay AS DOUBLE))
      comment: "Total overtime pay — a key efficiency/cost-control signal for staffing decisions."
    - name: "total_bonus_pay"
      expr: SUM(CAST(bonus_pay AS DOUBLE))
      comment: "Total bonus payouts for variable compensation spend management."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record, useful for per-employee cost benchmarking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours, a leading indicator of staffing gaps and burnout risk."
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Number of payroll records processed for volume and throughput monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce headcount, composition and attrition analytics for organizational planning."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on-leave) for headcount segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, contractor) for workforce mix analysis."
    - name: "job_level"
      expr: job_level
      comment: "Job level for seniority-band composition analysis."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for hiring trend analysis."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination for attrition trend analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for separation to distinguish voluntary vs involuntary attrition."
  measures:
    - name: "headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employee count — the foundational headcount KPI for org planning."
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Active employee count for current staffing level steering."
    - name: "terminated_count"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of separated employees, the numerator for attrition rate."
    - name: "attrition_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Share of the workforce that has separated — a core retention KPI for leadership."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting demand, time-to-fill and open-requisition analytics for talent acquisition steering."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the requisition (open, filled, cancelled) for pipeline health."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (new, replacement) for demand-mix analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the requisition for prioritization of recruiting effort."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the requisition opened for demand trend analysis."
    - name: "eeo_job_category"
      expr: eeo_job_category
      comment: "EEO job category for diversity-in-hiring reporting."
  measures:
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Total requisitions raised, measuring overall hiring demand."
    - name: "open_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN requisition_id END)
      comment: "Count of currently open requisitions — a key recruiting backlog KPI."
    - name: "avg_days_to_fill"
      expr: AVG(CAST(DATEDIFF(close_date, open_date) AS DOUBLE))
      comment: "Average days from open to close, the primary time-to-fill efficiency KPI."
    - name: "avg_salary_range_max"
      expr: AVG(CAST(salary_range_maximum AS DOUBLE))
      comment: "Average top-of-range salary offered, for compensation budgeting of open roles."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_interview_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interview funnel and candidate evaluation analytics for recruiting effectiveness."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`interview_event`"
  dimensions:
    - name: "interview_status"
      expr: interview_status
      comment: "Status of the interview for funnel completion tracking."
    - name: "interview_type"
      expr: interview_type
      comment: "Type of interview (phone, technical, panel) for stage-based analysis."
    - name: "hire_recommendation"
      expr: hire_recommendation
      comment: "Interviewer recommendation outcome for selection-quality analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of the scheduled interview for activity trend analysis."
    - name: "interview_format"
      expr: interview_format
      comment: "Format (in-person, video) for logistics and cost analysis."
  measures:
    - name: "interview_count"
      expr: COUNT(1)
      comment: "Total interviews conducted, measuring recruiting activity volume."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall candidate rating, a quality-of-pipeline signal."
    - name: "advance_count"
      expr: COUNT(DISTINCT CASE WHEN advance_to_next_round = true THEN interview_event_id END)
      comment: "Interviews resulting in advancement, numerator for pass-through rate."
    - name: "advance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN advance_to_next_round = true THEN interview_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of interviews advancing to the next round — a funnel efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave demand, approval and absence analytics for workforce availability planning."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (PTO, sick, FMLA) for absence-mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the leave request for workflow monitoring."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the leave was requested for seasonality analysis."
    - name: "fmla_protected_flag"
      expr: fmla_protected_flag
      comment: "Whether leave is FMLA-protected for compliance reporting."
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Whether leave is paid for cost-impact segmentation."
  measures:
    - name: "leave_request_count"
      expr: COUNT(1)
      comment: "Total leave requests, measuring overall absence demand."
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total leave days requested — a key availability/coverage planning metric."
    - name: "total_actual_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total actual leave days taken, for true absence cost analysis."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN leave_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of leave requests approved — a workflow/policy KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance rating distribution and talent-development analytics for talent management."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year) for cycle-based analysis."
    - name: "review_status"
      expr: review_status
      comment: "Status of the review for completion tracking."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of the review for cycle trend analysis."
    - name: "promotion_eligible_flag"
      expr: promotion_eligible_flag
      comment: "Whether the employee is flagged promotion-eligible for talent planning."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for rating-consistency governance."
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Total performance reviews completed, measuring cycle coverage."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating — a core talent-health KPI."
    - name: "avg_final_approved_rating"
      expr: AVG(CAST(final_approved_rating AS DOUBLE))
      comment: "Average post-calibration approved rating for fair-distribution monitoring."
    - name: "promotion_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN promotion_eligible_flag = true THEN performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of reviews flagging promotion eligibility — a talent-pipeline KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logged-hours, overtime and time-tracking analytics for labor utilization and project costing."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the timesheet for workflow control."
    - name: "pay_period_end"
      expr: DATE_TRUNC('MONTH', pay_period_end_date)
      comment: "Month of the pay period for hours trending."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for cost-band labor analysis."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether the timesheet was processed in payroll for reconciliation."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours logged — base labor capacity metric."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours, a key cost-control and burnout-risk signal."
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours_approved AS DOUBLE))
      comment: "Total approved hours, the basis for labor cost allocation."
    - name: "overtime_share_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours_approved AS DOUBLE)), 0), 2)
      comment: "Overtime as a share of approved hours — an efficiency/staffing-adequacy KPI."
    - name: "timesheet_count"
      expr: COUNT(1)
      comment: "Number of timesheets submitted for volume monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, cost and compliance analytics for learning and development steering."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the enrollment (enrolled, completed, withdrawn) for completion tracking."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for activity trend analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the training is mandatory for compliance-coverage analysis."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether training is regulatory-required for compliance steering."
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Delivery method (online, in-person) for cost/logistics analysis."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total training enrollments, measuring L&D participation volume."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training spend — a key L&D investment KPI."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of enrollments completed — a core training-effectiveness KPI."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score, a quality-of-learning outcome signal."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_separation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Separation, severance and exit analytics for retention and offboarding cost management."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`separation_record`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (voluntary, involuntary) for attrition-mix analysis."
    - name: "separation_reason_code"
      expr: separation_reason_code
      comment: "Coded separation reason for root-cause attrition analysis."
    - name: "separation_month"
      expr: DATE_TRUNC('MONTH', separation_date)
      comment: "Month of separation for attrition trend analysis."
    - name: "rehire_eligibility_flag"
      expr: rehire_eligibility_flag
      comment: "Whether the leaver is rehire-eligible for boomerang-talent planning."
  measures:
    - name: "separation_count"
      expr: COUNT(1)
      comment: "Total separations, the core attrition volume KPI."
    - name: "total_severance_amount"
      expr: SUM(CAST(severance_amount AS DOUBLE))
      comment: "Total severance paid — a key offboarding cost metric."
    - name: "avg_severance_weeks"
      expr: AVG(CAST(severance_weeks AS DOUBLE))
      comment: "Average severance weeks granted, for offboarding policy benchmarking."
    - name: "exit_interview_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exit_interview_completed_flag = true THEN separation_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of separations with completed exit interviews — a feedback-capture governance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation and employer-contribution cost analytics for total-rewards steering."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Benefit plan type (medical, dental, 401k) for benefits-mix analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the benefit enrollment for participation tracking."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee, family) for cost segmentation."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month coverage became effective for enrollment trend analysis."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total benefit enrollments, measuring participation volume."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contribution — a key total-rewards cost KPI."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee benefit contribution for cost-sharing analysis."
    - name: "avg_total_premium"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average total premium per enrollment for plan cost benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goal-setting and achievement analytics for performance-management and OKR steering."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`goal`"
  dimensions:
    - name: "goal_type"
      expr: goal_type
      comment: "Type of goal for objective-mix analysis."
    - name: "progress_status"
      expr: progress_status
      comment: "Progress status of the goal for execution tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the goal for focus-allocation analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the goal is due for delivery-timeline analysis."
  measures:
    - name: "goal_count"
      expr: COUNT(1)
      comment: "Total goals tracked, measuring objective-setting coverage."
    - name: "avg_achievement_pct"
      expr: AVG(CAST(achievement_percentage AS DOUBLE))
      comment: "Average goal achievement percentage — a core performance-execution KPI."
    - name: "completed_goal_count"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN goal_id END)
      comment: "Count of completed goals, numerator for completion rate."
    - name: "goal_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN goal_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of goals completed — an execution-effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_applicant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting funnel and applicant quality metrics"
  source: "`vibe_media_broadcasting_v1`.`workforce`.`applicant`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date the application was submitted"
    - name: "application_source"
      expr: application_source
      comment: "Source channel of the application (e.g., job board, referral)"
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "country_code"
      expr: country_code
      comment: "Country code of applicant's address"
    - name: "degree_field"
      expr: degree_field
      comment: "Field of study for the highest degree"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of applicant records submitted"
    - name: "avg_years_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience reported by applicants"
    - name: "avg_desired_salary"
      expr: AVG(CAST(desired_salary_amount AS DOUBLE))
      comment: "Average desired salary amount across applicants"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation plan financial and eligibility metrics"
  source: "`vibe_media_broadcasting_v1`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of the compensation plan"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade associated with the plan"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (e.g., biweekly, monthly)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan"
    - name: "union_code"
      expr: union_code
      comment: "Union code if the employee is unionized"
  measures:
    - name: "count_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with a compensation plan"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary amount across all compensation plans"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary amount"
    - name: "total_bonus_eligible"
      expr: SUM(CASE WHEN bonus_eligible THEN 1 ELSE 0 END)
      comment: "Count of employees eligible for bonus"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly employees"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic headcount planning metrics for workforce planning"
  source: "`vibe_media_broadcasting_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit the plan applies to"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (e.g., growth, reduction)"
    - name: "plan_approval_status"
      expr: plan_approval_status
      comment: "Current approval status of the plan"
  measures:
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte_count AS DOUBLE))
      comment: "Total approved full-time equivalents in the headcount plan"
    - name: "total_current_filled_fte"
      expr: SUM(CAST(current_filled_fte AS DOUBLE))
      comment: "Total currently filled FTEs"
    - name: "total_variance_fte"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Aggregate variance between planned and actual FTEs"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated for headcount"
$$;