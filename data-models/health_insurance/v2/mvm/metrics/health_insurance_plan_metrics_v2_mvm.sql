-- Metric views for domain: plan | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for health plan portfolio management — covering premium economics, cost-sharing design, risk profile, and ACA/marketplace compliance. Used by product, actuarial, and executive teams to steer plan design and market strategy."
  source: "`vibe_health_insurance_v1`.`plan`.`health_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO, HDHP, etc.) — primary segmentation axis for plan portfolio analysis."
    - name: "plan_category"
      expr: plan_category
      comment: "Metal tier or plan category (Bronze, Silver, Gold, Platinum) — key ACA market segmentation dimension."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, etc.) — drives regulatory and financial reporting segmentation."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) — critical for pricing and regulatory compliance analysis."
    - name: "plan_state"
      expr: plan_state
      comment: "State where the plan is offered — enables geographic performance and regulatory compliance analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year — enables year-over-year trend analysis of plan economics and portfolio changes."
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the plan (Active, Terminated, Pending) — used to filter operational vs. historical plans."
    - name: "plan_marketplace_eligible"
      expr: plan_marketplace_eligible
      comment: "Whether the plan is eligible for marketplace/exchange distribution — key for ACA compliance and enrollment strategy."
    - name: "plan_aca_compliant"
      expr: plan_aca_compliant
      comment: "Whether the plan meets ACA compliance requirements — critical regulatory dimension."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the plan — used for compliance reporting and regulatory segmentation."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation — used to analyze cost-sharing and access design across network tiers."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of plan effective start date — enables cohort and trend analysis of plan launches."
  measures:
    - name: "total_active_plans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN health_plan_id END)
      comment: "Count of currently active health plans — baseline portfolio size KPI used by product and executive teams to track plan footprint."
    - name: "avg_individual_premium"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount across plans — key pricing benchmark used by actuarial and product teams to assess affordability and competitiveness."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible across plans — measures cost-sharing burden on members; used in plan design and competitive benchmarking."
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible across plans — measures family cost-sharing design; used in product strategy and member affordability analysis."
    - name: "avg_oop_max_individual"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum — critical member financial protection metric; used by actuarial and compliance teams to assess ACA OOP cap adherence."
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum — measures family financial exposure ceiling; used in plan design and regulatory compliance review."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across plans — key actuarial KPI indicating relative morbidity of plan membership; drives ACA risk adjustment revenue/liability."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC (Hierarchical Condition Category) score — measures predicted member health risk; used by actuarial teams for risk adjustment and premium adequacy assessment."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans — measures member cost-sharing rate after deductible; used in plan design benchmarking."
    - name: "marketplace_eligible_plan_count"
      expr: COUNT(CASE WHEN plan_marketplace_eligible = TRUE THEN health_plan_id END)
      comment: "Count of marketplace-eligible plans — tracks exchange distribution footprint; used by sales and product strategy teams."
    - name: "aca_compliant_plan_count"
      expr: COUNT(CASE WHEN plan_aca_compliant = TRUE THEN health_plan_id END)
      comment: "Count of ACA-compliant plans — regulatory compliance KPI; any decline triggers immediate compliance review."
    - name: "mlr_exempt_plan_count"
      expr: COUNT(CASE WHEN is_exempt_from_mlr = TRUE THEN health_plan_id END)
      comment: "Count of plans exempt from Medical Loss Ratio requirements — regulatory portfolio metric used by compliance and finance teams."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for benefit package design and cost-sharing structure — covering deductibles, OOP maximums, copays, coinsurance, and actuarial value. Used by actuarial, product design, and compliance teams to evaluate benefit richness and affordability."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit_package`"
  dimensions:
    - name: "metal_tier"
      expr: metal_tier
      comment: "Metal tier (Bronze, Silver, Gold, Platinum) — primary ACA benefit richness classification; drives actuarial value and member cost-sharing expectations."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO, HDHP) — used to segment benefit design analysis by delivery model."
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation (In-Network, Out-of-Network, Tiered) — used to analyze cost-sharing design by network access tier."
    - name: "deductible_type"
      expr: deductible_type
      comment: "Deductible structure type (Integrated, Separate, Embedded) — key benefit design dimension affecting member cost exposure."
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Lifecycle status of the benefit package — used to filter active vs. historical packages in analysis."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required under this package — used to analyze utilization management stringency across packages."
    - name: "generic_substitution_required"
      expr: generic_substitution_required
      comment: "Whether generic drug substitution is required — pharmacy cost management design dimension."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Plan year of benefit package effective start — enables year-over-year benefit design trend analysis."
  measures:
    - name: "total_active_benefit_packages"
      expr: COUNT(CASE WHEN is_active = TRUE THEN benefit_package_id END)
      comment: "Count of active benefit packages — baseline portfolio metric for benefit design inventory management."
    - name: "avg_actuarial_value_pct"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage across benefit packages — measures plan generosity (% of costs covered); critical for ACA metal tier compliance and competitive positioning."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount — measures member cost-sharing burden; used in affordability analysis and plan design benchmarking."
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount — measures family financial exposure in benefit design; used by product and actuarial teams."
    - name: "avg_oop_max_individual"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum — key member financial protection metric; used to verify ACA OOP cap compliance and assess benefit generosity."
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum — measures family financial protection ceiling; used in plan design and regulatory compliance review."
    - name: "avg_copay_primary_care"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay — measures member access cost for primary care; used in plan design competitiveness and member affordability analysis."
    - name: "avg_copay_specialist"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay — measures member cost for specialist access; used in benefit design benchmarking and network strategy."
    - name: "avg_coinsurance_inpatient"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance rate — measures member share of inpatient costs; key actuarial and benefit design KPI for high-cost event exposure."
    - name: "avg_coinsurance_outpatient"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance rate — measures member share of outpatient costs; used in benefit design and cost-sharing adequacy analysis."
    - name: "avg_retail_copay_generic"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail copay for generic drugs — pharmacy benefit affordability metric; used by pharmacy and product teams to assess generic drug access cost."
    - name: "avg_retail_copay_brand"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail copay for brand drugs — measures member cost for brand medications; used in formulary strategy and pharmacy benefit design."
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay — measures member cost for high-cost specialty medications; critical for specialty pharmacy cost management strategy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for individual benefit coverage design — tracking cost-sharing amounts, coverage limits, authorization requirements, and benefit utilization management. Used by product, clinical, and compliance teams to evaluate benefit adequacy and regulatory alignment."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit`"
  dimensions:
    - name: "category"
      expr: category
      comment: "Benefit category (e.g., Preventive Care, Mental Health, Maternity) — primary clinical segmentation for benefit analysis."
    - name: "benefit_group"
      expr: benefit_group
      comment: "Benefit group classification — used to aggregate related benefits for portfolio and compliance analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (In-Network, Out-of-Network, Both) — used to analyze benefit design by network access."
    - name: "cost_sharing_type"
      expr: cost_sharing_type
      comment: "Type of cost sharing applied (Copay, Coinsurance, Deductible) — used to segment benefit cost-sharing design analysis."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Whether prior authorization is required for this benefit — key utilization management dimension."
    - name: "ehb_classification"
      expr: ehb_classification
      comment: "Essential Health Benefit classification — ACA regulatory compliance dimension; used to track EHB coverage adequacy."
    - name: "preventive_service_flag"
      expr: preventive_service_flag
      comment: "Whether the benefit is a preventive service — ACA-mandated zero cost-sharing dimension; critical for compliance monitoring."
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the benefit (Active, Terminated, Pending) — used to filter operational benefit inventory."
    - name: "tier"
      expr: tier
      comment: "Benefit tier designation — used to analyze cost-sharing variation across benefit tiers."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the benefit — enables year-over-year benefit design trend analysis."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the benefit — used for compliance reporting and regulatory segmentation."
  measures:
    - name: "total_active_benefits"
      expr: COUNT(CASE WHEN is_active = TRUE THEN benefit_id END)
      comment: "Count of active benefits — baseline benefit inventory KPI used to track coverage breadth across plans."
    - name: "avg_cost_sharing_amount"
      expr: AVG(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Average cost-sharing amount per benefit — measures member financial burden per benefit; used in affordability and plan design analysis."
    - name: "avg_cost_sharing_percent"
      expr: AVG(CAST(cost_sharing_percent AS DOUBLE))
      comment: "Average cost-sharing percentage per benefit — measures member coinsurance rate; used in benefit design benchmarking and actuarial analysis."
    - name: "avg_oop_max_amount"
      expr: AVG(CAST(oop_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum amount at benefit level — measures member financial protection ceiling per benefit category; used in ACA compliance and benefit design review."
    - name: "avg_moop_max_amount"
      expr: AVG(CAST(moop_max_amount AS DOUBLE))
      comment: "Average maximum out-of-pocket (MOOP) amount — ACA-regulated ceiling on member cost exposure; used by compliance teams to verify regulatory adherence."
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average benefit limit value — measures coverage quantity limits (e.g., visit limits, day limits); used in benefit adequacy and network utilization analysis."
    - name: "prior_auth_benefit_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE AND is_active = TRUE THEN benefit_id END)
      comment: "Count of active benefits requiring prior authorization — measures utilization management stringency; used by clinical and operations teams to assess authorization burden."
    - name: "preventive_benefit_count"
      expr: COUNT(CASE WHEN preventive_service_flag = TRUE AND is_active = TRUE THEN benefit_id END)
      comment: "Count of active preventive service benefits — ACA compliance KPI; tracks zero-cost-sharing preventive coverage breadth required under the ACA."
    - name: "mandatory_benefit_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND is_active = TRUE THEN benefit_id END)
      comment: "Count of active mandatory benefits — tracks regulatory and contractual benefit obligations; used by compliance and product teams."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for cost-sharing rule design and financial exposure — covering deductibles, copays, coinsurance, OOP maximums, and benefit limits. Used by actuarial, product, and compliance teams to evaluate member cost-sharing adequacy and regulatory alignment."
  source: "`vibe_health_insurance_v1`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost-sharing rule (Deductible, Copay, Coinsurance, OOP Max) — primary segmentation for cost-sharing design analysis."
    - name: "cost_share_category"
      expr: cost_share_category
      comment: "Category of cost-sharing (Medical, Pharmacy, Behavioral Health) — used to segment cost-sharing analysis by service category."
    - name: "network_type"
      expr: network_type
      comment: "Network type (In-Network, Out-of-Network) — used to compare in-network vs. out-of-network cost-sharing design."
    - name: "after_deductible"
      expr: after_deductible
      comment: "Whether cost-sharing applies after the deductible is met — key benefit design dimension affecting member cost sequencing."
    - name: "hsa_compatible"
      expr: hsa_compatible
      comment: "Whether the cost-sharing rule is compatible with HSA (Health Savings Account) — used to track HDHP/HSA-eligible plan design."
    - name: "applies_to_drug"
      expr: applies_to_drug
      comment: "Whether the rule applies to drug benefits — used to segment pharmacy vs. medical cost-sharing analysis."
    - name: "applies_to_procedure"
      expr: applies_to_procedure
      comment: "Whether the rule applies to procedures — used to analyze procedural cost-sharing design."
    - name: "cost_share_rule_status"
      expr: cost_share_rule_status
      comment: "Lifecycle status of the cost-sharing rule — used to filter active vs. historical rules."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the cost-sharing rule — used for compliance reporting."
    - name: "deductible_embedded_flag"
      expr: deductible_embedded_flag
      comment: "Whether the deductible is embedded (individual within family) — key benefit design dimension for family cost-sharing structure."
  measures:
    - name: "total_active_cost_share_rules"
      expr: COUNT(CASE WHEN is_active = TRUE THEN cost_share_rule_id END)
      comment: "Count of active cost-sharing rules — baseline inventory KPI for cost-sharing rule governance and plan design complexity."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across cost-sharing rules — measures member deductible burden; used in plan design benchmarking and affordability analysis."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount — measures member point-of-service cost; used in benefit design competitiveness and member affordability analysis."
    - name: "avg_copay_out_of_network"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay amount — measures member cost penalty for out-of-network use; used in network steerage and benefit design strategy."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average in-network coinsurance rate — measures member share of costs after deductible; key actuarial and benefit design KPI."
    - name: "avg_coinsurance_rate_out_of_network"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate — measures member cost penalty for out-of-network services; used in network adequacy and benefit design analysis."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average individual out-of-pocket maximum — critical member financial protection KPI; used to verify ACA OOP cap compliance and assess benefit generosity."
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum — measures family financial protection ceiling; used in plan design and ACA compliance review."
    - name: "avg_max_benefit_amount"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount — measures coverage ceiling per rule; used in benefit adequacy and actuarial liability analysis."
    - name: "hsa_compatible_rule_count"
      expr: COUNT(CASE WHEN hsa_compatible = TRUE AND is_active = TRUE THEN cost_share_rule_id END)
      comment: "Count of active HSA-compatible cost-sharing rules — tracks HDHP/HSA-eligible plan design inventory; used by product and compliance teams."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate KPIs for pricing strategy, rate adequacy, and market competitiveness — covering base rates, age-rated premiums, family tier premiums, and tobacco surcharges. Used by actuarial, pricing, and regulatory teams to manage rate filings and premium adequacy."
  source: "`vibe_health_insurance_v1`.`plan`.`rate`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the rate — primary time dimension for year-over-year rate trend and adequacy analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) — used to segment rate analysis by regulatory and pricing market."
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier (Employee Only, Employee + Spouse, Family, etc.) — used to analyze premium variation by coverage tier."
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (Base, Age-Rated, Tobacco-Adjusted) — used to segment rate analysis by pricing methodology."
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area code — used for geographic premium variation analysis and regulatory rate filing review."
    - name: "tobacco_use_indicator"
      expr: tobacco_use_indicator
      comment: "Tobacco use indicator — used to analyze tobacco surcharge application and premium differentiation."
    - name: "is_tobacco_surcharge_applicable"
      expr: is_tobacco_surcharge_applicable
      comment: "Whether tobacco surcharge applies to this rate — used to track tobacco rating practices and regulatory compliance."
    - name: "regulatory_filing_type"
      expr: regulatory_filing_type
      comment: "Type of regulatory rate filing — used to segment rates by filing category for regulatory reporting."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate record (Active, Pending, Expired) — used to filter operational vs. historical rates."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of rate effective start — enables trend analysis of rate changes over time."
  measures:
    - name: "total_active_rates"
      expr: COUNT(CASE WHEN is_active = TRUE THEN rate_id END)
      comment: "Count of active rate records — baseline rate inventory KPI used to track pricing coverage across plans and rating areas."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base premium rate — primary pricing benchmark; used by actuarial and pricing teams to assess rate adequacy and market competitiveness."
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium — measures premium after age rating factors; used in ACA age-rating compliance and pricing analysis."
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium — measures premium by coverage tier; used in family pricing strategy and affordability analysis."
    - name: "avg_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average tobacco surcharge amount — measures tobacco rating premium differential; used in underwriting and regulatory compliance analysis."
    - name: "max_base_rate"
      expr: MAX(CAST(base_rate AS DOUBLE))
      comment: "Maximum base rate across rate records — used to identify premium ceiling and outlier rates; triggers pricing review when unusually high."
    - name: "min_base_rate"
      expr: MIN(CAST(base_rate AS DOUBLE))
      comment: "Minimum base rate across rate records — used to identify premium floor and assess affordability of lowest-cost options."
    - name: "tobacco_surcharge_rate_count"
      expr: COUNT(CASE WHEN is_tobacco_surcharge_applicable = TRUE AND is_active = TRUE THEN rate_id END)
      comment: "Count of active rates with tobacco surcharge applicable — tracks tobacco rating practice scope; used by underwriting and compliance teams."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rx_benefit_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for pharmacy benefit configuration — covering drug coverage limits, cost-sharing, formulary design, and specialty drug management. Used by pharmacy, actuarial, and product teams to manage pharmacy benefit adequacy, cost, and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`plan`.`rx_benefit_config`"
  dimensions:
    - name: "cost_sharing_method"
      expr: cost_sharing_method
      comment: "Pharmacy cost-sharing method (Copay, Coinsurance, Tiered) — primary segmentation for pharmacy benefit design analysis."
    - name: "mail_order_network_type"
      expr: mail_order_network_type
      comment: "Mail order pharmacy network type — used to analyze mail order benefit design and cost management strategy."
    - name: "retail_network_type"
      expr: retail_network_type
      comment: "Retail pharmacy network type — used to segment pharmacy benefit analysis by retail network access."
    - name: "pbm_vendor"
      expr: pbm_vendor
      comment: "Pharmacy Benefit Manager (PBM) vendor — used to analyze pharmacy benefit performance and cost by PBM partner."
    - name: "deductible_applicable"
      expr: deductible_applicable
      comment: "Whether a deductible applies to pharmacy benefits — key benefit design dimension affecting member drug cost sequencing."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Whether step therapy is required — utilization management dimension; used to track drug management program stringency."
    - name: "ninety_day_supply_allowed"
      expr: ninety_day_supply_allowed
      comment: "Whether 90-day supply is allowed — member convenience and cost management dimension; used in pharmacy benefit design analysis."
    - name: "is_specialty_drug_excluded"
      expr: is_specialty_drug_excluded
      comment: "Whether specialty drugs are excluded — used to track specialty drug coverage scope and cost management strategy."
    - name: "is_biologic_preferred"
      expr: is_biologic_preferred
      comment: "Whether biologics are preferred on formulary — used in specialty drug management and formulary strategy analysis."
    - name: "is_biosimilar_preferred"
      expr: is_biosimilar_preferred
      comment: "Whether biosimilars are preferred — key cost management dimension; biosimilar preference drives significant pharmacy cost savings."
    - name: "rx_benefit_config_status"
      expr: rx_benefit_config_status
      comment: "Lifecycle status of the pharmacy benefit configuration — used to filter active vs. historical configurations."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the pharmacy benefit — used for compliance reporting and regulatory segmentation."
  measures:
    - name: "total_active_rx_configs"
      expr: COUNT(CASE WHEN is_active = TRUE THEN rx_benefit_config_id END)
      comment: "Count of active pharmacy benefit configurations — baseline inventory KPI for pharmacy benefit governance."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average pharmacy coinsurance rate — measures member share of drug costs; used in pharmacy benefit design benchmarking and affordability analysis."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average pharmacy deductible amount — measures member drug cost burden before coverage kicks in; used in benefit design and affordability analysis."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average pharmacy out-of-pocket maximum — measures member financial protection ceiling for drug costs; used in ACA compliance and benefit design review."
    - name: "avg_coverage_limit_per_year"
      expr: AVG(CAST(coverage_limit_per_year AS DOUBLE))
      comment: "Average annual pharmacy coverage limit — measures drug benefit ceiling; used in benefit adequacy and actuarial liability analysis."
    - name: "avg_coverage_limit_per_prescription"
      expr: AVG(CAST(coverage_limit_per_prescription AS DOUBLE))
      comment: "Average per-prescription coverage limit — measures per-fill benefit ceiling; used in pharmacy benefit design and member cost analysis."
    - name: "avg_max_coverage_amount"
      expr: AVG(CAST(max_coverage_amount AS DOUBLE))
      comment: "Average maximum pharmacy coverage amount — measures total drug benefit ceiling; used in actuarial liability and benefit adequacy analysis."
    - name: "biosimilar_preferred_config_count"
      expr: COUNT(CASE WHEN is_biosimilar_preferred = TRUE AND is_active = TRUE THEN rx_benefit_config_id END)
      comment: "Count of active configs with biosimilar preference — tracks biosimilar adoption in formulary design; biosimilar preference is a key pharmacy cost reduction lever."
    - name: "step_therapy_config_count"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE AND is_active = TRUE THEN rx_benefit_config_id END)
      comment: "Count of active configs requiring step therapy — measures utilization management stringency for drug benefits; used by pharmacy and clinical teams."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for geographic service area coverage and regulatory compliance — tracking coverage footprint, market eligibility, regulatory approval status, and geographic expansion. Used by market strategy, compliance, and regulatory teams."
  source: "`vibe_health_insurance_v1`.`plan`.`service_area`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State of the service area — primary geographic dimension for market coverage and regulatory analysis."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area (County, ZIP, State, Region) — used to analyze coverage granularity and geographic design."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type within the service area — used to segment service area analysis by coverage category."
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category associated with the service area — used to analyze geographic coverage by plan type."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the service area — enables year-over-year geographic expansion and contraction analysis."
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange market type (Federal, State) — used to segment service area analysis by marketplace type."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the service area — critical compliance dimension; unapproved areas trigger regulatory action."
    - name: "is_medicaid_eligible"
      expr: is_medicaid_eligible
      comment: "Whether the service area is Medicaid-eligible — used to track Medicaid market coverage footprint."
    - name: "is_medicare_eligible"
      expr: is_medicare_eligible
      comment: "Whether the service area is Medicare-eligible — used to track Medicare Advantage market coverage footprint."
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Whether the service area meets regulatory compliance requirements — critical compliance monitoring dimension."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the service area (Active, Pending, Terminated) — used to filter operational vs. historical service areas."
  measures:
    - name: "total_active_service_areas"
      expr: COUNT(CASE WHEN is_active = TRUE THEN service_area_id END)
      comment: "Count of active service areas — baseline geographic footprint KPI; used by market strategy teams to track coverage expansion and contraction."
    - name: "regulatory_compliant_area_count"
      expr: COUNT(CASE WHEN is_regulatory_compliant = TRUE AND is_active = TRUE THEN service_area_id END)
      comment: "Count of active service areas meeting regulatory compliance — critical compliance KPI; any decline triggers immediate regulatory review and remediation."
    - name: "non_compliant_area_count"
      expr: COUNT(CASE WHEN is_regulatory_compliant = FALSE AND is_active = TRUE THEN service_area_id END)
      comment: "Count of active service areas failing regulatory compliance — risk KPI; non-zero values require immediate compliance intervention to avoid regulatory penalties."
    - name: "medicaid_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicaid_eligible = TRUE AND is_active = TRUE THEN service_area_id END)
      comment: "Count of active Medicaid-eligible service areas — tracks Medicaid market coverage footprint; used in government programs strategy."
    - name: "medicare_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicare_eligible = TRUE AND is_active = TRUE THEN service_area_id END)
      comment: "Count of active Medicare-eligible service areas — tracks Medicare Advantage market coverage footprint; used in senior market strategy."
    - name: "exclusive_service_area_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE AND is_active = TRUE THEN service_area_id END)
      comment: "Count of active exclusive service areas — measures geographic exclusivity of plan offerings; used in competitive market strategy."
    - name: "federally_funded_area_count"
      expr: COUNT(CASE WHEN is_federal_funded = TRUE AND is_active = TRUE THEN service_area_id END)
      comment: "Count of active federally funded service areas — tracks federal program coverage footprint; used in government programs financial planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_network_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for network configuration design and out-of-network cost exposure — covering network adequacy, out-of-network cost-sharing, and geographic network coverage. Used by network strategy, actuarial, and compliance teams to manage network design and regulatory adequacy standards."
  source: "`vibe_health_insurance_v1`.`plan`.`network_config`"
  dimensions:
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation (Preferred, Standard, Tiered) — primary segmentation for network design analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier — used to analyze cost-sharing and access design across network tiers."
    - name: "network_coverage_type"
      expr: network_coverage_type
      comment: "Type of network coverage (HMO, PPO, EPO) — used to segment network configuration analysis by delivery model."
    - name: "network_state"
      expr: network_state
      comment: "State of the network configuration — geographic dimension for network adequacy and coverage analysis."
    - name: "access_type"
      expr: access_type
      comment: "Network access type (Open, Restricted, Gated) — used to analyze member access design across network configurations."
    - name: "out_of_network_coverage_flag"
      expr: out_of_network_coverage_flag
      comment: "Whether out-of-network coverage is provided — key benefit design dimension for network adequacy and member access analysis."
    - name: "network_exclusion_flag"
      expr: network_exclusion_flag
      comment: "Whether network exclusions apply — used to track network restriction practices and member access limitations."
    - name: "network_config_status"
      expr: network_config_status
      comment: "Lifecycle status of the network configuration — used to filter active vs. historical configurations."
    - name: "network_adequacy_measure"
      expr: network_adequacy_measure
      comment: "Network adequacy measure type — used to segment network adequacy analysis by regulatory standard."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year of network configuration effective start — enables year-over-year network design trend analysis."
  measures:
    - name: "total_active_network_configs"
      expr: COUNT(CASE WHEN is_active = TRUE THEN network_config_id END)
      comment: "Count of active network configurations — baseline network design inventory KPI used to track network configuration breadth across plans."
    - name: "avg_out_of_network_coinsurance_pct"
      expr: AVG(CAST(out_of_network_coinsurance_pct AS DOUBLE))
      comment: "Average out-of-network coinsurance percentage — measures member cost penalty for out-of-network use; used in network steerage strategy and benefit design analysis."
    - name: "avg_out_of_network_copay_amount"
      expr: AVG(CAST(out_of_network_copay_amount AS DOUBLE))
      comment: "Average out-of-network copay amount — measures member out-of-network access cost; used in network adequacy and benefit design strategy."
    - name: "out_of_network_coverage_count"
      expr: COUNT(CASE WHEN out_of_network_coverage_flag = TRUE AND is_active = TRUE THEN network_config_id END)
      comment: "Count of active network configurations providing out-of-network coverage — tracks OON benefit availability; used in network adequacy and member access strategy."
    - name: "network_exclusion_count"
      expr: COUNT(CASE WHEN network_exclusion_flag = TRUE AND is_active = TRUE THEN network_config_id END)
      comment: "Count of active network configurations with exclusions — measures network restriction scope; used by network strategy and compliance teams to assess access limitations."
$$;