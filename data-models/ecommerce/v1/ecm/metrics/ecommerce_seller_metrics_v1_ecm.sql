-- Metric views for domain: seller | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_gmv_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key GMV settlement performance metrics by period, channel and currency"
  source: "`ecommerce_ecm`.`seller`.`gmv_settlement`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the settlement period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the settlement period"
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g., marketplace, direct)"
  measures:
    - name: "total_gross_gmv"
      expr: SUM(CAST(gross_gmv_amount AS DOUBLE))
      comment: "Total gross GMV across settlements"
    - name: "total_net_gmv"
      expr: SUM(CAST(net_gmv_amount AS DOUBLE))
      comment: "Total net GMV after returns and adjustments"
    - name: "total_payout_amount"
      expr: SUM(CAST(payout_amount AS DOUBLE))
      comment: "Total payout amount to sellers"
    - name: "total_returns_amount"
      expr: SUM(CAST(returns_amount AS DOUBLE))
      comment: "Total returns amount deducted from GMV"
    - name: "average_gross_gmv_per_settlement"
      expr: AVG(CAST(gross_gmv_amount AS DOUBLE))
      comment: "Average gross GMV per settlement record"
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated seller performance scorecard metrics"
  source: "`ecommerce_ecm`.`seller`.`scorecard`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reporting period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the reporting period"
    - name: "period_type"
      expr: period_type
      comment: "Period granularity (e.g., monthly, quarterly)"
    - name: "performance_tier_rating"
      expr: performance_tier_rating
      comment: "Performance tier rating assigned to the seller"
  measures:
    - name: "total_gmv"
      expr: SUM(CAST(gmv AS DOUBLE))
      comment: "Total GMV for the scorecard period"
    - name: "avg_aov"
      expr: AVG(CAST(aov AS DOUBLE))
      comment: "Average order value (AOV) across sellers"
    - name: "avg_cancellation_rate"
      expr: AVG(CAST(cancellation_rate AS DOUBLE))
      comment: "Average cancellation rate"
    - name: "avg_return_rate"
      expr: AVG(CAST(return_rate AS DOUBLE))
      comment: "Average return rate"
    - name: "avg_inventory_health_score"
      expr: AVG(CAST(inventory_health_score AS DOUBLE))
      comment: "Average inventory health score"
    - name: "avg_nps_contribution_score"
      expr: AVG(CAST(nps_contribution_score AS DOUBLE))
      comment: "Average NPS contribution score"
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission structure metrics to monitor seller cost structures"
  source: "`ecommerce_ecm`.`seller`.`commission`"
  dimensions:
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (e.g., fixed, variable)"
    - name: "seller_tier"
      expr: seller_tier
      comment: "Seller tier associated with the commission"
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category code for the commission"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the commission amounts"
    - name: "is_negotiated"
      expr: is_negotiated
      comment: "Flag indicating if commission was negotiated"
  measures:
    - name: "avg_rate_percent"
      expr: AVG(CAST(rate_percent AS DOUBLE))
      comment: "Average commission rate percent"
    - name: "avg_fulfillment_fee_rate_percent"
      expr: AVG(CAST(fulfillment_fee_rate_percent AS DOUBLE))
      comment: "Average fulfillment fee rate percent"
    - name: "avg_promotional_coop_fee_percent"
      expr: AVG(CAST(promotional_coop_fee_percent AS DOUBLE))
      comment: "Average promotional co-op fee percent"
    - name: "avg_referral_fee_percent"
      expr: AVG(CAST(referral_fee_percent AS DOUBLE))
      comment: "Average referral fee percent"
    - name: "avg_subscription_fee_amount"
      expr: AVG(CAST(subscription_fee_amount AS DOUBLE))
      comment: "Average subscription fee amount"
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_fraud_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud investigation risk and exposure metrics"
  source: "`ecommerce_ecm`.`seller`.`fraud_investigation`"
  dimensions:
    - name: "fraud_type"
      expr: fraud_type
      comment: "Category of fraud (e.g., payment, account)"
    - name: "fraud_severity"
      expr: fraud_severity
      comment: "Severity level of the fraud"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect fraud"
    - name: "status"
      expr: status
      comment: "Current status of the investigation"
    - name: "regulatory_reported"
      expr: regulatory_reported
      comment: "Whether the case was reported to regulators"
    - name: "is_repeat_offender"
      expr: is_repeat_offender
      comment: "Flag indicating repeat offender"
  measures:
    - name: "total_amount_under_investigation"
      expr: SUM(CAST(amount_under_investigation AS DOUBLE))
      comment: "Total monetary amount under fraud investigation"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across investigations"
    - name: "investigation_count"
      expr: COUNT(1)
      comment: "Number of fraud investigations"
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core seller profile health and financial metrics"
  source: "`ecommerce_ecm`.`seller`.`seller_profile`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current account status of the seller"
    - name: "business_type"
      expr: business_type
      comment: "Business type (e.g., individual, corporate)"
    - name: "primary_category"
      expr: primary_category
      comment: "Primary product category of the seller"
    - name: "tier_id"
      expr: tier_id
      comment: "Identifier of the seller tier"
    - name: "platform_join_date"
      expr: platform_join_date
      comment: "Date the seller joined the platform"
  measures:
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across sellers"
    - name: "avg_gmv_attribution"
      expr: AVG(CAST(gmv_attribution AS DOUBLE))
      comment: "Average GMV attribution per seller"
    - name: "avg_seller_rating"
      expr: AVG(CAST(seller_rating AS DOUBLE))
      comment: "Average seller rating"
    - name: "seller_count"
      expr: COUNT(1)
      comment: "Total number of seller profiles"
$$;
