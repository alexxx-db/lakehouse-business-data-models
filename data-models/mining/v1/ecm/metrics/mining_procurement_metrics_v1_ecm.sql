-- Metric views for domain: procurement | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core procurement purchase order metrics tracking order value, approval cycle time, and order volume by purchasing organization, vendor, and status"
  source: "`mining_ecm`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status (e.g., approved, pending, cancelled)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization code"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group responsible for the order"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the purchase order"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the purchase order"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year of purchase order creation"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of purchase order creation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for order values"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of all purchase orders"
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of purchase orders excluding tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "po_count"
      expr: COUNT(DISTINCT procurement_purchase_order_id)
      comment: "Number of distinct purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "vendor_count"
      expr: COUNT(DISTINCT procurement_vendor_id)
      comment: "Number of distinct vendors with purchase orders"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt metrics tracking received quantities, quality inspection rates, and receipt cycle time for procurement operations"
  source: "`mining_ecm`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of inventory movement"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g., unrestricted, quality inspection)"
    - name: "quality_inspection_required"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection is required"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the goods receipt was reversed"
    - name: "receipt_year"
      expr: YEAR(received_date)
      comment: "Year of goods receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month of goods receipt"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for valuation"
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity originally ordered"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of goods received"
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight AS DOUBLE))
      comment: "Total gross weight of goods received"
    - name: "total_net_weight"
      expr: SUM(CAST(net_weight AS DOUBLE))
      comment: "Total net weight of goods received"
    - name: "goods_receipt_count"
      expr: COUNT(DISTINCT procurement_goods_receipt_id)
      comment: "Number of distinct goods receipts"
    - name: "quality_inspection_count"
      expr: SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of goods receipts requiring quality inspection"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversed goods receipts"
    - name: "vendor_count"
      expr: COUNT(DISTINCT procurement_vendor_id)
      comment: "Number of distinct vendors with goods receipts"
    - name: "material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials received"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance metrics tracking quality, delivery, price performance, and overall vendor ratings for supplier management"
  source: "`mining_ecm`.`procurement`.`procurement_vendor_performance`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating category"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the performance evaluation"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category being evaluated"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to vendor"
    - name: "preferred_vendor"
      expr: preferred_vendor_flag
      comment: "Whether vendor is marked as preferred"
    - name: "corrective_action_required"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year of performance evaluation"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of performance evaluation"
  measures:
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across vendors"
    - name: "avg_quality_performance_score"
      expr: AVG(CAST(quality_performance_score AS DOUBLE))
      comment: "Average quality performance score"
    - name: "avg_delivery_performance_score"
      expr: AVG(CAST(delivery_performance_score AS DOUBLE))
      comment: "Average delivery performance score"
    - name: "avg_price_performance_score"
      expr: AVG(CAST(price_performance_score AS DOUBLE))
      comment: "Average price performance score"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on-time delivery rate percentage"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate_percent AS DOUBLE))
      comment: "Average quality acceptance rate percentage"
    - name: "avg_rejection_rate"
      expr: AVG(CAST(rejection_rate_percent AS DOUBLE))
      comment: "Average rejection rate percentage"
    - name: "total_procurement_value"
      expr: SUM(CAST(total_procurement_value AS DOUBLE))
      comment: "Total procurement value across all vendor evaluations"
    - name: "total_ncr_count"
      expr: SUM(CAST(ncr_count AS BIGINT))
      comment: "Total number of non-conformance reports"
    - name: "total_hse_incident_count"
      expr: SUM(CAST(hse_incident_count AS BIGINT))
      comment: "Total number of health, safety, and environment incidents"
    - name: "vendor_evaluation_count"
      expr: COUNT(DISTINCT procurement_vendor_performance_id)
      comment: "Number of distinct vendor performance evaluations"
    - name: "vendor_count"
      expr: COUNT(DISTINCT procurement_vendor_id)
      comment: "Number of distinct vendors evaluated"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory balance metrics tracking stock levels, stock value, variance, and accuracy for warehouse and materials management"
  source: "`mining_ecm`.`procurement`.`inventory_balance`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Status of the stock"
    - name: "material_code"
      expr: material_code
      comment: "Material code"
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location code"
    - name: "count_frequency_category"
      expr: count_frequency_category
      comment: "Frequency category for cycle counting"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Whether a recount was required"
    - name: "snapshot_year"
      expr: YEAR(snapshot_timestamp)
      comment: "Year of inventory snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of inventory snapshot"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for stock valuation"
  measures:
    - name: "total_unrestricted_stock"
      expr: SUM(CAST(unrestricted_stock_quantity AS DOUBLE))
      comment: "Total unrestricted stock quantity available for use"
    - name: "total_blocked_stock"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total blocked stock quantity"
    - name: "total_quality_inspection_stock"
      expr: SUM(CAST(quality_inspection_stock_quantity AS DOUBLE))
      comment: "Total stock quantity in quality inspection"
    - name: "total_in_transit_stock"
      expr: SUM(CAST(in_transit_stock_quantity AS DOUBLE))
      comment: "Total stock quantity in transit"
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of all inventory"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity between system and physical count"
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total variance value between system and physical count"
    - name: "avg_stock_accuracy"
      expr: AVG(CAST(stock_accuracy_percentage AS DOUBLE))
      comment: "Average stock accuracy percentage"
    - name: "inventory_balance_count"
      expr: COUNT(DISTINCT inventory_balance_id)
      comment: "Number of distinct inventory balance records"
    - name: "material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials in inventory"
    - name: "warehouse_location_count"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of distinct warehouse locations"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing event metrics tracking procurement savings, vendor participation, and sourcing effectiveness for strategic procurement"
  source: "`mining_ecm`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Status of the sourcing event"
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g., RFQ, RFP, auction)"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category being sourced"
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance level of the sourcing event"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the sourcing event"
    - name: "purchasing_organisation"
      expr: purchasing_organisation
      comment: "Purchasing organization conducting the event"
    - name: "event_year"
      expr: YEAR(publication_date)
      comment: "Year of sourcing event publication"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month of sourcing event publication"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for sourcing values"
  measures:
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Total baseline value before sourcing"
    - name: "total_awarded_value"
      expr: SUM(CAST(awarded_value AS DOUBLE))
      comment: "Total awarded value after sourcing"
    - name: "total_savings_achieved"
      expr: SUM(CAST(savings_achieved AS DOUBLE))
      comment: "Total savings achieved through sourcing events"
    - name: "avg_savings_percentage"
      expr: AVG(CAST(savings_percentage AS DOUBLE))
      comment: "Average savings percentage across sourcing events"
    - name: "total_estimated_annual_spend"
      expr: SUM(CAST(estimated_annual_spend AS DOUBLE))
      comment: "Total estimated annual spend for sourced categories"
    - name: "total_vendors_invited"
      expr: SUM(CAST(vendors_invited_count AS BIGINT))
      comment: "Total number of vendors invited across all events"
    - name: "total_vendors_responded"
      expr: SUM(CAST(vendors_responded_count AS BIGINT))
      comment: "Total number of vendors who responded"
    - name: "sourcing_event_count"
      expr: COUNT(DISTINCT sourcing_event_id)
      comment: "Number of distinct sourcing events"
    - name: "avg_price_weighting"
      expr: AVG(CAST(price_weighting_percent AS DOUBLE))
      comment: "Average price weighting percentage in evaluation"
    - name: "avg_quality_weighting"
      expr: AVG(CAST(quality_weighting_percent AS DOUBLE))
      comment: "Average quality weighting percentage in evaluation"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment metrics tracking contract changes, value deltas, and amendment approval cycle time for contract management"
  source: "`mining_ecm`.`procurement`.`contract_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Status of the contract amendment"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g., value change, term extension)"
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the amendment"
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required for approval"
    - name: "legal_review_required"
      expr: legal_review_required_flag
      comment: "Whether legal review is required"
    - name: "vendor_acceptance_required"
      expr: vendor_acceptance_required_flag
      comment: "Whether vendor acceptance is required"
    - name: "amendment_year"
      expr: YEAR(amendment_date)
      comment: "Year of amendment"
    - name: "amendment_month"
      expr: DATE_TRUNC('MONTH', amendment_date)
      comment: "Month of amendment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for amendment values"
  measures:
    - name: "total_amendment_value_delta"
      expr: SUM(CAST(amendment_value_delta AS DOUBLE))
      comment: "Total value change across all amendments"
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Total original contract value before amendments"
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised contract value after amendments"
    - name: "total_quantity_delta"
      expr: SUM(CAST(quantity_delta AS DOUBLE))
      comment: "Total quantity change across amendments"
    - name: "amendment_count"
      expr: COUNT(DISTINCT contract_amendment_id)
      comment: "Number of distinct contract amendments"
    - name: "contract_count"
      expr: COUNT(DISTINCT procurement_contract_id)
      comment: "Number of distinct contracts with amendments"
    - name: "avg_amendment_value_delta"
      expr: AVG(CAST(amendment_value_delta AS DOUBLE))
      comment: "Average value change per amendment"
    - name: "legal_review_count"
      expr: SUM(CASE WHEN legal_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of amendments requiring legal review"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_outbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound shipment metrics tracking shipped tonnage, freight costs, demurrage, and shipment performance for logistics and sales fulfillment"
  source: "`mining_ecm`.`procurement`.`outbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Status of the outbound shipment"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code"
    - name: "destination_port_code"
      expr: destination_port_code
      comment: "Destination port code"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for the shipment"
    - name: "vessel_name"
      expr: vessel_name
      comment: "Name of the vessel"
    - name: "shipment_year"
      expr: YEAR(actual_departure_date)
      comment: "Year of shipment departure"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', actual_departure_date)
      comment: "Month of shipment departure"
    - name: "freight_currency_code"
      expr: freight_currency_code
      comment: "Currency code for freight costs"
  measures:
    - name: "total_loaded_quantity_tonnes"
      expr: SUM(CAST(loaded_quantity_tonnes AS DOUBLE))
      comment: "Total loaded quantity in tonnes"
    - name: "total_nominated_quantity_tonnes"
      expr: SUM(CAST(nominated_quantity_tonnes AS DOUBLE))
      comment: "Total nominated quantity in tonnes"
    - name: "total_quantity_variance_tonnes"
      expr: SUM(CAST(quantity_variance_tonnes AS DOUBLE))
      comment: "Total quantity variance in tonnes"
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments"
    - name: "total_demurrage_cost"
      expr: SUM(CAST(demurrage_cost AS DOUBLE))
      comment: "Total demurrage cost incurred"
    - name: "total_demurrage_days"
      expr: SUM(CAST(demurrage_days AS DOUBLE))
      comment: "Total demurrage days across shipments"
    - name: "avg_freight_rate_per_tonne"
      expr: AVG(CAST(freight_rate_per_tonne AS DOUBLE))
      comment: "Average freight rate per tonne"
    - name: "avg_grade_percent"
      expr: AVG(CAST(average_grade_percent AS DOUBLE))
      comment: "Average grade percentage of shipped material"
    - name: "avg_moisture_content_percent"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content percentage"
    - name: "shipment_count"
      expr: COUNT(DISTINCT outbound_shipment_id)
      comment: "Number of distinct outbound shipments"
    - name: "customer_count"
      expr: COUNT(DISTINCT counterparty_id)
      comment: "Number of distinct customers receiving shipments"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition metrics tracking requisition volume, value, approval cycle time, and conversion to purchase orders"
  source: "`mining_ecm`.`procurement`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition"
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Approval workflow status"
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of conversion to purchase order"
    - name: "priority_indicator"
      expr: priority_indicator
      comment: "Priority level of the requisition"
    - name: "material_group"
      expr: material_group
      comment: "Material group for the requisition"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group handling the requisition"
    - name: "requisition_year"
      expr: YEAR(requisition_date)
      comment: "Year of requisition creation"
    - name: "requisition_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month of requisition creation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for estimated value"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all requisitions"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity requisitioned"
    - name: "requisition_count"
      expr: COUNT(DISTINCT requisition_id)
      comment: "Number of distinct requisitions"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per requisition"
    - name: "requisitioner_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees creating requisitions"
    - name: "material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials requisitioned"
    - name: "vendor_count"
      expr: COUNT(DISTINCT procurement_vendor_id)
      comment: "Number of distinct vendors specified in requisitions"
$$;
