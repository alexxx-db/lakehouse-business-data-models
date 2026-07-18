-- Metric views for domain: risk | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key risk assessment KPIs summarizing overall risk scores and high‑risk flags."
  source: "`payments_fintech_ecm`.`risk`.`assessment`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date of the risk assessment"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification"
    - name: "region_code"
      expr: region_code
      comment: "Region code of the assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g., periodic, ad‑hoc)"
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Boolean flag indicating high‑risk assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Number of assessment records"
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessments"
    - name: "high_risk_assessment_count"
      expr: SUM(CASE WHEN is_high_risk THEN 1 ELSE 0 END)
      comment: "Count of assessments flagged as high risk"
    - name: "avg_transaction_amount_last_30d"
      expr: AVG(CAST(transaction_amount_last_30d AS DOUBLE))
      comment: "Average transaction amount over the last 30 days"
    - name: "total_transaction_volume_last_30d"
      expr: SUM(CAST(transaction_volume_last_30d AS DOUBLE))
      comment: "Total transaction volume over the last 30 days"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_exposure_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exposure limit utilization and limit amounts by geography and product."
  source: "`payments_fintech_ecm`.`risk`.`exposure_limit`"
  dimensions:
    - name: "geography"
      expr: geography
      comment: "Geographic region of the exposure limit"
    - name: "product_type"
      expr: product_type
      comment: "Product type associated with the limit"
    - name: "limit_name"
      expr: limit_name
      comment: "Descriptive name of the exposure limit"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month of limit effectiveness"
  measures:
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Sum of exposure limit amounts"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage of limits"
    - name: "exposure_limit_count"
      expr: COUNT(1)
      comment: "Number of exposure limit records"
    - name: "breach_status_count"
      expr: SUM(CASE WHEN breach_status = 'Breached' THEN 1 ELSE 0 END)
      comment: "Count of breached exposure limits"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated risk event metrics for monitoring event volume and severity."
  source: "`payments_fintech_ecm`.`risk`.`risk_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of risk event"
    - name: "risk_dimension"
      expr: risk_dimension
      comment: "Risk dimension the event belongs to"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the event"
    - name: "source_system"
      expr: source_system
      comment: "Originating source system"
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag if event was manually overridden"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of risk events"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across events"
    - name: "high_risk_event_count"
      expr: SUM(CASE WHEN risk_score > 80 THEN 1 ELSE 0 END)
      comment: "Count of events with risk score above 80"
    - name: "threshold_exceeded_count"
      expr: SUM(CASE WHEN is_threshold_exceeded THEN 1 ELSE 0 END)
      comment: "Count of events where threshold was exceeded"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and deployment metrics for risk models."
  source: "`payments_fintech_ecm`.`risk`.`risk_model`"
  dimensions:
    - name: "risk_model_type"
      expr: risk_model_type
      comment: "Type of risk model (e.g., credit, fraud)"
    - name: "algorithm"
      expr: algorithm
      comment: "Algorithm used by the model"
    - name: "deployment_state"
      expr: deployment_state
      comment: "Current deployment state of the model"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when model became effective"
  measures:
    - name: "model_count"
      expr: COUNT(1)
      comment: "Number of risk models"
    - name: "avg_performance_auc"
      expr: AVG(CAST(performance_auc AS DOUBLE))
      comment: "Average AUC performance metric"
    - name: "avg_performance_gini"
      expr: AVG(CAST(performance_gini AS DOUBLE))
      comment: "Average Gini coefficient"
    - name: "avg_performance_ks"
      expr: AVG(CAST(performance_ks AS DOUBLE))
      comment: "Average KS statistic"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key policy limits and approval metrics for risk governance."
  source: "`payments_fintech_ecm`.`risk`.`risk_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Policy type (e.g., transaction, exposure)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the policy"
    - name: "status"
      expr: risk_policy_status
      comment: "Current status of the policy"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year of policy effectiveness"
  measures:
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Number of risk policies"
    - name: "avg_daily_exposure_limit"
      expr: AVG(CAST(daily_exposure_limit AS DOUBLE))
      comment: "Average daily exposure limit across policies"
    - name: "avg_monthly_exposure_limit"
      expr: AVG(CAST(monthly_exposure_limit AS DOUBLE))
      comment: "Average monthly exposure limit"
    - name: "total_transaction_limit_amount"
      expr: SUM(CAST(transaction_limit_amount AS DOUBLE))
      comment: "Sum of transaction limit amounts across policies"
$$;
