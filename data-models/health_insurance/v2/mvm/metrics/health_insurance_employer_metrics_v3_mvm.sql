-- Metric views for domain: employer | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:43:30

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`broker`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Agreement End Date"
      expr: agreement_end_date
    - name: "Agreement Start Date"
      expr: agreement_start_date
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Terms"
      expr: agreement_terms
    - name: "Broker Status"
      expr: broker_status
    - name: "Broker Type"
      expr: broker_type
    - name: "City"
      expr: city
    - name: "Commission Currency"
      expr: commission_currency
    - name: "Commission End Date"
      expr: commission_end_date
    - name: "Commission Start Date"
      expr: commission_start_date
    - name: "Country"
      expr: country
    - name: "Email"
      expr: email
    - name: "End Date"
      expr: end_date
    - name: "Fax"
      expr: fax
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broker"
      expr: COUNT(DISTINCT broker_id)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Rating"
      expr: SUM(rating)
    - name: "Average Rating"
      expr: AVG(rating)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker Assignment business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`broker_assignment`"
  dimensions:
    - name: "Agency Name"
      expr: agency_name
    - name: "Broker Assignment Status"
      expr: broker_assignment_status
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Commission Type"
      expr: commission_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Primary"
      expr: is_primary
    - name: "Notes"
      expr: notes
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broker Assignment"
      expr: COUNT(DISTINCT broker_assignment_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_contribution_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contribution Strategy business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`contribution_strategy`"
  dimensions:
    - name: "Affordability Test Flag"
      expr: affordability_test_flag
    - name: "Contribution Code"
      expr: contribution_code
    - name: "Contribution Frequency"
      expr: contribution_frequency
    - name: "Contribution Rule Name"
      expr: contribution_rule_name
    - name: "Contribution Strategy Status"
      expr: contribution_strategy_status
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Is Post Tax"
      expr: is_post_tax
    - name: "Is Pre Tax"
      expr: is_pre_tax
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Notes"
      expr: notes
    - name: "Review Status"
      expr: review_status
    - name: "Tax Credit Eligible"
      expr: tax_credit_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contribution Strategy"
      expr: COUNT(DISTINCT contribution_strategy_id)
    - name: "Total Contribution Amount"
      expr: SUM(contribution_amount)
    - name: "Average Contribution Amount"
      expr: AVG(contribution_amount)
    - name: "Total Contribution Percentage"
      expr: SUM(contribution_percentage)
    - name: "Average Contribution Percentage"
      expr: AVG(contribution_percentage)
    - name: "Total Employer Contribution Cap"
      expr: SUM(employer_contribution_cap)
    - name: "Average Employer Contribution Cap"
      expr: AVG(employer_contribution_cap)
    - name: "Total Hra Employer Seed Amount"
      expr: SUM(hra_employer_seed_amount)
    - name: "Average Hra Employer Seed Amount"
      expr: AVG(hra_employer_seed_amount)
    - name: "Total Hsa Employer Seed Amount"
      expr: SUM(hsa_employer_seed_amount)
    - name: "Average Hsa Employer Seed Amount"
      expr: AVG(hsa_employer_seed_amount)
    - name: "Total Maximum Employee Contribution"
      expr: SUM(maximum_employee_contribution)
    - name: "Average Maximum Employee Contribution"
      expr: AVG(maximum_employee_contribution)
    - name: "Total Minimum Employee Contribution"
      expr: SUM(minimum_employee_contribution)
    - name: "Average Minimum Employee Contribution"
      expr: AVG(minimum_employee_contribution)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`group`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Contribution Strategy"
      expr: contribution_strategy
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dba Name"
      expr: dba_name
    - name: "Domicile State"
      expr: domicile_state
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "Enrollment Count Ec"
      expr: enrollment_count_ec
    - name: "Enrollment Count Ef"
      expr: enrollment_count_ef
    - name: "Enrollment Count Eo"
      expr: enrollment_count_eo
    - name: "Enrollment Count Es"
      expr: enrollment_count_es
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Funding Arrangement"
      expr: funding_arrangement
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group"
      expr: COUNT(DISTINCT group_id)
    - name: "Total Average Claim Cost"
      expr: SUM(average_claim_cost)
    - name: "Average Average Claim Cost"
      expr: AVG(average_claim_cost)
    - name: "Total Gfc Code"
      expr: SUM(gfc_code)
    - name: "Average Gfc Code"
      expr: AVG(gfc_code)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Contact business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`group_contact`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Authorization Level"
      expr: authorization_level
    - name: "Can Bill"
      expr: can_bill
    - name: "Can Enroll"
      expr: can_enroll
    - name: "City"
      expr: city
    - name: "Contact Type"
      expr: contact_type
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department"
      expr: department
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email"
      expr: email
    - name: "First Name"
      expr: first_name
    - name: "Full Name"
      expr: full_name
    - name: "Group Contact Status"
      expr: group_contact_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Contact"
      expr: COUNT(DISTINCT group_contact_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Location business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`group_location`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Address Type"
      expr: address_type
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "County Fips"
      expr: county_fips
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geocode Accuracy"
      expr: geocode_accuracy
    - name: "Group Location Status"
      expr: group_location_status
    - name: "Is Primary"
      expr: is_primary
    - name: "Location Code"
      expr: location_code
    - name: "Location Name"
      expr: location_name
    - name: "Notes"
      expr: notes
    - name: "Rating Area"
      expr: rating_area
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Location"
      expr: COUNT(DISTINCT group_location_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Plan Offering business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`group_plan_offering`"
  dimensions:
    - name: "Contribution Effective End Date"
      expr: contribution_effective_end_date
    - name: "Contribution Effective Start Date"
      expr: contribution_effective_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Group Plan Offering Status"
      expr: group_plan_offering_status
    - name: "Is Affordable"
      expr: is_affordable
    - name: "Measurement Period End"
      expr: measurement_period_end
    - name: "Measurement Period Start"
      expr: measurement_period_start
    - name: "Offering Code"
      expr: offering_code
    - name: "Offering Description"
      expr: offering_description
    - name: "Offering Name"
      expr: offering_name
    - name: "Offering Type"
      expr: offering_type
    - name: "Participation Status"
      expr: participation_status
    - name: "Plan Catalog Version"
      expr: plan_catalog_version
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Plan Offering"
      expr: COUNT(DISTINCT group_plan_offering_id)
    - name: "Total Employee Contribution Amount"
      expr: SUM(employee_contribution_amount)
    - name: "Average Employee Contribution Amount"
      expr: AVG(employee_contribution_amount)
    - name: "Total Family Contribution Amount"
      expr: SUM(family_contribution_amount)
    - name: "Average Family Contribution Amount"
      expr: AVG(family_contribution_amount)
    - name: "Total Hra Seed Amount"
      expr: SUM(hra_seed_amount)
    - name: "Average Hra Seed Amount"
      expr: AVG(hra_seed_amount)
    - name: "Total Hsa Seed Amount"
      expr: SUM(hsa_seed_amount)
    - name: "Average Hsa Seed Amount"
      expr: AVG(hsa_seed_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Renewal business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`group_renewal`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Amendment Flag"
      expr: amendment_flag
    - name: "Audit Created Timestamp"
      expr: audit_created_timestamp
    - name: "Audit Updated Timestamp"
      expr: audit_updated_timestamp
    - name: "Compliance Check Date"
      expr: compliance_check_date
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Funding Arrangement"
      expr: funding_arrangement
    - name: "Group Size"
      expr: group_size
    - name: "Latest Amendment Approval Status"
      expr: latest_amendment_approval_status
    - name: "Latest Amendment Effective Date"
      expr: latest_amendment_effective_date
    - name: "Latest Amendment Reason Code"
      expr: latest_amendment_reason_code
    - name: "Latest Amendment Type"
      expr: latest_amendment_type
    - name: "Participation Requirement Met"
      expr: participation_requirement_met
    - name: "Participation Requirement Outcome"
      expr: participation_requirement_outcome
    - name: "Prior Renewal Effective Date"
      expr: prior_renewal_effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Renewal"
      expr: COUNT(DISTINCT group_renewal_id)
    - name: "Total Latest Amendment After Value"
      expr: SUM(latest_amendment_after_value)
    - name: "Average Latest Amendment After Value"
      expr: AVG(latest_amendment_after_value)
    - name: "Total Latest Amendment Before Value"
      expr: SUM(latest_amendment_before_value)
    - name: "Average Latest Amendment Before Value"
      expr: AVG(latest_amendment_before_value)
    - name: "Total Premium Rate Prior Year"
      expr: SUM(premium_rate_prior_year)
    - name: "Average Premium Rate Prior Year"
      expr: AVG(premium_rate_prior_year)
    - name: "Total Premium Rate Renewal Year"
      expr: SUM(premium_rate_renewal_year)
    - name: "Average Premium Rate Renewal Year"
      expr: AVG(premium_rate_renewal_year)
    - name: "Total Rate Change Percentage"
      expr: SUM(rate_change_percentage)
    - name: "Average Rate Change Percentage"
      expr: AVG(rate_change_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_rate_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Quote business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`rate_quote`"
  dimensions:
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Group Sic Code"
      expr: group_sic_code
    - name: "Group Size"
      expr: group_size
    - name: "Group Type"
      expr: group_type
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "Member Count"
      expr: member_count
    - name: "Notes"
      expr: notes
    - name: "Quote Number"
      expr: quote_number
    - name: "Quote Version"
      expr: quote_version
    - name: "Rate Quote Status"
      expr: rate_quote_status
    - name: "Rating Area"
      expr: rating_area
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Quote"
      expr: COUNT(DISTINCT rate_quote_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gross Premium Amount"
      expr: SUM(gross_premium_amount)
    - name: "Average Gross Premium Amount"
      expr: AVG(gross_premium_amount)
    - name: "Total Net Premium Amount"
      expr: SUM(net_premium_amount)
    - name: "Average Net Premium Amount"
      expr: AVG(net_premium_amount)
    - name: "Total Pmpm Rate"
      expr: SUM(pmpm_rate)
    - name: "Average Pmpm Rate"
      expr: AVG(pmpm_rate)
    - name: "Total Total Group Premium Estimate"
      expr: SUM(total_group_premium_estimate)
    - name: "Average Total Group Premium Estimate"
      expr: AVG(total_group_premium_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_stop_loss_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop Loss Policy business metrics"
  source: "`vibe_health_insurance_v1`.`employer`.`stop_loss_policy`"
  dimensions:
    - name: "Aggregate Deductible Reset Period"
      expr: aggregate_deductible_reset_period
    - name: "Attachment Point Type"
      expr: attachment_point_type
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Claim Payment Limit Currency"
      expr: claim_payment_limit_currency
    - name: "Covered Benefit Codes"
      expr: covered_benefit_codes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Lasering Provision Flag"
      expr: lasering_provision_flag
    - name: "Notes"
      expr: notes
    - name: "Policy Number"
      expr: policy_number
    - name: "Policy Type"
      expr: policy_type
    - name: "Premium Currency"
      expr: premium_currency
    - name: "Renewal Date"
      expr: renewal_date
    - name: "Stop Loss Policy Status"
      expr: stop_loss_policy_status
    - name: "Termination Date"
      expr: termination_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stop Loss Policy"
      expr: COUNT(DISTINCT stop_loss_policy_id)
    - name: "Total Aggregate Attachment Point"
      expr: SUM(aggregate_attachment_point)
    - name: "Average Aggregate Attachment Point"
      expr: AVG(aggregate_attachment_point)
    - name: "Total Claim Payment Limit"
      expr: SUM(claim_payment_limit)
    - name: "Average Claim Payment Limit"
      expr: AVG(claim_payment_limit)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Individual Attachment Point"
      expr: SUM(individual_attachment_point)
    - name: "Average Individual Attachment Point"
      expr: AVG(individual_attachment_point)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;