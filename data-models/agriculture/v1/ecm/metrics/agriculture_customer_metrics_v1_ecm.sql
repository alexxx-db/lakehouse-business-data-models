-- Metric views for domain: customer | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core account‑level KPIs for the customer domain"
  source: "`agriculture_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., active, inactive)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g., corporate, individual)"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier level assigned to the account"
    - name: "segment_id"
      expr: segment_id
      comment: "Segment identifier linking to customer.segment"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "ISO country code of the billing address"
    - name: "account_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the account was created"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Count of customer accounts"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all accounts"
    - name: "average_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Sum of credit limits granted to accounts"
    - name: "distinct_credit_ratings"
      expr: COUNT(DISTINCT credit_rating)
      comment: "Number of unique credit rating categories"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and exposure KPIs"
  source: "`agriculture_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_risk_category"
      expr: credit_risk_category
      comment: "Risk category assigned to the credit profile"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit amounts"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the credit profile became effective"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Aggregate credit limit across all credit profiles"
    - name: "average_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average days sales outstanding"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across profiles"
    - name: "average_payment_behavior_score"
      expr: AVG(CAST(payment_behavior_score AS DOUBLE))
      comment: "Mean payment behavior score"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with a credit profile"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_account_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for inter‑account relationships and volume commitments"
  source: "`agriculture_ecm`.`customer`.`account_relationship`"
  dimensions:
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship (e.g., supplier, distributor)"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the relationship"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the relationship became effective"
  measures:
    - name: "total_volume_commitment_mt"
      expr: SUM(CAST(annual_volume_commitment_mt AS DOUBLE))
      comment: "Total annual volume commitment in metric tons"
    - name: "average_credit_exposure_limit"
      expr: AVG(CAST(credit_exposure_limit AS DOUBLE))
      comment: "Average credit exposure limit per relationship"
    - name: "distinct_source_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique source accounts in relationships"
    - name: "distinct_target_accounts"
      expr: COUNT(DISTINCT target_account_id)
      comment: "Number of unique target accounts in relationships"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_bundle_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for product bundle enrollment activity"
  source: "`agriculture_ecm`.`customer`.`bundle_enrollment`"
  dimensions:
    - name: "bundle_enrollment_status"
      expr: bundle_enrollment_status
      comment: "Current status of the bundle enrollment"
    - name: "season_year"
      expr: season_year
      comment: "Season year associated with the enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment"
  measures:
    - name: "total_contracted_volume"
      expr: SUM(CAST(contracted_volume AS DOUBLE))
      comment: "Total contracted volume across all bundle enrollments"
    - name: "average_pricing_override_pct"
      expr: AVG(CAST(pricing_override_pct AS DOUBLE))
      comment: "Average pricing override percentage"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of bundle enrollments"
$$;
