-- Metric views for domain: workforce | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:44:27

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Enrollment business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "Aca Affordability Safe Harbor"
      expr: aca_affordability_safe_harbor
    - name: "Aca Minimum Value Met Flag"
      expr: aca_minimum_value_met_flag
    - name: "Beneficiary Count"
      expr: beneficiary_count
    - name: "Carrier Confirmation Received Flag"
      expr: carrier_confirmation_received_flag
    - name: "Carrier Member Number"
      expr: carrier_member_number
    - name: "Carrier Notification Sent Date"
      expr: carrier_notification_sent_date
    - name: "Carrier Notification Sent Flag"
      expr: carrier_notification_sent_flag
    - name: "Cobra Election Date"
      expr: cobra_election_date
    - name: "Cobra Expiration Date"
      expr: cobra_expiration_date
    - name: "Cobra Qualifying Event"
      expr: cobra_qualifying_event
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dependent Count"
      expr: dependent_count
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Employee Discount Eligible Flag"
      expr: employee_discount_eligible_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Enrollment"
      expr: COUNT(DISTINCT benefit_enrollment_id)
    - name: "Total Annual Premium Amount"
      expr: SUM(annual_premium_amount)
    - name: "Average Annual Premium Amount"
      expr: AVG(annual_premium_amount)
    - name: "Total Employee Contribution Amount"
      expr: SUM(employee_contribution_amount)
    - name: "Average Employee Contribution Amount"
      expr: AVG(employee_contribution_amount)
    - name: "Total Employee Discount Percentage"
      expr: SUM(employee_discount_percentage)
    - name: "Average Employee Discount Percentage"
      expr: AVG(employee_discount_percentage)
    - name: "Total Employer Contribution Amount"
      expr: SUM(employer_contribution_amount)
    - name: "Average Employer Contribution Amount"
      expr: AVG(employer_contribution_amount)
    - name: "Total Per Pay Period Deduction Amount"
      expr: SUM(per_pay_period_deduction_amount)
    - name: "Average Per Pay Period Deduction Amount"
      expr: AVG(per_pay_period_deduction_amount)
    - name: "Total Vesting Percentage"
      expr: SUM(vesting_percentage)
    - name: "Average Vesting Percentage"
      expr: AVG(vesting_percentage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_benefit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Plan business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`benefit_plan`"
  dimensions:
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Carrier Policy Number"
      expr: carrier_policy_number
    - name: "Contribution Frequency"
      expr: contribution_frequency
    - name: "Coverage Level"
      expr: coverage_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Employee Group Code"
      expr: employee_group_code
    - name: "Enrollment Period End Date"
      expr: enrollment_period_end_date
    - name: "Enrollment Period Start Date"
      expr: enrollment_period_start_date
    - name: "Is Aca Compliant"
      expr: is_aca_compliant
    - name: "Is Cobra Eligible"
      expr: is_cobra_eligible
    - name: "Is Fsa Eligible"
      expr: is_fsa_eligible
    - name: "Is Hsa Eligible"
      expr: is_hsa_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Plan"
      expr: COUNT(DISTINCT benefit_plan_id)
    - name: "Total Coinsurance Percentage"
      expr: SUM(coinsurance_percentage)
    - name: "Average Coinsurance Percentage"
      expr: AVG(coinsurance_percentage)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Employee Contribution Amount"
      expr: SUM(employee_contribution_amount)
    - name: "Average Employee Contribution Amount"
      expr: AVG(employee_contribution_amount)
    - name: "Total Employer Contribution Amount"
      expr: SUM(employer_contribution_amount)
    - name: "Average Employer Contribution Amount"
      expr: AVG(employer_contribution_amount)
    - name: "Total Out Of Pocket Maximum"
      expr: SUM(out_of_pocket_maximum)
    - name: "Average Out Of Pocket Maximum"
      expr: AVG(out_of_pocket_maximum)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_budget_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Period business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`budget_period`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Budget Version"
      expr: budget_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description"
      expr: budget_period_description
    - name: "Duration Days"
      expr: duration_days
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Month"
      expr: fiscal_month
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Active"
      expr: is_active
    - name: "Is Current"
      expr: is_current
    - name: "Is Locked"
      expr: is_locked
    - name: "Lock Date"
      expr: lock_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Period"
      expr: COUNT(DISTINCT budget_period_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation Plan business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "Annual Review Month"
      expr: annual_review_month
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Bonus Eligible"
      expr: bonus_eligible
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Commission Plan Code"
      expr: commission_plan_code
    - name: "Compensation Plan Status"
      expr: compensation_plan_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Equity Grant Eligible"
      expr: equity_grant_eligible
    - name: "Flsa Status"
      expr: flsa_status
    - name: "Last Review Date"
      expr: last_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Compensation Plan"
      expr: COUNT(DISTINCT compensation_plan_id)
    - name: "Total Base Pay Amount"
      expr: SUM(base_pay_amount)
    - name: "Average Base Pay Amount"
      expr: AVG(base_pay_amount)
    - name: "Total Bonus Target Percentage"
      expr: SUM(bonus_target_percentage)
    - name: "Average Bonus Target Percentage"
      expr: AVG(bonus_target_percentage)
    - name: "Total Compa Ratio"
      expr: SUM(compa_ratio)
    - name: "Average Compa Ratio"
      expr: AVG(compa_ratio)
    - name: "Total Equity Grant Amount"
      expr: SUM(equity_grant_amount)
    - name: "Average Equity Grant Amount"
      expr: AVG(equity_grant_amount)
    - name: "Total Pay Range Maximum"
      expr: SUM(pay_range_maximum)
    - name: "Average Pay Range Maximum"
      expr: AVG(pay_range_maximum)
    - name: "Total Pay Range Midpoint"
      expr: SUM(pay_range_midpoint)
    - name: "Average Pay Range Midpoint"
      expr: AVG(pay_range_midpoint)
    - name: "Total Pay Range Minimum"
      expr: SUM(pay_range_minimum)
    - name: "Average Pay Range Minimum"
      expr: AVG(pay_range_minimum)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_competency_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competency Model business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`competency_model`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Competency Count"
      expr: competency_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: competency_model_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Url"
      expr: external_reference_url
    - name: "Is Global"
      expr: is_global
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Model Code"
      expr: model_code
    - name: "Model Name"
      expr: model_name
    - name: "Model Type"
      expr: model_type
    - name: "Next Review Date"
      expr: next_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competency Model"
      expr: COUNT(DISTINCT competency_model_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`course`"
  dimensions:
    - name: "Assessment Required"
      expr: assessment_required
    - name: "Category"
      expr: course_category
    - name: "Certification Awarded"
      expr: certification_awarded
    - name: "Certification Name"
      expr: certification_name
    - name: "Certification Validity Months"
      expr: certification_validity_months
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Compliance Required"
      expr: compliance_required
    - name: "Content Owner"
      expr: content_owner
    - name: "Content Url"
      expr: content_url
    - name: "Course Code"
      expr: course_code
    - name: "Course Type"
      expr: course_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Description"
      expr: description
    - name: "Difficulty Level"
      expr: difficulty_level
    - name: "Effective End Date"
      expr: effective_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Course"
      expr: COUNT(DISTINCT course_id)
    - name: "Total Average Rating"
      expr: SUM(average_rating)
    - name: "Average Average Rating"
      expr: AVG(average_rating)
    - name: "Total Cost Per Learner"
      expr: SUM(cost_per_learner)
    - name: "Average Cost Per Learner"
      expr: AVG(cost_per_learner)
    - name: "Total Credit Hours"
      expr: SUM(credit_hours)
    - name: "Average Credit Hours"
      expr: AVG(credit_hours)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Passing Score Percentage"
      expr: SUM(passing_score_percentage)
    - name: "Average Passing Score Percentage"
      expr: AVG(passing_score_percentage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Department business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`department`"
  dimensions:
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Department Type"
      expr: department_type
    - name: "Description"
      expr: department_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Headcount Actual"
      expr: headcount_actual
    - name: "Headcount Planned"
      expr: headcount_planned
    - name: "Is Customer Facing"
      expr: is_customer_facing
    - name: "Is Revenue Generating"
      expr: is_revenue_generating
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Name"
      expr: name
    - name: "Requires Seasonal Staffing"
      expr: requires_seasonal_staffing
    - name: "Safety Certification Required"
      expr: safety_certification_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Department"
      expr: COUNT(DISTINCT department_id)
    - name: "Total Budget Amount Annual"
      expr: SUM(budget_amount_annual)
    - name: "Average Budget Amount Annual"
      expr: AVG(budget_amount_annual)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Department"
      expr: department
    - name: "Eeo Classification"
      expr: eeo_classification
    - name: "Email Address"
      expr: email_address
    - name: "Employment Status"
      expr: employment_status
    - name: "Employment Type"
      expr: employment_type
    - name: "First Name"
      expr: first_name
    - name: "Flsa Status"
      expr: flsa_status
    - name: "Hire Date"
      expr: hire_date
    - name: "Job Title"
      expr: job_title
    - name: "Last Name"
      expr: last_name
    - name: "Middle Name"
      expr: middle_name
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "National Id Number"
      expr: national_id_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employee"
      expr: COUNT(DISTINCT employee_id)
    - name: "Total Pay Rate"
      expr: SUM(pay_rate)
    - name: "Average Pay Rate"
      expr: AVG(pay_rate)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_job_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job Family business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`job_family`"
  dimensions:
    - name: "Bonus Eligible"
      expr: bonus_eligible
    - name: "Career Path Type"
      expr: career_path_type
    - name: "Category"
      expr: job_family_category
    - name: "Code"
      expr: code
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Compensation Grade Maximum"
      expr: compensation_grade_maximum
    - name: "Compensation Grade Minimum"
      expr: compensation_grade_minimum
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Skill Indicator"
      expr: critical_skill_indicator
    - name: "Description"
      expr: description
    - name: "Eeo Category"
      expr: eeo_category
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Flsa Classification"
      expr: flsa_classification
    - name: "Last Modified By User"
      expr: last_modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Job Family"
      expr: COUNT(DISTINCT job_family_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_job_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job Profile business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`job_profile`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Bonus Eligible Flag"
      expr: bonus_eligible_flag
    - name: "Career Path Progression"
      expr: career_path_progression
    - name: "Certifications Required"
      expr: certifications_required
    - name: "Commission Eligible Flag"
      expr: commission_eligible_flag
    - name: "Competency Requirements"
      expr: competency_requirements
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Role Flag"
      expr: critical_role_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Education Level Required"
      expr: education_level_required
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Employment Type"
      expr: employment_type
    - name: "Flsa Classification"
      expr: flsa_classification
    - name: "Job Family"
      expr: job_family
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Job Profile"
      expr: COUNT(DISTINCT job_profile_id)
    - name: "Total Pay Range Maximum"
      expr: SUM(pay_range_maximum)
    - name: "Average Pay Range Maximum"
      expr: AVG(pay_range_maximum)
    - name: "Total Pay Range Midpoint"
      expr: SUM(pay_range_midpoint)
    - name: "Average Pay Range Midpoint"
      expr: AVG(pay_range_midpoint)
    - name: "Total Pay Range Minimum"
      expr: SUM(pay_range_minimum)
    - name: "Average Pay Range Minimum"
      expr: AVG(pay_range_minimum)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_labor_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor Compliance Event business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`labor_compliance_event`"
  dimensions:
    - name: "Audit Reference Number"
      expr: audit_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Detected By"
      expr: detected_by
    - name: "Event Date"
      expr: event_date
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Recurrence Flag"
      expr: recurrence_flag
    - name: "Regulatory Filing Date"
      expr: regulatory_filing_date
    - name: "Regulatory Filing Required"
      expr: regulatory_filing_required
    - name: "Regulatory Framework"
      expr: regulatory_framework
    - name: "Remediation Action"
      expr: remediation_action
    - name: "Remediation Completed Date"
      expr: remediation_completed_date
    - name: "Remediation Due Date"
      expr: remediation_due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Labor Compliance Event"
      expr: COUNT(DISTINCT labor_compliance_event_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning Enrollment business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`learning_enrollment`"
  dimensions:
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Attempts Count"
      expr: attempts_count
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Certification Issued Flag"
      expr: certification_issued_flag
    - name: "Certification Number"
      expr: certification_number
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Compliance Category"
      expr: compliance_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Due Date"
      expr: due_date
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "Feedback Comments"
      expr: feedback_comments
    - name: "Instructor Name"
      expr: instructor_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Learning Enrollment"
      expr: COUNT(DISTINCT learning_enrollment_id)
    - name: "Total Assessment Score"
      expr: SUM(assessment_score)
    - name: "Average Assessment Score"
      expr: AVG(assessment_score)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Feedback Rating"
      expr: SUM(feedback_rating)
    - name: "Average Feedback Rating"
      expr: AVG(feedback_rating)
    - name: "Total Passing Score Threshold"
      expr: SUM(passing_score_threshold)
    - name: "Average Passing Score Threshold"
      expr: AVG(passing_score_threshold)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave Request business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "Actual Return Date"
      expr: actual_return_date
    - name: "Approval Comments"
      expr: approval_comments
    - name: "Approval Date"
      expr: approval_date
    - name: "Benefits Continuation Flag"
      expr: benefits_continuation_flag
    - name: "Certification Due Date"
      expr: certification_due_date
    - name: "Coverage Plan Required"
      expr: coverage_plan_required
    - name: "Denial Reason"
      expr: denial_reason
    - name: "End Date"
      expr: end_date
    - name: "Fmla Case Number"
      expr: fmla_case_number
    - name: "Intermittent Frequency"
      expr: intermittent_frequency
    - name: "Is Fmla Qualifying"
      expr: is_fmla_qualifying
    - name: "Is Intermittent"
      expr: is_intermittent
    - name: "Is Paid Leave"
      expr: is_paid_leave
    - name: "Is Seasonal Employee"
      expr: is_seasonal_employee
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Leave Subtype"
      expr: leave_subtype
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Leave Request"
      expr: COUNT(DISTINCT leave_request_id)
    - name: "Total Fmla Hours Used"
      expr: SUM(fmla_hours_used)
    - name: "Average Fmla Hours Used"
      expr: AVG(fmla_hours_used)
    - name: "Total Leave Balance After"
      expr: SUM(leave_balance_after)
    - name: "Average Leave Balance After"
      expr: AVG(leave_balance_after)
    - name: "Total Leave Balance Before"
      expr: SUM(leave_balance_before)
    - name: "Average Leave Balance Before"
      expr: AVG(leave_balance_before)
    - name: "Total Total Days Requested"
      expr: SUM(total_days_requested)
    - name: "Average Total Days Requested"
      expr: AVG(total_days_requested)
    - name: "Total Total Hours Requested"
      expr: SUM(total_hours_requested)
    - name: "Average Total Hours Requested"
      expr: AVG(total_hours_requested)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Location business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`location`"
  dimensions:
    - name: "Accessibility Features"
      expr: accessibility_features
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Closing Date"
      expr: closing_date
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "District"
      expr: district
    - name: "Email Address"
      expr: email_address
    - name: "Is Seasonal"
      expr: is_seasonal
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Lease End Date"
      expr: lease_end_date
    - name: "Lease Or Owned"
      expr: lease_or_owned
    - name: "Lease Start Date"
      expr: lease_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Location"
      expr: COUNT(DISTINCT location_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Monthly Rent Amount"
      expr: SUM(monthly_rent_amount)
    - name: "Average Monthly Rent Amount"
      expr: AVG(monthly_rent_amount)
    - name: "Total Square Footage"
      expr: SUM(square_footage)
    - name: "Average Square Footage"
      expr: AVG(square_footage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Org Unit business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`org_unit`"
  dimensions:
    - name: "Business Unit Code"
      expr: business_unit_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Division Code"
      expr: division_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Gl Segment"
      expr: gl_segment
    - name: "Headcount Capacity"
      expr: headcount_capacity
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Is Seasonal"
      expr: is_seasonal
    - name: "Labor Union Code"
      expr: labor_union_code
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Org Unit Description"
      expr: org_unit_description
    - name: "Org Unit Status"
      expr: org_unit_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Org Unit"
      expr: COUNT(DISTINCT org_unit_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_pay_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pay Period business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`pay_period`"
  dimensions:
    - name: "Calendar Month"
      expr: calendar_month
    - name: "Calendar Year"
      expr: calendar_year
    - name: "Check Date"
      expr: check_date
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Adjustment Period"
      expr: is_adjustment_period
    - name: "Is Current"
      expr: is_current
    - name: "Is Year End"
      expr: is_year_end
    - name: "Legal Entity Code"
      expr: legal_entity_code
    - name: "Locked Timestamp"
      expr: locked_timestamp
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pay Period"
      expr: COUNT(DISTINCT pay_period_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll Run business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cost Center Allocation Method"
      expr: cost_center_allocation_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Gl Posting Status"
      expr: gl_posting_status
    - name: "Is Year End Adjustment"
      expr: is_year_end_adjustment
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Pay Frequency"
      expr: pay_frequency
    - name: "Pay Group Code"
      expr: pay_group_code
    - name: "Pay Period End Date"
      expr: pay_period_end_date
    - name: "Pay Period Start Date"
      expr: pay_period_start_date
    - name: "Payment Batch Code"
      expr: payment_batch_code
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payroll Run"
      expr: COUNT(DISTINCT payroll_run_id)
    - name: "Total Total Employee Tax Amount"
      expr: SUM(total_employee_tax_amount)
    - name: "Average Total Employee Tax Amount"
      expr: AVG(total_employee_tax_amount)
    - name: "Total Total Employer Tax Amount"
      expr: SUM(total_employer_tax_amount)
    - name: "Average Total Employer Tax Amount"
      expr: AVG(total_employer_tax_amount)
    - name: "Total Total Gross Pay Amount"
      expr: SUM(total_gross_pay_amount)
    - name: "Average Total Gross Pay Amount"
      expr: AVG(total_gross_pay_amount)
    - name: "Total Total Net Pay Amount"
      expr: SUM(total_net_pay_amount)
    - name: "Average Total Net Pay Amount"
      expr: AVG(total_net_pay_amount)
    - name: "Total Total Overtime Hours"
      expr: SUM(total_overtime_hours)
    - name: "Average Total Overtime Hours"
      expr: AVG(total_overtime_hours)
    - name: "Total Total Post Tax Deduction Amount"
      expr: SUM(total_post_tax_deduction_amount)
    - name: "Average Total Post Tax Deduction Amount"
      expr: AVG(total_post_tax_deduction_amount)
    - name: "Total Total Pre Tax Deduction Amount"
      expr: SUM(total_pre_tax_deduction_amount)
    - name: "Average Total Pre Tax Deduction Amount"
      expr: AVG(total_pre_tax_deduction_amount)
    - name: "Total Total Pto Hours"
      expr: SUM(total_pto_hours)
    - name: "Average Total Pto Hours"
      expr: AVG(total_pto_hours)
    - name: "Total Total Regular Hours"
      expr: SUM(total_regular_hours)
    - name: "Average Total Regular Hours"
      expr: AVG(total_regular_hours)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance Review business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Calibration Session Date"
      expr: calibration_session_date
    - name: "Calibration Session Flag"
      expr: calibration_session_flag
    - name: "Competency Communication Rating"
      expr: competency_communication_rating
    - name: "Competency Leadership Rating"
      expr: competency_leadership_rating
    - name: "Competency Teamwork Rating"
      expr: competency_teamwork_rating
    - name: "Competency Technical Rating"
      expr: competency_technical_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Development Plan Actions"
      expr: development_plan_actions
    - name: "Document Url"
      expr: document_url
    - name: "Employee Acknowledgment Date"
      expr: employee_acknowledgment_date
    - name: "Employee Acknowledgment Status"
      expr: employee_acknowledgment_status
    - name: "Employee Comments"
      expr: employee_comments
    - name: "Finalized Timestamp"
      expr: finalized_timestamp
    - name: "Incident Date"
      expr: incident_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Performance Review"
      expr: COUNT(DISTINCT performance_review_id)
    - name: "Total Goal Achievement Percentage"
      expr: SUM(goal_achievement_percentage)
    - name: "Average Goal Achievement Percentage"
      expr: AVG(goal_achievement_percentage)
    - name: "Total Overall Rating Score"
      expr: SUM(overall_rating_score)
    - name: "Average Overall Rating Score"
      expr: AVG(overall_rating_score)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`position`"
  dimensions:
    - name: "Budget Year"
      expr: budget_year
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible For Bonus"
      expr: eligible_for_bonus
    - name: "Eligible For Commission"
      expr: eligible_for_commission
    - name: "Is Critical Position"
      expr: is_critical_position
    - name: "Is Filled"
      expr: is_filled
    - name: "Is Seasonal"
      expr: is_seasonal
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Minimum Education Level"
      expr: minimum_education_level
    - name: "Minimum Experience Years"
      expr: minimum_experience_years
    - name: "Pay Grade"
      expr: pay_grade
    - name: "Position Code"
      expr: position_code
    - name: "Position Description"
      expr: position_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Position"
      expr: COUNT(DISTINCT position_id)
    - name: "Total Annual Salary Max"
      expr: SUM(annual_salary_max)
    - name: "Average Annual Salary Max"
      expr: AVG(annual_salary_max)
    - name: "Total Annual Salary Min"
      expr: SUM(annual_salary_min)
    - name: "Average Annual Salary Min"
      expr: AVG(annual_salary_min)
    - name: "Total Fte Allocation"
      expr: SUM(fte_allocation)
    - name: "Average Fte Allocation"
      expr: AVG(fte_allocation)
    - name: "Total Standard Hours Per Week"
      expr: SUM(standard_hours_per_week)
    - name: "Average Standard Hours Per Week"
      expr: AVG(standard_hours_per_week)
    - name: "Total Travel Requirement Pct"
      expr: SUM(travel_requirement_pct)
    - name: "Average Travel Requirement Pct"
      expr: AVG(travel_requirement_pct)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Role business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`role`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Bonus Eligible"
      expr: bonus_eligible
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Compensation Currency Code"
      expr: compensation_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: role_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Employment Type"
      expr: employment_type
    - name: "Flsa Classification"
      expr: flsa_classification
    - name: "Headcount Target"
      expr: headcount_target
    - name: "Is Customer Facing"
      expr: is_customer_facing
    - name: "Is Safety Sensitive"
      expr: is_safety_sensitive
    - name: "Is Seasonal"
      expr: is_seasonal
    - name: "Job Grade"
      expr: job_grade
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Role"
      expr: COUNT(DISTINCT role_id)
    - name: "Total Compensation Band Maximum"
      expr: SUM(compensation_band_maximum)
    - name: "Average Compensation Band Maximum"
      expr: AVG(compensation_band_maximum)
    - name: "Total Compensation Band Minimum"
      expr: SUM(compensation_band_minimum)
    - name: "Average Compensation Band Minimum"
      expr: AVG(compensation_band_minimum)
    - name: "Total Travel Requirement Percentage"
      expr: SUM(travel_requirement_percentage)
    - name: "Average Travel Requirement Percentage"
      expr: AVG(travel_requirement_percentage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_shift_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift Assignment business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`shift_assignment`"
  dimensions:
    - name: "Absence Reason Code"
      expr: absence_reason_code
    - name: "Actual End Datetime"
      expr: actual_end_datetime
    - name: "Actual Start Datetime"
      expr: actual_start_datetime
    - name: "Attendance Status"
      expr: attendance_status
    - name: "Break Duration Minutes"
      expr: break_duration_minutes
    - name: "Compliance Violation Flag"
      expr: compliance_violation_flag
    - name: "Compliance Violation Type"
      expr: compliance_violation_type
    - name: "Early Departure Minutes"
      expr: early_departure_minutes
    - name: "Is Holiday Shift"
      expr: is_holiday_shift
    - name: "Is Overtime Eligible"
      expr: is_overtime_eligible
    - name: "Is Seasonal Worker"
      expr: is_seasonal_worker
    - name: "Last Modified Datetime"
      expr: last_modified_datetime
    - name: "Pay Code"
      expr: pay_code
    - name: "Schedule Created Datetime"
      expr: schedule_created_datetime
    - name: "Schedule Published Datetime"
      expr: schedule_published_datetime
    - name: "Scheduled End Datetime"
      expr: scheduled_end_datetime
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shift Assignment"
      expr: COUNT(DISTINCT shift_assignment_id)
    - name: "Total Actual Hours Worked"
      expr: SUM(actual_hours_worked)
    - name: "Average Actual Hours Worked"
      expr: AVG(actual_hours_worked)
    - name: "Total Geolocation Latitude"
      expr: SUM(geolocation_latitude)
    - name: "Average Geolocation Latitude"
      expr: AVG(geolocation_latitude)
    - name: "Total Geolocation Longitude"
      expr: SUM(geolocation_longitude)
    - name: "Average Geolocation Longitude"
      expr: AVG(geolocation_longitude)
    - name: "Total Labor Standard Hours"
      expr: SUM(labor_standard_hours)
    - name: "Average Labor Standard Hours"
      expr: AVG(labor_standard_hours)
    - name: "Total Overtime Hours"
      expr: SUM(overtime_hours)
    - name: "Average Overtime Hours"
      expr: AVG(overtime_hours)
    - name: "Total Scheduled Hours"
      expr: SUM(scheduled_hours)
    - name: "Average Scheduled Hours"
      expr: AVG(scheduled_hours)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_shift_swap_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift Swap Request business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`shift_swap_request`"
  dimensions:
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Compliance Check Status"
      expr: compliance_check_status
    - name: "Compliance Violation Notes"
      expr: compliance_violation_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expiration Timestamp"
      expr: expiration_timestamp
    - name: "Impacts Overtime"
      expr: impacts_overtime
    - name: "Is Reciprocal Swap"
      expr: is_reciprocal_swap
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manager Approval Status"
      expr: manager_approval_status
    - name: "Manager Approval Timestamp"
      expr: manager_approval_timestamp
    - name: "Manager Notes"
      expr: manager_notes
    - name: "Notification Sent Flag"
      expr: notification_sent_flag
    - name: "Notification Sent Timestamp"
      expr: notification_sent_timestamp
    - name: "Priority Level"
      expr: priority_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shift Swap Request"
      expr: COUNT(DISTINCT shift_swap_request_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_staffing_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staffing Model business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`staffing_model`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approving Authority"
      expr: approving_authority
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Labor Budget Currency"
      expr: labor_budget_currency
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Location Type"
      expr: location_type
    - name: "Model Name"
      expr: model_name
    - name: "Model Type"
      expr: model_type
    - name: "Model Version"
      expr: model_version
    - name: "Notes"
      expr: notes
    - name: "Peak End Date"
      expr: peak_end_date
    - name: "Peak Start Date"
      expr: peak_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Staffing Model"
      expr: COUNT(DISTINCT staffing_model_id)
    - name: "Total Actual Headcount"
      expr: SUM(actual_headcount)
    - name: "Average Actual Headcount"
      expr: AVG(actual_headcount)
    - name: "Total Coverage Ratio"
      expr: SUM(coverage_ratio)
    - name: "Average Coverage Ratio"
      expr: AVG(coverage_ratio)
    - name: "Total Headcount Variance"
      expr: SUM(headcount_variance)
    - name: "Average Headcount Variance"
      expr: AVG(headcount_variance)
    - name: "Total Labor Budget Amount"
      expr: SUM(labor_budget_amount)
    - name: "Average Labor Budget Amount"
      expr: AVG(labor_budget_amount)
    - name: "Total Otb Headcount Budget"
      expr: SUM(otb_headcount_budget)
    - name: "Average Otb Headcount Budget"
      expr: AVG(otb_headcount_budget)
    - name: "Total Peak Period Multiplier"
      expr: SUM(peak_period_multiplier)
    - name: "Average Peak Period Multiplier"
      expr: AVG(peak_period_multiplier)
    - name: "Total Seasonal Adjustment Factor"
      expr: SUM(seasonal_adjustment_factor)
    - name: "Average Seasonal Adjustment Factor"
      expr: AVG(seasonal_adjustment_factor)
    - name: "Total Target Headcount"
      expr: SUM(target_headcount)
    - name: "Average Target Headcount"
      expr: AVG(target_headcount)
    - name: "Total Target Hours Per Week"
      expr: SUM(target_hours_per_week)
    - name: "Average Target Hours Per Week"
      expr: AVG(target_hours_per_week)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_talent_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent Requisition business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`talent_requisition`"
  dimensions:
    - name: "Approval Workflow Status"
      expr: approval_workflow_status
    - name: "Approved Headcount"
      expr: approved_headcount
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Compensation Grade"
      expr: compensation_grade
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Diversity Initiative Flag"
      expr: diversity_initiative_flag
    - name: "Employment Type"
      expr: employment_type
    - name: "Is Remote Eligible"
      expr: is_remote_eligible
    - name: "Job Description"
      expr: job_description
    - name: "Job Posting Title"
      expr: job_posting_title
    - name: "Job Title"
      expr: job_title
    - name: "Minimum Education Level"
      expr: minimum_education_level
    - name: "Minimum Experience Years"
      expr: minimum_experience_years
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Talent Requisition"
      expr: COUNT(DISTINCT talent_requisition_id)
    - name: "Total Salary Range Maximum"
      expr: SUM(salary_range_maximum)
    - name: "Average Salary Range Maximum"
      expr: AVG(salary_range_maximum)
    - name: "Total Salary Range Minimum"
      expr: SUM(salary_range_minimum)
    - name: "Average Salary Range Minimum"
      expr: AVG(salary_range_minimum)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time Entry business metrics"
  source: "`apparel_fashion_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Clock In Timestamp"
      expr: clock_in_timestamp
    - name: "Clock Out Timestamp"
      expr: clock_out_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Identifier"
      expr: device_identifier
    - name: "Entry Status"
      expr: entry_status
    - name: "Exception Code"
      expr: exception_code
    - name: "Exception Notes"
      expr: exception_notes
    - name: "Ip Address"
      expr: ip_address
    - name: "Is Holiday Worked"
      expr: is_holiday_worked
    - name: "Is Manual Entry"
      expr: is_manual_entry
    - name: "Job Code"
      expr: job_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manual Entry Reason"
      expr: manual_entry_reason
    - name: "Meal Break Violation Flag"
      expr: meal_break_violation_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Time Entry"
      expr: COUNT(DISTINCT time_entry_id)
    - name: "Total Break Duration Minutes"
      expr: SUM(break_duration_minutes)
    - name: "Average Break Duration Minutes"
      expr: AVG(break_duration_minutes)
    - name: "Total Double Time Hours"
      expr: SUM(double_time_hours)
    - name: "Average Double Time Hours"
      expr: AVG(double_time_hours)
    - name: "Total Geolocation Latitude"
      expr: SUM(geolocation_latitude)
    - name: "Average Geolocation Latitude"
      expr: AVG(geolocation_latitude)
    - name: "Total Geolocation Longitude"
      expr: SUM(geolocation_longitude)
    - name: "Average Geolocation Longitude"
      expr: AVG(geolocation_longitude)
    - name: "Total Labor Cost Amount"
      expr: SUM(labor_cost_amount)
    - name: "Average Labor Cost Amount"
      expr: AVG(labor_cost_amount)
    - name: "Total Overtime Hours"
      expr: SUM(overtime_hours)
    - name: "Average Overtime Hours"
      expr: AVG(overtime_hours)
    - name: "Total Regular Hours"
      expr: SUM(regular_hours)
    - name: "Average Regular Hours"
      expr: AVG(regular_hours)
    - name: "Total Total Hours Worked"
      expr: SUM(total_hours_worked)
    - name: "Average Total Hours Worked"
      expr: AVG(total_hours_worked)
$$;
