-- Metric views for domain: plan | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core health plan performance metrics including enrollment, premium revenue, and cost-sharing analysis"
  source: "`vibe_health_insurance_v1`.`plan`.`health_plan`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Calendar year of the health plan"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Business line (e.g., Commercial, Medicare, Medicaid)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (e.g., HMO, PPO, EPO)"
    - name: "plan_state"
      expr: plan_state
      comment: "State where the plan is offered"
    - name: "plan_region"
      expr: plan_region
      comment: "Geographic region for the plan"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the health plan (active, terminated, pending)"
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category classification"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (e.g., Tier 1, Tier 2)"
    - name: "aca_compliant_flag"
      expr: CASE WHEN plan_aca_compliant = TRUE THEN 'ACA Compliant' ELSE 'Non-ACA' END
      comment: "Whether the plan is ACA compliant"
    - name: "marketplace_eligible_flag"
      expr: CASE WHEN plan_marketplace_eligible = TRUE THEN 'Marketplace Eligible' ELSE 'Not Eligible' END
      comment: "Whether the plan is eligible for marketplace enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_start_date)
      comment: "Month when enrollment started"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when plan became effective"
  measures:
    - name: "total_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Total number of distinct health plans"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue across all plans"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per plan"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible amount across plans"
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible amount across plans"
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum across plans"
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum across plans"
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay amount"
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay amount"
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for plans"
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category risk score"
    - name: "total_deductible_liability"
      expr: SUM(CAST(deductible_individual AS DOUBLE))
      comment: "Total individual deductible liability across all plans"
    - name: "total_oop_max_exposure"
      expr: SUM(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Total individual out-of-pocket maximum exposure"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit package design and cost-sharing metrics for plan competitiveness and actuarial value analysis"
  source: "`vibe_health_insurance_v1`.`plan`.`benefit_package`"
  dimensions:
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of plan (HMO, PPO, EPO, POS)"
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation for the benefit package"
    - name: "deductible_type"
      expr: deductible_type
      comment: "Type of deductible structure"
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Current status of the benefit package"
    - name: "prior_auth_required_flag"
      expr: CASE WHEN prior_auth_required = TRUE THEN 'Prior Auth Required' ELSE 'No Prior Auth' END
      comment: "Whether prior authorization is required"
    - name: "generic_substitution_flag"
      expr: CASE WHEN generic_substitution_required = TRUE THEN 'Generic Required' ELSE 'Brand Allowed' END
      comment: "Whether generic drug substitution is required"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when benefit package became effective"
  measures:
    - name: "total_benefit_packages"
      expr: COUNT(DISTINCT benefit_package_id)
      comment: "Total number of distinct benefit packages"
    - name: "avg_actuarial_value"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage across benefit packages"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount"
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount"
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum"
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum"
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay"
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay"
    - name: "avg_inpatient_coinsurance"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance percentage"
    - name: "avg_outpatient_coinsurance"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance percentage"
    - name: "avg_retail_generic_copay"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail generic drug copay"
    - name: "avg_retail_brand_copay"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail brand drug copay"
    - name: "avg_mail_order_generic_copay"
      expr: AVG(CAST(mail_order_copay_generic AS DOUBLE))
      comment: "Average mail order generic drug copay"
    - name: "avg_mail_order_brand_copay"
      expr: AVG(CAST(mail_order_copay_brand AS DOUBLE))
      comment: "Average mail order brand drug copay"
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay"
    - name: "total_deductible_exposure"
      expr: SUM(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Total individual deductible exposure across all packages"
    - name: "total_oop_max_exposure"
      expr: SUM(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Total individual out-of-pocket maximum exposure"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate and pricing metrics for rate adequacy, competitiveness, and regulatory compliance analysis"
  source: "`vibe_health_insurance_v1`.`plan`.`rate`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for the rate"
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier classification (individual, family, etc.)"
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area code"
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (base, adjusted, etc.)"
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate"
    - name: "plan_designation"
      expr: plan_designation
      comment: "Plan designation for the rate"
    - name: "tobacco_surcharge_applicable_flag"
      expr: CASE WHEN is_tobacco_surcharge_applicable = TRUE THEN 'Tobacco Surcharge' ELSE 'No Surcharge' END
      comment: "Whether tobacco surcharge applies"
    - name: "tobacco_use_indicator"
      expr: tobacco_use_indicator
      comment: "Tobacco use indicator"
    - name: "underwriting_class"
      expr: underwriting_class_code
      comment: "Underwriting class code"
    - name: "age_band"
      expr: CONCAT(COALESCE(min_age, 'N/A'), '-', COALESCE(max_age, 'N/A'))
      comment: "Age band range for rating"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when rate became effective"
  measures:
    - name: "total_rates"
      expr: COUNT(DISTINCT rate_id)
      comment: "Total number of distinct rates"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across all rates"
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium"
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium"
    - name: "avg_tobacco_surcharge"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average tobacco surcharge amount"
    - name: "total_premium_revenue"
      expr: SUM(CAST(age_rated_premium AS DOUBLE))
      comment: "Total premium revenue from age-rated premiums"
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate AS DOUBLE))
      comment: "Total revenue from base rates"
    - name: "total_surcharge_revenue"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total revenue from surcharges"
    - name: "total_family_tier_revenue"
      expr: SUM(CAST(family_tier_premium AS DOUBLE))
      comment: "Total revenue from family tier premiums"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit-level cost-sharing and coverage metrics for benefit design optimization and regulatory compliance"
  source: "`vibe_health_insurance_v1`.`plan`.`benefit`"
  dimensions:
    - name: "category"
      expr: category
      comment: "Benefit category"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage provided"
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the benefit"
    - name: "cost_sharing_type"
      expr: cost_sharing_type
      comment: "Type of cost sharing (copay, coinsurance, etc.)"
    - name: "authorization_required_flag"
      expr: CASE WHEN authorization_required = TRUE THEN 'Auth Required' ELSE 'No Auth' END
      comment: "Whether authorization is required"
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization required"
    - name: "prior_auth_review_level"
      expr: prior_auth_review_level
      comment: "Level of prior authorization review"
    - name: "preventive_service_flag"
      expr: CASE WHEN preventive_service_flag = TRUE THEN 'Preventive' ELSE 'Non-Preventive' END
      comment: "Whether benefit is a preventive service"
    - name: "wellness_mandate_flag"
      expr: CASE WHEN wellness_mandate_flag = TRUE THEN 'Wellness Mandate' ELSE 'Non-Mandate' END
      comment: "Whether benefit is a wellness mandate"
    - name: "is_mandatory_flag"
      expr: CASE WHEN is_mandatory = TRUE THEN 'Mandatory' ELSE 'Optional' END
      comment: "Whether benefit is mandatory"
    - name: "is_exempt_flag"
      expr: CASE WHEN is_exempt = TRUE THEN 'Exempt' ELSE 'Not Exempt' END
      comment: "Whether benefit is exempt from certain requirements"
    - name: "ehb_classification"
      expr: ehb_classification
      comment: "Essential Health Benefit classification"
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier for drug benefits"
    - name: "tier"
      expr: tier
      comment: "Benefit tier"
    - name: "limit_type"
      expr: limit_type
      comment: "Type of benefit limit"
    - name: "limit_period"
      expr: limit_period
      comment: "Period for benefit limit"
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Type of exclusion"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when benefit became effective"
  measures:
    - name: "total_benefits"
      expr: COUNT(DISTINCT benefit_id)
      comment: "Total number of distinct benefits"
    - name: "avg_cost_sharing_amount"
      expr: AVG(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Average cost sharing amount across benefits"
    - name: "avg_cost_sharing_percent"
      expr: AVG(CAST(cost_sharing_percent AS DOUBLE))
      comment: "Average cost sharing percentage"
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average benefit limit value"
    - name: "avg_oop_max_amount"
      expr: AVG(CAST(oop_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum amount"
    - name: "avg_moop_max_amount"
      expr: AVG(CAST(moop_max_amount AS DOUBLE))
      comment: "Average maximum out-of-pocket maximum amount"
    - name: "total_cost_sharing_liability"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost sharing liability across all benefits"
    - name: "total_oop_max_exposure"
      expr: SUM(CAST(oop_max_amount AS DOUBLE))
      comment: "Total out-of-pocket maximum exposure"
    - name: "total_limit_value"
      expr: SUM(CAST(limit_value AS DOUBLE))
      comment: "Total benefit limit value"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-sharing rule metrics for member cost burden analysis and benefit design optimization"
  source: "`vibe_health_insurance_v1`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost sharing rule"
    - name: "cost_share_category"
      expr: cost_share_category
      comment: "Category of cost sharing"
    - name: "cost_share_rule_status"
      expr: cost_share_rule_status
      comment: "Current status of the cost sharing rule"
    - name: "network_type"
      expr: network_type
      comment: "Network type (in-network, out-of-network)"
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier classification"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the rule"
    - name: "after_deductible_flag"
      expr: CASE WHEN after_deductible = TRUE THEN 'After Deductible' ELSE 'Before Deductible' END
      comment: "Whether rule applies after deductible is met"
    - name: "prior_to_deductible_flag"
      expr: CASE WHEN prior_to_deductible = TRUE THEN 'Prior to Deductible' ELSE 'After Deductible' END
      comment: "Whether rule applies prior to deductible"
    - name: "hsa_compatible_flag"
      expr: CASE WHEN hsa_compatible = TRUE THEN 'HSA Compatible' ELSE 'Not HSA Compatible' END
      comment: "Whether rule is HSA compatible"
    - name: "is_default_rule_flag"
      expr: CASE WHEN is_default_rule = TRUE THEN 'Default Rule' ELSE 'Custom Rule' END
      comment: "Whether this is a default rule"
    - name: "deductible_aggregate_flag"
      expr: CASE WHEN deductible_aggregate_flag = TRUE THEN 'Aggregate' ELSE 'Non-Aggregate' END
      comment: "Whether deductible aggregates"
    - name: "deductible_embedded_flag"
      expr: CASE WHEN deductible_embedded_flag = TRUE THEN 'Embedded' ELSE 'Non-Embedded' END
      comment: "Whether deductible is embedded"
    - name: "applies_to_drug_flag"
      expr: CASE WHEN applies_to_drug = TRUE THEN 'Applies to Drug' ELSE 'Does Not Apply' END
      comment: "Whether rule applies to drug benefits"
    - name: "applies_to_procedure_flag"
      expr: CASE WHEN applies_to_procedure = TRUE THEN 'Applies to Procedure' ELSE 'Does Not Apply' END
      comment: "Whether rule applies to procedures"
    - name: "applies_to_ancillary_flag"
      expr: CASE WHEN applies_to_ancillary = TRUE THEN 'Applies to Ancillary' ELSE 'Does Not Apply' END
      comment: "Whether rule applies to ancillary services"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when cost share rule became effective"
  measures:
    - name: "total_cost_share_rules"
      expr: COUNT(DISTINCT cost_share_rule_id)
      comment: "Total number of distinct cost sharing rules"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across rules"
    - name: "avg_copay_oon"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay amount"
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate"
    - name: "avg_coinsurance_rate_oon"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate"
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
    - name: "total_deductible_exposure"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible exposure across all rules"
    - name: "total_oop_max_exposure"
      expr: SUM(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Total out-of-pocket maximum exposure"
    - name: "total_copay_liability"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay liability across all rules"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service area coverage and regulatory compliance metrics for market expansion and network adequacy analysis"
  source: "`vibe_health_insurance_v1`.`plan`.`plan_service_area`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State where service area is located"
    - name: "county"
      expr: county
      comment: "County within the service area"
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage in the service area"
    - name: "network_type"
      expr: network_type
      comment: "Network type for the service area"
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category for the service area"
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange market designation"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the service area"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status"
    - name: "is_exclusive_flag"
      expr: CASE WHEN is_exclusive = TRUE THEN 'Exclusive' ELSE 'Non-Exclusive' END
      comment: "Whether service area is exclusive"
    - name: "is_medicare_eligible_flag"
      expr: CASE WHEN is_medicare_eligible = TRUE THEN 'Medicare Eligible' ELSE 'Not Eligible' END
      comment: "Whether service area is Medicare eligible"
    - name: "is_medicaid_eligible_flag"
      expr: CASE WHEN is_medicaid_eligible = TRUE THEN 'Medicaid Eligible' ELSE 'Not Eligible' END
      comment: "Whether service area is Medicaid eligible"
    - name: "is_regulatory_compliant_flag"
      expr: CASE WHEN is_regulatory_compliant = TRUE THEN 'Compliant' ELSE 'Non-Compliant' END
      comment: "Whether service area is regulatory compliant"
    - name: "is_federal_funded_flag"
      expr: CASE WHEN is_federal_funded = TRUE THEN 'Federal Funded' ELSE 'Not Federal Funded' END
      comment: "Whether service area is federally funded"
    - name: "is_state_funded_flag"
      expr: CASE WHEN is_state_funded = TRUE THEN 'State Funded' ELSE 'Not State Funded' END
      comment: "Whether service area is state funded"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when service area became effective"
  measures:
    - name: "total_service_areas"
      expr: COUNT(DISTINCT plan_service_area_id)
      comment: "Total number of distinct plan service areas"
    - name: "total_counties_covered"
      expr: COUNT(DISTINCT county)
      comment: "Total number of distinct counties covered"
    - name: "total_states_covered"
      expr: COUNT(DISTINCT state)
      comment: "Total number of distinct states covered"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rx_benefit_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy benefit configuration metrics for formulary management, drug cost control, and PBM performance analysis"
  source: "`vibe_health_insurance_v1`.`plan`.`rx_benefit_config`"
  dimensions:
    - name: "rx_benefit_config_status"
      expr: rx_benefit_config_status
      comment: "Current status of the Rx benefit configuration"
    - name: "cost_sharing_method"
      expr: cost_sharing_method
      comment: "Method of cost sharing for pharmacy benefits"
    - name: "pbm_vendor"
      expr: pbm_vendor
      comment: "Pharmacy Benefit Manager vendor"
    - name: "retail_network_type"
      expr: retail_network_type
      comment: "Type of retail pharmacy network"
    - name: "mail_order_network_type"
      expr: mail_order_network_type
      comment: "Type of mail order pharmacy network"
    - name: "specialty_pharmacy_network"
      expr: specialty_pharmacy_network
      comment: "Specialty pharmacy network designation"
    - name: "formulary_version"
      expr: formulary_version
      comment: "Version of the formulary"
    - name: "deductible_applicable_flag"
      expr: CASE WHEN deductible_applicable = TRUE THEN 'Deductible Applies' ELSE 'No Deductible' END
      comment: "Whether deductible applies to Rx benefits"
    - name: "step_therapy_required_flag"
      expr: CASE WHEN step_therapy_required = TRUE THEN 'Step Therapy Required' ELSE 'No Step Therapy' END
      comment: "Whether step therapy is required"
    - name: "ninety_day_supply_allowed_flag"
      expr: CASE WHEN ninety_day_supply_allowed = TRUE THEN '90-Day Allowed' ELSE 'Not Allowed' END
      comment: "Whether 90-day supply is allowed"
    - name: "is_specialty_drug_excluded_flag"
      expr: CASE WHEN is_specialty_drug_excluded = TRUE THEN 'Specialty Excluded' ELSE 'Specialty Included' END
      comment: "Whether specialty drugs are excluded"
    - name: "is_biologic_preferred_flag"
      expr: CASE WHEN is_biologic_preferred = TRUE THEN 'Biologic Preferred' ELSE 'Not Preferred' END
      comment: "Whether biologics are preferred"
    - name: "is_biosimilar_preferred_flag"
      expr: CASE WHEN is_biosimilar_preferred = TRUE THEN 'Biosimilar Preferred' ELSE 'Not Preferred' END
      comment: "Whether biosimilars are preferred"
    - name: "is_exempt_from_mlr_flag"
      expr: CASE WHEN is_exempt_from_mlr = TRUE THEN 'MLR Exempt' ELSE 'Not Exempt' END
      comment: "Whether Rx benefit is exempt from MLR"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when Rx benefit configuration became effective"
  measures:
    - name: "total_rx_benefit_configs"
      expr: COUNT(DISTINCT rx_benefit_config_id)
      comment: "Total number of distinct Rx benefit configurations"
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate for pharmacy benefits"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount for Rx benefits"
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average out-of-pocket maximum for Rx benefits"
    - name: "avg_max_coverage_amount"
      expr: AVG(CAST(max_coverage_amount AS DOUBLE))
      comment: "Average maximum coverage amount"
    - name: "avg_coverage_limit_per_rx"
      expr: AVG(CAST(coverage_limit_per_prescription AS DOUBLE))
      comment: "Average coverage limit per prescription"
    - name: "avg_coverage_limit_per_year"
      expr: AVG(CAST(coverage_limit_per_year AS DOUBLE))
      comment: "Average coverage limit per year"
    - name: "total_rx_deductible_exposure"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total Rx deductible exposure across all configurations"
    - name: "total_rx_oop_max_exposure"
      expr: SUM(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Total Rx out-of-pocket maximum exposure"
    - name: "total_max_coverage"
      expr: SUM(CAST(max_coverage_amount AS DOUBLE))
      comment: "Total maximum coverage amount across all configurations"
$$;