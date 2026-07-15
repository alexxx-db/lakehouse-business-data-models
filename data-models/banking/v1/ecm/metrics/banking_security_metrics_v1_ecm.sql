-- Metric views for domain: security | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pricing KPIs used by trading desks and risk monitoring"
  source: "`banking_ecm`.`security`.`price`"
  dimensions:
    - name: "instrument_id"
      expr: instrument_id
      comment: "Identifier of the financial instrument"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the price quote"
    - name: "pricing_month"
      expr: DATE_TRUNC('month', pricing_date)
      comment: "Month of the pricing observation"
  measures:
    - name: "total_volume"
      expr: SUM(CAST(volume AS DOUBLE))
      comment: "Total traded volume for the instrument and currency"
    - name: "average_adjusted_close_price"
      expr: AVG(CAST(adjusted_close_price AS DOUBLE))
      comment: "Average adjusted close price across the selected period"
    - name: "average_price_change_percentage"
      expr: AVG(CAST(change_percentage AS DOUBLE))
      comment: "Average daily price change percentage"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_fixed_income`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed income portfolio valuation and income metrics"
  source: "`banking_ecm`.`security`.`fixed_income`"
  dimensions:
    - name: "issuer_id"
      expr: issuer_id
      comment: "Issuer of the security"
    - name: "maturity_year"
      expr: DATE_TRUNC('year', maturity_date)
      comment: "Maturity year bucket"
  measures:
    - name: "total_face_value"
      expr: SUM(CAST(face_value AS DOUBLE))
      comment: "Aggregate face value of all fixed income securities"
    - name: "average_coupon_rate"
      expr: AVG(CAST(coupon_rate AS DOUBLE))
      comment: "Average coupon rate across the portfolio"
    - name: "average_yield_to_maturity"
      expr: AVG(CAST(yield_to_maturity AS DOUBLE))
      comment: "Average YTM, indicating portfolio return expectations"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_derivative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Derivative exposure and risk metrics for capital planning"
  source: "`banking_ecm`.`security`.`derivative`"
  dimensions:
    - name: "instrument_id"
      expr: instrument_id
      comment: "Underlying instrument of the derivative"
    - name: "maturity_year"
      expr: DATE_TRUNC('year', maturity_date)
      comment: "Maturity year bucket"
  measures:
    - name: "total_notional_amount"
      expr: SUM(CAST(notional_amount AS DOUBLE))
      comment: "Total notional exposure of derivatives"
    - name: "total_mark_to_market_value"
      expr: SUM(CAST(mark_to_market_value AS DOUBLE))
      comment: "Aggregate MTM value for risk reporting"
    - name: "total_risk_weighted_assets"
      expr: SUM(CAST(rwa_amount AS DOUBLE))
      comment: "Total RWA derived from derivative positions"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_liquidity_holding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity position sizing and FX exposure"
  source: "`banking_ecm`.`security`.`liquidity_holding`"
  dimensions:
    - name: "holding_currency"
      expr: holding_currency
      comment: "Currency of the holding"
    - name: "liquidity_classification"
      expr: liquidity_classification
      comment: "Classification of liquidity (e.g., high, medium, low)"
    - name: "maturity_bucket"
      expr: maturity_bucket
      comment: "Bucketed maturity horizon"
  measures:
    - name: "total_market_value"
      expr: SUM(CAST(market_value AS DOUBLE))
      comment: "Total market value of liquidity holdings"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Aggregate quantity across holdings"
    - name: "average_fx_rate_to_position_currency"
      expr: AVG(CAST(fx_rate_to_position_currency AS DOUBLE))
      comment: "Average FX rate used for valuation"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_holding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core holding performance and valuation metrics"
  source: "`banking_ecm`.`security`.`security_holding`"
  dimensions:
    - name: "holding_status"
      expr: holding_status
      comment: "Current status of the holding (e.g., active, pending)"
    - name: "regulatory_treatment"
      expr: regulatory_treatment
      comment: "Regulatory classification affecting treatment"
  measures:
    - name: "total_market_value"
      expr: SUM(CAST(market_value AS DOUBLE))
      comment: "Total market value of security holdings"
    - name: "total_position_quantity"
      expr: SUM(CAST(position_quantity AS DOUBLE))
      comment: "Aggregate quantity of securities held"
    - name: "average_cost_basis"
      expr: AVG(CAST(cost_basis AS DOUBLE))
      comment: "Average cost basis per security"
$$;
