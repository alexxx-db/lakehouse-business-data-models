-- Metric views for domain: billing | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:49:32

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing Account business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "Account Name"
      expr: account_name
    - name: "Account Number"
      expr: account_number
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Auto Pay Flag"
      expr: auto_pay_flag
    - name: "Billing Account Status"
      expr: billing_account_status
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country"
      expr: billing_country
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State"
      expr: billing_state
    - name: "Close Date"
      expr: close_date
    - name: "Collection Stage"
      expr: collection_stage
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Billing Account"
      expr: COUNT(DISTINCT billing_account_id)
    - name: "Total Auto Payment Enabled"
      expr: SUM(auto_payment_enabled)
    - name: "Average Auto Payment Enabled"
      expr: AVG(auto_payment_enabled)
    - name: "Total Balance Amount"
      expr: SUM(balance_amount)
    - name: "Average Balance Amount"
      expr: AVG(balance_amount)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Credit Rating"
      expr: SUM(credit_rating)
    - name: "Average Credit Rating"
      expr: AVG(credit_rating)
    - name: "Total Current Ar Balance"
      expr: SUM(current_ar_balance)
    - name: "Average Current Ar Balance"
      expr: AVG(current_ar_balance)
    - name: "Total Payment Due Day Of Month"
      expr: SUM(payment_due_day_of_month)
    - name: "Average Payment Due Day Of Month"
      expr: AVG(payment_due_day_of_month)
    - name: "Total Payment Method"
      expr: SUM(payment_method)
    - name: "Average Payment Method"
      expr: AVG(payment_method)
    - name: "Total Preferred Payment Method"
      expr: SUM(preferred_payment_method)
    - name: "Average Preferred Payment Method"
      expr: AVG(preferred_payment_method)
    - name: "Total Tax Registration Number"
      expr: SUM(tax_registration_number)
    - name: "Average Tax Registration Number"
      expr: AVG(tax_registration_number)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_billing_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing Schedule business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`billing_schedule`"
  dimensions:
    - name: "Actual Billing Date"
      expr: actual_billing_date
    - name: "Billing Currency Code"
      expr: billing_currency_code
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Billing Status"
      expr: billing_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "Installment Count"
      expr: installment_count
    - name: "Is Retention Applicable"
      expr: is_retention_applicable
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Milestone Description"
      expr: milestone_description
    - name: "Milestone Type"
      expr: milestone_type
    - name: "Next Billing Date"
      expr: next_billing_date
    - name: "Notes"
      expr: notes
    - name: "Planned Billing Date"
      expr: planned_billing_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Billing Schedule"
      expr: COUNT(DISTINCT billing_schedule_id)
    - name: "Total Actual Billed Amount"
      expr: SUM(actual_billed_amount)
    - name: "Average Actual Billed Amount"
      expr: AVG(actual_billed_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Percentage Complete Trigger"
      expr: SUM(percentage_complete_trigger)
    - name: "Average Percentage Complete Trigger"
      expr: AVG(percentage_complete_trigger)
    - name: "Total Planned Billing Amount"
      expr: SUM(planned_billing_amount)
    - name: "Average Planned Billing Amount"
      expr: AVG(planned_billing_amount)
    - name: "Total Retention Amount"
      expr: SUM(retention_amount)
    - name: "Average Retention Amount"
      expr: AVG(retention_amount)
    - name: "Total Scheduled Amount"
      expr: SUM(scheduled_amount)
    - name: "Average Scheduled Amount"
      expr: AVG(scheduled_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_collections`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`collections`"
  dimensions:
    - name: "Case Close Date"
      expr: case_close_date
    - name: "Case Description"
      expr: case_description
    - name: "Case Number"
      expr: case_number
    - name: "Case Open Date"
      expr: case_open_date
    - name: "Case Status"
      expr: case_status
    - name: "Collection Case Number"
      expr: collection_case_number
    - name: "Collection Source System"
      expr: collection_source_system
    - name: "Collection Stage"
      expr: collection_stage
    - name: "Collection Status"
      expr: collection_status
    - name: "Communication Method"
      expr: communication_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Response Status"
      expr: customer_response_status
    - name: "Days Past Due"
      expr: days_past_due
    - name: "Dunning Date"
      expr: dunning_date
    - name: "Dunning Level"
      expr: dunning_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Collections"
      expr: COUNT(DISTINCT collections_id)
    - name: "Total Case Strategy"
      expr: SUM(case_strategy)
    - name: "Average Case Strategy"
      expr: AVG(case_strategy)
    - name: "Total Dunning Charges"
      expr: SUM(dunning_charges)
    - name: "Average Dunning Charges"
      expr: AVG(dunning_charges)
    - name: "Total Gross Exposure Amount"
      expr: SUM(gross_exposure_amount)
    - name: "Average Gross Exposure Amount"
      expr: AVG(gross_exposure_amount)
    - name: "Total Net Exposure Amount"
      expr: SUM(net_exposure_amount)
    - name: "Average Net Exposure Amount"
      expr: AVG(net_exposure_amount)
    - name: "Total Outstanding Amount"
      expr: SUM(outstanding_amount)
    - name: "Average Outstanding Amount"
      expr: AVG(outstanding_amount)
    - name: "Total Payment Arrangement Type"
      expr: SUM(payment_arrangement_type)
    - name: "Average Payment Arrangement Type"
      expr: AVG(payment_arrangement_type)
    - name: "Total Promised Amount"
      expr: SUM(promised_amount)
    - name: "Average Promised Amount"
      expr: AVG(promised_amount)
    - name: "Total Recovered Amount"
      expr: SUM(recovered_amount)
    - name: "Average Recovered Amount"
      expr: AVG(recovered_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit Limit business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`credit_limit`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Block Flag"
      expr: credit_block_flag
    - name: "Credit Status"
      expr: credit_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Limit Type"
      expr: limit_type
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Review Date"
      expr: review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credit Limit"
      expr: COUNT(DISTINCT credit_limit_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Available Credit Amount"
      expr: SUM(available_credit_amount)
    - name: "Average Available Credit Amount"
      expr: AVG(available_credit_amount)
    - name: "Total Credit Check Method"
      expr: SUM(credit_check_method)
    - name: "Average Credit Check Method"
      expr: AVG(credit_check_method)
    - name: "Total Credit Horizon Days"
      expr: SUM(credit_horizon_days)
    - name: "Average Credit Horizon Days"
      expr: AVG(credit_horizon_days)
    - name: "Total Credit Limit Number"
      expr: SUM(credit_limit_number)
    - name: "Average Credit Limit Number"
      expr: AVG(credit_limit_number)
    - name: "Total Credit Limit Status"
      expr: SUM(credit_limit_status)
    - name: "Average Credit Limit Status"
      expr: AVG(credit_limit_status)
    - name: "Total Current Exposure"
      expr: SUM(current_exposure)
    - name: "Average Current Exposure"
      expr: AVG(current_exposure)
    - name: "Total Limit Amount"
      expr: SUM(limit_amount)
    - name: "Average Limit Amount"
      expr: AVG(limit_amount)
    - name: "Total Utilization Percentage"
      expr: SUM(utilization_percentage)
    - name: "Average Utilization Percentage"
      expr: AVG(utilization_percentage)
    - name: "Total Utilized Credit Amount"
      expr: SUM(utilized_credit_amount)
    - name: "Average Utilized Credit Amount"
      expr: AVG(utilized_credit_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`dispute`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Number"
      expr: dispute_number
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Opened Date"
      expr: opened_date
    - name: "Priority"
      expr: priority
    - name: "Reason Category"
      expr: reason_category
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
    - name: "Resolution Date"
      expr: resolution_date
    - name: "Resolution Notes"
      expr: resolution_notes
    - name: "Resolution Type"
      expr: resolution_type
    - name: "Resolved Date"
      expr: resolved_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispute"
      expr: COUNT(DISTINCT dispute_id)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
    - name: "Total Resolved Amount"
      expr: SUM(resolved_amount)
    - name: "Average Resolved Amount"
      expr: AVG(resolved_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country"
      expr: billing_country
    - name: "Billing Period End"
      expr: billing_period_end
    - name: "Billing Period Start"
      expr: billing_period_start
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State"
      expr: billing_state
    - name: "Collection Status"
      expr: collection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Due Date"
      expr: due_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Invoice Type"
      expr: invoice_type
    - name: "Is Self Billing"
      expr: is_self_billing
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice"
      expr: COUNT(DISTINCT invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Rate"
      expr: SUM(discount_rate)
    - name: "Average Discount Rate"
      expr: AVG(discount_rate)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Payment Method"
      expr: SUM(payment_method)
    - name: "Average Payment Method"
      expr: AVG(payment_method)
    - name: "Total Payment Status"
      expr: SUM(payment_status)
    - name: "Average Payment Status"
      expr: AVG(payment_status)
    - name: "Total Payment Terms Code"
      expr: SUM(payment_terms_code)
    - name: "Average Payment Terms Code"
      expr: AVG(payment_terms_code)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deferred Revenue Flag"
      expr: deferred_revenue_flag
    - name: "Description"
      expr: description
    - name: "Expense Account"
      expr: expense_account
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Bundle Line"
      expr: is_bundle_line
    - name: "Is Credit Memo"
      expr: is_credit_memo
    - name: "Is Royalty Line"
      expr: is_royalty_line
    - name: "Is Tax Included"
      expr: is_tax_included
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Status"
      expr: line_status
    - name: "Line Type"
      expr: line_type
    - name: "Notes"
      expr: notes
    - name: "Posted Timestamp"
      expr: posted_timestamp
    - name: "Service End Date"
      expr: service_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line"
      expr: COUNT(DISTINCT invoice_line_id)
    - name: "Total Allocation Amount"
      expr: SUM(allocation_amount)
    - name: "Average Allocation Amount"
      expr: AVG(allocation_amount)
    - name: "Total Allocation Percent"
      expr: SUM(allocation_percent)
    - name: "Average Allocation Percent"
      expr: AVG(allocation_percent)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Line Amount"
      expr: SUM(line_amount)
    - name: "Average Line Amount"
      expr: AVG(line_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Revenue Account"
      expr: SUM(revenue_account)
    - name: "Average Revenue Account"
      expr: AVG(revenue_account)
    - name: "Total Revenue Recognition Method"
      expr: SUM(revenue_recognition_method)
    - name: "Average Revenue Recognition Method"
      expr: AVG(revenue_recognition_method)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Bank Name"
      expr: bank_name
    - name: "Bank Reference"
      expr: bank_reference
    - name: "Bank Value Date"
      expr: bank_value_date
    - name: "Channel"
      expr: channel
    - name: "Clearing Document Number"
      expr: clearing_document_number
    - name: "Clearing Status"
      expr: clearing_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Due Date"
      expr: due_date
    - name: "External Reference"
      expr: external_reference
    - name: "Is Reconciled"
      expr: is_reconciled
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment"
      expr: COUNT(DISTINCT payment_id)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Amount Discount"
      expr: SUM(amount_discount)
    - name: "Average Amount Discount"
      expr: AVG(amount_discount)
    - name: "Total Amount Gross"
      expr: SUM(amount_gross)
    - name: "Average Amount Gross"
      expr: AVG(amount_gross)
    - name: "Total Amount Net"
      expr: SUM(amount_net)
    - name: "Average Amount Net"
      expr: AVG(amount_net)
    - name: "Total Batch Code"
      expr: SUM(batch_code)
    - name: "Average Batch Code"
      expr: AVG(batch_code)
    - name: "Total Description"
      expr: SUM(description)
    - name: "Average Description"
      expr: AVG(description)
    - name: "Total Discount Taken"
      expr: SUM(discount_taken)
    - name: "Average Discount Taken"
      expr: AVG(discount_taken)
    - name: "Total Early Payment Discount Applied"
      expr: SUM(early_payment_discount_applied)
    - name: "Average Early Payment Discount Applied"
      expr: AVG(early_payment_discount_applied)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Method"
      expr: SUM(method)
    - name: "Average Method"
      expr: AVG(method)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Allocation business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`payment_allocation`"
  dimensions:
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Clearing Document Number"
      expr: clearing_document_number
    - name: "Clearing Status"
      expr: clearing_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Allocation Date Month"
      expr: DATE_TRUNC('MONTH', allocation_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Allocation"
      expr: COUNT(DISTINCT payment_allocation_id)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Allocation Sequence"
      expr: SUM(allocation_sequence)
    - name: "Average Allocation Sequence"
      expr: AVG(allocation_sequence)
    - name: "Total Discount Taken"
      expr: SUM(discount_taken)
    - name: "Average Discount Taken"
      expr: AVG(discount_taken)
    - name: "Total Early Payment Discount Applied"
      expr: SUM(early_payment_discount_applied)
    - name: "Average Early Payment Discount Applied"
      expr: AVG(early_payment_discount_applied)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment_term`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Term business metrics"
  source: "`vibe_manufacturing_v1`.`billing`.`payment_term`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Applicable Invoice Type"
      expr: applicable_invoice_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description"
      expr: description
    - name: "Discount Days"
      expr: discount_days
    - name: "Due Day Of Month"
      expr: due_day_of_month
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Installment Flag"
      expr: installment_flag
    - name: "Is Default"
      expr: is_default
    - name: "Is Tax Exempt"
      expr: is_tax_exempt
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Term"
      expr: COUNT(DISTINCT payment_term_id)
    - name: "Total Allowed Payment Channel"
      expr: SUM(allowed_payment_channel)
    - name: "Average Allowed Payment Channel"
      expr: AVG(allowed_payment_channel)
    - name: "Total Allowed Payment Method"
      expr: SUM(allowed_payment_method)
    - name: "Average Allowed Payment Method"
      expr: AVG(allowed_payment_method)
    - name: "Total Code"
      expr: SUM(code)
    - name: "Average Code"
      expr: AVG(code)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Early Payment Discount Days"
      expr: SUM(early_payment_discount_days)
    - name: "Average Early Payment Discount Days"
      expr: AVG(early_payment_discount_days)
    - name: "Total Early Payment Discount Percent"
      expr: SUM(early_payment_discount_percent)
    - name: "Average Early Payment Discount Percent"
      expr: AVG(early_payment_discount_percent)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Min Payment Amount"
      expr: SUM(min_payment_amount)
    - name: "Average Min Payment Amount"
      expr: AVG(min_payment_amount)
    - name: "Total Name"
      expr: SUM(name)
    - name: "Average Name"
      expr: AVG(name)
    - name: "Total Payment Term Status"
      expr: SUM(payment_term_status)
    - name: "Average Payment Term Status"
      expr: AVG(payment_term_status)
    - name: "Total Penalty Rate Percent"
      expr: SUM(penalty_rate_percent)
    - name: "Average Penalty Rate Percent"
      expr: AVG(penalty_rate_percent)
$$;