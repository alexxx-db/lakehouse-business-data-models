-- Metric views for domain: settlement | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level financial summary of settlements, useful for executive oversight of volume, revenue, and fee efficiency."
  source: "`payments_fintech_ecm`.`settlement`.`settlement`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of settlement"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used for settlement (e.g., ACH, RTGS)"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of settlement"
    - name: "acquirer_id"
      expr: acquirer_id
      comment: "Acquirer identifier"
    - name: "participant_id"
      expr: participant_id
      comment: "Participant identifier"
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Indicates if settlement is cross‑border"
  measures:
    - name: "total_settlements"
      expr: COUNT(1)
      comment: "Number of settlement records"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross settlement amounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net settlement amounts after fees"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fees charged on settlements"
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_amount AS DOUBLE) / NULLIF(gross_amount, 0)) * 100
      comment: "Average fee as percentage of gross amount"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_cycle_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics for settlement cycles, enabling leadership to monitor processing speed and cost."
  source: "`payments_fintech_ecm`.`settlement`.`cycle`"
  dimensions:
    - name: "cycle_code"
      expr: cycle_code
      comment: "Settlement cycle code"
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the cycle"
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Cross‑border flag for the cycle"
    - name: "start_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Start date of cycle"
    - name: "end_date"
      expr: DATE_TRUNC('day', end_timestamp)
      comment: "End date of cycle"
  measures:
    - name: "total_cycle_gross"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount processed in cycle"
    - name: "total_cycle_fees"
      expr: SUM(CAST(total_fees_amount AS DOUBLE))
      comment: "Total fees charged in cycle"
    - name: "total_cycle_net"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Net settlement amount after fees"
    - name: "avg_cycle_duration_seconds"
      expr: AVG(CAST((UNIX_TIMESTAMP(end_timestamp) - UNIX_TIMESTAMP(start_timestamp)) AS DOUBLE))
      comment: "Average cycle duration in seconds"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_net_position_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of participant net positions, supporting risk and liquidity decisions."
  source: "`payments_fintech_ecm`.`settlement`.`net_position`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of net position snapshot"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme identifier"
  measures:
    - name: "net_position_count"
      expr: COUNT(1)
      comment: "Number of net position records"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts across positions"
    - name: "total_gross_credit"
      expr: SUM(CAST(gross_credit_total AS DOUBLE))
      comment: "Sum of gross credit totals"
    - name: "total_gross_debit"
      expr: SUM(CAST(gross_debit_total AS DOUBLE))
      comment: "Sum of gross debit totals"
    - name: "adjusted_position_pct"
      expr: AVG(CASE WHEN is_adjusted THEN 1 ELSE 0 END) * 100
      comment: "Percentage of positions that have been adjusted"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_merchant_payout_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key payout KPIs that drive merchant satisfaction and cash‑flow monitoring."
  source: "`payments_fintech_ecm`.`settlement`.`merchant_payout`"
  dimensions:
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "payout_method"
      expr: payout_method
      comment: "Method used for payout"
    - name: "payout_status"
      expr: payout_status
      comment: "Current status of payout"
    - name: "payout_date"
      expr: DATE_TRUNC('day', payout_timestamp)
      comment: "Date of payout"
  measures:
    - name: "total_payouts"
      expr: COUNT(1)
      comment: "Number of payout records"
    - name: "total_payout_amount"
      expr: SUM(CAST(payout_amount AS DOUBLE))
      comment: "Total amount paid out to merchants"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount returned to merchants"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount associated with payouts"
    - name: "avg_payout_amount"
      expr: AVG(CAST(payout_amount AS DOUBLE))
      comment: "Average payout amount per record"
$$;


CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`settlement_adjustment_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of adjustments, enabling risk and compliance teams to monitor fee reversals and corrections."
  source: "`payments_fintech_ecm`.`settlement`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., fee, reversal)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of adjustment"
    - name: "participant_id"
      expr: participant_id
      comment: "Participant linked to adjustment"
    - name: "settlement_id"
      expr: settlement_id
      comment: "Settlement identifier that the adjustment relates to"
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Number of adjustment records"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Sum of adjusted amounts"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fees associated with adjustments"
    - name: "avg_adjusted_amount"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average adjusted amount per record"
$$;
