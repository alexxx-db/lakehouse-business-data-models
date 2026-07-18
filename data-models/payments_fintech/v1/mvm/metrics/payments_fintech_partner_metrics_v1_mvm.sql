-- Metric views for domain: partner | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`partner_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key agreement‑level financial and status metrics for executive oversight"
  source: "`payments_fintech_ecm`.`partner`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g., Active, Terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Classification of the agreement (e.g., Standard, Pilot)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the agreement"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates if the agreement auto‑renews (True/False)"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the agreement became effective"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of partner agreements"
    - name: "avg_mdr_rate"
      expr: AVG(CAST(mdr_rate AS DOUBLE))
      comment: "Average MDR (Merchant Discount Rate) across agreements, indicating pricing level"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across agreements, used for profitability analysis"
    - name: "avg_irf_rate"
      expr: AVG(CAST(irf_rate AS DOUBLE))
      comment: "Average Interchange Reimbursement Fee rate across agreements"
    - name: "avg_max_transaction_amount"
      expr: AVG(CAST(max_transaction_amount AS DOUBLE))
      comment: "Average maximum transaction amount allowed per agreement"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`partner_revenue_share_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of revenue‑share statements per agreement and partner"
  source: "`payments_fintech_ecm`.`partner`.`revenue_share_statement`"
  dimensions:
    - name: "agreement_id"
      expr: agreement_id
      comment: "Identifier of the underlying agreement"
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner ecosystem identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the statement amounts"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (e.g., Paid, Pending)"
    - name: "statement_month"
      expr: DATE_TRUNC('month', statement_period_start)
      comment: "Month of the statement period"
  measures:
    - name: "total_gross_interchange_amount"
      expr: SUM(CAST(gross_interchange_amount AS DOUBLE))
      comment: "Total gross interchange amount for the period"
    - name: "total_mdr_amount"
      expr: SUM(CAST(mdr_amount AS DOUBLE))
      comment: "Total MDR amount collected"
    - name: "total_net_revenue_amount"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Net revenue after fees and adjustments"
    - name: "total_partner_share_amount"
      expr: SUM(CAST(partner_share_amount AS DOUBLE))
      comment: "Total amount payable to partners"
    - name: "total_irf_amount"
      expr: SUM(CAST(irf_amount AS DOUBLE))
      comment: "Total Interchange Reimbursement Fee amount"
    - name: "total_adjustments_amount"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total adjustments applied to statements"
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Number of revenue share statements"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`partner_sla_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance and penalty metrics for monitoring partner service quality"
  source: "`payments_fintech_ecm`.`partner`.`sla_commitment`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., Availability, Latency)"
    - name: "sla_commitment_status"
      expr: sla_commitment_status
      comment: "Current status of the SLA commitment"
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the metric being measured under the SLA"
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner associated with the SLA"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the SLA commitment became effective"
  measures:
    - name: "sla_breach_count"
      expr: COUNT(1)
      comment: "Number of SLA breaches recorded"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across SLA commitments"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount incurred for SLA breaches"
$$;
