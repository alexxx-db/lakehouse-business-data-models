-- Metric views for domain: finance | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial totals for accounts payable invoices."
  source: "`vibe_water_utilities_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the invoice."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of the invoice amounts."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor supplying the goods/services."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts and taxes."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amounts applied to invoices."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated payment amounts for accounts payable."
  source: "`vibe_water_utilities_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to make the payment (e.g., ACH, Check)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor associated with the payment."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid across all AP payments."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and taxes."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax withheld on payments."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of AP payment records."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core accounts receivable financial performance."
  source: "`vibe_water_utilities_v1`.`finance`.`ar_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the AR transaction."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction amounts."
  measures:
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Sum of original amounts billed to customers."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of amounts actually received from customers."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Sum of amounts still due from customers."
    - name: "ar_transaction_count"
      expr: COUNT(1)
      comment: "Number of AR transaction records."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution and variance metrics."
  source: "`vibe_water_utilities_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the budget line."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget (e.g., Capital, Operating)."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the budget line."
    - name: "fund_id"
      expr: fund_id
      comment: "Fund linked to the budget line."
  measures:
    - name: "total_original_budget_amount"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total originally approved budget amount."
    - name: "total_actual_expenditure_amount"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditures recorded against the budget line."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts (budget minus actual)."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget line records."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_debt_service_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt service payment performance indicators."
  source: "`vibe_water_utilities_v1`.`finance`.`debt_service_payment`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the debt service payment."
    - name: "debt_instrument_id"
      expr: debt_instrument_id
      comment: "Identifier of the debt instrument being serviced."
    - name: "fund_id"
      expr: fund_id
      comment: "Fund used for the debt service payment."
  measures:
    - name: "total_debt_service_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total amount paid for debt service obligations."
    - name: "average_debt_service_coverage_ratio"
      expr: AVG(CAST(debt_service_coverage_ratio AS DOUBLE))
      comment: "Average debt service coverage ratio across payments."
    - name: "debt_service_payment_count"
      expr: COUNT(1)
      comment: "Number of debt service payment records."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall financial budgeting totals."
  source: "`vibe_water_utilities_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the finance budget."
    - name: "fund_id"
      expr: fund_id
      comment: "Fund associated with the budget."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the budget."
  measures:
    - name: "total_allotment_amount"
      expr: SUM(CAST(allotment_amount AS DOUBLE))
      comment: "Sum of budget allotments across all finance budgets."
    - name: "total_encumbrance_amount"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Sum of encumbered amounts (committed but not yet spent)."
    - name: "total_expended_amount"
      expr: SUM(CAST(expended_amount AS DOUBLE))
      comment: "Sum of amounts actually expended."
    - name: "finance_budget_count"
      expr: COUNT(1)
      comment: "Number of finance budget records."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_revenue_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key revenue and expense requirements for rate cases and budgeting."
  source: "`vibe_water_utilities_v1`.`finance`.`revenue_requirement`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund associated with the revenue requirement."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the revenue requirement."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body governing the requirement."
  measures:
    - name: "total_revenue_requirement_amount"
      expr: SUM(CAST(total_revenue_requirement_amount AS DOUBLE))
      comment: "Total revenue required to meet regulatory and financial targets."
    - name: "total_operating_expenditure_amount"
      expr: SUM(CAST(operating_expenditure_amount AS DOUBLE))
      comment: "Sum of operating expenditures required."
    - name: "total_capital_expenditure_amount"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Sum of capital expenditures required."
    - name: "revenue_requirement_count"
      expr: COUNT(1)
      comment: "Number of revenue requirement records."
$$;