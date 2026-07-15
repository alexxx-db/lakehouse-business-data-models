-- Metric views for domain: trade | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`trade_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution‑level trade metrics for the trade domain"
  source: "`banking_ecm`.`trade`.`execution`"
  dimensions:
    - name: "execution_date"
      expr: DATE_TRUNC('day', execution_timestamp)
      comment: "Date of execution (derived from timestamp)"
    - name: "instrument_id"
      expr: instrument_id
      comment: "Instrument identifier"
    - name: "broker_id"
      expr: broker_id
      comment: "Broker executing the trade"
    - name: "trading_book_id"
      expr: trading_book_id
      comment: "Trading book identifier"
    - name: "product_type_id"
      expr: product_type_id
      comment: "Product type identifier"
    - name: "currency_id"
      expr: currency_id
      comment: "Trade currency identifier"
    - name: "trade_side"
      expr: trade_side
      comment: "Buy or sell side of the trade"
    - name: "venue"
      expr: venue
      comment: "Execution venue"
  measures:
    - name: "trade_count"
      expr: COUNT(1)
      comment: "Number of execution records"
    - name: "total_gross_trade_value"
      expr: SUM(CAST(gross_trade_value AS DOUBLE))
      comment: "Sum of gross trade value"
    - name: "total_net_trade_value"
      expr: SUM(CAST(net_trade_value AS DOUBLE))
      comment: "Sum of net trade value"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission charged"
    - name: "avg_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average execution price"
    - name: "avg_executed_quantity"
      expr: AVG(CAST(executed_quantity AS DOUBLE))
      comment: "Average quantity executed"
    - name: "avg_commission_pct"
      expr: AVG(commission_amount / NULLIF(gross_trade_value, 0) * 100)
      comment: "Average commission as percentage of gross trade value"
    - name: "distinct_instrument_count"
      expr: COUNT(DISTINCT instrument_id)
      comment: "Number of distinct instruments traded"
    - name: "distinct_broker_count"
      expr: COUNT(DISTINCT broker_id)
      comment: "Number of distinct brokers involved"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`trade_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation‑level trade metrics for the trade domain"
  source: "`banking_ecm`.`trade`.`allocation`"
  dimensions:
    - name: "allocation_date"
      expr: DATE_TRUNC('day', allocation_timestamp)
      comment: "Date of allocation (derived from timestamp)"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation"
    - name: "side"
      expr: side
      comment: "Buy or sell side of the allocation"
    - name: "clearing_broker_id"
      expr: broker_id
      comment: "Clearing broker involved in the allocation"
  measures:
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of allocation records"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after allocation"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average allocation percentage"
$$;
