-- Metric views for domain: supply | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs measuring supplier delivery reliability, quality, and invoice accuracy to drive sourcing decisions and supplier relationship management."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_performance`"
  dimensions:
    - name: "rating_tier"
      expr: rating_tier
      comment: "Supplier performance tier (e.g., Gold, Silver, Bronze) used to segment suppliers by overall performance level."
    - name: "measurement_period_start"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month bucket of the measurement period start date for trend analysis over time."
    - name: "measurement_period_end"
      expr: DATE_TRUNC('month', measurement_period_end)
      comment: "Month bucket of the measurement period end date for period-over-period comparisons."
    - name: "contract_compliance_flag"
      expr: contract_compliance_flag
      comment: "Indicates whether the supplier was in compliance with contract terms during the measurement period."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Flags suppliers that required corrective action during the measurement period, enabling risk prioritization."
  measures:
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across evaluated suppliers. A key logistics KPI — declining rates signal supply chain risk and potential stockouts."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate across suppliers. Low fill rates indicate supply shortfalls that can disrupt restaurant operations."
    - name: "avg_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average rate at which received goods are rejected for quality failures. Drives food safety risk and rework cost decisions."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate across suppliers. Low accuracy increases AP processing cost and payment disputes."
    - name: "avg_food_safety_compliance_score"
      expr: AVG(CAST(food_safety_compliance_score AS DOUBLE))
      comment: "Average food safety compliance score across suppliers. Critical for regulatory risk management and brand protection."
    - name: "avg_order_accuracy_rate"
      expr: AVG(CAST(order_accuracy_rate AS DOUBLE))
      comment: "Average order accuracy rate — measures how often suppliers ship exactly what was ordered, impacting kitchen operations."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days. Longer lead times require higher safety stock and increase working capital requirements."
    - name: "supplier_evaluation_count"
      expr: COUNT(1)
      comment: "Total number of supplier performance evaluations in the period. Baseline volume metric for coverage analysis."
    - name: "suppliers_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END)
      comment: "Count of supplier evaluations where corrective action was required. Executives use this to gauge supply chain health and intervention needs."
    - name: "suppliers_non_compliant_contract"
      expr: COUNT(CASE WHEN contract_compliance_flag = FALSE THEN 1 END)
      comment: "Count of evaluations where the supplier was not in contract compliance. Drives contract enforcement and renegotiation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving operations KPIs tracking inbound goods volume, cost, temperature compliance, and quality at the point of receipt across distribution centers and restaurant units."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of goods receipt for trend analysis of inbound supply volume and cost."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (e.g., Accepted, Rejected, Partial) for operational filtering."
    - name: "receiving_method"
      expr: receiving_method
      comment: "Method used to receive goods (e.g., dock, direct store delivery) for process efficiency analysis."
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Indicates whether the receipt maintained cold chain integrity — critical for food safety compliance."
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Flags receipts where temperature deviated from acceptable range, enabling food safety risk monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt transaction for multi-currency cost analysis."
  measures:
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all goods received. Primary spend metric for supply cost management and budget tracking."
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Volume baseline for supply chain throughput analysis."
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts processed. Operational throughput metric for receiving capacity planning."
    - name: "temperature_deviation_receipt_count"
      expr: COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END)
      comment: "Number of receipts with temperature deviations. Elevated counts signal cold chain failures requiring immediate supplier or logistics intervention."
    - name: "cold_chain_non_compliant_count"
      expr: COUNT(CASE WHEN is_cold_chain_compliant = FALSE THEN 1 END)
      comment: "Count of receipts that failed cold chain compliance. Directly tied to food safety risk and potential regulatory exposure."
    - name: "avg_receipt_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per goods receipt. Benchmarks receiving efficiency and detects cost anomalies per delivery."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average recorded temperature at receipt. Used to monitor cold chain performance trends across suppliers and routes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level receiving quality and cost KPIs tracking variance, rejection rates, and unit economics for inbound ingredients."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt_line`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection result at the line level (e.g., Passed, Failed, Pending) for quality segmentation."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Indicates whether the received item is perishable — used to prioritize cold chain and waste risk analysis."
    - name: "is_returned"
      expr: is_returned
      comment: "Flags lines where goods were returned to the supplier, enabling return rate and cost recovery analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the received line item met compliance requirements."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the received item, enabling normalized quantity comparisons."
  measures:
    - name: "total_received_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all received line items. Core supply cost metric for COGS and food cost management."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all lines. Volume baseline for inventory replenishment and demand fulfillment tracking."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receiving. High rejection volumes signal supplier quality issues and increase effective food cost."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total financial variance between ordered and received amounts. Drives AP reconciliation and supplier dispute resolution."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between ordered and received. Persistent variances indicate supplier fulfillment reliability issues."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across received line items. Benchmarks against contract prices to detect pricing compliance issues."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score assigned at receiving inspection. Declining scores trigger supplier corrective action processes."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of received goods. Used for freight cost benchmarking and logistics capacity planning."
    - name: "returned_line_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of receipt lines where goods were returned. Elevated return counts indicate systemic supplier quality or specification issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order management KPIs tracking order volume, spend, approval status, and delivery performance for supply chain procurement operations."
  source: "`vibe_restaurants_v1`.`supply`.`supply_purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current status of the purchase order (e.g., Open, Approved, Received, Cancelled) for pipeline visibility."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — used to identify bottlenecks in the procurement approval process."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the purchase order was placed for spend trend analysis."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery for supply planning and inventory forecasting."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the order — enables freight cost and lead time analysis by transport mode."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the PO (e.g., Net 30, Net 60) for cash flow and working capital analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency spend consolidation."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the PO has been formally approved."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total spend committed across all purchase orders. Primary supply procurement cost metric for budget management."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Benchmarks order sizing and identifies unusually large or small orders for review."
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Operational volume metric for procurement workload and supplier activity."
    - name: "approved_po_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Count of approved purchase orders. Tracks approval throughput and identifies approval bottlenecks."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN is_approved = FALSE THEN 1 END)
      comment: "Count of purchase orders pending approval. High pending counts signal procurement process delays that risk supply continuity."
    - name: "total_approved_spend"
      expr: SUM(CASE WHEN is_approved = TRUE THEN total_amount ELSE 0 END)
      comment: "Total spend on approved purchase orders. Represents committed supply spend for cash flow forecasting."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supply_supplier_id)
      comment: "Number of distinct suppliers with active purchase orders. Measures supplier base breadth and concentration risk."
    - name: "distinct_unit_count"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units receiving supply orders. Measures supply chain reach and distribution coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchase order KPIs tracking ordered vs received quantities, unit economics, and fulfillment accuracy for ingredient procurement."
  source: "`vibe_restaurants_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g., Open, Received, Cancelled) for fulfillment tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered ingredient — enables normalized quantity comparisons across items."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery for supply planning and inventory forecasting at the line level."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item for multi-currency cost analysis."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Baseline demand signal for supply planning and inventory management."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines. Compared to ordered quantity to measure supplier fulfillment performance."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount (quantity × price). Core supply spend metric for COGS and food cost management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across PO lines. Measures negotiated savings and contract compliance benefits."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on PO lines for tax liability tracking and AP reconciliation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across ordered lines. Benchmarks against contract prices to detect pricing drift or non-compliance."
    - name: "fulfillment_quantity_gap"
      expr: SUM(CAST(ordered_quantity AS DOUBLE) - CAST(received_quantity AS DOUBLE))
      comment: "Total unfulfilled quantity (ordered minus received). Persistent gaps indicate supplier reliability issues that risk restaurant operations."
    - name: "po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines. Operational volume metric for procurement complexity and workload analysis."
    - name: "distinct_ingredient_count"
      expr: COUNT(DISTINCT ingredient_id)
      comment: "Number of distinct ingredients ordered. Measures ingredient portfolio breadth and sourcing complexity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier invoice KPIs tracking payables volume, payment status, matching accuracy, and financial exposure for supply chain AP management."
  source: "`vibe_restaurants_v1`.`supply`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., Open, Paid, Disputed, Cancelled) for AP pipeline management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., Unpaid, Partial, Paid) for cash flow and working capital analysis."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status (e.g., Matched, Unmatched, Exception) — unmatched invoices drive AP dispute and audit risk."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for payables trend and spend periodization."
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month payment is due for cash flow forecasting and early payment discount analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice (e.g., Net 30) for working capital and DPO analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency payables consolidation."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount across all supplier invoices. Primary AP spend metric for supply cost management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount (before tax). Used for COGS and food cost reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on supplier invoices for tax liability tracking and compliance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. AP workload and supplier activity volume metric."
    - name: "unpaid_invoice_count"
      expr: COUNT(CASE WHEN payment_status = 'Unpaid' THEN 1 END)
      comment: "Count of unpaid invoices. Elevated counts signal AP processing bottlenecks or cash flow constraints."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN match_status = 'Unmatched' THEN 1 END)
      comment: "Count of invoices that failed three-way match. Drives AP exception resolution workload and supplier dispute risk."
    - name: "total_unpaid_amount"
      expr: SUM(CASE WHEN payment_status = 'Unpaid' THEN total_amount ELSE 0 END)
      comment: "Total financial exposure from unpaid invoices. Critical for cash flow management and working capital optimization."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with invoices in the period. Measures AP supplier base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient master KPIs tracking cost, nutritional profile, compliance attributes, and waste characteristics to support menu engineering, food safety, and procurement decisions."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient`"
  dimensions:
    - name: "ingredient_category"
      expr: ingredient_category
      comment: "Category of the ingredient (e.g., Protein, Produce, Dairy) for spend and nutrition analysis by category."
    - name: "ingredient_status"
      expr: ingredient_status
      comment: "Active/inactive status of the ingredient for portfolio management and discontinuation tracking."
    - name: "haccp_classification"
      expr: haccp_classification
      comment: "HACCP risk classification of the ingredient — drives food safety monitoring and critical control point assignment."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance, tariff impact, and supply chain diversification analysis."
    - name: "organic_flag"
      expr: organic_flag
      comment: "Indicates organic certification — used for menu labeling compliance and premium cost analysis."
    - name: "halal_flag"
      expr: halal_flag
      comment: "Indicates halal certification for menu compliance and market segment targeting."
    - name: "kosher_flag"
      expr: kosher_flag
      comment: "Indicates kosher certification for menu compliance and market segment targeting."
    - name: "non_gmo_flag"
      expr: non_gmo_flag
      comment: "Indicates non-GMO status for menu labeling and consumer transparency requirements."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ingredient for normalized cost and quantity comparisons."
    - name: "sub_category"
      expr: sub_category
      comment: "Sub-category of the ingredient for granular spend and nutrition analysis."
  measures:
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across ingredients. Benchmarks ingredient economics and tracks cost inflation trends."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Sum of unit costs across the ingredient portfolio. Proxy for total ingredient cost exposure in the supply base."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across ingredients. High waste rates increase effective food cost and drive yield improvement initiatives."
    - name: "avg_calories_per_unit"
      expr: AVG(CAST(nutritional_calories_per_unit AS DOUBLE))
      comment: "Average caloric content per unit across ingredients. Supports menu nutrition analysis and regulatory labeling compliance."
    - name: "avg_sodium_mg_per_unit"
      expr: AVG(CAST(sodium_mg_per_unit AS DOUBLE))
      comment: "Average sodium content per unit. Supports health-conscious menu engineering and regulatory sodium reduction targets."
    - name: "avg_protein_content_percent"
      expr: AVG(CAST(protein_content_percent AS DOUBLE))
      comment: "Average protein content percentage across ingredients. Supports nutritional menu engineering and health positioning."
    - name: "ingredient_count"
      expr: COUNT(1)
      comment: "Total number of active ingredients in the supply portfolio. Measures ingredient complexity and sourcing breadth."
    - name: "organic_ingredient_count"
      expr: COUNT(CASE WHEN organic_flag = TRUE THEN 1 END)
      comment: "Count of organic-certified ingredients. Tracks progress toward organic sourcing commitments and premium menu positioning."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average required storage temperature across ingredients. Used for cold chain infrastructure planning and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot-level traceability and quality KPIs tracking ingredient lot status, recall exposure, yield, waste, and cost for food safety and inventory management."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the ingredient lot (e.g., Active, Quarantined, Consumed, Recalled) for traceability and risk management."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot (e.g., Production, Replenishment) for supply chain segmentation."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection result for the lot — drives disposition decisions and food safety compliance."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flags lots subject to a recall event — critical for food safety response and regulatory reporting."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Indicates whether the lot is organically certified for menu labeling and compliance."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the lot requires temperature-controlled storage for cold chain compliance."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month the lot was received for inbound supply trend analysis."
    - name: "best_by_month"
      expr: DATE_TRUNC('month', best_by_date)
      comment: "Month of best-by date for shelf life and waste risk analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance and supply chain diversification analysis."
  measures:
    - name: "total_lot_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all ingredient lots. Baseline inventory volume metric for supply availability planning."
    - name: "total_lot_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all ingredient lots. Core food cost and inventory valuation metric."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across lots. Tracks ingredient cost trends and variance from contract prices."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across ingredient lots. Declining scores signal supplier quality degradation requiring intervention."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across lots. Low yields increase effective food cost and drive prep process improvement."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across lots. High waste rates directly increase food cost and reduce margin."
    - name: "recalled_lot_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of lots subject to a recall. Executives use this to assess food safety exposure and regulatory response scope."
    - name: "total_recalled_quantity"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of recalled ingredient lots. Measures the operational and financial scale of recall events."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across lots. Used to monitor cold chain compliance and detect temperature drift."
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Total number of ingredient lots. Baseline traceability volume metric for lot management complexity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality inspection KPIs tracking inspection outcomes, defect rates, corrective action requirements, and compliance for supplier quality management."
  source: "`vibe_restaurants_v1`.`supply`.`quality_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of quality inspection (e.g., Incoming, In-Process, Final) for quality process segmentation."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g., Pass, Fail, Conditional) — primary quality disposition dimension."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Current status of the inspection record (e.g., Open, Closed, Pending Review)."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect identified (e.g., Temperature, Contamination, Packaging) for root cause analysis."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken on failed items (e.g., Return, Destroy, Accept with Deviation) for cost and compliance tracking."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flags inspections requiring corrective action — drives supplier quality improvement programs."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the inspected goods met compliance requirements."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection for quality trend analysis over time."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g., Visual, Lab Test, Temperature Check) for process analysis."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of quality inspections performed. Baseline quality program activity metric."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_result = 'Fail' THEN 1 END)
      comment: "Count of failed inspections. Elevated failure counts signal systemic supplier quality issues requiring escalation."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of inspections requiring corrective action. Drives supplier quality improvement program prioritization."
    - name: "total_rejection_quantity"
      expr: SUM(CAST(rejection_quantity AS DOUBLE))
      comment: "Total quantity rejected across all inspections. Measures the operational impact of quality failures on supply availability."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded during inspections. Monitors cold chain compliance trends across suppliers and shipments."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity recorded during inspections. Relevant for produce and dry goods quality compliance."
    - name: "non_compliant_inspection_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Count of inspections where compliance requirements were not met. Directly tied to regulatory risk and food safety exposure."
    - name: "distinct_supplier_inspected_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers inspected. Measures quality program coverage across the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety recall KPIs tracking recall volume, severity, financial impact, and regulatory compliance to manage supply chain risk and brand protection."
  source: "`vibe_restaurants_v1`.`supply`.`recall_event`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g., Active, Closed, Under Investigation) for response management."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class (Class I, II, III) indicating severity — Class I represents the highest consumer risk."
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity rating of the recall for risk prioritization and executive escalation."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., Voluntary, Mandatory, Market Withdrawal) for regulatory compliance tracking."
    - name: "recall_reason"
      expr: recall_reason
      comment: "Root cause of the recall (e.g., Contamination, Mislabeling, Foreign Object) for systemic risk analysis."
    - name: "product_category"
      expr: product_category
      comment: "Category of the recalled product for supply chain risk segmentation."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification (e.g., Notified, Pending) for compliance tracking."
    - name: "recall_initiation_month"
      expr: DATE_TRUNC('month', recall_initiation_timestamp)
      comment: "Month the recall was initiated for trend analysis of food safety incidents over time."
    - name: "compliance_fda"
      expr: compliance_fda
      comment: "Indicates FDA compliance status of the recall response — critical for regulatory risk management."
    - name: "compliance_haccp"
      expr: compliance_haccp
      comment: "Indicates HACCP compliance status of the recall response."
  measures:
    - name: "recall_event_count"
      expr: COUNT(1)
      comment: "Total number of recall events. Baseline food safety risk metric — executives use this to assess supply chain safety performance."
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity of product recalled. Measures the operational scale of recall events and supply disruption impact."
    - name: "total_recall_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total financial cost of recall events including disposal, logistics, and remediation. Directly impacts P&L and brand value."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across recall events. Tracks overall supply chain food safety risk level over time."
    - name: "active_recall_count"
      expr: COUNT(CASE WHEN recall_status = 'Active' THEN 1 END)
      comment: "Count of currently active recall events. Executives use this as a real-time food safety risk indicator."
    - name: "fda_non_compliant_recall_count"
      expr: COUNT(CASE WHEN compliance_fda = FALSE THEN 1 END)
      comment: "Count of recalls where FDA compliance was not achieved. Regulatory non-compliance exposes the business to fines and enforcement actions."
    - name: "temperature_deviation_recall_count"
      expr: COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END)
      comment: "Count of recalls triggered by temperature deviations. Identifies cold chain failures as a systemic recall risk driver."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics KPIs tracking shipment on-time performance, freight cost, temperature compliance, and carrier efficiency for supply chain operations."
  source: "`vibe_restaurants_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g., In Transit, Delivered, Delayed, Exception) for logistics visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., Truck, Rail, Air) for freight cost and lead time analysis by mode."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier for carrier performance benchmarking and contract management."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight terms (e.g., FOB, CIF) for cost responsibility and logistics contract analysis."
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Indicates whether the shipment required temperature control — used for cold chain compliance monitoring."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flags expedited shipments — high expedite rates signal supply planning failures and drive premium freight costs."
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('month', scheduled_arrival_timestamp)
      comment: "Month of scheduled arrival for supply planning and receiving capacity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight costs for multi-currency logistics spend analysis."
  measures:
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all inbound shipments. Key logistics cost metric for supply chain cost management."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarks carrier efficiency and identifies cost outliers."
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Total number of inbound shipments. Baseline logistics volume metric for receiving capacity planning."
    - name: "expedited_shipment_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Count of expedited shipments. High expedite counts signal supply planning failures and drive premium freight cost increases."
    - name: "total_expedited_freight_cost"
      expr: SUM(CASE WHEN is_expedited = TRUE THEN freight_cost ELSE 0 END)
      comment: "Total freight cost attributable to expedited shipments. Quantifies the financial penalty of supply planning failures."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of inbound shipments in kilograms. Used for freight cost per kg benchmarking and logistics capacity planning."
    - name: "total_volume_cubic_m"
      expr: SUM(CAST(volume_cubic_m AS DOUBLE))
      comment: "Total volume of inbound shipments in cubic meters. Used for truck utilization and logistics capacity planning."
    - name: "avg_temperature_min_c"
      expr: AVG(CAST(temperature_min_c AS DOUBLE))
      comment: "Average minimum temperature recorded across temperature-controlled shipments. Monitors cold chain lower bound compliance."
    - name: "avg_temperature_max_c"
      expr: AVG(CAST(temperature_max_c AS DOUBLE))
      comment: "Average maximum temperature recorded across temperature-controlled shipments. Monitors cold chain upper bound compliance."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with inbound shipments. Measures supply base activity and logistics network breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract KPIs tracking contract value, compliance, rebate economics, and renewal risk for strategic sourcing and vendor management."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_contract`"
  dimensions:
    - name: "supplier_contract_status"
      expr: supplier_contract_status
      comment: "Current status of the supplier contract (e.g., Active, Expired, Terminated, Pending) for portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., Master Supply Agreement, Spot, Framework) for contract portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract — non-compliant contracts drive legal and operational risk."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Renewal type (e.g., Auto-Renew, Manual, Evergreen) for contract lifecycle management."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates exclusive supply arrangements — relevant for supply concentration risk analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the contract became effective for contract vintage analysis."
    - name: "effective_until_month"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Month the contract expires for renewal pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency spend consolidation."
  measures:
    - name: "total_default_price"
      expr: SUM(CAST(default_price AS DOUBLE))
      comment: "Sum of default contract prices across active contracts. Proxy for contracted supply cost exposure."
    - name: "avg_default_price"
      expr: AVG(CAST(default_price AS DOUBLE))
      comment: "Average default contract price. Benchmarks pricing across the supplier portfolio."
    - name: "total_liability_limit"
      expr: SUM(CAST(liability_limit AS DOUBLE))
      comment: "Total liability limit across supplier contracts. Measures contractual risk coverage and legal exposure."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across contracts. Tracks negotiated rebate economics and savings opportunity."
    - name: "total_rebate_threshold"
      expr: SUM(CAST(rebate_threshold_amount AS DOUBLE))
      comment: "Total rebate threshold amount across contracts. Measures the spend level required to unlock rebate benefits."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of supplier contracts. Baseline contract portfolio size metric."
    - name: "non_compliant_contract_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of contracts with non-compliant status. Drives legal risk management and supplier corrective action."
    - name: "exclusive_contract_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Count of exclusive supply contracts. High exclusivity concentration increases supply chain vulnerability."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers under contract. Measures supply base breadth and sourcing diversification."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_commodity_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity category KPIs tracking spend concentration, cost benchmarks, risk profiles, and strategic sourcing tier distribution across the ingredient supply base."
  source: "`vibe_restaurants_v1`.`supply`.`commodity_category`"
  dimensions:
    - name: "commodity_category_status"
      expr: commodity_category_status
      comment: "Active/inactive status of the commodity category for portfolio management."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity (e.g., Protein, Produce, Packaging) for spend and risk segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the category (e.g., High, Medium, Low) for strategic sourcing prioritization."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Indicates whether the category contains perishable items — drives cold chain and waste risk analysis."
    - name: "is_leaf_category"
      expr: is_leaf_category
      comment: "Indicates whether this is a leaf-level category in the hierarchy for granular analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the commodity category hierarchy for roll-up and drill-down analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the category for normalized cost comparisons."
  measures:
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(average_cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across commodity categories. Benchmarks category economics and tracks inflation trends."
    - name: "total_spend_percentage"
      expr: SUM(CAST(spend_percentage AS DOUBLE))
      comment: "Sum of spend percentages across categories. Used to validate spend concentration and Pareto analysis of supply costs."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across commodity categories. Drives strategic sourcing investment and risk mitigation prioritization."
    - name: "avg_typical_cogs_percent"
      expr: AVG(CAST(typical_cogs_percent AS DOUBLE))
      comment: "Average typical COGS percentage across categories. Benchmarks food cost contribution by commodity type."
    - name: "high_risk_category_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of high-risk commodity categories. Executives use this to prioritize supply chain risk mitigation investments."
    - name: "category_count"
      expr: COUNT(1)
      comment: "Total number of commodity categories. Baseline portfolio complexity metric for sourcing organization design."
    - name: "perishable_category_count"
      expr: COUNT(CASE WHEN is_perishable = TRUE THEN 1 END)
      comment: "Count of perishable commodity categories. Measures cold chain dependency and waste risk exposure in the supply base."
$$;