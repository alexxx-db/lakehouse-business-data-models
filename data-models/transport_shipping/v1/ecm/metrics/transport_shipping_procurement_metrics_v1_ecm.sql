-- Metric views for domain: procurement | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement metrics for purchase order management including spend analysis, order efficiency, and procurement cycle performance."
  source: "`transport_shipping_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (open, closed, cancelled, etc.)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket release, service, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the purchase order"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Category classification of the procurement spend"
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of expenditure (OPEX vs CAPEX classification)"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery responsibility"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipping for the purchase order"
    - name: "priority"
      expr: priority
      comment: "Priority level of the purchase order"
    - name: "po_year_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month in which the purchase order was created"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center charged for the purchase order"
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders for volume tracking"
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross purchase order spend including tax"
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net purchase order spend excluding tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value indicating typical order size"
    - name: "cancelled_po_count"
      expr: COUNT(CASE WHEN po_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled purchase orders indicating procurement inefficiency"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers engaged, indicating supply base diversity"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard metrics for evaluating delivery reliability, quality, and overall supplier health across the logistics network."
  source: "`transport_shipping_ecm`.`procurement`.`supplier_performance`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the supplier evaluation (draft, published, approved)"
    - name: "evaluation_cycle_type"
      expr: evaluation_cycle_type
      comment: "Frequency of evaluation cycle (monthly, quarterly, annual)"
    - name: "overall_scorecard_grade"
      expr: overall_scorecard_grade
      comment: "Letter grade assigned to supplier overall performance"
    - name: "supplier_tier"
      expr: supplier_tier
      comment: "Strategic tier classification of the supplier"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the supplier based on performance"
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "Sustainability performance rating of the supplier"
    - name: "renewal_recommendation"
      expr: renewal_recommendation
      comment: "Recommendation on whether to renew the supplier contract"
    - name: "preferred_supplier_flag"
      expr: CAST(preferred_supplier_flag AS STRING)
      comment: "Whether the supplier holds preferred status"
    - name: "evaluation_period_start"
      expr: DATE_TRUNC('quarter', evaluation_period_start_date)
      comment: "Quarter of evaluation period start for trend analysis"
  measures:
    - name: "evaluated_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers evaluated in the period"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score across evaluations"
    - name: "avg_otd_rate"
      expr: AVG(CAST(otd_rate AS DOUBLE))
      comment: "Average on-time delivery rate across suppliers - critical for logistics reliability"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate indicating goods quality from suppliers"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate indicating billing reliability"
    - name: "avg_sla_compliance_score"
      expr: AVG(CAST(sla_compliance_score AS DOUBLE))
      comment: "Average SLA compliance score measuring contractual adherence"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score measuring supplier communication quality"
    - name: "total_order_value_evaluated"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total order value under evaluation for spend-weighted performance analysis"
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of supplier evaluations conducted"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt metrics tracking inbound material quality, delivery accuracy, and receiving efficiency for supply chain operations."
  source: "`transport_shipping_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (posted, reversed, blocked)"
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of goods receipt (standard, return, free goods)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO-GR-Invoice three-way match for payment processing"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received goods"
    - name: "storage_location"
      expr: storage_location
      comment: "Warehouse storage location where goods were received"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt for trend analysis"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for rejected goods to identify quality issues"
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the goods receipt record"
    - name: "match_tolerance_exceeded_flag"
      expr: CAST(match_tolerance_exceeded_flag AS STRING)
      comment: "Whether the receipt exceeded matching tolerance thresholds"
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity of goods accepted after inspection"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of goods rejected indicating supplier quality issues"
    - name: "total_receipt_value"
      expr: SUM(CAST(receipt_value_amount AS DOUBLE))
      comment: "Total monetary value of goods received"
    - name: "avg_receipt_value"
      expr: AVG(CAST(receipt_value_amount AS DOUBLE))
      comment: "Average value per goods receipt transaction"
    - name: "receipts_with_rejections"
      expr: COUNT(CASE WHEN rejected_quantity > 0 THEN 1 END)
      comment: "Number of receipts that had rejected quantities indicating quality failures"
    - name: "tolerance_exceeded_count"
      expr: COUNT(CASE WHEN match_tolerance_exceeded_flag = true THEN 1 END)
      comment: "Number of receipts exceeding match tolerance requiring investigation"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier invoice metrics for accounts payable management, payment efficiency, and invoice processing performance."
  source: "`transport_shipping_ecm`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the supplier invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status between PO, GR, and invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment for the invoice"
    - name: "submission_method"
      expr: submission_method
      comment: "How the invoice was submitted (EDI, portal, email, paper)"
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the invoice is in dispute"
    - name: "match_exception_type"
      expr: match_exception_type
      comment: "Type of matching exception encountered during processing"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice for period analysis"
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction applicable to the invoice"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices processed"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and withholding"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount payable"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured indicating AP efficiency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on supplier invoices"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments"
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = true THEN 1 END)
      comment: "Number of invoices in dispute requiring resolution"
    - name: "match_exception_count"
      expr: COUNT(CASE WHEN match_exception_type IS NOT NULL AND match_exception_type != '' THEN 1 END)
      comment: "Number of invoices with matching exceptions requiring manual intervention"
    - name: "total_match_exception_amount"
      expr: SUM(CAST(match_exception_amount AS DOUBLE))
      comment: "Total monetary value of matching exceptions indicating process gaps"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers invoicing in the period"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement contract portfolio metrics for managing contract value, compliance, and supplier relationship governance."
  source: "`transport_shipping_ecm`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the procurement contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of procurement contract (framework, spot, service, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the contract"
    - name: "procurement_contract_category"
      expr: procurement_contract_category
      comment: "Category of procurement the contract covers"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the contract"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed in the contract"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for delivery"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the contract"
    - name: "auto_renewal_flag"
      expr: CAST(auto_renewal_flag AS STRING)
      comment: "Whether the contract auto-renews"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the contract"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts in portfolio"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed contract value across the portfolio"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value indicating typical commitment size"
    - name: "max_order_value_capacity"
      expr: SUM(CAST(maximum_order_value AS DOUBLE))
      comment: "Total maximum order value capacity across contracts"
    - name: "min_order_value_floor"
      expr: SUM(CAST(minimum_order_value AS DOUBLE))
      comment: "Total minimum order value commitments across contracts"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers under contract"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers under contract for logistics services"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-level metrics for detailed spend analysis, delivery performance tracking, and procurement fulfillment monitoring."
  source: "`transport_shipping_ecm`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line item"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category for spend categorization"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered item"
    - name: "incoterm"
      expr: incoterm
      comment: "Delivery terms for the line item"
    - name: "is_capital_expenditure"
      expr: CAST(is_capital_expenditure AS STRING)
      comment: "Whether the line is capital expenditure vs operating expense"
    - name: "is_services"
      expr: CAST(is_services AS STRING)
      comment: "Whether the line is for services vs goods"
    - name: "payment_term_code"
      expr: payment_term_code
      comment: "Payment terms applicable to the line"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of PO line items"
    - name: "total_line_spend"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total spend across all PO lines"
    - name: "total_net_line_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount across PO lines excluding tax"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines"
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced against PO lines"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts negotiated on PO lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines for price benchmarking"
    - name: "open_lines_count"
      expr: COUNT(CASE WHEN line_status = 'Open' THEN 1 END)
      comment: "Number of open PO lines pending fulfillment"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers across PO lines"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition metrics for demand pipeline visibility, budget compliance, and procurement cycle time analysis."
  source: "`transport_shipping_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the purchase requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (standard, urgent, blanket)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition"
    - name: "budget_check_status"
      expr: budget_check_status
      comment: "Budget availability check result"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition"
    - name: "is_capital_expenditure"
      expr: CAST(is_capital_expenditure AS STRING)
      comment: "Whether the requisition is for capital expenditure"
    - name: "conversion_outcome"
      expr: conversion_outcome
      comment: "Outcome of requisition-to-PO conversion process"
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for the requisition"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the requisition was created for trend analysis"
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions submitted"
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_total_amount AS DOUBLE))
      comment: "Total estimated spend in the requisition pipeline"
    - name: "avg_requisition_value"
      expr: AVG(CAST(estimated_total_amount AS DOUBLE))
      comment: "Average requisition value indicating typical demand size"
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions"
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected requisitions indicating demand governance"
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN requisition_status = 'Pending Approval' THEN 1 END)
      comment: "Number of requisitions awaiting approval indicating bottlenecks"
    - name: "distinct_requestor_count"
      expr: COUNT(DISTINCT requestor_employee_id)
      comment: "Number of unique requestors generating procurement demand"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quotation metrics for sourcing effectiveness, competitive bidding analysis, and supplier engagement tracking."
  source: "`transport_shipping_ecm`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ process"
    - name: "rfq_category"
      expr: rfq_category
      comment: "Category of goods/services being sourced"
    - name: "sourcing_event_type"
      expr: sourcing_event_type
      comment: "Type of sourcing event (RFQ, RFP, reverse auction)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for the RFQ"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the sourcing event"
    - name: "issuing_business_unit"
      expr: issuing_business_unit
      comment: "Business unit issuing the RFQ"
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the RFQ was issued for pipeline analysis"
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued"
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_spend_amount AS DOUBLE))
      comment: "Total estimated spend under competitive sourcing"
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value of awarded RFQs"
    - name: "avg_estimated_spend"
      expr: AVG(CAST(estimated_spend_amount AS DOUBLE))
      comment: "Average estimated spend per RFQ indicating sourcing scale"
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs that resulted in supplier awards"
    - name: "cancelled_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled RFQs indicating sourcing process issues"
    - name: "distinct_awarded_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers awarded contracts through competitive bidding"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_rate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate agreement metrics for freight and logistics rate management, volume commitment tracking, and carrier cost optimization."
  source: "`transport_shipping_ecm`.`procurement`.`rate_agreement`"
  dimensions:
    - name: "rate_agreement_status"
      expr: rate_agreement_status
      comment: "Current status of the rate agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of rate agreement (spot, contract, tender)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport covered by the agreement (ocean, air, road, rail)"
    - name: "service_type"
      expr: service_type
      comment: "Type of logistics service covered"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate agreement"
    - name: "fuel_surcharge_type"
      expr: fuel_surcharge_type
      comment: "Type of fuel surcharge mechanism applied"
    - name: "rate_unit_of_measure"
      expr: rate_unit_of_measure
      comment: "Unit of measure for the rate (per kg, per TEU, per pallet)"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location for the rate lane"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location for the rate lane"
    - name: "valid_from_month"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month the rate agreement becomes effective"
  measures:
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of rate agreements in the portfolio"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across agreements for cost benchmarking"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment_quantity AS DOUBLE))
      comment: "Total volume committed across all rate agreements"
    - name: "total_fuel_surcharge_value"
      expr: SUM(CAST(fuel_surcharge_value AS DOUBLE))
      comment: "Total fuel surcharge value across agreements"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge across agreements"
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum charge cap across agreements"
    - name: "total_documentation_fees"
      expr: SUM(CAST(documentation_fee AS DOUBLE))
      comment: "Total documentation fees across rate agreements"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with rate agreements"
$$;
