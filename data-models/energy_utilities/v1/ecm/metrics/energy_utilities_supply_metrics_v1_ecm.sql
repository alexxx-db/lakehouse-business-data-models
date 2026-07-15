-- Metric views for domain: supply | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core purchasing activity KPI view"
  source: "`energy_utilities_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type/category of the purchase order"
    - name: "supplier_contract_id"
      expr: supplier_contract_id
      comment: "Identifier of the linked supplier contract"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the goods/services"
    - name: "po_date"
      expr: po_date
      comment: "Date the purchase order was created"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
    - name: "total_gross_value"
      expr: SUM(CAST(total_gross_value AS DOUBLE))
      comment: "Sum of gross value of all purchase orders"
    - name: "total_net_value"
      expr: SUM(CAST(total_net_value AS DOUBLE))
      comment: "Sum of net value of all purchase orders"
    - name: "average_gross_value"
      expr: AVG(CAST(total_gross_value AS DOUBLE))
      comment: "Average gross value per purchase order"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`supply_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier contract performance view"
  source: "`energy_utilities_ecm`.`supply`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Classification of the contract (e.g., fixed, variable)"
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date"
    - name: "renewal_option"
      expr: renewal_option
      comment: "Indicates if renewal option is available"
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of supplier contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Aggregate contract value across all supplier contracts"
    - name: "average_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`supply_emergency_stock_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for emergency stock provisioning and response"
  source: "`energy_utilities_ecm`.`supply`.`emergency_stock_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Classification of the emergency event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the emergency event"
    - name: "declared_emergency_date"
      expr: declared_emergency_date
      comment: "Date the emergency was declared"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor providing emergency stock"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse from which emergency stock was dispatched"
  measures:
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of emergency stock events"
    - name: "total_emergency_spend"
      expr: SUM(CAST(total_emergency_spend AS DOUBLE))
      comment: "Total spend associated with emergency stock events"
    - name: "total_quantity_requested"
      expr: SUM(CAST(total_quantity_requested AS DOUBLE))
      comment: "Aggregate quantity requested during emergencies"
    - name: "average_lead_time_achieved_hours"
      expr: AVG(CAST(lead_time_achieved_hours AS DOUBLE))
      comment: "Average lead time actually achieved (hours)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`supply_inventory_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory reconciliation metrics"
  source: "`energy_utilities_ecm`.`supply`.`inventory_count`"
  dimensions:
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where inventory is counted"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material being counted"
    - name: "count_date"
      expr: count_date
      comment: "Date of the inventory count"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count (e.g., completed, pending)"
  measures:
    - name: "inventory_count"
      expr: COUNT(1)
      comment: "Number of inventory count records"
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Sum of book (recorded) quantities"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Sum of physically counted quantities"
    - name: "total_variance_quantity"
      expr: SUM(CAST(difference_quantity AS DOUBLE))
      comment: "Aggregate quantity variance (book - counted)"
    - name: "average_variance_tolerance_percent"
      expr: AVG(CAST(variance_tolerance_percent AS DOUBLE))
      comment: "Average allowed variance tolerance percent"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`supply_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance and risk assessment view"
  source: "`energy_utilities_ecm`.`supply`.`vendor_evaluation`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor being evaluated"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation"
    - name: "evaluation_date"
      expr: evaluation_date
      comment: "Date the evaluation was recorded"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group responsible for the evaluation"
  measures:
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Number of vendor evaluations performed"
    - name: "average_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall evaluation score across vendors"
    - name: "average_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_pct AS DOUBLE))
      comment: "Average on‑time delivery percentage"
    - name: "total_purchase_value"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value evaluated"
$$;
