-- Metric views for domain: procurement | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:43:55

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Receipt business metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "Accounting Document Number"
      expr: accounting_document_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Damage Flag"
      expr: damage_flag
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Note Number"
      expr: delivery_note_number
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
    - name: "Invoice Verification Flag"
      expr: invoice_verification_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manufacturing Date"
      expr: manufacturing_date
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Material Document Year"
      expr: material_document_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Receipt"
      expr: COUNT(DISTINCT goods_receipt_id)
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
    - name: "Total Value"
      expr: SUM(value)
    - name: "Average Value"
      expr: AVG(value)
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
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
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
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Invoice Receipt Status"
      expr: invoice_receipt_status
    - name: "Material Category"
      expr: material_category
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order"
      expr: COUNT(DISTINCT purchase_order_id)
    - name: "Total Net Po Value"
      expr: SUM(net_po_value)
    - name: "Average Net Po Value"
      expr: AVG(net_po_value)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Po Value"
      expr: SUM(total_po_value)
    - name: "Average Total Po Value"
      expr: AVG(total_po_value)
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
    - name: "Purchasing Group Code"
      expr: purchasing_group_code
    - name: "Purchasing Organization Code"
      expr: purchasing_organization_code
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
      expr: rfq_description
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
    - name: "Material Category"
      expr: material_category
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Block Indicator"
      expr: payment_block_indicator
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
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tolerance Variance Amount"
      expr: SUM(tolerance_variance_amount)
    - name: "Average Tolerance Variance Amount"
      expr: AVG(tolerance_variance_amount)
    - name: "Total Tolerance Variance Percentage"
      expr: SUM(tolerance_variance_percentage)
    - name: "Average Tolerance Variance Percentage"
      expr: AVG(tolerance_variance_percentage)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
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
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Material Group"
      expr: material_group
    - name: "Payment Terms"
      expr: payment_terms
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