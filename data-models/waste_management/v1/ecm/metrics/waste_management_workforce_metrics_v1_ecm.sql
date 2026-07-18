-- Metric views for domain: workforce | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:59:07

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Enrollment business metrics"
  source: "`waste_management_ecm`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "Beneficiary Name"
      expr: beneficiary_name
    - name: "Beneficiary Relationship"
      expr: beneficiary_relationship
    - name: "Carrier Confirmation Number"
      expr: carrier_confirmation_number
    - name: "Cobra Election Date"
      expr: cobra_election_date
    - name: "Cobra Eligible Indicator"
      expr: cobra_eligible_indicator
    - name: "Cobra End Date"
      expr: cobra_end_date
    - name: "Contribution Frequency"
      expr: contribution_frequency
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dependent Count"
      expr: dependent_count
    - name: "Effective Date"
      expr: effective_date
    - name: "Enrollment Confirmation Sent Date"
      expr: enrollment_confirmation_sent_date
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Event Type"
      expr: enrollment_event_type
    - name: "Enrollment Method"
      expr: enrollment_method
    - name: "Enrollment Number"
      expr: enrollment_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Enrollment"
      expr: COUNT(DISTINCT benefit_enrollment_id)
    - name: "Total Annual Employee Contribution"
      expr: SUM(annual_employee_contribution)
    - name: "Average Annual Employee Contribution"
      expr: AVG(annual_employee_contribution)
    - name: "Total Annual Employer Contribution"
      expr: SUM(annual_employer_contribution)
    - name: "Average Annual Employer Contribution"
      expr: AVG(annual_employer_contribution)
    - name: "Total Employee Contribution Amount"
      expr: SUM(employee_contribution_amount)
    - name: "Average Employee Contribution Amount"
      expr: AVG(employee_contribution_amount)
    - name: "Total Employer Contribution Amount"
      expr: SUM(employer_contribution_amount)
    - name: "Average Employer Contribution Amount"
      expr: AVG(employer_contribution_amount)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_benefit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Plan business metrics"
  source: "`waste_management_ecm`.`workforce`.`benefit_plan`"
  dimensions:
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Carrier Policy Number"
      expr: carrier_policy_number
    - name: "Cobra Eligible"
      expr: cobra_eligible
    - name: "Coverage Level"
      expr: coverage_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dependent Coverage Age Limit"
      expr: dependent_coverage_age_limit
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Enrollment Eligibility Rule"
      expr: enrollment_eligibility_rule
    - name: "Is Aca Compliant"
      expr: is_aca_compliant
    - name: "Is Erisa Plan"
      expr: is_erisa_plan
    - name: "Is Hsa Eligible"
      expr: is_hsa_eligible
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Open Enrollment End Date"
      expr: open_enrollment_end_date
    - name: "Open Enrollment Start Date"
      expr: open_enrollment_start_date
    - name: "Plan Administrator Email"
      expr: plan_administrator_email
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
    - name: "Total Coverage Amount"
      expr: SUM(coverage_amount)
    - name: "Average Coverage Amount"
      expr: AVG(coverage_amount)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Employee Contribution Amount"
      expr: SUM(employee_contribution_amount)
    - name: "Average Employee Contribution Amount"
      expr: AVG(employee_contribution_amount)
    - name: "Total Employee Contribution Percentage"
      expr: SUM(employee_contribution_percentage)
    - name: "Average Employee Contribution Percentage"
      expr: AVG(employee_contribution_percentage)
    - name: "Total Employer Contribution Amount"
      expr: SUM(employer_contribution_amount)
    - name: "Average Employer Contribution Amount"
      expr: AVG(employer_contribution_amount)
    - name: "Total Employer Contribution Percentage"
      expr: SUM(employer_contribution_percentage)
    - name: "Average Employer Contribution Percentage"
      expr: AVG(employer_contribution_percentage)
    - name: "Total Out Of Pocket Maximum"
      expr: SUM(out_of_pocket_maximum)
    - name: "Average Out Of Pocket Maximum"
      expr: AVG(out_of_pocket_maximum)
    - name: "Total Total Premium Amount"
      expr: SUM(total_premium_amount)
    - name: "Average Total Premium Amount"
      expr: AVG(total_premium_amount)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_cdl_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cdl License business metrics"
  source: "`waste_management_ecm`.`workforce`.`cdl_license`"
  dimensions:
    - name: "Cdl Class"
      expr: cdl_class
    - name: "Clearinghouse Query Date"
      expr: clearinghouse_query_date
    - name: "Clearinghouse Status"
      expr: clearinghouse_status
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dot Medical Certificate Expiration Date"
      expr: dot_medical_certificate_expiration_date
    - name: "Driver Qualification File Complete"
      expr: driver_qualification_file_complete
    - name: "Endorsements"
      expr: endorsements
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fmcsa Registration Number"
      expr: fmcsa_registration_number
    - name: "Hazmat Endorsement Expiration Date"
      expr: hazmat_endorsement_expiration_date
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing State"
      expr: issuing_state
    - name: "Last Alcohol Test Date"
      expr: last_alcohol_test_date
    - name: "Last Alcohol Test Result"
      expr: last_alcohol_test_result
    - name: "Last Drug Test Date"
      expr: last_drug_test_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cdl License"
      expr: COUNT(DISTINCT cdl_license_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification business metrics"
  source: "`waste_management_ecm`.`workforce`.`certification`"
  dimensions:
    - name: "Background Check Required"
      expr: background_check_required
    - name: "Cdl Class"
      expr: cdl_class
    - name: "Cdl Endorsement"
      expr: cdl_endorsement
    - name: "Certification Code"
      expr: certification_code
    - name: "Certification Description"
      expr: certification_description
    - name: "Certification Name"
      expr: certification_name
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Epa Program"
      expr: epa_program
    - name: "Equipment Authorization"
      expr: equipment_authorization
    - name: "Exam Required"
      expr: exam_required
    - name: "Facility Type Authorization"
      expr: facility_type_authorization
    - name: "Hazmat Category"
      expr: hazmat_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certification"
      expr: COUNT(DISTINCT certification_id)
    - name: "Total Continuing Education Hours"
      expr: SUM(continuing_education_hours)
    - name: "Average Continuing Education Hours"
      expr: AVG(continuing_education_hours)
    - name: "Total Cost Estimate Usd"
      expr: SUM(cost_estimate_usd)
    - name: "Average Cost Estimate Usd"
      expr: AVG(cost_estimate_usd)
    - name: "Total Minimum Passing Score"
      expr: SUM(minimum_passing_score)
    - name: "Average Minimum Passing Score"
      expr: AVG(minimum_passing_score)
    - name: "Total Training Hours Required"
      expr: SUM(training_hours_required)
    - name: "Average Training Hours Required"
      expr: AVG(training_hours_required)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Center business metrics"
  source: "`waste_management_ecm`.`workforce`.`cost_center`"
  dimensions:
    - name: "Category"
      expr: cost_center_category
    - name: "Closure Reason"
      expr: closure_reason
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description"
      expr: cost_center_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "General Ledger Account Code"
      expr: general_ledger_account_code
    - name: "Is Billable"
      expr: is_billable
    - name: "Is Capital Project"
      expr: is_capital_project
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Name"
      expr: cost_center_name
    - name: "Notes"
      expr: notes
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Region Code"
      expr: region_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Center"
      expr: COUNT(DISTINCT cost_center_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Department business metrics"
  source: "`waste_management_ecm`.`workforce`.`department`"
  dimensions:
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
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
    - name: "Email Address"
      expr: email_address
    - name: "Headcount Actual"
      expr: headcount_actual
    - name: "Headcount Budgeted"
      expr: headcount_budgeted
    - name: "Is Billable"
      expr: is_billable
    - name: "Is Customer Facing"
      expr: is_customer_facing
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Name"
      expr: department_name
    - name: "Phone Number"
      expr: phone_number
    - name: "Requires Cdl"
      expr: requires_cdl
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Department"
      expr: COUNT(DISTINCT department_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary Action business metrics"
  source: "`waste_management_ecm`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Action Date"
      expr: action_date
    - name: "Action Number"
      expr: action_number
    - name: "Action Type"
      expr: action_type
    - name: "Appeal Date"
      expr: appeal_date
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Resolution Date"
      expr: appeal_resolution_date
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department Code"
      expr: department_code
    - name: "Disciplinary Action Status"
      expr: disciplinary_action_status
    - name: "Dot Reportable Flag"
      expr: dot_reportable_flag
    - name: "Eligible For Rehire Flag"
      expr: eligible_for_rehire_flag
    - name: "Employee Acknowledgment Flag"
      expr: employee_acknowledgment_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Disciplinary Action"
      expr: COUNT(DISTINCT disciplinary_action_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_division`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Division business metrics"
  source: "`waste_management_ecm`.`workforce`.`division`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Division Code"
      expr: division_code
    - name: "Division Name"
      expr: division_name
    - name: "Division Type"
      expr: division_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Fax Number"
      expr: fax_number
    - name: "General Ledger Account Code"
      expr: general_ledger_account_code
    - name: "Headcount Actual"
      expr: headcount_actual
    - name: "Headcount Authorized"
      expr: headcount_authorized
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Division"
      expr: COUNT(DISTINCT division_id)
    - name: "Total Safety Incident Rate"
      expr: SUM(safety_incident_rate)
    - name: "Average Safety Incident Rate"
      expr: AVG(safety_incident_rate)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_dot_drug_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dot Drug Test business metrics"
  source: "`waste_management_ecm`.`workforce`.`dot_drug_test`"
  dimensions:
    - name: "Cdl License Number"
      expr: cdl_license_number
    - name: "Cdl State"
      expr: cdl_state
    - name: "Collection Site Address"
      expr: collection_site_address
    - name: "Collection Site Name"
      expr: collection_site_name
    - name: "Collector Name"
      expr: collector_name
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Concentration Level"
      expr: concentration_level
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Follow Up Testing Plan Flag"
      expr: follow_up_testing_plan_flag
    - name: "Job Title"
      expr: job_title
    - name: "Laboratory Certification Number"
      expr: laboratory_certification_number
    - name: "Laboratory Name"
      expr: laboratory_name
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Mro Contact Phone"
      expr: mro_contact_phone
    - name: "Mro Name"
      expr: mro_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dot Drug Test"
      expr: COUNT(DISTINCT dot_drug_test_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee business metrics"
  source: "`waste_management_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "Cdl Class"
      expr: cdl_class
    - name: "Cdl Endorsements"
      expr: cdl_endorsements
    - name: "Cdl Expiration Date"
      expr: cdl_expiration_date
    - name: "Cdl License Number"
      expr: cdl_license_number
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Department"
      expr: department
    - name: "Dot Medical Card Expiration Date"
      expr: dot_medical_card_expiration_date
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
    - name: "Hazwoper Certification Date"
      expr: hazwoper_certification_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employee"
      expr: COUNT(DISTINCT employee_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_employee_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee Assignment business metrics"
  source: "`waste_management_ecm`.`workforce`.`employee_assignment`"
  dimensions:
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Cdl Required Flag"
      expr: cdl_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Employment Type"
      expr: employment_type
    - name: "End Date"
      expr: end_date
    - name: "Flsa Status"
      expr: flsa_status
    - name: "Hazmat Endorsement Required Flag"
      expr: hazmat_endorsement_required_flag
    - name: "Job Code"
      expr: job_code
    - name: "Job Title"
      expr: job_title
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "On Call Flag"
      expr: on_call_flag
    - name: "Osha Training Required Flag"
      expr: osha_training_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employee Assignment"
      expr: COUNT(DISTINCT employee_assignment_id)
    - name: "Total Fte Equivalent"
      expr: SUM(fte_equivalent)
    - name: "Average Fte Equivalent"
      expr: AVG(fte_equivalent)
    - name: "Total Labor Allocation Percentage"
      expr: SUM(labor_allocation_percentage)
    - name: "Average Labor Allocation Percentage"
      expr: AVG(labor_allocation_percentage)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_employee_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee Certification business metrics"
  source: "`waste_management_ecm`.`workforce`.`employee_certification`"
  dimensions:
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certification Level"
      expr: certification_level
    - name: "Certification Status"
      expr: certification_status
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Attachment Path"
      expr: document_attachment_path
    - name: "Endorsements"
      expr: endorsements
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Instructor Name"
      expr: instructor_name
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Organization"
      expr: issuing_organization
    - name: "Job Requirement Flag"
      expr: job_requirement_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Modified By"
      expr: modified_by
    - name: "Next Renewal Due Date"
      expr: next_renewal_due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employee Certification"
      expr: COUNT(DISTINCT employee_certification_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Exam Score"
      expr: SUM(exam_score)
    - name: "Average Exam Score"
      expr: AVG(exam_score)
    - name: "Total Passing Score Required"
      expr: SUM(passing_score_required)
    - name: "Average Passing Score Required"
      expr: AVG(passing_score_required)
    - name: "Total Training Hours"
      expr: SUM(training_hours)
    - name: "Average Training Hours"
      expr: AVG(training_hours)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grievance business metrics"
  source: "`waste_management_ecm`.`workforce`.`grievance`"
  dimensions:
    - name: "Arbitration Date"
      expr: arbitration_date
    - name: "Arbitration Decision"
      expr: arbitration_decision
    - name: "Arbitration Flag"
      expr: arbitration_flag
    - name: "Arbitrator Name"
      expr: arbitrator_name
    - name: "Cba Article Cited"
      expr: cba_article_cited
    - name: "Confidential Flag"
      expr: confidential_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Filing Date"
      expr: filing_date
    - name: "Grievance Number"
      expr: grievance_number
    - name: "Grievance Status"
      expr: grievance_status
    - name: "Grievance Type"
      expr: grievance_type
    - name: "Incident Date"
      expr: incident_date
    - name: "Incident Description"
      expr: incident_description
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Management Response"
      expr: management_response
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grievance"
      expr: COUNT(DISTINCT grievance_id)
    - name: "Total Back Pay Amount"
      expr: SUM(back_pay_amount)
    - name: "Average Back Pay Amount"
      expr: AVG(back_pay_amount)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_job_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job Position business metrics"
  source: "`waste_management_ecm`.`workforce`.`job_position`"
  dimensions:
    - name: "Background Check Level"
      expr: background_check_level
    - name: "Cdl Class Required"
      expr: cdl_class_required
    - name: "Cdl Endorsements Required"
      expr: cdl_endorsements_required
    - name: "Cdl Required Flag"
      expr: cdl_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Direct Reports Count"
      expr: direct_reports_count
    - name: "Dot Regulated Flag"
      expr: dot_regulated_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Epa Certification Required"
      expr: epa_certification_required
    - name: "Flsa Classification"
      expr: flsa_classification
    - name: "Hazwoper Certification Required"
      expr: hazwoper_certification_required
    - name: "Headcount Authorization"
      expr: headcount_authorization
    - name: "Job Family"
      expr: job_family
    - name: "Job Level"
      expr: job_level
    - name: "Last Modified By"
      expr: last_modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Job Position"
      expr: COUNT(DISTINCT job_position_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_job_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job Requisition business metrics"
  source: "`waste_management_ecm`.`workforce`.`job_requisition`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Headcount"
      expr: approved_headcount
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department Code"
      expr: department_code
    - name: "Education Level Required"
      expr: education_level_required
    - name: "Filled Headcount"
      expr: filled_headcount
    - name: "Job Description"
      expr: job_description
    - name: "Minimum Experience Years"
      expr: minimum_experience_years
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Posting Channel"
      expr: posting_channel
    - name: "Priority Level"
      expr: priority_level
    - name: "Requisition Close Date"
      expr: requisition_close_date
    - name: "Requisition Number"
      expr: requisition_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Job Requisition"
      expr: COUNT(DISTINCT job_requisition_id)
    - name: "Total Approved Budget Amount"
      expr: SUM(approved_budget_amount)
    - name: "Average Approved Budget Amount"
      expr: AVG(approved_budget_amount)
    - name: "Total Salary Range Max"
      expr: SUM(salary_range_max)
    - name: "Average Salary Range Max"
      expr: AVG(salary_range_max)
    - name: "Total Salary Range Min"
      expr: SUM(salary_range_min)
    - name: "Average Salary Range Min"
      expr: AVG(salary_range_min)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_labor_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor Cost Allocation business metrics"
  source: "`waste_management_ecm`.`workforce`.`labor_cost_allocation`"
  dimensions:
    - name: "Activity Type Code"
      expr: activity_type_code
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Business Unit Code"
      expr: business_unit_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Internal Order Number"
      expr: internal_order_number
    - name: "Job Classification"
      expr: job_classification
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Pay Period End Date"
      expr: pay_period_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Labor Cost Allocation"
      expr: COUNT(DISTINCT labor_cost_allocation_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Hazard Pay Amount"
      expr: SUM(hazard_pay_amount)
    - name: "Average Hazard Pay Amount"
      expr: AVG(hazard_pay_amount)
    - name: "Total Hours Worked"
      expr: SUM(hours_worked)
    - name: "Average Hours Worked"
      expr: AVG(hours_worked)
    - name: "Total Labor Rate"
      expr: SUM(labor_rate)
    - name: "Average Labor Rate"
      expr: AVG(labor_rate)
    - name: "Total Overtime Hours"
      expr: SUM(overtime_hours)
    - name: "Average Overtime Hours"
      expr: AVG(overtime_hours)
    - name: "Total Overtime Pay Amount"
      expr: SUM(overtime_pay_amount)
    - name: "Average Overtime Pay Amount"
      expr: AVG(overtime_pay_amount)
    - name: "Total Regular Hours"
      expr: SUM(regular_hours)
    - name: "Average Regular Hours"
      expr: AVG(regular_hours)
    - name: "Total Regular Pay Amount"
      expr: SUM(regular_pay_amount)
    - name: "Average Regular Pay Amount"
      expr: AVG(regular_pay_amount)
    - name: "Total Shift Differential Amount"
      expr: SUM(shift_differential_amount)
    - name: "Average Shift Differential Amount"
      expr: AVG(shift_differential_amount)
    - name: "Total Total Labor Cost"
      expr: SUM(total_labor_cost)
    - name: "Average Total Labor Cost"
      expr: AVG(total_labor_cost)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Org Unit business metrics"
  source: "`waste_management_ecm`.`workforce`.`org_unit`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Headcount"
      expr: current_headcount
    - name: "Dot Facility Number"
      expr: dot_facility_number
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Facility Type"
      expr: facility_type
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Headcount Capacity"
      expr: headcount_capacity
    - name: "Is Deleted"
      expr: is_deleted
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Org Unit"
      expr: COUNT(DISTINCT org_unit_id)
    - name: "Total Budget Amount Annual"
      expr: SUM(budget_amount_annual)
    - name: "Average Budget Amount Annual"
      expr: AVG(budget_amount_annual)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_pay_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pay Period business metrics"
  source: "`waste_management_ecm`.`workforce`.`pay_period`"
  dimensions:
    - name: "Approval Deadline Date"
      expr: approval_deadline_date
    - name: "Calendar Month"
      expr: calendar_month
    - name: "Calendar Year"
      expr: calendar_year
    - name: "Check Date"
      expr: check_date
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Finalized Timestamp"
      expr: finalized_timestamp
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Frequency Type"
      expr: frequency_type
    - name: "Holiday Count"
      expr: holiday_count
    - name: "Is Adjustment Period"
      expr: is_adjustment_period
    - name: "Is Year End Period"
      expr: is_year_end_period
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

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll Record business metrics"
  source: "`waste_management_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Pay Date"
      expr: pay_date
    - name: "Pay Period End Date"
      expr: pay_period_end_date
    - name: "Pay Period Start Date"
      expr: pay_period_start_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payroll Status"
      expr: payroll_status
    - name: "Sap Posting Reference"
      expr: sap_posting_reference
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payroll Record"
      expr: COUNT(DISTINCT payroll_record_id)
    - name: "Total Bonus Amount"
      expr: SUM(bonus_amount)
    - name: "Average Bonus Amount"
      expr: AVG(bonus_amount)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Dental Insurance Deduction"
      expr: SUM(dental_insurance_deduction)
    - name: "Average Dental Insurance Deduction"
      expr: AVG(dental_insurance_deduction)
    - name: "Total Disability Insurance Deduction"
      expr: SUM(disability_insurance_deduction)
    - name: "Average Disability Insurance Deduction"
      expr: AVG(disability_insurance_deduction)
    - name: "Total Federal Income Tax"
      expr: SUM(federal_income_tax)
    - name: "Average Federal Income Tax"
      expr: AVG(federal_income_tax)
    - name: "Total Garnishment Deduction"
      expr: SUM(garnishment_deduction)
    - name: "Average Garnishment Deduction"
      expr: AVG(garnishment_deduction)
    - name: "Total Gross Pay"
      expr: SUM(gross_pay)
    - name: "Average Gross Pay"
      expr: AVG(gross_pay)
    - name: "Total Hazard Pay"
      expr: SUM(hazard_pay)
    - name: "Average Hazard Pay"
      expr: AVG(hazard_pay)
    - name: "Total Life Insurance Deduction"
      expr: SUM(life_insurance_deduction)
    - name: "Average Life Insurance Deduction"
      expr: AVG(life_insurance_deduction)
    - name: "Total Medical Insurance Deduction"
      expr: SUM(medical_insurance_deduction)
    - name: "Average Medical Insurance Deduction"
      expr: AVG(medical_insurance_deduction)
    - name: "Total Medicare Tax"
      expr: SUM(medicare_tax)
    - name: "Average Medicare Tax"
      expr: AVG(medicare_tax)
    - name: "Total Net Pay"
      expr: SUM(net_pay)
    - name: "Average Net Pay"
      expr: AVG(net_pay)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance Review business metrics"
  source: "`waste_management_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "Action Type"
      expr: action_type
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Resolution Date"
      expr: appeal_resolution_date
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department Code"
      expr: department_code
    - name: "Employee Acknowledgment Date"
      expr: employee_acknowledgment_date
    - name: "Employee Acknowledgment Flag"
      expr: employee_acknowledgment_flag
    - name: "Employee Comments"
      expr: employee_comments
    - name: "Job Classification"
      expr: job_classification
    - name: "Merit Increase Recommended Flag"
      expr: merit_increase_recommended_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Near Miss Reports Count"
      expr: near_miss_reports_count
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Performance Review"
      expr: COUNT(DISTINCT performance_review_id)
    - name: "Total Attendance Score"
      expr: SUM(attendance_score)
    - name: "Average Attendance Score"
      expr: AVG(attendance_score)
    - name: "Total Customer Service Score"
      expr: SUM(customer_service_score)
    - name: "Average Customer Service Score"
      expr: AVG(customer_service_score)
    - name: "Total Merit Increase Percentage"
      expr: SUM(merit_increase_percentage)
    - name: "Average Merit Increase Percentage"
      expr: AVG(merit_increase_percentage)
    - name: "Total Overall Rating Score"
      expr: SUM(overall_rating_score)
    - name: "Average Overall Rating Score"
      expr: AVG(overall_rating_score)
    - name: "Total Productivity Metric Value"
      expr: SUM(productivity_metric_value)
    - name: "Average Productivity Metric Value"
      expr: AVG(productivity_metric_value)
    - name: "Total Quality Of Work Score"
      expr: SUM(quality_of_work_score)
    - name: "Average Quality Of Work Score"
      expr: AVG(quality_of_work_score)
    - name: "Total Safety Performance Score"
      expr: SUM(safety_performance_score)
    - name: "Average Safety Performance Score"
      expr: AVG(safety_performance_score)
    - name: "Total Teamwork Collaboration Score"
      expr: SUM(teamwork_collaboration_score)
    - name: "Average Teamwork Collaboration Score"
      expr: AVG(teamwork_collaboration_score)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift Schedule business metrics"
  source: "`waste_management_ecm`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "Break Duration Minutes"
      expr: break_duration_minutes
    - name: "Cdl Required Flag"
      expr: cdl_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Of Week"
      expr: days_of_week
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "End Time"
      expr: end_time
    - name: "Hazwoper Required Flag"
      expr: hazwoper_required_flag
    - name: "Headcount Capacity"
      expr: headcount_capacity
    - name: "Job Classification"
      expr: job_classification
    - name: "Minimum Staffing Level"
      expr: minimum_staffing_level
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Osha Certification Required"
      expr: osha_certification_required
    - name: "Overtime Eligible Flag"
      expr: overtime_eligible_flag
    - name: "Ppe Requirements"
      expr: ppe_requirements
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shift Schedule"
      expr: COUNT(DISTINCT shift_schedule_id)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Shift Differential Rate"
      expr: SUM(shift_differential_rate)
    - name: "Average Shift Differential Rate"
      expr: AVG(shift_differential_rate)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time Entry business metrics"
  source: "`waste_management_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "Absence Code"
      expr: absence_code
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Break Time Minutes"
      expr: break_time_minutes
    - name: "Cdl Hos Compliant Flag"
      expr: cdl_hos_compliant_flag
    - name: "Clock In Timestamp"
      expr: clock_in_timestamp
    - name: "Clock Out Timestamp"
      expr: clock_out_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Hazmat Work Flag"
      expr: hazmat_work_flag
    - name: "Hos Violation Code"
      expr: hos_violation_code
    - name: "Job Code"
      expr: job_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payroll Processed Flag"
      expr: payroll_processed_flag
    - name: "Ppe Issued Flag"
      expr: ppe_issued_flag
    - name: "Submitted Timestamp"
      expr: submitted_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Time Entry"
      expr: COUNT(DISTINCT time_entry_id)
    - name: "Total Driving Hours"
      expr: SUM(driving_hours)
    - name: "Average Driving Hours"
      expr: AVG(driving_hours)
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
    - name: "Total Off Duty Hours"
      expr: SUM(off_duty_hours)
    - name: "Average Off Duty Hours"
      expr: AVG(off_duty_hours)
    - name: "Total On Duty Not Driving Hours"
      expr: SUM(on_duty_not_driving_hours)
    - name: "Average On Duty Not Driving Hours"
      expr: AVG(on_duty_not_driving_hours)
    - name: "Total Overtime Hours"
      expr: SUM(overtime_hours)
    - name: "Average Overtime Hours"
      expr: AVG(overtime_hours)
    - name: "Total Regular Hours"
      expr: SUM(regular_hours)
    - name: "Average Regular Hours"
      expr: AVG(regular_hours)
    - name: "Total Sleeper Berth Hours"
      expr: SUM(sleeper_berth_hours)
    - name: "Average Sleeper Berth Hours"
      expr: AVG(sleeper_berth_hours)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_training_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training Course business metrics"
  source: "`waste_management_ecm`.`workforce`.`training_course`"
  dimensions:
    - name: "Assessment Required Flag"
      expr: assessment_required_flag
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Course Category"
      expr: course_category
    - name: "Course Code"
      expr: course_code
    - name: "Course Description"
      expr: course_description
    - name: "Course Materials Description"
      expr: course_materials_description
    - name: "Course Name"
      expr: course_name
    - name: "Course Status"
      expr: course_status
    - name: "Course Subcategory"
      expr: course_subcategory
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Instructor Qualification Required"
      expr: instructor_qualification_required
    - name: "Language Offered"
      expr: language_offered
    - name: "Last Content Review Date"
      expr: last_content_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Training Course"
      expr: COUNT(DISTINCT training_course_id)
    - name: "Total Continuing Education Credits"
      expr: SUM(continuing_education_credits)
    - name: "Average Continuing Education Credits"
      expr: AVG(continuing_education_credits)
    - name: "Total Cost Per Employee"
      expr: SUM(cost_per_employee)
    - name: "Average Cost Per Employee"
      expr: AVG(cost_per_employee)
    - name: "Total Duration Days"
      expr: SUM(duration_days)
    - name: "Average Duration Days"
      expr: AVG(duration_days)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Minimum Passing Score"
      expr: SUM(minimum_passing_score)
    - name: "Average Minimum Passing Score"
      expr: AVG(minimum_passing_score)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_union_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Union Agreement business metrics"
  source: "`waste_management_ecm`.`workforce`.`union_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Arbitration Provision Flag"
      expr: arbitration_provision_flag
    - name: "Bargaining Unit Size"
      expr: bargaining_unit_size
    - name: "Covered Job Classifications"
      expr: covered_job_classifications
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Attachment Path"
      expr: document_attachment_path
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Grievance Filing Deadline Days"
      expr: grievance_filing_deadline_days
    - name: "Grievance Procedure Steps"
      expr: grievance_procedure_steps
    - name: "Lead Negotiator Name"
      expr: lead_negotiator_name
    - name: "Management Rights Clause Flag"
      expr: management_rights_clause_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Negotiation Completion Date"
      expr: negotiation_completion_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Union Agreement"
      expr: COUNT(DISTINCT union_agreement_id)
    - name: "Total Base Wage Rate Maximum"
      expr: SUM(base_wage_rate_maximum)
    - name: "Average Base Wage Rate Maximum"
      expr: AVG(base_wage_rate_maximum)
    - name: "Total Base Wage Rate Minimum"
      expr: SUM(base_wage_rate_minimum)
    - name: "Average Base Wage Rate Minimum"
      expr: AVG(base_wage_rate_minimum)
    - name: "Total Cdl Premium Rate"
      expr: SUM(cdl_premium_rate)
    - name: "Average Cdl Premium Rate"
      expr: AVG(cdl_premium_rate)
    - name: "Total Double Time Threshold Hours"
      expr: SUM(double_time_threshold_hours)
    - name: "Average Double Time Threshold Hours"
      expr: AVG(double_time_threshold_hours)
    - name: "Total Hazard Pay Rate"
      expr: SUM(hazard_pay_rate)
    - name: "Average Hazard Pay Rate"
      expr: AVG(hazard_pay_rate)
    - name: "Total Health Insurance Employer Contribution Pct"
      expr: SUM(health_insurance_employer_contribution_pct)
    - name: "Average Health Insurance Employer Contribution Pct"
      expr: AVG(health_insurance_employer_contribution_pct)
    - name: "Total Overtime Multiplier"
      expr: SUM(overtime_multiplier)
    - name: "Average Overtime Multiplier"
      expr: AVG(overtime_multiplier)
    - name: "Total Overtime Threshold Hours"
      expr: SUM(overtime_threshold_hours)
    - name: "Average Overtime Threshold Hours"
      expr: AVG(overtime_threshold_hours)
    - name: "Total Paid Time Off Accrual Rate"
      expr: SUM(paid_time_off_accrual_rate)
    - name: "Average Paid Time Off Accrual Rate"
      expr: AVG(paid_time_off_accrual_rate)
    - name: "Total Pension Employer Contribution Pct"
      expr: SUM(pension_employer_contribution_pct)
    - name: "Average Pension Employer Contribution Pct"
      expr: AVG(pension_employer_contribution_pct)
    - name: "Total Shift Differential Rate"
      expr: SUM(shift_differential_rate)
    - name: "Average Shift Differential Rate"
      expr: AVG(shift_differential_rate)
    - name: "Total Union Dues Deduction Amount"
      expr: SUM(union_dues_deduction_amount)
    - name: "Average Union Dues Deduction Amount"
      expr: AVG(union_dues_deduction_amount)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_workers_comp_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workers Comp Claim business metrics"
  source: "`waste_management_ecm`.`workforce`.`workers_comp_claim`"
  dimensions:
    - name: "Adjuster Name"
      expr: adjuster_name
    - name: "Adjuster Phone"
      expr: adjuster_phone
    - name: "Body Part Affected"
      expr: body_part_affected
    - name: "Claim Filed Date"
      expr: claim_filed_date
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Status"
      expr: claim_status
    - name: "Corrective Actions"
      expr: corrective_actions
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Incident Location"
      expr: incident_location
    - name: "Injury Date"
      expr: injury_date
    - name: "Injury Description"
      expr: injury_description
    - name: "Injury Severity"
      expr: injury_severity
    - name: "Injury Type"
      expr: injury_type
    - name: "Insurer Claim Reference"
      expr: insurer_claim_reference
    - name: "Insurer Name"
      expr: insurer_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Workers Comp Claim"
      expr: COUNT(DISTINCT workers_comp_claim_id)
    - name: "Total Claim Reserve Amount"
      expr: SUM(claim_reserve_amount)
    - name: "Average Claim Reserve Amount"
      expr: AVG(claim_reserve_amount)
    - name: "Total Indemnity Cost"
      expr: SUM(indemnity_cost)
    - name: "Average Indemnity Cost"
      expr: AVG(indemnity_cost)
    - name: "Total Medical Cost"
      expr: SUM(medical_cost)
    - name: "Average Medical Cost"
      expr: AVG(medical_cost)
    - name: "Total Total Incurred Cost"
      expr: SUM(total_incurred_cost)
    - name: "Average Total Incurred Cost"
      expr: AVG(total_incurred_cost)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`workforce_workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce Training Record business metrics"
  source: "`waste_management_ecm`.`workforce`.`workforce_training_record`"
  dimensions:
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Attempts Count"
      expr: attempts_count
    - name: "Attendance Status"
      expr: attendance_status
    - name: "Certification Expiration Date"
      expr: certification_expiration_date
    - name: "Certification Issued"
      expr: certification_issued
    - name: "Certification Number"
      expr: certification_number
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Cost Center"
      expr: cost_center
    - name: "Course Code"
      expr: course_code
    - name: "Course Name"
      expr: course_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Department"
      expr: department
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Workforce Training Record"
      expr: COUNT(DISTINCT workforce_training_record_id)
    - name: "Total Ceu Credits"
      expr: SUM(ceu_credits)
    - name: "Average Ceu Credits"
      expr: AVG(ceu_credits)
    - name: "Total Passing Score Threshold"
      expr: SUM(passing_score_threshold)
    - name: "Average Passing Score Threshold"
      expr: AVG(passing_score_threshold)
    - name: "Total Score"
      expr: SUM(score)
    - name: "Average Score"
      expr: AVG(score)
    - name: "Total Training Cost"
      expr: SUM(training_cost)
    - name: "Average Training Cost"
      expr: AVG(training_cost)
    - name: "Total Training Hours"
      expr: SUM(training_hours)
    - name: "Average Training Hours"
      expr: AVG(training_hours)
$$;
