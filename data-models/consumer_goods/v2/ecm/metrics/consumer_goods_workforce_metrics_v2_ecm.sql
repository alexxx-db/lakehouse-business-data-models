-- Metric views for domain: workforce | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and composition metrics. Tracks active employee base, turnover signals, and workforce structure for executive headcount planning and HR steering decisions."
  source: "`vibe_consumer_goods_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, Leave, etc.) for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor classification for workforce composition analysis."
    - name: "department"
      expr: department
      comment: "Organizational department for headcount distribution reporting."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit for cross-BU workforce comparison."
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-level workforce analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation equity and grading analysis."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exempt/non-exempt classification for labor compliance reporting."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Whether the employee is a union member, for labor relations segmentation."
    - name: "work_location_country_code"
      expr: work_location_country_code
      comment: "Country of work location for global workforce distribution."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure cohort and hiring trend analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Employment contract type (permanent, fixed-term, etc.) for workforce risk assessment."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records. Primary headcount KPI used in all workforce planning dashboards."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active employees. Core metric for capacity planning and budget headcount tracking."
    - name: "terminated_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated employees in the period. Drives attrition rate calculation and retention risk analysis."
    - name: "union_member_headcount"
      expr: COUNT(CASE WHEN union_membership_flag = TRUE THEN 1 END)
      comment: "Count of union-represented employees. Critical for labor relations planning and CBA compliance monitoring."
    - name: "avg_standard_working_hours_per_week"
      expr: AVG(CAST(standard_working_hours_per_week AS DOUBLE))
      comment: "Average contracted weekly hours across the workforce. Indicates FTE utilization and part-time workforce proportion."
    - name: "total_standard_working_hours_per_week"
      expr: SUM(CAST(standard_working_hours_per_week AS DOUBLE))
      comment: "Total contracted weekly hours across all employees. Used to compute effective FTE capacity for production and operations planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics for financial planning, labor cost management, and executive compensation reporting. Directly informs P&L labor line items."
  source: "`vibe_consumer_goods_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "payroll_status"
      expr: payroll_status
      comment: "Processing status of the payroll record (Processed, Pending, Error) for payroll operations monitoring."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay cycle frequency (weekly, bi-weekly, monthly) for payroll scheduling analysis."
    - name: "pay_currency_code"
      expr: pay_currency_code
      comment: "Currency of payment for multi-currency payroll cost consolidation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check, etc.) for payroll operations efficiency."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation to business units and departments."
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start of the pay period for time-series payroll trend analysis."
    - name: "pay_date"
      expr: pay_date
      comment: "Actual pay date for cash flow and payroll disbursement tracking."
    - name: "work_location_code"
      expr: work_location_code
      comment: "Work location for geographic labor cost distribution."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll cost. Primary labor cost KPI for P&L and budget variance reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to employees. Drives cash flow forecasting and treasury planning."
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary component of payroll. Used to separate fixed vs variable compensation costs."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay cost. High overtime signals understaffing or scheduling inefficiency requiring management action."
    - name: "total_bonus_pay"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus compensation paid. Tracks variable pay spend against incentive budget."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total payroll deductions (taxes, benefits, garnishments). Used for benefits cost and tax liability reporting."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal tax withheld across all payroll records. Required for tax compliance and IRS reporting."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked. Operational KPI for labor efficiency and scheduling optimization."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked. Baseline for labor utilization and productivity analysis."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record. Benchmarks compensation levels across cost centers and pay grades."
    - name: "total_ytd_gross_pay"
      expr: SUM(CAST(year_to_date_gross_pay AS DOUBLE))
      comment: "Sum of year-to-date gross pay across all records. Used for annual compensation budget tracking and W-2 preparation."
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Total number of payroll records processed. Baseline volume metric for payroll operations and audit completeness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run execution metrics for operational efficiency, cost control, and compliance. Tracks payroll cycle performance and labor cost by run type and jurisdiction."
  source: "`vibe_consumer_goods_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (Completed, Failed, Pending) for operational monitoring."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (regular, off-cycle, correction) for cost categorization."
    - name: "payroll_frequency"
      expr: payroll_frequency
      comment: "Frequency of the payroll run for scheduling and compliance tracking."
    - name: "jurisdiction_country"
      expr: jurisdiction_country
      comment: "Country jurisdiction for multi-country payroll cost and compliance reporting."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for state-level tax and labor law compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run for multi-currency consolidation."
    - name: "pay_date"
      expr: pay_date
      comment: "Pay date of the run for cash flow and disbursement timeline analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual payroll cost and tax liability reporting."
  measures:
    - name: "total_gross_payroll"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll disbursed across all runs. Primary labor cost KPI for CFO and CHRO reporting."
    - name: "total_net_payroll"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll disbursed. Drives treasury cash flow planning."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total taxes withheld across all payroll runs. Required for tax authority remittance and compliance."
    - name: "total_overtime_hours_run"
      expr: SUM(CAST(total_overtime_hours AS DOUBLE))
      comment: "Total overtime hours across payroll runs. Signals labor cost overruns and scheduling inefficiency."
    - name: "avg_gross_per_run"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross payroll per run. Benchmarks run size for anomaly detection and budget forecasting."
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Total number of payroll runs executed. Operational volume metric for payroll team capacity planning."
    - name: "correction_run_count"
      expr: COUNT(CASE WHEN payroll_type = 'Correction' THEN 1 END)
      comment: "Count of correction payroll runs. High correction volume indicates data quality or process issues requiring intervention."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance and talent management metrics. Tracks rating distributions, merit increases, and promotion pipeline for talent strategy and compensation planning."
  source: "`vibe_consumer_goods_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, PIP) for review cycle analysis."
    - name: "review_status"
      expr: review_status
      comment: "Completion status of the review for process compliance monitoring."
    - name: "goal_category"
      expr: goal_category
      comment: "Category of performance goal for strategic alignment analysis."
    - name: "rating_scale"
      expr: rating_scale
      comment: "Rating scale used for normalization across review cycles."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for ensuring rating fairness and consistency."
    - name: "review_period_start"
      expr: review_period_start
      comment: "Start of the review period for time-series performance trend analysis."
    - name: "pip_flag"
      expr: pip_flag
      comment: "Whether the employee is on a Performance Improvement Plan. Critical for retention risk and legal exposure monitoring."
    - name: "promotion_recommendation_flag"
      expr: promotion_recommendation_flag
      comment: "Whether a promotion was recommended. Drives succession planning and talent pipeline reporting."
    - name: "compensation_change_flag"
      expr: compensation_change_flag
      comment: "Whether a compensation change was triggered by this review. Links performance to pay decisions."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews. Baseline for review completion rate and process compliance."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating across the workforce. Key talent health indicator for executive talent reviews."
    - name: "avg_goal_achievement"
      expr: AVG(CAST(goal_actual_achievement AS DOUBLE))
      comment: "Average goal achievement percentage. Measures how effectively the workforce is delivering against strategic objectives."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage awarded. Benchmarks compensation investment against performance outcomes."
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_amount AS DOUBLE))
      comment: "Total merit increase spend. Tracks compensation budget utilization from performance cycles."
    - name: "pip_employee_count"
      expr: COUNT(CASE WHEN pip_flag = TRUE THEN 1 END)
      comment: "Count of employees on Performance Improvement Plans. Signals talent risk and potential involuntary attrition exposure."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommendation_flag = TRUE THEN 1 END)
      comment: "Count of employees recommended for promotion. Drives succession pipeline and internal mobility planning."
    - name: "finalized_review_count"
      expr: COUNT(CASE WHEN is_finalized = TRUE THEN 1 END)
      comment: "Count of finalized reviews. Tracks review cycle completion rate for HR process compliance."
    - name: "avg_goal_weight"
      expr: AVG(CAST(goal_weight AS DOUBLE))
      comment: "Average goal weight assigned. Indicates how goals are distributed and whether strategic priorities are properly weighted."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_recruiting_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline metrics. Tracks open requisitions, hiring velocity, and recruiting efficiency for workforce planning and talent acquisition strategy."
  source: "`vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (Open, Filled, Cancelled) for pipeline health monitoring."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (backfill, new headcount, etc.) for workforce growth vs replacement analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for (full-time, part-time, contract) for workforce mix planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Recruiting priority level for resource allocation to critical open roles."
    - name: "reason_for_opening"
      expr: reason_for_opening
      comment: "Reason the position is open (attrition, growth, restructure) for workforce planning root cause analysis."
    - name: "remote_work_eligible"
      expr: remote_work_eligible
      comment: "Whether the role is remote-eligible. Tracks remote work policy adoption in hiring."
    - name: "requisition_created_date"
      expr: requisition_created_date
      comment: "Date the requisition was created for time-to-fill trend analysis."
    - name: "salary_currency_code"
      expr: salary_currency_code
      comment: "Currency of the salary range for multi-currency compensation benchmarking."
    - name: "evergreen_requisition"
      expr: evergreen_requisition
      comment: "Whether the requisition is evergreen (always-open) for pipeline volume normalization."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of recruiting requisitions. Baseline for talent acquisition pipeline volume."
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN 1 END)
      comment: "Count of currently open requisitions. Primary KPI for talent acquisition capacity and hiring backlog."
    - name: "filled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END)
      comment: "Count of filled requisitions. Measures recruiting team effectiveness and hiring throughput."
    - name: "avg_salary_range_midpoint"
      expr: AVG(CAST(salary_range_minimum AS DOUBLE) + CAST(salary_range_maximum AS DOUBLE)) / 2
      comment: "Average midpoint of salary ranges across requisitions. Benchmarks compensation competitiveness for talent attraction."
    - name: "total_approved_openings"
      expr: COUNT(CASE WHEN requisition_status != 'Cancelled' THEN 1 END)
      comment: "Total approved headcount openings (non-cancelled). Tracks authorized hiring capacity against budget."
    - name: "internal_posting_only_count"
      expr: COUNT(CASE WHEN internal_posting_only = TRUE THEN 1 END)
      comment: "Count of requisitions posted internally only. Measures internal mobility and promotion-from-within culture."
    - name: "avg_salary_range_maximum"
      expr: AVG(CAST(salary_range_maximum AS DOUBLE))
      comment: "Average maximum salary offered across requisitions. Tracks compensation ceiling trends for budget forecasting."
    - name: "avg_salary_range_minimum"
      expr: AVG(CAST(salary_range_minimum AS DOUBLE))
      comment: "Average minimum salary offered across requisitions. Tracks compensation floor for market competitiveness analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_job_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting funnel and candidate pipeline metrics. Tracks application volume, conversion rates, and offer outcomes to optimize talent acquisition effectiveness."
  source: "`vibe_consumer_goods_v1`.`workforce`.`job_application`"
  dimensions:
    - name: "application_stage"
      expr: application_stage
      comment: "Current stage in the recruiting funnel (Applied, Screened, Interviewed, Offered, Hired) for pipeline conversion analysis."
    - name: "application_source"
      expr: application_source
      comment: "Source channel of the application (LinkedIn, referral, job board) for sourcing effectiveness analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Status of the offer (Accepted, Declined, Pending) for offer conversion rate tracking."
    - name: "internal_candidate_flag"
      expr: internal_candidate_flag
      comment: "Whether the applicant is an internal employee. Tracks internal mobility rate."
    - name: "application_date"
      expr: application_date
      comment: "Date of application for recruiting volume trend analysis."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason for rejection for candidate quality and process improvement analysis."
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for OFCCP compliance and diversity hiring reporting."
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for EEO compliance and inclusive hiring tracking."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of job applications received. Primary recruiting funnel volume metric."
    - name: "hired_count"
      expr: COUNT(CASE WHEN hire_date IS NOT NULL THEN 1 END)
      comment: "Count of applications that resulted in a hire. Measures recruiting funnel conversion to hire."
    - name: "offer_accepted_count"
      expr: COUNT(CASE WHEN offer_status = 'Accepted' THEN 1 END)
      comment: "Count of accepted offers. Tracks offer acceptance rate as a compensation and employer brand indicator."
    - name: "offer_declined_count"
      expr: COUNT(CASE WHEN offer_status = 'Declined' THEN 1 END)
      comment: "Count of declined offers. High decline rate signals compensation or culture competitiveness issues."
    - name: "avg_interview_score"
      expr: AVG(CAST(interview_score AS DOUBLE))
      comment: "Average interview score across candidates. Benchmarks candidate quality by source channel and role."
    - name: "avg_offered_salary"
      expr: AVG(CAST(offered_salary AS DOUBLE))
      comment: "Average salary offered to candidates. Tracks compensation competitiveness and budget utilization in recruiting."
    - name: "internal_candidate_hired_count"
      expr: COUNT(CASE WHEN internal_candidate_flag = TRUE AND hire_date IS NOT NULL THEN 1 END)
      comment: "Count of internal candidates hired. Measures internal mobility and promotion-from-within effectiveness."
    - name: "avg_phone_screen_score"
      expr: AVG(CAST(phone_screen_score AS DOUBLE))
      comment: "Average phone screen score. Early funnel quality indicator for sourcing channel effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time and attendance metrics for operational efficiency, overtime cost management, and compliance. Directly informs labor cost allocation and scheduling optimization."
  source: "`vibe_consumer_goods_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (regular, overtime, absence, holiday) for labor category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry for payroll readiness and compliance monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for shift differential cost analysis."
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (sick, vacation, FMLA) for absence management and compliance."
    - name: "department_code"
      expr: department_code
      comment: "Department for labor cost allocation and headcount utilization analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant/facility code for site-level labor utilization reporting."
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the time entry for daily and weekly labor trend analysis."
    - name: "fmla_eligible_flag"
      expr: fmla_eligible_flag
      comment: "Whether the absence is FMLA-eligible for legal compliance tracking."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the time entry is linked to an OSHA recordable incident for safety compliance."
    - name: "weekend_flag"
      expr: weekend_flag
      comment: "Whether the entry falls on a weekend for premium pay and scheduling analysis."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Baseline labor utilization metric for capacity and productivity analysis."
    - name: "total_overtime_hours_1_5x"
      expr: SUM(CAST(overtime_hours_1_5x AS DOUBLE))
      comment: "Total 1.5x overtime hours. Primary overtime cost driver for labor budget variance analysis."
    - name: "total_overtime_hours_2x"
      expr: SUM(CAST(overtime_hours_2x AS DOUBLE))
      comment: "Total 2x overtime hours. Signals critical understaffing or emergency production situations."
    - name: "total_paid_time_off_hours"
      expr: SUM(CAST(paid_time_off_hours AS DOUBLE))
      comment: "Total paid time off hours consumed. Tracks PTO liability and absence impact on operational capacity."
    - name: "total_unpaid_time_off_hours"
      expr: SUM(CAST(unpaid_time_off_hours AS DOUBLE))
      comment: "Total unpaid time off hours. Measures unplanned absence impact on production and service delivery."
    - name: "total_time_entries"
      expr: COUNT(1)
      comment: "Total number of time entries. Baseline volume metric for payroll processing completeness."
    - name: "fmla_entry_count"
      expr: COUNT(CASE WHEN fmla_eligible_flag = TRUE THEN 1 END)
      comment: "Count of FMLA-eligible time entries. Tracks FMLA utilization for legal compliance and workforce availability planning."
    - name: "avg_regular_hours_per_entry"
      expr: AVG(CAST(regular_hours AS DOUBLE))
      comment: "Average regular hours per time entry. Benchmarks shift utilization and identifies scheduling gaps."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety and incident metrics for EHS compliance, risk management, and operational safety culture. Directly informs OSHA reporting and insurance cost management."
  source: "`vibe_consumer_goods_v1`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (injury, near-miss, property damage) for risk categorization."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident investigation for case management tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident for risk prioritization and executive safety reporting."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable. Critical for regulatory compliance and OSHA 300 log reporting."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic safety improvement and corrective action prioritization."
    - name: "department"
      expr: department
      comment: "Department where the incident occurred for departmental safety performance benchmarking."
    - name: "plant_site"
      expr: plant_site
      comment: "Plant or site where the incident occurred for facility-level safety performance tracking."
    - name: "osha_300_classification"
      expr: osha_300_classification
      comment: "OSHA 300 log classification for regulatory reporting compliance."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation for corrective action follow-through monitoring."
    - name: "claim_status"
      expr: claim_status
      comment: "Workers compensation claim status for insurance cost management."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents. Primary EHS KPI for safety culture and regulatory compliance reporting."
    - name: "osha_recordable_incident_count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Count of OSHA recordable incidents. Mandatory metric for OSHA 300 log and regulatory compliance."
    - name: "total_medical_cost"
      expr: SUM(CAST(medical_cost AS DOUBLE))
      comment: "Total medical costs from safety incidents. Drives workers compensation budget and insurance premium analysis."
    - name: "total_indemnity_cost"
      expr: SUM(CAST(indemnity_cost AS DOUBLE))
      comment: "Total indemnity (lost wage) costs from incidents. Measures financial impact of workforce safety failures."
    - name: "total_incident_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total all-in cost of safety incidents. Primary financial KPI for EHS ROI and safety investment justification."
    - name: "avg_incident_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per safety incident. Benchmarks incident severity and cost trends over time."
    - name: "modified_duty_incident_count"
      expr: COUNT(CASE WHEN modified_duty_flag = TRUE THEN 1 END)
      comment: "Count of incidents resulting in modified duty. Tracks workforce capacity impact from safety events."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce training completion and compliance metrics. Tracks certification currency, training effectiveness, and regulatory compliance for GMP, safety, and skills development."
  source: "`vibe_consumer_goods_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_record_status"
      expr: training_record_status
      comment: "Status of the training record (Completed, In Progress, Expired) for compliance monitoring."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (compliance, skills, leadership) for training investment categorization."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for training effectiveness and competency validation."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Whether recertification is required for tracking ongoing compliance obligations."
    - name: "completion_date"
      expr: completion_date
      comment: "Training completion date for time-series compliance trend analysis."
    - name: "training_location"
      expr: training_location
      comment: "Location where training was delivered for site-level compliance tracking."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Certifying organization for credential validity and regulatory recognition."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total training records. Baseline for training program coverage and compliance completeness."
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN training_record_status = 'Completed' THEN 1 END)
      comment: "Count of completed training records. Primary compliance KPI for regulatory audit readiness."
    - name: "passed_training_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Count of passed training assessments. Measures workforce competency attainment."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered. Tracks learning investment and regulatory training hour requirements."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score. Measures training program effectiveness and workforce competency levels."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN training_record_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications. Critical compliance risk metric — expired certs can halt GMP production operations."
    - name: "avg_training_hours_per_record"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per record. Benchmarks training depth and investment per employee-course completion."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefits enrollment and cost metrics. Tracks benefit plan adoption, contribution levels, and enrollment status for benefits strategy and total compensation management."
  source: "`vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Terminated, Waived) for benefits coverage tracking."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Category of benefit (medical, dental, retirement, etc.) for benefits portfolio analysis."
    - name: "benefit_plan_code"
      expr: benefit_plan_code
      comment: "Specific benefit plan for plan-level enrollment and cost analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family) for cost tier distribution analysis."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Frequency of benefit contributions for payroll deduction scheduling."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Event triggering enrollment (open enrollment, life event, new hire) for enrollment pattern analysis."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "Tax treatment of the benefit (pre-tax, post-tax) for compensation and tax planning."
    - name: "cobra_eligible_flag"
      expr: cobra_eligible_flag
      comment: "Whether the enrollment is COBRA-eligible for compliance and continuation coverage tracking."
    - name: "coverage_start_date"
      expr: coverage_start_date
      comment: "Coverage start date for benefits effective date and open enrollment cycle analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total benefit enrollments. Baseline for benefits program participation and coverage completeness."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Count of active benefit enrollments. Primary metric for benefits coverage rate and program utilization."
    - name: "total_employee_contributions"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee benefit contributions. Tracks employee cost-sharing and benefits affordability."
    - name: "total_employer_contributions"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contributions. Primary benefits cost KPI for total compensation budget management."
    - name: "total_annual_elections"
      expr: SUM(CAST(annual_election_amount AS DOUBLE))
      comment: "Total annual benefit elections (e.g., FSA/HSA). Tracks voluntary benefit utilization and tax-advantaged account adoption."
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution per enrollment. Benchmarks benefits affordability across pay grades and plan types."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment. Benchmarks benefits investment per employee for market competitiveness."
    - name: "cobra_eligible_count"
      expr: COUNT(CASE WHEN cobra_eligible_flag = TRUE THEN 1 END)
      comment: "Count of COBRA-eligible enrollments. Tracks continuation coverage obligations and associated cost exposure."
    - name: "waived_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Waived' THEN 1 END)
      comment: "Count of waived benefit enrollments. High waiver rates may indicate affordability issues or benefits program gaps."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_applicant_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key applicant pipeline metrics to monitor recruitment efficiency and conversion."
  source: "`vibe_consumer_goods_v1`.`workforce`.`applicant`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "department_applied"
      expr: department_applied
      comment: "Department the applicant applied to"
    - name: "source_channel"
      expr: source_channel
      comment: "Recruitment source channel"
    - name: "country"
      expr: country
      comment: "Applicant country"
    - name: "state"
      expr: state
      comment: "Applicant state"
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application"
  measures:
    - name: "total_applicants"
      expr: COUNT(1)
      comment: "Total number of applicant records"
    - name: "applications_with_offer"
      expr: COUNT(offer_date)
      comment: "Number of applicants who received an offer"
    - name: "avg_time_to_hire_days"
      expr: AVG(DATEDIFF(hire_date, application_date))
      comment: "Average days between application and hire date for hired applicants"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_employee_turnover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee turnover and tenure metrics for workforce planning."
  source: "`vibe_consumer_goods_v1`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Department of the employee"
    - name: "work_location_country"
      expr: work_location_country_code
      comment: "Country of work location"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination (if any)"
  measures:
    - name: "total_employees"
      expr: COUNT(1)
      comment: "Total employee records"
    - name: "total_terminations"
      expr: COUNT(termination_date)
      comment: "Number of employees who have a termination date"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average tenure in days, using termination date or current date"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_payroll_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated payroll financials for cost analysis."
  source: "`vibe_consumer_goods_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Payroll month"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center identifier"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll record"
    - name: "pay_currency"
      expr: pay_currency_code
      comment: "Currency of payroll amounts"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay amount"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay amount"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total deductions across all payroll records"
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record"
$$;