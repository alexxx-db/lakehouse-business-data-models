-- Metric views for domain: security | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_fixed_income`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and risk metrics for fixed income securities."
  source: "`banking_ecm`.`security`.`fixed_income`"
  dimensions:
    - name: "instrument_id"
      expr: instrument_id
      comment: "Identifier of the underlying instrument."
    - name: "issuer_id"
      expr: issuer_id
      comment: "Issuer of the fixed income security."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency in which the security is denominated."
    - name: "maturity_date"
      expr: maturity_date
      comment: "Maturity date of the bond."
    - name: "credit_rating_fitch"
      expr: credit_rating_fitch
      comment: "Fitch credit rating for the security."
  measures:
    - name: "total_market_price"
      expr: SUM(CAST(market_price AS DOUBLE))
      comment: "Total market price of fixed income securities, representing portfolio valuation."
    - name: "avg_yield_to_maturity"
      expr: AVG(CAST(yield_to_maturity AS DOUBLE))
      comment: "Average yield to maturity across fixed income securities, indicating overall return profile."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest AS DOUBLE))
      comment: "Sum of accrued interest, reflecting upcoming cash inflows."
    - name: "count_fixed_income_securities"
      expr: COUNT(1)
      comment: "Baseline count of fixed income records."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_equity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equity exposure and income metrics."
  source: "`banking_ecm`.`security`.`equity`"
  dimensions:
    - name: "issuer_id"
      expr: issuer_id
      comment: "Issuer of the equity."
    - name: "equity_type"
      expr: equity_type
      comment: "Type classification of the equity."
    - name: "primary_exchange"
      expr: primary_exchange
      comment: "Primary exchange where the equity trades."
    - name: "ticker_symbol"
      expr: ticker_symbol
      comment: "Ticker symbol of the equity."
    - name: "listing_date"
      expr: listing_date
      comment: "Date the equity was listed."
  measures:
    - name: "total_shares_outstanding"
      expr: SUM(CAST(shares_outstanding AS DOUBLE))
      comment: "Total shares outstanding across equities, indicating equity exposure."
    - name: "avg_dividend_rate"
      expr: AVG(CAST(dividend_rate AS DOUBLE))
      comment: "Average dividend rate, reflecting income generation potential."
    - name: "count_equities"
      expr: COUNT(1)
      comment: "Baseline count of equity records."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_derivative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Derivative exposure and maturity metrics."
  source: "`banking_ecm`.`security`.`derivative`"
  dimensions:
    - name: "instrument_id"
      expr: instrument_id
      comment: "Underlying instrument for the derivative."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the derivative."
    - name: "derivative_type"
      expr: derivative_type
      comment: "Type of derivative (e.g., option, future)."
    - name: "trade_date"
      expr: trade_date
      comment: "Trade date of the derivative."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the derivative."
  measures:
    - name: "total_notional_amount"
      expr: SUM(CAST(notional_amount AS DOUBLE))
      comment: "Total notional amount of derivatives, indicating exposure size."
    - name: "avg_maturity_days"
      expr: AVG(CAST(DATEDIFF(DAY, trade_date, expiry_date) AS DOUBLE))
      comment: "Average maturity in days from trade to expiry."
    - name: "count_derivatives"
      expr: COUNT(1)
      comment: "Baseline count of derivative records."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price and volume metrics for securities."
  source: "`banking_ecm`.`security`.`price`"
  dimensions:
    - name: "instrument_id"
      expr: instrument_id
      comment: "Instrument identifier for the price record."
    - name: "pricing_date"
      expr: pricing_date
      comment: "Date of the price observation."
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., closing, mid)."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the price."
  measures:
    - name: "total_volume"
      expr: SUM(CAST(volume AS DOUBLE))
      comment: "Total traded volume, indicating market activity."
    - name: "avg_last_trade_price"
      expr: AVG(CAST(last_trade_price AS DOUBLE))
      comment: "Average last trade price, reflecting price level."
    - name: "max_high_price"
      expr: MAX(CAST(high_price AS DOUBLE))
      comment: "Maximum high price observed, useful for volatility analysis."
    - name: "count_price_records"
      expr: COUNT(1)
      comment: "Baseline count of price records."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`security_credit_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit rating distribution and risk metrics."
  source: "`banking_ecm`.`security`.`credit_rating`"
  dimensions:
    - name: "rating_agency_name"
      expr: rating_agency_name
      comment: "Name of the rating agency."
    - name: "rating_outlook"
      expr: rating_outlook
      comment: "Outlook associated with the rating (e.g., Positive)."
    - name: "rating_date"
      expr: rating_date
      comment: "Date the rating was issued."
    - name: "issuer_id"
      expr: issuer_id
      comment: "Issuer of the rated entity."
    - name: "investment_grade_flag"
      expr: investment_grade_flag
      comment: "Boolean flag indicating if the rating is investment grade."
  measures:
    - name: "count_credit_ratings"
      expr: COUNT(1)
      comment: "Baseline count of credit rating records."
    - name: "avg_probability_of_default"
      expr: AVG(CAST(probability_of_default_pct AS DOUBLE))
      comment: "Average probability of default percentage across ratings."
    - name: "investment_grade_count"
      expr: SUM(CASE WHEN investment_grade_flag THEN 1 ELSE 0 END)
      comment: "Count of investment‑grade ratings, indicating credit quality distribution."
$$;
