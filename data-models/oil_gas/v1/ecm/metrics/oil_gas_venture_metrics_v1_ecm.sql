-- Metric views for domain: venture | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_cash_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash call activity and financial exposure metrics"
  source: "`oil_gas_ecm`.`venture`.`cash_call`"
  dimensions:
    - name: "cash_call_status"
      expr: cash_call_status
      comment: "Current status of the cash call"
    - name: "cash_call_number"
      expr: cash_call_number
      comment: "Unique identifier for the cash call"
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month cash call was issued"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month cash call is due"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cash call amounts"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner associated with the cash call"
  measures:
    - name: "total_call_amount"
      expr: SUM(CAST(total_call_amount AS DOUBLE))
      comment: "Total amount requested in cash calls"
    - name: "total_amount_outstanding"
      expr: SUM(CAST(total_amount_outstanding AS DOUBLE))
      comment: "Total outstanding balance across cash calls"
    - name: "total_amount_received"
      expr: SUM(CAST(total_amount_received AS DOUBLE))
      comment: "Total amount received for cash calls"
    - name: "cash_calls_count"
      expr: COUNT(1)
      comment: "Number of cash call records"
    - name: "average_call_amount"
      expr: AVG(CAST(total_call_amount AS DOUBLE))
      comment: "Average cash call amount per record"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_cash_call_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution and interest metrics for cash calls"
  source: "`oil_gas_ecm`.`venture`.`cash_call_payment`"
  dimensions:
    - name: "cash_call_id"
      expr: cash_call_id
      comment: "Reference to the cash call"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner receiving/issuing the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment"
  measures:
    - name: "total_called_amount"
      expr: SUM(CAST(called_amount AS DOUBLE))
      comment: "Total amount called for payment"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount actually paid"
    - name: "total_default_interest_amount"
      expr: SUM(CAST(default_interest_amount AS DOUBLE))
      comment: "Total default interest accrued on payments"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment records"
    - name: "average_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per record"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_lifting_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement vs. actual lift performance metrics"
  source: "`oil_gas_ecm`.`venture`.`lifting_entitlement`"
  dimensions:
    - name: "partner_id"
      expr: partner_id
      comment: "Partner entitled to lift"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product type (oil, gas, etc.)"
    - name: "entitlement_month"
      expr: DATE_TRUNC('month', entitlement_period_start_date)
      comment: "Month of entitlement period start"
    - name: "lease_id"
      expr: lease_id
      comment: "Lease associated with the entitlement"
    - name: "psa_id"
      expr: psa_id
      comment: "Production sharing agreement identifier"
  measures:
    - name: "total_entitlement_volume_bbl"
      expr: SUM(CAST(entitlement_volume_bbl AS DOUBLE))
      comment: "Total entitled oil volume in barrels"
    - name: "total_actual_lifted_volume_bbl"
      expr: SUM(CAST(actual_lifted_volume_bbl AS DOUBLE))
      comment: "Total actual lifted oil volume in barrels"
    - name: "total_imbalance_value_usd"
      expr: SUM(CAST(imbalance_value_usd AS DOUBLE))
      comment: "Total monetary imbalance value (USD)"
    - name: "lifting_entitlement_count"
      expr: COUNT(1)
      comment: "Number of lifting entitlement records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and demographic overview of venture partners"
  source: "`oil_gas_ecm`.`venture`.`partner`"
  dimensions:
    - name: "country_of_incorporation"
      expr: country_of_incorporation
      comment: "Partner's country of incorporation"
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type"
    - name: "is_operator"
      expr: is_operator
      comment: "Flag indicating if partner is an operator"
    - name: "is_government_entity"
      expr: is_government_entity
      comment: "Flag indicating government ownership"
    - name: "partner_status"
      expr: partner_status
      comment: "Current status of the partnership"
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction for the partner"
  measures:
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Aggregate annual revenue of partners"
    - name: "partner_count"
      expr: COUNT(1)
      comment: "Number of partner records"
    - name: "average_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit across partners"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_joint_venture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic and financial snapshot of joint ventures"
  source: "`oil_gas_ecm`.`venture`.`joint_venture`"
  dimensions:
    - name: "joint_venture_type"
      expr: joint_venture_type
      comment: "Classification of joint venture"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the joint venture"
    - name: "status"
      expr: status
      comment: "Current operational status"
    - name: "sec_disclosure_flag"
      expr: sec_disclosure_flag
      comment: "SEC disclosure requirement flag"
    - name: "joint_venture_name"
      expr: joint_venture_name
      comment: "Descriptive name of the joint venture"
  measures:
    - name: "total_commitment_amount"
      expr: SUM(CAST(total_commitment_amount AS DOUBLE))
      comment: "Total financial commitment across joint ventures"
    - name: "joint_venture_count"
      expr: COUNT(1)
      comment: "Number of joint venture records"
    - name: "average_partner_equity_percent"
      expr: AVG(CAST(partner_equity_percent AS DOUBLE))
      comment: "Average equity percentage held by partners"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_afe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization and financial control metrics for AFEs"
  source: "`oil_gas_ecm`.`venture`.`venture_afe`"
  dimensions:
    - name: "afe_status"
      expr: afe_status
      comment: "Current status of the AFE"
    - name: "afe_type"
      expr: afe_type
      comment: "Type/category of the AFE"
    - name: "approval_deadline_month"
      expr: DATE_TRUNC('month', approval_deadline_date)
      comment: "Month by which AFE approval is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for AFE amounts"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner associated with the AFE"
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Sum of approved AFE amounts"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between approved and actual AFE amounts"
    - name: "afe_count"
      expr: COUNT(1)
      comment: "Number of AFE records"
    - name: "average_approval_threshold_amount"
      expr: AVG(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Average approval threshold amount across AFEs"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_cost_recovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost recovery performance and limits"
  source: "`oil_gas_ecm`.`venture`.`cost_recovery`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High‑level cost category"
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost sub‑category"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts"
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the cost recovery audit"
    - name: "period_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the cost recovery period"
  measures:
    - name: "total_costs_incurred"
      expr: SUM(CAST(costs_incurred_period AS DOUBLE))
      comment: "Total costs incurred in the period"
    - name: "total_costs_recovered"
      expr: SUM(CAST(costs_recovered_period AS DOUBLE))
      comment: "Total costs recovered in the period"
    - name: "total_ceiling_limit"
      expr: SUM(CAST(ceiling_limit AS DOUBLE))
      comment: "Aggregate ceiling limits for cost recovery"
    - name: "cost_recovery_record_count"
      expr: COUNT(1)
      comment: "Number of cost recovery records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_royalty_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty financial obligations and payments"
  source: "`oil_gas_ecm`.`venture`.`royalty_obligation`"
  dimensions:
    - name: "royalty_type"
      expr: royalty_type
      comment: "Primary type of royalty (e.g., production, revenue)"
    - name: "royalty_subtype"
      expr: royalty_subtype
      comment: "Subtype or specific scheme of royalty"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of royalty amounts"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when royalty obligation became effective"
    - name: "royalty_owner_id"
      expr: royalty_owner_id
      comment: "Owner of the royalty right"
    - name: "psa_id"
      expr: psa_id
      comment: "Production sharing agreement linked to the royalty"
  measures:
    - name: "total_minimum_royalty_amount"
      expr: SUM(CAST(minimum_royalty_amount AS DOUBLE))
      comment: "Sum of minimum royalty amounts due"
    - name: "total_cumulative_paid"
      expr: SUM(CAST(cumulative_royalty_paid_amount AS DOUBLE))
      comment: "Total royalty amounts paid to date"
    - name: "royalty_obligation_count"
      expr: COUNT(1)
      comment: "Number of royalty obligation records"
    - name: "average_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage"
$$;
