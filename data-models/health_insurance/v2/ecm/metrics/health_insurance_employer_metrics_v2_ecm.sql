-- Metric views for domain: employer | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_aso_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASO fee schedule KPIs — tracks administrative services fee levels, billing structures, and participation thresholds to manage ASO revenue and self-funded group economics."
  source: "`vibe_health_insurance_v1`.`employer`.`aso_fee_schedule`"
  dimensions:
    - name: "aso_fee_schedule_status"
      expr: aso_fee_schedule_status
      comment: "Current status of the ASO fee schedule (active, expired, pending) for revenue portfolio monitoring."
    - name: "component_type"
      expr: component_type
      comment: "ASO fee component type (claims admin, eligibility, reporting) for fee structure analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly) for cash-flow and revenue recognition analysis."
    - name: "cap_type"
      expr: cap_type
      comment: "Fee cap type (per-member, aggregate) for revenue ceiling and risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency ASO revenue reporting."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether the ASO fee is taxable — affects net revenue and tax compliance reporting."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Fee schedule effective start date truncated to month for revenue timeline analysis."
  measures:
    - name: "total_aso_fee_schedules"
      expr: COUNT(DISTINCT aso_fee_schedule_id)
      comment: "Total ASO fee schedules in force — measures ASO revenue contract portfolio size."
    - name: "active_aso_fee_schedules"
      expr: COUNT(DISTINCT CASE WHEN aso_fee_schedule_status = 'active' THEN aso_fee_schedule_id END)
      comment: "Count of active ASO fee schedules — measures current ASO revenue-generating contracts."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pm_per_member_rate AS DOUBLE))
      comment: "Average per-member-per-month ASO fee rate — core ASO revenue pricing KPI for competitive benchmarking."
    - name: "total_cap_amount"
      expr: SUM(CAST(cap_amount AS DOUBLE))
      comment: "Total fee cap amount across all schedules — measures maximum ASO revenue ceiling and financial planning boundary."
    - name: "avg_cap_amount"
      expr: AVG(CAST(cap_amount AS DOUBLE))
      comment: "Average fee cap per schedule — benchmarks ASO fee ceiling levels across the self-funded portfolio."
    - name: "avg_minimum_participation_percent"
      expr: AVG(CAST(minimum_participation_percent AS DOUBLE))
      comment: "Average minimum participation percentage required for ASO fee eligibility — measures enrollment threshold risk."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to ASO fees — measures tax burden on ASO revenue for net revenue planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker channel performance KPIs — tracks broker portfolio size, commission economics, renewal health, and status to steer distribution strategy and broker relationship management."
  source: "`vibe_health_insurance_v1`.`employer`.`broker`"
  dimensions:
    - name: "broker_status"
      expr: broker_status
      comment: "Current broker status (active, terminated, suspended) for channel health monitoring."
    - name: "broker_type"
      expr: broker_type
      comment: "Broker type (independent, captive, GA, MAPD) for distribution channel segmentation."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Broker contract renewal status for channel retention and pipeline management."
    - name: "region"
      expr: region
      comment: "Geographic region for regional distribution performance analysis."
    - name: "state"
      expr: state
      comment: "State of broker operation for regulatory licensing and market coverage analysis."
    - name: "commission_start_date"
      expr: DATE_TRUNC('month', commission_start_date)
      comment: "Commission start date truncated to month for commission accrual and payment timing analysis."
    - name: "renewal_date"
      expr: DATE_TRUNC('month', renewal_date)
      comment: "Broker contract renewal date truncated to month for channel retention pipeline management."
  measures:
    - name: "total_brokers"
      expr: COUNT(DISTINCT broker_id)
      comment: "Total brokers in the distribution network — measures channel breadth and market reach."
    - name: "active_brokers"
      expr: COUNT(DISTINCT CASE WHEN broker_status = 'active' THEN broker_id END)
      comment: "Count of active brokers — measures effective distribution channel size for sales capacity planning."
    - name: "broker_active_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN broker_status = 'active' THEN broker_id END) / NULLIF(COUNT(DISTINCT broker_id), 0), 2)
      comment: "Percentage of brokers currently active — measures distribution channel health and attrition."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission amount paid to brokers — measures distribution cost and channel investment."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average broker commission rate — benchmarks distribution cost efficiency and competitive positioning."
    - name: "avg_broker_rating"
      expr: AVG(CAST(rating AS DOUBLE))
      comment: "Average broker performance rating — measures distribution channel quality for partner management decisions."
    - name: "brokers_up_for_renewal"
      expr: COUNT(DISTINCT CASE WHEN renewal_status = 'pending' THEN broker_id END)
      comment: "Count of brokers with pending contract renewal — measures near-term channel retention risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker assignment and commission metrics tracking broker relationships and compensation"
  source: "`vibe_health_insurance_v1`.`employer`.`broker_assignment`"
  dimensions:
    - name: "broker_assignment_status"
      expr: broker_assignment_status
      comment: "Status of the broker assignment"
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission structure"
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation"
    - name: "is_primary_broker"
      expr: CASE WHEN is_primary = TRUE THEN 'Primary' ELSE 'Secondary' END
      comment: "Whether this is the primary broker assignment"
    - name: "assignment_year"
      expr: YEAR(effective_start_date)
      comment: "Year the assignment became effective"
  measures:
    - name: "Total Broker Assignments"
      expr: COUNT(DISTINCT broker_assignment_id)
      comment: "Total number of broker assignments"
    - name: "Unique Brokers Assigned"
      expr: COUNT(DISTINCT broker_id)
      comment: "Number of distinct brokers with assignments"
    - name: "Unique Groups with Brokers"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct groups with broker assignments"
    - name: "Average Commission Rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across all assignments"
    - name: "Primary Broker Assignment Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_primary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT broker_assignment_id), 0), 2)
      comment: "Percentage of assignments that are primary broker relationships"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_contribution_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer contribution strategy KPIs — tracks contribution levels, affordability compliance, HSA/HRA seeding, and tax treatment to steer benefit design and ACA compliance."
  source: "`vibe_health_insurance_v1`.`employer`.`contribution_strategy`"
  dimensions:
    - name: "contribution_strategy_status"
      expr: contribution_strategy_status
      comment: "Status of the contribution strategy (active, inactive, pending) for portfolio monitoring."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (flat dollar, percentage of premium) for benefit design benchmarking."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Contribution payment frequency (monthly, bi-weekly) for cash-flow and payroll integration analysis."
    - name: "affordability_test_flag"
      expr: affordability_test_flag
      comment: "Whether ACA affordability test was applied — critical compliance dimension for employer mandate reporting."
    - name: "is_pre_tax"
      expr: is_pre_tax
      comment: "Whether contributions are pre-tax — affects employee net cost and tax compliance reporting."
    - name: "is_post_tax"
      expr: is_post_tax
      comment: "Whether contributions are post-tax — identifies non-standard tax treatment for compliance review."
    - name: "tax_credit_eligible"
      expr: tax_credit_eligible
      comment: "Whether the strategy qualifies for small business tax credits — measures SHOP marketplace eligibility."
    - name: "tier_code"
      expr: tier_code
      comment: "Coverage tier code (EE, ES, EC, EF) for contribution level analysis by family composition."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Strategy effective start date truncated to month for contribution change trend analysis."
  measures:
    - name: "total_contribution_strategies"
      expr: COUNT(DISTINCT contribution_strategy_id)
      comment: "Total contribution strategies defined — measures benefit design complexity and customization breadth."
    - name: "avg_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution dollar amount — benchmarks employer generosity and benefit competitiveness."
    - name: "avg_contribution_percentage"
      expr: AVG(CAST(contribution_percentage AS DOUBLE))
      comment: "Average employer contribution percentage of premium — key ACA affordability and competitiveness KPI."
    - name: "avg_employer_contribution_cap"
      expr: AVG(CAST(employer_contribution_cap AS DOUBLE))
      comment: "Average employer contribution cap — measures maximum employer liability per strategy for financial planning."
    - name: "total_hra_employer_seed"
      expr: SUM(CAST(hra_employer_seed_amount AS DOUBLE))
      comment: "Total HRA employer seed funding committed — measures HRA program financial investment and consumer-directed health strategy."
    - name: "total_hsa_employer_seed"
      expr: SUM(CAST(hsa_employer_seed_amount AS DOUBLE))
      comment: "Total HSA employer seed funding committed — measures HSA adoption investment and tax-advantaged benefit strategy."
    - name: "avg_minimum_employee_contribution"
      expr: AVG(CAST(minimum_employee_contribution AS DOUBLE))
      comment: "Average minimum employee contribution — measures employee cost floor for affordability compliance monitoring."
    - name: "avg_maximum_employee_contribution"
      expr: AVG(CAST(maximum_employee_contribution AS DOUBLE))
      comment: "Average maximum employee contribution — measures employee cost ceiling and benefit affordability risk."
    - name: "tax_credit_eligible_strategy_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN tax_credit_eligible = TRUE THEN contribution_strategy_id END) / NULLIF(COUNT(DISTINCT contribution_strategy_id), 0), 2)
      comment: "Percentage of contribution strategies eligible for small business tax credits — measures SHOP marketplace participation opportunity."
    - name: "affordability_compliant_strategy_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN affordability_test_flag = TRUE THEN contribution_strategy_id END) / NULLIF(COUNT(DISTINCT contribution_strategy_id), 0), 2)
      comment: "Percentage of strategies with affordability test applied — measures ACA employer mandate compliance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer contract metrics tracking contract portfolio value and status for vendor and group relationship management."
  source: "`vibe_health_insurance_v1`.`employer`.`employer_contract`"
  dimensions:
    - name: "employer_contract_status"
      expr: employer_contract_status
      comment: "Current status of the employer contract"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "annual_review_month"
      expr: MONTH(annual_review_date)
      comment: "Month of annual contract review"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of employer contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all employer contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value across all employer contracts"
    - name: "distinct_groups_under_contract"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with active contracts"
    - name: "distinct_vendors_contracted"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with employer contracts"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for employer group portfolio management — enrollment counts, risk profile, renewal health, and financial exposure across the employer book of business."
  source: "`vibe_health_insurance_v1`.`employer`.`group`"
  dimensions:
    - name: "group_status"
      expr: group_status
      comment: "Current lifecycle status of the employer group (active, terminated, pending, etc.) for portfolio segmentation."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (small group, large group, jumbo, etc.) for competitive and actuarial analysis."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement type (fully-insured, self-funded, level-funded) — key driver of revenue and risk exposure."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare Advantage, Medicaid) for product-line performance segmentation."
    - name: "size_tier"
      expr: size_tier
      comment: "Employer size tier (micro, small, mid, large) for underwriting and sales strategy segmentation."
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for regulatory and geographic performance analysis."
    - name: "industry_code"
      expr: industry_code
      comment: "Industry classification code (SIC/NAICS) for risk and loss-ratio benchmarking by industry."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA plan status flag — distinguishes ERISA-governed plans from non-ERISA for compliance reporting."
    - name: "renewal_date"
      expr: DATE_TRUNC('month', renewal_date)
      comment: "Renewal date truncated to month for pipeline and retention forecasting."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Group effective date truncated to month for cohort and vintage analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) for cash-flow and collections analysis."
    - name: "experience_rating_flag"
      expr: experience_rating_flag
      comment: "Whether the group is experience-rated — affects pricing and renewal strategy."
  measures:
    - name: "total_employer_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Total distinct employer groups in the portfolio — primary book-of-business size KPI for executive reporting."
    - name: "active_employer_groups"
      expr: COUNT(DISTINCT CASE WHEN group_status = 'active' THEN group_id END)
      comment: "Count of currently active employer groups — measures effective portfolio size and retention health."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across employer groups — signals overall portfolio risk profile and pricing adequacy."
    - name: "avg_average_claim_cost"
      expr: AVG(CAST(average_claim_cost AS DOUBLE))
      comment: "Average claim cost per employer group — key actuarial KPI for loss-ratio monitoring and renewal pricing."
    - name: "total_average_claim_cost"
      expr: SUM(CAST(average_claim_cost AS DOUBLE))
      comment: "Total aggregate average claim cost across all groups — used for portfolio-level financial exposure estimation."
    - name: "groups_with_wellness_program"
      expr: COUNT(DISTINCT CASE WHEN wellness_program_flag = TRUE THEN group_id END)
      comment: "Number of groups offering wellness programs — tracks wellness adoption rate as a cost-reduction and retention lever."
    - name: "wellness_program_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN wellness_program_flag = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT group_id), 0), 2)
      comment: "Percentage of employer groups with active wellness programs — executive KPI for population health strategy effectiveness."
    - name: "self_funded_group_count"
      expr: COUNT(DISTINCT CASE WHEN funding_arrangement = 'self-funded' THEN group_id END)
      comment: "Count of self-funded employer groups — critical for ASO revenue forecasting and stop-loss exposure management."
    - name: "auto_renewal_group_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN group_id END)
      comment: "Count of groups set to auto-renew — measures retention pipeline stability and reduces manual renewal workload."
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT group_id), 0), 2)
      comment: "Percentage of groups on auto-renewal — a leading indicator of retention and renewal operational efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan offering portfolio KPIs — measures benefit offering breadth, contribution levels, participation rates, and affordability compliance across employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`group_plan_offering`"
  dimensions:
    - name: "group_plan_offering_status"
      expr: group_plan_offering_status
      comment: "Status of the plan offering (active, terminated, pending) for portfolio health monitoring."
    - name: "offering_type"
      expr: offering_type
      comment: "Type of plan offering (medical, dental, vision, etc.) for product-line mix analysis."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Employer contribution type (flat dollar, percentage) for contribution strategy benchmarking."
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier (employee-only, employee+spouse, family) for benefit cost allocation analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year offering trend and affordability analysis."
    - name: "waiver_eligible"
      expr: waiver_eligible
      comment: "Whether waiver of coverage is permitted — affects participation rate calculations and ACA compliance."
    - name: "is_affordable"
      expr: is_affordable
      comment: "ACA affordability flag — critical compliance dimension for employer mandate reporting."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Offering effective date truncated to month for enrollment timing and open enrollment analysis."
    - name: "open_enrollment_start_date"
      expr: DATE_TRUNC('month', open_enrollment_start_date)
      comment: "Open enrollment start month for enrollment campaign planning and participation forecasting."
  measures:
    - name: "total_plan_offerings"
      expr: COUNT(DISTINCT group_plan_offering_id)
      comment: "Total plan offerings across all employer groups — measures benefit portfolio breadth and product distribution."
    - name: "active_plan_offerings"
      expr: COUNT(DISTINCT CASE WHEN group_plan_offering_status = 'active' THEN group_plan_offering_id END)
      comment: "Count of currently active plan offerings — measures live benefit portfolio size."
    - name: "affordable_offering_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_affordable = TRUE THEN group_plan_offering_id END) / NULLIF(COUNT(DISTINCT group_plan_offering_id), 0), 2)
      comment: "Percentage of plan offerings meeting ACA affordability standard — executive compliance KPI for employer mandate risk."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount per offering — benchmarks employer generosity and benefit competitiveness."
    - name: "avg_employee_contribution_amount"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount — measures employee cost burden and affordability risk."
    - name: "avg_family_contribution_amount"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family-tier contribution amount — tracks family coverage affordability and dependent enrollment drivers."
    - name: "avg_minimum_participation_percent"
      expr: AVG(CAST(minimum_participation_percent AS DOUBLE))
      comment: "Average minimum participation percentage required — benchmarks participation thresholds across the portfolio."
    - name: "avg_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage — key metric for benefit competitiveness benchmarking."
    - name: "total_hra_seed_amount"
      expr: SUM(CAST(hra_seed_amount AS DOUBLE))
      comment: "Total HRA seed funding committed across all offerings — measures HRA program financial exposure."
    - name: "total_hsa_seed_amount"
      expr: SUM(CAST(hsa_seed_amount AS DOUBLE))
      comment: "Total HSA seed funding committed — measures HSA program investment and consumer-directed health adoption."
    - name: "waiver_eligible_offering_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN waiver_eligible = TRUE THEN group_plan_offering_id END) / NULLIF(COUNT(DISTINCT group_plan_offering_id), 0), 2)
      comment: "Percentage of offerings allowing coverage waiver — affects participation rate benchmarks and ACA compliance calculations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewal pipeline and retention KPIs — tracks renewal outcomes, rate changes, compliance status, and retention drivers to steer account management and pricing strategy."
  source: "`vibe_health_insurance_v1`.`employer`.`group_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current renewal status (pending, completed, lapsed, cancelled) for pipeline stage tracking."
    - name: "retention_outcome"
      expr: retention_outcome
      comment: "Retention outcome (retained, lost, pending) — primary KPI dimension for account management performance."
    - name: "retention_reason_code"
      expr: retention_reason_code
      comment: "Reason code for retention outcome — identifies root causes of churn for strategic intervention."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement type at renewal — tracks shifts between fully-insured and self-funded as a revenue mix signal."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at renewal — flags groups with regulatory issues that may affect renewal eligibility."
    - name: "renewal_cycle_year"
      expr: renewal_cycle_year
      comment: "Renewal cycle year for year-over-year retention and rate-change trend analysis."
    - name: "renewal_effective_date"
      expr: DATE_TRUNC('month', renewal_effective_date)
      comment: "Renewal effective date truncated to month for pipeline timing and cash-flow forecasting."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA status at renewal for compliance segmentation."
    - name: "latest_amendment_type"
      expr: latest_amendment_type
      comment: "Type of most recent amendment — identifies benefit change patterns driving renewal complexity."
    - name: "participation_requirement_met"
      expr: participation_requirement_met
      comment: "Whether participation requirement was met — a key eligibility gate for renewal approval."
  measures:
    - name: "total_renewals"
      expr: COUNT(DISTINCT group_renewal_id)
      comment: "Total renewal cases in the pipeline — primary volume KPI for account management capacity planning."
    - name: "retained_groups"
      expr: COUNT(DISTINCT CASE WHEN retention_outcome = 'retained' THEN group_renewal_id END)
      comment: "Count of groups successfully retained at renewal — core retention performance KPI."
    - name: "lost_groups"
      expr: COUNT(DISTINCT CASE WHEN retention_outcome = 'lost' THEN group_renewal_id END)
      comment: "Count of groups lost at renewal — measures churn and revenue at risk."
    - name: "retention_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN retention_outcome = 'retained' THEN group_renewal_id END) / NULLIF(COUNT(DISTINCT group_renewal_id), 0), 2)
      comment: "Percentage of groups retained at renewal — executive KPI for account management effectiveness and revenue stability."
    - name: "avg_rate_change_percentage"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average premium rate change percentage at renewal — key pricing and competitiveness KPI for executive review."
    - name: "avg_prior_year_premium_rate"
      expr: AVG(CAST(premium_rate_prior_year AS DOUBLE))
      comment: "Average prior-year premium rate — baseline for renewal pricing trend analysis."
    - name: "avg_renewal_year_premium_rate"
      expr: AVG(CAST(premium_rate_renewal_year AS DOUBLE))
      comment: "Average renewal-year premium rate — measures pricing movement and revenue impact at renewal."
    - name: "renewals_with_amendment"
      expr: COUNT(DISTINCT CASE WHEN amendment_flag = TRUE THEN group_renewal_id END)
      comment: "Count of renewals requiring benefit amendments — measures renewal complexity and administrative burden."
    - name: "amendment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN amendment_flag = TRUE THEN group_renewal_id END) / NULLIF(COUNT(DISTINCT group_renewal_id), 0), 2)
      comment: "Percentage of renewals with amendments — signals benefit change frequency and renewal processing complexity."
    - name: "participation_requirement_met_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN participation_requirement_met = TRUE THEN group_renewal_id END) / NULLIF(COUNT(DISTINCT group_renewal_id), 0), 2)
      comment: "Percentage of renewals meeting participation requirements — tracks eligibility compliance and renewal approval risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_open_enrollment_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open enrollment window metrics tracking enrollment activity, participation rates, and enrollment window management effectiveness."
  source: "`vibe_health_insurance_v1`.`employer`.`open_enrollment_window`"
  dimensions:
    - name: "enrollment_window_status"
      expr: enrollment_window_status
      comment: "Current status of the enrollment window"
    - name: "enrollment_window_type"
      expr: enrollment_window_type
      comment: "Type of enrollment window (annual open enrollment, special enrollment, new hire, etc.)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage for the enrollment window"
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method of enrollment (online, paper, phone, etc.)"
    - name: "waiver_allowed"
      expr: CASE WHEN waiver_allowed = TRUE THEN 'Waiver Allowed' ELSE 'Waiver Not Allowed' END
      comment: "Whether waivers are permitted during this enrollment window"
    - name: "plan_selection_method"
      expr: plan_selection_method
      comment: "Method for plan selection during enrollment"
    - name: "enrollment_start_year"
      expr: YEAR(start_date)
      comment: "Year the enrollment window opens"
  measures:
    - name: "total_enrollment_windows"
      expr: COUNT(1)
      comment: "Total number of open enrollment windows"
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average participation rate across enrollment windows"
    - name: "distinct_groups_with_enrollment"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct groups with open enrollment windows"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_participation_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participation requirement metrics tracking compliance with minimum participation thresholds"
  source: "`vibe_health_insurance_v1`.`employer`.`participation_requirement`"
  dimensions:
    - name: "participation_requirement_status"
      expr: participation_requirement_status
      comment: "Status of the participation requirement"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status (met, not met, pending)"
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of participation requirement"
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement type"
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA status classification"
    - name: "group_size_tier"
      expr: group_size
      comment: "Group size tier"
    - name: "waiver_allowed"
      expr: CASE WHEN waiver_allowed = TRUE THEN 'Allowed' ELSE 'Not Allowed' END
      comment: "Whether waivers are allowed"
    - name: "measurement_period"
      expr: measurement_period
      comment: "Measurement period for participation"
  measures:
    - name: "Total Participation Requirements"
      expr: COUNT(DISTINCT participation_requirement_id)
      comment: "Total number of participation requirements"
    - name: "Unique Groups with Requirements"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct groups with participation requirements"
    - name: "Average Participation Percentage"
      expr: AVG(CAST(participation_percentage AS DOUBLE))
      comment: "Average actual participation percentage"
    - name: "Total Enrolled Headcount"
      expr: SUM(CAST(enrolled_headcount AS BIGINT))
      comment: "Total enrolled headcount across all requirements"
    - name: "Total Minimum Required Headcount"
      expr: SUM(CAST(minimum_enrolled_headcount AS BIGINT))
      comment: "Total minimum required headcount"
    - name: "Compliance Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'met' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT participation_requirement_id), 0), 2)
      comment: "Percentage of requirements in compliance"
    - name: "Average Waiver Percentage Allowed"
      expr: AVG(CAST(waiver_percentage_allowed AS DOUBLE))
      comment: "Average waiver percentage allowed"
    - name: "Waiver Allowed Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT participation_requirement_id), 0), 2)
      comment: "Percentage of requirements allowing waivers"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_rate_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and pricing KPIs — tracks quote volume, premium estimates, discount levels, and conversion by broker, group, and plan to steer sales strategy and pricing competitiveness."
  source: "`vibe_health_insurance_v1`.`employer`.`rate_quote`"
  dimensions:
    - name: "rate_quote_status"
      expr: rate_quote_status
      comment: "Quote lifecycle status (draft, issued, accepted, expired, declined) for sales funnel stage analysis."
    - name: "rating_methodology"
      expr: rating_methodology
      comment: "Rating methodology used (manual, experience, community) for pricing approach segmentation."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier quoted (employee-only, family, etc.) for benefit design and pricing analysis."
    - name: "group_type"
      expr: group_type
      comment: "Type of employer group (association, single employer, MEP) for market segment analysis."
    - name: "group_size"
      expr: group_size
      comment: "Group size band for underwriting and pricing tier analysis."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area for regional pricing performance analysis."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA status of the quoted group for compliance and product eligibility segmentation."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the quote for year-over-year pricing trend analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Quote effective date truncated to month for pipeline timing and revenue forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote for multi-currency portfolio reporting."
  measures:
    - name: "total_quotes_issued"
      expr: COUNT(DISTINCT rate_quote_id)
      comment: "Total rate quotes issued — primary sales pipeline volume KPI for capacity and conversion analysis."
    - name: "accepted_quotes"
      expr: COUNT(DISTINCT CASE WHEN rate_quote_status = 'accepted' THEN rate_quote_id END)
      comment: "Count of accepted quotes — measures sales conversion and new business generation."
    - name: "quote_acceptance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rate_quote_status = 'accepted' THEN rate_quote_id END) / NULLIF(COUNT(DISTINCT rate_quote_id), 0), 2)
      comment: "Percentage of quotes accepted — executive KPI for pricing competitiveness and sales effectiveness."
    - name: "total_gross_premium_estimate"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium across all quotes — measures total revenue potential in the sales pipeline."
    - name: "total_net_premium_estimate"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after discounts — measures net revenue potential and discount impact on pipeline value."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across quotes — tracks pricing concession levels and margin erosion risk."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate quoted — core pricing KPI for competitive benchmarking and actuarial review."
    - name: "avg_total_group_premium_estimate"
      expr: AVG(CAST(total_group_premium_estimate AS DOUBLE))
      comment: "Average total group premium estimate — benchmarks deal size for sales strategy and broker incentive planning."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per quote — measures pricing discipline and identifies segments with excessive concessions."
    - name: "expired_quote_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rate_quote_status = 'expired' THEN rate_quote_id END) / NULLIF(COUNT(DISTINCT rate_quote_id), 0), 2)
      comment: "Percentage of quotes that expired without decision — measures sales cycle efficiency and follow-up effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_regulatory_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer regulatory compliance KPIs — tracks compliance status, attestation timeliness, penalty exposure, and remediation activity to steer compliance program effectiveness."
  source: "`vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record`"
  dimensions:
    - name: "compliance_status_code"
      expr: compliance_status_code
      comment: "Compliance status code (compliant, non-compliant, remediation-in-progress) for regulatory risk segmentation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (ACA, ERISA, HIPAA, state) for compliance program coverage analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority (CMS, DOL, state DOI) for regulator-specific compliance performance reporting."
    - name: "record_type"
      expr: record_type
      comment: "Record type for compliance activity categorization and reporting."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required — flags non-compliant records requiring remediation."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Compliance due date truncated to month for deadline management and SLA monitoring."
    - name: "attestation_date"
      expr: DATE_TRUNC('month', attestation_date)
      comment: "Attestation date truncated to month for compliance cycle timing analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Obligation effective start date for compliance coverage period analysis."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(DISTINCT regulatory_compliance_record_id)
      comment: "Total regulatory compliance records — measures compliance program scope and obligation coverage."
    - name: "compliant_records"
      expr: COUNT(DISTINCT CASE WHEN compliance_status_code = 'compliant' THEN regulatory_compliance_record_id END)
      comment: "Count of compliant records — measures regulatory compliance achievement across the employer portfolio."
    - name: "non_compliant_records"
      expr: COUNT(DISTINCT CASE WHEN compliance_status_code = 'non-compliant' THEN regulatory_compliance_record_id END)
      comment: "Count of non-compliant records — measures regulatory risk exposure requiring executive attention."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status_code = 'compliant' THEN regulatory_compliance_record_id END) / NULLIF(COUNT(DISTINCT regulatory_compliance_record_id), 0), 2)
      comment: "Percentage of compliance records in compliant status — primary regulatory health KPI for executive and board reporting."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed — measures financial exposure from regulatory non-compliance."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per non-compliant record — benchmarks regulatory enforcement severity."
    - name: "records_requiring_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN regulatory_compliance_record_id END)
      comment: "Count of records requiring corrective action — measures remediation workload and compliance risk backlog."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN regulatory_compliance_record_id END) / NULLIF(COUNT(DISTINCT regulatory_compliance_record_id), 0), 2)
      comment: "Percentage of compliance records requiring corrective action — executive KPI for regulatory risk severity and remediation urgency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_stop_loss_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-loss risk management KPIs — tracks attachment points, premium levels, and policy status to manage catastrophic claims exposure for self-funded employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`stop_loss_policy`"
  dimensions:
    - name: "stop_loss_policy_status"
      expr: stop_loss_policy_status
      comment: "Current policy status (active, expired, cancelled) for portfolio risk exposure monitoring."
    - name: "policy_type"
      expr: policy_type
      comment: "Stop-loss policy type (specific, aggregate, combined) — determines risk coverage structure."
    - name: "attachment_point_type"
      expr: attachment_point_type
      comment: "Attachment point type (paid, incurred) — affects claims timing and reinsurance recovery calculations."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Stop-loss carrier name for counterparty concentration and vendor performance analysis."
    - name: "lasering_provision_flag"
      expr: lasering_provision_flag
      comment: "Whether lasering provision applies — flags high-risk members excluded from aggregate coverage."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Policy effective date truncated to month for coverage timeline and renewal pipeline analysis."
    - name: "renewal_date"
      expr: DATE_TRUNC('month', renewal_date)
      comment: "Policy renewal date truncated to month for stop-loss renewal pipeline management."
  measures:
    - name: "total_stop_loss_policies"
      expr: COUNT(DISTINCT stop_loss_policy_id)
      comment: "Total stop-loss policies in force — measures self-funded risk coverage portfolio size."
    - name: "active_stop_loss_policies"
      expr: COUNT(DISTINCT CASE WHEN stop_loss_policy_status = 'active' THEN stop_loss_policy_id END)
      comment: "Count of active stop-loss policies — measures current catastrophic risk coverage in force."
    - name: "avg_individual_attachment_point"
      expr: AVG(CAST(individual_attachment_point AS DOUBLE))
      comment: "Average specific/individual attachment point — benchmarks per-member catastrophic risk threshold across the portfolio."
    - name: "avg_aggregate_attachment_point"
      expr: AVG(CAST(aggregate_attachment_point AS DOUBLE))
      comment: "Average aggregate attachment point — measures total group catastrophic loss threshold and financial exposure."
    - name: "total_stop_loss_premium"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total stop-loss premium paid — measures reinsurance cost and its impact on self-funded group economics."
    - name: "avg_stop_loss_premium"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average stop-loss premium per policy — benchmarks reinsurance cost efficiency across the self-funded portfolio."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount — measures retained risk layer before stop-loss coverage activates."
    - name: "avg_claim_payment_limit"
      expr: AVG(CAST(claim_payment_limit AS DOUBLE))
      comment: "Average maximum claim payment limit — measures maximum reinsurance recovery per policy for financial planning."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to stop-loss pricing — signals portfolio risk loading trends."
    - name: "lasered_policy_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN lasering_provision_flag = TRUE THEN stop_loss_policy_id END) / NULLIF(COUNT(DISTINCT stop_loss_policy_id), 0), 2)
      comment: "Percentage of stop-loss policies with lasering provisions — measures high-risk member exclusion prevalence and coverage gap risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_tpa_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TPA arrangement metrics tracking third-party administrator costs, stop-loss coverage, and self-funded administration efficiency."
  source: "`vibe_health_insurance_v1`.`employer`.`tpa_arrangement`"
  dimensions:
    - name: "tpa_arrangement_status"
      expr: tpa_arrangement_status
      comment: "Current status of the TPA arrangement"
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of TPA arrangement (ASO, full service, etc.)"
    - name: "fee_schedule_type"
      expr: fee_schedule_type
      comment: "Type of fee schedule (PEPM, percentage, flat, etc.)"
    - name: "contribution_strategy"
      expr: contribution_strategy
      comment: "Contribution strategy associated with the TPA arrangement"
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA compliance status of the arrangement"
    - name: "stop_loss_coverage_scope"
      expr: stop_loss_coverage_scope
      comment: "Scope of stop-loss coverage (specific, aggregate, both)"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the TPA arrangement became effective"
  measures:
    - name: "total_tpa_arrangements"
      expr: COUNT(1)
      comment: "Total number of TPA arrangements"
    - name: "avg_fee_schedule_rate_pmpm"
      expr: AVG(CAST(fee_schedule_rate_pmpm AS DOUBLE))
      comment: "Average PEPM fee schedule rate across TPA arrangements"
    - name: "total_stop_loss_premium"
      expr: SUM(CAST(stop_loss_premium AS DOUBLE))
      comment: "Total stop-loss premium across all TPA arrangements"
    - name: "avg_individual_attachment_point"
      expr: AVG(CAST(stop_loss_individual_attachment_point AS DOUBLE))
      comment: "Average individual stop-loss attachment point across arrangements"
    - name: "avg_aggregate_deductible"
      expr: AVG(CAST(stop_loss_aggregate_deductible AS DOUBLE))
      comment: "Average aggregate stop-loss deductible across arrangements"
    - name: "avg_contribution_rate_pmpm"
      expr: AVG(CAST(contribution_rate_pmpm AS DOUBLE))
      comment: "Average contribution rate PMPM across TPA arrangements"
    - name: "total_fee_schedule_cap"
      expr: SUM(CAST(fee_schedule_cap_amount AS DOUBLE))
      comment: "Total fee schedule cap amounts across all arrangements"
    - name: "avg_stop_loss_laser_amount"
      expr: AVG(CAST(stop_loss_laser_amount AS DOUBLE))
      comment: "Average laser amount for high-risk individuals across arrangements"
    - name: "distinct_tpas"
      expr: COUNT(DISTINCT tpa_id)
      comment: "Number of distinct TPAs managing employer arrangements"
    - name: "distinct_groups_with_tpa"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with TPA arrangements"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting pipeline and pricing KPIs — tracks quote volume, conversion, premium estimates, and risk factors to steer underwriting strategy and sales effectiveness."
  source: "`vibe_health_insurance_v1`.`employer`.`underwriting_case`"
  dimensions:
    - name: "underwriting_status"
      expr: underwriting_status
      comment: "Current underwriting workflow status (submitted, in-review, approved, declined) for pipeline stage analysis."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Final underwriting decision (approved, declined, modified) — key outcome dimension for conversion analysis."
    - name: "quote_status"
      expr: quote_status
      comment: "Quote lifecycle status (draft, issued, accepted, expired) for sales funnel tracking."
    - name: "rating_methodology"
      expr: rating_methodology
      comment: "Rating methodology applied (manual, experience, blended) — affects pricing accuracy and competitive positioning."
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area code for regional pricing and market performance analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Assigned risk tier for the group — drives premium loading and stop-loss attachment decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the premium estimate for multi-currency portfolio reporting."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Effective start date truncated to month for cohort-based underwriting volume and conversion analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of case submission for pipeline velocity and throughput trending."
    - name: "manual_rate_basis"
      expr: manual_rate_basis
      comment: "Whether manual rate basis was applied — flags cases requiring actuarial override for quality review."
  measures:
    - name: "total_underwriting_cases"
      expr: COUNT(DISTINCT underwriting_case_id)
      comment: "Total underwriting cases submitted — primary pipeline volume KPI for sales and underwriting capacity planning."
    - name: "approved_cases"
      expr: COUNT(DISTINCT CASE WHEN underwriting_decision = 'approved' THEN underwriting_case_id END)
      comment: "Count of approved underwriting cases — measures underwriting throughput and approval rate."
    - name: "declined_cases"
      expr: COUNT(DISTINCT CASE WHEN underwriting_decision = 'declined' THEN underwriting_case_id END)
      comment: "Count of declined cases — tracks adverse selection risk and underwriting discipline."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN underwriting_decision = 'approved' THEN underwriting_case_id END) / NULLIF(COUNT(DISTINCT underwriting_case_id), 0), 2)
      comment: "Percentage of underwriting cases approved — executive KPI for underwriting selectivity and market competitiveness."
    - name: "total_premium_estimate"
      expr: SUM(CAST(total_premium_estimate AS DOUBLE))
      comment: "Total estimated premium across all underwriting cases — measures potential revenue in the pipeline."
    - name: "avg_premium_estimate"
      expr: AVG(CAST(total_premium_estimate AS DOUBLE))
      comment: "Average estimated premium per underwriting case — benchmarks deal size and pricing adequacy."
    - name: "avg_pmpm_estimate"
      expr: AVG(CAST(pmpm_estimate AS DOUBLE))
      comment: "Average per-member-per-month premium estimate — core actuarial pricing KPI for competitive benchmarking."
    - name: "avg_experience_rating_factor"
      expr: AVG(CAST(experience_rating_factor AS DOUBLE))
      comment: "Average experience rating factor applied — signals portfolio-wide claims experience trend and pricing pressure."
    - name: "avg_geographic_factor"
      expr: AVG(CAST(geographic_factor AS DOUBLE))
      comment: "Average geographic rating factor — measures regional cost variation impact on pricing."
    - name: "avg_age_gender_composite_factor"
      expr: AVG(CAST(age_gender_composite_factor AS DOUBLE))
      comment: "Average age/gender composite factor — tracks demographic risk loading across the underwriting pipeline."
    - name: "avg_aca_adjustment_factor"
      expr: AVG(CAST(aca_adjustment_factor AS DOUBLE))
      comment: "Average ACA adjustment factor — measures regulatory compliance cost loading in pricing."
    - name: "manual_rate_case_count"
      expr: COUNT(DISTINCT CASE WHEN manual_rate_basis = TRUE THEN underwriting_case_id END)
      comment: "Count of cases using manual rate basis — flags actuarial override volume for quality and consistency review."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_wellness_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wellness program metrics tracking participation, incentives, and program effectiveness"
  source: "`vibe_health_insurance_v1`.`employer`.`wellness_program`"
  dimensions:
    - name: "wellness_program_status"
      expr: wellness_program_status
      comment: "Current status of the wellness program"
    - name: "program_type"
      expr: program_type
      comment: "Type of wellness program"
    - name: "program_category"
      expr: program_category
      comment: "Category of wellness program"
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered"
    - name: "aca_compliance"
      expr: aca_compliance_classification
      comment: "ACA compliance classification"
    - name: "mandatory_flag"
      expr: CASE WHEN is_mandatory = TRUE THEN 'Mandatory' ELSE 'Voluntary' END
      comment: "Whether program participation is mandatory"
    - name: "tax_credit_eligible"
      expr: CASE WHEN is_eligible_for_tax_credit = TRUE THEN 'Eligible' ELSE 'Not Eligible' END
      comment: "Tax credit eligibility status"
    - name: "program_year"
      expr: program_effective_year
      comment: "Effective year of the program"
  measures:
    - name: "Total Wellness Programs"
      expr: COUNT(DISTINCT wellness_program_id)
      comment: "Total number of wellness programs"
    - name: "Total Current Participants"
      expr: SUM(CAST(current_participant_count AS BIGINT))
      comment: "Total current participants across all programs"
    - name: "Average Participation Rate"
      expr: AVG(CAST(program_actual_participation_pct AS DOUBLE))
      comment: "Average actual participation rate across programs"
    - name: "Average Target Participation Rate"
      expr: AVG(CAST(program_target_participation_pct AS DOUBLE))
      comment: "Average target participation rate"
    - name: "Total Program Budget"
      expr: SUM(CAST(program_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all wellness programs"
    - name: "Average Incentive Amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per program"
    - name: "Total Incentive Amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount across all programs"
    - name: "Average Risk Adjustment Factor"
      expr: AVG(CAST(program_risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for wellness programs"
    - name: "Participation Goal Achievement Rate"
      expr: ROUND(100.0 * AVG(CAST(program_actual_participation_pct AS DOUBLE) / NULLIF(CAST(program_target_participation_pct AS DOUBLE), 0)), 2)
      comment: "Average achievement rate of participation goals"
    - name: "Mandatory Program Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT wellness_program_id), 0), 2)
      comment: "Percentage of programs that are mandatory"
$$;
