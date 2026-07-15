-- Metric views for domain: trade | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`trade_capture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade capture level KPIs summarizing trade amounts and notional exposure."
  source: "`banking_ecm`.`trade`.`capture`"
  dimensions:
    - name: "trade_date"
      expr: trade_date
      comment: "Date the trade was executed"
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the trade settled"
    - name: "trading_book"
      expr: trading_book
      comment: "Trading book identifier"
    - name: "product_type_id"
      expr: product_type_id
      comment: "Product type identifier"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Regulatory reporting flag"
  measures:
    - name: "trade_count"
      expr: COUNT(1)
      comment: "Number of trade capture records"
    - name: "total_trade_amount"
      expr: SUM(CAST(trade_amount AS DOUBLE))
      comment: "Sum of trade amounts"
    - name: "total_notional_amount"
      expr: SUM(CAST(notional_amount AS DOUBLE))
      comment: "Sum of notional amounts"
    - name: "avg_trade_amount"
      expr: AVG(CAST(trade_amount AS DOUBLE))
      comment: "Average trade amount per capture"
    - name: "avg_notional_amount"
      expr: AVG(CAST(notional_amount AS DOUBLE))
      comment: "Average notional amount per capture"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`trade_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution level performance metrics including quantity, price, and fees."
  source: "`banking_ecm`.`trade`.`execution`"
  dimensions:
    - name: "execution_date"
      expr: DATE_TRUNC('day', execution_timestamp)
      comment: "Date of execution"
    - name: "instrument_id"
      expr: instrument_id
      comment: "Instrument identifier"
    - name: "trade_side"
      expr: trade_side
      comment: "Buy or sell side"
    - name: "venue"
      expr: venue
      comment: "Execution venue"
  measures:
    - name: "execution_count"
      expr: COUNT(1)
      comment: "Number of execution records"
    - name: "total_executed_quantity"
      expr: SUM(CAST(executed_quantity AS DOUBLE))
      comment: "Total quantity executed"
    - name: "avg_execution_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average execution price"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions paid"
    - name: "total_clearing_fee"
      expr: SUM(CAST(clearing_fee AS DOUBLE))
      comment: "Total clearing fees"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`trade_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position level valuation and P&L metrics."
  source: "`banking_ecm`.`trade`.`trade_position`"
  dimensions:
    - name: "position_date"
      expr: position_date
      comment: "Date of the position snapshot"
    - name: "instrument_id"
      expr: instrument_id
      comment: "Instrument identifier"
    - name: "trading_book_id"
      expr: trading_book_id
      comment: "Trading book identifier"
    - name: "party_id"
      expr: party_id
      comment: "Owner party identifier"
    - name: "position_type"
      expr: position_type
      comment: "Type of position (e.g., long, short)"
  measures:
    - name: "position_count"
      expr: COUNT(1)
      comment: "Number of position records"
    - name: "total_market_value"
      expr: SUM(CAST(market_value AS DOUBLE))
      comment: "Aggregate market value of positions"
    - name: "total_unrealized_pnl"
      expr: SUM(CAST(unrealized_pnl AS DOUBLE))
      comment: "Total unrealized profit and loss"
    - name: "total_realized_pnl"
      expr: SUM(CAST(realized_pnl AS DOUBLE))
      comment: "Total realized profit and loss"
    - name: "avg_market_price"
      expr: AVG(CAST(market_price AS DOUBLE))
      comment: "Average market price across positions"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`trade_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee related KPIs per trade."
  source: "`banking_ecm`.`trade`.`trade_fee`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of fee"
    - name: "fee_category"
      expr: fee_category
      comment: "Category of fee"
    - name: "fee_status"
      expr: fee_status
      comment: "Current status of the fee"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the fee"
    - name: "trading_book_id"
      expr: trading_book_id
      comment: "Trading book identifier"
  measures:
    - name: "fee_count"
      expr: COUNT(1)
      comment: "Number of fee records"
    - name: "total_fee_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of fee amounts"
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Sum of net fee amounts after adjustments"
$$;
