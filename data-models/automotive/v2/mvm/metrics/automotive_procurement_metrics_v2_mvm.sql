-- Metric views for domain: procurement | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:29:46

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor List business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`approved_vendor_list`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Avl Number"
      expr: avl_number
    - name: "Backup Supplier Flag"
      expr: backup_supplier_flag
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Entry Date"
      expr: entry_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Min Order Quantity"
      expr: min_order_quantity
    - name: "Notes"
      expr: notes
    - name: "Ppap Approval Level"
      expr: ppap_approval_level
    - name: "Preferred Supplier Flag"
      expr: preferred_supplier_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Approved Vendor List"
      expr: COUNT(DISTINCT approved_vendor_list_id)
    - name: "Total Price Cap"
      expr: SUM(price_cap)
    - name: "Average Price Cap"
      expr: AVG(price_cap)
    - name: "Total Quality Rating Threshold"
      expr: SUM(quality_rating_threshold)
    - name: "Average Quality Rating Threshold"
      expr: AVG(quality_rating_threshold)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_info_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Info Record business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`info_record`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Info Record Number"
      expr: info_record_number
    - name: "Info Record Status"
      expr: info_record_status
    - name: "Info Record Type"
      expr: info_record_type
    - name: "Last Price Update Timestamp"
      expr: last_price_update_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Minimum Order Quantity"
      expr: minimum_order_quantity
    - name: "Notes"
      expr: notes
    - name: "Order Quantity Uom"
      expr: order_quantity_uom
    - name: "Price Valid From"
      expr: price_valid_from
    - name: "Price Valid Until"
      expr: price_valid_until
    - name: "Procurement Category"
      expr: procurement_category
    - name: "Reminder Days"
      expr: reminder_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Info Record"
      expr: COUNT(DISTINCT info_record_id)
    - name: "Total Over Delivery Tolerance Percent"
      expr: SUM(over_delivery_tolerance_percent)
    - name: "Average Over Delivery Tolerance Percent"
      expr: AVG(over_delivery_tolerance_percent)
    - name: "Total Price Amount"
      expr: SUM(price_amount)
    - name: "Average Price Amount"
      expr: AVG(price_amount)
    - name: "Total Under Delivery Tolerance Percent"
      expr: SUM(under_delivery_tolerance_percent)
    - name: "Average Under Delivery Tolerance Percent"
      expr: AVG(under_delivery_tolerance_percent)
    - name: "Total Vendor Evaluation Score"
      expr: SUM(vendor_evaluation_score)
    - name: "Average Vendor Evaluation Score"
      expr: AVG(vendor_evaluation_score)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement Goods Receipt business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "Accounting Document Number"
      expr: accounting_document_number
    - name: "Accounting Year"
      expr: accounting_year
    - name: "Batch Number"
      expr: batch_number
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Invoice Match Status"
      expr: invoice_match_status
    - name: "Is Blocked Stock"
      expr: is_blocked_stock
    - name: "Is Quality Inspection Required"
      expr: is_quality_inspection_required
    - name: "Movement Type"
      expr: movement_type
    - name: "Posting Date"
      expr: posting_date
    - name: "Procurement Goods Receipt Status"
      expr: procurement_goods_receipt_status
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Quality Inspection Result"
      expr: quality_inspection_result
    - name: "Receipt Number"
      expr: receipt_number
    - name: "Receipt Timestamp"
      expr: receipt_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Procurement Goods Receipt"
      expr: COUNT(DISTINCT procurement_goods_receipt_id)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Quantity Received"
      expr: SUM(quantity_received)
    - name: "Average Quantity Received"
      expr: AVG(quantity_received)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement Po Line business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`procurement_po_line`"
  dimensions:
    - name: "Account Assignment Category"
      expr: account_assignment_category
    - name: "Batch Management Flag"
      expr: batch_management_flag
    - name: "Batch Number"
      expr: batch_number
    - name: "Confirmation Date"
      expr: confirmation_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Goods Receipt Date"
      expr: goods_receipt_date
    - name: "Internal Order Number"
      expr: internal_order_number
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Receipt Date"
      expr: invoice_receipt_date
    - name: "Is Blocked"
      expr: is_blocked
    - name: "Is Deleted"
      expr: is_deleted
    - name: "Last Updated By"
      expr: last_updated_by
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Line Number"
      expr: line_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Procurement Po Line"
      expr: COUNT(DISTINCT procurement_po_line_id)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Over Delivery Tolerance Percent"
      expr: SUM(over_delivery_tolerance_percent)
    - name: "Average Over Delivery Tolerance Percent"
      expr: AVG(over_delivery_tolerance_percent)
    - name: "Total Quantity Ordered"
      expr: SUM(quantity_ordered)
    - name: "Average Quantity Ordered"
      expr: AVG(quantity_ordered)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Under Delivery Tolerance Percent"
      expr: SUM(under_delivery_tolerance_percent)
    - name: "Average Under Delivery Tolerance Percent"
      expr: AVG(under_delivery_tolerance_percent)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement Purchase Order business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "Account Assignment"
      expr: account_assignment
    - name: "Approval Status"
      expr: approval_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Goods Receipt Date"
      expr: goods_receipt_date
    - name: "Gr Ir Control Flag"
      expr: gr_ir_control_flag
    - name: "Incoterms"
      expr: incoterms
    - name: "Invoice Receipt Date"
      expr: invoice_receipt_date
    - name: "Order Date"
      expr: order_date
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Po Number"
      expr: po_number
    - name: "Po Type"
      expr: po_type
    - name: "Procurement Purchase Order Status"
      expr: procurement_purchase_order_status
    - name: "Purchase Group"
      expr: purchase_group
    - name: "Purchasing Organization"
      expr: purchasing_organization
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Procurement Purchase Order"
      expr: COUNT(DISTINCT procurement_purchase_order_id)
    - name: "Total Currency Rate"
      expr: SUM(currency_rate)
    - name: "Average Currency Rate"
      expr: AVG(currency_rate)
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
    - name: "Total Total Quantity"
      expr: SUM(total_quantity)
    - name: "Average Total Quantity"
      expr: AVG(total_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement Supplier business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`procurement_supplier`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Name"
      expr: bank_name
    - name: "Certification Status"
      expr: certification_status
    - name: "City"
      expr: city
    - name: "Commodity Specialization"
      expr: commodity_specialization
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Duns Number"
      expr: duns_number
    - name: "Iatf16949 Cert Expiry"
      expr: iatf16949_cert_expiry
    - name: "Iatf16949 Certified"
      expr: iatf16949_certified
    - name: "Incoterms"
      expr: incoterms
    - name: "Iso14001 Cert Expiry"
      expr: iso14001_cert_expiry
    - name: "Iso14001 Certified"
      expr: iso14001_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Procurement Supplier"
      expr: COUNT(DISTINCT procurement_supplier_id)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Max Order Quantity"
      expr: SUM(max_order_quantity)
    - name: "Average Max Order Quantity"
      expr: AVG(max_order_quantity)
    - name: "Total Min Order Quantity"
      expr: SUM(min_order_quantity)
    - name: "Average Min Order Quantity"
      expr: AVG(min_order_quantity)
    - name: "Total Rating Score"
      expr: SUM(rating_score)
    - name: "Average Rating Score"
      expr: AVG(rating_score)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Requisition business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "Account Assignment Category"
      expr: account_assignment_category
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Converted To Po"
      expr: is_converted_to_po
    - name: "Notes"
      expr: notes
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Priority"
      expr: priority
    - name: "Procurement Type"
      expr: procurement_type
    - name: "Purchase Group"
      expr: purchase_group
    - name: "Purchase Requisition Status"
      expr: purchase_requisition_status
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Required Delivery Date"
      expr: required_delivery_date
    - name: "Requisition Date"
      expr: requisition_date
    - name: "Requisition Number"
      expr: requisition_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Requisition"
      expr: COUNT(DISTINCT purchase_requisition_id)
    - name: "Total Estimated Value"
      expr: SUM(estimated_value)
    - name: "Average Estimated Value"
      expr: AVG(estimated_value)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Contract business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Audit Trail Notes"
      expr: audit_trail_notes
    - name: "Compliance Requirements"
      expr: compliance_requirements
    - name: "Contract Category"
      expr: contract_category
    - name: "Contract Description"
      expr: contract_description
    - name: "Contract Document Url"
      expr: contract_document_url
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Scope"
      expr: contract_scope
    - name: "Contract Type"
      expr: contract_type
    - name: "Contract Version"
      expr: contract_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Schedule Description"
      expr: delivery_schedule_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Governing Law"
      expr: governing_law
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Contract"
      expr: COUNT(DISTINCT supplier_contract_id)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
    - name: "Total Volume Commitment Quantity"
      expr: SUM(volume_commitment_quantity)
    - name: "Average Volume Commitment Quantity"
      expr: AVG(volume_commitment_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Invoice business metrics"
  source: "`vibe_automotive_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "Accounting Document Number"
      expr: accounting_document_number
    - name: "Attachment Flag"
      expr: attachment_flag
    - name: "Blocking Reason"
      expr: blocking_reason
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Due Date"
      expr: due_date
    - name: "Ean Number"
      expr: ean_number
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Internal Order Number"
      expr: internal_order_number
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Type"
      expr: invoice_type
    - name: "Line Item Count"
      expr: line_item_count
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
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
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Invoice Currency Amount"
      expr: SUM(invoice_currency_amount)
    - name: "Average Invoice Currency Amount"
      expr: AVG(invoice_currency_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
$$;