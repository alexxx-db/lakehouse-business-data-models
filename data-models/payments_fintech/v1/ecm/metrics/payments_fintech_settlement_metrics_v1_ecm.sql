-- Metric views for domain: settlement | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core settlement performance metrics"
  source: "`payments_fintech_ecm`.`settlement`.`settlement`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of the settlement"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used for settlement (e.g., ACH, RTGS)"
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner participating in the ecosystem"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the settlement"
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g., final, interim)"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount settled across all settlements"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after fees and adjustments"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Aggregate of all fees applied to settlements"
    - name: "average_settlement_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net settlement amount per settlement record"
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Number of settlement records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics that evaluate settlement cycle efficiency and cost"
  source: "`payments_fintech_ecm`.`settlement`.`cycle`"
  dimensions:
    - name: "cycle_code"
      expr: cycle_code
      comment: "Business code for the settlement cycle"
    - name: "cycle_status"
      expr: cycle_status
      comment: "Operational status of the cycle"
    - name: "settlement_cycle_type"
      expr: settlement_cycle_type
      comment: "Classification of the cycle (e.g., daily, weekly)"
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Indicates if the cycle includes cross‑border settlements"
    - name: "start_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Start date of the cycle"
    - name: "end_date"
      expr: DATE_TRUNC('day', end_timestamp)
      comment: "End date of the cycle"
  measures:
    - name: "total_cycle_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross amounts for the cycle"
    - name: "total_cycle_net_settlement"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Sum of net settlement amounts for the cycle"
    - name: "total_cycle_fees"
      expr: SUM(CAST(total_fees_amount AS DOUBLE))
      comment: "Total fees incurred in the cycle"
    - name: "average_cycle_net_position"
      expr: AVG(CAST(net_position AS DOUBLE))
      comment: "Average net position across cycles"
    - name: "cycle_count"
      expr: COUNT(1)
      comment: "Number of settlement cycles"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_instruction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for settlement instructions"
  source: "`payments_fintech_ecm`.`settlement`.`instruction`"
  dimensions:
    - name: "instruction_status"
      expr: instruction_status
      comment: "Current processing status of the instruction"
    - name: "instruction_type"
      expr: instruction_type
      comment: "Type of instruction (e.g., payment, reversal)"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the instruction"
    - name: "payment_rail_id"
      expr: payment_rail_id
      comment: "Identifier of the payment rail used"
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner associated with the instruction"
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the instruction was settled"
    - name: "value_date"
      expr: value_date
      comment: "Value date for the instruction"
  measures:
    - name: "total_instruction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of settlement instructions"
    - name: "average_instruction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average instruction amount"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Aggregate of fees associated with instructions"
    - name: "instruction_count"
      expr: COUNT(1)
      comment: "Number of settlement instructions"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_merchant_payout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of merchant payouts"
  source: "`payments_fintech_ecm`.`settlement`.`merchant_payout`"
  dimensions:
    - name: "payout_status"
      expr: payout_status
      comment: "Current status of the payout"
    - name: "payout_method"
      expr: payout_method
      comment: "Method used for payout (e.g., ACH, wire)"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Identifier of the merchant receiving the payout"
    - name: "cycle_id"
      expr: cycle_id
      comment: "Settlement cycle linked to the payout"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the payout"
  measures:
    - name: "total_payout_amount"
      expr: SUM(CAST(payout_amount AS DOUBLE))
      comment: "Total amount paid out to merchants"
    - name: "total_interchange_fee"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Sum of interchange fees across payouts"
    - name: "total_mdr_fee"
      expr: SUM(CAST(mdr_amount AS DOUBLE))
      comment: "Sum of merchant discount rate fees"
    - name: "total_msf_fee"
      expr: SUM(CAST(msf_amount AS DOUBLE))
      comment: "Sum of merchant service fees"
    - name: "total_scheme_fee"
      expr: SUM(CAST(scheme_fee_amount AS DOUBLE))
      comment: "Sum of scheme fees (e.g., Visa, Mastercard)"
    - name: "payout_count"
      expr: COUNT(1)
      comment: "Number of merchant payout records"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_net_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics that reflect overall net position health and exposure"
  source: "`payments_fintech_ecm`.`settlement`.`net_position`"
  dimensions:
    - name: "net_position_status"
      expr: net_position_status
      comment: "Operational status of the net position"
    - name: "net_position_source"
      expr: net_position_source
      comment: "Source system or origin of the net position"
    - name: "cycle_id"
      expr: cycle_id
      comment: "Associated settlement cycle"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the net position"
  measures:
    - name: "total_gross_credit"
      expr: SUM(CAST(gross_credit_total AS DOUBLE))
      comment: "Total gross credit across net positions"
    - name: "total_gross_debit"
      expr: SUM(CAST(gross_debit_total AS DOUBLE))
      comment: "Total gross debit across net positions"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Aggregate net amount for net positions"
    - name: "average_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per net position"
    - name: "net_position_count"
      expr: COUNT(1)
      comment: "Number of net position records"
$$;
