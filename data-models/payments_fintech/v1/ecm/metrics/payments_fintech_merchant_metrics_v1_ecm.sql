-- Metric views for domain: merchant | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core merchant entity metrics for portfolio and operational performance."
  source: "`payments_fintech_ecm`.`merchant`.`merchant`"
  dimensions:
    - name: "region_id"
      expr: region_id
      comment: "Region identifier for merchant."
    - name: "business_country"
      expr: business_country
      comment: "Country where merchant operates."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of merchant (e.g., Active, Inactive)."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to merchant."
    - name: "mcc_id"
      expr: mcc_id
      comment: "Merchant Category Code identifier."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency used for processing."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year merchant was activated."
  measures:
    - name: "total_merchants"
      expr: COUNT(1)
      comment: "Total number of merchant records."
    - name: "active_merchants"
      expr: SUM(CASE WHEN lifecycle_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of merchants with active lifecycle status."
    - name: "avg_mdr_rate"
      expr: AVG(CAST(mdr_rate AS DOUBLE))
      comment: "Average merchant discount rate (MDR) across merchants."
    - name: "avg_monthly_processing_limit"
      expr: AVG(CAST(monthly_processing_limit AS DOUBLE))
      comment: "Average monthly processing limit per merchant."
    - name: "avg_transaction_limit_single"
      expr: AVG(CAST(transaction_limit_single AS DOUBLE))
      comment: "Average single transaction limit per merchant."
    - name: "avg_chargeback_threshold_ratio"
      expr: AVG(CAST(chargeback_threshold_ratio AS DOUBLE))
      comment: "Average chargeback threshold ratio set for merchants."
    - name: "compliance_percent"
      expr: AVG(CASE WHEN regulatory_obligation_id IS NOT NULL THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of merchants linked to a regulatory obligation (indicative of compliance)."
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule metrics per merchant for revenue and cost analysis."
  source: "`payments_fintech_ecm`.`merchant`.`merchant_fee_schedule`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of fee (e.g., transaction, monthly)."
    - name: "fee_category"
      expr: fee_category
      comment: "Category of fee (e.g., interchange, service)."
    - name: "applicable_scheme"
      expr: applicable_scheme
      comment: "Payment scheme the fee applies to."
    - name: "applicable_transaction_type"
      expr: applicable_transaction_type
      comment: "Transaction type the fee applies to."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the fee amount."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the fee schedule became effective."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount across all fee schedules."
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage across fee schedules."
    - name: "fee_schedule_count"
      expr: COUNT(1)
      comment: "Number of fee schedule records."
    - name: "percent_fee_exempt"
      expr: AVG(CASE WHEN fee_exempt_flag THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of fee schedules that are exempt."
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_processing_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Processing limit metrics for merchant risk and capacity management."
  source: "`payments_fintech_ecm`.`merchant`.`processing_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Classification of the limit (e.g., daily, monthly)."
    - name: "limit_code"
      expr: limit_code
      comment: "Code identifying the specific limit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the limit amounts."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Flag indicating compliance status of the limit."
    - name: "is_manual_review_required"
      expr: is_manual_review_required
      comment: "Flag indicating if manual review is required for the limit."
    - name: "is_override_allowed"
      expr: is_override_allowed
      comment: "Flag indicating if the limit can be overridden."
  measures:
    - name: "total_daily_volume_cap"
      expr: SUM(CAST(daily_volume_cap_amount AS DOUBLE))
      comment: "Sum of daily volume caps across limits."
    - name: "avg_daily_volume_cap"
      expr: AVG(CAST(daily_volume_cap_amount AS DOUBLE))
      comment: "Average daily volume cap."
    - name: "total_monthly_tpv_limit"
      expr: SUM(CAST(monthly_tpv_limit_amount AS DOUBLE))
      comment: "Sum of monthly total processing volume limits."
    - name: "avg_monthly_tpv_limit"
      expr: AVG(CAST(monthly_tpv_limit_amount AS DOUBLE))
      comment: "Average monthly TPV limit."
    - name: "limit_count"
      expr: COUNT(1)
      comment: "Number of processing limit records."
    - name: "percent_compliant"
      expr: AVG(CASE WHEN is_compliant THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of limits marked as compliant."
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_chargeback_threshold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback threshold metrics for monitoring merchant risk."
  source: "`payments_fintech_ecm`.`merchant`.`chargeback_threshold`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the chargeback threshold."
    - name: "program_type"
      expr: program_type
      comment: "Program type associated with the threshold."
    - name: "scheme_name"
      expr: scheme_name
      comment: "Payment scheme name."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the threshold became effective."
  measures:
    - name: "avg_threshold_percent"
      expr: AVG(CAST(chargeback_rate_threshold_percent AS DOUBLE))
      comment: "Average chargeback rate threshold percent."
    - name: "avg_current_month_rate"
      expr: AVG(CAST(current_month_chargeback_rate_percent AS DOUBLE))
      comment: "Average current month chargeback rate percent."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fine amount associated with chargeback thresholds."
    - name: "threshold_count"
      expr: COUNT(1)
      comment: "Number of chargeback threshold records."
    - name: "percent_active"
      expr: AVG(CASE WHEN chargeback_threshold_status = 'Active' THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of active chargeback thresholds."
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_risk_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk profile metrics summarizing merchant risk indicators."
  source: "`payments_fintech_ecm`.`merchant`.`merchant_risk_profile`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the merchant."
    - name: "risk_status"
      expr: risk_status
      comment: "Current risk status of the merchant."
    - name: "risk_score_source"
      expr: risk_score_source
      comment: "Source of the risk score calculation."
    - name: "risk_score_version"
      expr: risk_score_version
      comment: "Version of the risk scoring model."
  measures:
    - name: "avg_monthly_volume"
      expr: AVG(CAST(average_monthly_volume AS DOUBLE))
      comment: "Average monthly transaction volume."
    - name: "avg_fraud_rate"
      expr: AVG(CAST(fraud_rate AS DOUBLE))
      comment: "Average fraud rate."
    - name: "avg_chargeback_rate_current"
      expr: AVG(CAST(chargeback_rate_current AS DOUBLE))
      comment: "Average current chargeback rate."
    - name: "avg_reserve_balance"
      expr: AVG(CAST(reserve_balance AS DOUBLE))
      comment: "Average reserve balance amount."
    - name: "avg_reserve_percentage"
      expr: AVG(CAST(reserve_percentage AS DOUBLE))
      comment: "Average reserve percentage."
    - name: "risk_profile_count"
      expr: COUNT(1)
      comment: "Number of merchant risk profile records."
$$;
