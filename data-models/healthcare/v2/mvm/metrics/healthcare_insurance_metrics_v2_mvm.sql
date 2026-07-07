-- Metric views for domain: insurance | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member eligibility and enrollment metrics tracking coverage periods, premium revenue, subsidy costs, and enrollment patterns"
  source: "`vibe_healthcare_v1`.`insurance`.`eligibility_span`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status of the member"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Level of coverage (individual, family, etc.)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage plan"
    - name: "relationship_to_subscriber"
      expr: relationship_to_subscriber
      comment: "Member relationship to primary subscriber"
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method used for enrollment"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or channel of enrollment"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy received if applicable"
    - name: "premium_payment_frequency"
      expr: premium_payment_frequency
      comment: "Frequency of premium payments"
    - name: "eligibility_year"
      expr: YEAR(eligibility_start_date)
      comment: "Year of eligibility start"
    - name: "eligibility_month"
      expr: DATE_TRUNC('MONTH', eligibility_start_date)
      comment: "Month of eligibility start"
    - name: "cobra_indicator"
      expr: cobra_indicator
      comment: "Whether member is on COBRA continuation coverage"
    - name: "medicaid_indicator"
      expr: medicaid_indicator
      comment: "Whether member has Medicaid coverage"
    - name: "medicare_indicator"
      expr: medicare_indicator
      comment: "Whether member has Medicare coverage"
    - name: "dual_eligibility_indicator"
      expr: dual_eligibility_indicator
      comment: "Whether member is dual-eligible for Medicare and Medicaid"
  measures:
    - name: "total_member_months"
      expr: COUNT(1)
      comment: "Total count of eligibility span records representing member-months of coverage"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue collected across all eligibility spans"
    - name: "total_subsidy_cost"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount paid to support member premiums"
    - name: "avg_premium_per_member"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per member eligibility span"
    - name: "avg_subsidy_per_member"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per member eligibility span"
    - name: "distinct_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of unique members with eligibility spans"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of unique subscribers"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans with active eligibility"
    - name: "subsidy_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subsidy_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of eligibility spans receiving subsidy support"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health plan product metrics tracking plan design, cost-sharing structure, and network coverage characteristics"
  source: "`vibe_healthcare_v1`.`insurance`.`health_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (HMO, PPO, EPO, POS, etc.)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the health plan"
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum)"
    - name: "funding_type"
      expr: funding_type
      comment: "Plan funding type (fully-insured, self-funded, etc.)"
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for the plan"
    - name: "issuer_state"
      expr: issuer_state
      comment: "State where plan is issued"
    - name: "hsa_eligible"
      expr: hsa_eligible
      comment: "Whether plan is HSA-eligible"
    - name: "out_of_network_coverage"
      expr: out_of_network_coverage
      comment: "Whether plan covers out-of-network services"
    - name: "preventive_care_covered"
      expr: preventive_care_covered
      comment: "Whether preventive care is covered at no cost"
    - name: "requires_pcp_selection"
      expr: requires_pcp_selection
      comment: "Whether plan requires primary care physician selection"
    - name: "requires_referral_for_specialist"
      expr: requires_referral_for_specialist
      comment: "Whether plan requires referrals for specialist visits"
  measures:
    - name: "total_health_plans"
      expr: COUNT(1)
      comment: "Total count of health plan products"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount across plans"
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount across plans"
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(individual_oop_max_amount AS DOUBLE))
      comment: "Average individual out-of-pocket maximum across plans"
    - name: "avg_family_oop_max"
      expr: AVG(CAST(family_oop_max_amount AS DOUBLE))
      comment: "Average family out-of-pocket maximum across plans"
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(primary_care_copay_amount AS DOUBLE))
      comment: "Average primary care visit copay amount"
    - name: "avg_specialist_copay"
      expr: AVG(CAST(specialist_copay_amount AS DOUBLE))
      comment: "Average specialist visit copay amount"
    - name: "avg_er_copay"
      expr: AVG(CAST(emergency_room_copay_amount AS DOUBLE))
      comment: "Average emergency room copay amount"
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans"
    - name: "hsa_eligible_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hsa_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans that are HSA-eligible"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_payer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer contract performance metrics tracking reimbursement rates, quality incentives, and contract compliance"
  source: "`vibe_healthcare_v1`.`insurance`.`payer_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of payer contract"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "reimbursement_method"
      expr: reimbursement_method
      comment: "Method of provider reimbursement"
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (FFS, capitation, shared savings, etc.)"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation for the contract"
    - name: "state_code"
      expr: state_code
      comment: "State where contract is effective"
    - name: "apm_program_type"
      expr: apm_program_type
      comment: "Alternative payment model program type"
    - name: "contract_year"
      expr: YEAR(effective_date)
      comment: "Year contract became effective"
    - name: "quality_bonus_eligible"
      expr: quality_bonus_eligible
      comment: "Whether contract is eligible for quality bonuses"
    - name: "quality_penalty_eligible"
      expr: quality_penalty_eligible
      comment: "Whether contract is subject to quality penalties"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total count of payer contracts"
    - name: "avg_base_reimbursement_pct"
      expr: AVG(CAST(base_reimbursement_percentage AS DOUBLE))
      comment: "Average base reimbursement percentage across contracts"
    - name: "total_care_gap_incentive"
      expr: SUM(CAST(care_gap_closure_incentive_amount AS DOUBLE))
      comment: "Total care gap closure incentive amounts across contracts"
    - name: "avg_care_gap_incentive"
      expr: AVG(CAST(care_gap_closure_incentive_amount AS DOUBLE))
      comment: "Average care gap closure incentive per contract"
    - name: "total_stop_loss_threshold"
      expr: SUM(CAST(stop_loss_threshold_amount AS DOUBLE))
      comment: "Total stop-loss threshold amounts across contracts"
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold_amount AS DOUBLE))
      comment: "Average stop-loss threshold per contract"
    - name: "distinct_provider_orgs"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Distinct count of provider organizations under contract"
    - name: "quality_bonus_eligible_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_bonus_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts eligible for quality bonuses"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_fee_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule line-item metrics tracking contracted rates, RVU values, and reimbursement structure by procedure"
  source: "`vibe_healthcare_v1`.`insurance`.`fee_schedule_line`"
  dimensions:
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code (CPT, HCPCS, etc.)"
    - name: "procedure_code_type"
      expr: procedure_code_type
      comment: "Type of procedure code system"
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for rate calculation (fee schedule, percent of charges, etc.)"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service where procedure is performed"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility for the fee schedule line"
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty code applicable to this line"
    - name: "fee_schedule_line_status"
      expr: fee_schedule_line_status
      comment: "Current status of the fee schedule line"
    - name: "bundled_indicator"
      expr: bundled_indicator
      comment: "Whether procedure is part of a bundled payment"
    - name: "authorization_required"
      expr: authorization_required
      comment: "Whether prior authorization is required"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the fee schedule line became effective"
  measures:
    - name: "total_fee_schedule_lines"
      expr: COUNT(1)
      comment: "Total count of fee schedule line items"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Average contracted rate amount per procedure"
    - name: "total_contracted_rate_value"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total contracted rate value across all fee schedule lines"
    - name: "avg_case_rate"
      expr: AVG(CAST(case_rate_amount AS DOUBLE))
      comment: "Average case rate amount for bundled procedures"
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate for facility services"
    - name: "avg_rvu_total"
      expr: AVG(CAST(rvu_total AS DOUBLE))
      comment: "Average total relative value units per procedure"
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVU component per procedure"
    - name: "avg_rvu_practice_expense"
      expr: AVG(CAST(rvu_practice_expense AS DOUBLE))
      comment: "Average practice expense RVU component per procedure"
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average conversion factor for RVU-to-dollar translation"
    - name: "distinct_procedures"
      expr: COUNT(DISTINCT procedure_code)
      comment: "Distinct count of unique procedure codes in fee schedules"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_prior_auth_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization rule metrics tracking authorization requirements, turnaround times, and clinical criteria by service"
  source: "`vibe_healthcare_v1`.`insurance`.`prior_auth_rule`"
  dimensions:
    - name: "pa_requirement_type"
      expr: pa_requirement_type
      comment: "Type of prior authorization requirement"
    - name: "prior_auth_rule_status"
      expr: prior_auth_rule_status
      comment: "Current status of the prior authorization rule"
    - name: "service_category"
      expr: service_category
      comment: "Category of service requiring authorization"
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code requiring prior authorization"
    - name: "procedure_code_type"
      expr: procedure_code_type
      comment: "Type of procedure code system"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service where authorization applies"
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Whether step therapy is required before authorization"
    - name: "auto_approval_eligible"
      expr: auto_approval_eligible
      comment: "Whether rule allows for automatic approval"
    - name: "submission_method"
      expr: submission_method
      comment: "Method for submitting prior authorization requests"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the prior auth rule became effective"
  measures:
    - name: "total_prior_auth_rules"
      expr: COUNT(1)
      comment: "Total count of prior authorization rules"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours for prior authorization decisions"
    - name: "avg_urgent_turnaround_hours"
      expr: AVG(CAST(urgent_turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time for urgent prior authorization requests"
    - name: "avg_quantity_limit"
      expr: AVG(CAST(quantity_limit AS DOUBLE))
      comment: "Average quantity limit per authorization"
    - name: "distinct_procedures_requiring_pa"
      expr: COUNT(DISTINCT procedure_code)
      comment: "Distinct count of procedures requiring prior authorization"
    - name: "distinct_payers_with_pa_rules"
      expr: COUNT(DISTINCT payer_id)
      comment: "Distinct count of payers with prior authorization rules"
    - name: "step_therapy_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN step_therapy_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prior auth rules requiring step therapy"
    - name: "auto_approval_eligible_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_approval_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rules eligible for automatic approval"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit design metrics tracking cost-sharing parameters, coverage limits, and benefit utilization controls"
  source: "`vibe_healthcare_v1`.`insurance`.`benefit`"
  dimensions:
    - name: "subcategory"
      expr: subcategory
      comment: "Benefit subcategory for more granular classification"
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the benefit"
    - name: "service_type_code"
      expr: service_type_code
      comment: "Service type code for the benefit"
    - name: "network_type"
      expr: network_type
      comment: "Network type (in-network, out-of-network, etc.)"
    - name: "cost_sharing_tier"
      expr: cost_sharing_tier
      comment: "Cost-sharing tier for the benefit"
    - name: "tier"
      expr: tier
      comment: "Benefit tier designation"
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Pharmacy formulary tier if applicable"
    - name: "preventive_care_flag"
      expr: preventive_care_flag
      comment: "Whether benefit is classified as preventive care"
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization is required"
    - name: "step_therapy_required_flag"
      expr: step_therapy_required_flag
      comment: "Whether step therapy is required"
    - name: "quantity_limit_flag"
      expr: quantity_limit_flag
      comment: "Whether quantity limits apply"
  measures:
    - name: "total_benefits"
      expr: COUNT(1)
      comment: "Total count of benefit definitions"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across benefits"
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across benefits"
    - name: "avg_coverage_pct"
      expr: AVG(CAST(coverage_percentage AS DOUBLE))
      comment: "Average coverage percentage across benefits"
    - name: "avg_dollar_limit"
      expr: AVG(CAST(dollar_limit_amount AS DOUBLE))
      comment: "Average dollar limit per benefit"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans with defined benefits"
    - name: "prior_auth_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of benefits requiring prior authorization"
    - name: "preventive_care_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventive_care_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of benefits classified as preventive care"
    - name: "quantity_limit_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quantity_limit_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of benefits with quantity limits"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member enrollment lifecycle metrics tracking enrollment events, premium payments, and coverage continuity"
  source: "`vibe_healthcare_v1`.`insurance`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, renewal, change, etc.)"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of enrollment"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment occurred"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (individual, family, etc.)"
    - name: "relationship_to_subscriber"
      expr: relationship_to_subscriber
      comment: "Member relationship to subscriber"
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Status of premium payments"
    - name: "premium_payment_frequency"
      expr: premium_payment_frequency
      comment: "Frequency of premium payments"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy if applicable"
    - name: "cobra_indicator"
      expr: cobra_indicator
      comment: "Whether enrollment is COBRA continuation"
    - name: "eligibility_verification_status"
      expr: eligibility_verification_status
      comment: "Status of eligibility verification"
    - name: "enrollment_year"
      expr: YEAR(enrollment_effective_date)
      comment: "Year of enrollment effective date"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Month of enrollment effective date"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total count of member enrollment records"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue from enrollments"
    - name: "total_subsidy_cost"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy cost across enrollments"
    - name: "avg_premium_per_enrollment"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per enrollment"
    - name: "avg_subsidy_per_enrollment"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per enrollment"
    - name: "distinct_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of unique members enrolled"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans with enrollments"
    - name: "cobra_enrollment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cobra_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that are COBRA continuation"
$$;