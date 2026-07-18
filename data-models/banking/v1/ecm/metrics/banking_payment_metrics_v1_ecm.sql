-- Metric views for domain: payment | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment transaction performance and volume metrics"
  source: "`banking_ecm`.`payment`.`payment_transaction`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., CARD, ACH)"
    - name: "payment_type"
      expr: payment_type
      comment: "Payment type such as SINGLE or RECURRING"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current settlement status of the payment"
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date on which the payment settled"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for the payment amount"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the transaction"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
    - name: "successful_payment_count"
      expr: SUM(CASE WHEN transaction_status = 'SUCCESS' THEN 1 ELSE 0 END)
      comment: "Count of payments with a successful processing status"
    - name: "avg_settlement_days"
      expr: AVG(CAST(DATEDIFF(settlement_timestamp, execution_timestamp) AS DOUBLE))
      comment: "Average number of days between execution and settlement"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee revenue and volume metrics"
  source: "`banking_ecm`.`payment`.`payment_fee`"
  dimensions:
    - name: "fee_category"
      expr: fee_category
      comment: "Category of the fee (e.g., SERVICE, TRANSACTION)"
    - name: "fee_status"
      expr: fee_status
      comment: "Current status of the fee (e.g., POSTED, PENDING)"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for the fee amount"
    - name: "payment_rail_type"
      expr: payment_rail_type
      comment: "Payment rail type associated with the fee"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of fees charged"
    - name: "fee_count"
      expr: COUNT(1)
      comment: "Number of fee records"
    - name: "avg_fee_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average fee amount per record"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_fx_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Foreign exchange transaction volume and rate metrics"
  source: "`banking_ecm`.`payment`.`fx_transaction`"
  dimensions:
    - name: "currency_pair"
      expr: currency_pair
      comment: "Currency pair traded (e.g., USD/EUR)"
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of settlement for the FX transaction"
    - name: "currency_id"
      expr: currency_id
      comment: "Identifier of the base currency"
    - name: "quote_currency_code"
      expr: quote_currency_code
      comment: "Code of the quote currency"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used for settlement"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of FX transaction (e.g., SPOT, FORWARD)"
  measures:
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settled amount in settlement currency"
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total amount in base currency"
    - name: "avg_fx_rate"
      expr: AVG(CAST(deal_rate AS DOUBLE))
      comment: "Average FX rate applied across transactions"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch-level aggregation of credit/debit volumes"
  source: "`banking_ecm`.`payment`.`batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch"
    - name: "batch_type"
      expr: batch_type
      comment: "Type of batch (e.g., DAILY, AD_HOC)"
    - name: "payment_rail"
      expr: payment_rail
      comment: "Payment rail used for the batch"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the batch"
    - name: "batch_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the batch was created"
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across batches"
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across batches"
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of payment batches processed"
$$;
