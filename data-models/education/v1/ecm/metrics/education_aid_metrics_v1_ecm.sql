-- Metric views for domain: aid | Business: Education | Version: 1 | Generated on: 2026-05-06 12:19:37

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_aid_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aid Application business metrics"
  source: "`education_ecm`.`aid`.`aid_application`"
  dimensions:
    - name: "Aggregate Loan Limit Flag"
      expr: aggregate_loan_limit_flag
    - name: "Application Number"
      expr: application_number
    - name: "Application Status"
      expr: application_status
    - name: "C Code Flag"
      expr: c_code_flag
    - name: "Citizenship Status"
      expr: citizenship_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Overpayment Flag"
      expr: default_overpayment_flag
    - name: "Direct Loan Eligible Flag"
      expr: direct_loan_eligible_flag
    - name: "Drug Conviction Flag"
      expr: drug_conviction_flag
    - name: "Enrollment Intensity"
      expr: enrollment_intensity
    - name: "Fafsa Receipt Date"
      expr: fafsa_receipt_date
    - name: "Housing Plan Code"
      expr: housing_plan_code
    - name: "Pell Eligible Flag"
      expr: pell_eligible_flag
    - name: "Professional Judgment Flag"
      expr: professional_judgment_flag
    - name: "Professional Judgment Reason"
      expr: professional_judgment_reason
    - name: "Selective Service Compliance Flag"
      expr: selective_service_compliance_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aid Application"
      expr: COUNT(DISTINCT aid_application_id)
    - name: "Total Coa Amount"
      expr: SUM(coa_amount)
    - name: "Average Coa Amount"
      expr: AVG(coa_amount)
    - name: "Total Financial Need Amount"
      expr: SUM(financial_need_amount)
    - name: "Average Financial Need Amount"
      expr: AVG(financial_need_amount)
    - name: "Total Institutional Methodology Efc"
      expr: SUM(institutional_methodology_efc)
    - name: "Average Institutional Methodology Efc"
      expr: AVG(institutional_methodology_efc)
    - name: "Total Pell Leu Percentage"
      expr: SUM(pell_leu_percentage)
    - name: "Average Pell Leu Percentage"
      expr: AVG(pell_leu_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_aid_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aid Award business metrics"
  source: "`education_ecm`.`aid`.`aid_award`"
  dimensions:
    - name: "Acceptance Date"
      expr: acceptance_date
    - name: "Aid Year"
      expr: aid_year
    - name: "Award Number"
      expr: award_number
    - name: "Award Status"
      expr: award_status
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enrollment Status Requirement"
      expr: enrollment_status_requirement
    - name: "Federal Fund Code"
      expr: federal_fund_code
    - name: "First Disbursement Date"
      expr: first_disbursement_date
    - name: "Last Disbursement Date"
      expr: last_disbursement_date
    - name: "Loan Period Begin Date"
      expr: loan_period_begin_date
    - name: "Loan Period End Date"
      expr: loan_period_end_date
    - name: "Need Based Flag"
      expr: need_based_flag
    - name: "Offer Date"
      expr: offer_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aid Award"
      expr: COUNT(DISTINCT aid_award_id)
    - name: "Total Accepted Amount"
      expr: SUM(accepted_amount)
    - name: "Average Accepted Amount"
      expr: AVG(accepted_amount)
    - name: "Total Cancelled Amount"
      expr: SUM(cancelled_amount)
    - name: "Average Cancelled Amount"
      expr: AVG(cancelled_amount)
    - name: "Total Disbursed Amount"
      expr: SUM(disbursed_amount)
    - name: "Average Disbursed Amount"
      expr: AVG(disbursed_amount)
    - name: "Total Efc Amount"
      expr: SUM(efc_amount)
    - name: "Average Efc Amount"
      expr: AVG(efc_amount)
    - name: "Total Interest Rate"
      expr: SUM(interest_rate)
    - name: "Average Interest Rate"
      expr: AVG(interest_rate)
    - name: "Total Offered Amount"
      expr: SUM(offered_amount)
    - name: "Average Offered Amount"
      expr: AVG(offered_amount)
    - name: "Total Origination Fee Amount"
      expr: SUM(origination_fee_amount)
    - name: "Average Origination Fee Amount"
      expr: AVG(origination_fee_amount)
    - name: "Total Remaining Amount"
      expr: SUM(remaining_amount)
    - name: "Average Remaining Amount"
      expr: AVG(remaining_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_aid_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aid Fund business metrics"
  source: "`education_ecm`.`aid`.`aid_fund`"
  dimensions:
    - name: "Academic Level Requirement"
      expr: academic_level_requirement
    - name: "Award Year"
      expr: award_year
    - name: "Cfda Number"
      expr: cfda_number
    - name: "Citizenship Requirement"
      expr: citizenship_requirement
    - name: "Coa Component Restriction"
      expr: coa_component_restriction
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disbursement Frequency"
      expr: disbursement_frequency
    - name: "Disbursement Method"
      expr: disbursement_method
    - name: "Donor Name"
      expr: donor_name
    - name: "Donor Restrictions"
      expr: donor_restrictions
    - name: "Effective Date"
      expr: effective_date
    - name: "Endowed Flag"
      expr: endowed_flag
    - name: "Enrollment Status Requirement"
      expr: enrollment_status_requirement
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fund Category"
      expr: fund_category
    - name: "Fund Code"
      expr: fund_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aid Fund"
      expr: COUNT(DISTINCT aid_fund_id)
    - name: "Total Annual Allocation Amount"
      expr: SUM(annual_allocation_amount)
    - name: "Average Annual Allocation Amount"
      expr: AVG(annual_allocation_amount)
    - name: "Total Gpa Requirement"
      expr: SUM(gpa_requirement)
    - name: "Average Gpa Requirement"
      expr: AVG(gpa_requirement)
    - name: "Total Matching Percentage"
      expr: SUM(matching_percentage)
    - name: "Average Matching Percentage"
      expr: AVG(matching_percentage)
    - name: "Total Maximum Award Amount"
      expr: SUM(maximum_award_amount)
    - name: "Average Maximum Award Amount"
      expr: AVG(maximum_award_amount)
    - name: "Total Minimum Award Amount"
      expr: SUM(minimum_award_amount)
    - name: "Average Minimum Award Amount"
      expr: AVG(minimum_award_amount)
    - name: "Total Payout Rate"
      expr: SUM(payout_rate)
    - name: "Average Payout Rate"
      expr: AVG(payout_rate)
    - name: "Total Remaining Balance Amount"
      expr: SUM(remaining_balance_amount)
    - name: "Average Remaining Balance Amount"
      expr: AVG(remaining_balance_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_aid_sap_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aid Sap Evaluation business metrics"
  source: "`education_ecm`.`aid`.`aid_sap_evaluation`"
  dimensions:
    - name: "Academic Plan Conditions"
      expr: academic_plan_conditions
    - name: "Academic Plan End Term"
      expr: academic_plan_end_term
    - name: "Academic Plan Required Flag"
      expr: academic_plan_required_flag
    - name: "Academic Plan Start Term"
      expr: academic_plan_start_term
    - name: "Appeal Date"
      expr: appeal_date
    - name: "Appeal Decision"
      expr: appeal_decision
    - name: "Appeal Decision Date"
      expr: appeal_decision_date
    - name: "Appeal Reason"
      expr: appeal_reason
    - name: "Appeal Reviewer Name"
      expr: appeal_reviewer_name
    - name: "Appeal Submitted Flag"
      expr: appeal_submitted_flag
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evaluation Date"
      expr: evaluation_date
    - name: "Evaluation Type"
      expr: evaluation_type
    - name: "Financial Aid Eligibility Status"
      expr: financial_aid_eligibility_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aid Sap Evaluation"
      expr: COUNT(DISTINCT aid_sap_evaluation_id)
    - name: "Total Completion Rate Percentage"
      expr: SUM(completion_rate_percentage)
    - name: "Average Completion Rate Percentage"
      expr: AVG(completion_rate_percentage)
    - name: "Total Cumulative Credits Attempted"
      expr: SUM(cumulative_credits_attempted)
    - name: "Average Cumulative Credits Attempted"
      expr: AVG(cumulative_credits_attempted)
    - name: "Total Cumulative Credits Earned"
      expr: SUM(cumulative_credits_earned)
    - name: "Average Cumulative Credits Earned"
      expr: AVG(cumulative_credits_earned)
    - name: "Total Cumulative Gpa"
      expr: SUM(cumulative_gpa)
    - name: "Average Cumulative Gpa"
      expr: AVG(cumulative_gpa)
    - name: "Total Maximum Credits Allowed"
      expr: SUM(maximum_credits_allowed)
    - name: "Average Maximum Credits Allowed"
      expr: AVG(maximum_credits_allowed)
    - name: "Total Minimum Completion Rate Required"
      expr: SUM(minimum_completion_rate_required)
    - name: "Average Minimum Completion Rate Required"
      expr: AVG(minimum_completion_rate_required)
    - name: "Total Minimum Gpa Required"
      expr: SUM(minimum_gpa_required)
    - name: "Average Minimum Gpa Required"
      expr: AVG(minimum_gpa_required)
    - name: "Total Program Published Length"
      expr: SUM(program_published_length)
    - name: "Average Program Published Length"
      expr: AVG(program_published_length)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_award_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award Package business metrics"
  source: "`education_ecm`.`aid`.`award_package`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Default Status Flag"
      expr: default_status_flag
    - name: "Dependency Status"
      expr: dependency_status
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Housing Status"
      expr: housing_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Revision Date"
      expr: last_revision_date
    - name: "Notes"
      expr: notes
    - name: "Offer Letter Sent Date"
      expr: offer_letter_sent_date
    - name: "Overaward Detected Flag"
      expr: overaward_detected_flag
    - name: "Overaward Resolution Date"
      expr: overaward_resolution_date
    - name: "Overaward Resolution Status"
      expr: overaward_resolution_status
    - name: "Package Number"
      expr: package_number
    - name: "Package Status"
      expr: package_status
    - name: "Packaging Date"
      expr: packaging_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Award Package"
      expr: COUNT(DISTINCT award_package_id)
    - name: "Total Demonstrated Need Amount"
      expr: SUM(demonstrated_need_amount)
    - name: "Average Demonstrated Need Amount"
      expr: AVG(demonstrated_need_amount)
    - name: "Total Efc Amount"
      expr: SUM(efc_amount)
    - name: "Average Efc Amount"
      expr: AVG(efc_amount)
    - name: "Total Overaward Amount"
      expr: SUM(overaward_amount)
    - name: "Average Overaward Amount"
      expr: AVG(overaward_amount)
    - name: "Total Pell Lifetime Eligibility Used Percent"
      expr: SUM(pell_lifetime_eligibility_used_percent)
    - name: "Average Pell Lifetime Eligibility Used Percent"
      expr: AVG(pell_lifetime_eligibility_used_percent)
    - name: "Total Total Awarded Amount"
      expr: SUM(total_awarded_amount)
    - name: "Average Total Awarded Amount"
      expr: AVG(total_awarded_amount)
    - name: "Total Total Coa Amount"
      expr: SUM(total_coa_amount)
    - name: "Average Total Coa Amount"
      expr: AVG(total_coa_amount)
    - name: "Total Total Grant Amount"
      expr: SUM(total_grant_amount)
    - name: "Average Total Grant Amount"
      expr: AVG(total_grant_amount)
    - name: "Total Total Loan Amount"
      expr: SUM(total_loan_amount)
    - name: "Average Total Loan Amount"
      expr: AVG(total_loan_amount)
    - name: "Total Total Scholarship Amount"
      expr: SUM(total_scholarship_amount)
    - name: "Average Total Scholarship Amount"
      expr: AVG(total_scholarship_amount)
    - name: "Total Total Work Study Amount"
      expr: SUM(total_work_study_amount)
    - name: "Average Total Work Study Amount"
      expr: AVG(total_work_study_amount)
    - name: "Total Unmet Need Amount"
      expr: SUM(unmet_need_amount)
    - name: "Average Unmet Need Amount"
      expr: AVG(unmet_need_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_award_year`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award Year business metrics"
  source: "`education_ecm`.`aid`.`award_year`"
  dimensions:
    - name: "Academic Year End Date"
      expr: academic_year_end_date
    - name: "Academic Year Start Date"
      expr: academic_year_start_date
    - name: "Application Deadline Date"
      expr: application_deadline_date
    - name: "Application Open Date"
      expr: application_open_date
    - name: "Code"
      expr: award_year_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: award_year_description
    - name: "Disbursement End Date"
      expr: disbursement_end_date
    - name: "Disbursement Start Date"
      expr: disbursement_start_date
    - name: "End Date"
      expr: end_date
    - name: "Enrollment End Date"
      expr: enrollment_end_date
    - name: "Enrollment Start Date"
      expr: enrollment_start_date
    - name: "Fafsa Cycle Code"
      expr: fafsa_cycle_code
    - name: "Federal Award Year Code"
      expr: federal_award_year_code
    - name: "Is Current Year"
      expr: is_current_year
    - name: "Is Default Year"
      expr: is_default_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Award Year"
      expr: COUNT(DISTINCT award_year_id)
    - name: "Total Default Cost Of Attendance Amount"
      expr: SUM(default_cost_of_attendance_amount)
    - name: "Average Default Cost Of Attendance Amount"
      expr: AVG(default_cost_of_attendance_amount)
    - name: "Total Direct Subsidized Loan Annual Limit"
      expr: SUM(direct_subsidized_loan_annual_limit)
    - name: "Average Direct Subsidized Loan Annual Limit"
      expr: AVG(direct_subsidized_loan_annual_limit)
    - name: "Total Direct Unsubsidized Loan Annual Limit"
      expr: SUM(direct_unsubsidized_loan_annual_limit)
    - name: "Average Direct Unsubsidized Loan Annual Limit"
      expr: AVG(direct_unsubsidized_loan_annual_limit)
    - name: "Total Federal Pell Maximum Amount"
      expr: SUM(federal_pell_maximum_amount)
    - name: "Average Federal Pell Maximum Amount"
      expr: AVG(federal_pell_maximum_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_borrower`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Borrower business metrics"
  source: "`education_ecm`.`aid`.`borrower`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Adverse Credit Flag"
      expr: adverse_credit_flag
    - name: "Alternate Phone Number"
      expr: alternate_phone_number
    - name: "Borrower Status"
      expr: borrower_status
    - name: "Borrower Type"
      expr: borrower_type
    - name: "Citizenship Status"
      expr: citizenship_status
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Authorization Flag"
      expr: credit_authorization_flag
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Default Flag"
      expr: default_flag
    - name: "Dependency Status"
      expr: dependency_status
    - name: "Email Address"
      expr: email_address
    - name: "Entrance Counseling Date"
      expr: entrance_counseling_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Borrower"
      expr: COUNT(DISTINCT borrower_id)
    - name: "Total Aggregate Loan Limit"
      expr: SUM(aggregate_loan_limit)
    - name: "Average Aggregate Loan Limit"
      expr: AVG(aggregate_loan_limit)
    - name: "Total Outstanding Principal Balance"
      expr: SUM(outstanding_principal_balance)
    - name: "Average Outstanding Principal Balance"
      expr: AVG(outstanding_principal_balance)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_coa_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coa Budget business metrics"
  source: "`education_ecm`.`aid`.`coa_budget`"
  dimensions:
    - name: "Academic Level"
      expr: academic_level
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Budget Code"
      expr: budget_code
    - name: "Budget Description"
      expr: budget_description
    - name: "Budget Name"
      expr: budget_name
    - name: "Budget Status"
      expr: budget_status
    - name: "Budget Version"
      expr: budget_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Hour Maximum"
      expr: credit_hour_maximum
    - name: "Credit Hour Minimum"
      expr: credit_hour_minimum
    - name: "Dependency Status"
      expr: dependency_status
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Federal Methodology Flag"
      expr: federal_methodology_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coa Budget"
      expr: COUNT(DISTINCT coa_budget_id)
    - name: "Total Books Supplies Amount"
      expr: SUM(books_supplies_amount)
    - name: "Average Books Supplies Amount"
      expr: AVG(books_supplies_amount)
    - name: "Total Dependent Care Amount"
      expr: SUM(dependent_care_amount)
    - name: "Average Dependent Care Amount"
      expr: AVG(dependent_care_amount)
    - name: "Total Disability Expenses Amount"
      expr: SUM(disability_expenses_amount)
    - name: "Average Disability Expenses Amount"
      expr: AVG(disability_expenses_amount)
    - name: "Total Loan Fees Amount"
      expr: SUM(loan_fees_amount)
    - name: "Average Loan Fees Amount"
      expr: AVG(loan_fees_amount)
    - name: "Total Personal Expenses Amount"
      expr: SUM(personal_expenses_amount)
    - name: "Average Personal Expenses Amount"
      expr: AVG(personal_expenses_amount)
    - name: "Total Professional Licensure Amount"
      expr: SUM(professional_licensure_amount)
    - name: "Average Professional Licensure Amount"
      expr: AVG(professional_licensure_amount)
    - name: "Total Room Board Amount"
      expr: SUM(room_board_amount)
    - name: "Average Room Board Amount"
      expr: AVG(room_board_amount)
    - name: "Total Study Abroad Amount"
      expr: SUM(study_abroad_amount)
    - name: "Average Study Abroad Amount"
      expr: AVG(study_abroad_amount)
    - name: "Total Total Coa Amount"
      expr: SUM(total_coa_amount)
    - name: "Average Total Coa Amount"
      expr: AVG(total_coa_amount)
    - name: "Total Transportation Amount"
      expr: SUM(transportation_amount)
    - name: "Average Transportation Amount"
      expr: AVG(transportation_amount)
    - name: "Total Tuition Fees Amount"
      expr: SUM(tuition_fees_amount)
    - name: "Average Tuition Fees Amount"
      expr: AVG(tuition_fees_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disbursement business metrics"
  source: "`education_ecm`.`aid`.`disbursement`"
  dimensions:
    - name: "Anticipated Disbursement Flag"
      expr: anticipated_disbursement_flag
    - name: "Authorization Date"
      expr: authorization_date
    - name: "Bank Account Last Four"
      expr: bank_account_last_four
    - name: "Channel"
      expr: channel
    - name: "Cod Reporting Date"
      expr: cod_reporting_date
    - name: "Cod Reporting Flag"
      expr: cod_reporting_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Disbursement Date"
      expr: disbursement_date
    - name: "Disbursement Method"
      expr: disbursement_method
    - name: "Disbursement Number"
      expr: disbursement_number
    - name: "Disbursement Status"
      expr: disbursement_status
    - name: "Enrollment Status At Disbursement"
      expr: enrollment_status_at_disbursement
    - name: "Hold Flag"
      expr: hold_flag
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Hold Release Date"
      expr: hold_release_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Disbursement"
      expr: COUNT(DISTINCT disbursement_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Coa Amount"
      expr: SUM(coa_amount)
    - name: "Average Coa Amount"
      expr: AVG(coa_amount)
    - name: "Total Efc Amount"
      expr: SUM(efc_amount)
    - name: "Average Efc Amount"
      expr: AVG(efc_amount)
    - name: "Total Net Disbursement Amount"
      expr: SUM(net_disbursement_amount)
    - name: "Average Net Disbursement Amount"
      expr: AVG(net_disbursement_amount)
    - name: "Total Origination Fee Amount"
      expr: SUM(origination_fee_amount)
    - name: "Average Origination Fee Amount"
      expr: AVG(origination_fee_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_fund_fee_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund Fee Coverage business metrics"
  source: "`education_ecm`.`aid`.`fund_fee_coverage`"
  dimensions:
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Created Date"
      expr: created_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Modified Date"
      expr: modified_date
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fund Fee Coverage"
      expr: COUNT(DISTINCT fund_fee_coverage_id)
    - name: "Total Coverage Percentage"
      expr: SUM(coverage_percentage)
    - name: "Average Coverage Percentage"
      expr: AVG(coverage_percentage)
    - name: "Total Maximum Coverage Amount"
      expr: SUM(maximum_coverage_amount)
    - name: "Average Maximum Coverage Amount"
      expr: AVG(maximum_coverage_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_isir_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Isir Record business metrics"
  source: "`education_ecm`.`aid`.`isir_record`"
  dimensions:
    - name: "Automatic Zero Efc Flag"
      expr: automatic_zero_efc_flag
    - name: "Award Year"
      expr: award_year
    - name: "Citizenship Status"
      expr: citizenship_status
    - name: "Comment Codes"
      expr: comment_codes
    - name: "Correction Flag"
      expr: correction_flag
    - name: "Cps Version"
      expr: cps_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Dependency Status"
      expr: dependency_status
    - name: "Efc"
      expr: efc
    - name: "Fafsa Signature Date"
      expr: fafsa_signature_date
    - name: "Household Size"
      expr: household_size
    - name: "Isir Source"
      expr: isir_source
    - name: "Marital Status"
      expr: marital_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Number In College"
      expr: number_in_college
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Isir Record"
      expr: COUNT(DISTINCT isir_record_id)
    - name: "Total Parent Agi"
      expr: SUM(parent_agi)
    - name: "Average Parent Agi"
      expr: AVG(parent_agi)
    - name: "Total Parent Cash Savings"
      expr: SUM(parent_cash_savings)
    - name: "Average Parent Cash Savings"
      expr: AVG(parent_cash_savings)
    - name: "Total Parent Income Tax Paid"
      expr: SUM(parent_income_tax_paid)
    - name: "Average Parent Income Tax Paid"
      expr: AVG(parent_income_tax_paid)
    - name: "Total Parent Investment Net Worth"
      expr: SUM(parent_investment_net_worth)
    - name: "Average Parent Investment Net Worth"
      expr: AVG(parent_investment_net_worth)
    - name: "Total Parent Untaxed Income"
      expr: SUM(parent_untaxed_income)
    - name: "Average Parent Untaxed Income"
      expr: AVG(parent_untaxed_income)
    - name: "Total Student Agi"
      expr: SUM(student_agi)
    - name: "Average Student Agi"
      expr: AVG(student_agi)
    - name: "Total Student Cash Savings"
      expr: SUM(student_cash_savings)
    - name: "Average Student Cash Savings"
      expr: AVG(student_cash_savings)
    - name: "Total Student Income Tax Paid"
      expr: SUM(student_income_tax_paid)
    - name: "Average Student Income Tax Paid"
      expr: AVG(student_income_tax_paid)
    - name: "Total Student Investment Net Worth"
      expr: SUM(student_investment_net_worth)
    - name: "Average Student Investment Net Worth"
      expr: AVG(student_investment_net_worth)
    - name: "Total Student Untaxed Income"
      expr: SUM(student_untaxed_income)
    - name: "Average Student Untaxed Income"
      expr: AVG(student_untaxed_income)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_lender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lender business metrics"
  source: "`education_ecm`.`aid`.`lender`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Contact Person Email"
      expr: contact_person_email
    - name: "Contact Person Name"
      expr: contact_person_name
    - name: "Contact Person Phone"
      expr: contact_person_phone
    - name: "Contact Person Title"
      expr: contact_person_title
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duns Number"
      expr: duns_number
    - name: "Email Address"
      expr: email_address
    - name: "Fax Number"
      expr: fax_number
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Lender Code"
      expr: lender_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lender"
      expr: COUNT(DISTINCT lender_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_loan_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loan Record business metrics"
  source: "`education_ecm`.`aid`.`loan_record`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Anticipated Disbursement Date"
      expr: anticipated_disbursement_date
    - name: "Award Year"
      expr: award_year
    - name: "Borrower Type"
      expr: borrower_type
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Cod Accepted Date"
      expr: cod_accepted_date
    - name: "Cod Transaction Number"
      expr: cod_transaction_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Check Passed Indicator"
      expr: credit_check_passed_indicator
    - name: "Dependency Status"
      expr: dependency_status
    - name: "Disbursement Date"
      expr: disbursement_date
    - name: "Disbursement Number"
      expr: disbursement_number
    - name: "Endorser Required Indicator"
      expr: endorser_required_indicator
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Entrance Counseling Completed Date"
      expr: entrance_counseling_completed_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loan Record"
      expr: COUNT(DISTINCT loan_record_id)
    - name: "Total Aggregate Loan Balance"
      expr: SUM(aggregate_loan_balance)
    - name: "Average Aggregate Loan Balance"
      expr: AVG(aggregate_loan_balance)
    - name: "Total Aggregate Loan Limit"
      expr: SUM(aggregate_loan_limit)
    - name: "Average Aggregate Loan Limit"
      expr: AVG(aggregate_loan_limit)
    - name: "Total Coa Amount"
      expr: SUM(coa_amount)
    - name: "Average Coa Amount"
      expr: AVG(coa_amount)
    - name: "Total Efc Amount"
      expr: SUM(efc_amount)
    - name: "Average Efc Amount"
      expr: AVG(efc_amount)
    - name: "Total Financial Need Amount"
      expr: SUM(financial_need_amount)
    - name: "Average Financial Need Amount"
      expr: AVG(financial_need_amount)
    - name: "Total Gross Loan Amount"
      expr: SUM(gross_loan_amount)
    - name: "Average Gross Loan Amount"
      expr: AVG(gross_loan_amount)
    - name: "Total Interest Rate"
      expr: SUM(interest_rate)
    - name: "Average Interest Rate"
      expr: AVG(interest_rate)
    - name: "Total Net Loan Amount"
      expr: SUM(net_loan_amount)
    - name: "Average Net Loan Amount"
      expr: AVG(net_loan_amount)
    - name: "Total Origination Fee Amount"
      expr: SUM(origination_fee_amount)
    - name: "Average Origination Fee Amount"
      expr: AVG(origination_fee_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_master_promissory_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master Promissory Note business metrics"
  source: "`education_ecm`.`aid`.`master_promissory_note`"
  dimensions:
    - name: "Borrower Address Line1"
      expr: borrower_address_line1
    - name: "Borrower Address Line2"
      expr: borrower_address_line2
    - name: "Borrower City"
      expr: borrower_city
    - name: "Borrower Country"
      expr: borrower_country
    - name: "Borrower Date Of Birth"
      expr: borrower_date_of_birth
    - name: "Borrower Email"
      expr: borrower_email
    - name: "Borrower Name"
      expr: borrower_name
    - name: "Borrower Phone"
      expr: borrower_phone
    - name: "Borrower Postal Code"
      expr: borrower_postal_code
    - name: "Borrower Ssn"
      expr: borrower_ssn
    - name: "Borrower State"
      expr: borrower_state
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Counseling Completed Date"
      expr: counseling_completed_date
    - name: "Counseling Completed Flag"
      expr: counseling_completed_flag
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Master Promissory Note"
      expr: COUNT(DISTINCT master_promissory_note_id)
    - name: "Total Interest Rate Percent"
      expr: SUM(interest_rate_percent)
    - name: "Average Interest Rate Percent"
      expr: AVG(interest_rate_percent)
    - name: "Total Max Loan Amount"
      expr: SUM(max_loan_amount)
    - name: "Average Max Loan Amount"
      expr: AVG(max_loan_amount)
    - name: "Total Origination Fee Percent"
      expr: SUM(origination_fee_percent)
    - name: "Average Origination Fee Percent"
      expr: AVG(origination_fee_percent)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_professional_judgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional Judgment business metrics"
  source: "`education_ecm`.`aid`.`professional_judgment`"
  dimensions:
    - name: "Adjusted Dependency Status"
      expr: adjusted_dependency_status
    - name: "Adjustment Category"
      expr: adjustment_category
    - name: "Appeal Deadline Date"
      expr: appeal_deadline_date
    - name: "Appeal Eligible"
      expr: appeal_eligible
    - name: "Approving Administrator Name"
      expr: approving_administrator_name
    - name: "Approving Administrator Title"
      expr: approving_administrator_title
    - name: "Audit Flag"
      expr: audit_flag
    - name: "Audit Notes"
      expr: audit_notes
    - name: "Corrected Isir Transaction Number"
      expr: corrected_isir_transaction_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Date"
      expr: decision_date
    - name: "Decision Status"
      expr: decision_status
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Documentation Received Date"
      expr: documentation_received_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Professional Judgment"
      expr: COUNT(DISTINCT professional_judgment_id)
    - name: "Total Adjusted Coa"
      expr: SUM(adjusted_coa)
    - name: "Average Adjusted Coa"
      expr: AVG(adjusted_coa)
    - name: "Total Adjusted Efc"
      expr: SUM(adjusted_efc)
    - name: "Average Adjusted Efc"
      expr: AVG(adjusted_efc)
    - name: "Total Adjusted Value"
      expr: SUM(adjusted_value)
    - name: "Average Adjusted Value"
      expr: AVG(adjusted_value)
    - name: "Total Original Coa"
      expr: SUM(original_coa)
    - name: "Average Original Coa"
      expr: AVG(original_coa)
    - name: "Total Original Efc"
      expr: SUM(original_efc)
    - name: "Average Original Efc"
      expr: AVG(original_efc)
    - name: "Total Original Value"
      expr: SUM(original_value)
    - name: "Average Original Value"
      expr: AVG(original_value)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_r2t4_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R2t4 Calculation business metrics"
  source: "`education_ecm`.`aid`.`r2t4_calculation`"
  dimensions:
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Calculation Number"
      expr: calculation_number
    - name: "Calculation Status"
      expr: calculation_status
    - name: "Calculation Timestamp"
      expr: calculation_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Completed"
      expr: days_completed
    - name: "Determination Date"
      expr: determination_date
    - name: "Last Date Of Attendance"
      expr: last_date_of_attendance
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Period Days"
      expr: payment_period_days
    - name: "Payment Period End Date"
      expr: payment_period_end_date
    - name: "Payment Period Start Date"
      expr: payment_period_start_date
    - name: "Recalculation Flag"
      expr: recalculation_flag
    - name: "Return Completed Date"
      expr: return_completed_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct R2t4 Calculation"
      expr: COUNT(DISTINCT r2t4_calculation_id)
    - name: "Total Grant Protection Amount"
      expr: SUM(grant_protection_amount)
    - name: "Average Grant Protection Amount"
      expr: AVG(grant_protection_amount)
    - name: "Total Institutional Charges"
      expr: SUM(institutional_charges)
    - name: "Average Institutional Charges"
      expr: AVG(institutional_charges)
    - name: "Total Institutional Return Amount"
      expr: SUM(institutional_return_amount)
    - name: "Average Institutional Return Amount"
      expr: AVG(institutional_return_amount)
    - name: "Total Percentage Completed"
      expr: SUM(percentage_completed)
    - name: "Average Percentage Completed"
      expr: AVG(percentage_completed)
    - name: "Total Post Withdrawal Disbursement Amount"
      expr: SUM(post_withdrawal_disbursement_amount)
    - name: "Average Post Withdrawal Disbursement Amount"
      expr: AVG(post_withdrawal_disbursement_amount)
    - name: "Total Student Return Amount"
      expr: SUM(student_return_amount)
    - name: "Average Student Return Amount"
      expr: AVG(student_return_amount)
    - name: "Total Total Title Iv Aid Disbursed"
      expr: SUM(total_title_iv_aid_disbursed)
    - name: "Average Total Title Iv Aid Disbursed"
      expr: AVG(total_title_iv_aid_disbursed)
    - name: "Total Total Title Iv Aid Earned"
      expr: SUM(total_title_iv_aid_earned)
    - name: "Average Total Title Iv Aid Earned"
      expr: AVG(total_title_iv_aid_earned)
    - name: "Total Total Title Iv Aid Unearned"
      expr: SUM(total_title_iv_aid_unearned)
    - name: "Average Total Title Iv Aid Unearned"
      expr: AVG(total_title_iv_aid_unearned)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_scholarship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scholarship business metrics"
  source: "`education_ecm`.`aid`.`scholarship`"
  dimensions:
    - name: "Academic Level"
      expr: academic_level
    - name: "Application Deadline"
      expr: application_deadline
    - name: "Application Required Flag"
      expr: application_required_flag
    - name: "Award Notification Date"
      expr: award_notification_date
    - name: "Class Standing"
      expr: class_standing
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Coordination Rule"
      expr: coordination_rule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Donor Organization Name"
      expr: donor_organization_name
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Endowment Flag"
      expr: endowment_flag
    - name: "Funding Source"
      expr: funding_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Scholarship"
      expr: COUNT(DISTINCT scholarship_id)
    - name: "Total Maximum Award Amount"
      expr: SUM(maximum_award_amount)
    - name: "Average Maximum Award Amount"
      expr: AVG(maximum_award_amount)
    - name: "Total Minimum Award Amount"
      expr: SUM(minimum_award_amount)
    - name: "Average Minimum Award Amount"
      expr: AVG(minimum_award_amount)
    - name: "Total Minimum Gpa"
      expr: SUM(minimum_gpa)
    - name: "Average Minimum Gpa"
      expr: AVG(minimum_gpa)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification business metrics"
  source: "`education_ecm`.`aid`.`verification`"
  dimensions:
    - name: "Aid Year"
      expr: aid_year
    - name: "Child Support Paid Verification Date"
      expr: child_support_paid_verification_date
    - name: "Comments"
      expr: comments
    - name: "Completion Date"
      expr: completion_date
    - name: "Conflicting Information Description"
      expr: conflicting_information_description
    - name: "Conflicting Information Indicator"
      expr: conflicting_information_indicator
    - name: "Correction Required Indicator"
      expr: correction_required_indicator
    - name: "Correction Submitted Date"
      expr: correction_submitted_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dependency Override Date"
      expr: dependency_override_date
    - name: "Dependency Override Indicator"
      expr: dependency_override_indicator
    - name: "Dependency Override Reason"
      expr: dependency_override_reason
    - name: "Exclusion Reason"
      expr: exclusion_reason
    - name: "High School Completion Verification Date"
      expr: high_school_completion_verification_date
    - name: "Household Size Verification Date"
      expr: household_size_verification_date
    - name: "Identity Verification Received Date"
      expr: identity_verification_received_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Verification"
      expr: COUNT(DISTINCT verification_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_veteran_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Veteran Benefit business metrics"
  source: "`education_ecm`.`aid`.`veteran_benefit`"
  dimensions:
    - name: "Benefit Chapter"
      expr: benefit_chapter
    - name: "Benefit Status"
      expr: benefit_status
    - name: "Certificate Of Eligibility Number"
      expr: certificate_of_eligibility_number
    - name: "Certification Date"
      expr: certification_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delimiting Date"
      expr: delimiting_date
    - name: "Eligibility Begin Date"
      expr: eligibility_begin_date
    - name: "Eligibility End Date"
      expr: eligibility_end_date
    - name: "Kicker Eligible Flag"
      expr: kicker_eligible_flag
    - name: "Last Certification Change Date"
      expr: last_certification_change_date
    - name: "Last Certification Change Reason"
      expr: last_certification_change_reason
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Payment Date"
      expr: last_payment_date
    - name: "Payment Status"
      expr: payment_status
    - name: "Sco Remarks"
      expr: sco_remarks
    - name: "Training Time"
      expr: training_time
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Veteran Benefit"
      expr: COUNT(DISTINCT veteran_benefit_id)
    - name: "Total Benefit Percentage"
      expr: SUM(benefit_percentage)
    - name: "Average Benefit Percentage"
      expr: AVG(benefit_percentage)
    - name: "Total Book Stipend Amount"
      expr: SUM(book_stipend_amount)
    - name: "Average Book Stipend Amount"
      expr: AVG(book_stipend_amount)
    - name: "Total Certified Credit Hours"
      expr: SUM(certified_credit_hours)
    - name: "Average Certified Credit Hours"
      expr: AVG(certified_credit_hours)
    - name: "Total Kicker Monthly Amount"
      expr: SUM(kicker_monthly_amount)
    - name: "Average Kicker Monthly Amount"
      expr: AVG(kicker_monthly_amount)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
    - name: "Total Monthly Housing Allowance Amount"
      expr: SUM(monthly_housing_allowance_amount)
    - name: "Average Monthly Housing Allowance Amount"
      expr: AVG(monthly_housing_allowance_amount)
    - name: "Total Remaining Entitlement Months"
      expr: SUM(remaining_entitlement_months)
    - name: "Average Remaining Entitlement Months"
      expr: AVG(remaining_entitlement_months)
    - name: "Total Tuition And Fees Paid To School"
      expr: SUM(tuition_and_fees_paid_to_school)
    - name: "Average Tuition And Fees Paid To School"
      expr: AVG(tuition_and_fees_paid_to_school)
    - name: "Total Yellow Ribbon Institution Contribution"
      expr: SUM(yellow_ribbon_institution_contribution)
    - name: "Average Yellow Ribbon Institution Contribution"
      expr: AVG(yellow_ribbon_institution_contribution)
    - name: "Total Yellow Ribbon Va Contribution"
      expr: SUM(yellow_ribbon_va_contribution)
    - name: "Average Yellow Ribbon Va Contribution"
      expr: AVG(yellow_ribbon_va_contribution)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_workstudy_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workstudy Assignment business metrics"
  source: "`education_ecm`.`aid`.`workstudy_assignment`"
  dimensions:
    - name: "Actual Termination Date"
      expr: actual_termination_date
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Community Service Flag"
      expr: community_service_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Employment Type"
      expr: employment_type
    - name: "Funding Source"
      expr: funding_source
    - name: "I9 Verification Date"
      expr: i9_verification_date
    - name: "I9 Verification Status"
      expr: i9_verification_status
    - name: "Job Description"
      expr: job_description
    - name: "Last Updated By"
      expr: last_updated_by
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Orientation Completed Flag"
      expr: orientation_completed_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Workstudy Assignment"
      expr: COUNT(DISTINCT workstudy_assignment_id)
    - name: "Total Authorized Hours Per Week"
      expr: SUM(authorized_hours_per_week)
    - name: "Average Authorized Hours Per Week"
      expr: AVG(authorized_hours_per_week)
    - name: "Total Cumulative Earnings To Date"
      expr: SUM(cumulative_earnings_to_date)
    - name: "Average Cumulative Earnings To Date"
      expr: AVG(cumulative_earnings_to_date)
    - name: "Total Federal Share Percentage"
      expr: SUM(federal_share_percentage)
    - name: "Average Federal Share Percentage"
      expr: AVG(federal_share_percentage)
    - name: "Total Hourly Rate"
      expr: SUM(hourly_rate)
    - name: "Average Hourly Rate"
      expr: AVG(hourly_rate)
    - name: "Total Institutional Share Percentage"
      expr: SUM(institutional_share_percentage)
    - name: "Average Institutional Share Percentage"
      expr: AVG(institutional_share_percentage)
    - name: "Total Remaining Balance"
      expr: SUM(remaining_balance)
    - name: "Average Remaining Balance"
      expr: AVG(remaining_balance)
    - name: "Total Total Award Amount"
      expr: SUM(total_award_amount)
    - name: "Average Total Award Amount"
      expr: AVG(total_award_amount)
$$;
