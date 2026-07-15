-- Metric views for domain: channel | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_atm_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and risk metrics for ATM transaction activity"
  source: "`banking_ecm`.`channel`.`atm_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction (day level)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type/category of the ATM transaction"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency used for the transaction"
    - name: "atm_id"
      expr: atm_id
      comment: "Identifier of the ATM where the transaction occurred"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of ATM transactions recorded"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of all transaction amounts in ATM transactions"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per ATM transaction"
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharge fees collected from ATM transactions"
    - name: "fraud_transaction_count"
      expr: SUM(CASE WHEN fraud_flag THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged as fraud"
    - name: "interchange_fee_total"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees incurred"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_atm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and revenue related metrics for ATMs"
  source: "`banking_ecm`.`channel`.`atm`"
  dimensions:
    - name: "installation_date"
      expr: installation_date
      comment: "Date the ATM was installed"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the ATM"
    - name: "location_type"
      expr: location_type
      comment: "Physical location type of the ATM (e.g., lobby, outdoor)"
    - name: "manufacturer"
      expr: manufacturer
      comment: "ATM manufacturer name"
    - name: "country_id"
      expr: country_id
      comment: "Country where the ATM is located"
  measures:
    - name: "atm_count"
      expr: COUNT(1)
      comment: "Total number of ATMs"
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Aggregate surcharge amount across all ATMs"
    - name: "avg_daily_cash_dispensed"
      expr: AVG(CAST(average_daily_cash_dispensed AS DOUBLE))
      comment: "Average daily cash dispensed per ATM"
    - name: "avg_max_withdrawal_amount"
      expr: AVG(CAST(max_withdrawal_amount AS DOUBLE))
      comment: "Average maximum withdrawal limit configured on ATMs"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction performance and revenue metrics"
  source: "`banking_ecm`.`channel`.`interaction`"
  dimensions:
    - name: "interaction_date"
      expr: DATE_TRUNC('day', interaction_timestamp)
      comment: "Date of the interaction (day level)"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Category of the interaction (e.g., ATM, digital, contact_center)"
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier associated with the interaction"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts captured in interactions"
    - name: "sla_met_count"
      expr: SUM(CASE WHEN sla_met_flag THEN 1 ELSE 0 END)
      comment: "Count of interactions that met SLA targets"
    - name: "total_atm_surcharge_amount"
      expr: SUM(CAST(atm_surcharge_amount AS DOUBLE))
      comment: "Total ATM surcharge fees recorded in interactions"
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Session-level activity and risk metrics"
  source: "`banking_ecm`.`channel`.`session`"
  dimensions:
    - name: "session_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the session started (day level)"
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier for the session"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used in the session"
    - name: "session_status"
      expr: session_status
      comment: "Current status of the session"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of user sessions"
    - name: "total_fraud_risk_score"
      expr: SUM(CAST(fraud_risk_score AS DOUBLE))
      comment: "Aggregate fraud risk score across all sessions"
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score per session"
$$;
