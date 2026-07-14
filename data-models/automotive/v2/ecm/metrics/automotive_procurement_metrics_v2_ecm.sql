-- Metric views for domain: procurement | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order KPIs tracking order value, volume, cycle time, and approval efficiency across plants, suppliers, and programs"
  source: "`vibe_automotive_v1`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the purchase order was created"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the purchase order was created"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, subcontracting, consignment, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the purchase order"
    - name: "po_status"
      expr: procurement_purchase_order_status
      comment: "Current status of the purchase order (open, closed, blocked, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order"
    - name: "purchase_group"
      expr: purchase_group
      comment: "Purchasing group handling the order"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery and risk transfer"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with supplier"
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "total_po_net_value"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of all purchase orders"
    - name: "total_po_gross_value"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all purchase orders including tax"
    - name: "total_po_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "avg_po_net_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per purchase order"
    - name: "total_po_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity ordered across all purchase orders"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers with purchase orders"
    - name: "distinct_plant_count"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of unique plants receiving purchase orders"
    - name: "avg_currency_rate"
      expr: AVG(CAST(currency_rate AS DOUBLE))
      comment: "Average currency exchange rate applied to purchase orders"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_spend_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend analytics KPIs tracking procurement expenditure, payment performance, and spend distribution across categories, suppliers, and cost centers"
  source: "`vibe_automotive_v1`.`procurement`.`spend_transaction`"
  dimensions:
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year the spend transaction occurred"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month the spend transaction occurred"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction"
    - name: "spend_category"
      expr: spend_category
      comment: "Primary spend category classification"
    - name: "spend_subcategory"
      expr: spend_subcategory
      comment: "Detailed spend subcategory"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for the purchased item or service"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the spend transaction"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the spend transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms applied to the transaction"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center charged for the spend"
    - name: "is_service_line"
      expr: is_service_line
      comment: "Flag indicating whether transaction is for services vs goods"
    - name: "is_blocked"
      expr: is_blocked
      comment: "Flag indicating whether transaction is blocked for payment"
  measures:
    - name: "total_spend_transactions"
      expr: COUNT(1)
      comment: "Total number of spend transactions"
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross spend amount before tax"
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend amount after discounts"
    - name: "total_tax_spend"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount paid on spend transactions"
    - name: "avg_transaction_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per spend transaction"
    - name: "total_quantity_purchased"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items or services purchased"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all spend transactions"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers in spend transactions"
    - name: "distinct_plant_count"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of unique plants with spend transactions"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of unique SKUs purchased"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average currency exchange rate applied to transactions"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier invoice KPIs tracking invoice processing, payment performance, matching accuracy, and accounts payable efficiency"
  source: "`vibe_automotive_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year the invoice was posted to accounting"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the invoice was posted to accounting"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo, etc.)"
    - name: "invoice_status"
      expr: supplier_invoice_status
      comment: "Current status of the invoice (pending, posted, paid, blocked, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (wire, check, ACH, etc.)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match between PO, goods receipt, and invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason invoice is blocked for payment, if applicable"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating whether invoice is tax-exempt"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices"
    - name: "total_invoice_gross_value"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all invoices"
    - name: "total_invoice_net_value"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of all invoices after discounts"
    - name: "total_invoice_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount taken on invoices"
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per invoice"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to invoices"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average currency exchange rate applied to invoices"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers with invoices"
    - name: "distinct_cost_center_count"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers charged on invoices"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance KPIs tracking quality, delivery, cost, development, and overall supplier scorecard metrics"
  source: "`vibe_automotive_v1`.`procurement`.`supplier_evaluation`"
  dimensions:
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year the supplier evaluation was conducted"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month the supplier evaluation was conducted"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (annual, quarterly, ad-hoc, etc.)"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (draft, approved, published, etc.)"
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used for evaluation (scorecard, audit, survey, etc.)"
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category of supplier being evaluated"
    - name: "supplier_region"
      expr: supplier_region
      comment: "Geographic region of the supplier"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to supplier (low, medium, high, critical)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the supplier"
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended action based on evaluation results"
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of supplier evaluations conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score across suppliers"
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score across suppliers"
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score across suppliers"
    - name: "avg_development_score"
      expr: AVG(CAST(development_score AS DOUBLE))
      comment: "Average supplier development and innovation score"
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across suppliers"
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across suppliers"
    - name: "avg_price_variance_pct"
      expr: AVG(CAST(price_variance_pct AS DOUBLE))
      comment: "Average price variance percentage from target across suppliers"
    - name: "avg_invoice_accuracy_pct"
      expr: AVG(CAST(invoice_accuracy_pct AS DOUBLE))
      comment: "Average invoice accuracy percentage across suppliers"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers evaluated"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract KPIs tracking contract value, coverage, compliance, and lifecycle management across programs and suppliers"
  source: "`vibe_automotive_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (master agreement, purchase agreement, framework, etc.)"
    - name: "contract_category"
      expr: contract_category
      comment: "Category of contract (direct materials, indirect, services, etc.)"
    - name: "contract_status"
      expr: supplier_contract_status
      comment: "Current status of the contract (active, expired, terminated, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which contract value is denominated"
    - name: "is_master_agreement"
      expr: is_master_agreement
      comment: "Flag indicating whether this is a master agreement"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the contract"
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law applicable to the contract"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms specified in the contract"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of supplier contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all supplier contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average value per supplier contract"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment_quantity AS DOUBLE))
      comment: "Total volume commitment quantity across all contracts"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers with active contracts"
    - name: "distinct_vehicle_program_count"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs covered by contracts"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_savings_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement savings KPIs tracking cost reduction initiatives, target vs actual savings, and savings realization across commodities and regions"
  source: "`vibe_automotive_v1`.`procurement`.`savings_initiative`"
  dimensions:
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the savings initiative started"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the savings initiative started"
    - name: "program_year"
      expr: program_year
      comment: "Program year for the savings initiative"
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of savings initiative (sourcing, design, process, etc.)"
    - name: "initiative_status"
      expr: savings_initiative_status
      comment: "Current status of the savings initiative"
    - name: "commodity"
      expr: commodity
      comment: "Commodity targeted by the savings initiative"
    - name: "region_code"
      expr: region_code
      comment: "Region where the savings initiative is implemented"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the savings initiative is implemented"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center benefiting from the savings initiative"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which savings are measured"
    - name: "savings_validation_method"
      expr: savings_validation_method
      comment: "Method used to validate savings realization"
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total number of savings initiatives"
    - name: "total_target_savings"
      expr: SUM(CAST(target_savings_amount AS DOUBLE))
      comment: "Total target savings amount across all initiatives"
    - name: "total_actual_savings"
      expr: SUM(CAST(actual_savings_amount AS DOUBLE))
      comment: "Total actual savings realized across all initiatives"
    - name: "total_baseline_spend"
      expr: SUM(CAST(baseline_spend AS DOUBLE))
      comment: "Total baseline spend before savings initiatives"
    - name: "avg_target_savings"
      expr: AVG(CAST(target_savings_amount AS DOUBLE))
      comment: "Average target savings per initiative"
    - name: "avg_actual_savings"
      expr: AVG(CAST(actual_savings_amount AS DOUBLE))
      comment: "Average actual savings per initiative"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers involved in savings initiatives"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality KPIs tracking nonconformances, defect rates, containment actions, and corrective action effectiveness"
  source: "`vibe_automotive_v1`.`procurement`.`supplier_nonconformance`"
  dimensions:
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year the nonconformance was detected"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the nonconformance was detected"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the nonconformance (critical, major, minor)"
    - name: "defect_code"
      expr: defect_code
      comment: "Code identifying the type of defect"
    - name: "detection_point"
      expr: detection_point
      comment: "Point in the supply chain where nonconformance was detected"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause for the nonconformance"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the nonconformance case"
    - name: "containment_action"
      expr: containment_action
      comment: "Containment action taken to prevent further defects"
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of supplier nonconformances"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of parts rejected due to nonconformances"
    - name: "total_inspected_quantity"
      expr: SUM(CAST(total_inspected_quantity AS DOUBLE))
      comment: "Total quantity of parts inspected"
    - name: "avg_ppm_count"
      expr: AVG(CAST(ppm_count AS DOUBLE))
      comment: "Average parts-per-million defect count across nonconformances"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers with nonconformances"
    - name: "distinct_plant_count"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of unique plants reporting nonconformances"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of unique SKUs with nonconformances"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs tracking receiving volume, quality inspection rates, invoice matching, and receiving efficiency"
  source: "`vibe_automotive_v1`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "receipt_year"
      expr: YEAR(receipt_timestamp)
      comment: "Year the goods were received"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month the goods were received"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year the goods receipt was posted to inventory"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the goods receipt was posted to inventory"
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of goods receipt (PO, return, transfer, etc.)"
    - name: "receipt_status"
      expr: procurement_goods_receipt_status
      comment: "Current status of the goods receipt"
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt"
    - name: "is_quality_inspection_required"
      expr: is_quality_inspection_required
      comment: "Flag indicating whether quality inspection is required"
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Result of quality inspection (passed, failed, pending)"
    - name: "is_blocked_stock"
      expr: is_blocked_stock
      comment: "Flag indicating whether received stock is blocked"
    - name: "invoice_match_status"
      expr: invoice_match_status
      comment: "Status of invoice matching for the goods receipt"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where goods were received"
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location where goods were placed"
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received"
    - name: "total_gross_value"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of goods received"
    - name: "total_net_value"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods received"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods received"
    - name: "avg_receipt_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per goods receipt"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers with goods receipts"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of unique SKUs received"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs tracking requisition volume, approval cycle time, conversion to PO, and procurement demand"
  source: "`vibe_automotive_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "requisition_year"
      expr: YEAR(requisition_date)
      comment: "Year the purchase requisition was created"
    - name: "requisition_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the purchase requisition was created"
    - name: "requisition_status"
      expr: purchase_requisition_status
      comment: "Current status of the purchase requisition"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the requisition"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Type of procurement (stock, non-stock, service, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition"
    - name: "is_converted_to_po"
      expr: is_converted_to_po
      comment: "Flag indicating whether requisition has been converted to PO"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition estimated value"
    - name: "purchase_group"
      expr: purchase_group
      comment: "Purchasing group responsible for the requisition"
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment category for the requisition"
    - name: "source_of_supply"
      expr: source_of_supply
      comment: "Identified source of supply for the requisition"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions"
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all requisitions"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per requisition"
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity requested across all requisitions"
    - name: "distinct_plant_count"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of unique plants with requisitions"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers identified in requisitions"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of unique SKUs requested"
    - name: "distinct_vehicle_program_count"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs with requisitions"
$$;