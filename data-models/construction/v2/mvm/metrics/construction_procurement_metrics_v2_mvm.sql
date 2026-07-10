-- Metric views for domain: procurement | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:34:58

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_approved_vendor_list_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor List Item business metrics"
  source: "`vibe_construction_v1`.`procurement`.`approved_vendor_list_item`"
  dimensions:
    - name: "Approved Vendor List Item Status"
      expr: approved_vendor_list_item_status
    - name: "Created Date"
      expr: created_date
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Preferred Vendor Rank"
      expr: preferred_vendor_rank
    - name: "Price Validity End Date"
      expr: price_validity_end_date
    - name: "Price Validity Start Date"
      expr: price_validity_start_date
    - name: "Vendor Lead Time Days"
      expr: vendor_lead_time_days
    - name: "Vendor Material Number"
      expr: vendor_material_number
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Last Modified Date Month"
      expr: DATE_TRUNC('MONTH', last_modified_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Approved Vendor List Item"
      expr: COUNT(DISTINCT approved_vendor_list_item_id)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Vendor Unit Price"
      expr: SUM(vendor_unit_price)
    - name: "Average Vendor Unit Price"
      expr: AVG(vendor_unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Receipt business metrics"
  source: "`vibe_construction_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Completed Flag"
      expr: delivery_completed_flag
    - name: "Delivery Note Number"
      expr: delivery_note_number
    - name: "Gr Document Number"
      expr: gr_document_number
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Invoice Verification Status"
      expr: invoice_verification_status
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Movement Type"
      expr: movement_type
    - name: "Posting Date"
      expr: posting_date
    - name: "Receipt Condition"
      expr: receipt_condition
    - name: "Receipt Date"
      expr: receipt_date
    - name: "Receipt Timestamp"
      expr: receipt_timestamp
    - name: "Reversal Document Number"
      expr: reversal_document_number
    - name: "Reversal Flag"
      expr: reversal_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Receipt"
      expr: COUNT(DISTINCT goods_receipt_id)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Received Quantity"
      expr: SUM(received_quantity)
    - name: "Average Received Quantity"
      expr: AVG(received_quantity)
    - name: "Total Rejected Quantity"
      expr: SUM(rejected_quantity)
    - name: "Average Rejected Quantity"
      expr: AVG(rejected_quantity)
    - name: "Total Total Value"
      expr: SUM(total_value)
    - name: "Average Total Value"
      expr: AVG(total_value)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_material_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Catalog business metrics"
  source: "`vibe_construction_v1`.`procurement`.`material_catalog`"
  dimensions:
    - name: "Abc Classification"
      expr: abc_classification
    - name: "Alternative Unit Of Measure"
      expr: alternative_unit_of_measure
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Bim Object Reference"
      expr: bim_object_reference
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Date"
      expr: created_date
    - name: "Customs Tariff Number"
      expr: customs_tariff_number
    - name: "Dimension Unit"
      expr: dimension_unit
    - name: "Environmental Certification"
      expr: environmental_certification
    - name: "Hazard Class"
      expr: hazard_class
    - name: "Hazardous Material Indicator"
      expr: hazardous_material_indicator
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Manufacturer Name"
      expr: manufacturer_name
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Catalog"
      expr: COUNT(DISTINCT material_catalog_id)
    - name: "Total Gross Weight"
      expr: SUM(gross_weight)
    - name: "Average Gross Weight"
      expr: AVG(gross_weight)
    - name: "Total Height"
      expr: SUM(height)
    - name: "Average Height"
      expr: AVG(height)
    - name: "Total Length"
      expr: SUM(length)
    - name: "Average Length"
      expr: AVG(length)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Net Weight"
      expr: SUM(net_weight)
    - name: "Average Net Weight"
      expr: AVG(net_weight)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Volume"
      expr: SUM(volume)
    - name: "Average Volume"
      expr: AVG(volume)
    - name: "Total Width"
      expr: SUM(width)
    - name: "Average Width"
      expr: AVG(width)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Po Line business metrics"
  source: "`vibe_construction_v1`.`procurement`.`po_line`"
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
    - name: "Free Text Note"
      expr: free_text_note
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
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Po Line"
      expr: COUNT(DISTINCT po_line_id)
    - name: "Total Goods Receipt Quantity"
      expr: SUM(goods_receipt_quantity)
    - name: "Average Goods Receipt Quantity"
      expr: AVG(goods_receipt_quantity)
    - name: "Total Invoiced Quantity"
      expr: SUM(invoiced_quantity)
    - name: "Average Invoiced Quantity"
      expr: AVG(invoiced_quantity)
    - name: "Total Net Value"
      expr: SUM(net_value)
    - name: "Average Net Value"
      expr: AVG(net_value)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Outstanding Quantity"
      expr: SUM(outstanding_quantity)
    - name: "Average Outstanding Quantity"
      expr: AVG(outstanding_quantity)
    - name: "Total Over Delivery Tolerance Percent"
      expr: SUM(over_delivery_tolerance_percent)
    - name: "Average Over Delivery Tolerance Percent"
      expr: AVG(over_delivery_tolerance_percent)
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

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Order business metrics"
  source: "`vibe_construction_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Buyer Name"
      expr: buyer_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Revision Number"
      expr: current_revision_number
    - name: "Current Version Number"
      expr: current_version_number
    - name: "Delivery Address Line1"
      expr: delivery_address_line1
    - name: "Delivery Address Line2"
      expr: delivery_address_line2
    - name: "Delivery City"
      expr: delivery_city
    - name: "Delivery Country Code"
      expr: delivery_country_code
    - name: "Delivery Postal Code"
      expr: delivery_postal_code
    - name: "Delivery State Province"
      expr: delivery_state_province
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order"
      expr: COUNT(DISTINCT purchase_order_id)
    - name: "Total Cumulative Amendment Value"
      expr: SUM(cumulative_amendment_value)
    - name: "Average Cumulative Amendment Value"
      expr: AVG(cumulative_amendment_value)
    - name: "Total Gmp Amount"
      expr: SUM(gmp_amount)
    - name: "Average Gmp Amount"
      expr: AVG(gmp_amount)
    - name: "Total Original Po Value"
      expr: SUM(original_po_value)
    - name: "Average Original Po Value"
      expr: AVG(original_po_value)
    - name: "Total Retention Amount"
      expr: SUM(retention_amount)
    - name: "Average Retention Amount"
      expr: AVG(retention_amount)
    - name: "Total Retention Percentage"
      expr: SUM(retention_percentage)
    - name: "Average Retention Percentage"
      expr: AVG(retention_percentage)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Po Value"
      expr: SUM(total_po_value)
    - name: "Average Total Po Value"
      expr: AVG(total_po_value)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rfq business metrics"
  source: "`vibe_construction_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "Award Date"
      expr: award_date
    - name: "Bid Bond Required"
      expr: bid_bond_required
    - name: "Boq Reference"
      expr: boq_reference
    - name: "Buyer Contact Email"
      expr: buyer_contact_email
    - name: "Buyer Contact Name"
      expr: buyer_contact_name
    - name: "Buyer Contact Phone"
      expr: buyer_contact_phone
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Evaluation Criteria"
      expr: evaluation_criteria
    - name: "Hse Requirements"
      expr: hse_requirements
    - name: "Incoterms"
      expr: incoterms
    - name: "Invited Vendor Count"
      expr: invited_vendor_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rfq"
      expr: COUNT(DISTINCT rfq_id)
    - name: "Total Awarded Amount"
      expr: SUM(awarded_amount)
    - name: "Average Awarded Amount"
      expr: AVG(awarded_amount)
    - name: "Total Bid Bond Amount"
      expr: SUM(bid_bond_amount)
    - name: "Average Bid Bond Amount"
      expr: AVG(bid_bond_amount)
    - name: "Total Retention Percentage"
      expr: SUM(retention_percentage)
    - name: "Average Retention Percentage"
      expr: AVG(retention_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor business metrics"
  source: "`vibe_construction_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "Account Number"
      expr: account_number
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Result"
      expr: audit_result
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Name"
      expr: bank_name
    - name: "Bank Routing Number"
      expr: bank_routing_number
    - name: "City"
      expr: city
    - name: "Classification"
      expr: classification
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Currency Code"
      expr: currency_code
    - name: "Diversity Classification"
      expr: diversity_classification
    - name: "Duns Number"
      expr: duns_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor"
      expr: COUNT(DISTINCT vendor_id)
    - name: "Total Annual Revenue Amount"
      expr: SUM(annual_revenue_amount)
    - name: "Average Annual Revenue Amount"
      expr: AVG(annual_revenue_amount)
    - name: "Total Bonding Capacity Amount"
      expr: SUM(bonding_capacity_amount)
    - name: "Average Bonding Capacity Amount"
      expr: AVG(bonding_capacity_amount)
    - name: "Total Prequalification Score"
      expr: SUM(prequalification_score)
    - name: "Average Prequalification Score"
      expr: AVG(prequalification_score)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Invoice business metrics"
  source: "`vibe_construction_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Blocked Reason"
      expr: blocked_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Description"
      expr: invoice_description
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Received Date"
      expr: invoice_received_date
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Invoice Type"
      expr: invoice_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Invoice"
      expr: COUNT(DISTINCT vendor_invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Invoice Gross Amount"
      expr: SUM(invoice_gross_amount)
    - name: "Average Invoice Gross Amount"
      expr: AVG(invoice_gross_amount)
    - name: "Total Invoice Net Amount"
      expr: SUM(invoice_net_amount)
    - name: "Average Invoice Net Amount"
      expr: AVG(invoice_net_amount)
    - name: "Total Retention Amount"
      expr: SUM(retention_amount)
    - name: "Average Retention Amount"
      expr: AVG(retention_amount)
    - name: "Total Retention Percentage"
      expr: SUM(retention_percentage)
    - name: "Average Retention Percentage"
      expr: AVG(retention_percentage)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Qualification business metrics"
  source: "`vibe_construction_v1`.`procurement`.`vendor_qualification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved Material Categories"
      expr: approved_material_categories
    - name: "Bonding Capacity Currency"
      expr: bonding_capacity_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Geographic Coverage"
      expr: geographic_coverage
    - name: "Hse Performance Rating"
      expr: hse_performance_rating
    - name: "Insurance Certificate Expiry Date"
      expr: insurance_certificate_expiry_date
    - name: "Insurance Workers Comp Verified"
      expr: insurance_workers_comp_verified
    - name: "Iso 14001 Certificate Number"
      expr: iso_14001_certificate_number
    - name: "Iso 14001 Certified"
      expr: iso_14001_certified
    - name: "Iso 14001 Expiry Date"
      expr: iso_14001_expiry_date
    - name: "Iso 45001 Certificate Number"
      expr: iso_45001_certificate_number
    - name: "Iso 45001 Certified"
      expr: iso_45001_certified
    - name: "Iso 45001 Expiry Date"
      expr: iso_45001_expiry_date
    - name: "Iso 9001 Certificate Number"
      expr: iso_9001_certificate_number
    - name: "Iso 9001 Certified"
      expr: iso_9001_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Qualification"
      expr: COUNT(DISTINCT vendor_qualification_id)
    - name: "Total Bonding Capacity Limit"
      expr: SUM(bonding_capacity_limit)
    - name: "Average Bonding Capacity Limit"
      expr: AVG(bonding_capacity_limit)
    - name: "Total Financial Health Score"
      expr: SUM(financial_health_score)
    - name: "Average Financial Health Score"
      expr: AVG(financial_health_score)
    - name: "Total Insurance General Liability Limit"
      expr: SUM(insurance_general_liability_limit)
    - name: "Average Insurance General Liability Limit"
      expr: AVG(insurance_general_liability_limit)
    - name: "Total Lti Frequency Rate"
      expr: SUM(lti_frequency_rate)
    - name: "Average Lti Frequency Rate"
      expr: AVG(lti_frequency_rate)
    - name: "Total On Time Delivery Rate"
      expr: SUM(on_time_delivery_rate)
    - name: "Average On Time Delivery Rate"
      expr: AVG(on_time_delivery_rate)
    - name: "Total Past Performance Score"
      expr: SUM(past_performance_score)
    - name: "Average Past Performance Score"
      expr: AVG(past_performance_score)
    - name: "Total Quality Defect Rate"
      expr: SUM(quality_defect_rate)
    - name: "Average Quality Defect Rate"
      expr: AVG(quality_defect_rate)
    - name: "Total Technical Capability Score"
      expr: SUM(technical_capability_score)
    - name: "Average Technical Capability Score"
      expr: AVG(technical_capability_score)
    - name: "Total Trir Rate"
      expr: SUM(trir_rate)
    - name: "Average Trir Rate"
      expr: AVG(trir_rate)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Quotation business metrics"
  source: "`vibe_construction_v1`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "Attachment Count"
      expr: attachment_count
    - name: "Award Recommendation"
      expr: award_recommendation
    - name: "Commercial Exceptions"
      expr: commercial_exceptions
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Lead Time Days"
      expr: delivery_lead_time_days
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Deviations From Specification"
      expr: deviations_from_specification
    - name: "Evaluation Date"
      expr: evaluation_date
    - name: "Evaluation Notes"
      expr: evaluation_notes
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Material Description"
      expr: material_description
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Quotation Number"
      expr: quotation_number
    - name: "Quotation Status"
      expr: quotation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Quotation"
      expr: COUNT(DISTINCT vendor_quotation_id)
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
    - name: "Total Quoted Quantity"
      expr: SUM(quoted_quantity)
    - name: "Average Quoted Quantity"
      expr: AVG(quoted_quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Price"
      expr: SUM(total_price)
    - name: "Average Total Price"
      expr: AVG(total_price)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;