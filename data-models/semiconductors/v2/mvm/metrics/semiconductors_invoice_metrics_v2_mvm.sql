-- Metric views for domain: invoice | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ar Invoice business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`ar_invoice`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Ar Invoice Status"
      expr: ar_invoice_status
    - name: "Auditor Notes"
      expr: auditor_notes
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Collection Status"
      expr: collection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Name"
      expr: customer_name
    - name: "Document Type"
      expr: document_type
    - name: "Due Date"
      expr: due_date
    - name: "Ecn Classification"
      expr: ecn_classification
    - name: "Export Control Flag"
      expr: export_control_flag
    - name: "Hs Code"
      expr: hs_code
    - name: "Incoterms"
      expr: incoterms
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ar Invoice"
      expr: COUNT(DISTINCT ar_invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Early Payment Discount"
      expr: SUM(early_payment_discount)
    - name: "Average Early Payment Discount"
      expr: AVG(early_payment_discount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Late Fee Amount"
      expr: SUM(late_fee_amount)
    - name: "Average Late Fee Amount"
      expr: AVG(late_fee_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_credit_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit Hold business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`credit_hold`"
  dimensions:
    - name: "Block Level"
      expr: block_level
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Hold Status"
      expr: credit_hold_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hold Category"
      expr: hold_category
    - name: "Hold Number"
      expr: hold_number
    - name: "Hold Placed Timestamp"
      expr: hold_placed_timestamp
    - name: "Hold Reason"
      expr: hold_reason
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Hold Reason Description"
      expr: hold_reason_description
    - name: "Hold Release Date"
      expr: hold_release_date
    - name: "Hold Start Date"
      expr: hold_start_date
    - name: "Hold Status"
      expr: hold_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credit Hold"
      expr: COUNT(DISTINCT credit_hold_id)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Hold Amount"
      expr: SUM(hold_amount)
    - name: "Average Hold Amount"
      expr: AVG(hold_amount)
    - name: "Total Overdue Amount"
      expr: SUM(overdue_amount)
    - name: "Average Overdue Amount"
      expr: AVG(overdue_amount)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_customer_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Credit Limit business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`customer_credit_limit`"
  dimensions:
    - name: "Business Unit"
      expr: business_unit
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Currency"
      expr: credit_currency
    - name: "Credit Hold Flag"
      expr: credit_hold_flag
    - name: "Credit Hold Reason"
      expr: credit_hold_reason
    - name: "Credit Insurance Coverage"
      expr: credit_insurance_coverage
    - name: "Credit Insurance Provider"
      expr: credit_insurance_provider
    - name: "Credit Limit Created"
      expr: credit_limit_created
    - name: "Credit Limit Last Updated"
      expr: credit_limit_last_updated
    - name: "Credit Limit Number"
      expr: credit_limit_number
    - name: "Credit Limit Status"
      expr: credit_limit_status
    - name: "Credit Limit Type"
      expr: credit_limit_type
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Credit Review Date"
      expr: credit_review_date
    - name: "Credit Risk Classification"
      expr: credit_risk_classification
    - name: "Currency Code"
      expr: currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Credit Limit"
      expr: COUNT(DISTINCT customer_credit_limit_id)
    - name: "Total Available Credit"
      expr: SUM(available_credit)
    - name: "Average Available Credit"
      expr: AVG(available_credit)
    - name: "Total Credit Available Amount"
      expr: SUM(credit_available_amount)
    - name: "Average Credit Available Amount"
      expr: AVG(credit_available_amount)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Credit Used Amount"
      expr: SUM(credit_used_amount)
    - name: "Average Credit Used Amount"
      expr: AVG(credit_used_amount)
    - name: "Total Credit Utilization Amount"
      expr: SUM(credit_utilization_amount)
    - name: "Average Credit Utilization Amount"
      expr: AVG(credit_utilization_amount)
    - name: "Total Credit Utilization Pct"
      expr: SUM(credit_utilization_pct)
    - name: "Average Credit Utilization Pct"
      expr: AVG(credit_utilization_pct)
    - name: "Total Overdue Amount"
      expr: SUM(overdue_amount)
    - name: "Average Overdue Amount"
      expr: AVG(overdue_amount)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`dispute`"
  dimensions:
    - name: "Actual Settlement Date"
      expr: actual_settlement_date
    - name: "Attached Documents Flag"
      expr: attached_documents_flag
    - name: "Channel"
      expr: channel
    - name: "Close Timestamp"
      expr: close_timestamp
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Dispute Type"
      expr: dispute_type
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Expected Settlement Date"
      expr: expected_settlement_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Notes"
      expr: notes
    - name: "Number"
      expr: number
    - name: "Open Timestamp"
      expr: open_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispute"
      expr: COUNT(DISTINCT dispute_id)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
    - name: "Total Settlement Amount"
      expr: SUM(settlement_amount)
    - name: "Average Settlement Amount"
      expr: AVG(settlement_amount)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`invoice_line`"
  dimensions:
    - name: "Billing Period End"
      expr: billing_period_end
    - name: "Billing Period Start"
      expr: billing_period_start
    - name: "Charge Type"
      expr: charge_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "External Reference"
      expr: external_reference
    - name: "Is Discount Applied"
      expr: is_discount_applied
    - name: "Is Tax Exempt"
      expr: is_tax_exempt
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Description"
      expr: line_description
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line"
      expr: COUNT(DISTINCT invoice_line_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Extended Amount"
      expr: SUM(extended_amount)
    - name: "Average Extended Amount"
      expr: AVG(extended_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_payment_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Receipt business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`payment_receipt`"
  dimensions:
    - name: "Bank Reference"
      expr: bank_reference
    - name: "Compliance Check Status"
      expr: compliance_check_status
    - name: "Compliance Check Timestamp"
      expr: compliance_check_timestamp
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Number Of Allocations"
      expr: number_of_allocations
    - name: "On Account Payment Flag"
      expr: on_account_payment_flag
    - name: "Overpayment Flag"
      expr: overpayment_flag
    - name: "Partial Payment Flag"
      expr: partial_payment_flag
    - name: "Payer Account Number"
      expr: payer_account_number
    - name: "Payer Bank Code"
      expr: payer_bank_code
    - name: "Payer Name"
      expr: payer_name
    - name: "Payment Channel"
      expr: payment_channel
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Receipt"
      expr: COUNT(DISTINCT payment_receipt_id)
    - name: "Total Allocated Amount Total"
      expr: SUM(allocated_amount_total)
    - name: "Average Allocated Amount Total"
      expr: AVG(allocated_amount_total)
    - name: "Total Amount Received"
      expr: SUM(amount_received)
    - name: "Average Amount Received"
      expr: AVG(amount_received)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Functional Currency Amount"
      expr: SUM(functional_currency_amount)
    - name: "Average Functional Currency Amount"
      expr: AVG(functional_currency_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Residual Open Amount"
      expr: SUM(residual_open_amount)
    - name: "Average Residual Open Amount"
      expr: AVG(residual_open_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total To Ar Invoice"
      expr: SUM(to_ar_invoice)
    - name: "Average To Ar Invoice"
      expr: AVG(to_ar_invoice)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_payment_term`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Term business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`payment_term`"
  dimensions:
    - name: "Applicable To Customer Type"
      expr: applicable_to_customer_type
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Compliance Regulation"
      expr: compliance_regulation
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Days"
      expr: discount_days
    - name: "Early Payment Discount Days"
      expr: early_payment_discount_days
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Is Active"
      expr: is_active
    - name: "Is Default"
      expr: is_default
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Term"
      expr: COUNT(DISTINCT payment_term_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Early Payment Discount Percent"
      expr: SUM(early_payment_discount_percent)
    - name: "Average Early Payment Discount Percent"
      expr: AVG(early_payment_discount_percent)
    - name: "Total Late Payment Penalty Percent"
      expr: SUM(late_payment_penalty_percent)
    - name: "Average Late Payment Penalty Percent"
      expr: AVG(late_payment_penalty_percent)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Max Penalty Amount"
      expr: SUM(max_penalty_amount)
    - name: "Average Max Penalty Amount"
      expr: AVG(max_penalty_amount)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Recognition Event business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event`"
  dimensions:
    - name: "Accounting Period"
      expr: accounting_period
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Event Number"
      expr: event_number
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "Is Reversed"
      expr: is_reversed
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Notes"
      expr: notes
    - name: "Period End Date"
      expr: period_end_date
    - name: "Period Start Date"
      expr: period_start_date
    - name: "Recognition Date"
      expr: recognition_date
    - name: "Recognition Method"
      expr: recognition_method
    - name: "Recognition Timestamp"
      expr: recognition_timestamp
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Recognition Event"
      expr: COUNT(DISTINCT revenue_recognition_event_id)
    - name: "Total Cost Of Goods Sold Amount"
      expr: SUM(cost_of_goods_sold_amount)
    - name: "Average Cost Of Goods Sold Amount"
      expr: AVG(cost_of_goods_sold_amount)
    - name: "Total Deferred Amount"
      expr: SUM(deferred_amount)
    - name: "Average Deferred Amount"
      expr: AVG(deferred_amount)
    - name: "Total Profit Amount"
      expr: SUM(profit_amount)
    - name: "Average Profit Amount"
      expr: AVG(profit_amount)
    - name: "Total Recognized Amount"
      expr: SUM(recognized_amount)
    - name: "Average Recognized Amount"
      expr: AVG(recognized_amount)
    - name: "Total Revenue Amount"
      expr: SUM(revenue_amount)
    - name: "Average Revenue Amount"
      expr: AVG(revenue_amount)
    - name: "Total Revenue Rev Rec Event To Ar Invoice"
      expr: SUM(revenue_rev_rec_event_to_ar_invoice)
    - name: "Average Revenue Rev Rec Event To Ar Invoice"
      expr: AVG(revenue_rev_rec_event_to_ar_invoice)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_tax_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax Determination business metrics"
  source: "`vibe_semiconductors_v1`.`invoice`.`tax_determination`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Tax Exempt"
      expr: is_tax_exempt
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Reverse Charge Mechanism"
      expr: reverse_charge_mechanism
    - name: "Tax Calculation Method"
      expr: tax_calculation_method
    - name: "Tax Category"
      expr: tax_category
    - name: "Tax Code"
      expr: tax_code
    - name: "Tax Credit Eligible"
      expr: tax_credit_eligible
    - name: "Tax Currency"
      expr: tax_currency
    - name: "Tax Document Number"
      expr: tax_document_number
    - name: "Tax Document Type"
      expr: tax_document_type
    - name: "Tax Exempt Flag"
      expr: tax_exempt_flag
    - name: "Tax Exempt Reason"
      expr: tax_exempt_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tax Determination"
      expr: COUNT(DISTINCT tax_determination_id)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Base Amount"
      expr: SUM(tax_base_amount)
    - name: "Average Tax Base Amount"
      expr: AVG(tax_base_amount)
    - name: "Total Tax Credit Amount"
      expr: SUM(tax_credit_amount)
    - name: "Average Tax Credit Amount"
      expr: AVG(tax_credit_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Tax Rate Percent"
      expr: SUM(tax_rate_percent)
    - name: "Average Tax Rate Percent"
      expr: AVG(tax_rate_percent)
    - name: "Total Taxable Amount"
      expr: SUM(taxable_amount)
    - name: "Average Taxable Amount"
      expr: AVG(taxable_amount)
    - name: "Total Taxable Quantity"
      expr: SUM(taxable_quantity)
    - name: "Average Taxable Quantity"
      expr: AVG(taxable_quantity)
    - name: "Total To Ar Invoice"
      expr: SUM(to_ar_invoice)
    - name: "Average To Ar Invoice"
      expr: AVG(to_ar_invoice)
    - name: "Total Withholding Amount"
      expr: SUM(withholding_amount)
    - name: "Average Withholding Amount"
      expr: AVG(withholding_amount)
    - name: "Total Withholding Rate"
      expr: SUM(withholding_rate)
    - name: "Average Withholding Rate"
      expr: AVG(withholding_rate)
$$;