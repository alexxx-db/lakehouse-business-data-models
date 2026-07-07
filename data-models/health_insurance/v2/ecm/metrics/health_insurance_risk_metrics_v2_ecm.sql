-- Metric views for domain: risk | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_actuarial_assumption_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial assumption set KPIs for pricing assumption governance, trend monitoring, and peer review compliance — ensures actuarial assumptions are current, peer-reviewed, and regulatory-compliant."
  source: "`vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set`"
  filter: is_active = TRUE
  dimensions:
    - name: "actuarial_assumption_set_type"
      expr: actuarial_assumption_set_type
      comment: "Type of assumption set (pricing, reserving, IBNR, RBC) — enables assumption governance by use case."
    - name: "actuarial_assumption_set_status"
      expr: actuarial_assumption_set_status
      comment: "Current status (draft, peer-reviewed, approved, expired) — tracks assumption lifecycle and governance compliance."
    - name: "peer_review_status"
      expr: peer_review_status
      comment: "Peer review status — unapproved assumptions in production use represent actuarial governance risk."
    - name: "is_peer_reviewed"
      expr: is_peer_reviewed
      comment: "Flag indicating peer review completion — critical governance control for actuarial assumption quality."
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Flag indicating regulatory compliance of the assumption set — non-compliant assumptions in use create regulatory filing risk."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the assumption set became effective — enables year-over-year assumption trend analysis."
  measures:
    - name: "total_assumption_sets"
      expr: COUNT(1)
      comment: "Total actuarial assumption sets — measures assumption governance inventory."
    - name: "avg_trend_rate_medical_cost"
      expr: AVG(CAST(trend_rate_medical_cost AS DOUBLE))
      comment: "Average medical cost trend rate — primary pricing assumption; rising trends drive premium increases and profitability pressure."
    - name: "avg_trend_rate_pharmacy"
      expr: AVG(CAST(trend_rate_pharmacy AS DOUBLE))
      comment: "Average pharmacy trend rate — tracks drug cost inflation assumptions; critical for pharmacy benefit pricing."
    - name: "avg_trend_rate_utilization"
      expr: AVG(CAST(trend_rate_utilization AS DOUBLE))
      comment: "Average utilization trend rate — measures assumed changes in healthcare utilization; drives actuarial projections."
    - name: "avg_compound_trend_factor"
      expr: AVG(CAST(compound_trend_factor AS DOUBLE))
      comment: "Average compound trend factor — measures cumulative multi-year trend impact on pricing; key long-term profitability assumption."
    - name: "avg_credibility_weight"
      expr: AVG(CAST(credibility_weight AS DOUBLE))
      comment: "Average credibility weight — measures statistical reliability of experience data; low weights increase pricing uncertainty."
    - name: "avg_lapse_rate"
      expr: AVG(CAST(lapse_rate AS DOUBLE))
      comment: "Average lapse rate assumption — measures expected member attrition; high lapse rates affect risk pool stability and adverse selection."
    - name: "peer_reviewed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_peer_reviewed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assumption sets that have been peer reviewed — measures actuarial governance compliance; low rates indicate control gaps."
    - name: "regulatory_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assumption sets that are regulatory compliant — measures compliance posture; non-compliant assumptions in use create filing risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_adjustment_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment payment KPIs for CMS transfer payment monitoring, reconciliation tracking, and revenue integrity — directly impacts plan financial performance and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`adjustment_payment`"
  filter: is_active = TRUE
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of adjustment payment (risk adjustment, reinsurance, cost-sharing reduction) — enables payment type segmentation for revenue analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (pending, processed, reconciled, disputed) — tracks payment pipeline and cash flow."
    - name: "program_type"
      expr: program_type
      comment: "CMS program type (ACA, Medicare Advantage, Medicaid) — enables program-level payment performance analysis."
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year — aligns adjustment payments to revenue recognition periods."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for the adjustment — identifies systematic payment issues requiring remediation."
    - name: "reconciliation_flag"
      expr: reconciliation_flag
      comment: "Indicates whether the payment has been reconciled — unreconciled payments represent financial reporting risk."
    - name: "payment_effective_month"
      expr: DATE_TRUNC('MONTH', payment_effective_date)
      comment: "Month the payment became effective — enables monthly cash flow and revenue trend analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross adjustment payment amount — measures total CMS transfer payments before netting; primary revenue metric."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net adjustment payment amount — measures actual revenue impact after all adjustments and offsets."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount — measures the magnitude of payment corrections and reconciliation items."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with adjustment payments — links payment amounts to population acuity for revenue integrity analysis."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total adjustment payment records — measures payment volume and processing throughput."
    - name: "reconciliation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustment payments that have been reconciled — measures financial close completeness; low rates indicate unresolved payment discrepancies."
    - name: "gross_to_net_ratio"
      expr: ROUND(SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of net to gross adjustment payments — measures the impact of adjustments and offsets on gross revenue; values significantly below 1.0 indicate large payment reductions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_hcc_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCC (Hierarchical Condition Category) mapping KPIs for risk adjustment coding quality, RAF score component analysis, and CMS model compliance — drives revenue optimization through accurate diagnosis-to-HCC mapping."
  source: "`vibe_health_insurance_v1`.`risk`.`hcc_mapping`"
  filter: is_active = TRUE
  dimensions:
    - name: "hcc_mapping_status"
      expr: hcc_mapping_status
      comment: "Current status of the HCC mapping (active, inactive, superseded) — tracks mapping currency and validity."
    - name: "model_year"
      expr: model_year
      comment: "CMS model year for the HCC mapping — aligns mappings to the correct payment year model."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "HCC hierarchy level — identifies where in the HCC hierarchy the condition falls; higher levels indicate more severe conditions."
    - name: "disease_interaction_group"
      expr: disease_interaction_group
      comment: "Disease interaction group — identifies HCCs that interact to produce additional RAF score components."
    - name: "is_excluded"
      expr: is_excluded
      comment: "Indicates whether the HCC is excluded from scoring — excluded HCCs represent potential revenue recovery opportunities."
    - name: "is_mapped"
      expr: is_mapped
      comment: "Indicates whether the ICD-10 code is successfully mapped to an HCC — unmapped codes represent coding gaps."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the mapping — pending reviews indicate potential coding accuracy issues."
  measures:
    - name: "total_hcc_mappings"
      expr: COUNT(1)
      comment: "Total HCC mapping records — measures coding coverage and mapping inventory."
    - name: "avg_risk_score_weight"
      expr: AVG(CAST(risk_score_weight AS DOUBLE))
      comment: "Average risk score weight per HCC — measures the RAF contribution of mapped conditions; high-weight HCCs are priority coding targets."
    - name: "avg_coefficient"
      expr: AVG(CAST(coefficient AS DOUBLE))
      comment: "Average HCC coefficient — the CMS-published RAF contribution per HCC; drives payment calculation accuracy."
    - name: "avg_age_adjustment_factor"
      expr: AVG(CAST(age_adjustment_factor AS DOUBLE))
      comment: "Average age adjustment factor — measures age-based modification to HCC coefficients for demographic accuracy."
    - name: "avg_demographic_adjustment_factor"
      expr: AVG(CAST(demographic_adjustment_factor AS DOUBLE))
      comment: "Average demographic adjustment factor — measures combined age/gender adjustment to HCC scores."
    - name: "mapping_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mapped = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ICD-10 codes successfully mapped to HCCs — measures coding completeness; low rates indicate revenue leakage from unmapped diagnoses."
    - name: "exclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_excluded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HCC mappings excluded from scoring — high exclusion rates may indicate systematic coding issues or hierarchy suppression patterns."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_ibnr_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IBNR (Incurred But Not Reported) reserve KPIs for actuarial adequacy monitoring, regulatory capital compliance, and financial close accuracy — critical for CFO, Chief Actuary, and state DOI reporting."
  source: "`vibe_health_insurance_v1`.`risk`.`ibnr_reserve`"
  filter: is_active = TRUE
  dimensions:
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for IBNR segmentation — enables LOB-level reserve adequacy analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO) for reserve analysis by product type."
    - name: "reserve_methodology"
      expr: reserve_methodology
      comment: "Actuarial methodology used (e.g., chain-ladder, Bornhuetter-Ferguson) — critical for methodology consistency audits."
    - name: "ibnr_reserve_status"
      expr: ibnr_reserve_status
      comment: "Current status of the reserve estimate (preliminary, final, revised) for financial close tracking."
    - name: "reserve_adequacy_flag"
      expr: reserve_adequacy_flag
      comment: "Actuarial adequacy flag — identifies pools where reserves may be insufficient, triggering executive action."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_month)
      comment: "Service month for trend analysis of IBNR development patterns over time."
    - name: "valuation_date"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Valuation date for the reserve estimate — aligns reserves to financial reporting periods."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether this reserve is included in regulatory filings — critical for compliance completeness checks."
  measures:
    - name: "total_ibnr_amount"
      expr: SUM(CAST(ibnr_amount AS DOUBLE))
      comment: "Total IBNR reserve amount — primary actuarial liability metric; directly impacts statutory financial statements and RBC calculations."
    - name: "avg_ibnr_pmpm"
      expr: AVG(CAST(ibnr_pmpm AS DOUBLE))
      comment: "Average IBNR per member per month — normalizes reserve levels for population size comparison across pools and periods."
    - name: "total_hcc_weighted_amount"
      expr: SUM(CAST(hcc_weighted_amount AS DOUBLE))
      comment: "Total HCC-weighted IBNR amount — measures risk-adjusted reserve liability, linking clinical acuity to financial exposure."
    - name: "total_rbc_impact_amount"
      expr: SUM(CAST(rbc_impact_amount AS DOUBLE))
      comment: "Total RBC (Risk-Based Capital) impact of IBNR reserves — directly affects regulatory capital adequacy ratios reported to state DOIs."
    - name: "avg_expected_loss_ratio"
      expr: AVG(CAST(expected_loss_ratio AS DOUBLE))
      comment: "Average expected loss ratio embedded in IBNR estimates — deviations from pricing assumptions signal profitability risk."
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average loss development factor — measures how much incurred claims are expected to develop; high factors indicate immature claim patterns."
    - name: "avg_actuarial_confidence_level"
      expr: AVG(CAST(actuarial_confidence_level AS DOUBLE))
      comment: "Average actuarial confidence level for reserve estimates — low confidence triggers additional actuarial review and potential reserve strengthening."
    - name: "reserve_count"
      expr: COUNT(1)
      comment: "Number of IBNR reserve records — tracks reserve estimation coverage across pools and periods."
    - name: "confidence_interval_spread"
      expr: ROUND(AVG(CAST(confidence_interval_upper AS DOUBLE)) - AVG(CAST(confidence_interval_lower AS DOUBLE)), 2)
      comment: "Average spread between upper and lower confidence intervals — measures actuarial uncertainty; wide spreads indicate high reserve estimation risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member-level risk scoring KPIs for CMS risk adjustment, RAF score monitoring, and population health stratification — drives revenue optimization and care management prioritization."
  source: "`vibe_health_insurance_v1`.`risk`.`member_risk_score`"
  filter: is_active = TRUE
  dimensions:
    - name: "risk_score_type"
      expr: risk_score_type
      comment: "Type of risk score (e.g., CMS-HCC, HHS-HCC, Rx-HCC) for model-specific performance analysis."
    - name: "score_methodology_code"
      expr: score_methodology_code
      comment: "Methodology used to compute the score (e.g., CMS-HCC v24, v28) — critical for regulatory compliance and year-over-year comparability."
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year the risk score applies to — aligns scores to revenue recognition periods."
    - name: "risk_score_status"
      expr: risk_score_status
      comment: "Current status of the risk score (submitted, accepted, rejected, pending) for submission pipeline monitoring."
    - name: "risk_adjustment_factor_category"
      expr: risk_adjustment_factor_category
      comment: "Category of risk adjustment factor (demographic, disease, interaction) for decomposition analysis."
    - name: "model_name"
      expr: model_name
      comment: "Name of the risk model used — enables comparison across model versions and types."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk model — tracks model upgrades and their impact on population scores."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag indicating whether the score was manually overridden — monitors data integrity and audit exposure."
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "CMS submission status for the risk score — tracks regulatory submission pipeline health."
    - name: "score_effective_year"
      expr: YEAR(score_effective_date)
      comment: "Year the score became effective — enables annual cohort analysis."
  measures:
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF (Risk Adjustment Factor) score across members — primary CMS revenue driver; higher scores indicate sicker populations and higher expected payments."
    - name: "total_raf_score"
      expr: SUM(CAST(raf_score AS DOUBLE))
      comment: "Sum of RAF scores across the population — used to compute aggregate risk adjustment transfer payments."
    - name: "avg_plan_calculated_score"
      expr: AVG(CAST(plan_calculated_score AS DOUBLE))
      comment: "Average plan-calculated risk score — compared against CMS published scores to identify submission gaps and revenue leakage."
    - name: "avg_cms_published_score"
      expr: AVG(CAST(cms_published_score AS DOUBLE))
      comment: "Average CMS-published risk score — the official score used for payment; deviations from plan score indicate reconciliation risk."
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance between plan-calculated and CMS-published scores — measures risk adjustment revenue leakage or overpayment exposure."
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic component of the risk score — isolates age/gender contribution to overall RAF for population aging analysis."
    - name: "avg_risk_score_confidence"
      expr: AVG(CAST(risk_score_confidence_score AS DOUBLE))
      comment: "Average confidence score for risk score calculations — low confidence scores indicate data quality issues requiring remediation."
    - name: "scored_member_count"
      expr: COUNT(1)
      comment: "Total number of scored member records — measures risk scoring coverage across the enrolled population."
    - name: "manual_override_count"
      expr: COUNT(CASE WHEN is_manual_override = TRUE THEN 1 END)
      comment: "Count of manually overridden risk scores — high counts signal audit risk and potential CMS compliance exposure."
    - name: "plan_vs_cms_score_gap"
      expr: ROUND(AVG(CAST(plan_calculated_score AS DOUBLE)) - AVG(CAST(cms_published_score AS DOUBLE)), 4)
      comment: "Average gap between plan-calculated and CMS-published scores — positive values indicate potential revenue recovery opportunity; negative values indicate overpayment risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for risk pool performance monitoring — tracks financial exposure, risk score distribution, and reserve adequacy across pools to inform actuarial and executive decisions."
  source: "`vibe_health_insurance_v1`.`risk`.`pool`"
  filter: is_active = TRUE
  dimensions:
    - name: "pool_type"
      expr: pool_type
      comment: "Type of risk pool (e.g., individual, small group, Medicare Advantage) for segmenting pool performance."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the pool (e.g., commercial, Medicaid, Medicare) for LOB-level analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g., large group, individual exchange) for competitive and regulatory segmentation."
    - name: "state_code"
      expr: state_code
      comment: "State of operation for geographic risk pool analysis and state-level regulatory reporting."
    - name: "pool_status"
      expr: pool_status
      comment: "Current operational status of the pool (active, closed, run-off) for portfolio management."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the pool became effective, used for year-over-year trend analysis."
    - name: "aca_compliance_flag"
      expr: aca_compliance_flag
      comment: "Indicates whether the pool is ACA-compliant, critical for regulatory segmentation."
  measures:
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims across all pools — primary financial exposure metric for actuarial and CFO review."
    - name: "total_paid_claims"
      expr: SUM(CAST(total_paid_claims AS DOUBLE))
      comment: "Total paid claims — measures actual cash outflow and is compared against incurred to assess IBNR adequacy."
    - name: "total_reserve_amount"
      expr: SUM(CAST(total_reserve_amount AS DOUBLE))
      comment: "Total reserves held across pools — key solvency and RBC metric reviewed by finance and actuarial leadership."
    - name: "total_member_months"
      expr: SUM(CAST(member_months AS DOUBLE))
      comment: "Total member months across pools — denominator for PMPM calculations and enrollment trend analysis."
    - name: "avg_pmpm"
      expr: AVG(CAST(pmpm AS DOUBLE))
      comment: "Average per-member-per-month cost across pools — core actuarial pricing and profitability KPI."
    - name: "avg_risk_score"
      expr: AVG(CAST(average_risk_score AS DOUBLE))
      comment: "Average risk score across pools — indicates population health acuity and drives premium adequacy decisions."
    - name: "risk_score_volatility"
      expr: AVG(CAST(risk_score_stddev AS DOUBLE))
      comment: "Average standard deviation of risk scores within pools — measures population risk concentration and adverse selection exposure."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across pools — directly impacts CMS transfer payments and revenue recognition."
    - name: "active_pool_count"
      expr: COUNT(1)
      comment: "Count of active risk pools — portfolio breadth metric for executive oversight."
    - name: "incurred_to_paid_ratio"
      expr: ROUND(SUM(CAST(total_incurred_claims AS DOUBLE)) / NULLIF(SUM(CAST(total_paid_claims AS DOUBLE)), 0), 4)
      comment: "Ratio of incurred to paid claims — values above 1.0 indicate outstanding IBNR liability; critical for reserve adequacy assessment."
    - name: "reserve_to_incurred_ratio"
      expr: ROUND(SUM(CAST(total_reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_incurred_claims AS DOUBLE)), 0), 4)
      comment: "Reserve coverage ratio — measures whether reserves are sufficient relative to incurred claims; key solvency indicator."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_prospective_risk_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospective risk model KPIs for predictive model performance monitoring, population risk stratification, and care management targeting — enables proactive intervention for high-risk members."
  source: "`vibe_health_insurance_v1`.`risk`.`prospective_risk_model`"
  filter: is_active = TRUE
  dimensions:
    - name: "model_status"
      expr: model_status
      comment: "Current status of the prospective model (development, validation, production, retired) — tracks model lifecycle."
    - name: "model_category"
      expr: model_category
      comment: "Category of prospective model (cost prediction, utilization, readmission) — enables model type performance comparison."
    - name: "risk_model_type"
      expr: risk_model_type
      comment: "Type of risk model — distinguishes clinical, financial, and operational risk models."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment the model targets — enables segment-specific model performance analysis."
    - name: "is_production"
      expr: is_production
      comment: "Indicates whether the model is in production use — distinguishes active models from development/validation versions."
    - name: "cms_model_year"
      expr: cms_model_year
      comment: "CMS model year — aligns prospective models to the correct regulatory payment year."
    - name: "run_year"
      expr: YEAR(run_date)
      comment: "Year the model was run — enables year-over-year model performance trending."
  measures:
    - name: "total_model_runs"
      expr: COUNT(1)
      comment: "Total prospective risk model runs — measures model production frequency and coverage."
    - name: "avg_normalization_factor"
      expr: AVG(CAST(normalization_factor AS DOUBLE))
      comment: "Average normalization factor applied — measures population risk relative to the reference population; values above 1.0 indicate higher-than-average risk."
    - name: "avg_risk_score_max"
      expr: AVG(CAST(risk_score_max AS DOUBLE))
      comment: "Average maximum risk score produced — measures the upper tail of the risk distribution; high values indicate concentration of catastrophic risk."
    - name: "avg_risk_score_min"
      expr: AVG(CAST(risk_score_min AS DOUBLE))
      comment: "Average minimum risk score produced — measures the lower bound of the risk distribution for population health baseline assessment."
    - name: "risk_score_range"
      expr: ROUND(AVG(CAST(risk_score_max AS DOUBLE)) - AVG(CAST(risk_score_min AS DOUBLE)), 4)
      comment: "Average range between max and min risk scores — measures risk score dispersion; wide ranges indicate heterogeneous populations requiring stratified care management."
    - name: "production_model_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_production = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of models in production use — measures model deployment rate and governance of model lifecycle."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_radv_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RADV (Risk Adjustment Data Validation) audit KPIs for CMS audit compliance, payment error rate monitoring, and financial settlement tracking — critical for MA plan revenue integrity and regulatory risk management."
  source: "`vibe_health_insurance_v1`.`risk`.`radv_audit`"
  filter: is_active = TRUE
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the RADV audit (in-progress, complete, appealed) for audit pipeline management."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RADV audit (contract-level, national, targeted) — determines scope and financial exposure."
    - name: "audit_year"
      expr: audit_year
      comment: "Year of the RADV audit — enables year-over-year audit performance trending."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Appeal status for audit findings — tracks contested findings and potential payment recovery."
    - name: "audit_error_flag"
      expr: audit_error_flag
      comment: "Indicates whether the audit identified errors — primary flag for financial exposure assessment."
    - name: "medical_record_request_status"
      expr: medical_record_request_status
      comment: "Status of medical record requests — incomplete records are a leading indicator of audit failure risk."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total RADV audit records — measures audit volume and CMS oversight exposure."
    - name: "total_extrapolated_payment_error"
      expr: SUM(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Total extrapolated payment error from RADV audits — represents the maximum financial liability from CMS payment recoupment; critical CFO and legal metric."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amounts from RADV audits — measures actual financial impact of CMS audit findings on plan revenue."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for audited members — compared against submitted RAF to identify systematic over-coding patterns."
    - name: "audit_error_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_error_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with identified errors — primary RADV compliance KPI; high rates indicate systemic coding or documentation failures."
    - name: "avg_extrapolated_payment_error"
      expr: AVG(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Average extrapolated payment error per audit — normalizes financial exposure for comparison across audit cohorts and years."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_raps_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RAPS (Risk Adjustment Processing System) submission KPIs for CMS risk adjustment compliance monitoring — tracks submission acceptance rates, error rates, and risk adjustment factor performance for Medicare Advantage revenue optimization."
  source: "`vibe_health_insurance_v1`.`risk`.`raps_submission`"
  filter: is_active = TRUE
  dimensions:
    - name: "raps_submission_status"
      expr: raps_submission_status
      comment: "Current status of the RAPS submission (accepted, rejected, pending) — primary pipeline health indicator."
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year for the submission — aligns submissions to revenue recognition and reconciliation periods."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for the submission — enables MA plan-type-level submission performance analysis."
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status — distinguishes between accepted, rejected, and pending CMS responses."
    - name: "risk_adjustment_year"
      expr: risk_adjustment_year
      comment: "Risk adjustment year — aligns submissions to the correct CMS payment reconciliation cycle."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission — tracks submission cadence and deadline compliance."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of RAPS submissions — measures submission volume and pipeline throughput."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across submissions — directly drives CMS payment transfers; declining RAF indicates revenue risk."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score submitted to CMS — measures population acuity as reported for payment purposes."
    - name: "submission_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cms_acknowledgment_status = 'ACCEPTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions accepted by CMS — key compliance and data quality KPI; low rates trigger remediation workflows."
    - name: "submission_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cms_acknowledgment_status = 'REJECTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions rejected by CMS — high rejection rates indicate data quality issues and revenue leakage risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_rate_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial rate development KPIs for premium adequacy monitoring, rate filing compliance, and pricing trend analysis — drives underwriting profitability and regulatory rate approval strategy."
  source: "`vibe_health_insurance_v1`.`risk`.`rate_development`"
  filter: is_active = TRUE
  dimensions:
    - name: "rate_development_status"
      expr: rate_development_status
      comment: "Status of the rate development (draft, filed, approved, rejected) for regulatory pipeline tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the rate development — enables LOB-level pricing performance analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO) for product-level rate analysis."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area — enables regional pricing analysis and competitive benchmarking."
    - name: "rate_methodology"
      expr: rate_methodology
      comment: "Actuarial methodology used for rate development — tracks methodology consistency and regulatory compliance."
    - name: "rating_period_start_year"
      expr: YEAR(rating_period_start)
      comment: "Year the rating period begins — aligns rate developments to plan years for trend analysis."
  measures:
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across rate developments — primary pricing benchmark for actuarial and underwriting review."
    - name: "avg_final_approved_rate"
      expr: AVG(CAST(final_approved_rate AS DOUBLE))
      comment: "Average final approved rate — measures regulatory approval outcomes and premium adequacy."
    - name: "avg_trend_factor"
      expr: AVG(CAST(trend_factor AS DOUBLE))
      comment: "Average medical trend factor — key actuarial assumption driving premium increases; monitored by CFO and Chief Actuary."
    - name: "avg_mlr_target"
      expr: AVG(CAST(mlr_target AS DOUBLE))
      comment: "Average MLR target embedded in rate developments — measures pricing discipline and ACA MLR compliance planning."
    - name: "avg_credibility_factor"
      expr: AVG(CAST(credibility_factor AS DOUBLE))
      comment: "Average credibility factor — measures statistical reliability of experience data; low credibility increases pricing uncertainty."
    - name: "avg_profit_margin"
      expr: AVG(CAST(profit_margin AS DOUBLE))
      comment: "Average profit margin built into rates — primary financial sustainability metric for pricing strategy decisions."
    - name: "rate_development_count"
      expr: COUNT(1)
      comment: "Total rate development records — measures pricing activity volume and regulatory filing workload."
    - name: "rate_increase_factor"
      expr: ROUND(AVG(CAST(final_approved_rate AS DOUBLE)) / NULLIF(AVG(CAST(base_rate AS DOUBLE)), 0), 4)
      comment: "Ratio of final approved rate to base rate — measures the magnitude of rate adjustments through the development process; values above 1.0 indicate rate increases."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_rbc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-Based Capital (RBC) calculation KPIs for solvency monitoring, regulatory capital adequacy compliance, and financial stability assessment — critical for state DOI reporting and executive financial oversight."
  source: "`vibe_health_insurance_v1`.`risk`.`rbc_calculation`"
  filter: is_active = TRUE
  dimensions:
    - name: "rbc_status"
      expr: rbc_status
      comment: "Current RBC status (adequate, company action level, regulatory action level) — primary solvency classification for regulatory and executive action."
    - name: "action_threshold_status"
      expr: action_threshold_status
      comment: "RBC action threshold status — indicates whether regulatory intervention thresholds have been breached."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used for RBC calculation — ensures methodology consistency across reporting periods."
    - name: "calculation_period_year"
      expr: YEAR(calculation_period_start_date)
      comment: "Year of the RBC calculation period — enables year-over-year solvency trend analysis."
  measures:
    - name: "avg_rbc_ratio"
      expr: AVG(CAST(rbc_ratio AS DOUBLE))
      comment: "Average RBC ratio (Total Adjusted Capital / Authorized Control Level RBC) — primary solvency metric; ratios below 200% trigger regulatory action under NAIC standards."
    - name: "avg_total_adjusted_capital"
      expr: AVG(CAST(total_adjusted_capital AS DOUBLE))
      comment: "Average total adjusted capital — measures the capital base available to absorb losses; key financial strength indicator."
    - name: "avg_authorized_control_level_rbc"
      expr: AVG(CAST(authorized_control_level_rbc AS DOUBLE))
      comment: "Average authorized control level RBC — the regulatory minimum capital threshold; used to compute the RBC ratio."
    - name: "avg_company_action_level_rbc"
      expr: AVG(CAST(company_action_level_rbc AS DOUBLE))
      comment: "Average company action level RBC — the threshold at which the company must file a corrective action plan with the state DOI."
    - name: "avg_h1_underwriting_risk"
      expr: AVG(CAST(h1_underwriting_risk AS DOUBLE))
      comment: "Average H1 underwriting risk component — measures insurance risk exposure; largest RBC component for health plans."
    - name: "avg_h2_credit_risk"
      expr: AVG(CAST(h2_credit_risk AS DOUBLE))
      comment: "Average H2 credit risk component — measures counterparty and receivable default risk in the capital calculation."
    - name: "avg_covariance_adjustment"
      expr: AVG(CAST(covariance_adjustment AS DOUBLE))
      comment: "Average covariance adjustment — measures the diversification benefit across RBC risk components; larger adjustments indicate better risk diversification."
    - name: "rbc_calculation_count"
      expr: COUNT(1)
      comment: "Total RBC calculation records — tracks calculation frequency and regulatory reporting completeness."
    - name: "capital_adequacy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rbc_ratio >= 2.0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RBC calculations meeting the 200% adequacy threshold — measures overall solvency compliance rate across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_reinsurance_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance arrangement KPIs for stop-loss program management, premium cession monitoring, and catastrophic risk transfer effectiveness — informs reinsurance purchasing strategy and financial risk management."
  source: "`vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`"
  filter: is_active = TRUE
  dimensions:
    - name: "reinsurance_arrangement_status"
      expr: reinsurance_arrangement_status
      comment: "Current status of the reinsurance arrangement (active, expired, terminated) — tracks program portfolio."
    - name: "treaty_type"
      expr: treaty_type
      comment: "Type of reinsurance treaty (quota share, excess of loss, stop-loss) — enables analysis by reinsurance structure."
    - name: "stop_loss_type"
      expr: stop_loss_type
      comment: "Type of stop-loss arrangement (specific, aggregate) — distinguishes individual vs. aggregate risk transfer."
    - name: "lob_coverage"
      expr: lob_coverage
      comment: "Line of business covered by the arrangement — enables LOB-level reinsurance coverage analysis."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the arrangement became effective — enables year-over-year reinsurance program analysis."
  measures:
    - name: "total_arrangements"
      expr: COUNT(1)
      comment: "Total reinsurance arrangements — measures reinsurance program breadth and counterparty diversification."
    - name: "total_premium_ceded"
      expr: SUM(CAST(premium_ceded AS DOUBLE))
      comment: "Total premium ceded to reinsurers — measures the cost of risk transfer; compared against recoveries to assess program ROI."
    - name: "avg_attachment_point"
      expr: AVG(CAST(attachment_point AS DOUBLE))
      comment: "Average attachment point across arrangements — measures the self-insured retention level before reinsurance coverage begins."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold — measures the aggregate loss level at which stop-loss coverage activates."
    - name: "avg_maximum_liability"
      expr: AVG(CAST(maximum_liability AS DOUBLE))
      comment: "Average maximum reinsurer liability — measures the cap on reinsurance recoveries and residual risk retained."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage — measures the proportion of losses shared with reinsurers under quota share arrangements."
    - name: "avg_maximum_recovery_limit"
      expr: AVG(CAST(maximum_recovery_limit AS DOUBLE))
      comment: "Average maximum recovery limit — caps total recoverable amounts; arrangements near limits indicate potential exposure gaps."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_reinsurance_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance claim KPIs for stop-loss recovery monitoring, reinsurance program effectiveness, and catastrophic loss management — informs reinsurance purchasing strategy and financial risk transfer decisions."
  source: "`vibe_health_insurance_v1`.`risk`.`reinsurance_claim`"
  filter: is_active = TRUE
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the reinsurance claim (submitted, accepted, paid, denied) for recovery pipeline tracking."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of reinsurance claim (specific, aggregate) — distinguishes individual large-claim recoveries from aggregate stop-loss."
    - name: "loss_category"
      expr: loss_category
      comment: "Category of loss (medical, pharmacy, behavioral) — enables loss type analysis for reinsurance program design."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Recovery status (pending, received, disputed) — tracks cash recovery pipeline for treasury and finance."
    - name: "covered_year"
      expr: YEAR(covered_start_date)
      comment: "Year of covered loss — aligns reinsurance recoveries to the underlying claim year for program evaluation."
    - name: "is_aggregated"
      expr: is_aggregated
      comment: "Indicates whether the claim is an aggregate stop-loss claim — distinguishes aggregate from specific reinsurance recoveries."
  measures:
    - name: "total_incurred_amount"
      expr: SUM(CAST(total_incurred_amount AS DOUBLE))
      comment: "Total incurred loss amount submitted for reinsurance recovery — measures gross financial exposure ceded to reinsurers."
    - name: "total_recoverable_amount"
      expr: SUM(CAST(recoverable_amount AS DOUBLE))
      comment: "Total amount recoverable from reinsurers — measures expected cash recovery and net financial exposure after reinsurance."
    - name: "total_attachment_point_amount"
      expr: SUM(CAST(attachment_point_amount AS DOUBLE))
      comment: "Total attachment point amounts across claims — measures the self-insured retention layer before reinsurance kicks in."
    - name: "reinsurance_claim_count"
      expr: COUNT(1)
      comment: "Total reinsurance claims submitted — measures frequency of large-loss events and reinsurance program utilization."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recoverable_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_incurred_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of incurred losses recoverable from reinsurers — measures reinsurance program effectiveness and net loss retention."
    - name: "avg_incurred_per_claim"
      expr: AVG(CAST(total_incurred_amount AS DOUBLE))
      comment: "Average incurred amount per reinsurance claim — measures severity of large-loss events triggering reinsurance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS risk adjustment submission KPIs for encounter data submission compliance, error rate monitoring, and risk adjustment revenue tracking — critical for MA plan regulatory compliance and revenue integrity."
  source: "`vibe_health_insurance_v1`.`risk`.`risk_cms_submission`"
  filter: is_active = TRUE
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the CMS submission (submitted, accepted, rejected, pending) for pipeline monitoring."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission (initial, correction, delete) — tracks submission lifecycle and correction volumes."
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year — aligns submissions to revenue recognition and reconciliation cycles."
    - name: "service_year"
      expr: service_year
      comment: "Service year for the encounter data — enables lag analysis between service delivery and submission."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter submitted (inpatient, outpatient, professional) for submission mix analysis."
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status — distinguishes accepted vs. rejected submissions for compliance tracking."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission — tracks submission cadence and regulatory deadline compliance."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total CMS risk adjustment submissions — measures submission volume and regulatory activity."
    - name: "total_accepted_records"
      expr: SUM(CAST(accepted_record_count AS DOUBLE))
      comment: "Total records accepted by CMS — measures successful data submission volume driving risk adjustment payments."
    - name: "total_rejected_records"
      expr: SUM(CAST(rejected_record_count AS DOUBLE))
      comment: "Total records rejected by CMS — high rejection counts indicate data quality failures and revenue risk."
    - name: "total_record_count"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Total records submitted to CMS — denominator for acceptance and rejection rate calculations."
    - name: "record_acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_record_count AS DOUBLE)) / NULLIF(SUM(CAST(record_count AS DOUBLE)), 0), 2)
      comment: "Percentage of submitted records accepted by CMS — primary data quality and compliance KPI for encounter data submissions."
    - name: "record_rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_record_count AS DOUBLE)) / NULLIF(SUM(CAST(record_count AS DOUBLE)), 0), 2)
      comment: "Percentage of submitted records rejected by CMS — drives remediation prioritization and revenue recovery efforts."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment payment amount from CMS submissions — direct revenue impact metric for CFO and actuarial review."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across submissions — measures population acuity as recognized by CMS for payment."
    - name: "avg_risk_adjustment_score"
      expr: AVG(CAST(risk_adjustment_score AS DOUBLE))
      comment: "Average risk adjustment score — tracks score trends across submission cycles to identify population health changes."
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total claim amount underlying CMS submissions — measures the financial basis for risk adjustment transfer payments."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net risk adjustment amount — represents the net financial impact after CMS reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting case KPIs for group risk assessment, premium adequacy monitoring, and underwriting decision quality — drives underwriting profitability and portfolio risk management."
  source: "`vibe_health_insurance_v1`.`risk`.`risk_underwriting_case`"
  filter: is_active = TRUE
  dimensions:
    - name: "risk_underwriting_case_status"
      expr: risk_underwriting_case_status
      comment: "Current status of the underwriting case (pending, approved, declined, referred) for pipeline management."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification assigned to the group (standard, substandard, preferred) — primary underwriting decision output."
    - name: "underwriting_tier"
      expr: underwriting_tier
      comment: "Underwriting tier assigned — drives premium rate selection and risk pooling decisions."
    - name: "lob"
      expr: lob
      comment: "Line of business for the underwriting case — enables LOB-level underwriting performance analysis."
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant (new business, renewal, conversion) — distinguishes new vs. renewal underwriting performance."
    - name: "medical_underwriting_status"
      expr: medical_underwriting_status
      comment: "Medical underwriting status — tracks cases requiring clinical review vs. standard processing."
    - name: "is_self_insured"
      expr: is_self_insured
      comment: "Indicates self-insured arrangements — ASO cases have different risk and revenue profiles than fully-insured."
    - name: "reinsurance_flag"
      expr: reinsurance_flag
      comment: "Indicates whether reinsurance was placed for this case — tracks stop-loss purchasing decisions."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the underwriting case becomes effective — enables cohort analysis of underwriting decisions."
  measures:
    - name: "total_underwriting_cases"
      expr: COUNT(1)
      comment: "Total underwriting cases — measures underwriting pipeline volume and workload."
    - name: "avg_gross_premium_amount"
      expr: AVG(CAST(gross_premium_amount AS DOUBLE))
      comment: "Average gross premium amount per underwriting case — measures revenue per group and premium adequacy."
    - name: "total_gross_premium_amount"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium from underwriting cases — measures total revenue in the underwriting pipeline."
    - name: "avg_net_premium_amount"
      expr: AVG(CAST(net_premium_amount AS DOUBLE))
      comment: "Average net premium after adjustments — measures actual revenue retained after reinsurance and adjustments."
    - name: "avg_overall_group_risk_score"
      expr: AVG(CAST(overall_group_risk_score AS DOUBLE))
      comment: "Average group risk score — measures population health acuity of underwritten groups; high scores indicate adverse selection risk."
    - name: "avg_expected_claims_pmpm"
      expr: AVG(CAST(expected_claims_pmpm AS DOUBLE))
      comment: "Average expected claims PMPM — actuarial projection of claims cost; compared against premium to assess profitability."
    - name: "avg_morbidity_factor"
      expr: AVG(CAST(morbidity_factor AS DOUBLE))
      comment: "Average morbidity factor applied — measures health status adjustment to base rates across the underwriting portfolio."
    - name: "avg_premium_rate"
      expr: AVG(CAST(premium_rate AS DOUBLE))
      comment: "Average premium rate per underwriting case — tracks pricing levels and rate adequacy across the book of business."
    - name: "avg_industry_risk_factor"
      expr: AVG(CAST(industry_risk_factor AS DOUBLE))
      comment: "Average industry risk factor — measures occupational risk loading across the group portfolio."
    - name: "premium_to_claims_ratio"
      expr: ROUND(AVG(CAST(gross_premium_amount AS DOUBLE)) / NULLIF(AVG(CAST(expected_claims_pmpm AS DOUBLE)), 0), 4)
      comment: "Ratio of gross premium to expected claims PMPM — measures premium adequacy at the case level; values below 1.0 indicate underpriced cases."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_score_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk score run KPIs for RAF score production monitoring, model performance tracking, and CMS submission readiness — ensures accurate and timely risk score production for revenue optimization."
  source: "`vibe_health_insurance_v1`.`risk`.`score_run`"
  filter: is_active = TRUE
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the score run (completed, failed, in-progress) — primary production pipeline health indicator."
    - name: "run_type"
      expr: run_type
      comment: "Type of score run (initial, mid-year, final, sweep) — distinguishes production runs from interim estimates."
    - name: "model_name"
      expr: model_name
      comment: "Risk model used for the run — enables model version comparison and performance benchmarking."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk model — tracks model upgrades and their population-level impact."
    - name: "cms_model_year"
      expr: cms_model_year
      comment: "CMS model year — aligns score runs to the correct CMS payment year for regulatory compliance."
    - name: "risk_model_type"
      expr: risk_model_type
      comment: "Type of risk model (CMS-HCC, HHS-HCC, Rx-HCC) — enables model-type-level performance analysis."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment scored (Medicare, Medicaid, Commercial) — enables segment-level score monitoring."
    - name: "run_date_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of the score run — tracks production cadence and identifies gaps in scoring coverage."
  measures:
    - name: "total_score_runs"
      expr: COUNT(1)
      comment: "Total score runs executed — measures scoring production volume and cadence."
    - name: "total_member_population_scored"
      expr: SUM(CAST(member_population_count AS DOUBLE))
      comment: "Total members scored across all runs — measures scoring coverage of the enrolled population."
    - name: "avg_raf_score"
      expr: AVG(CAST(average_raf_score AS DOUBLE))
      comment: "Average RAF score across score runs — tracks population risk acuity trends over time; declining RAF signals revenue risk."
    - name: "total_raf_score"
      expr: SUM(CAST(total_raf_score AS DOUBLE))
      comment: "Sum of total RAF scores across runs — measures aggregate risk adjustment revenue basis across the population."
    - name: "avg_normalization_factor"
      expr: AVG(CAST(normalization_factor AS DOUBLE))
      comment: "Average normalization factor applied — CMS-mandated adjustment to RAF scores; deviations from 1.0 indicate population risk relative to national average."
    - name: "successful_run_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN run_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of score runs completing successfully — measures production reliability; failures delay CMS submissions and risk revenue."
$$;
