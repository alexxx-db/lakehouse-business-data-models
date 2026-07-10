-- Metric views for domain: workforce | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_staff_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and compensation metrics. Provides executive-level visibility into active staff composition, salary investment, and attrition risk across the organisation."
  source: "`vibe_ngo_v1`.`workforce`.`staff_member`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the staff member (e.g. Active, On Leave, Terminated) — primary filter for headcount analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment arrangement (e.g. Full-Time, Part-Time, Consultant) — used to segment workforce cost and headcount."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract classification (e.g. National, International, Volunteer) — critical for donor reporting and compliance segmentation."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country where the staff member is deployed — enables geographic workforce distribution analysis."
    - name: "department"
      expr: department
      comment: "Organisational department of the staff member — used for departmental headcount and cost allocation."
    - name: "job_grade"
      expr: job_grade
      comment: "Salary grade band of the staff member — used for compensation equity and grade distribution analysis."
    - name: "gender"
      expr: gender
      comment: "Self-identified gender of the staff member — used for diversity and inclusion reporting. PII-sensitive."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the staff member — used for international vs national staff ratio reporting. PII-sensitive."
    - name: "rehire_eligible"
      expr: rehire_eligible
      comment: "Flag indicating whether the staff member is eligible for rehire — used in talent pipeline and attrition quality analysis."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of staff member records. Used as the baseline headcount figure for workforce planning and donor reporting."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active staff members. The primary operational headcount KPI used in steering meetings and board decks."
    - name: "total_annual_salary_usd"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Sum of base salary amounts across all staff. Drives total compensation cost visibility for budget owners and finance leadership."
    - name: "avg_annual_salary_usd"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per staff member. Used for compensation benchmarking and equity analysis across grades and geographies."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE allocation across staff. Indicates workforce utilisation intensity and part-time vs full-time balance."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Sum of FTE percentages expressed as total FTE equivalent. Used for capacity planning and grant effort allocation reporting."
    - name: "separated_staff_count"
      expr: COUNT(CASE WHEN separation_date IS NOT NULL THEN 1 END)
      comment: "Count of staff members with a recorded separation date. Used to compute attrition rates and inform retention strategy."
    - name: "avg_years_of_service"
      expr: AVG(DATEDIFF(CURRENT_DATE(), hire_date) / 365.25)
      comment: "Average tenure in years across staff. Longer average tenure signals organisational stability; declining tenure signals retention risk."
    - name: "expat_staff_count"
      expr: COUNT(CASE WHEN contract_type = 'International' THEN 1 END)
      comment: "Count of internationally contracted (expatriate) staff. Drives expat package cost forecasting and duty-of-care planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll execution and cost metrics. Provides finance and HR leadership with visibility into payroll spend, tax obligations, and employer contribution liabilities by period, country, and fund."
  source: "`vibe_ngo_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Month bucket of the payroll period start date — enables trend analysis of payroll costs over time."
    - name: "country_code"
      expr: country_code
      comment: "Country in which the payroll run was executed — used for geographic cost allocation and statutory compliance reporting."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Processing status of the payroll run (e.g. Draft, Approved, Posted) — used to filter for completed vs in-progress runs."
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Type of payroll run (e.g. Regular, Off-Cycle, Retroactive) — used to isolate exceptional payroll costs."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay cycle (e.g. Monthly, Bi-Weekly) — used to normalise payroll cost comparisons across entities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payroll run was processed — used for multi-currency payroll cost consolidation."
    - name: "fund_code"
      expr: fund_code
      comment: "Donor fund code charged for this payroll run — critical for grant-funded payroll cost allocation and donor reporting."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the payroll run — used for program-level staff cost attribution."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flag indicating whether the payroll run includes retroactive adjustments — used to isolate and investigate retroactive cost spikes."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll cost across all runs. The primary payroll expenditure KPI used in budget vs actual reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees. Used for cash flow planning and bank funding requirements."
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total statutory tax withheld across payroll runs. Used for tax remittance compliance and liability reporting."
    - name: "total_employer_contributions"
      expr: SUM(CAST(total_employer_contributions AS DOUBLE))
      comment: "Total employer-side contributions (pension, social security, etc.). Represents the true employment cost beyond gross salary."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total employee deductions across payroll runs. Used to reconcile gross-to-net pay and validate payroll accuracy."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run. Used to detect anomalous payroll runs that deviate significantly from the norm."
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Total number of payroll runs executed. Used to verify payroll cycle completeness and detect missing or duplicate runs."
    - name: "retroactive_run_count"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN 1 END)
      comment: "Count of retroactive payroll runs. High retroactive counts signal payroll process quality issues requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_payslip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual payslip-level compensation metrics. Enables detailed analysis of allowance composition, deduction patterns, and net pay distribution across the workforce."
  source: "`vibe_ngo_v1`.`workforce`.`payslip`"
  dimensions:
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Month bucket of the pay period — enables monthly payroll cost trend analysis at the individual level."
    - name: "country_code"
      expr: country_code
      comment: "Country of the payslip — used for geographic compensation cost analysis."
    - name: "payslip_status"
      expr: payslip_status
      comment: "Processing status of the payslip — used to filter for finalised payslips in cost reporting."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which net pay was disbursed — used for multi-currency compensation analysis."
    - name: "payroll_group"
      expr: payroll_group
      comment: "Payroll group classification — used to segment compensation costs by staff category or entity."
    - name: "is_correction"
      expr: is_correction
      comment: "Flag indicating whether this payslip is a correction — used to measure payroll accuracy and rework rates."
    - name: "is_off_cycle"
      expr: is_off_cycle
      comment: "Flag indicating an off-cycle payslip — used to track exceptional payment frequency and associated administrative cost."
    - name: "program_code"
      expr: program_code
      comment: "Program code for grant-funded payslips — used for program-level staff cost attribution."
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross salary across all payslips. Primary compensation cost measure for budget vs actual analysis."
    - name: "total_net_pay_payment_currency"
      expr: SUM(CAST(net_pay_payment_currency AS DOUBLE))
      comment: "Total net pay in payment currency. Used for cash disbursement planning and bank funding requirements."
    - name: "total_allowances"
      expr: SUM(CAST(total_allowances AS DOUBLE))
      comment: "Total allowances paid (hardship, housing, field, transport, expat). Used to understand the allowance burden relative to base salary."
    - name: "total_hardship_allowance"
      expr: SUM(CAST(hardship_allowance AS DOUBLE))
      comment: "Total hardship allowances paid. Used to quantify the cost of field deployments in difficult environments."
    - name: "total_housing_allowance"
      expr: SUM(CAST(housing_allowance AS DOUBLE))
      comment: "Total housing allowances paid. Used for duty-station cost-of-living analysis and package benchmarking."
    - name: "total_income_tax_deduction"
      expr: SUM(CAST(income_tax_deduction AS DOUBLE))
      comment: "Total income tax withheld at payslip level. Used for tax liability reconciliation and statutory compliance."
    - name: "total_pension_deduction"
      expr: SUM(CAST(pension_deduction AS DOUBLE))
      comment: "Total employee pension contributions deducted. Used for pension scheme liability and compliance reporting."
    - name: "total_employer_pension_contribution"
      expr: SUM(CAST(employer_pension_contribution AS DOUBLE))
      comment: "Total employer pension contributions. Represents a significant non-salary employment cost tracked for total compensation reporting."
    - name: "correction_payslip_count"
      expr: COUNT(CASE WHEN is_correction = TRUE THEN 1 END)
      comment: "Count of correction payslips. High correction rates indicate payroll processing quality issues requiring process improvement."
    - name: "avg_gross_salary_per_payslip"
      expr: AVG(CAST(gross_salary AS DOUBLE))
      comment: "Average gross salary per payslip. Used for compensation benchmarking and detecting outlier pay records."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilisation and balance metrics. Provides HR and operations leadership with visibility into leave consumption patterns, balance liabilities, and approval cycle efficiency."
  source: "`vibe_ngo_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave requested (e.g. Annual, Sick, R&R, Maternity) — primary dimension for leave liability and utilisation analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the leave request — used to distinguish approved, pending, and rejected requests."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of the staff member's duty station — used for geographic leave pattern analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category (e.g. National, International) — used to compare leave utilisation across employment categories."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type of the staff member — used to segment leave entitlement and utilisation by contract class."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year to which the request belongs — used for annual leave liability and carry-forward analysis."
    - name: "is_rnr_eligible"
      expr: is_rnr_eligible
      comment: "Flag indicating R&R eligibility — used to track R&R leave consumption and duty-of-care compliance."
    - name: "requested_start_date"
      expr: DATE_TRUNC('month', requested_start_date)
      comment: "Month bucket of leave start date — used for seasonal leave demand planning."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests submitted. Baseline volume metric for leave management workload and trend analysis."
    - name: "total_days_requested"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested. Used to forecast operational capacity gaps and plan coverage arrangements."
    - name: "total_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total leave days actually taken. Compared against entitlement to assess leave utilisation rates."
    - name: "total_leave_balance_liability"
      expr: SUM(CAST(leave_balance_after AS DOUBLE))
      comment: "Sum of leave balances after each request. Represents the organisation's accrued leave liability requiring financial provisioning."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance remaining after requests. High averages indicate under-utilisation and growing leave liability."
    - name: "total_carry_forward_days"
      expr: SUM(CAST(carry_forward_days AS DOUBLE))
      comment: "Total leave days carried forward. Elevated carry-forward signals operational pressure preventing staff from taking leave — a wellbeing risk."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved leave requests. Used to compute approval rates and assess leave management responsiveness."
    - name: "avg_days_per_request"
      expr: AVG(CAST(requested_days AS DOUBLE))
      comment: "Average number of days per leave request. Used to understand leave consumption patterns by type and category."
    - name: "total_toil_hours_accrued"
      expr: SUM(CAST(toil_hours_accrued AS DOUBLE))
      comment: "Total time-off-in-lieu hours accrued. High TOIL accrual indicates excessive overtime and potential staff burnout risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics. Provides HR and executive leadership with visibility into rating distributions, review completion, and performance quality across the workforce."
  source: "`vibe_ngo_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Status of the performance review (e.g. Draft, Submitted, Calibrated, Closed) — used to track review cycle completion."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of review cycle (e.g. Annual, Mid-Year, Probation) — used to segment performance data by review cadence."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating label — primary dimension for rating distribution analysis and talent segmentation."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of the reviewed staff member — used for geographic performance distribution analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the reviewed employee — used to compare performance outcomes across employment categories."
    - name: "period_start_date"
      expr: DATE_TRUNC('year', period_start_date)
      comment: "Year bucket of the review period start — used for year-over-year performance trend analysis."
    - name: "pip_required"
      expr: pip_required
      comment: "Flag indicating whether a performance improvement plan was recommended — used to track underperformance prevalence."
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Flag indicating a promotion recommendation — used for talent pipeline and succession planning analysis."
    - name: "retention_risk_flag"
      expr: retention_risk_flag
      comment: "Flag indicating the employee is at retention risk — used to prioritise retention interventions."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews. Baseline metric for review cycle coverage and completion tracking."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Primary KPI for workforce performance quality — tracked by leadership to assess organisational health."
    - name: "avg_objective_achievement_score"
      expr: AVG(CAST(objective_achievement_score AS DOUBLE))
      comment: "Average objective achievement score. Measures how effectively staff are meeting their set goals — directly linked to programme delivery quality."
    - name: "avg_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score. Used to identify capability gaps requiring learning and development investment."
    - name: "pip_recommended_count"
      expr: COUNT(CASE WHEN pip_required = TRUE THEN 1 END)
      comment: "Count of reviews where a PIP was recommended. Used to track underperformance prevalence and HR intervention workload."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommendation = TRUE THEN 1 END)
      comment: "Count of reviews with a promotion recommendation. Used for succession planning and career progression pipeline analysis."
    - name: "retention_risk_count"
      expr: COUNT(CASE WHEN retention_risk_flag = TRUE THEN 1 END)
      comment: "Count of staff flagged as retention risks. Directly informs targeted retention investment decisions by HR and line management."
    - name: "employee_acknowledged_count"
      expr: COUNT(CASE WHEN employee_acknowledged = TRUE THEN 1 END)
      comment: "Count of reviews acknowledged by the employee. Used to track review process completion and identify outstanding acknowledgements."
    - name: "employee_disagreement_count"
      expr: COUNT(CASE WHEN employee_disagreement_flag = TRUE THEN 1 END)
      comment: "Count of reviews where the employee formally disagreed with the rating. Elevated disagreement rates signal calibration or management quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline and efficiency metrics. Provides HR and programme leadership with visibility into vacancy fill rates, time-to-fill, and recruitment cost by location and funding source."
  source: "`vibe_ngo_v1`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "recruitment_requisition_status"
      expr: recruitment_requisition_status
      comment: "Status of the recruitment requisition (e.g. Open, Filled, Cancelled) — primary filter for active pipeline analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for — used to segment recruitment activity by contract category."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of the vacancy — used for geographic recruitment demand and time-to-fill analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the vacancy — used to compare recruitment efficiency across national and international roles."
    - name: "recruitment_type"
      expr: recruitment_type
      comment: "Type of recruitment (e.g. External, Internal, Surge) — used to analyse sourcing strategy effectiveness."
    - name: "funding_confirmed"
      expr: funding_confirmed
      comment: "Flag indicating whether funding is confirmed for the position — used to prioritise active recruitment and avoid unfunded hires."
    - name: "is_emergency_surge"
      expr: is_emergency_surge
      comment: "Flag indicating an emergency surge recruitment — used to track surge response capacity and speed."
    - name: "opened_date"
      expr: DATE_TRUNC('month', opened_date)
      comment: "Month the requisition was opened — used for recruitment demand trend analysis."
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade of the vacancy — used for compensation benchmarking and budget planning."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of recruitment requisitions. Baseline metric for recruitment pipeline volume and workload planning."
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN recruitment_requisition_status = 'Open' THEN 1 END)
      comment: "Count of currently open requisitions. Primary operational KPI for vacancy management — high open counts signal capacity risk."
    - name: "filled_requisitions"
      expr: COUNT(CASE WHEN recruitment_requisition_status = 'Filled' THEN 1 END)
      comment: "Count of filled requisitions. Used to measure recruitment throughput and success rate."
    - name: "avg_budgeted_annual_salary"
      expr: AVG(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Average budgeted annual salary for open positions. Used for workforce cost forecasting and budget planning."
    - name: "total_budgeted_annual_salary"
      expr: SUM(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Total budgeted annual salary across all requisitions. Represents the total compensation commitment pipeline for financial planning."
    - name: "emergency_surge_requisition_count"
      expr: COUNT(CASE WHEN is_emergency_surge = TRUE THEN 1 END)
      comment: "Count of emergency surge requisitions. Used to track humanitarian response staffing demand and surge capacity utilisation."
    - name: "unfunded_requisition_count"
      expr: COUNT(CASE WHEN funding_confirmed = FALSE THEN 1 END)
      comment: "Count of requisitions without confirmed funding. Unfunded open requisitions represent financial risk and should trigger management review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development completion metrics. Provides HR and compliance leadership with visibility into training completion rates, mandatory course adherence, and learning investment by programme and staff category."
  source: "`vibe_ngo_v1`.`workforce`.`learning_enrollment`"
  dimensions:
    - name: "learning_enrollment_status"
      expr: learning_enrollment_status
      comment: "Status of the learning enrollment (e.g. Enrolled, Completed, Failed, Withdrawn) — primary filter for completion analysis."
    - name: "course_category"
      expr: course_category
      comment: "Category of the learning course — used to segment training investment and completion by subject area."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether the course is mandatory — used to track compliance with mandatory training requirements."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of course delivery (e.g. eLearning, Classroom, Blended) — used to analyse learning modality effectiveness and cost."
    - name: "country_code"
      expr: country_code
      comment: "Country of the enrolled staff member — used for geographic training coverage analysis."
    - name: "staff_type"
      expr: staff_type
      comment: "Staff type of the enrolled learner — used to compare training completion rates across staff categories."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the course — used to measure training effectiveness and identify courses with high failure rates."
    - name: "learning_enrollment_date"
      expr: DATE_TRUNC('month', learning_enrollment_date)
      comment: "Month of enrollment — used for training demand trend analysis and capacity planning."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of learning enrollments. Baseline metric for training programme reach and volume."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN learning_enrollment_status = 'Completed' THEN 1 END)
      comment: "Count of completed learning enrollments. Primary training completion KPI used in compliance and donor reporting."
    - name: "mandatory_completed_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND learning_enrollment_status = 'Completed' THEN 1 END)
      comment: "Count of completed mandatory training enrollments. Used to assess compliance with mandatory training obligations — a key risk management metric."
    - name: "mandatory_enrollment_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Total mandatory training enrollments. Used as the denominator for mandatory training completion rate calculations."
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total cost of training across all enrollments. Used for L&D budget management and cost-per-learner analysis."
    - name: "avg_training_cost_per_enrollment"
      expr: AVG(CAST(training_cost AS DOUBLE))
      comment: "Average training cost per enrollment. Used for L&D investment efficiency benchmarking across delivery modes and providers."
    - name: "total_actual_hours_spent"
      expr: SUM(CAST(actual_hours_spent AS DOUBLE))
      comment: "Total learning hours invested across all enrollments. Used to quantify the workforce's total learning investment in hours."
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score across completed enrollments. Used to evaluate training effectiveness and identify courses requiring redesign."
    - name: "certified_staff_count"
      expr: COUNT(CASE WHEN is_certified = TRUE THEN 1 END)
      comment: "Count of enrollments resulting in certification. Used to track certified workforce capacity for donor and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effort allocation and grant charging metrics. Provides finance and programme leadership with visibility into staff time allocation across grants, programmes, and activities — critical for donor compliance and ICR recovery."
  source: "`vibe_ngo_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "timesheet_status"
      expr: timesheet_status
      comment: "Status of the timesheet (e.g. Draft, Submitted, Approved, Rejected) — used to filter for approved effort data in grant reporting."
    - name: "grant_code"
      expr: grant_code
      comment: "Grant code charged on the timesheet — primary dimension for grant-funded effort allocation and donor reporting."
    - name: "program_code"
      expr: program_code
      comment: "Programme code associated with the timesheet — used for programme-level staff effort attribution."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of the duty station — used for geographic effort distribution analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the timesheet owner — used to segment effort by national vs international staff."
    - name: "is_grant_chargeable"
      expr: is_grant_chargeable
      comment: "Flag indicating whether hours are chargeable to a grant — used to separate direct programme effort from overhead."
    - name: "is_field_deployment"
      expr: is_field_deployment
      comment: "Flag indicating field deployment hours — used to track field vs HQ effort distribution."
    - name: "work_date"
      expr: DATE_TRUNC('month', work_date)
      comment: "Month bucket of the work date — used for monthly effort trend analysis and grant burn rate monitoring."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost centre charged on the timesheet — used for departmental effort and cost allocation analysis."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all timesheets. Primary effort volume metric for capacity utilisation and grant charging analysis."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Used to assess standard capacity utilisation and plan staffing levels."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. High overtime signals understaffing or workload imbalance requiring management intervention."
    - name: "total_grant_chargeable_hours"
      expr: SUM(CASE WHEN is_grant_chargeable = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total hours chargeable to grants. Used for grant effort reporting, ICR recovery calculations, and donor compliance."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage allocation per timesheet entry. Used to assess how staff time is distributed across funding sources."
    - name: "total_toil_hours_accrued"
      expr: SUM(CAST(toil_hours_accrued AS DOUBLE))
      comment: "Total TOIL hours accrued from timesheets. Used to track compensatory time liability and staff wellbeing risk."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN timesheet_status = 'Approved' THEN 1 END)
      comment: "Count of approved timesheets. Used to track timesheet submission compliance and approval cycle completeness."
    - name: "effort_certification_required_count"
      expr: COUNT(CASE WHEN effort_certification_required = TRUE THEN 1 END)
      comment: "Count of timesheets requiring effort certification. Used to manage grant compliance obligations and audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_separation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff attrition and separation metrics. Provides HR and executive leadership with visibility into turnover patterns, separation types, and financial settlement costs — critical for workforce stability and retention strategy. Per VREQ-029, this view also surfaces safeguarding clearance status at separation."
  source: "`vibe_ngo_v1`.`workforce`.`separation_event`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (e.g. Resignation, Redundancy, End of Contract, Dismissal) — primary dimension for attrition cause analysis."
    - name: "separation_reason_code"
      expr: separation_reason_code
      comment: "Coded reason for separation — used for detailed attrition root cause analysis and trend reporting."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of the departing staff member — used for geographic attrition pattern analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the departing employee — used to compare attrition rates across national and international staff."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type at time of separation — used to segment attrition by employment arrangement."
    - name: "rehire_eligibility"
      expr: rehire_eligibility
      comment: "Rehire eligibility status — used to assess talent pool quality and flag ineligible separations for HR records."
    - name: "safeguarding_clearance_status"
      expr: safeguarding_clearance_status
      comment: "Safeguarding clearance status at separation — per VREQ-029, used to ensure safeguarding outcomes are tracked at the point of staff departure."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of separation effective date — used for monthly attrition trend analysis."
    - name: "exit_interview_status"
      expr: exit_interview_status
      comment: "Status of the exit interview — used to track exit interview completion rates and identify gaps in offboarding quality."
  measures:
    - name: "total_separations"
      expr: COUNT(1)
      comment: "Total number of separation events. Primary attrition volume metric used in workforce stability reporting."
    - name: "voluntary_separations"
      expr: COUNT(CASE WHEN separation_type = 'Resignation' THEN 1 END)
      comment: "Count of voluntary separations (resignations). Used to compute voluntary attrition rate — a key retention health indicator."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total financial settlement paid to departing staff. Used for separation cost budgeting and financial liability management."
    - name: "total_severance_pay"
      expr: SUM(CAST(severance_pay_amount AS DOUBLE))
      comment: "Total severance pay disbursed. Used for redundancy cost tracking and financial planning for workforce restructuring."
    - name: "avg_years_of_service_at_separation"
      expr: AVG(CAST(years_of_service AS DOUBLE))
      comment: "Average years of service at time of separation. Low averages indicate early attrition — a signal of onboarding or culture issues."
    - name: "total_leave_encashment_days"
      expr: SUM(CAST(leave_encashment_days AS DOUBLE))
      comment: "Total leave days encashed at separation. Represents the financial liability of accrued but untaken leave paid out at departure."
    - name: "exit_interview_completed_count"
      expr: COUNT(CASE WHEN exit_interview_status = 'Completed' THEN 1 END)
      comment: "Count of separations with a completed exit interview. Used to track offboarding quality and data collection for retention analysis."
    - name: "safeguarding_cleared_count"
      expr: COUNT(CASE WHEN safeguarding_clearance_status = 'Cleared' THEN 1 END)
      comment: "Count of separations where safeguarding clearance was confirmed. Per VREQ-029, ensures safeguarding outcomes are tracked at departure — a compliance and duty-of-care requirement."
    - name: "knowledge_transfer_completed_count"
      expr: COUNT(CASE WHEN knowledge_transfer_completed = TRUE THEN 1 END)
      comment: "Count of separations with completed knowledge transfer. Used to assess offboarding quality and mitigate institutional knowledge loss risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation and cost metrics. Provides HR and finance leadership with visibility into benefit plan uptake, employer contribution liabilities, and coverage distribution across the workforce."
  source: "`vibe_ngo_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_enrollment_status"
      expr: benefit_enrollment_status
      comment: "Status of the benefit enrollment (e.g. Active, Terminated, Waived) — primary filter for active benefit cost analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (e.g. Medical, Pension, Life Insurance) — used to segment benefit cost by plan category."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier selected (e.g. Employee Only, Employee + Family) — used to analyse dependent coverage uptake and cost."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of the enrolled staff member — used for geographic benefit cost distribution analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the enrolled employee — used to compare benefit uptake and cost across employment categories."
    - name: "cobra_eligible"
      expr: cobra_eligible
      comment: "Flag indicating COBRA eligibility — used to track continuation coverage obligations and associated cost liabilities."
    - name: "is_dependent_coverage"
      expr: is_dependent_coverage
      comment: "Flag indicating dependent coverage — used to quantify the cost of dependent benefit coverage across the workforce."
    - name: "benefit_enrollment_date"
      expr: DATE_TRUNC('year', benefit_enrollment_date)
      comment: "Year of enrollment — used for annual benefit uptake trend analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of benefit enrollments. Baseline metric for benefit programme participation tracking."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN benefit_enrollment_status = 'Active' THEN 1 END)
      comment: "Count of active benefit enrollments. Used to determine current benefit liability and plan utilisation."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contributions to benefit plans. Used for payroll deduction reconciliation and benefit cost-sharing analysis."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contributions to benefit plans. Represents a significant non-salary employment cost tracked for total compensation reporting."
    - name: "total_life_insurance_coverage"
      expr: SUM(CAST(life_insurance_coverage_amount AS DOUBLE))
      comment: "Total life insurance coverage amount across enrolled staff. Used for insurance liability and duty-of-care reporting."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment. Used for benefit cost benchmarking and plan design optimisation."
    - name: "avg_pension_contribution_rate"
      expr: AVG(CAST(pension_contribution_rate_pct AS DOUBLE))
      comment: "Average pension contribution rate across enrollments. Used to assess pension scheme generosity and cost relative to market benchmarks."
    - name: "dependent_coverage_count"
      expr: COUNT(CASE WHEN is_dependent_coverage = TRUE THEN 1 END)
      comment: "Count of enrollments with dependent coverage. Used to quantify the dependent coverage burden and associated employer cost."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary and misconduct metrics. Provides HR, compliance, and executive leadership with visibility into case volumes, PSEA prevalence, donor reporting obligations, and investigation outcomes — a critical risk management and safeguarding KPI set."
  source: "`vibe_ngo_v1`.`workforce`.`disciplinary_case`"
  dimensions:
    - name: "disciplinary_case_status"
      expr: disciplinary_case_status
      comment: "Status of the disciplinary case (e.g. Open, Under Investigation, Closed) — primary filter for active case management."
    - name: "disciplinary_case_type"
      expr: disciplinary_case_type
      comment: "Type of disciplinary case — used to categorise misconduct and identify systemic patterns."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country where the incident occurred — used for geographic risk pattern analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the subject — used to segment disciplinary cases by employment type."
    - name: "is_psea_case"
      expr: is_psea_case
      comment: "Flag indicating a PSEA (Protection from Sexual Exploitation and Abuse) case — critical safeguarding KPI for board and donor reporting."
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (e.g. Substantiated, Unsubstantiated, Inconclusive) — used to assess case resolution quality."
    - name: "is_mandatory_donor_report_required"
      expr: is_mandatory_donor_report_required
      comment: "Flag indicating mandatory donor reporting obligation — used to track compliance with donor incident reporting requirements."
    - name: "opened_date"
      expr: DATE_TRUNC('month', opened_date)
      comment: "Month the case was opened — used for incident trend analysis and early warning monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the disciplinary case — used to ensure high-priority cases receive timely management attention."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of disciplinary cases. Baseline metric for misconduct prevalence and HR caseload management."
    - name: "open_cases"
      expr: COUNT(CASE WHEN disciplinary_case_status = 'Open' THEN 1 END)
      comment: "Count of currently open disciplinary cases. Used to monitor active caseload and ensure timely resolution."
    - name: "psea_case_count"
      expr: COUNT(CASE WHEN is_psea_case = TRUE THEN 1 END)
      comment: "Count of PSEA cases. Critical safeguarding KPI reported to boards, donors, and regulatory bodies — zero tolerance threshold metric."
    - name: "mandatory_donor_report_count"
      expr: COUNT(CASE WHEN is_mandatory_donor_report_required = TRUE THEN 1 END)
      comment: "Count of cases requiring mandatory donor reporting. Used to track compliance with donor incident disclosure obligations."
    - name: "donor_report_submitted_count"
      expr: COUNT(CASE WHEN donor_report_submitted_date IS NOT NULL THEN 1 END)
      comment: "Count of cases where donor reports have been submitted. Used to verify compliance with mandatory reporting deadlines."
    - name: "beneficiary_involved_count"
      expr: COUNT(CASE WHEN beneficiary_involved = TRUE THEN 1 END)
      comment: "Count of cases involving beneficiaries. Elevated counts signal serious safeguarding failures requiring immediate executive attention."
    - name: "referred_to_authorities_count"
      expr: COUNT(CASE WHEN referred_to_authorities = TRUE THEN 1 END)
      comment: "Count of cases referred to external authorities. Used to track the most serious misconduct cases and legal exposure."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_end_date, investigation_start_date))
      comment: "Average number of days to complete an investigation. Used to assess investigation timeliness and identify process bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_staff_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff assignment and deployment metrics. Provides programme and HR leadership with visibility into effort allocation, field deployment intensity, and grant-funded assignment distribution across the workforce."
  source: "`vibe_ngo_v1`.`workforce`.`workforce_staff_assignment`"
  dimensions:
    - name: "workforce_staff_assignment_status"
      expr: workforce_staff_assignment_status
      comment: "Status of the staff assignment (e.g. Active, Ended, Pending) — primary filter for current deployment analysis."
    - name: "workforce_staff_assignment_type"
      expr: workforce_staff_assignment_type
      comment: "Type of assignment (e.g. Primary, TDY, Surge) — used to segment deployment by assignment category."
    - name: "duty_country_code"
      expr: duty_country_code
      comment: "Country of the assignment — used for geographic deployment distribution analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the assigned employee — used to compare deployment patterns across national and international staff."
    - name: "is_field_deployment"
      expr: is_field_deployment
      comment: "Flag indicating a field deployment — used to track field vs HQ assignment distribution."
    - name: "is_surge_deployment"
      expr: is_surge_deployment
      comment: "Flag indicating a surge deployment — used to monitor emergency response staffing intensity."
    - name: "grant_code"
      expr: grant_code
      comment: "Grant code funding the assignment — used for grant-funded staff deployment tracking and donor reporting."
    - name: "safeguarding_training_completed"
      expr: safeguarding_training_completed
      comment: "Flag indicating safeguarding training completion for the assigned staff member — used for deployment compliance monitoring."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of assignment start — used for deployment trend analysis and surge response monitoring."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of staff assignments. Baseline metric for deployment volume and workforce mobility analysis."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN workforce_staff_assignment_status = 'Active' THEN 1 END)
      comment: "Count of currently active staff assignments. Primary operational deployment KPI for programme capacity monitoring."
    - name: "field_deployment_count"
      expr: COUNT(CASE WHEN is_field_deployment = TRUE THEN 1 END)
      comment: "Count of field deployment assignments. Used to track field presence intensity and duty-of-care obligations."
    - name: "surge_deployment_count"
      expr: COUNT(CASE WHEN is_surge_deployment = TRUE THEN 1 END)
      comment: "Count of surge deployment assignments. Used to monitor emergency response staffing levels and surge capacity utilisation."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent across all assignments. Used for programme capacity planning and grant effort allocation reporting."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage per assignment. Used to assess how staff time is distributed across programmes and grants."
    - name: "safeguarding_trained_assignment_count"
      expr: COUNT(CASE WHEN safeguarding_training_completed = TRUE THEN 1 END)
      comment: "Count of assignments where safeguarding training is confirmed. Used to verify deployment compliance with safeguarding requirements."
    - name: "cost_shared_assignment_count"
      expr: COUNT(CASE WHEN is_cost_shared = TRUE THEN 1 END)
      comment: "Count of cost-shared assignments. Used for multi-donor cost allocation analysis and ICR recovery planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_employment_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employment contract and compensation structure metrics. Provides HR and finance leadership with visibility into salary investment, allowance composition, and contract portfolio by type, grade, and geography."
  source: "`vibe_ngo_v1`.`workforce`.`employment_contract`"
  dimensions:
    - name: "employment_contract_status"
      expr: employment_contract_status
      comment: "Status of the employment contract (e.g. Active, Terminated, Expired) — primary filter for active contract analysis."
    - name: "employment_contract_type"
      expr: employment_contract_type
      comment: "Type of employment contract (e.g. Fixed-Term, Open-Ended, Consultancy) — used to segment workforce by contract structure."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country of the duty station — used for geographic salary and allowance cost analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category under the contract — used to compare compensation structures across national and international staff."
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade of the contract — used for grade-level compensation analysis and equity review."
    - name: "is_expatriate"
      expr: is_expatriate
      comment: "Flag indicating an expatriate contract — used to segment and quantify the expat compensation premium."
    - name: "salary_currency"
      expr: salary_currency
      comment: "Currency of the salary — used for multi-currency compensation analysis and FX exposure management."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year of contract start — used for contract vintage analysis and workforce renewal planning."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of employment contracts. Baseline metric for contract portfolio size and workforce structure analysis."
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary commitment across all contracts. Primary compensation cost metric for budget planning and grant charging."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per contract. Used for compensation benchmarking and equity analysis across grades and geographies."
    - name: "total_hardship_allowance"
      expr: SUM(CAST(hardship_allowance_amount AS DOUBLE))
      comment: "Total hardship allowances committed across contracts. Used to quantify the cost of field deployments in difficult environments."
    - name: "total_housing_allowance"
      expr: SUM(CAST(housing_allowance_amount AS DOUBLE))
      comment: "Total housing allowances committed. Used for duty-station cost-of-living analysis and total compensation benchmarking."
    - name: "total_relocation_allowance"
      expr: SUM(CAST(relocation_allowance_amount AS DOUBLE))
      comment: "Total relocation allowances committed. Used for mobility cost budgeting and expatriate package cost management."
    - name: "expat_contract_count"
      expr: COUNT(CASE WHEN is_expatriate = TRUE THEN 1 END)
      comment: "Count of expatriate contracts. Used to track expat workforce size and associated premium compensation costs."
    - name: "avg_icr_rate"
      expr: AVG(CAST(icr_rate AS DOUBLE))
      comment: "Average indirect cost recovery rate across contracts. Used to assess ICR recovery efficiency and grant overhead allocation."
$$;