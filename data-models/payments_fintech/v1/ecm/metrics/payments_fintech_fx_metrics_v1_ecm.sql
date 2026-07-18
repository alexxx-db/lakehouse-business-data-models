-- Metric views for domain: fx | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_cross_border_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment KPIs for cross‑border transactions"
  source: "`payments_fintech_ecm`.`fx`.`cross_border_payment`"
  dimensions:
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Identifier of the payment product used"
    - name: "country_id"
      expr: country_id
      comment: "Country where payment originated"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO code of destination country"
    - name: "payment_rail"
      expr: payment_rail
      comment: "Payment rail (e.g., card, ACH, SWIFT)"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the payment event"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total settled payment amount in destination currency"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fees charged for cross‑border payments"
    - name: "average_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average FX rate applied to payments"
    - name: "payment_transaction_count"
      expr: COUNT(1)
      comment: "Number of cross‑border payment records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_conversion_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion audit performance and profitability"
  source: "`payments_fintech_ecm`.`fx`.`conversion_audit`"
  dimensions:
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion (e.g., real‑time, batch)"
    - name: "engine_version"
      expr: engine_version
      comment: "Version of conversion engine used"
    - name: "is_test_conversion"
      expr: is_test_conversion
      comment: "Flag indicating test conversions"
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the FX rate used"
    - name: "conversion_date"
      expr: DATE_TRUNC('day', conversion_timestamp)
      comment: "Date of conversion"
  measures:
    - name: "total_converted_amount"
      expr: SUM(CAST(calculated_amount AS DOUBLE))
      comment: "Total amount converted across all audits"
    - name: "total_conversion_pnl"
      expr: SUM(CAST(conversion_pnl AS DOUBLE))
      comment: "Aggregate profit & loss from conversions"
    - name: "average_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Mean conversion rate applied"
    - name: "successful_conversions"
      expr: SUM(CASE WHEN calculation_status = 'SUCCESS' THEN 1 ELSE 0 END)
      comment: "Count of successful conversion audits"
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of conversion audit records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_liquidity_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity position monitoring for treasury"
  source: "`payments_fintech_ecm`.`fx`.`liquidity_position`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the liquidity position"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee responsible for the position"
    - name: "event_type"
      expr: event_type
      comment: "Type of liquidity event (e.g., inflow, outflow)"
    - name: "position_date"
      expr: DATE_TRUNC('day', position_timestamp)
      comment: "Date of the liquidity snapshot"
  measures:
    - name: "total_net_available_liquidity"
      expr: SUM(CAST(net_available_liquidity AS DOUBLE))
      comment: "Aggregate net liquidity available"
    - name: "total_committed_outflows"
      expr: SUM(CAST(committed_outflows AS DOUBLE))
      comment: "Sum of liquidity committed to outflows"
    - name: "total_expected_inflows"
      expr: SUM(CAST(expected_inflows AS DOUBLE))
      comment: "Sum of expected inflows"
    - name: "breach_count"
      expr: SUM(CASE WHEN breach_flag THEN 1 ELSE 0 END)
      comment: "Number of liquidity breaches recorded"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk exposure KPIs for FX positions"
  source: "`payments_fintech_ecm`.`fx`.`exposure`"
  dimensions:
    - name: "exposure_source"
      expr: exposure_source
      comment: "Origin of the exposure (e.g., trading, settlement)"
    - name: "exposure_status"
      expr: exposure_status
      comment: "Current status of the exposure"
    - name: "limit_id"
      expr: limit_id
      comment: "Identifier of the associated risk limit"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the exposure snapshot"
  measures:
    - name: "total_gross_notional_exposure"
      expr: SUM(CAST(gross_notional_exposure AS DOUBLE))
      comment: "Total gross notional exposure across all currency pairs"
    - name: "total_net_exposure"
      expr: SUM(CAST(net_exposure AS DOUBLE))
      comment: "Aggregate net exposure"
    - name: "total_limit_utilization_amount"
      expr: SUM(CAST(limit_utilization_amount AS DOUBLE))
      comment: "Sum of limit utilization amounts"
    - name: "average_limit_utilization_pct"
      expr: AVG(CAST(risk_limit_utilization_pct AS DOUBLE))
      comment: "Average percentage of risk limit utilization"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and availability metrics for FX rates"
  source: "`payments_fintech_ecm`.`fx`.`rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Classification of the rate (e.g., spot, forward)"
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region"
    - name: "base_currency"
      expr: base_currency
      comment: "Base currency of the rate"
    - name: "quote_currency"
      expr: quote_currency
      comment: "Quote currency of the rate"
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_timestamp)
      comment: "Date when the rate became effective"
  measures:
    - name: "average_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Mean bid price for the rate"
    - name: "average_ask_price"
      expr: AVG(CAST(ask_price AS DOUBLE))
      comment: "Mean ask price for the rate"
    - name: "average_mid_price"
      expr: AVG(CAST(mid_price AS DOUBLE))
      comment: "Mean mid price for the rate"
    - name: "average_spread"
      expr: AVG(CAST(spread AS DOUBLE))
      comment: "Mean spread between ask and bid"
    - name: "active_rate_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of active rates"
$$;
