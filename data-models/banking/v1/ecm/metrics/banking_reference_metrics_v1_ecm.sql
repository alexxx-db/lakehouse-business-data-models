-- Metric views for domain: reference | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_benchmark_rate_fixing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for benchmark rate fixing events."
  source: "`banking_ecm`.`reference`.`benchmark_rate_fixing`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the benchmark rate."
    - name: "tenor_code"
      expr: tenor_code
      comment: "Tenor code of the rate."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate (e.g., ACTIVE, INACTIVE)."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the rate fixing."
    - name: "is_revised"
      expr: is_revised
      comment: "Indicates if the rate has been revised."
  measures:
    - name: "total_rates"
      expr: COUNT(1)
      comment: "Total number of benchmark rate fixing records."
    - name: "avg_rate_value"
      expr: AVG(CAST(rate_value AS DOUBLE))
      comment: "Average rate value across records."
    - name: "avg_rate_basis_points"
      expr: AVG(CAST(rate_basis_points AS DOUBLE))
      comment: "Average rate expressed in basis points."
    - name: "avg_spread_adjustment"
      expr: AVG(CAST(spread_adjustment AS DOUBLE))
      comment: "Average spread adjustment applied."
    - name: "revised_rate_count"
      expr: SUM(CASE WHEN is_revised THEN 1 ELSE 0 END)
      comment: "Count of rates that have been revised."
    - name: "business_day_rate_count"
      expr: SUM(CASE WHEN is_business_day THEN 1 ELSE 0 END)
      comment: "Count of rates occurring on business days."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_exchange_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exchange rate performance and pricing metrics."
  source: "`banking_ecm`.`reference`.`exchange_rate`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Base currency identifier."
    - name: "quote_currency_code"
      expr: quote_currency_code
      comment: "Quote currency ISO code."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of exchange rate (e.g., spot, forward)."
    - name: "effective_timestamp"
      expr: effective_timestamp
      comment: "Timestamp when the rate became effective."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the exchange rate."
  measures:
    - name: "total_exchange_rates"
      expr: COUNT(1)
      comment: "Total number of exchange rate records."
    - name: "avg_rate_value"
      expr: AVG(CAST(rate_value AS DOUBLE))
      comment: "Average exchange rate value."
    - name: "avg_spread_bps"
      expr: AVG(CAST(spread_bps AS DOUBLE))
      comment: "Average spread in basis points."
    - name: "cross_rate_flag_count"
      expr: SUM(CASE WHEN cross_rate_flag THEN 1 ELSE 0 END)
      comment: "Count of cross rates."
    - name: "benchmark_rate_flag_count"
      expr: SUM(CASE WHEN benchmark_rate_flag THEN 1 ELSE 0 END)
      comment: "Count of benchmark rates."
    - name: "data_quality_score_avg"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for exchange rates."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_product_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product type financial limits and risk indicators."
  source: "`banking_ecm`.`reference`.`product_type`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the product type."
    - name: "product_type_name"
      expr: product_type_name
      comment: "Descriptive name of the product type."
    - name: "regulatory_product_category_basel"
      expr: regulatory_product_category_basel
      comment: "Basel regulatory category."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of product type effectiveness."
    - name: "credit_risk_flag"
      expr: credit_risk_flag
      comment: "Indicates if credit risk applies."
  measures:
    - name: "total_product_types"
      expr: COUNT(1)
      comment: "Total number of product type records."
    - name: "avg_maximum_amount"
      expr: AVG(CAST(maximum_amount AS DOUBLE))
      comment: "Average maximum amount limit."
    - name: "avg_minimum_amount"
      expr: AVG(CAST(minimum_amount AS DOUBLE))
      comment: "Average minimum amount limit."
    - name: "credit_risk_product_count"
      expr: SUM(CASE WHEN credit_risk_flag THEN 1 ELSE 0 END)
      comment: "Count of product types with credit risk flag."
    - name: "liquidity_risk_product_count"
      expr: SUM(CASE WHEN liquidity_risk_flag THEN 1 ELSE 0 END)
      comment: "Count of product types with liquidity risk flag."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_rate_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benchmark rate characteristics and usage metrics."
  source: "`banking_ecm`.`reference`.`rate_benchmark`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency associated with the benchmark."
    - name: "benchmark_type"
      expr: benchmark_type
      comment: "Type of benchmark (e.g., LIBOR, SOFR)."
    - name: "day_count_convention"
      expr: day_count_convention
      comment: "Day count convention used."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the benchmark."
    - name: "is_risk_free_rate"
      expr: is_risk_free_rate
      comment: "Indicates if the benchmark is risk‑free."
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of benchmark records."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score."
    - name: "avg_transaction_volume_threshold"
      expr: AVG(CAST(transaction_volume_threshold AS DOUBLE))
      comment: "Average transaction volume threshold."
    - name: "risk_free_benchmark_count"
      expr: SUM(CASE WHEN is_risk_free_rate THEN 1 ELSE 0 END)
      comment: "Count of risk‑free benchmarks."
    - name: "secured_benchmark_count"
      expr: SUM(CASE WHEN is_secured_rate THEN 1 ELSE 0 END)
      comment: "Count of secured benchmarks."
    - name: "avg_fallback_spread_adjustment"
      expr: AVG(CAST(fallback_spread_adjustment AS DOUBLE))
      comment: "Average fallback spread adjustment."
$$;
