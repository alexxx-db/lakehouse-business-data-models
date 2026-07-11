-- Metric views for domain: employer | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for employer group portfolio management — group size, risk profile, renewal health, and financial exposure across the employer book of business."
  source: "`vibe_health_insurance_v1`.`employer`.`group`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the employer group (e.g., small, mid, large) for portfolio segmentation."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement type (e.g., fully-insured, self-funded, level-funded) — key driver of risk and revenue model."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the group (e.g., commercial, Medicare Advantage)."
    - name: "size_tier"
      expr: size_tier
      comment: "Employer group size tier for segmentation and underwriting classification."
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for geographic and regulatory analysis."
    - name: "group_status"
      expr: group_status
      comment: "Current lifecycle status of the employer group (active, terminated, pending)."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA compliance status of the group — relevant for regulatory reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of group effective date for cohort and trend analysis."
    - name: "renewal_date_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month of group renewal date for pipeline and retention planning."
  measures:
    - name: "total_active_groups"
      expr: COUNT(CASE WHEN group_status = 'active' THEN group_id END)
      comment: "Count of active employer groups — primary book-of-business size indicator for executive dashboards."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across employer groups — signals overall portfolio risk profile and informs pricing strategy."
    - name: "avg_average_claim_cost"
      expr: AVG(CAST(average_claim_cost AS DOUBLE))
      comment: "Average claim cost per group — key underwriting and financial planning metric used to assess group-level medical cost trends."
    - name: "total_average_claim_cost"
      expr: SUM(CAST(average_claim_cost AS DOUBLE))
      comment: "Total aggregate average claim cost across all groups — used to size total medical cost exposure in the employer portfolio."
    - name: "groups_renewing_next_90_days"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN group_id END)
      comment: "Number of groups with renewal dates in the next 90 days — critical retention pipeline metric for account management and sales leadership."
    - name: "terminated_group_count"
      expr: COUNT(CASE WHEN group_status = 'terminated' THEN group_id END)
      comment: "Count of terminated employer groups — tracks attrition and informs retention strategy."
    - name: "self_funded_group_count"
      expr: COUNT(CASE WHEN funding_arrangement = 'self-funded' THEN group_id END)
      comment: "Count of self-funded employer groups — strategic metric for ASO revenue and stop-loss exposure management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for employer group plan offerings — participation rates, contribution economics, and affordability compliance across plan elections."
  source: "`vibe_health_insurance_v1`.`employer`.`group_plan_offering`"
  dimensions:
    - name: "offering_type"
      expr: offering_type
      comment: "Type of plan offering (e.g., medical, dental, vision) for benefit portfolio analysis."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Employer contribution type (flat dollar, percentage) — drives affordability and ACA compliance analysis."
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier (employee-only, employee+spouse, family) for cost-sharing analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year trend analysis of participation and contribution economics."
    - name: "group_plan_offering_status"
      expr: group_plan_offering_status
      comment: "Current status of the plan offering (active, terminated, pending)."
    - name: "is_affordable"
      expr: is_affordable
      comment: "ACA affordability flag — critical for compliance reporting and employer mandate tracking."
    - name: "waiver_eligible"
      expr: waiver_eligible
      comment: "Whether the offering allows waivers — relevant for participation rate analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the offering became effective — used for cohort and trend analysis."
  measures:
    - name: "total_active_offerings"
      expr: COUNT(CASE WHEN group_plan_offering_status = 'active' THEN group_plan_offering_id END)
      comment: "Count of active plan offerings across employer groups — measures breadth of benefit portfolio."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount per offering — benchmarks employer generosity and affordability compliance."
    - name: "avg_employee_contribution_amount"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount — measures employee cost burden and informs affordability analysis."
    - name: "avg_minimum_participation_percent"
      expr: AVG(CAST(minimum_participation_percent AS DOUBLE))
      comment: "Average minimum participation threshold required across offerings — used to assess risk of group non-compliance."
    - name: "affordable_offering_count"
      expr: COUNT(CASE WHEN is_affordable = TRUE THEN group_plan_offering_id END)
      comment: "Count of ACA-affordable plan offerings — directly tracks employer mandate compliance across the book of business."
    - name: "avg_family_contribution_amount"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family-tier contribution amount — informs total cost-of-coverage analysis for dependent coverage strategy."
    - name: "avg_hsa_seed_amount"
      expr: AVG(CAST(hsa_seed_amount AS DOUBLE))
      comment: "Average HSA employer seed contribution — tracks HDHP/HSA adoption and employer investment in consumer-directed health."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting pipeline and financial KPIs — quote conversion, premium estimates, and risk factor analysis for the employer underwriting book."
  source: "`vibe_health_insurance_v1`.`employer`.`employer_underwriting_case`"
  dimensions:
    - name: "underwriting_status"
      expr: underwriting_status
      comment: "Current underwriting workflow status (submitted, in-review, approved, declined) for pipeline tracking."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Final underwriting decision (approved, declined, modified) — key outcome metric for underwriting performance."
    - name: "quote_status"
      expr: quote_status
      comment: "Status of the associated rate quote — tracks conversion from quote to bound coverage."
    - name: "rating_methodology"
      expr: rating_methodology
      comment: "Rating methodology applied (experience-rated, manual-rated, blended) — affects pricing accuracy and risk selection."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the group — drives premium loading and stop-loss attachment points."
    - name: "manual_rate_basis"
      expr: manual_rate_basis
      comment: "Whether manual rate basis was applied — flags cases requiring actuarial review."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of premium estimates for multi-currency portfolio reporting."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of coverage effective start — used for cohort analysis of new business."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of case submission — tracks underwriting pipeline volume over time."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total underwriting cases submitted — measures new business pipeline volume."
    - name: "approved_case_count"
      expr: COUNT(CASE WHEN underwriting_decision = 'approved' THEN employer_underwriting_case_id END)
      comment: "Count of approved underwriting cases — primary conversion metric for underwriting performance."
    - name: "declined_case_count"
      expr: COUNT(CASE WHEN underwriting_decision = 'declined' THEN employer_underwriting_case_id END)
      comment: "Count of declined cases — tracks adverse selection risk and underwriting stringency."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN underwriting_decision = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of underwriting cases approved — key underwriting conversion KPI for executive reporting."
    - name: "avg_total_premium_estimate"
      expr: AVG(CAST(total_premium_estimate AS DOUBLE))
      comment: "Average total premium estimate per underwriting case — measures average deal size in the new business pipeline."
    - name: "total_premium_pipeline"
      expr: SUM(CAST(total_premium_estimate AS DOUBLE))
      comment: "Total premium estimate across all active underwriting cases — measures total new business revenue pipeline."
    - name: "avg_pmpm_estimate"
      expr: AVG(CAST(pmpm_estimate AS DOUBLE))
      comment: "Average per-member-per-month premium estimate — benchmarks pricing competitiveness and actuarial accuracy."
    - name: "avg_experience_rating_factor"
      expr: AVG(CAST(experience_rating_factor AS DOUBLE))
      comment: "Average experience rating factor applied — signals portfolio-level claims experience trend used in pricing."
    - name: "avg_geographic_factor"
      expr: AVG(CAST(geographic_factor AS DOUBLE))
      comment: "Average geographic risk factor — informs regional pricing strategy and market expansion decisions."
    - name: "avg_group_average_age"
      expr: AVG(CAST(group_average_age AS DOUBLE))
      comment: "Average group age across underwriting cases — key demographic risk indicator for actuarial pricing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_rate_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate quote pipeline KPIs — quote volume, premium economics, conversion, and discount analysis for employer sales and underwriting leadership."
  source: "`vibe_health_insurance_v1`.`employer`.`rate_quote`"
  dimensions:
    - name: "rate_quote_status"
      expr: rate_quote_status
      comment: "Current status of the rate quote (pending, issued, accepted, declined, expired) — tracks sales pipeline stage."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier of the quoted plan (employee-only, family, etc.) for cost-tier analysis."
    - name: "group_type"
      expr: group_type
      comment: "Type of employer group being quoted — used for market segment performance analysis."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area of the quote — enables regional pricing performance analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the quote — supports year-over-year pipeline comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quoted premium amounts."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA status of the quoted group — relevant for compliance and product eligibility."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of proposed coverage effective date — used for new business cohort analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month the quote was issued — tracks sales activity volume over time."
  measures:
    - name: "total_quotes_issued"
      expr: COUNT(1)
      comment: "Total rate quotes issued — measures sales pipeline activity volume."
    - name: "accepted_quote_count"
      expr: COUNT(CASE WHEN rate_quote_status = 'accepted' THEN rate_quote_id END)
      comment: "Count of accepted rate quotes — primary sales conversion metric."
    - name: "quote_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_quote_status = 'accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued quotes that were accepted — key sales effectiveness KPI for executive and sales leadership."
    - name: "expired_quote_count"
      expr: COUNT(CASE WHEN rate_quote_status = 'expired' THEN rate_quote_id END)
      comment: "Count of expired quotes — measures lost pipeline opportunities requiring follow-up."
    - name: "total_gross_premium_pipeline"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium across all quotes — measures total revenue pipeline before discounts."
    - name: "total_net_premium_pipeline"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium across all quotes — measures actual revenue pipeline after discounts."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate quoted — benchmarks pricing competitiveness across market segments."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied across quotes — tracks pricing concessions and margin erosion."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per quote — measures pricing discipline and competitive pressure."
    - name: "avg_total_group_premium_estimate"
      expr: AVG(CAST(total_group_premium_estimate AS DOUBLE))
      comment: "Average total group premium estimate per quote — measures average deal size in the sales pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker performance and distribution channel KPIs — commission economics, portfolio quality, and broker lifecycle management."
  source: "`vibe_health_insurance_v1`.`employer`.`broker`"
  dimensions:
    - name: "broker_type"
      expr: broker_type
      comment: "Type of broker (independent, captive, GA) — key distribution channel segmentation dimension."
    - name: "broker_status"
      expr: broker_status
      comment: "Current status of the broker relationship (active, terminated, suspended)."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the broker agreement — tracks contract compliance and renewal pipeline."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Broker agreement renewal status — used for retention and distribution channel management."
    - name: "region"
      expr: region
      comment: "Geographic region of the broker — enables regional distribution channel analysis."
    - name: "state"
      expr: state
      comment: "State of the broker — supports state-level distribution and regulatory compliance analysis."
    - name: "commission_currency"
      expr: commission_currency
      comment: "Currency of broker commissions for multi-currency reporting."
    - name: "agreement_start_month"
      expr: DATE_TRUNC('MONTH', agreement_start_date)
      comment: "Month broker agreement started — used for cohort analysis of broker onboarding."
  measures:
    - name: "total_active_brokers"
      expr: COUNT(CASE WHEN broker_status = 'active' THEN broker_id END)
      comment: "Count of active brokers — measures distribution channel breadth and capacity."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average broker commission rate — key distribution cost metric for financial planning and margin management."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission dollars paid to brokers — measures total distribution cost and broker channel investment."
    - name: "avg_broker_rating"
      expr: AVG(CAST(rating AS DOUBLE))
      comment: "Average broker performance rating — used to identify top-performing distribution partners and manage channel quality."
    - name: "brokers_expiring_next_90_days"
      expr: COUNT(CASE WHEN agreement_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN broker_id END)
      comment: "Brokers with agreements expiring in the next 90 days — critical retention pipeline metric for distribution management."
    - name: "terminated_broker_count"
      expr: COUNT(CASE WHEN broker_status = 'terminated' THEN broker_id END)
      comment: "Count of terminated brokers — tracks distribution channel attrition and informs recruitment strategy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker agreement economics and compliance KPIs — commission structures, agreement lifecycle, and distribution cost management."
  source: "`vibe_health_insurance_v1`.`employer`.`broker_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of broker agreement (standard, GA override, specialty) — drives commission structure and compliance requirements."
    - name: "broker_agreement_status"
      expr: broker_agreement_status
      comment: "Current status of the broker agreement (active, expired, terminated)."
    - name: "commission_schedule_type"
      expr: commission_schedule_type
      comment: "Commission schedule type — determines how broker compensation is calculated and paid."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment covered by the agreement — enables segment-level distribution cost analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line covered by the agreement (medical, dental, vision) — supports product-level distribution analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of commission payments — relevant for cash flow and accounts payable planning."
    - name: "appointment_status"
      expr: appointment_status
      comment: "State appointment status of the broker — critical for regulatory compliance and licensing management."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the agreement is exclusive — informs competitive distribution strategy."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement became effective — used for cohort and trend analysis."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN broker_agreement_status = 'active' THEN broker_agreement_id END)
      comment: "Count of active broker agreements — measures active distribution channel contracts."
    - name: "avg_base_commission_rate"
      expr: AVG(CAST(base_commission_rate AS DOUBLE))
      comment: "Average base commission rate across agreements — benchmarks distribution cost structure."
    - name: "avg_override_commission_rate"
      expr: AVG(CAST(override_commission_rate AS DOUBLE))
      comment: "Average override commission rate — measures incremental distribution cost above base for high-volume brokers."
    - name: "avg_renewal_commission_rate"
      expr: AVG(CAST(renewal_commission_rate AS DOUBLE))
      comment: "Average renewal commission rate — tracks ongoing distribution cost for retained business."
    - name: "agreements_expiring_next_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN broker_agreement_id END)
      comment: "Broker agreements expiring in the next 90 days — critical pipeline metric for distribution contract renewal management."
    - name: "avg_minimum_production_requirement"
      expr: AVG(CAST(minimum_production_requirement AS DOUBLE))
      comment: "Average minimum production requirement across agreements — measures expected revenue contribution from broker channel."
    - name: "errors_omissions_expiring_count"
      expr: COUNT(CASE WHEN errors_omissions_required = TRUE AND errors_omissions_expiry < CURRENT_DATE THEN broker_agreement_id END)
      comment: "Count of agreements where required E&O insurance has expired — critical compliance risk metric for broker oversight."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group renewal performance KPIs — retention rates, premium rate changes, compliance status, and renewal pipeline health for account management leadership."
  source: "`vibe_health_insurance_v1`.`employer`.`group_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current renewal status (pending, approved, declined, lapsed) — primary pipeline stage dimension."
    - name: "retention_outcome"
      expr: retention_outcome
      comment: "Outcome of the renewal retention effort (retained, lost, pending) — key sales and account management KPI dimension."
    - name: "retention_reason_code"
      expr: retention_reason_code
      comment: "Reason code for retention outcome — enables root cause analysis of group attrition."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement of the renewing group — drives revenue model and risk exposure."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at renewal — flags groups with outstanding regulatory issues."
    - name: "renewal_cycle_year"
      expr: renewal_cycle_year
      comment: "Renewal cycle year — enables year-over-year retention and rate change trend analysis."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether the renewal includes an amendment — tracks complexity and processing burden."
    - name: "participation_requirement_met"
      expr: participation_requirement_met
      comment: "Whether the group met participation requirements at renewal — compliance and viability indicator."
    - name: "renewal_effective_month"
      expr: DATE_TRUNC('MONTH', renewal_effective_date)
      comment: "Month of renewal effective date — used for cohort and seasonal trend analysis."
  measures:
    - name: "total_renewals"
      expr: COUNT(1)
      comment: "Total group renewals processed — measures renewal pipeline volume."
    - name: "retained_group_count"
      expr: COUNT(CASE WHEN retention_outcome = 'retained' THEN group_renewal_id END)
      comment: "Count of groups successfully retained at renewal — primary retention performance metric."
    - name: "retention_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retention_outcome = 'retained' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of renewing groups retained — top-line retention KPI for executive and account management reporting."
    - name: "avg_rate_change_percentage"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average premium rate change at renewal — measures pricing trend and competitive positioning."
    - name: "avg_prior_year_premium_rate"
      expr: AVG(CAST(premium_rate_prior_year AS DOUBLE))
      comment: "Average prior year premium rate — baseline for rate change analysis."
    - name: "avg_renewal_year_premium_rate"
      expr: AVG(CAST(premium_rate_renewal_year AS DOUBLE))
      comment: "Average renewal year premium rate — measures current pricing level across renewing groups."
    - name: "non_compliant_renewal_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN group_renewal_id END)
      comment: "Count of renewals with non-compliant status — tracks regulatory risk in the renewal book."
    - name: "participation_requirement_failure_count"
      expr: COUNT(CASE WHEN participation_requirement_met = FALSE THEN group_renewal_id END)
      comment: "Count of renewals where participation requirements were not met — flags groups at risk of coverage termination."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_contribution_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer contribution strategy KPIs — contribution economics, affordability compliance, and HSA/HRA seeding analysis across employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`contribution_strategy`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of employer contribution (flat dollar, percentage, tiered) — drives affordability and ACA compliance analysis."
    - name: "contribution_strategy_status"
      expr: contribution_strategy_status
      comment: "Current status of the contribution strategy (active, expired, pending)."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Frequency of employer contributions (monthly, annual, per-payroll) — relevant for cash flow planning."
    - name: "is_pre_tax"
      expr: is_pre_tax
      comment: "Whether contributions are pre-tax — affects employee net cost and ACA affordability calculations."
    - name: "is_post_tax"
      expr: is_post_tax
      comment: "Whether contributions are post-tax — relevant for tax liability and benefit design analysis."
    - name: "tax_credit_eligible"
      expr: tax_credit_eligible
      comment: "Whether the strategy qualifies for small business tax credits — tracks SHOP marketplace eligibility."
    - name: "tier_code"
      expr: tier_code
      comment: "Contribution tier code (EE, ES, EC, EF) — enables tier-level contribution analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contribution strategy became effective — used for trend analysis."
  measures:
    - name: "total_active_strategies"
      expr: COUNT(CASE WHEN contribution_strategy_status = 'active' THEN contribution_strategy_id END)
      comment: "Count of active contribution strategies — measures breadth of employer contribution programs."
    - name: "avg_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount — benchmarks employer generosity and ACA affordability compliance."
    - name: "avg_contribution_percentage"
      expr: AVG(CAST(contribution_percentage AS DOUBLE))
      comment: "Average employer contribution percentage — key metric for affordability analysis and benefit competitiveness."
    - name: "avg_employer_contribution_cap"
      expr: AVG(CAST(employer_contribution_cap AS DOUBLE))
      comment: "Average employer contribution cap — measures maximum financial exposure per strategy."
    - name: "avg_hsa_employer_seed_amount"
      expr: AVG(CAST(hsa_employer_seed_amount AS DOUBLE))
      comment: "Average HSA employer seed amount — tracks investment in consumer-directed health accounts."
    - name: "avg_hra_employer_seed_amount"
      expr: AVG(CAST(hra_employer_seed_amount AS DOUBLE))
      comment: "Average HRA employer seed amount — measures employer investment in health reimbursement arrangements."
    - name: "tax_credit_eligible_strategy_count"
      expr: COUNT(CASE WHEN tax_credit_eligible = TRUE THEN contribution_strategy_id END)
      comment: "Count of strategies eligible for small business tax credits — tracks SHOP marketplace participation and tax benefit utilization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_wellness_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wellness program performance and ROI KPIs — participation rates, budget utilization, and program effectiveness across employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`wellness_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of wellness program (preventive, chronic disease management, mental health) — enables program category analysis."
    - name: "program_category"
      expr: program_category
      comment: "Program category for portfolio segmentation and effectiveness benchmarking."
    - name: "wellness_program_status"
      expr: wellness_program_status
      comment: "Current status of the wellness program (active, completed, suspended)."
    - name: "aca_compliance_classification"
      expr: aca_compliance_classification
      comment: "ACA compliance classification of the wellness program — critical for regulatory compliance reporting."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether program participation is mandatory — affects participation rate benchmarks."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (premium discount, gift card, HSA contribution) — informs program design effectiveness."
    - name: "program_review_status"
      expr: program_review_status
      comment: "Current review status of the program — tracks governance and compliance review cycle."
    - name: "program_effective_year"
      expr: program_effective_year
      comment: "Year the program is effective — enables year-over-year performance comparison."
  measures:
    - name: "total_active_programs"
      expr: COUNT(CASE WHEN wellness_program_status = 'active' THEN wellness_program_id END)
      comment: "Count of active wellness programs — measures breadth of employer wellness investment."
    - name: "avg_actual_participation_pct"
      expr: AVG(CAST(program_actual_participation_pct AS DOUBLE))
      comment: "Average actual participation percentage across programs — primary wellness program effectiveness KPI."
    - name: "avg_target_participation_pct"
      expr: AVG(CAST(program_target_participation_pct AS DOUBLE))
      comment: "Average target participation percentage — used to calculate participation attainment vs. goal."
    - name: "total_program_budget"
      expr: SUM(CAST(program_budget_amount AS DOUBLE))
      comment: "Total wellness program budget across all programs — measures total employer investment in workforce health."
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per program — benchmarks incentive generosity and its correlation with participation."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(program_risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to wellness programs — measures actuarial impact of wellness initiatives on group risk."
    - name: "participation_attainment_rate"
      expr: ROUND(100.0 * AVG(CAST(program_actual_participation_pct AS DOUBLE)) / NULLIF(AVG(CAST(program_target_participation_pct AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to target participation percentage — measures wellness program goal attainment for executive reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_stop_loss_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-loss policy portfolio KPIs — attachment points, premium economics, and risk exposure management for self-funded employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`stop_loss_policy`"
  dimensions:
    - name: "stop_loss_policy_status"
      expr: stop_loss_policy_status
      comment: "Current status of the stop-loss policy (active, expired, terminated)."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of stop-loss policy (specific, aggregate, combined) — determines risk protection structure."
    - name: "attachment_point_type"
      expr: attachment_point_type
      comment: "Type of attachment point (paid, incurred) — affects claims timing and financial exposure."
    - name: "lasering_provision_flag"
      expr: lasering_provision_flag
      comment: "Whether the policy includes a lasering provision — flags high-risk individual exclusions affecting group coverage."
    - name: "claim_payment_limit_currency"
      expr: claim_payment_limit_currency
      comment: "Currency of claim payment limits for multi-currency portfolio reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the policy became effective — used for cohort and trend analysis."
    - name: "renewal_date_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month of policy renewal — tracks stop-loss renewal pipeline."
  measures:
    - name: "total_active_policies"
      expr: COUNT(CASE WHEN stop_loss_policy_status = 'active' THEN stop_loss_policy_id END)
      comment: "Count of active stop-loss policies — measures self-funded group risk protection coverage."
    - name: "avg_individual_attachment_point"
      expr: AVG(CAST(individual_attachment_point AS DOUBLE))
      comment: "Average specific stop-loss attachment point — key risk management metric indicating per-member deductible level."
    - name: "avg_aggregate_attachment_point"
      expr: AVG(CAST(aggregate_attachment_point AS DOUBLE))
      comment: "Average aggregate stop-loss attachment point — measures total group-level risk retention before reinsurance kicks in."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total stop-loss premium paid — measures total reinsurance cost across the self-funded portfolio."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average stop-loss premium per policy — benchmarks reinsurance cost efficiency."
    - name: "avg_claim_payment_limit"
      expr: AVG(CAST(claim_payment_limit AS DOUBLE))
      comment: "Average maximum claim payment limit — measures maximum reinsurance recovery per policy."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor on stop-loss policies — signals portfolio-level risk loading applied by reinsurers."
    - name: "policies_renewing_next_90_days"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN stop_loss_policy_id END)
      comment: "Stop-loss policies renewing in the next 90 days — critical risk management pipeline metric for self-funded groups."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_participation_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participation requirement compliance KPIs — enrollment thresholds, compliance status, and waiver utilization across employer groups and health plans."
  source: "`vibe_health_insurance_v1`.`employer`.`participation_requirement`"
  dimensions:
    - name: "participation_requirement_status"
      expr: participation_requirement_status
      comment: "Current status of the participation requirement (met, not-met, waived, pending)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the group against the participation requirement — regulatory risk indicator."
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of participation requirement (minimum enrollment, contribution threshold) — drives compliance analysis."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement of the group — participation requirements vary by funding type."
    - name: "waiver_allowed"
      expr: waiver_allowed
      comment: "Whether waivers are permitted — affects participation rate calculations and compliance thresholds."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether this requirement triggers regulatory reporting — flags high-compliance-risk records."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the requirement became effective — used for trend analysis."
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total participation requirements tracked — measures compliance monitoring scope."
    - name: "non_compliant_requirement_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN participation_requirement_id END)
      comment: "Count of non-compliant participation requirements — primary compliance risk metric for regulatory and account management teams."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of participation requirements in compliance — top-line compliance health metric for executive reporting."
    - name: "avg_participation_percentage"
      expr: AVG(CAST(participation_percentage AS DOUBLE))
      comment: "Average actual participation percentage across requirements — measures enrollment health across the employer portfolio."
    - name: "avg_waiver_percentage_allowed"
      expr: AVG(CAST(waiver_percentage_allowed AS DOUBLE))
      comment: "Average waiver percentage allowed — measures flexibility built into participation requirements."
    - name: "regulatory_reporting_requirement_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN participation_requirement_id END)
      comment: "Count of requirements triggering regulatory reporting — measures regulatory compliance burden and reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_tpa_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TPA arrangement portfolio KPIs — ASO fee economics, arrangement lifecycle, and self-funded administration cost management."
  source: "`vibe_health_insurance_v1`.`employer`.`tpa_arrangement`"
  dimensions:
    - name: "tpa_arrangement_status"
      expr: tpa_arrangement_status
      comment: "Current status of the TPA arrangement (active, expired, terminated)."
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of TPA arrangement (ASO, administrative-only, full-service) — drives fee structure and service scope."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA compliance status of the arrangement — relevant for fiduciary and regulatory reporting."
    - name: "gfc_control_flag"
      expr: gfc_control_flag
      comment: "GFC control flag — indicates arrangements subject to group financial controls."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the arrangement became effective — used for cohort and trend analysis."
    - name: "renewal_date_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month of arrangement renewal — tracks TPA contract renewal pipeline."
  measures:
    - name: "total_active_arrangements"
      expr: COUNT(CASE WHEN tpa_arrangement_status = 'active' THEN tpa_arrangement_id END)
      comment: "Count of active TPA arrangements — measures self-funded administration portfolio size."
    - name: "avg_contribution_rate_pmpm"
      expr: AVG(CAST(contribution_rate_pmpm AS DOUBLE))
      comment: "Average per-member-per-month ASO contribution rate — key metric for self-funded administration cost benchmarking."
    - name: "total_contribution_rate_pmpm"
      expr: SUM(CAST(contribution_rate_pmpm AS DOUBLE))
      comment: "Total PMPM contribution rate across all arrangements — measures aggregate ASO fee revenue."
    - name: "arrangements_renewing_next_90_days"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN tpa_arrangement_id END)
      comment: "TPA arrangements renewing in the next 90 days — critical contract management pipeline metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_rating_factor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group rating factor KPIs — risk adjustment analytics and actuarial factor trends for underwriting and pricing strategy."
  source: "`vibe_health_insurance_v1`.`employer`.`group_rating_factor`"
  dimensions:
    - name: "factor_type"
      expr: factor_type
      comment: "Type of rating factor (age, gender, industry, geographic, experience) — enables factor-level risk analysis."
    - name: "group_rating_factor_status"
      expr: group_rating_factor_status
      comment: "Current status of the rating factor (active, expired, superseded)."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Whether the factor has been manually adjusted — flags non-standard underwriting decisions."
    - name: "is_default"
      expr: is_default
      comment: "Whether the factor is the default value — distinguishes standard from customized risk adjustments."
    - name: "actuarial_basis"
      expr: actuarial_basis
      comment: "Actuarial basis used for the factor — ensures methodological consistency in pricing."
    - name: "value_unit"
      expr: value_unit
      comment: "Unit of the factor value (multiplier, percentage, index) — required for correct interpretation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rating factor became effective — used for trend analysis."
  measures:
    - name: "avg_factor_value"
      expr: AVG(CAST(factor_value AS DOUBLE))
      comment: "Average rating factor value — measures central tendency of risk adjustments applied across the employer portfolio."
    - name: "max_factor_value"
      expr: MAX(CAST(factor_value AS DOUBLE))
      comment: "Maximum rating factor value — identifies highest-risk outliers in the employer portfolio."
    - name: "min_factor_value"
      expr: MIN(CAST(factor_value AS DOUBLE))
      comment: "Minimum rating factor value — identifies lowest-risk groups for competitive pricing opportunities."
    - name: "manually_adjusted_factor_count"
      expr: COUNT(CASE WHEN is_adjusted = TRUE THEN group_rating_factor_id END)
      comment: "Count of manually adjusted rating factors — measures underwriting override frequency and actuarial exception volume."
    - name: "adjusted_factor_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rating factors that have been manually adjusted — tracks underwriting exception rate and pricing discipline."
$$;