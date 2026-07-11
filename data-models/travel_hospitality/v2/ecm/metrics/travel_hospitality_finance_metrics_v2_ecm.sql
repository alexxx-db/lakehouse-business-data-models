-- Metric views for domain: finance | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:27:42

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_allocation_rule_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation Rule Set business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set`"
  dimensions:
    - name: "Allocation Basis"
      expr: allocation_basis
    - name: "Allocation Frequency"
      expr: allocation_frequency
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Workflow Code"
      expr: approval_workflow_code
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audit Trail Required"
      expr: audit_trail_required
    - name: "Business Justification"
      expr: business_justification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Filter"
      expr: department_filter
    - name: "Allocation Rule Set Description"
      expr: allocation_rule_set_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Gl Account Filter"
      expr: gl_account_filter
    - name: "Is Automated"
      expr: is_automated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Allocation Rule Set"
      expr: COUNT(DISTINCT allocation_rule_set_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Maximum Threshold Amount"
      expr: SUM(maximum_threshold_amount)
    - name: "Average Maximum Threshold Amount"
      expr: AVG(maximum_threshold_amount)
    - name: "Total Minimum Threshold Amount"
      expr: SUM(minimum_threshold_amount)
    - name: "Average Minimum Threshold Amount"
      expr: AVG(minimum_threshold_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_allocation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation Run business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`allocation_run`"
  dimensions:
    - name: "Accounting Period"
      expr: accounting_period
    - name: "Actual Execution Timestamp"
      expr: actual_execution_timestamp
    - name: "Allocation Basis"
      expr: allocation_basis
    - name: "Allocation Line Count"
      expr: allocation_line_count
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Error Message"
      expr: error_message
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Gl Posting Status"
      expr: gl_posting_status
    - name: "Is Automated"
      expr: is_automated
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Reconciliation Status"
      expr: reconciliation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Allocation Run"
      expr: COUNT(DISTINCT allocation_run_id)
    - name: "Total Total Amount Allocated"
      expr: SUM(total_amount_allocated)
    - name: "Average Total Amount Allocated"
      expr: AVG(total_amount_allocated)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ap Invoice business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Ap Invoice Description"
      expr: ap_invoice_description
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Due Date"
      expr: due_date
    - name: "Expense Category"
      expr: expense_category
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Invoice Type"
      expr: invoice_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ap Invoice"
      expr: COUNT(DISTINCT ap_invoice_id)
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
    - name: "Total Outstanding Amount"
      expr: SUM(outstanding_amount)
    - name: "Average Outstanding Amount"
      expr: AVG(outstanding_amount)
    - name: "Total Paid Amount"
      expr: SUM(paid_amount)
    - name: "Average Paid Amount"
      expr: AVG(paid_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ap Payment business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Base Currency Code"
      expr: base_currency_code
    - name: "Check Number"
      expr: check_number
    - name: "Clearing Date"
      expr: clearing_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Currency Code"
      expr: payment_currency_code
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Description"
      expr: payment_description
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ap Payment"
      expr: COUNT(DISTINCT ap_payment_id)
    - name: "Total Bank Fee Amount"
      expr: SUM(bank_fee_amount)
    - name: "Average Bank Fee Amount"
      expr: AVG(bank_fee_amount)
    - name: "Total Base Currency Amount"
      expr: SUM(base_currency_amount)
    - name: "Average Base Currency Amount"
      expr: AVG(base_currency_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Net Payment Amount"
      expr: SUM(net_payment_amount)
    - name: "Average Net Payment Amount"
      expr: AVG(net_payment_amount)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ar Invoice business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "Aging Bucket"
      expr: aging_bucket
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Contact Email"
      expr: billing_contact_email
    - name: "Billing Contact Phone"
      expr: billing_contact_phone
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Entity Name"
      expr: billing_entity_name
    - name: "Billing Entity Type"
      expr: billing_entity_type
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Collection Status"
      expr: collection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Outstanding"
      expr: days_outstanding
    - name: "Dispute Flag"
      expr: dispute_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ar Invoice"
      expr: COUNT(DISTINCT ar_invoice_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Ancillary Revenue Amount"
      expr: SUM(ancillary_revenue_amount)
    - name: "Average Ancillary Revenue Amount"
      expr: AVG(ancillary_revenue_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Event Revenue Amount"
      expr: SUM(event_revenue_amount)
    - name: "Average Event Revenue Amount"
      expr: AVG(event_revenue_amount)
    - name: "Total Fnb Revenue Amount"
      expr: SUM(fnb_revenue_amount)
    - name: "Average Fnb Revenue Amount"
      expr: AVG(fnb_revenue_amount)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Paid Amount"
      expr: SUM(paid_amount)
    - name: "Average Paid Amount"
      expr: AVG(paid_amount)
    - name: "Total Room Revenue Amount"
      expr: SUM(room_revenue_amount)
    - name: "Average Room Revenue Amount"
      expr: AVG(room_revenue_amount)
    - name: "Total Service Charge Amount"
      expr: SUM(service_charge_amount)
    - name: "Average Service Charge Amount"
      expr: AVG(service_charge_amount)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ar Payment business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Bank Name"
      expr: bank_name
    - name: "Base Currency Code"
      expr: base_currency_code
    - name: "Card Last Four"
      expr: card_last_four
    - name: "Card Type"
      expr: card_type
    - name: "Cardholder Name"
      expr: cardholder_name
    - name: "Check Number"
      expr: check_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deposit Date"
      expr: deposit_date
    - name: "Is Advance Deposit"
      expr: is_advance_deposit
    - name: "Is Refund"
      expr: is_refund
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Channel"
      expr: payment_channel
    - name: "Payment Currency Code"
      expr: payment_currency_code
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ar Payment"
      expr: COUNT(DISTINCT ar_payment_id)
    - name: "Total Applied Amount"
      expr: SUM(applied_amount)
    - name: "Average Applied Amount"
      expr: AVG(applied_amount)
    - name: "Total Base Currency Amount"
      expr: SUM(base_currency_amount)
    - name: "Average Base Currency Amount"
      expr: AVG(base_currency_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Net Payment Amount"
      expr: SUM(net_payment_amount)
    - name: "Average Net Payment Amount"
      expr: AVG(net_payment_amount)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Shift Code"
      expr: SUM(shift_code)
    - name: "Average Shift Code"
      expr: AVG(shift_code)
    - name: "Total Transaction Fee"
      expr: SUM(transaction_fee)
    - name: "Average Transaction Fee"
      expr: AVG(transaction_fee)
    - name: "Total Unapplied Amount"
      expr: SUM(unapplied_amount)
    - name: "Average Unapplied Amount"
      expr: AVG(unapplied_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank Account business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "Account Closed Date"
      expr: account_closed_date
    - name: "Account Name"
      expr: account_name
    - name: "Account Number"
      expr: account_number
    - name: "Account Number Masked"
      expr: account_number_masked
    - name: "Account Opened Date"
      expr: account_opened_date
    - name: "Account Purpose"
      expr: account_purpose
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Ach Enabled"
      expr: ach_enabled
    - name: "Bank Branch Name"
      expr: bank_branch_name
    - name: "Bank Code"
      expr: bank_code
    - name: "Bank Contact Email"
      expr: bank_contact_email
    - name: "Bank Contact Name"
      expr: bank_contact_name
    - name: "Bank Contact Phone"
      expr: bank_contact_phone
    - name: "Bank Name"
      expr: bank_name
    - name: "Company Code"
      expr: company_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bank Account"
      expr: COUNT(DISTINCT bank_account_id)
    - name: "Total Available Balance"
      expr: SUM(available_balance)
    - name: "Average Available Balance"
      expr: AVG(available_balance)
    - name: "Total Current Balance"
      expr: SUM(current_balance)
    - name: "Average Current Balance"
      expr: AVG(current_balance)
    - name: "Total Interest Rate"
      expr: SUM(interest_rate)
    - name: "Average Interest Rate"
      expr: AVG(interest_rate)
    - name: "Total Last Statement Balance"
      expr: SUM(last_statement_balance)
    - name: "Average Last Statement Balance"
      expr: AVG(last_statement_balance)
    - name: "Total Minimum Balance Required"
      expr: SUM(minimum_balance_required)
    - name: "Average Minimum Balance Required"
      expr: AVG(minimum_balance_required)
    - name: "Total Opening Balance"
      expr: SUM(opening_balance)
    - name: "Average Opening Balance"
      expr: AVG(opening_balance)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Budget Number"
      expr: budget_number
    - name: "Budget Status"
      expr: budget_status
    - name: "Budget Type"
      expr: budget_type
    - name: "Budgeted Available Rooms"
      expr: budgeted_available_rooms
    - name: "Budgeted Covers"
      expr: budgeted_covers
    - name: "Budgeted Room Nights"
      expr: budgeted_room_nights
    - name: "Budget Category"
      expr: budget_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget"
      expr: COUNT(DISTINCT budget_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Budgeted Adr"
      expr: SUM(budgeted_adr)
    - name: "Average Budgeted Adr"
      expr: AVG(budgeted_adr)
    - name: "Total Budgeted Cpor"
      expr: SUM(budgeted_cpor)
    - name: "Average Budgeted Cpor"
      expr: AVG(budgeted_cpor)
    - name: "Total Budgeted Ebitda"
      expr: SUM(budgeted_ebitda)
    - name: "Average Budgeted Ebitda"
      expr: AVG(budgeted_ebitda)
    - name: "Total Budgeted Events Revenue"
      expr: SUM(budgeted_events_revenue)
    - name: "Average Budgeted Events Revenue"
      expr: AVG(budgeted_events_revenue)
    - name: "Total Budgeted Fnb Revenue"
      expr: SUM(budgeted_fnb_revenue)
    - name: "Average Budgeted Fnb Revenue"
      expr: AVG(budgeted_fnb_revenue)
    - name: "Total Budgeted Gop"
      expr: SUM(budgeted_gop)
    - name: "Average Budgeted Gop"
      expr: AVG(budgeted_gop)
    - name: "Total Budgeted Goppar"
      expr: SUM(budgeted_goppar)
    - name: "Average Budgeted Goppar"
      expr: AVG(budgeted_goppar)
    - name: "Total Budgeted Labor Expense"
      expr: SUM(budgeted_labor_expense)
    - name: "Average Budgeted Labor Expense"
      expr: AVG(budgeted_labor_expense)
    - name: "Total Budgeted Noi"
      expr: SUM(budgeted_noi)
    - name: "Average Budgeted Noi"
      expr: AVG(budgeted_noi)
    - name: "Total Budgeted Occupancy Rate"
      expr: SUM(budgeted_occupancy_rate)
    - name: "Average Budgeted Occupancy Rate"
      expr: AVG(budgeted_occupancy_rate)
    - name: "Total Budgeted Operating Expense"
      expr: SUM(budgeted_operating_expense)
    - name: "Average Budgeted Operating Expense"
      expr: AVG(budgeted_operating_expense)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Line business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "Allocation Driver"
      expr: allocation_driver
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Budget Category"
      expr: budget_category
    - name: "Budget Owner"
      expr: budget_owner
    - name: "Budget Type"
      expr: budget_type
    - name: "Budget Version"
      expr: budget_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Line"
      expr: COUNT(DISTINCT budget_line_id)
    - name: "Total Planned Amount"
      expr: SUM(planned_amount)
    - name: "Average Planned Amount"
      expr: AVG(planned_amount)
    - name: "Total Prior Year Actual Amount"
      expr: SUM(prior_year_actual_amount)
    - name: "Average Prior Year Actual Amount"
      expr: AVG(prior_year_actual_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Variance Threshold Percent"
      expr: SUM(variance_threshold_percent)
    - name: "Average Variance Threshold Percent"
      expr: AVG(variance_threshold_percent)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capex Request business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Approval Authority Level"
      expr: approval_authority_level
    - name: "Approval Date"
      expr: approval_date
    - name: "Approver Name"
      expr: approver_name
    - name: "Asset Category"
      expr: asset_category
    - name: "Budget Year"
      expr: budget_year
    - name: "Business Justification"
      expr: business_justification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Environmental Impact Assessment"
      expr: environmental_impact_assessment
    - name: "Expected Useful Life Years"
      expr: expected_useful_life_years
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Is Multi Year Project"
      expr: is_multi_year_project
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capex Request"
      expr: COUNT(DISTINCT capex_request_id)
    - name: "Total Approved Amount"
      expr: SUM(approved_amount)
    - name: "Average Approved Amount"
      expr: AVG(approved_amount)
    - name: "Total Requested Amount"
      expr: SUM(requested_amount)
    - name: "Average Requested Amount"
      expr: AVG(requested_amount)
    - name: "Total Roi Percentage"
      expr: SUM(roi_percentage)
    - name: "Average Roi Percentage"
      expr: AVG(roi_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Center business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "Audit Trail Required Flag"
      expr: audit_trail_required_flag
    - name: "Budget Allocation Flag"
      expr: budget_allocation_flag
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Company Code"
      expr: company_code
    - name: "Controlling Area"
      expr: controlling_area
    - name: "Cost Allocation Method"
      expr: cost_allocation_method
    - name: "Cost Center Status"
      expr: cost_center_status
    - name: "Cost Center Type"
      expr: cost_center_type
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Category"
      expr: department_category
    - name: "Cost Center Description"
      expr: cost_center_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reporting Flag"
      expr: external_reporting_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Center"
      expr: COUNT(DISTINCT cost_center_id)
    - name: "Total Annual Budget Amount"
      expr: SUM(annual_budget_amount)
    - name: "Average Annual Budget Amount"
      expr: AVG(annual_budget_amount)
    - name: "Total Square Footage"
      expr: SUM(square_footage)
    - name: "Average Square Footage"
      expr: AVG(square_footage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_fiscal_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fiscal Period business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`fiscal_period`"
  dimensions:
    - name: "Budget Version"
      expr: budget_version
    - name: "Business Days In Period"
      expr: business_days_in_period
    - name: "Calendar Month"
      expr: calendar_month
    - name: "Calendar Quarter"
      expr: calendar_quarter
    - name: "Calendar Year"
      expr: calendar_year
    - name: "Close Date"
      expr: close_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days In Period"
      expr: days_in_period
    - name: "Fiscal Period Description"
      expr: fiscal_period_description
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Month"
      expr: fiscal_month
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Week"
      expr: fiscal_week
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Adjustment Period"
      expr: is_adjustment_period
    - name: "Is Leap Year"
      expr: is_leap_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fiscal Period"
      expr: COUNT(DISTINCT fiscal_period_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed Asset business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Asset Category"
      expr: asset_category
    - name: "Asset Class"
      expr: asset_class
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Number"
      expr: asset_number
    - name: "Asset Status"
      expr: asset_status
    - name: "Capex Approval Status"
      expr: capex_approval_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Disposal Date"
      expr: disposal_date
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Ffe Reserve Eligible"
      expr: ffe_reserve_eligible
    - name: "Impairment Indicator"
      expr: impairment_indicator
    - name: "Insurance Policy Number"
      expr: insurance_policy_number
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
    - name: "Total Disposal Proceeds"
      expr: SUM(disposal_proceeds)
    - name: "Average Disposal Proceeds"
      expr: AVG(disposal_proceeds)
    - name: "Total Gain Loss On Disposal"
      expr: SUM(gain_loss_on_disposal)
    - name: "Average Gain Loss On Disposal"
      expr: AVG(gain_loss_on_disposal)
    - name: "Total Impairment Loss"
      expr: SUM(impairment_loss)
    - name: "Average Impairment Loss"
      expr: AVG(impairment_loss)
    - name: "Total Net Book Value"
      expr: SUM(net_book_value)
    - name: "Average Net Book Value"
      expr: AVG(net_book_value)
    - name: "Total Salvage Value"
      expr: SUM(salvage_value)
    - name: "Average Salvage Value"
      expr: AVG(salvage_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_gl_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gl Batch business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`gl_batch`"
  dimensions:
    - name: "Accounting Period"
      expr: accounting_period
    - name: "Approval Required"
      expr: approval_required
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Batch Name"
      expr: batch_name
    - name: "Batch Number"
      expr: batch_number
    - name: "Batch Status"
      expr: batch_status
    - name: "Batch Type"
      expr: batch_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Gl Batch Description"
      expr: gl_batch_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Entry Count"
      expr: entry_count
    - name: "External Reference"
      expr: external_reference
    - name: "Fiscal Year"
      expr: fiscal_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gl Batch"
      expr: COUNT(DISTINCT gl_batch_id)
    - name: "Total Control Total"
      expr: SUM(control_total)
    - name: "Average Control Total"
      expr: AVG(control_total)
    - name: "Total Total Credit Amount"
      expr: SUM(total_credit_amount)
    - name: "Average Total Credit Amount"
      expr: AVG(total_credit_amount)
    - name: "Total Total Debit Amount"
      expr: SUM(total_debit_amount)
    - name: "Average Total Debit Amount"
      expr: AVG(total_debit_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_hma_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hma Contract business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`hma_contract`"
  dimensions:
    - name: "Accounting Standard"
      expr: accounting_standard
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Assignment Rights Flag"
      expr: assignment_rights_flag
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Budget Approval Authority"
      expr: budget_approval_authority
    - name: "Confidentiality Period Years"
      expr: confidentiality_period_years
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Notes"
      expr: contract_notes
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Classification"
      expr: data_classification
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hma Contract"
      expr: COUNT(DISTINCT hma_contract_id)
    - name: "Total Base Management Fee Percentage"
      expr: SUM(base_management_fee_percentage)
    - name: "Average Base Management Fee Percentage"
      expr: AVG(base_management_fee_percentage)
    - name: "Total Capital Expenditure Reserve Percentage"
      expr: SUM(capital_expenditure_reserve_percentage)
    - name: "Average Capital Expenditure Reserve Percentage"
      expr: AVG(capital_expenditure_reserve_percentage)
    - name: "Total Incentive Fee Percentage"
      expr: SUM(incentive_fee_percentage)
    - name: "Average Incentive Fee Percentage"
      expr: AVG(incentive_fee_percentage)
    - name: "Total Indemnification Cap Amount"
      expr: SUM(indemnification_cap_amount)
    - name: "Average Indemnification Cap Amount"
      expr: AVG(indemnification_cap_amount)
    - name: "Total Minimum Annual Fee Amount"
      expr: SUM(minimum_annual_fee_amount)
    - name: "Average Minimum Annual Fee Amount"
      expr: AVG(minimum_annual_fee_amount)
    - name: "Total Working Capital Amount"
      expr: SUM(working_capital_amount)
    - name: "Average Working Capital Amount"
      expr: AVG(working_capital_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audit Trail Notes"
      expr: audit_trail_notes
    - name: "Capex Indicator"
      expr: capex_indicator
    - name: "Company Code"
      expr: company_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Journal Entry Description"
      expr: journal_entry_description
    - name: "Document Number"
      expr: document_number
    - name: "Document Type"
      expr: document_type
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Functional Currency Code"
      expr: functional_currency_code
    - name: "Intercompany Indicator"
      expr: intercompany_indicator
    - name: "Intercompany Partner Code"
      expr: intercompany_partner_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Posted Timestamp"
      expr: posted_timestamp
    - name: "Posting Date"
      expr: posting_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry"
      expr: COUNT(DISTINCT journal_entry_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Debit Amount"
      expr: SUM(debit_amount)
    - name: "Average Debit Amount"
      expr: AVG(debit_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry Line business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "Asset Number"
      expr: asset_number
    - name: "Assignment Field"
      expr: assignment_field
    - name: "Baseline Payment Date"
      expr: baseline_payment_date
    - name: "Business Area Code"
      expr: business_area_code
    - name: "Capex Indicator"
      expr: capex_indicator
    - name: "Clearing Date"
      expr: clearing_date
    - name: "Clearing Document Number"
      expr: clearing_document_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Code"
      expr: customer_code
    - name: "Debit Credit Indicator"
      expr: debit_credit_indicator
    - name: "Functional Area Code"
      expr: functional_area_code
    - name: "Group Currency Code"
      expr: group_currency_code
    - name: "Line Item Text"
      expr: line_item_text
    - name: "Line Number"
      expr: line_number
    - name: "Local Currency Code"
      expr: local_currency_code
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry Line"
      expr: COUNT(DISTINCT journal_entry_line_id)
    - name: "Total Amount Group Currency"
      expr: SUM(amount_group_currency)
    - name: "Average Amount Group Currency"
      expr: AVG(amount_group_currency)
    - name: "Total Amount Local Currency"
      expr: SUM(amount_local_currency)
    - name: "Average Amount Local Currency"
      expr: AVG(amount_local_currency)
    - name: "Total Amount Transaction Currency"
      expr: SUM(amount_transaction_currency)
    - name: "Average Amount Transaction Currency"
      expr: AVG(amount_transaction_currency)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ledger business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`ledger`"
  dimensions:
    - name: "Account Category"
      expr: account_category
    - name: "Account Name"
      expr: account_name
    - name: "Account Number"
      expr: account_number
    - name: "Account Subcategory"
      expr: account_subcategory
    - name: "Account Type"
      expr: account_type
    - name: "Audit Trail Required"
      expr: audit_trail_required
    - name: "Balance Sheet Section"
      expr: balance_sheet_section
    - name: "Cash Flow Classification"
      expr: cash_flow_classification
    - name: "Consolidation Account"
      expr: consolidation_account
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Ledger Description"
      expr: ledger_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Functional Area"
      expr: functional_area
    - name: "Income Statement Section"
      expr: income_statement_section
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ledger"
      expr: COUNT(DISTINCT ledger_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_management_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Management Fee business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`management_fee`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Calculation Date"
      expr: calculation_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fee Number"
      expr: fee_number
    - name: "Fee Status"
      expr: fee_status
    - name: "Fee Type"
      expr: fee_type
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Intercompany Indicator"
      expr: intercompany_indicator
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Management Fee"
      expr: COUNT(DISTINCT management_fee_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Basis Amount"
      expr: SUM(basis_amount)
    - name: "Average Basis Amount"
      expr: AVG(basis_amount)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Fee Rate Percentage"
      expr: SUM(fee_rate_percentage)
    - name: "Average Fee Rate Percentage"
      expr: AVG(fee_rate_percentage)
    - name: "Total Net Fee Amount"
      expr: SUM(net_fee_amount)
    - name: "Average Net Fee Amount"
      expr: AVG(net_fee_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_owner_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Owner Distribution business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`owner_distribution`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Calculation Date"
      expr: calculation_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Distribution Number"
      expr: distribution_number
    - name: "Distribution Status"
      expr: distribution_status
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Due Date"
      expr: payment_due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Owner Distribution"
      expr: COUNT(DISTINCT owner_distribution_id)
    - name: "Total Base Management Fee Amount"
      expr: SUM(base_management_fee_amount)
    - name: "Average Base Management Fee Amount"
      expr: AVG(base_management_fee_amount)
    - name: "Total Debt Service Amount"
      expr: SUM(debt_service_amount)
    - name: "Average Debt Service Amount"
      expr: AVG(debt_service_amount)
    - name: "Total Distribution Amount"
      expr: SUM(distribution_amount)
    - name: "Average Distribution Amount"
      expr: AVG(distribution_amount)
    - name: "Total Ffe Reserve Balance"
      expr: SUM(ffe_reserve_balance)
    - name: "Average Ffe Reserve Balance"
      expr: AVG(ffe_reserve_balance)
    - name: "Total Ffe Reserve Contribution Amount"
      expr: SUM(ffe_reserve_contribution_amount)
    - name: "Average Ffe Reserve Contribution Amount"
      expr: AVG(ffe_reserve_contribution_amount)
    - name: "Total Gop Amount"
      expr: SUM(gop_amount)
    - name: "Average Gop Amount"
      expr: AVG(gop_amount)
    - name: "Total Gross Revenue Amount"
      expr: SUM(gross_revenue_amount)
    - name: "Average Gross Revenue Amount"
      expr: AVG(gross_revenue_amount)
    - name: "Total Incentive Management Fee Amount"
      expr: SUM(incentive_management_fee_amount)
    - name: "Average Incentive Management Fee Amount"
      expr: AVG(incentive_management_fee_amount)
    - name: "Total Insurance Premium Amount"
      expr: SUM(insurance_premium_amount)
    - name: "Average Insurance Premium Amount"
      expr: AVG(insurance_premium_amount)
    - name: "Total Noi Amount"
      expr: SUM(noi_amount)
    - name: "Average Noi Amount"
      expr: AVG(noi_amount)
    - name: "Total Other Deductions Amount"
      expr: SUM(other_deductions_amount)
    - name: "Average Other Deductions Amount"
      expr: AVG(other_deductions_amount)
    - name: "Total Property Tax Amount"
      expr: SUM(property_tax_amount)
    - name: "Average Property Tax Amount"
      expr: AVG(property_tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Run business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Payment Run Description"
      expr: payment_run_description
    - name: "Error Message"
      expr: error_message
    - name: "Execution Timestamp"
      expr: execution_timestamp
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Failed Payment Count"
      expr: failed_payment_count
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment File Format"
      expr: payment_file_format
    - name: "Payment File Name"
      expr: payment_file_name
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Run"
      expr: COUNT(DISTINCT payment_run_id)
    - name: "Total Failed Amount"
      expr: SUM(failed_amount)
    - name: "Average Failed Amount"
      expr: AVG(failed_amount)
    - name: "Total Net Disbursement Amount"
      expr: SUM(net_disbursement_amount)
    - name: "Average Net Disbursement Amount"
      expr: AVG(net_disbursement_amount)
    - name: "Total Processing Fee Amount"
      expr: SUM(processing_fee_amount)
    - name: "Average Processing Fee Amount"
      expr: AVG(processing_fee_amount)
    - name: "Total Successful Amount"
      expr: SUM(successful_amount)
    - name: "Average Successful Amount"
      expr: AVG(successful_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit Center business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Brand Code"
      expr: brand_code
    - name: "Business Area Code"
      expr: business_area_code
    - name: "City"
      expr: city
    - name: "Closure Date"
      expr: closure_date
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Company Code"
      expr: company_code
    - name: "Controlling Area Code"
      expr: controlling_area_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Profit Center Description"
      expr: profit_center_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Profit Center"
      expr: COUNT(DISTINCT profit_center_id)
    - name: "Total Square Footage"
      expr: SUM(square_footage)
    - name: "Average Square Footage"
      expr: AVG(square_footage)
    - name: "Total Star Rating"
      expr: SUM(star_rating)
    - name: "Average Star Rating"
      expr: AVG(star_rating)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_recurring_entry_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recurring Entry Template business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template`"
  dimensions:
    - name: "Amount Type"
      expr: amount_type
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Approver Role"
      expr: approver_role
    - name: "Auto Post Flag"
      expr: auto_post_flag
    - name: "Business Justification"
      expr: business_justification
    - name: "Calculation Formula"
      expr: calculation_formula
    - name: "Capex Ffe Flag"
      expr: capex_ffe_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Entry Type"
      expr: entry_type
    - name: "Gaap Reference"
      expr: gaap_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recurring Entry Template"
      expr: COUNT(DISTINCT recurring_entry_template_id)
    - name: "Total Fixed Amount"
      expr: SUM(fixed_amount)
    - name: "Average Fixed Amount"
      expr: AVG(fixed_amount)
    - name: "Total Sox Control Code"
      expr: SUM(sox_control_code)
    - name: "Average Sox Control Code"
      expr: AVG(sox_control_code)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax Posting business metrics"
  source: "`vibe_travel_hospitality_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Number"
      expr: document_number
    - name: "Due Date"
      expr: due_date
    - name: "Exemption Certificate Number"
      expr: exemption_certificate_number
    - name: "Exemption Indicator"
      expr: exemption_indicator
    - name: "Filing Date"
      expr: filing_date
    - name: "Filing Status"
      expr: filing_status
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
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
    - name: "Total Tax Rate Percentage"
      expr: SUM(tax_rate_percentage)
    - name: "Average Tax Rate Percentage"
      expr: AVG(tax_rate_percentage)
$$;