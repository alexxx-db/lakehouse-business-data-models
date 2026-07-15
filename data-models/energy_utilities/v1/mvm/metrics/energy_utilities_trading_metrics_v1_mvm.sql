-- Metric views for domain: trading | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_trade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core trade financial KPIs"
  source: "`energy_utilities_ecm`.`trading`.`trade`"
  dimensions:
    - name: "trade_date"
      expr: trade_date
      comment: "Date the trade was executed"
    - name: "market_type"
      expr: market_type
      comment: "Market type (e.g., day-ahead, real-time)"
    - name: "commodity"
      expr: commodity
      comment: "Commodity being traded"
    - name: "trade_status"
      expr: trade_status
      comment: "Current status of the trade"
  measures:
    - name: "trade_count"
      expr: COUNT(1)
      comment: "Number of trades recorded"
    - name: "total_trade_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of trades (sum of total_value)"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity traded across all trades"
    - name: "average_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average trade price per unit"
    - name: "average_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per trade"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position‑level exposure and valuation metrics"
  source: "`energy_utilities_ecm`.`trading`.`position`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date for the position snapshot"
    - name: "portfolio_id"
      expr: portfolio_id
      comment: "Portfolio identifier"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity for the position"
    - name: "market_type"
      expr: market_type
      comment: "Market type associated with the position"
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO region code"
    - name: "position_status"
      expr: position_status
      comment: "Current status of the position"
  measures:
    - name: "position_count"
      expr: COUNT(1)
      comment: "Number of position records"
    - name: "total_net_position_quantity"
      expr: SUM(CAST(net_position_quantity AS DOUBLE))
      comment: "Aggregate net position quantity"
    - name: "total_mark_to_market_value"
      expr: SUM(CAST(mark_to_market_value AS DOUBLE))
      comment: "Total mark‑to‑market value of positions"
    - name: "total_unrealized_pnl"
      expr: SUM(CAST(unrealized_pnl AS DOUBLE))
      comment: "Total unrealized profit & loss"
    - name: "average_credit_exposure"
      expr: AVG(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Average credit exposure per position"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_market_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial settlement KPIs for market settlements"
  source: "`energy_utilities_ecm`.`trading`.`market_settlement`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of the settlement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for settlement amounts"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement"
  measures:
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Number of settlement records"
    - name: "total_settlement_amount"
      expr: SUM(CAST(total_settlement_amount AS DOUBLE))
      comment: "Aggregate settlement amount"
    - name: "total_imbalance_charge"
      expr: SUM(CAST(imbalance_charge_amount AS DOUBLE))
      comment: "Total imbalance charge across settlements"
    - name: "total_congestion_charge"
      expr: SUM(CAST(congestion_charge_amount AS DOUBLE))
      comment: "Total congestion charge across settlements"
    - name: "total_netting_adjustment"
      expr: SUM(CAST(netting_adjustment_amount AS DOUBLE))
      comment: "Total netting adjustment amount"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_credit_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit exposure risk and utilization metrics"
  source: "`energy_utilities_ecm`.`trading`.`credit_exposure`"
  dimensions:
    - name: "exposure_as_of_date"
      expr: exposure_as_of_date
      comment: "Date of exposure measurement"
    - name: "counterparty_id"
      expr: counterparty_id
      comment: "Counterparty ID for the credit exposure"
    - name: "primary_credit_counterparty_id"
      expr: primary_credit_counterparty_id
      comment: "Primary counterparty ID"
    - name: "exposure_status"
      expr: exposure_status
      comment: "Status of the exposure record"
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO region code"
  measures:
    - name: "exposure_count"
      expr: COUNT(1)
      comment: "Number of credit exposure records"
    - name: "total_exposure_amount"
      expr: SUM(CAST(total_exposure_amount AS DOUBLE))
      comment: "Aggregate total exposure amount"
    - name: "average_utilization_pct"
      expr: AVG(CAST(credit_limit_utilization_pct AS DOUBLE))
      comment: "Average credit limit utilization percentage"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Sum of credit limits across counterparties"
    - name: "margin_calls_issued"
      expr: SUM(CASE WHEN margin_call_issued_flag THEN 1 ELSE 0 END)
      comment: "Count of margin calls issued"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_lmp_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Locational marginal pricing (LMP) performance metrics"
  source: "`energy_utilities_ecm`.`trading`.`lmp_price`"
  dimensions:
    - name: "market_date"
      expr: market_date
      comment: "Date of the market interval"
    - name: "market_hour"
      expr: market_hour
      comment: "Hour of the market interval"
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g., delivery point, node)"
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO region code"
    - name: "price_unit_of_measure"
      expr: price_unit_of_measure
      comment: "Unit of measure for price values"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of LMP price records"
    - name: "average_lmp_total"
      expr: AVG(CAST(lmp_total AS DOUBLE))
      comment: "Average total LMP across records"
    - name: "total_energy_component"
      expr: SUM(CAST(lmp_energy_component AS DOUBLE))
      comment: "Sum of energy component of LMP"
    - name: "total_congestion_component"
      expr: SUM(CAST(lmp_congestion_component AS DOUBLE))
      comment: "Sum of congestion component of LMP"
$$;
