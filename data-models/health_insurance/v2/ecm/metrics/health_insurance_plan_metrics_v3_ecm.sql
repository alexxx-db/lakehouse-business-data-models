-- Metric views for domain: plan | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core health plan performance metrics including enrollment capacity, premium revenue, risk adjustment, and regulatory compliance tracking"
  source: "`vibe_health_insurance_v1`.`plan`.`health_plan`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Calendar year the health plan is offered"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Business line (Commercial, Medicare, Medicaid, Exchange)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification (Individual, Small Group, Large Group)"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO, POS)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current operational status of the health plan"
    - name: "plan_state"
      expr: plan_state
      comment: "State where the plan is offered"
    - name: "plan_region"
      expr: plan_region
      comment: "Geographic region for the plan"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier classification (Narrow, Standard, Broad)"
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category classification"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the plan"
    - name: "aca_compliant_flag"
      expr: CASE WHEN plan_aca_compliant = TRUE THEN 'ACA Compliant' ELSE 'Non-ACA' END
      comment: "Whether plan meets ACA compliance requirements"
    - name: "marketplace_eligible_flag"
      expr: CASE WHEN plan_marketplace_eligible = TRUE THEN 'Marketplace Eligible' ELSE 'Not Eligible' END
      comment: "Whether plan is eligible for marketplace exchange"
    - name: "mlr_exempt_flag"
      expr: CASE WHEN is_exempt_from_mlr = TRUE THEN 'MLR Exempt' ELSE 'MLR Subject' END
      comment: "Whether plan is exempt from Medical Loss Ratio requirements"
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('MONTH', enrollment_start_date)
      comment: "Month when enrollment period begins"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when plan becomes effective"
  measures:
    - name: "total_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Total number of distinct health plans"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue across all plans"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per health plan"
    - name: "total_individual_deductible"
      expr: SUM(CAST(deductible_individual AS DOUBLE))
      comment: "Sum of individual deductible amounts across plans"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible amount"
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible amount"
    - name: "avg_oop_max_individual"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum"
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum"
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans"
    - name: "avg_copay_primary_care"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay amount"
    - name: "avg_copay_specialist"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay amount"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for actuarial pricing"
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category risk score"
    - name: "aca_compliant_plan_count"
      expr: COUNT(DISTINCT CASE WHEN plan_aca_compliant = TRUE THEN health_plan_id END)
      comment: "Number of ACA-compliant plans"
    - name: "marketplace_eligible_plan_count"
      expr: COUNT(DISTINCT CASE WHEN plan_marketplace_eligible = TRUE THEN health_plan_id END)
      comment: "Number of marketplace-eligible plans"
    - name: "active_plan_count"
      expr: COUNT(DISTINCT CASE WHEN plan_status = 'Active' THEN health_plan_id END)
      comment: "Number of currently active health plans"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit package design metrics tracking cost-sharing structures, actuarial value, and pharmacy benefit configurations"
  source: "`vibe_health_insurance_v1`.`plan`.`benefit_package`"
  dimensions:
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum)"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type classification"
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation for the benefit package"
    - name: "deductible_type"
      expr: deductible_type
      comment: "Type of deductible structure (Embedded, Aggregate)"
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Current status of the benefit package"
    - name: "prior_auth_required_flag"
      expr: CASE WHEN prior_auth_required = TRUE THEN 'Prior Auth Required' ELSE 'No Prior Auth' END
      comment: "Whether prior authorization is required"
    - name: "generic_substitution_flag"
      expr: CASE WHEN generic_substitution_required = TRUE THEN 'Generic Required' ELSE 'Brand Allowed' END
      comment: "Whether generic drug substitution is required"
    - name: "specialty_drug_program"
      expr: specialty_drug_management_program
      comment: "Specialty drug management program type"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when benefit package becomes effective"
  measures:
    - name: "total_benefit_packages"
      expr: COUNT(DISTINCT benefit_package_id)
      comment: "Total number of distinct benefit packages"
    - name: "avg_actuarial_value_pct"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage across packages"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount"
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount"
    - name: "avg_oop_max_individual"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum"
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum"
    - name: "avg_copay_primary_care"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay"
    - name: "avg_copay_specialist"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay"
    - name: "avg_coinsurance_inpatient"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance percentage"
    - name: "avg_coinsurance_outpatient"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance percentage"
    - name: "avg_retail_copay_generic"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail generic drug copay"
    - name: "avg_retail_copay_brand"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail brand drug copay"
    - name: "avg_mail_order_copay_generic"
      expr: AVG(CAST(mail_order_copay_generic AS DOUBLE))
      comment: "Average mail order generic drug copay"
    - name: "avg_mail_order_copay_brand"
      expr: AVG(CAST(mail_order_copay_brand AS DOUBLE))
      comment: "Average mail order brand drug copay"
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay"
    - name: "prior_auth_package_count"
      expr: COUNT(DISTINCT CASE WHEN prior_auth_required = TRUE THEN benefit_package_id END)
      comment: "Number of packages requiring prior authorization"
    - name: "generic_substitution_package_count"
      expr: COUNT(DISTINCT CASE WHEN generic_substitution_required = TRUE THEN benefit_package_id END)
      comment: "Number of packages requiring generic substitution"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate metrics tracking pricing by age, family tier, rating area, and tobacco use for actuarial and revenue analysis"
  source: "`vibe_health_insurance_v1`.`plan`.`rate`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the rate"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for rate classification"
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier (Individual, Family, Employee+Spouse, etc.)"
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area code"
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate"
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (Standard, Subsidized, etc.)"
    - name: "tobacco_use_indicator"
      expr: tobacco_use_indicator
      comment: "Tobacco use status for rating"
    - name: "underwriting_class_code"
      expr: underwriting_class_code
      comment: "Underwriting class for risk classification"
    - name: "regulatory_filing_type"
      expr: regulatory_filing_type
      comment: "Type of regulatory filing for the rate"
    - name: "plan_designation"
      expr: plan_designation
      comment: "Plan designation classification"
    - name: "tobacco_surcharge_applicable_flag"
      expr: CASE WHEN is_tobacco_surcharge_applicable = TRUE THEN 'Tobacco Surcharge' ELSE 'No Surcharge' END
      comment: "Whether tobacco surcharge applies"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when rate becomes effective"
  measures:
    - name: "total_rates"
      expr: COUNT(DISTINCT rate_id)
      comment: "Total number of distinct rates"
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate AS DOUBLE))
      comment: "Sum of base rate amounts"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate amount"
    - name: "total_age_rated_premium"
      expr: SUM(CAST(age_rated_premium AS DOUBLE))
      comment: "Sum of age-rated premium amounts"
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium"
    - name: "total_family_tier_premium"
      expr: SUM(CAST(family_tier_premium AS DOUBLE))
      comment: "Sum of family tier premium amounts"
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium"
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Sum of surcharge amounts (tobacco, etc.)"
    - name: "avg_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average surcharge amount"
    - name: "tobacco_surcharge_rate_count"
      expr: COUNT(DISTINCT CASE WHEN is_tobacco_surcharge_applicable = TRUE THEN rate_id END)
      comment: "Number of rates with tobacco surcharge"
    - name: "active_rate_count"
      expr: COUNT(DISTINCT CASE WHEN rate_status = 'Active' THEN rate_id END)
      comment: "Number of currently active rates"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission metrics tracking filing status, approval rates, fees, and compliance timelines for state and federal filings"
  source: "`vibe_health_insurance_v1`.`plan`.`submission`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the submission"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission (CMS, State DOI, etc.)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of plan being submitted"
    - name: "submitter_role"
      expr: submitter_role
      comment: "Role of the person submitting"
    - name: "annual_filing_flag"
      expr: CASE WHEN is_annual_filing = TRUE THEN 'Annual Filing' ELSE 'Non-Annual' END
      comment: "Whether this is an annual filing"
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when submission was made"
    - name: "approval_year_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when submission was approved"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when submission becomes effective"
  measures:
    - name: "total_submissions"
      expr: COUNT(DISTINCT submission_id)
      comment: "Total number of regulatory submissions"
    - name: "total_filing_fee_gross"
      expr: SUM(CAST(filing_fee_gross AS DOUBLE))
      comment: "Total gross filing fees"
    - name: "total_filing_fee_net"
      expr: SUM(CAST(filing_fee_net AS DOUBLE))
      comment: "Total net filing fees after adjustments"
    - name: "total_filing_fee_adjustment"
      expr: SUM(CAST(filing_fee_adjustment AS DOUBLE))
      comment: "Total filing fee adjustments"
    - name: "avg_filing_fee_gross"
      expr: AVG(CAST(filing_fee_gross AS DOUBLE))
      comment: "Average gross filing fee per submission"
    - name: "avg_filing_fee_net"
      expr: AVG(CAST(filing_fee_net AS DOUBLE))
      comment: "Average net filing fee per submission"
    - name: "approved_submission_count"
      expr: COUNT(DISTINCT CASE WHEN submission_status = 'Approved' THEN submission_id END)
      comment: "Number of approved submissions"
    - name: "rejected_submission_count"
      expr: COUNT(DISTINCT CASE WHEN submission_status = 'Rejected' THEN submission_id END)
      comment: "Number of rejected submissions"
    - name: "pending_submission_count"
      expr: COUNT(DISTINCT CASE WHEN submission_status = 'Pending' THEN submission_id END)
      comment: "Number of pending submissions"
    - name: "withdrawn_submission_count"
      expr: COUNT(DISTINCT CASE WHEN submission_status = 'Withdrawn' THEN submission_id END)
      comment: "Number of withdrawn submissions"
    - name: "annual_filing_count"
      expr: COUNT(DISTINCT CASE WHEN is_annual_filing = TRUE THEN submission_id END)
      comment: "Number of annual filings"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer group offering metrics tracking contribution strategies, enrollment windows, and plan adoption by employer segment"
  source: "`vibe_health_insurance_v1`.`plan`.`offering`"
  dimensions:
    - name: "offering_type"
      expr: offering_type
      comment: "Type of offering (Fully Insured, Self-Funded, etc.)"
    - name: "offering_status"
      expr: offering_status
      comment: "Current status of the offering"
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of employer contribution (Fixed, Percentage, etc.)"
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier classification"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when offering becomes effective"
    - name: "open_enrollment_start_month"
      expr: DATE_TRUNC('MONTH', open_enrollment_start_date)
      comment: "Month when open enrollment begins"
  measures:
    - name: "total_offerings"
      expr: COUNT(DISTINCT offering_id)
      comment: "Total number of plan offerings"
    - name: "total_employer_contribution"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount"
    - name: "avg_employer_contribution"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount"
    - name: "avg_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contribution amount"
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount"
    - name: "total_family_contribution"
      expr: SUM(CAST(family_contribution_amount AS DOUBLE))
      comment: "Total family contribution amount"
    - name: "avg_family_contribution"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family contribution amount"
    - name: "active_offering_count"
      expr: COUNT(DISTINCT CASE WHEN offering_status = 'Active' THEN offering_id END)
      comment: "Number of currently active offerings"
    - name: "distinct_employer_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with offerings"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans offered"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan amendment metrics tracking benefit changes, regulatory approvals, member impact, and compliance timelines"
  source: "`vibe_health_insurance_v1`.`plan`.`plan_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of plan amendment"
    - name: "plan_amendment_status"
      expr: plan_amendment_status
      comment: "Current status of the amendment"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status"
    - name: "effective_year"
      expr: effective_year
      comment: "Year when amendment becomes effective"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the amendment"
    - name: "compliance_flag"
      expr: CASE WHEN compliance_flag = TRUE THEN 'Compliant' ELSE 'Non-Compliant' END
      comment: "Whether amendment meets compliance requirements"
    - name: "member_notification_required_flag"
      expr: CASE WHEN member_notification_required = TRUE THEN 'Notification Required' ELSE 'No Notification' END
      comment: "Whether member notification is required"
    - name: "sbc_generation_flag"
      expr: CASE WHEN triggers_sbc_generation = TRUE THEN 'SBC Required' ELSE 'No SBC' END
      comment: "Whether amendment triggers SBC regeneration"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when amendment becomes effective"
    - name: "regulatory_approval_year_month"
      expr: DATE_TRUNC('MONTH', regulatory_approval_date)
      comment: "Month when regulatory approval was received"
  measures:
    - name: "total_amendments"
      expr: COUNT(DISTINCT plan_amendment_id)
      comment: "Total number of plan amendments"
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Total estimated cost impact of amendments"
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Average estimated cost impact per amendment"
    - name: "total_estimated_member_cost_impact"
      expr: SUM(CAST(impact_estimated_member_cost AS DOUBLE))
      comment: "Total estimated member cost impact"
    - name: "avg_estimated_member_cost_impact"
      expr: AVG(CAST(impact_estimated_member_cost AS DOUBLE))
      comment: "Average estimated member cost impact"
    - name: "total_estimated_provider_cost_impact"
      expr: SUM(CAST(impact_estimated_provider_cost AS DOUBLE))
      comment: "Total estimated provider cost impact"
    - name: "avg_estimated_provider_cost_impact"
      expr: AVG(CAST(impact_estimated_provider_cost AS DOUBLE))
      comment: "Average estimated provider cost impact"
    - name: "approved_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_status = 'Approved' THEN plan_amendment_id END)
      comment: "Number of approved amendments"
    - name: "pending_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_status = 'Pending' THEN plan_amendment_id END)
      comment: "Number of pending amendments"
    - name: "compliant_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_flag = TRUE THEN plan_amendment_id END)
      comment: "Number of compliant amendments"
    - name: "member_notification_required_count"
      expr: COUNT(DISTINCT CASE WHEN member_notification_required = TRUE THEN plan_amendment_id END)
      comment: "Number of amendments requiring member notification"
    - name: "sbc_generation_required_count"
      expr: COUNT(DISTINCT CASE WHEN triggers_sbc_generation = TRUE THEN plan_amendment_id END)
      comment: "Number of amendments requiring SBC regeneration"
    - name: "distinct_health_plans_amended"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans with amendments"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-sharing rule metrics tracking deductible structures, coinsurance rates, copay amounts, and out-of-pocket maximums by service category"
  source: "`vibe_health_insurance_v1`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost-sharing rule"
    - name: "cost_share_category"
      expr: cost_share_category
      comment: "Category of cost-sharing"
    - name: "cost_share_rule_status"
      expr: cost_share_rule_status
      comment: "Current status of the rule"
    - name: "network_type"
      expr: network_type
      comment: "Network type (In-Network, Out-of-Network)"
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier classification"
    - name: "applies_to_service_category"
      expr: applies_to_service_category
      comment: "Service category the rule applies to"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the rule"
    - name: "hsa_compatible_flag"
      expr: CASE WHEN hsa_compatible = TRUE THEN 'HSA Compatible' ELSE 'Not HSA Compatible' END
      comment: "Whether rule is HSA-compatible"
    - name: "default_rule_flag"
      expr: CASE WHEN is_default_rule = TRUE THEN 'Default Rule' ELSE 'Custom Rule' END
      comment: "Whether this is a default rule"
    - name: "after_deductible_flag"
      expr: CASE WHEN after_deductible = TRUE THEN 'After Deductible' ELSE 'Before Deductible' END
      comment: "Whether cost-sharing applies after deductible"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when rule becomes effective"
  measures:
    - name: "total_cost_share_rules"
      expr: COUNT(DISTINCT cost_share_rule_id)
      comment: "Total number of cost-sharing rules"
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate"
    - name: "avg_coinsurance_rate_oon"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount"
    - name: "avg_copay_amount_oon"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay amount"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount"
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average out-of-pocket maximum"
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum"
    - name: "avg_max_benefit_amount"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount"
    - name: "avg_accumulator_threshold"
      expr: AVG(CAST(accumulator_threshold AS DOUBLE))
      comment: "Average accumulator threshold"
    - name: "hsa_compatible_rule_count"
      expr: COUNT(DISTINCT CASE WHEN hsa_compatible = TRUE THEN cost_share_rule_id END)
      comment: "Number of HSA-compatible rules"
    - name: "default_rule_count"
      expr: COUNT(DISTINCT CASE WHEN is_default_rule = TRUE THEN cost_share_rule_id END)
      comment: "Number of default rules"
    - name: "distinct_benefit_packages"
      expr: COUNT(DISTINCT benefit_package_id)
      comment: "Number of distinct benefit packages with rules"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans with rules"
$$;