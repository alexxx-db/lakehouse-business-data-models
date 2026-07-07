-- Metric views for domain: plan | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit design analytics — coverage richness, cost-sharing levels, authorization requirements, and regulatory classification. Used by Product, Compliance, and Actuarial teams to manage benefit portfolio and ensure regulatory adherence."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit`"
  dimensions:
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category (Medical, Pharmacy, Behavioral Health, etc.) for benefit portfolio segmentation."
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the benefit (Active, Inactive, Pending) for lifecycle monitoring."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (In-Network, Out-of-Network, Emergency) for network benefit analysis."
    - name: "ehb_classification"
      expr: ehb_classification
      comment: "Essential Health Benefit classification for ACA compliance reporting."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Flag indicating whether prior authorization is required for this benefit."
    - name: "cost_sharing_type"
      expr: cost_sharing_type
      comment: "Type of cost sharing applied (Copay, Coinsurance, Deductible) for benefit design analysis."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the benefit for compliance segmentation."
    - name: "preventive_service_flag"
      expr: preventive_service_flag
      comment: "Flag for preventive services (ACA-mandated zero cost-sharing) for compliance monitoring."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether the benefit is mandated by regulation."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year benefit design trend analysis."
    - name: "tier"
      expr: tier
      comment: "Benefit tier for tiered benefit structure analysis."
    - name: "benefit_group"
      expr: benefit_group
      comment: "Benefit group for grouping related benefits in portfolio analysis."
  measures:
    - name: "total_active_benefits"
      expr: COUNT(CASE WHEN is_active = TRUE THEN benefit_id END)
      comment: "Count of active benefits in the plan portfolio. Product leadership uses this to track benefit breadth and coverage completeness."
    - name: "avg_cost_sharing_amount"
      expr: AVG(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Average cost-sharing amount across benefits. Actuarial uses this to benchmark member financial exposure and plan affordability."
    - name: "avg_cost_sharing_percent"
      expr: AVG(CAST(cost_sharing_percent AS DOUBLE))
      comment: "Average cost-sharing percentage across benefits. Used alongside cost_sharing_amount to assess coinsurance burden."
    - name: "avg_oop_max_amount"
      expr: AVG(CAST(oop_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum across benefits. Key member financial protection metric for ACA compliance and product design."
    - name: "avg_moop_max_amount"
      expr: AVG(CAST(moop_max_amount AS DOUBLE))
      comment: "Average maximum out-of-pocket maximum across benefits. Used by Actuarial to assess aggregate member financial exposure."
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average benefit limit value. Product and Actuarial use this to assess coverage caps and their impact on member adequacy."
    - name: "prior_auth_required_benefit_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN benefit_id END)
      comment: "Count of benefits requiring prior authorization. UM and Medical Management use this to size authorization workload and identify access barriers."
    - name: "preventive_benefit_count"
      expr: COUNT(CASE WHEN preventive_service_flag = TRUE THEN benefit_id END)
      comment: "Count of preventive service benefits. Compliance uses this to verify ACA zero-cost-sharing mandates are met."
    - name: "mandatory_benefit_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN benefit_id END)
      comment: "Count of mandated benefits. Compliance and Legal use this to track regulatory mandate coverage obligations."
    - name: "wellness_mandate_benefit_count"
      expr: COUNT(CASE WHEN wellness_mandate_flag = TRUE THEN benefit_id END)
      comment: "Count of benefits subject to wellness mandates. Used by Compliance to ensure wellness program regulatory requirements are met."
    - name: "exempt_benefit_count"
      expr: COUNT(CASE WHEN is_exempt = TRUE THEN benefit_id END)
      comment: "Count of benefits exempt from standard requirements. Compliance uses this to track exemption scope and associated regulatory risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit package design analytics — actuarial value, cost-sharing structure, and package competitiveness. Used by Actuarial, Product, and Finance to evaluate plan design richness and pricing adequacy."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit_package`"
  dimensions:
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum) for benefit richness segmentation."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO) for product mix analysis."
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation (In-Network, Out-of-Network) for network benefit analysis."
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Current status of the benefit package for lifecycle monitoring."
    - name: "deductible_type"
      expr: deductible_type
      comment: "Deductible type (Embedded, Aggregate) for cost-sharing structure analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering live vs. inactive benefit packages."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Flag indicating whether prior authorization is required across the package."
    - name: "generic_substitution_required"
      expr: generic_substitution_required
      comment: "Flag indicating whether generic drug substitution is required — pharmacy cost management indicator."
  measures:
    - name: "total_active_packages"
      expr: COUNT(CASE WHEN is_active = TRUE THEN benefit_package_id END)
      comment: "Count of active benefit packages. Product leadership uses this to track the breadth of plan offerings in the market."
    - name: "avg_actuarial_value_pct"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage across packages. Core ACA compliance and pricing metric — must meet metal tier thresholds (60/70/80/90%)."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible across benefit packages. Actuarial uses this to benchmark member cost exposure and plan competitiveness."
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible across benefit packages. Used to assess family coverage affordability and market competitiveness."
    - name: "avg_oop_max_individual"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum. ACA compliance KPI — must not exceed IRS annual limits."
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Used by Actuarial and Product to assess family financial protection adequacy."
    - name: "avg_copay_primary_care"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay across packages. Access and affordability KPI — high copays create barriers to preventive care."
    - name: "avg_copay_specialist"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay across packages. Used to assess specialist access barriers and benefit design competitiveness."
    - name: "avg_coinsurance_inpatient"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance rate. Actuarial uses this to model inpatient cost-sharing exposure and reserve adequacy."
    - name: "avg_coinsurance_outpatient"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance rate. Used alongside inpatient coinsurance to assess overall member cost-sharing burden."
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay. Pharmacy management KPI for specialty drug cost-sharing design."
    - name: "avg_retail_copay_generic"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail generic drug copay. Pharmacy cost management KPI — generic utilization drives formulary savings."
    - name: "avg_retail_copay_brand"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail brand drug copay. Used alongside generic copay to assess brand-to-generic cost differential and formulary incentive design."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-sharing rule analytics — deductible, coinsurance, and copay rule design across plan benefits. Used by Actuarial and Product to ensure cost-sharing rules are correctly structured, compliant, and competitively positioned."
  source: "`vibe_health_insurance_v1`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost-sharing rule (Deductible, Copay, Coinsurance, OOP Max) for rule portfolio analysis."
    - name: "cost_share_category"
      expr: cost_share_category
      comment: "Cost-sharing category for grouping rules by benefit area."
    - name: "network_type"
      expr: network_type
      comment: "Network type (In-Network, Out-of-Network) for network-specific cost-sharing analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier for tiered cost-sharing structure analysis."
    - name: "cost_share_rule_status"
      expr: cost_share_rule_status
      comment: "Current status of the cost-sharing rule for lifecycle monitoring."
    - name: "after_deductible"
      expr: after_deductible
      comment: "Flag indicating whether cost-sharing applies after the deductible is met."
    - name: "hsa_compatible"
      expr: hsa_compatible
      comment: "Flag indicating HSA compatibility — critical for HDHP plan design compliance."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification for compliance segmentation."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering live vs. inactive cost-sharing rules."
    - name: "is_default_rule"
      expr: is_default_rule
      comment: "Flag indicating whether this is the default cost-sharing rule for the benefit."
  measures:
    - name: "total_active_rules"
      expr: COUNT(CASE WHEN is_active = TRUE THEN cost_share_rule_id END)
      comment: "Count of active cost-sharing rules. Product and Actuarial use this to track rule complexity and benefit design governance."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across cost-sharing rules. Actuarial uses this to benchmark member cost exposure and plan design adequacy."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across rules. Product uses this to assess member point-of-service cost burden."
    - name: "avg_copay_out_of_network"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay amount. Used to assess out-of-network cost differential and network steerage incentives."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate across rules. Actuarial uses this to model member cost-sharing exposure in claims projections."
    - name: "avg_coinsurance_out_of_network"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate. Used to quantify out-of-network financial penalty and network steerage effectiveness."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average out-of-pocket maximum across rules. ACA compliance KPI — must not exceed federal annual limits."
    - name: "avg_max_benefit_amount"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount across rules. Used to assess benefit cap adequacy and catastrophic coverage exposure."
    - name: "hsa_compatible_rule_count"
      expr: COUNT(CASE WHEN hsa_compatible = TRUE THEN cost_share_rule_id END)
      comment: "Count of HSA-compatible cost-sharing rules. Finance and Product use this to track HDHP/HSA plan design compliance."
    - name: "prior_to_deductible_rule_count"
      expr: COUNT(CASE WHEN prior_to_deductible = TRUE THEN cost_share_rule_id END)
      comment: "Count of rules applying cost-sharing prior to deductible. Used to identify first-dollar coverage rules and their financial impact."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for health plan portfolio management — premium economics, risk adjustment, cost-sharing design, and plan lifecycle status. Used by Product, Actuarial, and Finance leadership to steer plan design and pricing decisions."
  source: "`vibe_health_insurance_v1`.`plan`.`health_plan`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, etc.) for segmenting plan performance."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) for plan portfolio analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO, HDHP, etc.) for product mix analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the plan (Active, Terminated, Pending) for operational monitoring."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year trend analysis."
    - name: "plan_state"
      expr: plan_state
      comment: "State where the plan is offered for geographic performance analysis."
    - name: "plan_category"
      expr: plan_category
      comment: "ACA metal tier or plan category (Bronze, Silver, Gold, Platinum) for benefit richness segmentation."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the plan for compliance reporting segmentation."
    - name: "plan_marketplace_eligible"
      expr: plan_marketplace_eligible
      comment: "Flag indicating whether the plan is eligible for marketplace/exchange offering."
    - name: "plan_aca_compliant"
      expr: plan_aca_compliant
      comment: "Flag indicating ACA compliance status for regulatory segmentation."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering live vs. inactive plans."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation for plan-network relationship analysis."
  measures:
    - name: "total_active_plans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN health_plan_id END)
      comment: "Count of currently active health plans. Executives use this to track portfolio size and market presence."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible across plans. Actuarial and Product teams use this to benchmark cost-sharing design competitiveness."
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible across plans. Used alongside individual deductible to assess family coverage affordability."
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum. Key ACA compliance metric and member financial protection indicator."
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Used by Product leadership to assess family plan affordability."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount across plans. Core pricing KPI used by Actuarial and Finance to monitor premium adequacy."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor (RAF) across plans. Used by Actuarial to assess risk pool quality and CMS payment accuracy."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC risk score across plans. Drives risk adjustment revenue projections and population health strategy."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans. Used by Product to benchmark member cost-sharing levels."
    - name: "avg_copay_primary_care"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay across plans. Key benefit design metric for access and affordability analysis."
    - name: "avg_copay_specialist"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay across plans. Used to assess specialist access barriers and benefit competitiveness."
    - name: "marketplace_eligible_plan_count"
      expr: COUNT(CASE WHEN plan_marketplace_eligible = TRUE THEN health_plan_id END)
      comment: "Count of plans eligible for marketplace/exchange offering. Tracks exchange market footprint for strategic growth decisions."
    - name: "aca_compliant_plan_count"
      expr: COUNT(CASE WHEN plan_aca_compliant = TRUE THEN health_plan_id END)
      comment: "Count of ACA-compliant plans. Regulatory compliance KPI monitored by Compliance and Legal leadership."
    - name: "mlr_exempt_plan_count"
      expr: COUNT(CASE WHEN is_exempt_from_mlr = TRUE THEN health_plan_id END)
      comment: "Count of plans exempt from MLR requirements. Finance uses this to identify plans outside standard MLR rebate obligations."
    - name: "distinct_states_offered"
      expr: COUNT(DISTINCT plan_state)
      comment: "Number of distinct states where plans are offered. Geographic footprint KPI for market expansion strategy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_hsa_hra_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSA/HRA account configuration analytics — contribution limits, employer contributions, and IRS compliance. Used by Finance, Benefits, and Compliance to manage tax-advantaged account design and IRS regulatory adherence."
  source: "`vibe_health_insurance_v1`.`plan`.`hsa_hra_config`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Account type (HSA, HRA, FSA) for tax-advantaged account portfolio segmentation."
    - name: "hsa_hra_config_status"
      expr: hsa_hra_config_status
      comment: "Current status of the HSA/HRA configuration for lifecycle monitoring."
    - name: "contribution_method"
      expr: contribution_method
      comment: "Contribution method (Payroll Deduction, Direct) for contribution mechanics analysis."
    - name: "contribution_source"
      expr: contribution_source
      comment: "Contribution source (Employer, Employee, Both) for contribution structure analysis."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Contribution frequency (Annual, Monthly, Per-Paycheck) for cash flow analysis."
    - name: "rollover_allowed"
      expr: rollover_allowed
      comment: "Flag indicating whether account balance rollover is allowed — member financial planning indicator."
    - name: "catch_up_contribution_eligible"
      expr: catch_up_contribution_eligible
      comment: "Flag indicating catch-up contribution eligibility (age 55+) for IRS compliance analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating IRS/regulatory compliance for the account configuration."
    - name: "eligibility_hdpp"
      expr: eligibility_hdpp
      comment: "Flag indicating HDHP eligibility requirement for HSA — IRS compliance indicator."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. inactive HSA/HRA configurations."
  measures:
    - name: "total_active_configs"
      expr: COUNT(CASE WHEN is_active = TRUE THEN hsa_hra_config_id END)
      comment: "Count of active HSA/HRA configurations. Benefits and Finance use this to track tax-advantaged account program scope."
    - name: "avg_contribution_limit_amount"
      expr: AVG(CAST(contribution_limit_amount AS DOUBLE))
      comment: "Average contribution limit amount. Finance uses this to verify IRS annual contribution limits are correctly configured."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount. Finance uses this to project employer HSA/HRA funding costs and assess benefit generosity."
    - name: "avg_employee_contribution_limit"
      expr: AVG(CAST(employee_contribution_limit AS DOUBLE))
      comment: "Average employee contribution limit. Benefits uses this to assess employee savings capacity and plan design competitiveness."
    - name: "avg_irs_minimum_deductible"
      expr: AVG(CAST(irs_minimum_deductible AS DOUBLE))
      comment: "Average IRS minimum deductible configured. Compliance uses this to verify HDHP minimum deductible thresholds are met for HSA eligibility."
    - name: "avg_irs_oop_max"
      expr: AVG(CAST(irs_out_of_pocket_max AS DOUBLE))
      comment: "Average IRS out-of-pocket maximum configured. Compliance uses this to verify HDHP OOP max limits are within IRS thresholds."
    - name: "avg_rollover_limit_amount"
      expr: AVG(CAST(rollover_limit_amount AS DOUBLE))
      comment: "Average rollover limit amount for accounts with rollover allowed. Finance uses this to project carryover liability and account balance management."
    - name: "avg_catch_up_contribution_amount"
      expr: AVG(CAST(catch_up_contribution_amount AS DOUBLE))
      comment: "Average catch-up contribution amount for eligible members. Finance uses this to project additional funding for age-55+ population."
    - name: "regulatory_compliant_config_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN hsa_hra_config_id END)
      comment: "Count of IRS/regulatory compliant HSA/HRA configurations. Compliance uses this to verify all active accounts meet regulatory requirements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_network_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan network configuration analytics — network adequacy, out-of-network coverage, and network tier design. Used by Network Management, Product, and Compliance to monitor network adequacy standards and out-of-network benefit design."
  source: "`vibe_health_insurance_v1`.`plan`.`network_config`"
  dimensions:
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation (Preferred, Standard, Narrow) for network tier analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for tiered network benefit design analysis."
    - name: "network_coverage_type"
      expr: network_coverage_type
      comment: "Network coverage type for benefit-network intersection analysis."
    - name: "network_state"
      expr: network_state
      comment: "State for geographic network adequacy analysis."
    - name: "network_config_status"
      expr: network_config_status
      comment: "Current status of the network configuration for lifecycle monitoring."
    - name: "out_of_network_coverage_flag"
      expr: out_of_network_coverage_flag
      comment: "Flag indicating whether out-of-network coverage is provided — benefit design and member access indicator."
    - name: "network_exclusion_flag"
      expr: network_exclusion_flag
      comment: "Flag indicating network exclusions for compliance and access analysis."
    - name: "access_type"
      expr: access_type
      comment: "Access type (Open Access, Gatekeeper, PCP Required) for network access model analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. inactive network configurations."
  measures:
    - name: "total_active_network_configs"
      expr: COUNT(CASE WHEN is_active = TRUE THEN network_config_id END)
      comment: "Count of active network configurations. Network Management uses this to track plan-network relationship complexity."
    - name: "out_of_network_coverage_count"
      expr: COUNT(CASE WHEN out_of_network_coverage_flag = TRUE THEN network_config_id END)
      comment: "Count of network configurations with out-of-network coverage. Product uses this to track OON benefit availability across the plan portfolio."
    - name: "avg_out_of_network_coinsurance_pct"
      expr: AVG(CAST(out_of_network_coinsurance_pct AS DOUBLE))
      comment: "Average out-of-network coinsurance percentage. Used to assess OON cost differential and network steerage incentive strength."
    - name: "avg_out_of_network_copay_amount"
      expr: AVG(CAST(out_of_network_copay_amount AS DOUBLE))
      comment: "Average out-of-network copay amount. Used alongside OON coinsurance to assess total OON financial penalty and network steerage effectiveness."
    - name: "network_exclusion_count"
      expr: COUNT(CASE WHEN network_exclusion_flag = TRUE THEN network_config_id END)
      comment: "Count of network configurations with exclusions. Compliance uses this to track exclusion scope and associated member access risk."
    - name: "distinct_states_configured"
      expr: COUNT(DISTINCT network_state)
      comment: "Number of distinct states with network configurations. Network Management uses this to track geographic network coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer group plan offering analytics — contribution levels, offering types, and enrollment windows. Used by Sales, Account Management, and Finance to track employer group plan penetration and contribution economics."
  source: "`vibe_health_insurance_v1`.`plan`.`offering`"
  dimensions:
    - name: "offering_type"
      expr: offering_type
      comment: "Type of plan offering (Fully Insured, Self-Funded, Level-Funded) for product mix analysis."
    - name: "offering_status"
      expr: offering_status
      comment: "Current status of the offering (Active, Terminated, Pending) for lifecycle monitoring."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Contribution type (Fixed, Percentage) for employer contribution structure analysis."
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier (Employee Only, Employee+Spouse, Family) for tiered contribution analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. inactive offerings."
  measures:
    - name: "total_active_offerings"
      expr: COUNT(CASE WHEN is_active = TRUE THEN offering_id END)
      comment: "Count of active plan offerings. Sales and Account Management use this to track employer group plan penetration."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount per offering. Finance and Account Management use this to benchmark employer contribution levels and assess plan affordability."
    - name: "avg_employer_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage. Used to assess employer cost-sharing generosity and competitive positioning."
    - name: "avg_employee_contribution_amount"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount. HR and Benefits teams use this to assess employee premium burden and plan affordability."
    - name: "avg_family_contribution_amount"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family contribution amount. Used to assess family coverage affordability and employer contribution generosity for dependents."
    - name: "distinct_employer_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with active plan offerings. Sales KPI for employer group market penetration."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan amendment tracking metrics for change management and regulatory compliance analysis"
  source: "`vibe_health_insurance_v1`.`plan`.`plan_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of plan amendment"
    - name: "plan_amendment_status"
      expr: plan_amendment_status
      comment: "Amendment approval status"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for amendment"
    - name: "effective_year"
      expr: effective_year
      comment: "Year amendment becomes effective"
    - name: "compliance_flag"
      expr: CASE WHEN compliance_flag = TRUE THEN 'Compliant' ELSE 'Non-Compliant' END
      comment: "Compliance indicator"
    - name: "member_notification_required_flag"
      expr: CASE WHEN member_notification_required = TRUE THEN 'Notification Required' ELSE 'No Notification' END
      comment: "Member notification requirement"
    - name: "triggers_sbc_flag"
      expr: CASE WHEN triggers_sbc_generation = TRUE THEN 'SBC Required' ELSE 'No SBC' END
      comment: "SBC generation trigger"
  measures:
    - name: "total_amendments"
      expr: COUNT(DISTINCT plan_amendment_id)
      comment: "Total number of plan amendments"
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Average estimated cost impact of amendments"
    - name: "avg_estimated_member_cost_impact"
      expr: AVG(CAST(impact_estimated_member_cost AS DOUBLE))
      comment: "Average estimated member cost impact"
    - name: "avg_estimated_provider_cost_impact"
      expr: AVG(CAST(impact_estimated_provider_cost AS DOUBLE))
      comment: "Average estimated provider cost impact"
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Total estimated cost impact across all amendments"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan regulatory obligation tracking metrics for compliance monitoring and audit readiness"
  source: "`vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current obligation status"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority imposing obligation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body"
    - name: "regulator"
      expr: regulator
      comment: "Regulator name"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of obligation"
    - name: "filing_frequency"
      expr: filing_frequency
      comment: "Required filing frequency"
    - name: "review_frequency"
      expr: review_frequency
      comment: "Required review frequency"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for compliance"
    - name: "obligation_year"
      expr: YEAR(effective_date)
      comment: "Year obligation became effective"
  measures:
    - name: "total_regulatory_obligations"
      expr: COUNT(DISTINCT plan_regulatory_obligation_id)
      comment: "Total number of regulatory obligations"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts assessed"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per obligation"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service area analytics — geographic coverage, regulatory compliance, and market eligibility by plan. Used by Network, Regulatory Affairs, and Product to manage geographic footprint, adequacy compliance, and market expansion."
  source: "`vibe_health_insurance_v1`.`plan`.`plan_service_area`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State for geographic service area analysis and regulatory jurisdiction tracking."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Service area type (County, ZIP, State) for geographic granularity analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type for the service area for benefit-geographic intersection analysis."
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category for the service area for product-geographic analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year service area expansion/contraction analysis."
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Flag indicating regulatory compliance for the service area — network adequacy and geographic access compliance."
    - name: "is_medicaid_eligible"
      expr: is_medicaid_eligible
      comment: "Flag indicating Medicaid eligibility for the service area for government program footprint analysis."
    - name: "is_medicare_eligible"
      expr: is_medicare_eligible
      comment: "Flag indicating Medicare eligibility for the service area for Medicare Advantage footprint analysis."
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange market type (Federal, State) for marketplace participation analysis."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the service area for filing compliance monitoring."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. historical service areas."
    - name: "network_type"
      expr: network_type
      comment: "Network type for the service area for network-geographic analysis."
  measures:
    - name: "total_active_service_areas"
      expr: COUNT(CASE WHEN is_active = TRUE THEN plan_service_area_id END)
      comment: "Count of active service areas. Network and Product leadership use this to track geographic market footprint."
    - name: "distinct_states_covered"
      expr: COUNT(DISTINCT state)
      comment: "Number of distinct states with active service areas. Geographic expansion KPI for market strategy and regulatory licensing."
    - name: "regulatory_compliant_area_count"
      expr: COUNT(CASE WHEN is_regulatory_compliant = TRUE THEN plan_service_area_id END)
      comment: "Count of service areas meeting regulatory compliance requirements. Compliance uses this to track network adequacy and geographic access compliance."
    - name: "non_compliant_area_count"
      expr: COUNT(CASE WHEN is_regulatory_compliant = FALSE THEN plan_service_area_id END)
      comment: "Count of service areas failing regulatory compliance. Compliance and Network use this to prioritize remediation and avoid regulatory penalties."
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_compliant = TRUE THEN plan_service_area_id END) / NULLIF(COUNT(plan_service_area_id), 0), 2)
      comment: "Percentage of service areas meeting regulatory compliance. Executive KPI for network adequacy and regulatory risk management."
    - name: "medicaid_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicaid_eligible = TRUE THEN plan_service_area_id END)
      comment: "Count of Medicaid-eligible service areas. Government Programs uses this to track Medicaid market footprint and expansion opportunities."
    - name: "medicare_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicare_eligible = TRUE THEN plan_service_area_id END)
      comment: "Count of Medicare-eligible service areas. Medicare Advantage team uses this to track MA market footprint."
    - name: "exchange_market_area_count"
      expr: COUNT(CASE WHEN exchange_market IS NOT NULL THEN plan_service_area_id END)
      comment: "Count of service areas participating in exchange markets. Marketplace team uses this to track exchange footprint and APTC eligibility scope."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_program_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program coverage analytics — care management program benefit coverage, cost-sharing waivers, and enrollment capacity. Used by Care Management, Product, and Compliance to track program benefit design and regulatory mandate fulfillment."
  source: "`vibe_health_insurance_v1`.`plan`.`program_coverage`"
  dimensions:
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type for the program (Medical, Behavioral, Pharmacy) for program benefit segmentation."
    - name: "coverage_status_code"
      expr: coverage_status_code
      comment: "Current coverage status code for lifecycle monitoring."
    - name: "coverage_category"
      expr: coverage_category
      comment: "Coverage category for grouping program benefits by type."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (Individual, Family) for member-level benefit analysis."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Flag indicating whether the program coverage is mandated by regulation."
    - name: "copay_waiver_flag"
      expr: copay_waiver_flag
      comment: "Flag indicating whether copay is waived for this program — care management incentive design."
    - name: "authorization_required_flag"
      expr: authorization_required_flag
      comment: "Flag indicating whether authorization is required for program services."
    - name: "auto_enrollment_flag"
      expr: auto_enrollment_flag
      comment: "Flag indicating automatic enrollment in the program — population health management indicator."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the program coverage (Federal, State, Commercial) for financial accountability."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. inactive program coverages."
  measures:
    - name: "total_active_program_coverages"
      expr: COUNT(CASE WHEN is_active = TRUE THEN program_coverage_id END)
      comment: "Count of active program coverage configurations. Care Management and Product use this to track program benefit breadth."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount for program services. Used to assess member cost barriers to care management program participation."
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_pct AS DOUBLE))
      comment: "Average coinsurance percentage for program coverage. Actuarial uses this to model program cost-sharing exposure."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount for program coverage. Used to assess deductible barriers to program service utilization."
    - name: "avg_coverage_limit_amount"
      expr: AVG(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Average coverage limit amount for program benefits. Product uses this to assess benefit cap adequacy for care management programs."
    - name: "avg_annual_limit_amount"
      expr: AVG(CAST(annual_limit_amount AS DOUBLE))
      comment: "Average annual benefit limit for program coverage. Actuarial uses this to model annual program cost exposure."
    - name: "copay_waiver_coverage_count"
      expr: COUNT(CASE WHEN copay_waiver_flag = TRUE THEN program_coverage_id END)
      comment: "Count of program coverages with copay waiver. Care Management uses this to track incentive design for high-value program participation."
    - name: "regulatory_mandate_coverage_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN program_coverage_id END)
      comment: "Count of mandated program coverages. Compliance uses this to verify all regulatory program coverage obligations are met."
    - name: "auto_enrollment_coverage_count"
      expr: COUNT(CASE WHEN auto_enrollment_flag = TRUE THEN program_coverage_id END)
      comment: "Count of program coverages with auto-enrollment. Population Health uses this to assess automatic program engagement reach."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate analytics — base rates, age-rated premiums, surcharges, and rate filing status. Used by Actuarial, Finance, and Regulatory Affairs to monitor premium adequacy, rate filing compliance, and pricing competitiveness."
  source: "`vibe_health_insurance_v1`.`plan`.`rate`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) for rate portfolio segmentation."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year rate trend analysis."
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Rating area code for geographic rate variation analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate (Active, Filed, Approved, Rejected) for rate filing lifecycle monitoring."
    - name: "premium_type"
      expr: premium_type
      comment: "Premium type (Base, Age-Rated, Tobacco-Surcharged) for rate component analysis."
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier (Employee Only, Employee+Spouse, Family) for tier-based rate analysis."
    - name: "underwriting_class_code"
      expr: underwriting_class_code
      comment: "Underwriting class for risk-segmented rate analysis."
    - name: "is_tobacco_surcharge_applicable"
      expr: is_tobacco_surcharge_applicable
      comment: "Flag indicating tobacco surcharge applicability for ACA tobacco rating compliance."
    - name: "regulatory_filing_type"
      expr: regulatory_filing_type
      comment: "Type of regulatory filing (Prior Approval, File and Use) for rate filing compliance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. historical rates."
  measures:
    - name: "total_active_rates"
      expr: COUNT(CASE WHEN is_active = TRUE THEN rate_id END)
      comment: "Count of active rate records. Actuarial and Finance use this to track rate portfolio size and filing completeness."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base premium rate. Core pricing KPI used by Actuarial to monitor rate adequacy and competitive positioning."
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium. Used by Actuarial to assess age-rating curve adequacy and ACA 3:1 age-rating compliance."
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium. Finance uses this to project family coverage revenue and assess family rate competitiveness."
    - name: "avg_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average tobacco surcharge amount. Actuarial uses this to assess tobacco surcharge revenue contribution and ACA compliance."
    - name: "tobacco_surcharge_rate_count"
      expr: COUNT(CASE WHEN is_tobacco_surcharge_applicable = TRUE THEN rate_id END)
      comment: "Count of rates with tobacco surcharge applied. Compliance uses this to verify tobacco rating is applied consistently per ACA rules."
    - name: "distinct_rating_areas"
      expr: COUNT(DISTINCT rating_area_code)
      comment: "Number of distinct rating areas covered. Geographic footprint KPI for market expansion and rate filing completeness."
    - name: "max_base_rate"
      expr: MAX(CAST(base_rate AS DOUBLE))
      comment: "Maximum base rate in the portfolio. Used by Actuarial to identify rate outliers and assess premium ceiling exposure."
    - name: "min_base_rate"
      expr: MIN(CAST(base_rate AS DOUBLE))
      comment: "Minimum base rate in the portfolio. Used alongside max to assess rate spread and competitive floor pricing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_regulatory_obligation_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan regulatory obligation compliance analytics — obligation status, attestation timelines, and penalty exposure. Used by Compliance, Legal, and Regulatory Affairs to monitor plan-level regulatory obligation fulfillment and manage compliance risk."
  source: "`vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (Reporting, Filing, Attestation) for compliance portfolio segmentation."
    - name: "obligation_status_code"
      expr: obligation_status_code
      comment: "Current compliance status code for obligation lifecycle monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status for the obligation for executive compliance dashboard."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority (CMS, State DOI, NCQA) for jurisdiction-specific compliance analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction for geographic compliance analysis."
    - name: "filing_frequency"
      expr: filing_frequency
      comment: "Filing frequency (Annual, Quarterly, Monthly) for compliance workload planning."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. historical obligation links."
  measures:
    - name: "total_active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN regulatory_obligation_link_id END)
      comment: "Count of active regulatory obligations linked to plans. Compliance uses this to track total obligation workload."
    - name: "compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN regulatory_obligation_link_id END)
      comment: "Count of obligations in compliant status. Executive compliance KPI for regulatory risk management."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN regulatory_obligation_link_id END)
      comment: "Count of non-compliant obligations. Compliance and Legal use this to prioritize remediation and assess regulatory penalty exposure."
    - name: "obligation_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN regulatory_obligation_link_id END) / NULLIF(COUNT(regulatory_obligation_link_id), 0), 2)
      comment: "Percentage of regulatory obligations in compliant status. Board-level compliance KPI for regulatory risk governance."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across non-compliant obligations. Finance and Legal use this to quantify regulatory penalty exposure and reserve requirements."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per obligation. Used to benchmark per-obligation regulatory risk and prioritize high-penalty remediation."
    - name: "distinct_regulatory_authorities"
      expr: COUNT(DISTINCT regulatory_authority)
      comment: "Number of distinct regulatory authorities with active obligations. Compliance uses this to assess multi-regulator complexity and resource allocation."
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with active regulatory obligations. Legal uses this to track multi-state compliance footprint."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rx_benefit_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy benefit configuration analytics — formulary design, cost-sharing, and specialty drug management. Used by Pharmacy, Actuarial, and Product to manage Rx benefit design, formulary compliance, and specialty drug cost controls."
  source: "`vibe_health_insurance_v1`.`plan`.`rx_benefit_config`"
  dimensions:
    - name: "rx_benefit_config_status"
      expr: rx_benefit_config_status
      comment: "Current status of the Rx benefit configuration for lifecycle monitoring."
    - name: "cost_sharing_method"
      expr: cost_sharing_method
      comment: "Cost-sharing method (Copay, Coinsurance, Tiered) for Rx benefit design analysis."
    - name: "mail_order_network_type"
      expr: mail_order_network_type
      comment: "Mail order network type for mail-order vs. retail pharmacy benefit analysis."
    - name: "retail_network_type"
      expr: retail_network_type
      comment: "Retail network type for retail pharmacy benefit analysis."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Flag indicating step therapy requirement — drug utilization management indicator."
    - name: "is_specialty_drug_excluded"
      expr: is_specialty_drug_excluded
      comment: "Flag indicating specialty drug exclusion for specialty drug cost management analysis."
    - name: "is_biologic_preferred"
      expr: is_biologic_preferred
      comment: "Flag indicating biologic drug preference for formulary design analysis."
    - name: "is_biosimilar_preferred"
      expr: is_biosimilar_preferred
      comment: "Flag indicating biosimilar preference — cost management and formulary strategy indicator."
    - name: "ninety_day_supply_allowed"
      expr: ninety_day_supply_allowed
      comment: "Flag indicating 90-day supply allowance for medication adherence and cost management analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. inactive Rx benefit configurations."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification for the Rx benefit configuration for compliance segmentation."
  measures:
    - name: "total_active_rx_configs"
      expr: COUNT(CASE WHEN is_active = TRUE THEN rx_benefit_config_id END)
      comment: "Count of active Rx benefit configurations. Pharmacy and Product use this to track formulary program scope."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average Rx coinsurance rate. Actuarial uses this to model pharmacy cost-sharing exposure in claims projections."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average Rx deductible amount. Used to assess pharmacy deductible burden and its impact on medication adherence."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average Rx out-of-pocket maximum. ACA compliance KPI — Rx OOP must be integrated with medical OOP for combined limit compliance."
    - name: "avg_coverage_limit_per_year"
      expr: AVG(CAST(coverage_limit_per_year AS DOUBLE))
      comment: "Average annual Rx coverage limit. Actuarial uses this to assess annual pharmacy benefit cap exposure."
    - name: "avg_max_coverage_amount"
      expr: AVG(CAST(max_coverage_amount AS DOUBLE))
      comment: "Average maximum Rx coverage amount. Used to assess lifetime/annual pharmacy benefit adequacy."
    - name: "step_therapy_config_count"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE THEN rx_benefit_config_id END)
      comment: "Count of Rx configs with step therapy required. Pharmacy Management uses this to track step therapy program scope and drug utilization management reach."
    - name: "biosimilar_preferred_config_count"
      expr: COUNT(CASE WHEN is_biosimilar_preferred = TRUE THEN rx_benefit_config_id END)
      comment: "Count of Rx configs preferring biosimilars. Pharmacy uses this to track biosimilar adoption strategy and associated cost savings potential."
    - name: "specialty_drug_excluded_count"
      expr: COUNT(CASE WHEN is_specialty_drug_excluded = TRUE THEN rx_benefit_config_id END)
      comment: "Count of Rx configs excluding specialty drugs. Finance and Pharmacy use this to track specialty drug cost containment strategy scope."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_sbc_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Summary of Benefits and Coverage (SBC) document analytics — document currency, regulatory submission status, and version management. Used by Compliance and Regulatory Affairs to ensure SBC obligations are met per ACA requirements."
  source: "`vibe_health_insurance_v1`.`plan`.`sbc_document`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Document type for SBC portfolio segmentation."
    - name: "sbc_document_status"
      expr: sbc_document_status
      comment: "Current status of the SBC document (Draft, Final, Submitted, Approved) for lifecycle monitoring."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Regulatory submission status for ACA SBC filing compliance monitoring."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year SBC compliance analysis."
    - name: "language"
      expr: language
      comment: "Language of the SBC document for member communication accessibility analysis."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating whether this is the current version of the SBC document."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. historical SBC documents."
  measures:
    - name: "total_active_sbc_documents"
      expr: COUNT(CASE WHEN is_active = TRUE THEN sbc_document_id END)
      comment: "Count of active SBC documents. Compliance uses this to verify SBC coverage across all active plans."
    - name: "current_version_sbc_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN sbc_document_id END)
      comment: "Count of current-version SBC documents. Regulatory Affairs uses this to ensure members have access to the most current SBC."
    - name: "submitted_sbc_count"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'Submitted' THEN sbc_document_id END)
      comment: "Count of SBC documents submitted to regulators. Compliance uses this to track ACA SBC filing obligation fulfillment."
    - name: "avg_document_size_bytes"
      expr: AVG(CAST(document_size_bytes AS DOUBLE))
      comment: "Average SBC document size in bytes. Operations uses this to monitor document management storage and delivery infrastructure needs."
    - name: "distinct_languages_covered"
      expr: COUNT(DISTINCT language)
      comment: "Number of distinct languages in which SBCs are available. Compliance uses this to verify language access obligations under ACA and state mandates."
    - name: "distinct_plans_with_sbc"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans with at least one SBC document. Compliance uses this to identify plans missing required SBC documentation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission analytics — filing status, fees, timelines, and approval rates. Used by Regulatory Affairs, Finance, and Compliance to manage plan filing obligations, track approval rates, and monitor filing fee economics."
  source: "`vibe_health_insurance_v1`.`plan`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (Rate Filing, Form Filing, Network Filing) for submission portfolio analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (Pending, Approved, Rejected, Withdrawn) for filing lifecycle monitoring."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission (CMS, State DOI) for jurisdiction-specific compliance analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for the submission for product-specific filing analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year submission trend analysis."
    - name: "is_annual_filing"
      expr: is_annual_filing
      comment: "Flag indicating whether this is an annual filing for distinguishing routine vs. ad-hoc submissions."
    - name: "submitter_role"
      expr: submitter_role
      comment: "Role of the submitter for accountability and workflow analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. historical submissions."
  measures:
    - name: "total_submissions"
      expr: COUNT(submission_id)
      comment: "Total count of regulatory submissions. Regulatory Affairs uses this to track filing volume and workload."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN submission_id END)
      comment: "Count of approved submissions. Regulatory Affairs uses this to track approval rate and filing quality."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN submission_id END)
      comment: "Count of rejected submissions. Compliance uses this to identify filing quality issues and remediation needs."
    - name: "submission_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Approved' THEN submission_id END) / NULLIF(COUNT(submission_id), 0), 2)
      comment: "Percentage of submissions approved. Executive KPI for regulatory filing quality and relationship management with regulators."
    - name: "total_filing_fee_gross"
      expr: SUM(CAST(filing_fee_gross AS DOUBLE))
      comment: "Total gross filing fees across submissions. Finance uses this to track regulatory filing cost burden."
    - name: "total_filing_fee_net"
      expr: SUM(CAST(filing_fee_net AS DOUBLE))
      comment: "Total net filing fees after adjustments. Finance uses this for accurate regulatory cost accounting."
    - name: "avg_filing_fee_net"
      expr: AVG(CAST(filing_fee_net AS DOUBLE))
      comment: "Average net filing fee per submission. Finance uses this to benchmark per-filing regulatory cost and budget for future filings."
    - name: "total_filing_fee_adjustment"
      expr: SUM(CAST(filing_fee_adjustment AS DOUBLE))
      comment: "Total filing fee adjustments. Finance uses this to track fee credits, waivers, and corrections in regulatory cost management."
    - name: "withdrawn_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Withdrawn' THEN submission_id END)
      comment: "Count of withdrawn submissions. Regulatory Affairs uses this to track filing strategy changes and associated rework costs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_year`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan year lifecycle analytics — budget, premium rates, enrollment windows, and regulatory filing status. Used by Finance, Actuarial, and Operations to manage annual plan year transitions and budget performance."
  source: "`vibe_health_insurance_v1`.`plan`.`year`"
  dimensions:
    - name: "plan_year_code"
      expr: plan_year_code
      comment: "Plan year code for year-over-year comparison and trend analysis."
    - name: "plan_year_type"
      expr: plan_year_type
      comment: "Plan year type (Calendar, Non-Calendar) for plan year structure analysis."
    - name: "plan_year_market_segment"
      expr: plan_year_market_segment
      comment: "Market segment for the plan year for segmented budget and enrollment analysis."
    - name: "plan_year_state"
      expr: plan_year_state
      comment: "State for the plan year for geographic budget and enrollment analysis."
    - name: "year_status"
      expr: year_status
      comment: "Current status of the plan year (Active, Closed, Pending) for lifecycle monitoring."
    - name: "aca_compliance_indicator"
      expr: aca_compliance_indicator
      comment: "ACA compliance indicator for the plan year — regulatory compliance segmentation."
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Flag indicating whether regulatory filing is required for this plan year."
    - name: "plan_year_regulatory_classification"
      expr: plan_year_regulatory_classification
      comment: "Regulatory classification for the plan year for compliance reporting."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current vs. historical plan years."
  measures:
    - name: "total_active_plan_years"
      expr: COUNT(CASE WHEN is_active = TRUE THEN year_id END)
      comment: "Count of active plan years. Operations uses this to track concurrent plan year management complexity."
    - name: "total_plan_year_budget"
      expr: SUM(CAST(plan_year_budget_amount AS DOUBLE))
      comment: "Total budgeted amount across plan years. Finance uses this as the top-line budget KPI for annual financial planning."
    - name: "avg_plan_year_budget"
      expr: AVG(CAST(plan_year_budget_amount AS DOUBLE))
      comment: "Average plan year budget amount. Finance uses this to benchmark per-plan-year investment and identify budget outliers."
    - name: "avg_plan_year_premium_rate"
      expr: AVG(CAST(plan_year_premium_rate AS DOUBLE))
      comment: "Average premium rate for the plan year. Actuarial uses this to track year-over-year premium trend and rate adequacy."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required = TRUE THEN year_id END)
      comment: "Count of plan years requiring regulatory filing. Regulatory Affairs uses this to manage filing workload and compliance deadlines."
    - name: "aca_compliant_year_count"
      expr: COUNT(CASE WHEN aca_compliance_indicator = TRUE THEN year_id END)
      comment: "Count of ACA-compliant plan years. Compliance uses this to verify annual ACA adherence across the plan portfolio."
$$;
