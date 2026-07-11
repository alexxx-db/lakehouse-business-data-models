-- Metric views for domain: risk | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member-level risk scoring metrics for CMS risk adjustment, payment accuracy, and population health management. Tracks risk score variance, demographic factors, and submission status for financial forecasting and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`member_risk_score`"
  dimensions:
    - name: "model_version"
      expr: model_version
      comment: "CMS HCC model version used for risk score calculation (e.g., V24, V28)"
    - name: "payment_year"
      expr: payment_year
      comment: "Calendar year for which risk-adjusted payments are calculated"
    - name: "risk_score_status"
      expr: risk_score_status
      comment: "Current status of the risk score record (e.g., Active, Pending, Rejected)"
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "Status of submission to CMS for risk adjustment payment (e.g., Submitted, Accepted, Rejected)"
    - name: "risk_adjustment_factor_category"
      expr: risk_adjustment_factor_category
      comment: "Category of risk adjustment factor applied (e.g., Community, Institutional, New Enrollee)"
    - name: "variance_category"
      expr: variance_category
      comment: "Classification of variance between plan-calculated and CMS-published scores (e.g., High, Medium, Low)"
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag indicating whether risk score was manually overridden by plan staff"
    - name: "score_effective_month"
      expr: DATE_TRUNC('MONTH', score_effective_date)
      comment: "Month when the risk score became effective for payment calculation"
    - name: "score_effective_year"
      expr: YEAR(score_effective_date)
      comment: "Year when the risk score became effective"
  measures:
    - name: "member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with risk scores - key population denominator for risk adjustment analytics"
    - name: "avg_plan_calculated_score"
      expr: AVG(CAST(plan_calculated_score AS DOUBLE))
      comment: "Average risk score calculated by the health plan - drives revenue forecasting and actuarial reserve setting"
    - name: "avg_cms_published_score"
      expr: AVG(CAST(cms_published_score AS DOUBLE))
      comment: "Average risk score published by CMS after validation - determines actual payment amounts"
    - name: "total_score_variance"
      expr: SUM(CAST(score_variance AS DOUBLE))
      comment: "Total variance between plan-calculated and CMS-published scores - indicates coding accuracy and potential payment adjustments"
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance per member between plan and CMS scores - key quality metric for risk adjustment operations"
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic component of risk score (age/sex factors) - baseline risk before condition adjustments"
    - name: "avg_risk_score_confidence"
      expr: AVG(CAST(risk_score_confidence_score AS DOUBLE))
      comment: "Average confidence level in risk score accuracy - supports audit prioritization and quality assurance"
    - name: "manual_override_count"
      expr: SUM(CASE WHEN is_manual_override = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risk scores manually overridden - audit trail for compliance and quality control"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_ibnr_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incurred But Not Reported (IBNR) reserve metrics for financial solvency, regulatory capital requirements, and actuarial forecasting. Critical for balance sheet accuracy and RBC compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`ibnr_reserve`"
  dimensions:
    - name: "reserve_methodology"
      expr: reserve_methodology
      comment: "Actuarial method used to calculate IBNR (e.g., Chain Ladder, Bornhuetter-Ferguson, Expected Loss Ratio)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (e.g., HMO, PPO, EPO) - different reserve patterns by product"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (e.g., Commercial, Medicare, Medicaid) - regulatory reporting segment"
    - name: "ibnr_reserve_status"
      expr: ibnr_reserve_status
      comment: "Status of reserve calculation (e.g., Preliminary, Final, Audited)"
    - name: "reserve_adequacy_flag"
      expr: reserve_adequacy_flag
      comment: "Flag indicating whether reserve meets actuarial adequacy standards"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether reserve is included in regulatory financial statements"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_month)
      comment: "Month of service for which claims are incurred but not yet reported"
    - name: "valuation_quarter"
      expr: DATE_TRUNC('QUARTER', valuation_date)
      comment: "Quarter when reserve valuation was performed - aligns with regulatory reporting cycles"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of reserve valuation"
  measures:
    - name: "total_ibnr_amount"
      expr: SUM(CAST(ibnr_amount AS DOUBLE))
      comment: "Total IBNR reserve liability - critical balance sheet metric for financial solvency and regulatory capital requirements"
    - name: "avg_ibnr_pmpm"
      expr: AVG(CAST(ibnr_pmpm AS DOUBLE))
      comment: "Average IBNR reserve per member per month - key actuarial metric for rate setting and financial forecasting"
    - name: "total_rbc_impact"
      expr: SUM(CAST(rbc_impact_amount AS DOUBLE))
      comment: "Total impact on Risk-Based Capital requirements - determines regulatory capital adequacy and solvency ratios"
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average claims development factor applied - indicates claim emergence pattern and reserve adequacy"
    - name: "avg_expected_loss_ratio"
      expr: AVG(CAST(expected_loss_ratio AS DOUBLE))
      comment: "Average expected loss ratio used in reserve calculation - drives pricing and profitability targets"
    - name: "avg_actuarial_confidence_level"
      expr: AVG(CAST(actuarial_confidence_level AS DOUBLE))
      comment: "Average confidence level of actuarial estimate - supports reserve range disclosure and audit defense"
    - name: "total_hcc_weighted_amount"
      expr: SUM(CAST(hcc_weighted_amount AS DOUBLE))
      comment: "Total IBNR amount weighted by HCC risk scores - links clinical risk to financial reserves for Medicare Advantage"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to reserves - reflects population acuity impact on liability"
    - name: "reserve_count"
      expr: COUNT(1)
      comment: "Count of IBNR reserve records - tracks granularity of reserve segmentation for actuarial analysis"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_radv_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Adjustment Data Validation (RADV) audit metrics for CMS compliance, payment integrity, and medical record validation. Tracks audit findings, extrapolated errors, and settlement amounts for financial and regulatory risk management."
  source: "`vibe_health_insurance_v1`.`risk`.`radv_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RADV audit (e.g., CMS RADV, Contract-Level, MA-Only) - determines scope and financial exposure"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of audit (e.g., In Progress, Completed, Under Appeal) - tracks audit lifecycle"
    - name: "audit_year"
      expr: audit_year
      comment: "Payment year being audited - determines which risk scores and payments are under review"
    - name: "medical_record_request_status"
      expr: medical_record_request_status
      comment: "Status of medical record retrieval (e.g., Received, Pending, Not Available) - impacts audit defensibility"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of audit findings appeal (e.g., Not Appealed, Pending, Upheld, Overturned)"
    - name: "audit_error_flag"
      expr: audit_error_flag
      comment: "Flag indicating whether audit identified a payment error - key compliance and quality metric"
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', audit_start_timestamp)
      comment: "Month when audit began - tracks audit timing and resource allocation"
    - name: "audit_start_year"
      expr: YEAR(audit_start_timestamp)
      comment: "Year when audit began"
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total count of RADV audit records - tracks audit volume and compliance burden"
    - name: "member_audit_count"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members audited - denominator for error rate calculations"
    - name: "total_extrapolated_payment_error"
      expr: SUM(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Total extrapolated payment error identified by CMS - drives financial reserves and potential repayment liability"
    - name: "avg_extrapolated_payment_error"
      expr: AVG(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Average extrapolated payment error per audit - indicates severity of coding accuracy issues"
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amount after appeals and negotiations - actual financial impact of RADV audits"
    - name: "avg_final_settlement_amount"
      expr: AVG(CAST(final_settlement_amount AS DOUBLE))
      comment: "Average settlement amount per audit - benchmarks financial exposure per audit event"
    - name: "audit_error_count"
      expr: SUM(CASE WHEN audit_error_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits with identified errors - numerator for audit error rate KPI"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for audited members - indicates acuity of audited population"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_rate_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate development metrics for pricing, underwriting, and regulatory filing. Tracks rating factors, trend assumptions, and rate approval status for revenue forecasting and competitive positioning."
  source: "`vibe_health_insurance_v1`.`risk`.`rate_development`"
  dimensions:
    - name: "rate_development_status"
      expr: rate_development_status
      comment: "Status of rate development process (e.g., Draft, Submitted, Approved, Rejected)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan product (e.g., HMO, PPO, HDHP) - different rating structures by product"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., Small Group, Large Group, Individual) - regulatory rating rules vary by segment"
    - name: "rate_methodology"
      expr: rate_methodology
      comment: "Actuarial methodology used for rate development (e.g., Manual Rating, Experience Rating, Community Rating)"
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area - determines allowed geographic variation under ACA and state regulations"
    - name: "effective_quarter"
      expr: DATE_TRUNC('QUARTER', effective_date)
      comment: "Quarter when rates become effective - aligns with renewal cycles and competitive analysis"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when rates become effective"
    - name: "rating_period_year"
      expr: YEAR(rating_period_start)
      comment: "Year of rating period start - tracks rate generation vintage"
  measures:
    - name: "rate_development_count"
      expr: COUNT(1)
      comment: "Count of rate development records - tracks pricing activity volume and product portfolio breadth"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base premium rate before adjustments - foundation for all pricing and competitive benchmarking"
    - name: "avg_final_approved_rate"
      expr: AVG(CAST(final_approved_rate AS DOUBLE))
      comment: "Average final approved premium rate - actual rate charged to customers, drives revenue forecasts"
    - name: "avg_trend_factor"
      expr: AVG(CAST(trend_factor AS DOUBLE))
      comment: "Average medical cost trend factor applied - key actuarial assumption driving rate increases year-over-year"
    - name: "avg_administrative_loading"
      expr: AVG(CAST(administrative_loading AS DOUBLE))
      comment: "Average administrative expense loading percentage - impacts profitability and competitive positioning"
    - name: "avg_profit_margin"
      expr: AVG(CAST(profit_margin AS DOUBLE))
      comment: "Average profit margin built into rates - target underwriting gain for financial performance"
    - name: "avg_mlr_target"
      expr: AVG(CAST(mlr_target AS DOUBLE))
      comment: "Average Medical Loss Ratio target - regulatory constraint under ACA minimum MLR requirements (80%/85%)"
    - name: "avg_geographic_factor"
      expr: AVG(CAST(geographic_factor AS DOUBLE))
      comment: "Average geographic adjustment factor - reflects regional cost variation and network adequacy"
    - name: "avg_age_factor"
      expr: AVG(CAST(age_factor AS DOUBLE))
      comment: "Average age rating factor - demographic adjustment within ACA 3:1 age curve limits"
    - name: "avg_group_size_factor"
      expr: AVG(CAST(group_size_factor AS DOUBLE))
      comment: "Average group size adjustment factor - economies of scale in large group pricing"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_raps_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Adjustment Processing System (RAPS) submission metrics for Medicare Advantage risk score data transmission to CMS. Tracks submission status, acceptance rates, and risk scores for payment reconciliation and compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`raps_submission`"
  dimensions:
    - name: "raps_submission_status"
      expr: raps_submission_status
      comment: "Status of RAPS submission to CMS (e.g., Submitted, Accepted, Rejected, Pending)"
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status for submission (e.g., Accepted, Rejected with Errors)"
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year for which risk adjustment data is submitted - determines revenue impact timing"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of Medicare Advantage plan (e.g., MA-PD, MA-Only, SNP)"
    - name: "risk_adjustment_year"
      expr: risk_adjustment_year
      comment: "Year of risk adjustment model applied - tracks model version transitions"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when RAPS data was submitted to CMS - tracks submission timing and compliance with deadlines"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year when RAPS data was submitted"
  measures:
    - name: "submission_count"
      expr: COUNT(1)
      comment: "Total count of RAPS submissions - tracks submission volume and operational throughput"
    - name: "total_records_submitted"
      expr: SUM(CAST(total_record_count AS BIGINT))
      comment: "Total diagnosis records submitted to CMS - volume metric for risk adjustment operations"
    - name: "total_records_accepted"
      expr: SUM(CAST(accepted_record_count AS BIGINT))
      comment: "Total diagnosis records accepted by CMS - numerator for acceptance rate KPI"
    - name: "total_records_rejected"
      expr: SUM(CAST(rejected_record_count AS BIGINT))
      comment: "Total diagnosis records rejected by CMS - indicates data quality issues requiring remediation"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across submissions - drives Medicare Advantage payment rates and revenue forecasting"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied - reflects population acuity and payment multiplier"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_hcc_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hierarchical Condition Category (HCC) mapping metrics for ICD-10 to HCC crosswalk management, risk score coefficient tracking, and model version control. Supports risk adjustment accuracy and CMS model compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`hcc_mapping`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "CMS HCC model year (e.g., 2024, 2023) - determines coefficient values and hierarchy rules"
    - name: "hcc_code"
      expr: hcc_code
      comment: "Hierarchical Condition Category code - clinical grouping for risk adjustment"
    - name: "hcc_mapping_status"
      expr: hcc_mapping_status
      comment: "Status of HCC mapping record (e.g., Active, Inactive, Superseded)"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in HCC hierarchy - determines which conditions supersede others in risk scoring"
    - name: "disease_interaction_group"
      expr: disease_interaction_group
      comment: "Disease interaction group for additive risk score adjustments (e.g., Diabetes-CHF)"
    - name: "interaction_flag"
      expr: interaction_flag
      comment: "Flag indicating whether HCC participates in disease interaction scoring"
    - name: "is_excluded"
      expr: is_excluded
      comment: "Flag indicating whether HCC is excluded from risk scoring under current model rules"
    - name: "is_mapped"
      expr: is_mapped
      comment: "Flag indicating whether ICD-10 code is successfully mapped to an HCC"
    - name: "review_status"
      expr: review_status
      comment: "Review status of mapping record (e.g., Approved, Pending Review, Rejected)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when HCC mapping became effective"
  measures:
    - name: "hcc_mapping_count"
      expr: COUNT(1)
      comment: "Total count of HCC mapping records - tracks crosswalk coverage and model complexity"
    - name: "distinct_hcc_code_count"
      expr: COUNT(DISTINCT hcc_code)
      comment: "Distinct count of HCC codes in mapping - measures clinical category breadth in risk model"
    - name: "distinct_icd10_code_count"
      expr: COUNT(DISTINCT icd10_code)
      comment: "Distinct count of ICD-10 codes mapped - measures diagnosis code coverage for risk adjustment"
    - name: "avg_coefficient"
      expr: AVG(CAST(coefficient AS DOUBLE))
      comment: "Average HCC coefficient value - determines incremental risk score contribution per condition"
    - name: "avg_risk_score_weight"
      expr: AVG(CAST(risk_score_weight AS DOUBLE))
      comment: "Average risk score weight across HCCs - composite measure of condition severity in model"
    - name: "avg_age_adjustment_factor"
      expr: AVG(CAST(age_adjustment_factor AS DOUBLE))
      comment: "Average age adjustment factor - reflects age-specific risk score modifications"
    - name: "avg_demographic_adjustment_factor"
      expr: AVG(CAST(demographic_adjustment_factor AS DOUBLE))
      comment: "Average demographic adjustment factor - captures age/sex baseline risk before conditions"
    - name: "avg_gender_adjustment_factor"
      expr: AVG(CAST(gender_adjustment_factor AS DOUBLE))
      comment: "Average gender adjustment factor - sex-specific risk score modifications"
$$;