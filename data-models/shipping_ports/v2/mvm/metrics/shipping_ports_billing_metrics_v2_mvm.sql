-- Metric views for domain: billing | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:23:20

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "Applied Date"
      expr: applied_date
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Container Number"
      expr: container_number
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Note Date"
      expr: credit_note_date
    - name: "Credit Note Number"
      expr: credit_note_number
    - name: "Credit Note Status"
      expr: credit_note_status
    - name: "Credit Reason Code"
      expr: credit_reason_code
    - name: "Credit Reason Description"
      expr: credit_reason_description
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Notification Sent"
      expr: customer_notification_sent
    - name: "Customer Reference"
      expr: customer_reference
    - name: "Fiscal Period"
      expr: fiscal_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adjustment"
      expr: COUNT(DISTINCT adjustment_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Original Charge Amount"
      expr: SUM(original_charge_amount)
    - name: "Average Original Charge Amount"
      expr: AVG(original_charge_amount)
    - name: "Total Tax Credit Amount"
      expr: SUM(tax_credit_amount)
    - name: "Average Tax Credit Amount"
      expr: AVG(tax_credit_amount)
    - name: "Total Total Credit Amount"
      expr: SUM(total_credit_amount)
    - name: "Average Total Credit Amount"
      expr: AVG(total_credit_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_charge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge Event business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`charge_event`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Billing Status"
      expr: billing_status
    - name: "Container Number"
      expr: container_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Excess Days"
      expr: excess_days
    - name: "Exemption Flag"
      expr: exemption_flag
    - name: "Exemption Reason"
      expr: exemption_reason
    - name: "Free Time Days"
      expr: free_time_days
    - name: "Free Time End Timestamp"
      expr: free_time_end_timestamp
    - name: "Free Time Start Timestamp"
      expr: free_time_start_timestamp
    - name: "Hazmat Flag"
      expr: hazmat_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Charge Event"
      expr: COUNT(DISTINCT charge_event_id)
    - name: "Total Cargo Volume Cbm"
      expr: SUM(cargo_volume_cbm)
    - name: "Average Cargo Volume Cbm"
      expr: AVG(cargo_volume_cbm)
    - name: "Total Cargo Weight Kg"
      expr: SUM(cargo_weight_kg)
    - name: "Average Cargo Weight Kg"
      expr: AVG(cargo_weight_kg)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
    - name: "Total Daily Rate"
      expr: SUM(daily_rate)
    - name: "Average Daily Rate"
      expr: AVG(daily_rate)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Net Charge Amount"
      expr: SUM(net_charge_amount)
    - name: "Average Net Charge Amount"
      expr: AVG(net_charge_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Unit Rate"
      expr: SUM(unit_rate)
    - name: "Average Unit Rate"
      expr: AVG(unit_rate)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_debit_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debit Note business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`debit_note`"
  dimensions:
    - name: "Acknowledgement Date"
      expr: acknowledgement_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Bol Number"
      expr: bol_number
    - name: "Container Number"
      expr: container_number
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Acknowledgement Status"
      expr: customer_acknowledgement_status
    - name: "Debit Note Number"
      expr: debit_note_number
    - name: "Debit Reason Code"
      expr: debit_reason_code
    - name: "Debit Reason Description"
      expr: debit_reason_description
    - name: "Debit Status"
      expr: debit_status
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Due Date"
      expr: due_date
    - name: "Issue Date"
      expr: issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Debit Note"
      expr: COUNT(DISTINCT debit_note_id)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Debit Amount"
      expr: SUM(total_debit_amount)
    - name: "Average Total Debit Amount"
      expr: AVG(total_debit_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`dispute`"
  dimensions:
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Category"
      expr: dispute_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Note Reference"
      expr: credit_note_reference
    - name: "Customer Satisfaction Rating"
      expr: customer_satisfaction_rating
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Disputed Currency Code"
      expr: disputed_currency_code
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Investigation Notes"
      expr: investigation_notes
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lodged Date"
      expr: lodged_date
    - name: "Lodged Timestamp"
      expr: lodged_timestamp
    - name: "Preventive Action Taken"
      expr: preventive_action_taken
    - name: "Reason Code"
      expr: reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispute"
      expr: COUNT(DISTINCT dispute_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`invoice`"
  dimensions:
    - name: "Bol Number"
      expr: bol_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Note Number"
      expr: credit_note_number
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Due Date"
      expr: due_date
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Received Date"
      expr: payment_received_date
    - name: "Payment Reference Number"
      expr: payment_reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice"
      expr: COUNT(DISTINCT invoice_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Baf Amount"
      expr: SUM(baf_amount)
    - name: "Average Baf Amount"
      expr: AVG(baf_amount)
    - name: "Total Caf Amount"
      expr: SUM(caf_amount)
    - name: "Average Caf Amount"
      expr: AVG(caf_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
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

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "Adjustment Flag"
      expr: adjustment_flag
    - name: "Bol Number"
      expr: bol_number
    - name: "Charge Category"
      expr: charge_category
    - name: "Container Number"
      expr: container_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Line Number"
      expr: line_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Revenue Recognition Date"
      expr: revenue_recognition_date
    - name: "Service End Timestamp"
      expr: service_end_timestamp
    - name: "Service Start Timestamp"
      expr: service_start_timestamp
    - name: "Tax Code"
      expr: tax_code
    - name: "Unit Of Measure"
      expr: unit_of_measure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line"
      expr: COUNT(DISTINCT invoice_line_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
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
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Unit Rate"
      expr: SUM(unit_rate)
    - name: "Average Unit Rate"
      expr: AVG(unit_rate)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`payment`"
  dimensions:
    - name: "Bank Reference"
      expr: bank_reference
    - name: "Channel"
      expr: channel
    - name: "Clearing Date"
      expr: clearing_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Reference"
      expr: dispute_reference
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Advance Payment"
      expr: is_advance_payment
    - name: "Method"
      expr: method
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Navis Billing Reference"
      expr: navis_billing_reference
    - name: "Notes"
      expr: notes
    - name: "Payer Account Number"
      expr: payer_account_number
    - name: "Payer Bank Name"
      expr: payer_bank_name
    - name: "Payment Date"
      expr: payment_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment"
      expr: COUNT(DISTINCT payment_id)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Amount Paid"
      expr: SUM(amount_paid)
    - name: "Average Amount Paid"
      expr: AVG(amount_paid)
    - name: "Total Base Currency Amount"
      expr: SUM(base_currency_amount)
    - name: "Average Base Currency Amount"
      expr: AVG(base_currency_amount)
    - name: "Total Discount Taken"
      expr: SUM(discount_taken)
    - name: "Average Discount Taken"
      expr: AVG(discount_taken)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Unapplied Amount"
      expr: SUM(unapplied_amount)
    - name: "Average Unapplied Amount"
      expr: AVG(unapplied_amount)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Allocation business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`payment_allocation`"
  dimensions:
    - name: "Accounting Period"
      expr: accounting_period
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Reference"
      expr: allocation_reference
    - name: "Allocation Source"
      expr: allocation_source
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Timestamp"
      expr: allocation_timestamp
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Bank Reconciliation Reference"
      expr: bank_reconciliation_reference
    - name: "Business Area"
      expr: business_area
    - name: "Company Code"
      expr: company_code
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reference"
      expr: dispute_reference
    - name: "Fiscal Year"
      expr: fiscal_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Allocation"
      expr: COUNT(DISTINCT payment_allocation_id)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Discount Taken"
      expr: SUM(discount_taken)
    - name: "Average Discount Taken"
      expr: AVG(discount_taken)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Local Currency Amount"
      expr: SUM(local_currency_amount)
    - name: "Average Local Currency Amount"
      expr: AVG(local_currency_amount)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Withholding Tax Deducted"
      expr: SUM(withholding_tax_deducted)
    - name: "Average Withholding Tax Deducted"
      expr: AVG(withholding_tax_deducted)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_receivable_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receivable Account business metrics"
  source: "`vibe_shipping_ports_v1`.`billing`.`receivable_account`"
  dimensions:
    - name: "Account Classification"
      expr: account_classification
    - name: "Account Closed Date"
      expr: account_closed_date
    - name: "Account Code"
      expr: account_code
    - name: "Account Name"
      expr: account_name
    - name: "Account Opened Date"
      expr: account_opened_date
    - name: "Account Status"
      expr: account_status
    - name: "Auto Payment Flag"
      expr: auto_payment_flag
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country"
      expr: billing_country
    - name: "Billing Email"
      expr: billing_email
    - name: "Billing Phone"
      expr: billing_phone
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Consolidation Flag"
      expr: consolidation_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Receivable Account"
      expr: COUNT(DISTINCT receivable_account_id)
    - name: "Total Aging Bucket 0 30 Days"
      expr: SUM(aging_bucket_0_30_days)
    - name: "Average Aging Bucket 0 30 Days"
      expr: AVG(aging_bucket_0_30_days)
    - name: "Total Aging Bucket 31 60 Days"
      expr: SUM(aging_bucket_31_60_days)
    - name: "Average Aging Bucket 31 60 Days"
      expr: AVG(aging_bucket_31_60_days)
    - name: "Total Aging Bucket 61 90 Days"
      expr: SUM(aging_bucket_61_90_days)
    - name: "Average Aging Bucket 61 90 Days"
      expr: AVG(aging_bucket_61_90_days)
    - name: "Total Aging Bucket Over 90 Days"
      expr: SUM(aging_bucket_over_90_days)
    - name: "Average Aging Bucket Over 90 Days"
      expr: AVG(aging_bucket_over_90_days)
    - name: "Total Average Days To Pay"
      expr: SUM(average_days_to_pay)
    - name: "Average Average Days To Pay"
      expr: AVG(average_days_to_pay)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Write Off Amount Ytd"
      expr: SUM(write_off_amount_ytd)
    - name: "Average Write Off Amount Ytd"
      expr: AVG(write_off_amount_ytd)
$$;
