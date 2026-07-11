-- Metric views for domain: pharmacy | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claim financial and operational KPIs. Tracks plan spend, member cost-sharing, ingredient costs, and dispensing fees to steer pharmacy benefit management decisions."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., Medicare Part D, Medicaid, Commercial) for segmenting pharmacy spend."
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail order, specialty) for channel mix analysis."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the dispensed drug, used to analyze tier utilization and cost impact."
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the pharmacy claim (paid, reversed, denied)."
    - name: "fill_date_month"
      expr: DATE_TRUNC('MONTH', fill_date)
      comment: "Month of prescription fill date for trend analysis."
    - name: "is_340b_claim"
      expr: is_340b_claim
      comment: "Flag indicating whether the claim was processed under the 340B drug pricing program."
    - name: "is_compound_claim"
      expr: is_compound_claim
      comment: "Flag indicating whether the claim is for a compounded medication."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of benefits indicator — whether another payer is involved."
  measures:
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by the health plan across all pharmacy claims. Primary driver of pharmacy benefit cost."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total ingredient cost (drug acquisition cost) across all claims. Key input for rebate and pricing negotiations."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies. Used to evaluate pharmacy network fee structures."
    - name: "total_member_copay"
      expr: SUM(CAST(member_copay AS DOUBLE))
      comment: "Total member copay collected. Measures member cost-sharing burden and benefit design effectiveness."
    - name: "total_member_coinsurance"
      expr: SUM(CAST(member_coinsurance AS DOUBLE))
      comment: "Total member coinsurance collected. Complements copay in measuring total member out-of-pocket."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied AS DOUBLE))
      comment: "Total deductible amounts applied to pharmacy claims. Tracks deductible accumulation across the benefit year."
    - name: "total_other_payer_amount"
      expr: SUM(CAST(other_payer_amount AS DOUBLE))
      comment: "Total amount paid by other payers (COB). Measures coordination of benefits recovery."
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax AS DOUBLE))
      comment: "Total sales tax on pharmacy claims. Relevant for states with pharmacy sales tax obligations."
    - name: "avg_plan_paid_per_claim"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan-paid amount per pharmacy claim. Benchmark for cost-per-script trend monitoring."
    - name: "avg_ingredient_cost_per_claim"
      expr: AVG(CAST(ingredient_cost AS DOUBLE))
      comment: "Average ingredient cost per claim. Used to track drug cost inflation and generic substitution impact."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with pharmacy claims. Measures pharmacy benefit utilization breadth."
    - name: "distinct_prescriber_count"
      expr: COUNT(DISTINCT prescriber_npi)
      comment: "Number of unique prescribers generating claims. Used for prescriber profiling and outlier detection."
    - name: "distinct_dispensing_pharmacy_count"
      expr: COUNT(DISTINCT dispensing_pharmacy_id)
      comment: "Number of unique dispensing pharmacies used. Measures network utilization breadth."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total drug quantity dispensed across all claims. Used for utilization management and drug trend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy claim line-level financial and clinical KPIs. Provides granular drug-level cost, utilization, and clinical program metrics for formulary management and rebate optimization."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`claim_line`"
  dimensions:
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the dispensed drug for tier-level cost and utilization analysis."
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail, specialty) for channel mix analysis."
    - name: "line_status"
      expr: line_status
      comment: "Status of the claim line (paid, reversed, adjusted) for adjudication quality monitoring."
    - name: "line_type"
      expr: line_type
      comment: "Type of claim line for categorization in financial reporting."
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Flag indicating specialty drug claims, which drive disproportionate pharmacy spend."
    - name: "generic_indicator"
      expr: generic_indicator
      comment: "Flag indicating whether a generic drug was dispensed. Key metric for generic dispensing rate programs."
    - name: "low_income_subsidy_indicator"
      expr: low_income_subsidy_indicator
      comment: "Flag for low-income subsidy (LIS) claims under Medicare Part D."
    - name: "coverage_gap_indicator"
      expr: coverage_gap_indicator
      comment: "Flag indicating claims in the Medicare Part D coverage gap phase."
    - name: "dispensed_date_month"
      expr: DATE_TRUNC('MONTH', dispensed_date)
      comment: "Month of dispensing date for trend analysis."
    - name: "step_therapy_indicator"
      expr: step_therapy_indicator
      comment: "Flag indicating step therapy was applied, for clinical program effectiveness tracking."
  measures:
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total plan-paid amount at claim line level. Primary pharmacy cost driver for formulary and rebate strategy."
    - name: "total_ingredient_cost_amount"
      expr: SUM(CAST(ingredient_cost_amount AS DOUBLE))
      comment: "Total ingredient cost at claim line level. Used for drug pricing analysis and MAC list effectiveness."
    - name: "total_dispensing_fee_amount"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees at claim line level. Evaluated against pharmacy contract benchmarks."
    - name: "total_patient_pay_amount"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket at claim line level. Measures member cost-sharing and adherence risk."
    - name: "total_gross_drug_cost_amount"
      expr: SUM(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Total gross drug cost before rebates and discounts. Baseline for net cost and rebate yield calculations."
    - name: "total_manufacturer_discount_amount"
      expr: SUM(CAST(manufacturer_discount_amount AS DOUBLE))
      comment: "Total manufacturer discounts applied. Measures coverage gap discount program value under Part D."
    - name: "total_other_payer_amount"
      expr: SUM(CAST(other_payer_amount AS DOUBLE))
      comment: "Total amount paid by other payers at line level. Tracks COB recovery at drug level."
    - name: "total_true_oop_amount"
      expr: SUM(CAST(true_oop_amount AS DOUBLE))
      comment: "Total true out-of-pocket amounts. Critical for Medicare Part D MOOP tracking and CMS reporting."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts paid. Measures performance-based pharmacy incentive program spend."
    - name: "total_sales_tax_amount"
      expr: SUM(CAST(sales_tax_amount AS DOUBLE))
      comment: "Total sales tax at claim line level for state tax compliance reporting."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total drug quantity dispensed at line level. Used for utilization trend and drug shortage monitoring."
    - name: "avg_plan_paid_per_line"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan-paid amount per claim line. Benchmark for drug-level cost management."
    - name: "avg_gross_drug_cost_per_line"
      expr: AVG(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Average gross drug cost per claim line. Used to identify high-cost drug trends."
    - name: "distinct_drug_count"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Number of unique drugs dispensed. Measures formulary utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_benefit_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member benefit accumulator KPIs tracking deductible, out-of-pocket, and catastrophic coverage progress. Critical for benefit design evaluation, CMS reconciliation, and member financial risk monitoring."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for segmenting accumulator data (Medicare Part D, Commercial, Medicaid)."
    - name: "part_d_benefit_phase"
      expr: part_d_benefit_phase
      comment: "Medicare Part D benefit phase (deductible, initial coverage, coverage gap, catastrophic) for phase-level analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator record for data quality and reconciliation monitoring."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status for Part D DIR and reconciliation compliance tracking."
    - name: "is_deductible_met"
      expr: is_deductible_met
      comment: "Flag indicating whether the member has met their deductible. Drives benefit phase transitions."
    - name: "is_moop_met"
      expr: is_moop_met
      comment: "Flag indicating whether the member has met their maximum out-of-pocket limit."
    - name: "benefit_period_start_date_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start_date)
      comment: "Benefit period start month for year-over-year accumulator trend analysis."
    - name: "lis_level"
      expr: lis_level
      comment: "Low-income subsidy level for segmenting Part D accumulator data by subsidy tier."
    - name: "coordination_of_benefits_type"
      expr: coordination_of_benefits_type
      comment: "COB type for analyzing accumulator behavior in multi-payer scenarios."
  measures:
    - name: "total_deductible_applied_amt"
      expr: SUM(CAST(deductible_applied_amt AS DOUBLE))
      comment: "Total deductible amounts applied across members. Measures benefit year deductible accumulation and plan liability timing."
    - name: "total_oop_applied_amt"
      expr: SUM(CAST(oop_applied_amt AS DOUBLE))
      comment: "Total out-of-pocket amounts applied. Tracks member financial exposure and MOOP attainment."
    - name: "total_moop_limit_amt"
      expr: SUM(CAST(moop_limit_amt AS DOUBLE))
      comment: "Total maximum out-of-pocket limits across members. Used to size catastrophic coverage liability."
    - name: "total_catastrophic_applied_amt"
      expr: SUM(CAST(catastrophic_applied_amt AS DOUBLE))
      comment: "Total catastrophic coverage amounts applied. Measures plan liability in the catastrophic benefit phase."
    - name: "total_troop_applied_amt"
      expr: SUM(CAST(troop_applied_amt AS DOUBLE))
      comment: "Total True Out-of-Pocket (TrOOP) amounts applied. Critical for Medicare Part D CMS DIR reconciliation."
    - name: "total_coverage_gap_discount_applied_amt"
      expr: SUM(CAST(coverage_gap_discount_applied_amt AS DOUBLE))
      comment: "Total coverage gap discounts applied. Measures manufacturer discount program utilization under Part D."
    - name: "total_icl_applied_amt"
      expr: SUM(CAST(icl_applied_amt AS DOUBLE))
      comment: "Total Initial Coverage Limit amounts applied. Tracks transition from initial coverage to coverage gap phase."
    - name: "total_family_deductible_applied_amt"
      expr: SUM(CAST(family_deductible_applied_amt AS DOUBLE))
      comment: "Total family deductible amounts applied. Measures family-level benefit accumulation for group plan analysis."
    - name: "total_family_oop_applied_amt"
      expr: SUM(CAST(family_oop_applied_amt AS DOUBLE))
      comment: "Total family out-of-pocket amounts applied. Tracks family-level financial exposure."
    - name: "total_hsa_eligible_applied_amt"
      expr: SUM(CAST(hsa_eligible_applied_amt AS DOUBLE))
      comment: "Total HSA-eligible amounts applied. Supports HDHP/HSA benefit design analysis."
    - name: "total_specialty_drug_applied_amt"
      expr: SUM(CAST(specialty_drug_applied_amt AS DOUBLE))
      comment: "Total specialty drug amounts applied to accumulators. Measures specialty drug cost-sharing burden."
    - name: "total_mail_order_applied_amt"
      expr: SUM(CAST(mail_order_applied_amt AS DOUBLE))
      comment: "Total mail order amounts applied. Supports mail order channel incentive program evaluation."
    - name: "total_third_party_applied_amt"
      expr: SUM(CAST(third_party_applied_amt AS DOUBLE))
      comment: "Total third-party amounts applied to accumulators. Tracks copay assistance and manufacturer coupon impact."
    - name: "members_with_moop_met"
      expr: COUNT(DISTINCT CASE WHEN is_moop_met = TRUE THEN member_subscriber_id END)
      comment: "Number of unique members who have met their MOOP. Measures catastrophic coverage liability exposure."
    - name: "members_with_deductible_met"
      expr: COUNT(DISTINCT CASE WHEN is_deductible_met = TRUE THEN member_subscriber_id END)
      comment: "Number of unique members who have met their deductible. Tracks benefit phase transition timing."
    - name: "avg_oop_applied_per_member"
      expr: AVG(CAST(oop_applied_amt AS DOUBLE))
      comment: "Average out-of-pocket applied per accumulator record. Benchmarks member financial burden across benefit designs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug rebate financial KPIs tracking contracted, invoiced, received, and variance amounts. Directly informs rebate negotiation strategy, PBM contract performance, and MLR reporting."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_rebate`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (base, performance, market share) for rebate program mix analysis."
    - name: "drug_tier"
      expr: drug_tier
      comment: "Formulary tier of the rebated drug for tier-level rebate yield analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for segmenting rebate data (Commercial, Medicare Part D, Medicaid)."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Rebate reconciliation status for tracking outstanding and disputed rebate amounts."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Drug manufacturer name for manufacturer-level rebate performance analysis."
    - name: "therapeutic_class_code"
      expr: therapeutic_class_code
      comment: "Therapeutic class for analyzing rebate yield by drug category."
    - name: "mlr_rebate_category"
      expr: mlr_rebate_category
      comment: "MLR rebate category for medical loss ratio regulatory reporting classification."
    - name: "part_d_indicator"
      expr: part_d_indicator
      comment: "Flag indicating Medicare Part D rebates for CMS DIR reporting."
    - name: "rebate_period_start_date_month"
      expr: DATE_TRUNC('MONTH', rebate_period_start_date)
      comment: "Rebate period start month for quarterly and annual rebate trend analysis."
    - name: "performance_target_met_indicator"
      expr: performance_target_met_indicator
      comment: "Flag indicating whether performance rebate targets were met. Drives performance rebate yield analysis."
  measures:
    - name: "total_calculated_rebate_amount"
      expr: SUM(CAST(calculated_rebate_amount AS DOUBLE))
      comment: "Total calculated rebate amount based on contracted rates and utilization. Primary rebate yield KPI."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total rebate amount invoiced to manufacturers. Measures billing completeness against calculated amounts."
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total rebate amount actually received from manufacturers. Tracks cash collection performance."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between invoiced and received rebate amounts. Identifies collection gaps and dispute exposure."
    - name: "total_pass_through_amount"
      expr: SUM(CAST(pass_through_amount AS DOUBLE))
      comment: "Total rebate pass-through amounts to clients/members. Measures rebate sharing program obligations."
    - name: "avg_contracted_rebate_rate"
      expr: AVG(CAST(contracted_rebate_rate AS DOUBLE))
      comment: "Average contracted rebate rate across drug-formulary combinations. Benchmarks negotiation outcomes."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage across rebated drugs. Tracks market share rebate program performance."
    - name: "total_utilization_units"
      expr: SUM(CAST(utilization_units AS DOUBLE))
      comment: "Total drug utilization units underlying rebate calculations. Validates rebate invoice accuracy."
    - name: "distinct_manufacturer_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique manufacturers with active rebate agreements. Measures rebate program breadth."
    - name: "avg_awp_unit_price"
      expr: AVG(CAST(awp_unit_price AS DOUBLE))
      comment: "Average AWP unit price across rebated drugs. Used to benchmark rebate rates as a percentage of AWP."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy prior authorization KPIs tracking approval rates, decision timeliness, and clinical criteria outcomes. Drives UM program effectiveness, regulatory compliance, and member access monitoring."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`"
  dimensions:
    - name: "pa_status"
      expr: pa_status
      comment: "Current status of the prior authorization (approved, denied, pending, withdrawn)."
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization request for program-level analysis."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business for segmenting PA data (Medicare Part D, Commercial, Medicaid)."
    - name: "review_level"
      expr: review_level
      comment: "Level of clinical review applied (initial, peer-to-peer, appeal) for escalation analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for PA denials. Used to identify top denial drivers and clinical criteria gaps."
    - name: "drug_tier"
      expr: drug_tier
      comment: "Formulary tier of the drug requiring PA. Identifies tier-level PA burden."
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Flag indicating specialty drug PAs, which have higher clinical and financial stakes."
    - name: "request_type"
      expr: request_type
      comment: "Type of PA request (new, renewal, extension) for workload and trend analysis."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of PA request for trend and seasonality analysis."
    - name: "criteria_met"
      expr: criteria_met
      comment: "Flag indicating whether clinical criteria were met. Core metric for PA program clinical effectiveness."
    - name: "cms_part_d_reportable"
      expr: cms_part_d_reportable
      comment: "Flag for CMS Part D reportable PAs for regulatory compliance tracking."
  measures:
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total drug quantity approved across all PAs. Measures clinical program access granted."
    - name: "avg_approved_quantity"
      expr: AVG(CAST(approved_quantity AS DOUBLE))
      comment: "Average approved drug quantity per PA. Benchmarks clinical criteria consistency."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Number of unique members with PA requests. Measures PA program utilization breadth."
    - name: "distinct_prescriber_count"
      expr: COUNT(DISTINCT prescriber_npi)
      comment: "Number of unique prescribers submitting PA requests. Used for prescriber education targeting."
    - name: "approved_pa_count"
      expr: COUNT(DISTINCT CASE WHEN pa_status = 'APPROVED' THEN prior_authorization_id END)
      comment: "Number of approved prior authorizations. Numerator for PA approval rate calculation."
    - name: "total_pa_count"
      expr: COUNT(DISTINCT prior_authorization_id)
      comment: "Total number of prior authorization requests. Denominator for PA approval and denial rate calculations."
    - name: "denied_pa_count"
      expr: COUNT(DISTINCT CASE WHEN pa_status = 'DENIED' THEN prior_authorization_id END)
      comment: "Number of denied prior authorizations. Tracks denial volume for regulatory and member access monitoring."
    - name: "criteria_met_pa_count"
      expr: COUNT(DISTINCT CASE WHEN criteria_met = TRUE THEN prior_authorization_id END)
      comment: "Number of PAs where clinical criteria were met. Measures clinical criteria program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary management KPIs tracking formulary composition, compliance status, and review cycle performance. Supports P&T committee governance, CMS compliance, and formulary strategy decisions."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary`"
  dimensions:
    - name: "formulary_status"
      expr: formulary_status
      comment: "Current status of the formulary (active, pending, retired) for lifecycle management."
    - name: "formulary_type"
      expr: formulary_type
      comment: "Type of formulary (open, closed, tiered) for benefit design analysis."
    - name: "formulary_category"
      expr: formulary_category
      comment: "Formulary category for segmenting by line of business or program type."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for formulary segmentation."
    - name: "is_cms_part_d"
      expr: is_cms_part_d
      comment: "Flag indicating CMS Part D formularies requiring regulatory compliance monitoring."
    - name: "is_aca_compliant"
      expr: is_aca_compliant
      comment: "Flag indicating ACA-compliant formularies for marketplace plan regulatory tracking."
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "CMS regulatory filing status for formulary submission compliance tracking."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year formulary comparison."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of formulary effective date for change management tracking."
  measures:
    - name: "active_formulary_count"
      expr: COUNT(DISTINCT CASE WHEN formulary_status = 'ACTIVE' THEN formulary_id END)
      comment: "Number of active formularies. Tracks formulary portfolio size for governance oversight."
    - name: "total_formulary_count"
      expr: COUNT(DISTINCT formulary_id)
      comment: "Total number of formularies across all statuses. Measures formulary portfolio breadth."
    - name: "cms_compliant_formulary_count"
      expr: COUNT(DISTINCT CASE WHEN is_cms_part_d = TRUE AND regulatory_filing_status = 'APPROVED' THEN formulary_id END)
      comment: "Number of CMS Part D formularies with approved regulatory filing status. Tracks CMS compliance posture."
    - name: "formularies_pending_review_count"
      expr: COUNT(DISTINCT CASE WHEN next_review_date <= CURRENT_DATE() THEN formulary_id END)
      comment: "Number of formularies past their scheduled review date. Drives P&T committee workload prioritization."
    - name: "avg_tier_count"
      expr: AVG(CAST(tier_count AS DOUBLE))
      comment: "Average number of tiers across formularies. Benchmarks formulary complexity and benefit design variation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_drug_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary drug tier KPIs tracking cost-sharing structures, prior auth requirements, and step therapy coverage. Informs formulary design decisions, member cost-sharing strategy, and clinical program effectiveness."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier`"
  dimensions:
    - name: "tier_name"
      expr: tier_name
      comment: "Formulary tier name (Generic, Preferred Brand, Non-Preferred, Specialty) for tier-level analysis."
    - name: "tier_number"
      expr: tier_number
      comment: "Numeric tier designation for ordered tier analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for segmenting tier data."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status of the drug-tier combination (covered, not covered, restricted)."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Flag indicating prior authorization is required. Measures PA burden by tier."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Flag indicating step therapy is required. Measures step therapy program scope."
    - name: "quantity_limit_required"
      expr: quantity_limit_required
      comment: "Flag indicating quantity limits apply. Measures utilization management program breadth."
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Flag indicating specialty drug tier placement for specialty benefit management."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for channel-specific cost-sharing analysis."
    - name: "deductible_applies"
      expr: deductible_applies
      comment: "Flag indicating whether the deductible applies to this tier. Affects member cost-sharing modeling."
  measures:
    - name: "avg_copay_retail_30"
      expr: AVG(CAST(copay_retail_30 AS DOUBLE))
      comment: "Average 30-day retail copay by tier. Benchmarks member cost-sharing design across formularies."
    - name: "avg_copay_retail_90"
      expr: AVG(CAST(copay_retail_90 AS DOUBLE))
      comment: "Average 90-day retail copay by tier. Evaluates extended supply cost-sharing incentives."
    - name: "avg_copay_mail_order"
      expr: AVG(CAST(copay_mail_order AS DOUBLE))
      comment: "Average mail order copay by tier. Measures mail order channel cost-sharing incentive differential."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate by tier. Benchmarks percentage-based cost-sharing design."
    - name: "drugs_with_prior_auth_count"
      expr: COUNT(DISTINCT CASE WHEN prior_auth_required = TRUE THEN drug_master_id END)
      comment: "Number of unique drugs requiring prior authorization. Measures PA program scope and administrative burden."
    - name: "drugs_with_step_therapy_count"
      expr: COUNT(DISTINCT CASE WHEN step_therapy_required = TRUE THEN drug_master_id END)
      comment: "Number of unique drugs with step therapy requirements. Measures step therapy program breadth."
    - name: "total_drug_tier_combinations"
      expr: COUNT(DISTINCT formulary_drug_tier_id)
      comment: "Total drug-tier combinations across all formularies. Measures formulary coverage complexity."
    - name: "distinct_drug_count"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Number of unique drugs on formulary tiers. Measures formulary coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug pricing KPIs tracking AWP, WAC, MAC, and RBP prices across drugs and contracts. Drives drug pricing strategy, MAC list effectiveness, and contract negotiation decisions."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_pricing`"
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Type of price (AWP, WAC, MAC, RBP) for pricing methodology analysis."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of pricing data (e.g., Medi-Span, Red Book, internal) for data quality governance."
    - name: "pricing_status"
      expr: pricing_status
      comment: "Current status of the pricing record (active, expired, pending) for pricing lifecycle management."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for channel-specific pricing analysis."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier for tier-level pricing analysis."
    - name: "multi_source_code"
      expr: multi_source_code
      comment: "Multi-source code indicating brand/generic status for pricing differential analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of pricing effective date for price change trend analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule for controlled drug pricing analysis."
  measures:
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all drug pricing records. Benchmarks overall drug cost levels."
    - name: "avg_awp_price"
      expr: AVG(CAST(awp_price AS DOUBLE))
      comment: "Average AWP price. Baseline for AWP discount negotiation benchmarking."
    - name: "avg_wac_price"
      expr: AVG(CAST(wac_price AS DOUBLE))
      comment: "Average WAC price. Used for WAC-based pricing contract analysis."
    - name: "avg_mac_price"
      expr: AVG(CAST(mac_price AS DOUBLE))
      comment: "Average MAC price. Measures MAC list effectiveness in controlling generic drug costs."
    - name: "avg_rbp_price"
      expr: AVG(CAST(rbp_price AS DOUBLE))
      comment: "Average reference-based pricing (RBP) price. Evaluates RBP program cost containment effectiveness."
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage. Key PBM contract performance metric for drug cost management."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average price change percentage. Tracks drug price inflation trends for budget forecasting."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee AS DOUBLE))
      comment: "Average dispensing fee across pricing records. Benchmarks pharmacy network fee structures."
    - name: "distinct_drug_count"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Number of unique drugs with active pricing records. Measures pricing database coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pbm_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PBM contract performance KPIs tracking financial guarantees, rebate commitments, and operational terms. Drives PBM vendor management, contract renewal decisions, and performance guarantee monitoring."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the PBM contract (active, expired, terminated) for portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of PBM contract for segmenting by arrangement type."
    - name: "lob_scope"
      expr: lob_scope
      comment: "Line of business scope covered by the PBM contract."
    - name: "rebate_settlement_frequency"
      expr: rebate_settlement_frequency
      comment: "Frequency of rebate settlement (quarterly, annual) for cash flow planning."
    - name: "performance_guarantee_flag"
      expr: performance_guarantee_flag
      comment: "Flag indicating contracts with performance guarantees for guarantee monitoring."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating auto-renewal contracts for contract management alerts."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of contract effective date for contract portfolio timeline analysis."
    - name: "governing_state_code"
      expr: governing_state_code
      comment: "Governing state for the PBM contract for regulatory jurisdiction analysis."
  measures:
    - name: "avg_awp_discount_mail_pct"
      expr: AVG(CAST(awp_discount_mail_pct AS DOUBLE))
      comment: "Average AWP discount percentage for mail order. Benchmarks PBM mail order pricing performance."
    - name: "avg_awp_discount_retail_pct"
      expr: AVG(CAST(awp_discount_retail_pct AS DOUBLE))
      comment: "Average AWP discount percentage for retail. Benchmarks PBM retail pricing performance."
    - name: "avg_rebate_guarantee_pmpm"
      expr: AVG(CAST(rebate_guarantee_pmpm AS DOUBLE))
      comment: "Average guaranteed rebate PMPM across PBM contracts. Key financial guarantee benchmark for contract negotiations."
    - name: "avg_rebate_pass_through_pct"
      expr: AVG(CAST(rebate_pass_through_pct AS DOUBLE))
      comment: "Average rebate pass-through percentage. Measures PBM transparency and rebate sharing terms."
    - name: "avg_mail_order_penetration_guarantee"
      expr: AVG(CAST(mail_order_penetration_guarantee AS DOUBLE))
      comment: "Average guaranteed mail order penetration rate. Tracks PBM mail order performance commitments."
    - name: "avg_generic_dispensing_rate_guarantee"
      expr: AVG(CAST(generic_dispensing_rate_guarantee AS DOUBLE))
      comment: "Average guaranteed generic dispensing rate. Measures PBM generic substitution performance commitments."
    - name: "avg_dispensing_fee_retail"
      expr: AVG(CAST(dispensing_fee_retail AS DOUBLE))
      comment: "Average contracted retail dispensing fee. Benchmarks pharmacy network fee negotiations."
    - name: "avg_dispensing_fee_mail_order"
      expr: AVG(CAST(dispensing_fee_mail_order AS DOUBLE))
      comment: "Average contracted mail order dispensing fee. Benchmarks mail order channel fee structures."
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'ACTIVE' THEN pbm_contract_id END)
      comment: "Number of active PBM contracts. Measures vendor relationship portfolio size."
    - name: "contracts_with_performance_guarantee_count"
      expr: COUNT(DISTINCT CASE WHEN performance_guarantee_flag = TRUE THEN pbm_contract_id END)
      comment: "Number of PBM contracts with performance guarantees. Measures financial risk protection coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dur_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug utilization review (DUR) alert KPIs tracking clinical safety interventions, override rates, and adjudication outcomes. Drives patient safety program effectiveness and clinical quality improvement."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dur_alert`"
  dimensions:
    - name: "alert_type_code"
      expr: alert_type_code
      comment: "DUR alert type code (drug-drug interaction, duplicate therapy, etc.) for safety program analysis."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the DUR alert (open, resolved, overridden) for workload management."
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Outcome of adjudication following DUR alert for clinical effectiveness measurement."
    - name: "severity_level_code"
      expr: severity_level_code
      comment: "Clinical severity level of the DUR alert for risk stratification."
    - name: "dur_program_type"
      expr: dur_program_type
      comment: "Type of DUR program (prospective, retrospective, concurrent) for program-level analysis."
    - name: "pa_required_flag"
      expr: pa_required_flag
      comment: "Flag indicating PA was required following DUR alert. Measures PA trigger rate from DUR."
    - name: "step_therapy_flag"
      expr: step_therapy_flag
      comment: "Flag indicating step therapy was triggered by DUR alert."
    - name: "alert_generated_date_month"
      expr: DATE_TRUNC('MONTH', alert_generated_timestamp)
      comment: "Month of alert generation for DUR alert volume trend analysis."
    - name: "quantity_limit_flag"
      expr: quantity_limit_flag
      comment: "Flag indicating quantity limit was triggered by DUR alert."
  measures:
    - name: "total_prescribed_quantity"
      expr: SUM(CAST(prescribed_quantity AS DOUBLE))
      comment: "Total prescribed quantity across DUR alerts. Measures drug volume subject to clinical review."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity dispensed following DUR review. Measures drug volume approved after clinical intervention."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with DUR alerts. Measures patient safety program reach."
    - name: "distinct_prescriber_count"
      expr: COUNT(DISTINCT prescriber_npi)
      comment: "Number of unique prescribers generating DUR alerts. Used for prescriber education targeting."
    - name: "overridden_alert_count"
      expr: COUNT(DISTINCT CASE WHEN override_code IS NOT NULL THEN dur_alert_id END)
      comment: "Number of DUR alerts that were overridden. Measures clinical override rate for safety program evaluation."
    - name: "total_alert_count"
      expr: COUNT(DISTINCT dur_alert_id)
      comment: "Total number of DUR alerts generated. Denominator for override rate and resolution rate calculations."
    - name: "high_severity_alert_count"
      expr: COUNT(DISTINCT CASE WHEN severity_level_code IN ('1', 'HIGH', 'MAJOR') THEN dur_alert_id END)
      comment: "Number of high-severity DUR alerts. Prioritizes patient safety intervention focus."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary exception and coverage determination KPIs tracking approval rates, decision timeliness, and regulatory compliance. Drives CMS Part D compliance, member access, and appeals management."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_exception`"
  dimensions:
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the formulary exception request (approved, denied, pending)."
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception (formulary, tier, coverage determination) for program-level analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for segmenting exception data."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denied exceptions. Identifies top denial drivers for clinical criteria review."
    - name: "cms_coverage_determination_type"
      expr: cms_coverage_determination_type
      comment: "CMS coverage determination type for Part D regulatory compliance classification."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating expedited exception requests requiring faster turnaround times."
    - name: "requestor_type"
      expr: requestor_type
      comment: "Type of requestor (member, prescriber, pharmacy) for access channel analysis."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the exception was requested for operational efficiency analysis."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of exception request for volume trend analysis."
    - name: "appeal_rights_notified"
      expr: appeal_rights_notified
      comment: "Flag indicating member was notified of appeal rights. Tracks regulatory notification compliance."
  measures:
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total drug quantity requested via formulary exceptions. Measures exception program utilization volume."
    - name: "approved_exception_count"
      expr: COUNT(DISTINCT CASE WHEN exception_status = 'APPROVED' THEN formulary_exception_id END)
      comment: "Number of approved formulary exceptions. Numerator for exception approval rate."
    - name: "total_exception_count"
      expr: COUNT(DISTINCT formulary_exception_id)
      comment: "Total number of formulary exception requests. Denominator for approval and denial rate calculations."
    - name: "expedited_exception_count"
      expr: COUNT(DISTINCT CASE WHEN is_expedited = TRUE THEN formulary_exception_id END)
      comment: "Number of expedited exception requests. Tracks urgent access requests requiring priority processing."
    - name: "appeal_rights_notified_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_rights_notified = TRUE THEN formulary_exception_id END)
      comment: "Number of exceptions where appeal rights notification was sent. Tracks CMS regulatory notification compliance."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with formulary exception requests. Measures member access program reach."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_part_d_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare Part D submission KPIs tracking PDE record counts, submission timeliness, reconciliation status, and financial impacts. Critical for CMS compliance, DIR reporting, and risk adjustment accuracy."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`part_d_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the Part D submission (accepted, rejected, pending) for compliance monitoring."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (original, resubmission, correction) for submission quality analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for DIR and payment reconciliation tracking."
    - name: "cms_response_code"
      expr: cms_response_code
      comment: "CMS response code for submission outcome analysis and error pattern identification."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for segmenting Part D submission data."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for year-over-year Part D submission performance comparison."
    - name: "is_timely_submission"
      expr: is_timely_submission
      comment: "Flag indicating whether submission met CMS timeliness requirements. Tracks regulatory compliance."
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Flag indicating resubmissions for tracking correction volume and data quality."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for trend analysis."
  measures:
    - name: "total_cgdp_invoice_amount"
      expr: SUM(CAST(cgdp_invoice_amount AS DOUBLE))
      comment: "Total Coverage Gap Discount Program invoice amount. Measures manufacturer discount program financial impact."
    - name: "total_dir_amount"
      expr: SUM(CAST(dir_amount AS DOUBLE))
      comment: "Total Direct and Indirect Remuneration (DIR) amount. Critical for CMS reconciliation and net drug cost reporting."
    - name: "total_raf_impact_amount"
      expr: SUM(CAST(raf_impact_amount AS DOUBLE))
      comment: "Total Risk Adjustment Factor (RAF) impact amount. Measures risk adjustment financial impact from PDE submissions."
    - name: "timely_submission_count"
      expr: COUNT(DISTINCT CASE WHEN is_timely_submission = TRUE THEN part_d_submission_id END)
      comment: "Number of timely Part D submissions. Numerator for CMS timeliness compliance rate."
    - name: "total_submission_count"
      expr: COUNT(DISTINCT part_d_submission_id)
      comment: "Total number of Part D submissions. Denominator for timeliness and acceptance rate calculations."
    - name: "avg_accepted_record_count"
      expr: AVG(CAST(accepted_record_count AS DOUBLE))
      comment: "Average number of accepted PDE records per submission. Benchmarks submission quality."
    - name: "avg_rejected_record_count"
      expr: AVG(CAST(rejected_record_count AS DOUBLE))
      comment: "Average number of rejected PDE records per submission. Tracks data quality issues requiring remediation."
    - name: "resubmission_count"
      expr: COUNT(DISTINCT CASE WHEN is_resubmission = TRUE THEN part_d_submission_id END)
      comment: "Number of resubmissions. Measures data quality issues requiring correction and reprocessing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_specialty_drug_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specialty drug program KPIs tracking program scope, cost-sharing structures, and clinical management requirements. Drives specialty pharmacy strategy, copay assistance program management, and high-cost drug oversight."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the specialty drug program (active, inactive, pending) for portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of specialty drug program for segmentation and analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for segmenting specialty drug program data."
    - name: "therapeutic_category"
      expr: therapeutic_category
      comment: "Therapeutic category for specialty drug program analysis by disease area."
    - name: "specialty_tier_designation"
      expr: specialty_tier_designation
      comment: "Specialty tier designation for cost-sharing tier analysis."
    - name: "cms_part_d_specialty_tier_flag"
      expr: cms_part_d_specialty_tier_flag
      comment: "Flag indicating CMS Part D specialty tier designation for regulatory compliance tracking."
    - name: "prior_auth_required_flag"
      expr: prior_auth_required_flag
      comment: "Flag indicating prior authorization is required for specialty drug access management."
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Flag indicating REMS (Risk Evaluation and Mitigation Strategy) requirements for safety program tracking."
    - name: "limited_distribution_flag"
      expr: limited_distribution_flag
      comment: "Flag indicating limited distribution drugs requiring specialty pharmacy network management."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of program effective date for program launch trend analysis."
  measures:
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage for specialty drugs. Benchmarks specialty drug pricing negotiations."
    - name: "avg_wac_discount_pct"
      expr: AVG(CAST(wac_discount_pct AS DOUBLE))
      comment: "Average WAC discount percentage for specialty drugs. Measures WAC-based specialty pricing effectiveness."
    - name: "avg_dispensing_fee_amount"
      expr: AVG(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Average dispensing fee for specialty drug programs. Benchmarks specialty pharmacy fee structures."
    - name: "avg_copay_assistance_max_benefit_amount"
      expr: AVG(CAST(copay_assistance_max_benefit_amount AS DOUBLE))
      comment: "Average maximum copay assistance benefit amount. Measures copay assistance program generosity and financial exposure."
    - name: "active_program_count"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'ACTIVE' THEN specialty_drug_program_id END)
      comment: "Number of active specialty drug programs. Tracks specialty pharmacy portfolio size."
    - name: "programs_with_copay_assistance_count"
      expr: COUNT(DISTINCT CASE WHEN copay_assistance_flag = TRUE THEN specialty_drug_program_id END)
      comment: "Number of specialty programs with copay assistance. Measures manufacturer copay assistance program coverage."
    - name: "programs_with_rems_count"
      expr: COUNT(DISTINCT CASE WHEN rems_required_flag = TRUE THEN specialty_drug_program_id END)
      comment: "Number of specialty programs with REMS requirements. Tracks FDA safety program compliance obligations."
    - name: "programs_with_limited_distribution_count"
      expr: COUNT(DISTINCT CASE WHEN limited_distribution_flag = TRUE THEN specialty_drug_program_id END)
      comment: "Number of limited distribution specialty programs. Measures specialty pharmacy network exclusivity management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dispensing_pharmacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispensing pharmacy network KPIs tracking network composition, contract terms, and operational capabilities. Drives pharmacy network strategy, contract negotiations, and network adequacy assessments."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`"
  dimensions:
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Current network participation status (in-network, out-of-network, terminated) for network management."
    - name: "pharmacy_type"
      expr: pharmacy_type
      comment: "Type of pharmacy (retail, mail order, specialty, long-term care) for network composition analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation for preferred/standard pharmacy network analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of pharmacy contract for contract portfolio analysis."
    - name: "dispensing_state_code"
      expr: dispensing_state_code
      comment: "State where pharmacy is located for geographic network adequacy analysis."
    - name: "mail_order_capable"
      expr: mail_order_capable
      comment: "Flag indicating mail order capability for channel capacity planning."
    - name: "cold_chain_certified"
      expr: cold_chain_certified
      comment: "Flag indicating cold chain certification for specialty drug distribution capability."
    - name: "chain_independent_flag"
      expr: chain_independent_flag
      comment: "Flag distinguishing chain vs. independent pharmacies for network diversity analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business served by the pharmacy for LOB-specific network analysis."
    - name: "contract_effective_date_month"
      expr: DATE_TRUNC('MONTH', contract_effective_date)
      comment: "Month of contract effective date for network growth trend analysis."
  measures:
    - name: "avg_awp_discount_percent"
      expr: AVG(CAST(awp_discount_percent AS DOUBLE))
      comment: "Average AWP discount percentage across network pharmacies. Benchmarks pharmacy network pricing performance."
    - name: "avg_dispensing_fee_amount"
      expr: AVG(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Average dispensing fee across network pharmacies. Benchmarks pharmacy fee structures for contract negotiations."
    - name: "active_network_pharmacy_count"
      expr: COUNT(DISTINCT CASE WHEN network_participation_status = 'ACTIVE' THEN dispensing_pharmacy_id END)
      comment: "Number of active in-network pharmacies. Primary network adequacy KPI for regulatory compliance."
    - name: "mail_order_capable_pharmacy_count"
      expr: COUNT(DISTINCT CASE WHEN mail_order_capable = TRUE THEN dispensing_pharmacy_id END)
      comment: "Number of mail order capable pharmacies. Measures mail order channel capacity."
    - name: "cold_chain_certified_pharmacy_count"
      expr: COUNT(DISTINCT CASE WHEN cold_chain_certified = TRUE THEN dispensing_pharmacy_id END)
      comment: "Number of cold chain certified pharmacies. Measures specialty drug distribution network capacity."
    - name: "distinct_state_count"
      expr: COUNT(DISTINCT dispensing_state_code)
      comment: "Number of states with network pharmacy coverage. Measures geographic network breadth for adequacy assessment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_mtm_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication Therapy Management (MTM) service KPIs tracking enrollment, completion rates, drug therapy problem resolution, and CMS Star measure performance. Drives MTM program effectiveness and Part D quality ratings."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`mtm_service`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the MTM service (enrolled, completed, opted out) for program management."
    - name: "service_type"
      expr: service_type
      comment: "Type of MTM service (CMR, TMR, targeted intervention) for service mix analysis."
    - name: "service_delivery_channel"
      expr: service_delivery_channel
      comment: "Channel for MTM service delivery (phone, in-person, telehealth) for channel effectiveness analysis."
    - name: "drug_therapy_problem_type"
      expr: drug_therapy_problem_type
      comment: "Type of drug therapy problem identified for clinical quality improvement targeting."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Flag indicating member opted out of MTM. Tracks program engagement and opt-out rates."
    - name: "star_measure_eligible_flag"
      expr: star_measure_eligible_flag
      comment: "Flag indicating eligibility for CMS Star measure reporting. Critical for Part D quality rating management."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Flag indicating follow-up is required for care continuity tracking."
    - name: "cms_reporting_period"
      expr: cms_reporting_period
      comment: "CMS reporting period for Star measure performance tracking."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of MTM service delivery for program volume trend analysis."
  measures:
    - name: "total_estimated_annual_drug_cost"
      expr: SUM(CAST(estimated_annual_drug_cost AS DOUBLE))
      comment: "Total estimated annual drug cost across MTM-enrolled members. Measures financial impact of MTM-eligible population."
    - name: "avg_estimated_annual_drug_cost"
      expr: AVG(CAST(estimated_annual_drug_cost AS DOUBLE))
      comment: "Average estimated annual drug cost per MTM member. Benchmarks MTM program targeting effectiveness."
    - name: "cmr_completed_count"
      expr: COUNT(DISTINCT CASE WHEN cmr_completion_date IS NOT NULL THEN mtm_service_id END)
      comment: "Number of completed Comprehensive Medication Reviews (CMR). Primary CMS Star measure for MTM program quality."
    - name: "total_mtm_member_count"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Total unique members enrolled in MTM. Measures MTM program reach and eligibility capture rate."
    - name: "opted_out_member_count"
      expr: COUNT(DISTINCT CASE WHEN opt_out_flag = TRUE THEN member_subscriber_id END)
      comment: "Number of members who opted out of MTM. Tracks program engagement barriers."
    - name: "star_eligible_member_count"
      expr: COUNT(DISTINCT CASE WHEN star_measure_eligible_flag = TRUE THEN member_subscriber_id END)
      comment: "Number of members eligible for CMS Star measure reporting. Denominator for Star measure compliance rate."
    - name: "avg_intervention_count"
      expr: AVG(CAST(intervention_count AS DOUBLE))
      comment: "Average number of clinical interventions per MTM service. Measures MTM program clinical intensity."
    - name: "prescriber_notified_count"
      expr: COUNT(DISTINCT CASE WHEN prescriber_notification_flag = TRUE THEN mtm_service_id END)
      comment: "Number of MTM services where prescriber was notified. Tracks care coordination effectiveness."
$$;