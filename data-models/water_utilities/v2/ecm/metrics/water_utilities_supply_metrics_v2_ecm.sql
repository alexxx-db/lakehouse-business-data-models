-- Metric views for domain: supply | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational receipt metrics to monitor inbound logistics"
  source: "`vibe_water_utilities_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor that supplied the goods"
    - name: "warehouse_location_id"
      expr: warehouse_location_id
      comment: "Warehouse location where goods were received"
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', gr_document_date)
      comment: "Month of the goods receipt document"
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across goods receipts"
    - name: "total_goods_receipt_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of monetary value of goods receipts"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received items"
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Count of goods receipt records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_inventory_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and efficiency metrics"
  source: "`vibe_water_utilities_v1`.`supply`.`inventory_stock`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the stock is held"
    - name: "warehouse_location_id"
      expr: warehouse_location_id
      comment: "Warehouse location identifier"
    - name: "stock_type"
      expr: stock_type
      comment: "Classification of stock (e.g., raw, finished)"
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock item"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(stock_value_amount AS DOUBLE))
      comment: "Total monetary value of inventory stock"
    - name: "average_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply across stock items"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity of stock that is available for issue"
    - name: "avg_stock_utilization_pct"
      expr: AVG(100.0 * available_quantity / NULLIF(maximum_stock_level, 0))
      comment: "Average percentage of stock utilization (available vs. maximum)"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and operational KPIs for purchase orders"
  source: "`vibe_water_utilities_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type/category of the purchase order"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor supplying the order"
    - name: "procurement_category_id"
      expr: procurement_category_id
      comment: "Procurement category linked to the order"
    - name: "po_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month of the purchase order"
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of purchase order total amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts on purchase orders"
    - name: "average_po_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order total amount"
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Count of purchase orders"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor base health metrics for procurement governance"
  source: "`vibe_water_utilities_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (Active, Inactive, etc.)"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor (e.g., Manufacturer, Distributor)"
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Indicates if vendor is a small business"
    - name: "woman_owned_flag"
      expr: woman_owned_flag
      comment: "Indicates if vendor is woman‑owned"
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Indicates if vendor is minority‑owned"
    - name: "country_code"
      expr: country_code
      comment: "Country where the vendor is located"
  measures:
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the system"
    - name: "certified_insurance_vendor_count"
      expr: SUM(CASE WHEN insurance_certificate_on_file_flag THEN 1 ELSE 0 END)
      comment: "Count of vendors with a valid insurance certificate on file"
    - name: "active_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of vendors currently marked as Active"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vendor performance KPIs used for supplier management"
  source: "`vibe_water_utilities_v1`.`supply`.`vendor_performance`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor being evaluated"
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_date)
      comment: "Month of the performance evaluation"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (e.g., Completed, Pending)"
  measures:
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on‑time delivery rate percentage for vendors"
    - name: "avg_order_fill_rate_pct"
      expr: AVG(CAST(order_fill_rate_pct AS DOUBLE))
      comment: "Average order fill rate percentage"
    - name: "avg_quality_conformance_rate_pct"
      expr: AVG(CAST(quality_conformance_rate_pct AS DOUBLE))
      comment: "Average quality conformance rate percentage"
    - name: "avg_pricing_accuracy_rate_pct"
      expr: AVG(CAST(pricing_accuracy_rate_pct AS DOUBLE))
      comment: "Average pricing accuracy rate percentage"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average vendor responsiveness score"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total monetary value of orders evaluated in the performance period"
    - name: "vendor_performance_record_count"
      expr: COUNT(1)
      comment: "Number of vendor performance records"
$$;