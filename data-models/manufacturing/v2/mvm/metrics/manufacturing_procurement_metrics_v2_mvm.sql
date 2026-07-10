-- Metric views for domain: procurement | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:49:38

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_contract_release_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Release Order business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`contract_release_order`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Goods Receipt Number"
      expr: goods_receipt_number
    - name: "Incoterms"
      expr: incoterms
    - name: "Inspection Lot Number"
      expr: inspection_lot_number
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Quality Inspection Required"
      expr: quality_inspection_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Release Order"
      expr: COUNT(DISTINCT contract_release_order_id)
    - name: "Total Contract Remaining Quantity"
      expr: SUM(contract_remaining_quantity)
    - name: "Average Contract Remaining Quantity"
      expr: AVG(contract_remaining_quantity)
    - name: "Total Contract Remaining Value"
      expr: SUM(contract_remaining_value)
    - name: "Average Contract Remaining Value"
      expr: AVG(contract_remaining_value)
    - name: "Total Cumulative Released Value"
      expr: SUM(cumulative_released_value)
    - name: "Average Cumulative Released Value"
      expr: AVG(cumulative_released_value)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Release Quantity"
      expr: SUM(release_quantity)
    - name: "Average Release Quantity"
      expr: AVG(release_quantity)
    - name: "Total Release Value"
      expr: SUM(release_value)
    - name: "Average Release Value"
      expr: AVG(release_value)
    - name: "Total Released Quantity"
      expr: SUM(released_quantity)
    - name: "Average Released Quantity"
      expr: AVG(released_quantity)
    - name: "Total Released Value"
      expr: SUM(released_value)
    - name: "Average Released Value"
      expr: AVG(released_value)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_po_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Po Line Item business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`po_line_item`"
  dimensions:
    - name: "Account Assignment Category"
      expr: account_assignment_category
    - name: "Buyer Name"
      expr: buyer_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deletion Indicator"
      expr: deletion_indicator
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Final Invoice Indicator"
      expr: final_invoice_indicator
    - name: "Goods Receipt Indicator"
      expr: goods_receipt_indicator
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Invoice Receipt Indicator"
      expr: invoice_receipt_indicator
    - name: "Item Category"
      expr: item_category
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Status"
      expr: line_status
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
    - name: "Material Number"
      expr: material_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Po Line Item"
      expr: COUNT(DISTINCT po_line_item_id)
    - name: "Total Net Line Amount"
      expr: SUM(net_line_amount)
    - name: "Average Net Line Amount"
      expr: AVG(net_line_amount)
    - name: "Total Net Order Value"
      expr: SUM(net_order_value)
    - name: "Average Net Order Value"
      expr: AVG(net_order_value)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Open Quantity"
      expr: SUM(open_quantity)
    - name: "Average Open Quantity"
      expr: AVG(open_quantity)
    - name: "Total Over Delivery Tolerance Percent"
      expr: SUM(over_delivery_tolerance_percent)
    - name: "Average Over Delivery Tolerance Percent"
      expr: AVG(over_delivery_tolerance_percent)
    - name: "Total Price Unit"
      expr: SUM(price_unit)
    - name: "Average Price Unit"
      expr: AVG(price_unit)
    - name: "Total Quantity Invoiced"
      expr: SUM(quantity_invoiced)
    - name: "Average Quantity Invoiced"
      expr: AVG(quantity_invoiced)
    - name: "Total Quantity Ordered"
      expr: SUM(quantity_ordered)
    - name: "Average Quantity Ordered"
      expr: AVG(quantity_ordered)
    - name: "Total Quantity Received"
      expr: SUM(quantity_received)
    - name: "Average Quantity Received"
      expr: AVG(quantity_received)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Under Delivery Tolerance Percent"
      expr: SUM(under_delivery_tolerance_percent)
    - name: "Average Under Delivery Tolerance Percent"
      expr: AVG(under_delivery_tolerance_percent)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement Contract business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Approval Date"
      expr: approval_date
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Confidentiality Clause Flag"
      expr: confidentiality_clause_flag
    - name: "Contract Description"
      expr: contract_description
    - name: "Contract Name"
      expr: contract_name
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
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Incoterms"
      expr: incoterms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Procurement Contract"
      expr: COUNT(DISTINCT procurement_contract_id)
    - name: "Total Committed Volume"
      expr: SUM(committed_volume)
    - name: "Average Committed Volume"
      expr: AVG(committed_volume)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Price Deescalation Mechanism"
      expr: SUM(price_deescalation_mechanism)
    - name: "Average Price Deescalation Mechanism"
      expr: AVG(price_deescalation_mechanism)
    - name: "Total Price Escalation Mechanism"
      expr: SUM(price_escalation_mechanism)
    - name: "Average Price Escalation Mechanism"
      expr: AVG(price_escalation_mechanism)
    - name: "Total Release Quantity"
      expr: SUM(release_quantity)
    - name: "Average Release Quantity"
      expr: AVG(release_quantity)
    - name: "Total Release Value"
      expr: SUM(release_value)
    - name: "Average Release Value"
      expr: AVG(release_value)
    - name: "Total Remaining Quantity"
      expr: SUM(remaining_quantity)
    - name: "Average Remaining Quantity"
      expr: AVG(remaining_quantity)
    - name: "Total Remaining Value"
      expr: SUM(remaining_value)
    - name: "Average Remaining Value"
      expr: AVG(remaining_value)
    - name: "Total Target Quantity"
      expr: SUM(target_quantity)
    - name: "Average Target Quantity"
      expr: AVG(target_quantity)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement Goods Receipt business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "Accounting Document Number"
      expr: accounting_document_number
    - name: "Batch Number"
      expr: batch_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Damage Flag"
      expr: damage_flag
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Document Date"
      expr: document_date
    - name: "Document Number"
      expr: document_number
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Gr Ir Clearing Status"
      expr: gr_ir_clearing_status
    - name: "Inspection Required Flag"
      expr: inspection_required_flag
    - name: "Invoice Verification Flag"
      expr: invoice_verification_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manufacturing Date"
      expr: manufacturing_date
    - name: "Material Document Number"
      expr: material_document_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Procurement Goods Receipt"
      expr: COUNT(DISTINCT procurement_goods_receipt_id)
    - name: "Total Goods Receipt Value"
      expr: SUM(goods_receipt_value)
    - name: "Average Goods Receipt Value"
      expr: AVG(goods_receipt_value)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Quantity Variance"
      expr: SUM(quantity_variance)
    - name: "Average Quantity Variance"
      expr: AVG(quantity_variance)
    - name: "Total Received Quantity"
      expr: SUM(received_quantity)
    - name: "Average Received Quantity"
      expr: AVG(received_quantity)
    - name: "Total Rejected Quantity"
      expr: SUM(rejected_quantity)
    - name: "Average Rejected Quantity"
      expr: AVG(rejected_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_info_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Info Record business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_info_record`"
  dimensions:
    - name: "Approved Source Flag"
      expr: approved_source_flag
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fixed Source Flag"
      expr: fixed_source_flag
    - name: "Incoterms"
      expr: incoterms
    - name: "Info Record Category"
      expr: info_record_category
    - name: "Info Record Number"
      expr: info_record_number
    - name: "Info Record Status"
      expr: info_record_status
    - name: "Info Record Type"
      expr: info_record_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Price Update Timestamp"
      expr: last_price_update_timestamp
    - name: "Mrp Relevant Flag"
      expr: mrp_relevant_flag
    - name: "Notes"
      expr: notes
    - name: "Planned Delivery Time Days"
      expr: planned_delivery_time_days
    - name: "Plant Code"
      expr: plant_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Info Record"
      expr: COUNT(DISTINCT purchase_info_record_id)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Order Quantity Multiple"
      expr: SUM(order_quantity_multiple)
    - name: "Average Order Quantity Multiple"
      expr: AVG(order_quantity_multiple)
    - name: "Total Price Change Indicator"
      expr: SUM(price_change_indicator)
    - name: "Average Price Change Indicator"
      expr: AVG(price_change_indicator)
    - name: "Total Price Change Reason"
      expr: SUM(price_change_reason)
    - name: "Average Price Change Reason"
      expr: AVG(price_change_reason)
    - name: "Total Price Unit"
      expr: SUM(price_unit)
    - name: "Average Price Unit"
      expr: AVG(price_unit)
    - name: "Total Tolerance Limit Percent"
      expr: SUM(tolerance_limit_percent)
    - name: "Average Tolerance Limit Percent"
      expr: AVG(tolerance_limit_percent)
    - name: "Total Tolerance Percent"
      expr: SUM(tolerance_percent)
    - name: "Average Tolerance Percent"
      expr: AVG(tolerance_percent)
    - name: "Total Vendor Price List"
      expr: SUM(vendor_price_list)
    - name: "Average Vendor Price List"
      expr: AVG(vendor_price_list)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Order business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "Acknowledgement Date"
      expr: acknowledgement_date
    - name: "Acknowledgement Status"
      expr: acknowledgement_status
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Date"
      expr: approved_date
    - name: "Closed Date"
      expr: closed_date
    - name: "Company Code"
      expr: company_code
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Invoice Receipt Status"
      expr: invoice_receipt_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order"
      expr: COUNT(DISTINCT purchase_order_id)
    - name: "Total Net Po Value"
      expr: SUM(net_po_value)
    - name: "Average Net Po Value"
      expr: AVG(net_po_value)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Gross Amount"
      expr: SUM(total_gross_amount)
    - name: "Average Total Gross Amount"
      expr: AVG(total_gross_amount)
    - name: "Total Total Net Amount"
      expr: SUM(total_net_amount)
    - name: "Average Total Net Amount"
      expr: AVG(total_net_amount)
    - name: "Total Total Po Value"
      expr: SUM(total_po_value)
    - name: "Average Total Po Value"
      expr: AVG(total_po_value)
    - name: "Total Total Tax Amount"
      expr: SUM(total_tax_amount)
    - name: "Average Total Tax Amount"
      expr: AVG(total_tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Requisition business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "Approval Level Required"
      expr: approval_level_required
    - name: "Approved Date"
      expr: approved_date
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Justification Notes"
      expr: justification_notes
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Mrp Controller"
      expr: mrp_controller
    - name: "Plant Code"
      expr: plant_code
    - name: "Po Created Date"
      expr: po_created_date
    - name: "Po Number"
      expr: po_number
    - name: "Pr Date"
      expr: pr_date
    - name: "Pr Number"
      expr: pr_number
    - name: "Pr Status"
      expr: pr_status
    - name: "Pr Type"
      expr: pr_type
    - name: "Priority Code"
      expr: priority_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Requisition"
      expr: COUNT(DISTINCT purchase_requisition_id)
    - name: "Total Estimated Total Value"
      expr: SUM(estimated_total_value)
    - name: "Average Estimated Total Value"
      expr: AVG(estimated_total_value)
    - name: "Total Estimated Unit Price"
      expr: SUM(estimated_unit_price)
    - name: "Average Estimated Unit Price"
      expr: AVG(estimated_unit_price)
    - name: "Total Quantity Requested"
      expr: SUM(quantity_requested)
    - name: "Average Quantity Requested"
      expr: AVG(quantity_requested)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rfq business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Award Date"
      expr: award_date
    - name: "Bid Bond Required"
      expr: bid_bond_required
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Commodity Code"
      expr: commodity_code
    - name: "Commodity Description"
      expr: commodity_description
    - name: "Confidentiality Agreement Required"
      expr: confidentiality_agreement_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Description"
      expr: description
    - name: "Evaluation Criteria"
      expr: evaluation_criteria
    - name: "Invited Supplier Count"
      expr: invited_supplier_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rfq"
      expr: COUNT(DISTINCT rfq_id)
    - name: "Total Bid Bond Amount"
      expr: SUM(bid_bond_amount)
    - name: "Average Bid Bond Amount"
      expr: AVG(bid_bond_amount)
    - name: "Total Estimated Total Value"
      expr: SUM(estimated_total_value)
    - name: "Average Estimated Total Value"
      expr: AVG(estimated_total_value)
    - name: "Total Estimated Value"
      expr: SUM(estimated_value)
    - name: "Average Estimated Value"
      expr: AVG(estimated_value)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_source_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source List business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`source_list`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description"
      expr: description
    - name: "Fixed Source Flag"
      expr: fixed_source_flag
    - name: "Is Blocked"
      expr: is_blocked
    - name: "Is Fixed Source"
      expr: is_fixed_source
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Mrp Relevant Flag"
      expr: mrp_relevant_flag
    - name: "Mrp Source Indicator"
      expr: mrp_source_indicator
    - name: "Priority"
      expr: priority
    - name: "Procurement Type"
      expr: procurement_type
    - name: "Source List Number"
      expr: source_list_number
    - name: "Source List Status"
      expr: source_list_status
    - name: "Source Name"
      expr: source_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Source List"
      expr: COUNT(DISTINCT source_list_id)
    - name: "Total Allocation Percent"
      expr: SUM(allocation_percent)
    - name: "Average Allocation Percent"
      expr: AVG(allocation_percent)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Price Per Unit"
      expr: SUM(price_per_unit)
    - name: "Average Price Per Unit"
      expr: AVG(price_per_unit)
    - name: "Total Price Valid From"
      expr: SUM(price_valid_from)
    - name: "Average Price Valid From"
      expr: AVG(price_valid_from)
    - name: "Total Price Valid To"
      expr: SUM(price_valid_to)
    - name: "Average Price Valid To"
      expr: AVG(price_valid_to)
    - name: "Total Source Rating"
      expr: SUM(source_rating)
    - name: "Average Source Rating"
      expr: AVG(source_rating)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Invoice business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Baseline Date"
      expr: baseline_date
    - name: "Blocking Reason"
      expr: blocking_reason
    - name: "Company Code"
      expr: company_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Date"
      expr: document_date
    - name: "Due Date"
      expr: due_date
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
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Material Category"
      expr: material_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Invoice"
      expr: COUNT(DISTINCT supplier_invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Freight Amount"
      expr: SUM(freight_amount)
    - name: "Average Freight Amount"
      expr: AVG(freight_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Payment Block Indicator"
      expr: SUM(payment_block_indicator)
    - name: "Average Payment Block Indicator"
      expr: AVG(payment_block_indicator)
    - name: "Total Payment Method"
      expr: SUM(payment_method)
    - name: "Average Payment Method"
      expr: AVG(payment_method)
    - name: "Total Payment Reference Number"
      expr: SUM(payment_reference_number)
    - name: "Average Payment Reference Number"
      expr: AVG(payment_reference_number)
    - name: "Total Payment Status"
      expr: SUM(payment_status)
    - name: "Average Payment Status"
      expr: AVG(payment_status)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tolerance Variance Amount"
      expr: SUM(tolerance_variance_amount)
    - name: "Average Tolerance Variance Amount"
      expr: AVG(tolerance_variance_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Quotation business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_quotation`"
  dimensions:
    - name: "Award Date"
      expr: award_date
    - name: "Award Flag"
      expr: award_flag
    - name: "Bid Rank"
      expr: bid_rank
    - name: "Commercial Compliance Flag"
      expr: commercial_compliance_flag
    - name: "Commercial Compliance Notes"
      expr: commercial_compliance_notes
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Environmental Compliance Flag"
      expr: environmental_compliance_flag
    - name: "Incoterms"
      expr: incoterms
    - name: "Is Awarded"
      expr: is_awarded
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Material Group"
      expr: material_group
    - name: "Plant Code"
      expr: plant_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Quotation"
      expr: COUNT(DISTINCT supplier_quotation_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Evaluation Score"
      expr: SUM(evaluation_score)
    - name: "Average Evaluation Score"
      expr: AVG(evaluation_score)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Quoted Quantity"
      expr: SUM(quoted_quantity)
    - name: "Average Quoted Quantity"
      expr: AVG(quoted_quantity)
    - name: "Total Quoted Total Price"
      expr: SUM(quoted_total_price)
    - name: "Average Quoted Total Price"
      expr: AVG(quoted_total_price)
    - name: "Total Quoted Unit Price"
      expr: SUM(quoted_unit_price)
    - name: "Average Quoted Unit Price"
      expr: AVG(quoted_unit_price)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Cost Of Ownership"
      expr: SUM(total_cost_of_ownership)
    - name: "Average Total Cost Of Ownership"
      expr: AVG(total_cost_of_ownership)
    - name: "Total Total Quoted Amount"
      expr: SUM(total_quoted_amount)
    - name: "Average Total Quoted Amount"
      expr: AVG(total_quoted_amount)
$$;