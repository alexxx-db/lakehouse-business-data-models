-- Metric views for domain: pharmacy | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_benefit_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member pharmacy benefit accumulator metrics tracking deductible, out-of-pocket, and Part D benefit phase progress. Critical for member cost-sharing management, CMS reconciliation, and benefit design evaluation."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator`"
  filter: is_active = TRUE
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Medicare Part D, Commercial, Medicaid) for benefit accumulator segmentation."
    - name: "part_d_benefit_phase"
      expr: part_d_benefit_phase
      comment: "Current Part D benefit phase (deductible, initial coverage, coverage gap, catastrophic) for CMS reporting."
    - name: "lis_level"
      expr: lis_level
      comment: "Low Income Subsidy level for equity and access analysis of low-income member populations."
    - name: "is_deductible_met"
      expr: is_deductible_met
      comment: "Flag indicating whether the member has met their deductible. Drives benefit phase transition analysis."
    - name: "is_moop_met"
      expr: is_moop_met
      comment: "Flag indicating whether the member has met their maximum out-of-pocket limit. Critical for catastrophic coverage activation."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status for Part D DIR and TROOP reporting compliance."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('month', benefit_period_start_date)
      comment: "Benefit period start month for annual accumulator reset and plan year analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator record for data quality and operational monitoring."
  measures:
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied_amt AS DOUBLE))
      comment: "Total deductible amounts applied across all member accumulators. Measures benefit phase progression and cost-sharing exposure."
    - name: "total_oop_applied"
      expr: SUM(CAST(oop_applied_amt AS DOUBLE))
      comment: "Total out-of-pocket amounts applied. Primary member financial burden metric for benefit design evaluation."
    - name: "total_troop_applied"
      expr: SUM(CAST(troop_applied_amt AS DOUBLE))
      comment: "Total True Out-of-Pocket (TrOOP) amounts applied. Required for CMS Part D DIR reconciliation and TROOP reporting."
    - name: "total_catastrophic_applied"
      expr: SUM(CAST(catastrophic_applied_amt AS DOUBLE))
      comment: "Total catastrophic coverage amounts applied. Measures high-cost member exposure and CMS reinsurance liability."
    - name: "total_coverage_gap_discount_applied"
      expr: SUM(CAST(coverage_gap_discount_applied_amt AS DOUBLE))
      comment: "Total manufacturer coverage gap discounts applied. Tracks Part D coverage gap discount program utilization."
    - name: "total_specialty_drug_applied"
      expr: SUM(CAST(specialty_drug_applied_amt AS DOUBLE))
      comment: "Total specialty drug cost applied to accumulators. Measures specialty drug cost-sharing burden on members."
    - name: "total_hsa_eligible_applied"
      expr: SUM(CAST(hsa_eligible_applied_amt AS DOUBLE))
      comment: "Total HSA-eligible amounts applied. Supports HDHP/HSA benefit design compliance reporting."
    - name: "total_icl_applied"
      expr: SUM(CAST(icl_applied_amt AS DOUBLE))
      comment: "Total Initial Coverage Limit amounts applied. Tracks Part D coverage gap entry threshold progression."
    - name: "total_mail_order_applied"
      expr: SUM(CAST(mail_order_applied_amt AS DOUBLE))
      comment: "Total mail-order amounts applied to accumulators. Measures mail-order channel utilization and cost-sharing."
    - name: "avg_oop_applied_per_member"
      expr: AVG(CAST(oop_applied_amt AS DOUBLE))
      comment: "Average out-of-pocket amount applied per member accumulator record. Benchmarks member cost burden across populations."
    - name: "members_at_moop"
      expr: COUNT(CASE WHEN is_moop_met = TRUE THEN 1 END)
      comment: "Number of members who have reached their maximum out-of-pocket limit. Drives catastrophic coverage cost projections."
    - name: "members_at_deductible"
      expr: COUNT(CASE WHEN is_deductible_met = TRUE THEN 1 END)
      comment: "Number of members who have met their deductible. Measures benefit phase transition volume for actuarial modeling."
    - name: "total_accumulator_records"
      expr: COUNT(1)
      comment: "Total active accumulator records. Baseline for member benefit tracking completeness and data quality monitoring."
    - name: "total_family_oop_applied"
      expr: SUM(CAST(family_oop_applied_amt AS DOUBLE))
      comment: "Total family-level out-of-pocket amounts applied. Measures aggregate family cost-sharing for family plan benefit design."
    - name: "total_third_party_applied"
      expr: SUM(CAST(third_party_applied_amt AS DOUBLE))
      comment: "Total third-party (manufacturer copay assistance) amounts applied. Tracks accumulator adjustment program (AAP) exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy claim line-level financial and clinical metrics covering drug cost components, COB, and specialty drug utilization. Provides granular ingredient-level analytics for formulary management and cost trend analysis."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`claim_line`"
  filter: record_status = 'active'
  dimensions:
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the dispensed drug for tier-mix and cost-sharing analysis at the line level."
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail, specialty) for channel economics analysis."
    - name: "line_status"
      expr: line_status
      comment: "Claim line status (paid, reversed, adjusted) for adjudication pipeline monitoring."
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Flag for specialty drug claim lines — highest cost category requiring dedicated management."
    - name: "generic_indicator"
      expr: generic_indicator
      comment: "Flag for generic drug dispensing. Tracks generic dispensing rate, a key formulary cost management KPI."
    - name: "low_income_subsidy_indicator"
      expr: low_income_subsidy_indicator
      comment: "Flag for LIS (Low Income Subsidy) claim lines for equity and CMS subsidy reporting."
    - name: "coverage_gap_indicator"
      expr: coverage_gap_indicator
      comment: "Flag for claim lines in the Part D coverage gap phase for benefit phase cost analysis."
    - name: "catastrophic_coverage_indicator"
      expr: catastrophic_coverage_indicator
      comment: "Flag for claim lines in catastrophic coverage phase — highest CMS reinsurance liability."
    - name: "dispensed_month"
      expr: DATE_TRUNC('month', dispensed_date)
      comment: "Month of dispensing for claim line trend analysis."
    - name: "step_therapy_indicator"
      expr: step_therapy_indicator
      comment: "Flag indicating step therapy was applied to this claim line."
  measures:
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total plan-paid amount at the claim line level. Granular drug-level cost KPI for formulary management."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost_amount AS DOUBLE))
      comment: "Total ingredient cost at the claim line level. Primary drug acquisition cost metric for formulary economics."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees at the claim line level. Measures pharmacy network dispensing cost by channel and tier."
    - name: "total_patient_pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket payments at the claim line level. Measures member cost burden by drug and tier."
    - name: "total_gross_drug_cost"
      expr: SUM(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Total gross drug cost before rebates and discounts. Baseline for net cost calculation and rebate ROI analysis."
    - name: "total_manufacturer_discount"
      expr: SUM(CAST(manufacturer_discount_amount AS DOUBLE))
      comment: "Total manufacturer discounts applied at the claim line level. Measures coverage gap discount program financial impact."
    - name: "total_other_payer_amount"
      expr: SUM(CAST(other_payer_amount AS DOUBLE))
      comment: "Total other payer amounts at the claim line level. Measures COB recovery at the drug level."
    - name: "total_true_oop_amount"
      expr: SUM(CAST(true_oop_amount AS DOUBLE))
      comment: "Total True Out-of-Pocket (TrOOP) amounts at the claim line level. Required for CMS Part D TROOP accumulation reporting."
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax_amount AS DOUBLE))
      comment: "Total sales tax at the claim line level for state tax compliance reporting."
    - name: "avg_quantity_dispensed"
      expr: AVG(CAST(quantity_dispensed AS DOUBLE))
      comment: "Average quantity dispensed per claim line. Benchmarks dispensing patterns against quantity limits."
    - name: "generic_dispensing_rate"
      expr: COUNT(CASE WHEN generic_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Ratio of generic to total claim lines. Key formulary cost management KPI — higher rates indicate effective generic substitution."
    - name: "specialty_drug_cost_share"
      expr: SUM(CASE WHEN specialty_drug_indicator = TRUE THEN plan_paid_amount ELSE 0 END) / NULLIF(SUM(CAST(plan_paid_amount AS DOUBLE)), 0)
      comment: "Proportion of total plan-paid amount attributable to specialty drugs. Measures specialty drug cost concentration for budget management."
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total pharmacy claim lines. Baseline utilization volume metric for trend and capacity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug pricing analytics covering AWP, WAC, MAC, and RBP price benchmarks across formulary tiers and dispensing channels. Drives formulary economics, PBM contract performance, and cost management strategy."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_pricing`"
  filter: is_active = TRUE
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Type of drug price (AWP, WAC, MAC, RBP) for pricing benchmark comparison."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier for tier-level pricing analysis and cost-sharing design."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel (retail, mail, specialty) for channel-specific pricing analysis."
    - name: "multi_source_code"
      expr: multi_source_code
      comment: "Multi-source code indicating brand vs. generic availability for generic substitution economics."
    - name: "pricing_status"
      expr: pricing_status
      comment: "Current pricing record status for active price file management."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of pricing data (Medi-Span, Red Book, FDB) for data provenance and benchmark validation."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of price effective date for drug price inflation trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency pricing environments."
  measures:
    - name: "avg_awp_price"
      expr: AVG(CAST(awp_price AS DOUBLE))
      comment: "Average AWP (Average Wholesale Price) across drug pricing records. Benchmark for PBM discount negotiation and formulary economics."
    - name: "avg_wac_price"
      expr: AVG(CAST(wac_price AS DOUBLE))
      comment: "Average WAC (Wholesale Acquisition Cost) across drug pricing records. Manufacturer list price benchmark for rebate and discount analysis."
    - name: "avg_mac_price"
      expr: AVG(CAST(mac_price AS DOUBLE))
      comment: "Average MAC (Maximum Allowable Cost) price. Measures generic drug cost ceiling effectiveness for plan cost management."
    - name: "avg_rbp_price"
      expr: AVG(CAST(rbp_price AS DOUBLE))
      comment: "Average Reference-Based Pricing (RBP) price. Tracks alternative pricing methodology adoption and cost impact."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price across all pricing records. Primary drug cost benchmark for formulary and PBM contract management."
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage negotiated. Measures PBM contract discount depth and formulary savings effectiveness."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee AS DOUBLE))
      comment: "Average dispensing fee across pricing records. Benchmarks pharmacy network dispensing cost by channel and tier."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average price change percentage from prior period. Tracks drug price inflation trends for actuarial and budget planning."
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total active drug pricing records. Measures formulary pricing file completeness and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug rebate financial performance metrics covering contracted vs. received rebate amounts, reconciliation status, and manufacturer performance. Directly impacts pharmacy net cost and MLR calculations."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_rebate`"
  filter: record_status = 'active'
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (base, performance, market share) for rebate program mix analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for rebate allocation and MLR reporting by segment."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Rebate reconciliation status (pending, reconciled, disputed) for cash flow and liability management."
    - name: "therapeutic_class_code"
      expr: therapeutic_class_code
      comment: "Therapeutic drug class for rebate analysis by clinical category and formulary strategy."
    - name: "mlr_rebate_category"
      expr: mlr_rebate_category
      comment: "MLR rebate category classification required for CMS MLR reporting and rebate pass-through calculations."
    - name: "part_d_indicator"
      expr: part_d_indicator
      comment: "Flag indicating Part D rebate for CMS DIR reporting and Part D financial reconciliation."
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Specialty drug flag for specialty rebate program performance tracking."
    - name: "rebate_period_start_month"
      expr: DATE_TRUNC('month', rebate_period_start_date)
      comment: "Rebate period start month for quarterly and annual rebate trend analysis."
    - name: "performance_target_met_indicator"
      expr: performance_target_met_indicator
      comment: "Flag indicating whether manufacturer performance targets were met, triggering performance rebate payments."
  measures:
    - name: "total_calculated_rebate_amount"
      expr: SUM(CAST(calculated_rebate_amount AS DOUBLE))
      comment: "Total calculated rebate amount based on contracted rates and utilization. Primary rebate revenue projection KPI."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total rebate amount invoiced to manufacturers. Measures rebate billing completeness and cash flow timing."
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total rebate amount actually received from manufacturers. Tracks cash collection vs. invoiced amounts."
    - name: "total_pass_through_amount"
      expr: SUM(CAST(pass_through_amount AS DOUBLE))
      comment: "Total rebate amounts passed through to clients or members. Measures rebate pass-through program compliance."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between calculated and received rebate amounts. Identifies manufacturer underpayment and dispute triggers."
    - name: "avg_contracted_rebate_rate"
      expr: AVG(CAST(contracted_rebate_rate AS DOUBLE))
      comment: "Average contracted rebate rate across all rebate agreements. Benchmarks formulary negotiation effectiveness."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage across rebate contracts. Tracks formulary positioning and market share rebate eligibility."
    - name: "total_utilization_units"
      expr: SUM(CAST(utilization_units AS DOUBLE))
      comment: "Total drug utilization units underlying rebate calculations. Validates rebate invoice accuracy against claims data."
    - name: "rebate_collection_rate"
      expr: SUM(CAST(received_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_amount AS DOUBLE)), 0)
      comment: "Ratio of received to invoiced rebate amounts. Measures manufacturer payment compliance and collection effectiveness."
    - name: "total_rebate_records"
      expr: COUNT(1)
      comment: "Total rebate records. Baseline for rebate program coverage and manufacturer contract completeness."
    - name: "disputed_rebate_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Number of rebate records with active disputes. Tracks manufacturer dispute volume and resolution pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dur_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug utilization review (DUR) alert metrics tracking clinical safety interventions, override patterns, and adjudication outcomes. Critical for patient safety, clinical program effectiveness, and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dur_alert`"
  filter: record_status = 'active'
  dimensions:
    - name: "alert_type_code"
      expr: alert_type_code
      comment: "DUR alert type (drug-drug interaction, drug-disease, duplicate therapy) for clinical safety category analysis."
    - name: "alert_status"
      expr: alert_status
      comment: "Current alert status (open, overridden, resolved) for DUR program operational monitoring."
    - name: "clinical_significance_code"
      expr: clinical_significance_code
      comment: "Clinical significance level of the DUR alert for severity-weighted safety analysis."
    - name: "severity_level_code"
      expr: severity_level_code
      comment: "Severity level of the drug interaction or clinical issue for risk stratification."
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Adjudication outcome following DUR alert (paid, rejected, overridden) for claims processing impact analysis."
    - name: "dur_program_type"
      expr: dur_program_type
      comment: "DUR program type (prospective, retrospective, concurrent) for program effectiveness comparison."
    - name: "pa_required_flag"
      expr: pa_required_flag
      comment: "Flag indicating PA was required as a result of the DUR alert. Measures DUR-to-PA escalation rate."
    - name: "alert_month"
      expr: DATE_TRUNC('month', dispensing_date)
      comment: "Month of dispensing date for DUR alert trend analysis over time."
    - name: "step_therapy_flag"
      expr: step_therapy_flag
      comment: "Flag indicating step therapy was triggered by the DUR alert."
  measures:
    - name: "total_dur_alerts"
      expr: COUNT(1)
      comment: "Total DUR alerts generated. Baseline patient safety metric measuring clinical intervention volume."
    - name: "override_count"
      expr: COUNT(CASE WHEN override_code IS NOT NULL THEN 1 END)
      comment: "Number of DUR alerts overridden by pharmacists or prescribers. High override rates may indicate alert fatigue or inappropriate criteria."
    - name: "override_rate"
      expr: COUNT(CASE WHEN override_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Ratio of overridden to total DUR alerts. Key clinical safety KPI — high rates signal alert fatigue and patient safety risk."
    - name: "pa_escalation_rate"
      expr: COUNT(CASE WHEN pa_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Rate of DUR alerts escalating to prior authorization. Measures DUR program clinical rigor and PA workload impact."
    - name: "quantity_limit_alert_count"
      expr: COUNT(CASE WHEN quantity_limit_flag = TRUE THEN 1 END)
      comment: "Number of DUR alerts triggered by quantity limit violations. Tracks quantity limit program effectiveness."
    - name: "avg_prescribed_quantity"
      expr: AVG(CAST(prescribed_quantity AS DOUBLE))
      comment: "Average prescribed quantity at time of DUR alert. Benchmarks prescribing patterns against clinical quantity limits."
    - name: "avg_quantity_dispensed"
      expr: AVG(CAST(quantity_dispensed AS DOUBLE))
      comment: "Average quantity dispensed when DUR alert was generated. Measures dispensing compliance with clinical safety thresholds."
    - name: "distinct_member_alert_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with DUR alerts. Measures patient safety program reach and high-risk member identification."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary exception and coverage determination metrics tracking approval rates, denial patterns, and CMS compliance. Directly impacts member access, regulatory compliance, and formulary design decisions."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_exception`"
  filter: record_status = 'active'
  dimensions:
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the formulary exception request (approved, denied, pending) for pipeline management."
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception (formulary, tier, coverage determination) for exception program mix analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for identifying top denial drivers and formulary improvement opportunities."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for exception volume segmentation across Medicare, Medicaid, and Commercial."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag for expedited exception requests requiring 72-hour turnaround per CMS Part D regulations."
    - name: "cms_coverage_determination_type"
      expr: cms_coverage_determination_type
      comment: "CMS coverage determination type for Part D regulatory compliance classification."
    - name: "requestor_type"
      expr: requestor_type
      comment: "Who submitted the exception request (member, prescriber, pharmacy) for access channel analysis."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of exception request for trend analysis of formulary exception volume."
    - name: "appeal_rights_notified"
      expr: appeal_rights_notified
      comment: "Flag indicating member was notified of appeal rights. CMS compliance requirement for all adverse determinations."
  measures:
    - name: "total_exception_requests"
      expr: COUNT(1)
      comment: "Total formulary exception requests. Baseline metric for formulary access barrier measurement."
    - name: "approved_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'approved' THEN 1 END)
      comment: "Number of approved formulary exceptions. Measures formulary flexibility and member access outcomes."
    - name: "denied_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'denied' THEN 1 END)
      comment: "Number of denied formulary exceptions. Tracks denial volume for regulatory scrutiny and formulary design review."
    - name: "exception_approval_rate"
      expr: COUNT(CASE WHEN exception_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Ratio of approved to total exception requests. Key formulary access KPI and CMS compliance indicator."
    - name: "appeal_rights_notification_compliance_rate"
      expr: COUNT(CASE WHEN appeal_rights_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Rate of timely appeal rights notification. CMS Part D compliance requirement — failure triggers regulatory penalties."
    - name: "expedited_exception_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of expedited exception requests. Tracks urgent access volume for CMS 72-hour turnaround compliance."
    - name: "supporting_doc_received_rate"
      expr: COUNT(CASE WHEN supporting_doc_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Rate of exceptions with supporting documentation received. Measures documentation completeness for clinical review quality."
    - name: "avg_requested_quantity"
      expr: AVG(CAST(quantity_requested AS DOUBLE))
      comment: "Average quantity requested in formulary exceptions. Benchmarks exception request patterns against formulary quantity limits."
    - name: "distinct_member_exception_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members filing formulary exceptions. Measures formulary access barrier breadth across the member population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_mtm_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication Therapy Management (MTM) service performance metrics covering enrollment, completion rates, and CMS Star Ratings impact. MTM is a CMS-mandated Part D program directly tied to Star Ratings and quality bonuses."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`mtm_service`"
  filter: record_status = 'active'
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "MTM service type (CMR, TMR, MAP) for service mix and CMS reporting analysis."
    - name: "service_status"
      expr: service_status
      comment: "Current MTM service status for program pipeline and completion tracking."
    - name: "service_delivery_channel"
      expr: service_delivery_channel
      comment: "Delivery channel (phone, in-person, telehealth) for MTM service access and cost analysis."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Flag for members who opted out of MTM. Tracks opt-out rates for program engagement strategy."
    - name: "star_measure_eligible_flag"
      expr: star_measure_eligible_flag
      comment: "Flag indicating the MTM service is eligible for CMS Star Ratings credit. Directly impacts quality bonus payments."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Flag for MTM services requiring follow-up. Tracks care coordination workload and member engagement continuity."
    - name: "cms_reporting_period"
      expr: cms_reporting_period
      comment: "CMS reporting period for MTM performance measurement and Star Ratings submission."
    - name: "service_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of MTM service delivery for trend analysis and CMS reporting period alignment."
  measures:
    - name: "total_mtm_services"
      expr: COUNT(1)
      comment: "Total MTM services delivered. Baseline CMS Part D program compliance and Star Ratings volume metric."
    - name: "cmr_completion_count"
      expr: COUNT(CASE WHEN cmr_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of Comprehensive Medication Reviews (CMRs) completed. Primary CMS Star Ratings MTM measure — directly impacts quality bonus."
    - name: "opt_out_rate"
      expr: COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Rate of member opt-outs from MTM program. High opt-out rates reduce Star Ratings performance and CMS quality bonuses."
    - name: "star_eligible_service_rate"
      expr: COUNT(CASE WHEN star_measure_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of MTM services eligible for CMS Star Ratings credit. Measures program quality and CMS bonus payment eligibility."
    - name: "avg_chronic_condition_count"
      expr: AVG(CAST(chronic_condition_count AS DOUBLE))
      comment: "Average number of chronic conditions per MTM-enrolled member. Measures disease burden of MTM population for program targeting."
    - name: "avg_estimated_annual_drug_cost"
      expr: AVG(CAST(estimated_annual_drug_cost AS DOUBLE))
      comment: "Average estimated annual drug cost per MTM member. Measures high-cost member concentration and MTM program ROI potential."
    - name: "avg_intervention_count"
      expr: AVG(CAST(intervention_count AS DOUBLE))
      comment: "Average number of drug therapy interventions per MTM service. Measures clinical intensity and pharmacist engagement depth."
    - name: "avg_service_duration_minutes"
      expr: AVG(CAST(service_duration_minutes AS DOUBLE))
      comment: "Average MTM service duration in minutes. Benchmarks service quality and pharmacist productivity."
    - name: "distinct_member_mtm_count"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Number of unique members receiving MTM services. Measures MTM program reach relative to eligible population."
    - name: "prescriber_notification_rate"
      expr: COUNT(CASE WHEN prescriber_notification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Rate of MTM services with prescriber notification. Measures care coordination completeness and clinical communication compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_part_d_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS Part D submission compliance and financial metrics covering PDE submission rates, reconciliation status, and DIR/RAF financial impacts. Critical for CMS regulatory compliance and Part D financial management."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`part_d_submission`"
  filter: record_status = 'active'
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "CMS submission status (accepted, rejected, pending) for compliance pipeline monitoring."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of Part D submission (PDE, DIR, reconciliation) for submission program mix analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for DIR and TROOP reconciliation compliance tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for Part D submission segmentation."
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Flag for resubmissions, indicating prior submission failures requiring correction."
    - name: "is_timely_submission"
      expr: is_timely_submission
      comment: "Flag indicating whether submission met CMS deadline. Timely submission is a CMS compliance requirement."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for annual Part D submission trend and reconciliation analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for trend analysis of Part D filing volume and compliance."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total Part D submissions. Baseline CMS compliance volume metric."
    - name: "total_dir_amount"
      expr: SUM(CAST(dir_amount AS DOUBLE))
      comment: "Total Direct and Indirect Remuneration (DIR) amounts reported. Critical CMS Part D financial reconciliation KPI."
    - name: "total_raf_impact_amount"
      expr: SUM(CAST(raf_impact_amount AS DOUBLE))
      comment: "Total Risk Adjustment Factor (RAF) financial impact from Part D submissions. Drives CMS payment reconciliation."
    - name: "total_cgdp_invoice_amount"
      expr: SUM(CAST(cgdp_invoice_amount AS DOUBLE))
      comment: "Total Coverage Gap Discount Program invoice amounts. Tracks manufacturer discount program financial flows."
    - name: "timely_submission_rate"
      expr: COUNT(CASE WHEN is_timely_submission = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Rate of timely CMS Part D submissions. CMS compliance KPI — late submissions trigger penalties and audit risk."
    - name: "resubmission_rate"
      expr: COUNT(CASE WHEN is_resubmission = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Rate of resubmissions indicating prior submission failures. High rates signal data quality or system issues."
    - name: "avg_pde_record_count"
      expr: AVG(CAST(pde_record_count AS DOUBLE))
      comment: "Average PDE record count per submission batch. Benchmarks submission completeness and batch sizing."
    - name: "total_accepted_records"
      expr: SUM(CAST(accepted_record_count AS DOUBLE))
      comment: "Total CMS-accepted PDE records. Measures submission acceptance volume for Part D payment eligibility."
    - name: "total_rejected_records"
      expr: SUM(CAST(rejected_record_count AS DOUBLE))
      comment: "Total CMS-rejected PDE records. Tracks rejection volume for data quality remediation and resubmission prioritization."
    - name: "rejection_rate"
      expr: SUM(CAST(rejected_record_count AS DOUBLE)) / NULLIF(SUM(CAST(total_record_count AS DOUBLE)), 0)
      comment: "Ratio of rejected to total PDE records. CMS data quality KPI — high rejection rates risk Part D payment clawbacks."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pbm_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PBM contract performance and economics metrics covering discount guarantees, rebate commitments, and contract compliance. PBM contracts are the primary lever for pharmacy cost management and represent significant financial commitments."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`"
  filter: is_active = TRUE
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current PBM contract status for active contract portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of PBM contract (full-service, carve-out, ASO) for contract mix and governance analysis."
    - name: "lob_scope"
      expr: lob_scope
      comment: "Line of business scope covered by the PBM contract for contract coverage analysis."
    - name: "mail_order_flag"
      expr: mail_order_flag
      comment: "Flag indicating mail order services are included in the PBM contract."
    - name: "specialty_pharmacy_flag"
      expr: specialty_pharmacy_flag
      comment: "Flag indicating specialty pharmacy services are included in the PBM contract."
    - name: "performance_guarantee_flag"
      expr: performance_guarantee_flag
      comment: "Flag indicating the PBM contract includes performance guarantees. Drives PBM accountability and financial risk sharing."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag for auto-renewal contracts requiring proactive termination notice management."
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Contract effective year for contract portfolio vintage analysis and renewal planning."
  measures:
    - name: "total_pbm_contracts"
      expr: COUNT(1)
      comment: "Total active PBM contracts. Baseline for PBM vendor portfolio management and contract governance."
    - name: "avg_awp_discount_retail_pct"
      expr: AVG(CAST(awp_discount_retail_pct AS DOUBLE))
      comment: "Average AWP discount percentage for retail dispensing. Primary PBM contract economics KPI for retail drug cost management."
    - name: "avg_awp_discount_mail_pct"
      expr: AVG(CAST(awp_discount_mail_pct AS DOUBLE))
      comment: "Average AWP discount percentage for mail order dispensing. Benchmarks mail-order channel economics and PBM contract value."
    - name: "avg_rebate_guarantee_pmpm"
      expr: AVG(CAST(rebate_guarantee_pmpm AS DOUBLE))
      comment: "Average guaranteed rebate PMPM across PBM contracts. Measures contracted rebate revenue commitment for financial planning."
    - name: "avg_rebate_pass_through_pct"
      expr: AVG(CAST(rebate_pass_through_pct AS DOUBLE))
      comment: "Average rebate pass-through percentage. Measures PBM transparency and rebate sharing with plan sponsors."
    - name: "avg_generic_dispensing_rate_guarantee"
      expr: AVG(CAST(generic_dispensing_rate_guarantee AS DOUBLE))
      comment: "Average guaranteed generic dispensing rate. Measures PBM commitment to generic substitution and formulary cost management."
    - name: "avg_mail_order_penetration_guarantee"
      expr: AVG(CAST(mail_order_penetration_guarantee AS DOUBLE))
      comment: "Average guaranteed mail order penetration rate. Tracks PBM commitment to mail-order channel adoption for cost savings."
    - name: "avg_dispensing_fee_retail"
      expr: AVG(CAST(dispensing_fee_retail AS DOUBLE))
      comment: "Average contracted retail dispensing fee. Benchmarks pharmacy network dispensing cost across PBM contracts."
    - name: "avg_dispensing_fee_specialty"
      expr: AVG(CAST(dispensing_fee_specialty AS DOUBLE))
      comment: "Average contracted specialty dispensing fee. Tracks specialty pharmacy cost management across PBM agreements."
    - name: "performance_guarantee_contract_count"
      expr: COUNT(CASE WHEN performance_guarantee_flag = TRUE THEN 1 END)
      comment: "Number of PBM contracts with performance guarantees. Measures PBM accountability program scope and financial risk sharing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claims metrics tracking prescription utilization, cost, and financial performance across dispensing channels and formulary tiers"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the pharmacy claim (approved, denied, pending, reversed)"
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail order, specialty pharmacy)"
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier assigned to the dispensed drug (generic, preferred brand, non-preferred, specialty)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, Exchange)"
    - name: "fill_month"
      expr: DATE_TRUNC('MONTH', fill_date)
      comment: "Month when prescription was filled, for trend analysis"
    - name: "fill_year"
      expr: YEAR(fill_date)
      comment: "Year when prescription was filled"
    - name: "is_340b_claim"
      expr: is_340b_claim
      comment: "Indicator whether claim qualifies for 340B drug pricing program"
    - name: "is_compound_claim"
      expr: is_compound_claim
      comment: "Indicator whether claim is for a compounded medication"
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of benefits indicator (other payer involved)"
    - name: "basis_of_cost_determination"
      expr: basis_of_cost_determination
      comment: "Pricing methodology used (AWP, MAC, WAC, ingredient cost)"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of pharmacy claims processed"
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by health plan for pharmacy claims"
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total ingredient cost across all pharmacy claims"
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies"
    - name: "total_member_copay"
      expr: SUM(CAST(member_copay AS DOUBLE))
      comment: "Total member copayment amounts collected at point of sale"
    - name: "total_member_coinsurance"
      expr: SUM(CAST(member_coinsurance AS DOUBLE))
      comment: "Total member coinsurance amounts (percentage-based cost sharing)"
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied AS DOUBLE))
      comment: "Total deductible amounts applied to pharmacy claims"
    - name: "total_other_payer_amount"
      expr: SUM(CAST(other_payer_amount AS DOUBLE))
      comment: "Total amounts paid by other payers in COB scenarios"
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax AS DOUBLE))
      comment: "Total sales tax collected on pharmacy claims"
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of medication units dispensed across all claims"
    - name: "avg_plan_paid_per_claim"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan payment per pharmacy claim"
    - name: "avg_ingredient_cost_per_claim"
      expr: AVG(CAST(ingredient_cost AS DOUBLE))
      comment: "Average ingredient cost per pharmacy claim"
    - name: "avg_member_copay"
      expr: AVG(CAST(member_copay AS DOUBLE))
      comment: "Average member copayment per claim"
    - name: "avg_days_supply"
      expr: AVG(CAST(days_supply AS DOUBLE))
      comment: "Average days supply per prescription fill"
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT prescriber_npi)
      comment: "Distinct count of prescribers writing prescriptions"
    - name: "unique_pharmacies"
      expr: COUNT(DISTINCT dispensing_pharmacy_npi)
      comment: "Distinct count of pharmacies dispensing prescriptions"
    - name: "unique_drugs"
      expr: COUNT(DISTINCT ndc)
      comment: "Distinct count of NDC codes dispensed"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claim financial performance metrics covering plan spend, member cost-sharing, ingredient cost, and dispensing economics. Primary fact table for pharmacy cost management and trend analysis."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2`"
  filter: record_status = 'active'
  dimensions:
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail order, specialty) for channel-mix analysis."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the dispensed drug, used to analyze tier-mix and cost-sharing patterns."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Medicare, Medicaid, Commercial) for LOB-level cost segmentation."
    - name: "claim_status"
      expr: claim_status
      comment: "Claim processing status (paid, reversed, pended) for adjudication pipeline monitoring."
    - name: "is_340b_claim"
      expr: is_340b_claim
      comment: "Flag indicating whether the claim was processed under the 340B drug pricing program."
    - name: "is_compound_claim"
      expr: is_compound_claim
      comment: "Flag for compound drug claims, which carry higher cost and clinical risk."
    - name: "fill_month"
      expr: DATE_TRUNC('month', fill_date)
      comment: "Month of drug fill date for trend analysis of pharmacy spend over time."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of benefits indicator — identifies claims with secondary payer involvement."
    - name: "step_therapy_override"
      expr: step_therapy_override
      comment: "Flag indicating step therapy protocol was overridden, relevant for clinical compliance monitoring."
  measures:
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by the health plan across all pharmacy claims. Primary pharmacy cost KPI for budget management and trend reporting."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total ingredient cost (drug acquisition cost) across all claims. Drives formulary management and rebate strategy decisions."
    - name: "total_member_copay"
      expr: SUM(CAST(member_copay AS DOUBLE))
      comment: "Total member copay collected. Measures member cost-sharing burden and benefit design effectiveness."
    - name: "total_member_coinsurance"
      expr: SUM(CAST(member_coinsurance AS DOUBLE))
      comment: "Total member coinsurance collected. Combined with copay, reflects total member out-of-pocket exposure."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies. Key component of pharmacy network cost management."
    - name: "total_other_payer_amount"
      expr: SUM(CAST(other_payer_amount AS DOUBLE))
      comment: "Total amount paid by other payers (COB). Measures coordination of benefits recovery effectiveness."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied AS DOUBLE))
      comment: "Total deductible amounts applied to pharmacy claims. Informs benefit design and member cost-sharing analysis."
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax AS DOUBLE))
      comment: "Total sales tax on pharmacy claims. Relevant for state-specific tax compliance and cost reporting."
    - name: "avg_plan_paid_per_claim"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan-paid amount per pharmacy claim. Benchmark for cost-per-claim trend and outlier detection."
    - name: "avg_ingredient_cost_per_claim"
      expr: AVG(CAST(ingredient_cost AS DOUBLE))
      comment: "Average ingredient cost per claim. Tracks drug cost inflation and formulary tier-shift impact."
    - name: "avg_days_supply"
      expr: AVG(CAST(days_supply AS DOUBLE))
      comment: "Average days supply dispensed per claim. Higher values indicate mail-order adoption and medication adherence."
    - name: "avg_quantity_dispensed"
      expr: AVG(CAST(quantity_dispensed AS DOUBLE))
      comment: "Average quantity dispensed per claim. Used to detect quantity limit compliance and dispensing pattern anomalies."
    - name: "total_claim_count"
      expr: COUNT(1)
      comment: "Total number of pharmacy claims processed. Baseline volume metric for utilization trend analysis."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with pharmacy claims. Measures pharmacy program reach and per-member utilization."
    - name: "cob_claim_count"
      expr: COUNT(CASE WHEN cob_indicator = TRUE THEN 1 END)
      comment: "Number of claims with coordination of benefits. Tracks COB program effectiveness and secondary payer recovery volume."
    - name: "step_therapy_override_count"
      expr: COUNT(CASE WHEN step_therapy_override = TRUE THEN 1 END)
      comment: "Number of claims where step therapy was overridden. Clinical compliance KPI for UM program integrity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy prior authorization performance metrics covering approval rates, denial patterns, and clinical criteria compliance. Critical for UM program effectiveness, CMS Part D compliance, and member access management."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`"
  filter: record_status = 'active'
  dimensions:
    - name: "pa_status"
      expr: pa_status
      comment: "Prior authorization status (approved, denied, pending, appealed) for pipeline and outcome analysis."
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization request (new, renewal, exception) for workload and trend analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for identifying top denial drivers and clinical criteria improvement opportunities."
    - name: "drug_tier"
      expr: drug_tier
      comment: "Formulary tier of the requested drug for PA volume analysis by tier."
    - name: "lob"
      expr: lob
      comment: "Line of business for PA performance segmentation across Medicare, Medicaid, and Commercial."
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Flag for specialty drug PAs, which have higher cost and clinical complexity."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Flag indicating step therapy was required as part of the PA criteria."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of PA request for trend analysis of authorization volume and turnaround times."
    - name: "cms_part_d_reportable"
      expr: cms_part_d_reportable
      comment: "Flag for CMS Part D reportable PAs, required for coverage determination compliance reporting."
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total prior authorization requests. Baseline UM workload metric for staffing and capacity planning."
    - name: "approved_pa_count"
      expr: COUNT(CASE WHEN pa_status = 'approved' THEN 1 END)
      comment: "Number of approved prior authorizations. Measures approval volume and formulary access rates."
    - name: "denied_pa_count"
      expr: COUNT(CASE WHEN pa_status = 'denied' THEN 1 END)
      comment: "Number of denied prior authorizations. Tracks denial volume for clinical criteria review and member impact assessment."
    - name: "pa_approval_rate"
      expr: COUNT(CASE WHEN pa_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Ratio of approved to total PA requests. Key UM effectiveness KPI and CMS compliance indicator."
    - name: "pa_denial_rate"
      expr: COUNT(CASE WHEN pa_status = 'denied' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Ratio of denied to total PA requests. Monitors denial rate trends for regulatory scrutiny and member access equity."
    - name: "appeal_rate"
      expr: COUNT(CASE WHEN appeal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Ratio of PA decisions that were appealed. High appeal rates signal problematic denial criteria or member dissatisfaction."
    - name: "criteria_met_rate"
      expr: COUNT(CASE WHEN criteria_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of PAs where clinical criteria were met. Measures clinical criteria appropriateness and formulary design effectiveness."
    - name: "step_therapy_completed_rate"
      expr: COUNT(CASE WHEN step_therapy_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN step_therapy_required = TRUE THEN 1 END), 0)
      comment: "Rate of step therapy completion among PAs requiring it. Measures step therapy protocol adherence and clinical compliance."
    - name: "avg_approved_quantity"
      expr: AVG(CAST(approved_quantity AS DOUBLE))
      comment: "Average quantity approved per PA. Benchmarks dispensing quantity decisions against requested amounts."
    - name: "avg_requested_quantity"
      expr: AVG(CAST(requested_quantity AS DOUBLE))
      comment: "Average quantity requested per PA. Tracks prescriber ordering patterns and quantity limit program effectiveness."
    - name: "distinct_member_pa_count"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Number of unique members with PA requests. Measures PA program reach and per-member authorization burden."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_specialty_drug_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specialty drug program performance metrics covering program enrollment, cost management, and clinical management requirements. Specialty drugs represent the highest per-unit cost category and require dedicated program oversight."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program`"
  filter: is_active = TRUE
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current specialty drug program status for active program portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of specialty drug program (REMS, hub services, limited distribution) for program mix analysis."
    - name: "therapeutic_category"
      expr: therapeutic_category
      comment: "Therapeutic category of the specialty drug for clinical and cost analysis by disease area."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for specialty drug program segmentation."
    - name: "cms_part_d_specialty_tier_flag"
      expr: cms_part_d_specialty_tier_flag
      comment: "Flag for CMS Part D specialty tier designation, triggering specific cost-sharing and PA requirements."
    - name: "prior_auth_required_flag"
      expr: prior_auth_required_flag
      comment: "Flag indicating PA is required for this specialty drug program."
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Flag for REMS (Risk Evaluation and Mitigation Strategy) requirement — highest clinical risk specialty drugs."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Flag for cold chain storage requirement, impacting dispensing network and logistics costs."
    - name: "copay_assistance_flag"
      expr: copay_assistance_flag
      comment: "Flag for manufacturer copay assistance availability, relevant for accumulator adjustment program management."
  measures:
    - name: "total_specialty_programs"
      expr: COUNT(1)
      comment: "Total active specialty drug programs. Measures specialty formulary breadth and clinical management program scope."
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage for specialty drugs. Measures specialty drug pricing negotiation effectiveness."
    - name: "avg_wac_discount_pct"
      expr: AVG(CAST(wac_discount_pct AS DOUBLE))
      comment: "Average WAC discount percentage for specialty drugs. Benchmarks specialty drug cost management against manufacturer list prices."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Average dispensing fee for specialty drug programs. Tracks specialty pharmacy network cost management."
    - name: "avg_copay_assistance_max_benefit"
      expr: AVG(CAST(copay_assistance_max_benefit_amount AS DOUBLE))
      comment: "Average maximum copay assistance benefit amount. Measures manufacturer copay assistance program value and accumulator adjustment exposure."
    - name: "rems_program_count"
      expr: COUNT(CASE WHEN rems_required_flag = TRUE THEN 1 END)
      comment: "Number of specialty programs requiring REMS. Tracks highest-risk specialty drug portfolio for clinical oversight prioritization."
    - name: "pa_required_program_count"
      expr: COUNT(CASE WHEN prior_auth_required_flag = TRUE THEN 1 END)
      comment: "Number of specialty programs requiring prior authorization. Measures PA program scope for UM workload planning."
    - name: "copay_assistance_program_count"
      expr: COUNT(CASE WHEN copay_assistance_flag = TRUE THEN 1 END)
      comment: "Number of specialty programs with manufacturer copay assistance. Tracks accumulator adjustment program exposure and member cost-sharing impact."
    - name: "limited_distribution_program_count"
      expr: COUNT(CASE WHEN limited_distribution_flag = TRUE THEN 1 END)
      comment: "Number of limited distribution specialty drug programs. Measures network adequacy risk for specialty pharmacy access."
$$;
