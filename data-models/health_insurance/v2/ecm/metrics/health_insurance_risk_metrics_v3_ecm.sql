-- Metric views for domain: risk | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk pool performance metrics tracking member months, claims experience, risk scores, and financial adequacy across market segments and lines of business."
  source: "`vibe_health_insurance_v1`.`risk`.`pool`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business classification (Commercial, Medicare Advantage, Medicaid, ACA Marketplace)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment categorization (Large Group, Small Group, Individual)"
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction code for regulatory and geographic analysis"
    - name: "pool_status"
      expr: pool_status
      comment: "Current operational status of the risk pool"
    - name: "pool_type"
      expr: pool_type
      comment: "Risk pool type classification"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Calendar year the pool became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Fiscal quarter of pool effective date"
    - name: "aca_compliance_flag"
      expr: aca_compliance_flag
      comment: "Indicates whether pool is subject to ACA compliance requirements"
    - name: "is_excluded_from_mlr"
      expr: is_excluded_from_mlr
      comment: "Flag indicating exclusion from Medical Loss Ratio calculations"
  measures:
    - name: "total_member_months"
      expr: SUM(CAST(member_months AS DOUBLE))
      comment: "Total member months of coverage across all pools - key volume metric for premium and claims normalization"
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims liability including paid and reserved amounts"
    - name: "total_paid_claims"
      expr: SUM(CAST(total_paid_claims AS DOUBLE))
      comment: "Total paid claims amount excluding reserves"
    - name: "total_reserve_amount"
      expr: SUM(CAST(total_reserve_amount AS DOUBLE))
      comment: "Total claims reserves held for IBNR and case reserves"
    - name: "avg_pmpm"
      expr: AVG(CAST(pmpm AS DOUBLE))
      comment: "Average per-member-per-month cost - critical efficiency metric for pricing and trend analysis"
    - name: "avg_risk_score"
      expr: AVG(CAST(average_risk_score AS DOUBLE))
      comment: "Average risk adjustment factor score across pools - drives CMS payment adjustments"
    - name: "weighted_avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to pool premiums and reserves"
    - name: "loss_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_incurred_claims AS DOUBLE)) / NULLIF(SUM(CAST(member_months AS DOUBLE)) * AVG(CAST(pmpm AS DOUBLE)), 0), 2)
      comment: "Incurred loss ratio percentage - critical MLR compliance and profitability metric"
    - name: "reserve_to_incurred_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_incurred_claims AS DOUBLE)), 0), 2)
      comment: "Reserve adequacy ratio - measures reserve strength relative to total incurred claims"
    - name: "pool_count"
      expr: COUNT(DISTINCT pool_id)
      comment: "Number of distinct risk pools - tracks portfolio segmentation and complexity"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member-level risk score metrics tracking CMS risk adjustment scores, HCC coding, and payment accuracy for Medicare Advantage and ACA populations."
  source: "`vibe_health_insurance_v1`.`risk`.`member_risk_score`"
  dimensions:
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year for risk adjustment - drives prospective payment rates"
    - name: "model_name"
      expr: model_name
      comment: "CMS risk adjustment model name (CMS-HCC, RxHCC, ESRD)"
    - name: "model_version"
      expr: model_version
      comment: "Risk model version identifier for tracking regulatory changes"
    - name: "risk_score_type"
      expr: risk_score_type
      comment: "Type of risk score (Community, Institutional, New Enrollee)"
    - name: "risk_score_status"
      expr: risk_score_status
      comment: "Current status of risk score calculation and submission"
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "Status of risk score submission to CMS for payment reconciliation"
    - name: "risk_adjustment_factor_category"
      expr: risk_adjustment_factor_category
      comment: "RAF category classification for segmentation analysis"
    - name: "variance_category"
      expr: variance_category
      comment: "Categorization of score variance between plan and CMS calculations"
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag indicating manual intervention in risk score calculation"
    - name: "score_effective_year"
      expr: YEAR(score_effective_date)
      comment: "Calendar year the risk score became effective"
  measures:
    - name: "avg_plan_calculated_score"
      expr: AVG(CAST(plan_calculated_score AS DOUBLE))
      comment: "Average plan-calculated risk score - internal actuarial estimate for pricing and reserving"
    - name: "avg_cms_published_score"
      expr: AVG(CAST(cms_published_score AS DOUBLE))
      comment: "Average CMS-published risk score - official payment adjustment factor"
    - name: "avg_risk_score_value"
      expr: AVG(CAST(risk_score_value AS DOUBLE))
      comment: "Average overall risk score value across all members"
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic component of risk score (age, gender, Medicaid status)"
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance between plan and CMS scores - key audit and reconciliation metric"
    - name: "avg_risk_score_confidence"
      expr: AVG(CAST(risk_score_confidence_score AS DOUBLE))
      comment: "Average confidence score for risk score accuracy - data quality indicator"
    - name: "total_member_risk_scores"
      expr: COUNT(DISTINCT member_risk_score_id)
      comment: "Total number of member risk score records - tracks scoring coverage and completeness"
    - name: "unique_members_scored"
      expr: COUNT(DISTINCT identity_id)
      comment: "Distinct count of members with risk scores - measures population coverage"
    - name: "plan_cms_score_gap"
      expr: ROUND(AVG(CAST(plan_calculated_score AS DOUBLE)) - AVG(CAST(cms_published_score AS DOUBLE)), 4)
      comment: "Average gap between plan and CMS scores - critical for payment reconciliation and RADV audit risk"
    - name: "manual_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_manual_override = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk scores requiring manual override - data quality and process efficiency indicator"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_adjustment_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment payment metrics tracking CMS payment reconciliations, retroactive adjustments, and revenue impact from risk score changes."
  source: "`vibe_health_insurance_v1`.`risk`.`adjustment_payment`"
  dimensions:
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year for risk adjustment reconciliation"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of risk adjustment payment (Initial, Mid-Year, Final Reconciliation)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of payment processing and reconciliation"
    - name: "program_type"
      expr: program_type
      comment: "CMS program type (Medicare Advantage, ACA Marketplace)"
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Standardized code for payment adjustment reason"
    - name: "payment_source"
      expr: payment_source
      comment: "Source of payment adjustment (CMS, State, Internal Correction)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of payment record"
    - name: "reconciliation_flag"
      expr: reconciliation_flag
      comment: "Indicates whether payment is part of reconciliation process"
    - name: "payment_effective_year"
      expr: YEAR(payment_effective_date)
      comment: "Calendar year the payment became effective"
    - name: "payment_effective_quarter"
      expr: CONCAT('Q', QUARTER(payment_effective_date), '-', YEAR(payment_effective_date))
      comment: "Fiscal quarter of payment effective date"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment payment amount - critical revenue impact metric for financial planning"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount before adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after all adjustments - actual cash impact"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with adjustment payments"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment amount per payment record"
    - name: "total_payment_records"
      expr: COUNT(DISTINCT adjustment_payment_id)
      comment: "Total number of adjustment payment records - tracks reconciliation volume"
    - name: "unique_members_adjusted"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of members with payment adjustments - measures adjustment breadth"
    - name: "net_adjustment_rate"
      expr: ROUND(100.0 * SUM(CAST(adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Net adjustment as percentage of gross payment - key variance metric for budget accuracy"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_rate_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate development metrics tracking actuarial rate-setting, trend factors, loading components, and regulatory filing status."
  source: "`vibe_health_insurance_v1`.`risk`.`rate_development`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for rate development (Commercial, Medicare, Medicaid)"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type classification (HMO, PPO, EPO, POS)"
    - name: "rate_development_status"
      expr: rate_development_status
      comment: "Current status of rate development process (Draft, Filed, Approved, Implemented)"
    - name: "rate_methodology"
      expr: rate_methodology
      comment: "Actuarial methodology used for rate development"
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area for premium variation"
    - name: "rating_period_year"
      expr: YEAR(rating_period_start)
      comment: "Calendar year of rating period start"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Calendar year the rates become effective"
    - name: "regulatory_filing_reference"
      expr: regulatory_filing_reference
      comment: "Reference number for regulatory rate filing"
  measures:
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base premium rate before adjustments - foundation for all pricing"
    - name: "avg_final_approved_rate"
      expr: AVG(CAST(final_approved_rate AS DOUBLE))
      comment: "Average final approved premium rate - actual market rate after regulatory review"
    - name: "avg_trend_factor"
      expr: AVG(CAST(trend_factor AS DOUBLE))
      comment: "Average trend factor applied to rates - key driver of year-over-year rate changes"
    - name: "avg_administrative_loading"
      expr: AVG(CAST(administrative_loading AS DOUBLE))
      comment: "Average administrative expense loading percentage"
    - name: "avg_profit_margin"
      expr: AVG(CAST(profit_margin AS DOUBLE))
      comment: "Average profit margin percentage - target underwriting gain"
    - name: "avg_mlr_target"
      expr: AVG(CAST(mlr_target AS DOUBLE))
      comment: "Average Medical Loss Ratio target - regulatory compliance threshold"
    - name: "avg_credibility_factor"
      expr: AVG(CAST(credibility_factor AS DOUBLE))
      comment: "Average credibility weighting factor for experience rating"
    - name: "avg_age_factor"
      expr: AVG(CAST(age_factor AS DOUBLE))
      comment: "Average age adjustment factor applied to base rates"
    - name: "avg_geographic_factor"
      expr: AVG(CAST(geographic_factor AS DOUBLE))
      comment: "Average geographic cost variation factor"
    - name: "total_rate_developments"
      expr: COUNT(DISTINCT rate_development_id)
      comment: "Total number of rate development records - tracks pricing activity volume"
    - name: "rate_increase_percentage"
      expr: ROUND(100.0 * (AVG(CAST(final_approved_rate AS DOUBLE)) - AVG(CAST(base_rate AS DOUBLE))) / NULLIF(AVG(CAST(base_rate AS DOUBLE)), 0), 2)
      comment: "Average percentage increase from base to final approved rate - key market competitiveness metric"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_ibnr_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incurred But Not Reported reserve metrics tracking actuarial reserve adequacy, development factors, and risk-based capital impact."
  source: "`vibe_health_insurance_v1`.`risk`.`ibnr_reserve`"
  dimensions:
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for reserve segmentation"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type classification for reserve stratification"
    - name: "ibnr_reserve_status"
      expr: ibnr_reserve_status
      comment: "Current status of IBNR reserve calculation"
    - name: "reserve_methodology"
      expr: reserve_methodology
      comment: "Actuarial methodology used for IBNR calculation (Chain Ladder, Bornhuetter-Ferguson)"
    - name: "reserve_name"
      expr: reserve_name
      comment: "Named reserve category for reporting"
    - name: "service_month_year"
      expr: DATE_TRUNC('MONTH', service_month)
      comment: "Service month for incurred claims - key dimension for lag analysis"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Calendar year of reserve valuation"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(valuation_date), '-', YEAR(valuation_date))
      comment: "Fiscal quarter of reserve valuation"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether reserve is included in regulatory financial statements"
    - name: "reserve_adequacy_flag"
      expr: reserve_adequacy_flag
      comment: "Flag indicating whether reserve meets adequacy standards"
  measures:
    - name: "total_ibnr_amount"
      expr: SUM(CAST(ibnr_amount AS DOUBLE))
      comment: "Total IBNR reserve amount - critical balance sheet liability for financial solvency"
    - name: "avg_ibnr_pmpm"
      expr: AVG(CAST(ibnr_pmpm AS DOUBLE))
      comment: "Average IBNR per member per month - normalized reserve metric for trend analysis"
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average claims development factor - measures claim lag and completion patterns"
    - name: "avg_expected_loss_ratio"
      expr: AVG(CAST(expected_loss_ratio AS DOUBLE))
      comment: "Average expected loss ratio used in reserve calculation"
    - name: "total_hcc_weighted_amount"
      expr: SUM(CAST(hcc_weighted_amount AS DOUBLE))
      comment: "Total HCC risk-adjusted IBNR amount - incorporates member acuity into reserves"
    - name: "total_rbc_impact_amount"
      expr: SUM(CAST(rbc_impact_amount AS DOUBLE))
      comment: "Total risk-based capital impact of IBNR reserves - regulatory capital requirement driver"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to IBNR reserves"
    - name: "avg_confidence_interval_width"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE) - CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average width of confidence interval - measures reserve estimate uncertainty"
    - name: "avg_actuarial_confidence_level"
      expr: AVG(CAST(actuarial_confidence_level AS DOUBLE))
      comment: "Average actuarial confidence level for reserve adequacy"
    - name: "total_reserve_records"
      expr: COUNT(DISTINCT ibnr_reserve_id)
      comment: "Total number of IBNR reserve records - tracks reserve granularity"
    - name: "reserve_adequacy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reserve_adequacy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reserves meeting adequacy standards - key solvency risk indicator"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_reinsurance_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance arrangement metrics tracking stop-loss coverage, attachment points, premium ceded, and maximum liability limits."
  source: "`vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`"
  dimensions:
    - name: "treaty_type"
      expr: treaty_type
      comment: "Type of reinsurance treaty (Quota Share, Excess of Loss, Stop Loss)"
    - name: "stop_loss_type"
      expr: stop_loss_type
      comment: "Stop loss coverage type (Specific, Aggregate, Both)"
    - name: "reinsurance_arrangement_status"
      expr: reinsurance_arrangement_status
      comment: "Current status of reinsurance arrangement"
    - name: "lob_coverage"
      expr: lob_coverage
      comment: "Lines of business covered by reinsurance arrangement"
    - name: "reinsurer_name"
      expr: reinsurer_name
      comment: "Name of reinsurance carrier"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Calendar year the reinsurance arrangement became effective"
    - name: "arrangement_number"
      expr: arrangement_number
      comment: "Unique identifier for reinsurance arrangement"
  measures:
    - name: "total_premium_ceded"
      expr: SUM(CAST(premium_ceded AS DOUBLE))
      comment: "Total premium ceded to reinsurers - cost of reinsurance protection"
    - name: "avg_attachment_point"
      expr: AVG(CAST(attachment_point AS DOUBLE))
      comment: "Average attachment point for reinsurance coverage - threshold where reinsurance begins"
    - name: "avg_specific_deductible"
      expr: AVG(CAST(specific_deductible AS DOUBLE))
      comment: "Average specific deductible per claim before reinsurance coverage"
    - name: "avg_stop_loss_deductible"
      expr: AVG(CAST(stop_loss_deductible AS DOUBLE))
      comment: "Average aggregate stop loss deductible - total claims before reinsurance"
    - name: "avg_stop_loss_limit"
      expr: AVG(CAST(stop_loss_limit AS DOUBLE))
      comment: "Average maximum stop loss coverage limit"
    - name: "total_maximum_liability"
      expr: SUM(CAST(maximum_liability AS DOUBLE))
      comment: "Total maximum reinsurer liability across all arrangements - total protection purchased"
    - name: "total_maximum_recovery_limit"
      expr: SUM(CAST(maximum_recovery_limit AS DOUBLE))
      comment: "Total maximum recoverable amount from reinsurers"
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage shared with reinsurer"
    - name: "avg_corridor_percentage"
      expr: AVG(CAST(corridor_percentage AS DOUBLE))
      comment: "Average corridor percentage retained before reinsurance applies"
    - name: "total_arrangements"
      expr: COUNT(DISTINCT reinsurance_arrangement_id)
      comment: "Total number of reinsurance arrangements - tracks risk transfer complexity"
    - name: "avg_coverage_leverage"
      expr: ROUND(AVG(CAST(maximum_liability AS DOUBLE)) / NULLIF(AVG(CAST(premium_ceded AS DOUBLE)), 0), 2)
      comment: "Average leverage ratio of coverage to premium - efficiency of reinsurance spend"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_rbc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-Based Capital calculation metrics tracking regulatory capital adequacy, RBC ratio, action level thresholds, and solvency risk components."
  source: "`vibe_health_insurance_v1`.`risk`.`rbc_calculation`"
  dimensions:
    - name: "rbc_status"
      expr: rbc_status
      comment: "Current RBC status classification (No Action, Company Action, Regulatory Action, Authorized Control)"
    - name: "action_threshold_status"
      expr: action_threshold_status
      comment: "Action level threshold status for regulatory intervention"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Methodology used for RBC calculation (NAIC formula, state-specific)"
    - name: "calculation_period_year"
      expr: YEAR(calculation_period_start_date)
      comment: "Calendar year of RBC calculation period"
    - name: "calculation_number"
      expr: calculation_number
      comment: "Unique calculation identifier for audit trail"
  measures:
    - name: "avg_rbc_ratio"
      expr: AVG(CAST(rbc_ratio AS DOUBLE))
      comment: "Average RBC ratio - critical solvency metric for regulatory compliance (target >200%)"
    - name: "avg_total_adjusted_capital"
      expr: AVG(CAST(total_adjusted_capital AS DOUBLE))
      comment: "Average total adjusted capital - numerator of RBC ratio"
    - name: "avg_authorized_control_level_rbc"
      expr: AVG(CAST(authorized_control_level_rbc AS DOUBLE))
      comment: "Average authorized control level RBC - regulatory seizure threshold"
    - name: "avg_company_action_level_rbc"
      expr: AVG(CAST(company_action_level_rbc AS DOUBLE))
      comment: "Average company action level RBC - threshold requiring corrective action plan"
    - name: "avg_h0_asset_risk"
      expr: AVG(CAST(h0_asset_risk AS DOUBLE))
      comment: "Average H0 asset risk component - investment portfolio risk"
    - name: "avg_h1_underwriting_risk"
      expr: AVG(CAST(h1_underwriting_risk AS DOUBLE))
      comment: "Average H1 underwriting risk component - insurance liability risk"
    - name: "avg_h2_credit_risk"
      expr: AVG(CAST(h2_credit_risk AS DOUBLE))
      comment: "Average H2 credit risk component - counterparty default risk"
    - name: "avg_h3_business_risk"
      expr: AVG(CAST(h3_business_risk AS DOUBLE))
      comment: "Average H3 business risk component - operational and strategic risk"
    - name: "avg_h4_admin_expense_risk"
      expr: AVG(CAST(h4_admin_expense_risk AS DOUBLE))
      comment: "Average H4 administrative expense risk component"
    - name: "avg_covariance_adjustment"
      expr: AVG(CAST(covariance_adjustment AS DOUBLE))
      comment: "Average covariance adjustment for risk diversification"
    - name: "total_calculations"
      expr: COUNT(DISTINCT rbc_calculation_id)
      comment: "Total number of RBC calculations - tracks calculation frequency and entities"
    - name: "capital_adequacy_margin"
      expr: ROUND(AVG(CAST(total_adjusted_capital AS DOUBLE)) - AVG(CAST(company_action_level_rbc AS DOUBLE)), 2)
      comment: "Average capital cushion above company action level - measures solvency buffer"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_radv_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Adjustment Data Validation audit metrics tracking CMS RADV audit results, payment error rates, extrapolated errors, and appeal outcomes."
  source: "`vibe_health_insurance_v1`.`risk`.`radv_audit`"
  dimensions:
    - name: "audit_year"
      expr: audit_year
      comment: "CMS audit year for RADV validation"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RADV audit (Initial Validation, RADV, Contract-Level)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of RADV audit process"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of audit findings appeal"
    - name: "audit_source"
      expr: audit_source
      comment: "Source of audit (CMS, Internal, Third-Party)"
    - name: "medical_record_request_status"
      expr: medical_record_request_status
      comment: "Status of medical record retrieval for audit"
    - name: "audit_error_flag"
      expr: audit_error_flag
      comment: "Flag indicating audit errors were found"
    - name: "contract_number"
      expr: contract_number
      comment: "CMS contract number under audit"
    - name: "hcc_mapping_version"
      expr: hcc_mapping_version
      comment: "HCC model version used in audit"
  measures:
    - name: "total_extrapolated_payment_error"
      expr: SUM(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Total extrapolated payment error from audit sample - projected financial exposure"
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amount after audit resolution - actual financial impact"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor validated in audit"
    - name: "total_audits"
      expr: COUNT(DISTINCT radv_audit_id)
      comment: "Total number of RADV audits - tracks audit volume and exposure"
    - name: "unique_members_audited"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of members included in RADV audits"
    - name: "audit_error_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_error_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with errors found - key quality and compliance metric"
    - name: "avg_extrapolated_error_per_audit"
      expr: AVG(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Average extrapolated error per audit - measures typical audit exposure"
    - name: "settlement_to_error_ratio"
      expr: ROUND(100.0 * SUM(CAST(final_settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(extrapolated_payment_error AS DOUBLE)), 0), 2)
      comment: "Final settlement as percentage of extrapolated error - measures appeal success rate"
$$;
