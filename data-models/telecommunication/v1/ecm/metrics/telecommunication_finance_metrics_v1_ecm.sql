-- Metric views for domain: finance | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AR financial exposure and provision metrics"
  source: "`telecommunication_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AR record"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the AR record"
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the AR"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification for the AR"
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all AR records"
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Sum of bad debt provisions"
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Sum of credit memo amounts applied to AR"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Sum of amounts written off from AR"
    - name: "distinct_ar_documents"
      expr: COUNT(DISTINCT ar_document_number)
      comment: "Count of distinct AR documents"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of AR rows"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budgeting performance indicators"
  source: "`telecommunication_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the budget"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the budget"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit code"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of budget plan"
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total amount budgeted in the plan"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total amount committed against the budget"
    - name: "total_actual_to_date"
      expr: SUM(CAST(actual_to_date_amount AS DOUBLE))
      comment: "Actual spend to date"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance (planned vs actual)"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of budget plan rows"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial targets and budget allocations per profit center"
  source: "`telecommunication_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center code"
    - name: "profit_center_name"
      expr: profit_center_name
      comment: "Profit center descriptive name"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the profit center"
    - name: "business_segment"
      expr: business_segment
      comment: "Business segment classification"
  measures:
    - name: "total_arpu_target"
      expr: SUM(CAST(arpu_target AS DOUBLE))
      comment: "Sum of ARPU targets for profit centers"
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget AS DOUBLE))
      comment: "Total CAPEX budget allocated"
    - name: "total_opex_budget"
      expr: SUM(CAST(opex_budget AS DOUBLE))
      comment: "Total OPEX budget allocated"
    - name: "total_ebitda_target"
      expr: SUM(CAST(ebitda_target AS DOUBLE))
      comment: "Sum of EBITDA targets"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of profit center rows"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition performance metrics"
  source: "`telecommunication_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the recognition"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the recognition"
    - name: "recognition_status"
      expr: revenue_recognition_status
      comment: "Current status of revenue recognition"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition"
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance"
    - name: "total_contract_asset_balance"
      expr: SUM(CAST(contract_asset_balance AS DOUBLE))
      comment: "Total contract asset balance"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition rows"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity and credit capacity metrics for bank accounts"
  source: "`telecommunication_ecm`.`finance`.`bank_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (e.g., checking, savings)"
    - name: "account_status"
      expr: account_status
      comment: "Operational status of the account"
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Aggregate current balance across bank accounts"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Aggregate available balance"
    - name: "total_overdraft_limit"
      expr: SUM(CAST(overdraft_limit AS DOUBLE))
      comment: "Aggregate overdraft limits"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of bank account rows"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`finance_cash_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash pool liquidity and commitment metrics"
  source: "`telecommunication_ecm`.`finance`.`cash_pool`"
  dimensions:
    - name: "pool_type"
      expr: pool_type
      comment: "Classification of cash pool (e.g., operational, strategic)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cash pool"
    - name: "region"
      expr: region
      comment: "Geographic region of the cash pool"
    - name: "status"
      expr: cash_pool_status
      comment: "Current status of the cash pool"
  measures:
    - name: "total_pool_balance"
      expr: SUM(CAST(pool_balance AS DOUBLE))
      comment: "Total balance held in cash pools"
    - name: "total_committed_balance"
      expr: SUM(CAST(committed_balance AS DOUBLE))
      comment: "Total committed balance within cash pools"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available balance for use"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of cash pool rows"
$$;
