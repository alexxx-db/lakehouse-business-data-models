-- Metric views for domain: finance | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:51:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual business metrics"
  source: "`vibe_automotive_v1`.`finance`.`accrual`"
  dimensions:
    - name: "Accrual Date"
      expr: accrual_date
    - name: "Accrual Number"
      expr: accrual_number
    - name: "Accrual Status"
      expr: accrual_status
    - name: "Accrual Type"
      expr: accrual_type
    - name: "Audit User"
      expr: audit_user
    - name: "Basis"
      expr: basis
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Accrual Description"
      expr: accrual_description
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Manual"
      expr: is_manual
    - name: "Is Tax Relevant"
      expr: is_tax_relevant
    - name: "Notes"
      expr: notes
    - name: "Period End Date"
      expr: period_end_date
    - name: "Posting Date"
      expr: posting_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accrual"
      expr: COUNT(DISTINCT accrual_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_allocation_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation Cycle business metrics"
  source: "`vibe_automotive_v1`.`finance`.`allocation_cycle`"
  dimensions:
    - name: "Allocation Basis"
      expr: allocation_basis
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cycle Code"
      expr: cycle_code
    - name: "Cycle Name"
      expr: cycle_name
    - name: "Cycle Type"
      expr: cycle_type
    - name: "Allocation Cycle Description"
      expr: allocation_cycle_description
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Current"
      expr: is_current
    - name: "Period Number"
      expr: period_number
    - name: "Start Date"
      expr: start_date
    - name: "Allocation Cycle Status"
      expr: allocation_cycle_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Allocation Cycle"
      expr: COUNT(DISTINCT allocation_cycle_id)
    - name: "Total Actual Amount"
      expr: SUM(actual_amount)
    - name: "Average Actual Amount"
      expr: AVG(actual_amount)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ap Invoice business metrics"
  source: "`vibe_automotive_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Due Date"
      expr: due_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Goods Receipt Number"
      expr: goods_receipt_number
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Is Credit Memo"
      expr: is_credit_memo
    - name: "Material Group"
      expr: material_group
    - name: "Notes"
      expr: notes
    - name: "Payment Block Flag"
      expr: payment_block_flag
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Reference"
      expr: payment_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ap Invoice"
      expr: COUNT(DISTINCT ap_invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Warranty Reserve Amount"
      expr: SUM(warranty_reserve_amount)
    - name: "Average Warranty Reserve Amount"
      expr: AVG(warranty_reserve_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ap Payment business metrics"
  source: "`vibe_automotive_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Clearance Date"
      expr: clearance_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Early Payment Discount Flag"
      expr: early_payment_discount_flag
    - name: "House Bank Code"
      expr: house_bank_code
    - name: "Is Automated"
      expr: is_automated
    - name: "Payment Channel"
      expr: payment_channel
    - name: "Payment Comments"
      expr: payment_comments
    - name: "Payment Cost Center"
      expr: payment_cost_center
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Description"
      expr: payment_description
    - name: "Payment Document Number"
      expr: payment_document_number
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Error Flag"
      expr: payment_error_flag
    - name: "Payment Exchange Rate Date"
      expr: payment_exchange_rate_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ap Payment"
      expr: COUNT(DISTINCT ap_payment_id)
    - name: "Total Amount Gross"
      expr: SUM(amount_gross)
    - name: "Average Amount Gross"
      expr: AVG(amount_gross)
    - name: "Total Amount Net"
      expr: SUM(amount_net)
    - name: "Average Amount Net"
      expr: AVG(amount_net)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Payment Original Amount"
      expr: SUM(payment_original_amount)
    - name: "Average Payment Original Amount"
      expr: AVG(payment_original_amount)
    - name: "Total Payment Vat Amount"
      expr: SUM(payment_vat_amount)
    - name: "Average Payment Vat Amount"
      expr: AVG(payment_vat_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ar Invoice business metrics"
  source: "`vibe_automotive_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "Accounting Date"
      expr: accounting_date
    - name: "Aging Bucket"
      expr: aging_bucket
    - name: "Ar Invoice Status"
      expr: ar_invoice_status
    - name: "Billing Document Number"
      expr: billing_document_number
    - name: "Collection Status"
      expr: collection_status
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Note Number"
      expr: delivery_note_number
    - name: "Discount Reason"
      expr: discount_reason
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Due Date"
      expr: due_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Intercompany Flag"
      expr: intercompany_flag
    - name: "Invoice Category"
      expr: invoice_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ar Invoice"
      expr: COUNT(DISTINCT ar_invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Warranty Reserve Amount"
      expr: SUM(warranty_reserve_amount)
    - name: "Average Warranty Reserve Amount"
      expr: AVG(warranty_reserve_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ar Payment business metrics"
  source: "`vibe_automotive_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "Ar Payment Status"
      expr: ar_payment_status
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Name"
      expr: bank_name
    - name: "Cash Application Status"
      expr: cash_application_status
    - name: "Clearance Date"
      expr: clearance_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Due Date"
      expr: due_date
    - name: "Exchange Rate Date"
      expr: exchange_rate_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Is Partial Payment"
      expr: is_partial_payment
    - name: "Notes"
      expr: notes
    - name: "Payment Channel"
      expr: payment_channel
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Number"
      expr: payment_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ar Payment"
      expr: COUNT(DISTINCT ar_payment_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Original Amount"
      expr: SUM(original_amount)
    - name: "Average Original Amount"
      expr: AVG(original_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Line business metrics"
  source: "`vibe_automotive_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Amount Type"
      expr: amount_type
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Budget Line Status"
      expr: budget_line_status
    - name: "Business Unit"
      expr: business_unit
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Budget Line Description"
      expr: budget_line_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Manual"
      expr: is_manual
    - name: "Justification"
      expr: justification
    - name: "Line Sequence"
      expr: line_sequence
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Line"
      expr: COUNT(DISTINCT budget_line_id)
    - name: "Total Line Quantity"
      expr: SUM(line_quantity)
    - name: "Average Line Quantity"
      expr: AVG(line_quantity)
    - name: "Total Planned Amount"
      expr: SUM(planned_amount)
    - name: "Average Planned Amount"
      expr: AVG(planned_amount)
    - name: "Total Revised Amount"
      expr: SUM(revised_amount)
    - name: "Average Revised Amount"
      expr: AVG(revised_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Plan business metrics"
  source: "`vibe_automotive_v1`.`finance`.`budget_plan`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Date"
      expr: approval_date
    - name: "Budget Category"
      expr: budget_category
    - name: "Budget Plan Status"
      expr: budget_plan_status
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account"
      expr: gl_account
    - name: "Is Forecast"
      expr: is_forecast
    - name: "Is Locked"
      expr: is_locked
    - name: "Notes"
      expr: notes
    - name: "Plan Code"
      expr: plan_code
    - name: "Plan Name"
      expr: plan_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Plan"
      expr: COUNT(DISTINCT budget_plan_id)
    - name: "Total Planned Amount"
      expr: SUM(planned_amount)
    - name: "Average Planned Amount"
      expr: AVG(planned_amount)
    - name: "Total Revised Amount"
      expr: SUM(revised_amount)
    - name: "Average Revised Amount"
      expr: AVG(revised_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capex Request business metrics"
  source: "`vibe_automotive_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Capex Request Status"
      expr: capex_request_status
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Years"
      expr: depreciation_years
    - name: "Capex Request Description"
      expr: capex_request_description
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Funding Source"
      expr: funding_source
    - name: "Has External Funding"
      expr: has_external_funding
    - name: "Investment Category"
      expr: investment_category
    - name: "Is Capitalized"
      expr: is_capitalized
    - name: "Is Compliant"
      expr: is_compliant
    - name: "Justification"
      expr: justification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capex Request"
      expr: COUNT(DISTINCT capex_request_id)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Approved Budget Amount"
      expr: SUM(approved_budget_amount)
    - name: "Average Approved Budget Amount"
      expr: AVG(approved_budget_amount)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total External Funding Amount"
      expr: SUM(external_funding_amount)
    - name: "Average External Funding Amount"
      expr: AVG(external_funding_amount)
    - name: "Total Irr"
      expr: SUM(irr)
    - name: "Average Irr"
      expr: AVG(irr)
    - name: "Total Npv"
      expr: SUM(npv)
    - name: "Average Npv"
      expr: AVG(npv)
    - name: "Total Payback Period Years"
      expr: SUM(payback_period_years)
    - name: "Average Payback Period Years"
      expr: AVG(payback_period_years)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_company_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Company Code business metrics"
  source: "`vibe_automotive_v1`.`finance`.`company_code`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Business Line"
      expr: business_line
    - name: "Chart Of Accounts"
      expr: chart_of_accounts
    - name: "City"
      expr: city
    - name: "Company Code"
      expr: company_code
    - name: "Company Code Status"
      expr: company_code_status
    - name: "Consolidation Group"
      expr: consolidation_group
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Entity Type"
      expr: entity_type
    - name: "Fiscal Year Variant"
      expr: fiscal_year_variant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Company Code"
      expr: COUNT(DISTINCT company_code_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Allocation business metrics"
  source: "`vibe_automotive_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Cost Allocation Status"
      expr: cost_allocation_status
    - name: "Cost Element Code"
      expr: cost_element_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cost Allocation Description"
      expr: cost_allocation_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Intercompany"
      expr: is_intercompany
    - name: "Posting Date"
      expr: posting_date
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Receiver Cost Center Code"
      expr: receiver_cost_center_code
    - name: "Sender Cost Center Code"
      expr: sender_cost_center_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Allocation"
      expr: COUNT(DISTINCT cost_allocation_id)
    - name: "Total Activity Quantity"
      expr: SUM(activity_quantity)
    - name: "Average Activity Quantity"
      expr: AVG(activity_quantity)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Statistical Key Value"
      expr: SUM(statistical_key_value)
    - name: "Average Statistical Key Value"
      expr: AVG(statistical_key_value)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Center business metrics"
  source: "`vibe_automotive_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Status"
      expr: approval_status
    - name: "Cost Center Category"
      expr: cost_center_category
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Cost Center Status"
      expr: cost_center_status
    - name: "Cost Center Type"
      expr: cost_center_type
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cost Center Description"
      expr: cost_center_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Cost Center Name"
      expr: cost_center_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Center"
      expr: COUNT(DISTINCT cost_center_id)
    - name: "Total Actual Spend"
      expr: SUM(actual_spend)
    - name: "Average Actual Spend"
      expr: AVG(actual_spend)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_currency_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency Rate business metrics"
  source: "`vibe_automotive_v1`.`finance`.`currency_rate`"
  dimensions:
    - name: "Company Code"
      expr: company_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency From"
      expr: currency_from
    - name: "Currency To"
      expr: currency_to
    - name: "Currency Rate Description"
      expr: currency_rate_description
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Historical"
      expr: is_historical
    - name: "Period"
      expr: period
    - name: "Rate Date"
      expr: rate_date
    - name: "Rate Type"
      expr: rate_type
    - name: "Source"
      expr: source
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Rate Date Month"
      expr: DATE_TRUNC('MONTH', rate_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Currency Rate"
      expr: COUNT(DISTINCT currency_rate_id)
    - name: "Total Rate Value"
      expr: SUM(rate_value)
    - name: "Average Rate Value"
      expr: AVG(rate_value)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_dealer_incentive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Incentive business metrics"
  source: "`vibe_automotive_v1`.`finance`.`dealer_incentive`"
  dimensions:
    - name: "Accounting Period"
      expr: accounting_period
    - name: "Accrual Basis"
      expr: accrual_basis
    - name: "Actual Units Accrued"
      expr: actual_units_accrued
    - name: "Audit User"
      expr: audit_user
    - name: "Budget Version"
      expr: budget_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dealer Incentive Status"
      expr: dealer_incentive_status
    - name: "Dealer Incentive Description"
      expr: dealer_incentive_description
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "End Date"
      expr: end_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Incentive Category"
      expr: incentive_category
    - name: "Is Taxable"
      expr: is_taxable
    - name: "Max Units"
      expr: max_units
    - name: "Model Year"
      expr: model_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Incentive"
      expr: COUNT(DISTINCT dealer_incentive_id)
    - name: "Total Actual Payment Amount"
      expr: SUM(actual_payment_amount)
    - name: "Average Actual Payment Amount"
      expr: AVG(actual_payment_amount)
    - name: "Total Incentive Amount Per Unit"
      expr: SUM(incentive_amount_per_unit)
    - name: "Average Incentive Amount Per Unit"
      expr: AVG(incentive_amount_per_unit)
    - name: "Total Payment Trigger Threshold"
      expr: SUM(payment_trigger_threshold)
    - name: "Average Payment Trigger Threshold"
      expr: AVG(payment_trigger_threshold)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Total Budget"
      expr: SUM(total_budget)
    - name: "Average Total Budget"
      expr: AVG(total_budget)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_depreciation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation Run business metrics"
  source: "`vibe_automotive_v1`.`finance`.`depreciation_run`"
  dimensions:
    - name: "Company Code"
      expr: company_code
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Area"
      expr: depreciation_area
    - name: "Depreciation End Date"
      expr: depreciation_end_date
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Test Run"
      expr: is_test_run
    - name: "Number Of Assets Processed"
      expr: number_of_assets_processed
    - name: "Posting Document Number"
      expr: posting_document_number
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Remarks"
      expr: remarks
    - name: "Run Number"
      expr: run_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Depreciation Run"
      expr: COUNT(DISTINCT depreciation_run_id)
    - name: "Total Total Depreciation Amount"
      expr: SUM(total_depreciation_amount)
    - name: "Average Total Depreciation Amount"
      expr: AVG(total_depreciation_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_finance_inventory_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance Inventory Valuation business metrics"
  source: "`vibe_automotive_v1`.`finance`.`finance_inventory_valuation`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Finance Inventory Valuation"
      expr: COUNT(DISTINCT finance_inventory_valuation_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_finance_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance Project business metrics"
  source: "`vibe_automotive_v1`.`finance`.`finance_project`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Comments"
      expr: audit_comments
    - name: "Audit Status"
      expr: audit_status
    - name: "Capital Expenditure Flag"
      expr: capital_expenditure_flag
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "External Project Number"
      expr: external_project_number
    - name: "Funding Source"
      expr: funding_source
    - name: "Location"
      expr: location
    - name: "Operational Expenditure Flag"
      expr: operational_expenditure_flag
    - name: "Phase"
      expr: phase
    - name: "Phase End Date"
      expr: phase_end_date
    - name: "Phase Start Date"
      expr: phase_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Finance Project"
      expr: COUNT(DISTINCT finance_project_id)
    - name: "Total Actual Spend"
      expr: SUM(actual_spend)
    - name: "Average Actual Spend"
      expr: AVG(actual_spend)
    - name: "Total Approved By"
      expr: SUM(approved_by)
    - name: "Average Approved By"
      expr: AVG(approved_by)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Expected Roi Percent"
      expr: SUM(expected_roi_percent)
    - name: "Average Expected Roi Percent"
      expr: AVG(expected_roi_percent)
    - name: "Total Forecasted Total Cost"
      expr: SUM(forecasted_total_cost)
    - name: "Average Forecasted Total Cost"
      expr: AVG(forecasted_total_cost)
    - name: "Total Revised Budget Amount"
      expr: SUM(revised_budget_amount)
    - name: "Average Revised Budget Amount"
      expr: AVG(revised_budget_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
    - name: "Total Variance Percent"
      expr: SUM(variance_percent)
    - name: "Average Variance Percent"
      expr: AVG(variance_percent)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_financial_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial Period Close business metrics"
  source: "`vibe_automotive_v1`.`finance`.`financial_period_close`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Approver Name"
      expr: approver_name
    - name: "Blocking Issue Description"
      expr: blocking_issue_description
    - name: "Close Event Timestamp"
      expr: close_event_timestamp
    - name: "Close Task Number"
      expr: close_task_number
    - name: "Close Task Type"
      expr: close_task_type
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Financial Period Close Status"
      expr: financial_period_close_status
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Audit Evidence"
      expr: is_audit_evidence
    - name: "Lock Flag"
      expr: lock_flag
    - name: "Notes"
      expr: notes
    - name: "Planned Completion Date"
      expr: planned_completion_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Financial Period Close"
      expr: COUNT(DISTINCT financial_period_close_id)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_fiscal_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fiscal Period business metrics"
  source: "`vibe_automotive_v1`.`finance`.`fiscal_period`"
  dimensions:
    - name: "Accrual Cutoff Date"
      expr: accrual_cutoff_date
    - name: "Company Code"
      expr: company_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fiscal Period Description"
      expr: fiscal_period_description
    - name: "Fiscal Period Status"
      expr: fiscal_period_status
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Fiscal Year Variant"
      expr: fiscal_year_variant
    - name: "Is Current Period"
      expr: is_current_period
    - name: "Is Interim"
      expr: is_interim
    - name: "Lock Date"
      expr: lock_date
    - name: "Period End Date"
      expr: period_end_date
    - name: "Period Name"
      expr: period_name
    - name: "Period Number"
      expr: period_number
    - name: "Period Start Date"
      expr: period_start_date
    - name: "Period Type"
      expr: period_type
    - name: "Posting Deadline Date"
      expr: posting_deadline_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fiscal Period"
      expr: COUNT(DISTINCT fiscal_period_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed Asset business metrics"
  source: "`vibe_automotive_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Asset Class"
      expr: asset_class
    - name: "Asset Condition"
      expr: asset_condition
    - name: "Asset Description"
      expr: asset_description
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Asset Type"
      expr: asset_type
    - name: "Capitalized Flag"
      expr: capitalized_flag
    - name: "Condition Rating"
      expr: condition_rating
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Disposal Method"
      expr: disposal_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fixed Asset"
      expr: COUNT(DISTINCT fixed_asset_id)
    - name: "Total Accumulated Depreciation"
      expr: SUM(accumulated_depreciation)
    - name: "Average Accumulated Depreciation"
      expr: AVG(accumulated_depreciation)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Depreciation Rate Percent"
      expr: SUM(depreciation_rate_percent)
    - name: "Average Depreciation Rate Percent"
      expr: AVG(depreciation_rate_percent)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Net Book Value"
      expr: SUM(net_book_value)
    - name: "Average Net Book Value"
      expr: AVG(net_book_value)
    - name: "Total Tax Depreciation Amount"
      expr: SUM(tax_depreciation_amount)
    - name: "Average Tax Depreciation Amount"
      expr: AVG(tax_depreciation_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gl Account business metrics"
  source: "`vibe_automotive_v1`.`finance`.`gl_account`"
  dimensions:
    - name: "Account Code"
      expr: account_code
    - name: "Account Group"
      expr: account_group
    - name: "Account Name"
      expr: account_name
    - name: "Account Type"
      expr: account_type
    - name: "Balance Type"
      expr: balance_type
    - name: "Chart Of Accounts Version"
      expr: chart_of_accounts_version
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Gl Account Description"
      expr: gl_account_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Status"
      expr: gl_account_status
    - name: "Is Budgeted"
      expr: is_budgeted
    - name: "Is Consolidation Account"
      expr: is_consolidation_account
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gl Account"
      expr: COUNT(DISTINCT gl_account_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Closing Balance"
      expr: SUM(closing_balance)
    - name: "Average Closing Balance"
      expr: AVG(closing_balance)
    - name: "Total Opening Balance"
      expr: SUM(opening_balance)
    - name: "Average Opening Balance"
      expr: AVG(opening_balance)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_intercompany_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany Group business metrics"
  source: "`vibe_automotive_v1`.`finance`.`intercompany_group`"
  dimensions:
    - name: "Consolidation Method"
      expr: consolidation_method
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Intercompany Group Description"
      expr: intercompany_group_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "External Reference Number"
      expr: external_reference_number
    - name: "Group Code"
      expr: group_code
    - name: "Group Name"
      expr: group_name
    - name: "Group Type"
      expr: group_type
    - name: "Intercompany Accounting Rule"
      expr: intercompany_accounting_rule
    - name: "Is Cross Border"
      expr: is_cross_border
    - name: "Is Taxable"
      expr: is_taxable
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Intercompany Group"
      expr: COUNT(DISTINCT intercompany_group_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_intercompany_loan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany Loan business metrics"
  source: "`vibe_automotive_v1`.`finance`.`intercompany_loan`"
  dimensions:
    - name: "Accounting Code"
      expr: accounting_code
    - name: "Amortization Method"
      expr: amortization_method
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Collateral Type"
      expr: collateral_type
    - name: "Covenant Details"
      expr: covenant_details
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Default Date"
      expr: default_date
    - name: "Default Flag"
      expr: default_flag
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Guarantee Type"
      expr: guarantee_type
    - name: "Interest Accrual Method"
      expr: interest_accrual_method
    - name: "Interest Rate Type"
      expr: interest_rate_type
    - name: "Internal Audit Status"
      expr: internal_audit_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Intercompany Loan"
      expr: COUNT(DISTINCT intercompany_loan_id)
    - name: "Total Accrued Interest"
      expr: SUM(accrued_interest)
    - name: "Average Accrued Interest"
      expr: AVG(accrued_interest)
    - name: "Total Collateral Value"
      expr: SUM(collateral_value)
    - name: "Average Collateral Value"
      expr: AVG(collateral_value)
    - name: "Total Early Termination Fee"
      expr: SUM(early_termination_fee)
    - name: "Average Early Termination Fee"
      expr: AVG(early_termination_fee)
    - name: "Total Exchange Rate At Inception"
      expr: SUM(exchange_rate_at_inception)
    - name: "Average Exchange Rate At Inception"
      expr: AVG(exchange_rate_at_inception)
    - name: "Total Interest Cap"
      expr: SUM(interest_cap)
    - name: "Average Interest Cap"
      expr: AVG(interest_cap)
    - name: "Total Interest Rate"
      expr: SUM(interest_rate)
    - name: "Average Interest Rate"
      expr: AVG(interest_rate)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Principal Amount"
      expr: SUM(principal_amount)
    - name: "Average Principal Amount"
      expr: AVG(principal_amount)
    - name: "Total Principal Outstanding"
      expr: SUM(principal_outstanding)
    - name: "Average Principal Outstanding"
      expr: AVG(principal_outstanding)
    - name: "Total Total Outstanding"
      expr: SUM(total_outstanding)
    - name: "Average Total Outstanding"
      expr: AVG(total_outstanding)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_intercompany_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany Settlement business metrics"
  source: "`vibe_automotive_v1`.`finance`.`intercompany_settlement`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Clearing Document Number"
      expr: clearing_document_number
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Intercompany Settlement Description"
      expr: intercompany_settlement_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Intercompany Settlement Status"
      expr: intercompany_settlement_status
    - name: "Is Approved"
      expr: is_approved
    - name: "Netting Indicator"
      expr: netting_indicator
    - name: "Posting Date"
      expr: posting_date
    - name: "Receiving Company Code"
      expr: receiving_company_code
    - name: "Reconciliation Status"
      expr: reconciliation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Intercompany Settlement"
      expr: COUNT(DISTINCT intercompany_settlement_id)
    - name: "Total Amount Gross"
      expr: SUM(amount_gross)
    - name: "Average Amount Gross"
      expr: AVG(amount_gross)
    - name: "Total Amount Net"
      expr: SUM(amount_net)
    - name: "Average Amount Net"
      expr: AVG(amount_net)
    - name: "Total Amount Tax"
      expr: SUM(amount_tax)
    - name: "Average Amount Tax"
      expr: AVG(amount_tax)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry business metrics"
  source: "`vibe_automotive_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Debit Credit Indicator"
      expr: debit_credit_indicator
    - name: "Document Date"
      expr: document_date
    - name: "Document Language"
      expr: document_language
    - name: "Document Number"
      expr: document_number
    - name: "Document Type"
      expr: document_type
    - name: "Exchange Rate Type"
      expr: exchange_rate_type
    - name: "Intercompany Indicator"
      expr: intercompany_indicator
    - name: "Is Adjustment"
      expr: is_adjustment
    - name: "Is Consolidated"
      expr: is_consolidated
    - name: "Is Manual Entry"
      expr: is_manual_entry
    - name: "Is Test Entry"
      expr: is_test_entry
    - name: "Journal Entry Status"
      expr: journal_entry_status
    - name: "Ledger Group"
      expr: ledger_group
    - name: "Line Item Count"
      expr: line_item_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry"
      expr: COUNT(DISTINCT journal_entry_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry Line business metrics"
  source: "`vibe_automotive_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "Account Type"
      expr: account_type
    - name: "Assignment"
      expr: assignment
    - name: "Business Area"
      expr: business_area
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Cc"
      expr: currency_cc
    - name: "Currency Tc"
      expr: currency_tc
    - name: "Debit Credit Indicator"
      expr: debit_credit_indicator
    - name: "Document Date"
      expr: document_date
    - name: "Exchange Rate Type"
      expr: exchange_rate_type
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Line Text"
      expr: line_text
    - name: "Plant"
      expr: plant
    - name: "Posting Date"
      expr: posting_date
    - name: "Posting Key"
      expr: posting_key
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry Line"
      expr: COUNT(DISTINCT journal_entry_line_id)
    - name: "Total Amount Cc"
      expr: SUM(amount_cc)
    - name: "Average Amount Cc"
      expr: AVG(amount_cc)
    - name: "Total Amount Tc"
      expr: SUM(amount_tc)
    - name: "Average Amount Tc"
      expr: AVG(amount_tc)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Entity business metrics"
  source: "`vibe_automotive_v1`.`finance`.`legal_entity`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Country Of Incorporation"
      expr: country_of_incorporation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Privacy Classification"
      expr: data_privacy_classification
    - name: "Legal Entity Description"
      expr: legal_entity_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "Entity Type"
      expr: entity_type
    - name: "Fiscal Year End Month"
      expr: fiscal_year_end_month
    - name: "Industry Code"
      expr: industry_code
    - name: "Is Public Company"
      expr: is_public_company
    - name: "Legal Name"
      expr: legal_name
    - name: "Number Of Employees"
      expr: number_of_employees
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Entity"
      expr: COUNT(DISTINCT legal_entity_id)
    - name: "Total Market Capitalization"
      expr: SUM(market_capitalization)
    - name: "Average Market Capitalization"
      expr: AVG(market_capitalization)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_manufacturing_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing Cost business metrics"
  source: "`vibe_automotive_v1`.`finance`.`manufacturing_cost`"
  dimensions:
    - name: "Cost Calculation Timestamp"
      expr: cost_calculation_timestamp
    - name: "Cost Record Number"
      expr: cost_record_number
    - name: "Costing Date"
      expr: costing_date
    - name: "Costing Version"
      expr: costing_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Variance Exceed Threshold"
      expr: is_variance_exceed_threshold
    - name: "Manufacturing Cost Status"
      expr: manufacturing_cost_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vehicle Line"
      expr: vehicle_line
    - name: "Vehicle Model Code"
      expr: vehicle_model_code
    - name: "Vehicle Model Year"
      expr: vehicle_model_year
    - name: "Cost Calculation Timestamp Month"
      expr: DATE_TRUNC('MONTH', cost_calculation_timestamp)
    - name: "Costing Date Month"
      expr: DATE_TRUNC('MONTH', costing_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Manufacturing Cost"
      expr: COUNT(DISTINCT manufacturing_cost_id)
    - name: "Total Actual Energy Cost"
      expr: SUM(actual_energy_cost)
    - name: "Average Actual Energy Cost"
      expr: AVG(actual_energy_cost)
    - name: "Total Actual Fixed Overhead Cost"
      expr: SUM(actual_fixed_overhead_cost)
    - name: "Average Actual Fixed Overhead Cost"
      expr: AVG(actual_fixed_overhead_cost)
    - name: "Total Actual Labor Cost"
      expr: SUM(actual_labor_cost)
    - name: "Average Actual Labor Cost"
      expr: AVG(actual_labor_cost)
    - name: "Total Actual Material Cost"
      expr: SUM(actual_material_cost)
    - name: "Average Actual Material Cost"
      expr: AVG(actual_material_cost)
    - name: "Total Actual Scrap Cost"
      expr: SUM(actual_scrap_cost)
    - name: "Average Actual Scrap Cost"
      expr: AVG(actual_scrap_cost)
    - name: "Total Actual Tooling Amortization Cost"
      expr: SUM(actual_tooling_amortization_cost)
    - name: "Average Actual Tooling Amortization Cost"
      expr: AVG(actual_tooling_amortization_cost)
    - name: "Total Actual Variable Overhead Cost"
      expr: SUM(actual_variable_overhead_cost)
    - name: "Average Actual Variable Overhead Cost"
      expr: AVG(actual_variable_overhead_cost)
    - name: "Total Cost Variance Amount"
      expr: SUM(cost_variance_amount)
    - name: "Average Cost Variance Amount"
      expr: AVG(cost_variance_amount)
    - name: "Total Cost Variance Percent"
      expr: SUM(cost_variance_percent)
    - name: "Average Cost Variance Percent"
      expr: AVG(cost_variance_percent)
    - name: "Total Standard Energy Cost"
      expr: SUM(standard_energy_cost)
    - name: "Average Standard Energy Cost"
      expr: AVG(standard_energy_cost)
    - name: "Total Standard Fixed Overhead Cost"
      expr: SUM(standard_fixed_overhead_cost)
    - name: "Average Standard Fixed Overhead Cost"
      expr: AVG(standard_fixed_overhead_cost)
    - name: "Total Standard Labor Cost"
      expr: SUM(standard_labor_cost)
    - name: "Average Standard Labor Cost"
      expr: AVG(standard_labor_cost)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_payment_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Settlement business metrics"
  source: "`vibe_automotive_v1`.`finance`.`payment_settlement`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Counterparty Type"
      expr: counterparty_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Payment Settlement Description"
      expr: payment_settlement_description
    - name: "Is Cross Border"
      expr: is_cross_border
    - name: "Is Manual Settlement"
      expr: is_manual_settlement
    - name: "Original Currency Code"
      expr: original_currency_code
    - name: "Payment Reference"
      expr: payment_reference
    - name: "Project Code"
      expr: project_code
    - name: "Reconciliation Date"
      expr: reconciliation_date
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Settlement Approval Timestamp"
      expr: settlement_approval_timestamp
    - name: "Settlement Approved By"
      expr: settlement_approved_by
    - name: "Settlement Batch Sequence"
      expr: settlement_batch_sequence
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Settlement"
      expr: COUNT(DISTINCT payment_settlement_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit Center business metrics"
  source: "`vibe_automotive_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Profit Center Category"
      expr: profit_center_category
    - name: "Closure Date"
      expr: closure_date
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Company Code"
      expr: company_code
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Profit Center Description"
      expr: profit_center_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "External Reference"
      expr: external_reference
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Is Consolidated"
      expr: is_consolidated
    - name: "Is Intercompany"
      expr: is_intercompany
    - name: "Last Review Date"
      expr: last_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Profit Center"
      expr: COUNT(DISTINCT profit_center_id)
    - name: "Total Actual Amount"
      expr: SUM(actual_amount)
    - name: "Average Actual Amount"
      expr: AVG(actual_amount)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Ebitda Amount"
      expr: SUM(ebitda_amount)
    - name: "Average Ebitda Amount"
      expr: AVG(ebitda_amount)
    - name: "Total Margin Percent"
      expr: SUM(margin_percent)
    - name: "Average Margin Percent"
      expr: AVG(margin_percent)
    - name: "Total Plan Amount"
      expr: SUM(plan_amount)
    - name: "Average Plan Amount"
      expr: AVG(plan_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax Posting business metrics"
  source: "`vibe_automotive_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Tax Posting Description"
      expr: tax_posting_description
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Posting Date"
      expr: posting_date
    - name: "Source Document Number"
      expr: source_document_number
    - name: "Source Document Type"
      expr: source_document_type
    - name: "Tax Code"
      expr: tax_code
    - name: "Tax Exempt Flag"
      expr: tax_exempt_flag
    - name: "Tax Jurisdiction"
      expr: tax_jurisdiction
    - name: "Tax Posting Status"
      expr: tax_posting_status
    - name: "Tax Rate Type"
      expr: tax_rate_type
    - name: "Tax Reporting Period"
      expr: tax_reporting_period
    - name: "Tax Return Reference"
      expr: tax_return_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tax Posting"
      expr: COUNT(DISTINCT tax_posting_id)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Base Amount"
      expr: SUM(tax_base_amount)
    - name: "Average Tax Base Amount"
      expr: AVG(tax_base_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_vehicle_profitability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle Profitability business metrics"
  source: "`vibe_automotive_v1`.`finance`.`vehicle_profitability`"
  dimensions:
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Emission Rating"
      expr: emission_rating
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Is Eligible For Subsidy"
      expr: is_eligible_for_subsidy
    - name: "Market Region"
      expr: market_region
    - name: "Model Year"
      expr: model_year
    - name: "Plant Code"
      expr: plant_code
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Sales Channel"
      expr: sales_channel
    - name: "Transaction Date"
      expr: transaction_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vehicle Category"
      expr: vehicle_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vehicle Profitability"
      expr: COUNT(DISTINCT vehicle_profitability_id)
    - name: "Total Actual Manufacturing Cost"
      expr: SUM(actual_manufacturing_cost)
    - name: "Average Actual Manufacturing Cost"
      expr: AVG(actual_manufacturing_cost)
    - name: "Total Ebitda Contribution"
      expr: SUM(ebitda_contribution)
    - name: "Average Ebitda Contribution"
      expr: AVG(ebitda_contribution)
    - name: "Total Gross Margin"
      expr: SUM(gross_margin)
    - name: "Average Gross Margin"
      expr: AVG(gross_margin)
    - name: "Total Gross Revenue Msrp"
      expr: SUM(gross_revenue_msrp)
    - name: "Average Gross Revenue Msrp"
      expr: AVG(gross_revenue_msrp)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
    - name: "Total Net Contribution Margin"
      expr: SUM(net_contribution_margin)
    - name: "Average Net Contribution Margin"
      expr: AVG(net_contribution_margin)
    - name: "Total Net Revenue"
      expr: SUM(net_revenue)
    - name: "Average Net Revenue"
      expr: AVG(net_revenue)
    - name: "Total Selling Distribution Cost"
      expr: SUM(selling_distribution_cost)
    - name: "Average Selling Distribution Cost"
      expr: AVG(selling_distribution_cost)
    - name: "Total Standard Manufacturing Cost"
      expr: SUM(standard_manufacturing_cost)
    - name: "Average Standard Manufacturing Cost"
      expr: AVG(standard_manufacturing_cost)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Vehicle Weight Kg"
      expr: SUM(vehicle_weight_kg)
    - name: "Average Vehicle Weight Kg"
      expr: AVG(vehicle_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_warranty_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty Reserve business metrics"
  source: "`vibe_automotive_v1`.`finance`.`warranty_reserve`"
  dimensions:
    - name: "Accounting Period"
      expr: accounting_period
    - name: "Accrual Basis"
      expr: accrual_basis
    - name: "Actuarial Review Date"
      expr: actuarial_review_date
    - name: "Audit Trail Notes"
      expr: audit_trail_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Ifrs Compliant"
      expr: is_ifrs_compliant
    - name: "Is Sox Controlled"
      expr: is_sox_controlled
    - name: "Last Actuarial Update Timestamp"
      expr: last_actuarial_update_timestamp
    - name: "Market Region"
      expr: market_region
    - name: "Model Year"
      expr: model_year
    - name: "Regulatory Reporting Flag"
      expr: regulatory_reporting_flag
    - name: "Reserve Description"
      expr: reserve_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Warranty Reserve"
      expr: COUNT(DISTINCT warranty_reserve_id)
    - name: "Total Claims Charged"
      expr: SUM(claims_charged)
    - name: "Average Claims Charged"
      expr: AVG(claims_charged)
    - name: "Total Estimated Cost Per Unit"
      expr: SUM(estimated_cost_per_unit)
    - name: "Average Estimated Cost Per Unit"
      expr: AVG(estimated_cost_per_unit)
    - name: "Total Reserve Adequacy Ratio"
      expr: SUM(reserve_adequacy_ratio)
    - name: "Average Reserve Adequacy Ratio"
      expr: AVG(reserve_adequacy_ratio)
    - name: "Total Reserve Amount"
      expr: SUM(reserve_amount)
    - name: "Average Reserve Amount"
      expr: AVG(reserve_amount)
    - name: "Total Reserve Balance"
      expr: SUM(reserve_balance)
    - name: "Average Reserve Balance"
      expr: AVG(reserve_balance)
    - name: "Total Units Sold"
      expr: SUM(units_sold)
    - name: "Average Units Sold"
      expr: AVG(units_sold)
    - name: "Total Warranty Claims Amount"
      expr: SUM(warranty_claims_amount)
    - name: "Average Warranty Claims Amount"
      expr: AVG(warranty_claims_amount)
    - name: "Total Warranty Claims Count"
      expr: SUM(warranty_claims_count)
    - name: "Average Warranty Claims Count"
      expr: AVG(warranty_claims_count)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wbs Element business metrics"
  source: "`vibe_automotive_v1`.`finance`.`wbs_element`"
  dimensions:
    - name: "Accounting Status"
      expr: accounting_status
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "External Reference"
      expr: external_reference
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Investment Program Code"
      expr: investment_program_code
    - name: "Is Capex"
      expr: is_capex
    - name: "Is R And D"
      expr: is_r_and_d
    - name: "Milestone Flag"
      expr: milestone_flag
    - name: "Notes"
      expr: notes
    - name: "Plant Location"
      expr: plant_location
    - name: "Project Phase"
      expr: project_phase
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wbs Element"
      expr: COUNT(DISTINCT wbs_element_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Committed Cost"
      expr: SUM(committed_cost)
    - name: "Average Committed Cost"
      expr: AVG(committed_cost)
    - name: "Total Planned Cost"
      expr: SUM(planned_cost)
    - name: "Average Planned Cost"
      expr: AVG(planned_cost)
$$;