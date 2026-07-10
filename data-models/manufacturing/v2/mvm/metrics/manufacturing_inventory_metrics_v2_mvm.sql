-- Metric views for domain: inventory | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:46:30

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position and valuation metrics for stock on hand, availability, and turnover analysis"
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock (available, blocked, restricted, etc.)"
    - name: "stock_type"
      expr: stock_type
      comment: "Type classification of stock (unrestricted, quality inspection, blocked, etc.)"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization (A=high value, B=medium, C=low)"
    - name: "stock_category"
      expr: stock_category
      comment: "Category of stock for segmentation and reporting"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for accounting and financial reporting"
    - name: "special_stock_type"
      expr: special_stock_type
      comment: "Special stock indicator (consignment, project stock, etc.)"
    - name: "consignment_indicator"
      expr: consignment_indicator
      comment: "Flag indicating whether stock is consignment inventory"
    - name: "obsolete_indicator"
      expr: obsolete_indicator
      comment: "Flag indicating whether stock is marked as obsolete"
    - name: "slow_moving_indicator"
      expr: slow_moving_indicator
      comment: "Flag indicating whether stock is slow-moving based on turnover analysis"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', period_end_snapshot_date)
      comment: "Month of the inventory snapshot for period-over-period analysis"
    - name: "snapshot_quarter"
      expr: DATE_TRUNC('QUARTER', period_end_snapshot_date)
      comment: "Quarter of the inventory snapshot for quarterly reporting"
    - name: "snapshot_year"
      expr: YEAR(period_end_snapshot_date)
      comment: "Year of the inventory snapshot for annual comparisons"
    - name: "last_receipt_month"
      expr: DATE_TRUNC('MONTH', last_goods_receipt_date)
      comment: "Month of last goods receipt for activity analysis"
    - name: "last_issue_month"
      expr: DATE_TRUNC('MONTH', last_goods_issue_date)
      comment: "Month of last goods issue for movement tracking"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of stock on hand across all locations and materials"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use (not blocked or reserved)"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for orders or production"
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total monetary value of inventory on hand"
    - name: "avg_valuation_price"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per unit across stock balances"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available for use (not blocked or reserved)"
    - name: "inventory_reservation_rate"
      expr: ROUND(100.0 * SUM(CAST(reserved_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is reserved for orders"
    - name: "safety_stock_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(safety_stock_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory designated as safety stock"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity maintained across all materials and locations"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with stock balances"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of distinct stock locations with inventory"
    - name: "stock_balance_record_count"
      expr: COUNT(1)
      comment: "Total number of stock balance records"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement and transaction metrics for goods receipts, issues, transfers, and material flow analysis"
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP/ERP movement type code indicating the nature of the transaction"
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the movement transaction (posted, pending, cancelled, etc.)"
    - name: "movement_indicator"
      expr: movement_indicator
      comment: "General movement direction indicator"
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether this is a goods receipt transaction"
    - name: "goods_issue_indicator"
      expr: goods_issue_indicator
      comment: "Flag indicating whether this is a goods issue transaction"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether this is a reversal transaction"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock involved in the movement (unrestricted, quality, blocked, etc.)"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock type indicator (consignment, project, etc.)"
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the movement (scrap, return, transfer, etc.)"
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of originating document (purchase order, sales order, production order, etc.)"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of the posting date for period analysis"
    - name: "posting_quarter"
      expr: DATE_TRUNC('QUARTER', posting_date)
      comment: "Quarter of the posting date for quarterly reporting"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year of the posting date for annual comparisons"
    - name: "document_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of the document date for transaction timing analysis"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_receipts_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity received into inventory"
    - name: "total_issues_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity issued out of inventory"
    - name: "net_movement_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN CAST(quantity AS DOUBLE) WHEN goods_issue_indicator = TRUE THEN -CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Net inventory change (receipts minus issues)"
    - name: "total_reversal_quantity"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity involved in reversal transactions"
    - name: "movement_transaction_count"
      expr: COUNT(1)
      comment: "Total number of inventory movement transactions"
    - name: "receipt_transaction_count"
      expr: COUNT(CASE WHEN goods_receipt_indicator = TRUE THEN 1 END)
      comment: "Number of goods receipt transactions"
    - name: "issue_transaction_count"
      expr: COUNT(CASE WHEN goods_issue_indicator = TRUE THEN 1 END)
      comment: "Number of goods issue transactions"
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal transactions"
    - name: "distinct_material_moved_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials involved in movements"
    - name: "distinct_source_location_count"
      expr: COUNT(DISTINCT source_stock_location_id)
      comment: "Number of distinct source locations in movement transactions"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per movement transaction"
    - name: "receipt_to_issue_ratio"
      expr: ROUND(SUM(CASE WHEN goods_receipt_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CASE WHEN goods_issue_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END), 0), 2)
      comment: "Ratio of goods receipts to goods issues (>1 indicates inventory build, <1 indicates drawdown)"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics for inventory audit and reconciliation performance"
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (planned, in progress, completed, cancelled)"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (ABC, full, spot, etc.)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, RF scan, automated, etc.)"
    - name: "count_scope"
      expr: count_scope
      comment: "Scope of the count (location, zone, material group, etc.)"
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of materials counted (A=high value, B=medium, C=low)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cycle count results"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of count adjustments to inventory"
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating whether a recount is required due to variance"
    - name: "count_zone"
      expr: count_zone
      comment: "Warehouse zone where the count was performed"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cycle count"
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for financial reconciliation"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month of the cycle count for trend analysis"
    - name: "count_quarter"
      expr: DATE_TRUNC('QUARTER', count_date)
      comment: "Quarter of the cycle count for quarterly reporting"
    - name: "count_year"
      expr: YEAR(count_date)
      comment: "Year of the cycle count for annual comparisons"
  measures:
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory accuracy percentage across cycle counts"
    - name: "total_items_counted"
      expr: SUM(CAST(total_items_counted AS DOUBLE))
      comment: "Total number of items counted across all cycle counts"
    - name: "total_variance_quantity"
      expr: SUM(CAST(total_variance_quantity AS DOUBLE))
      comment: "Total quantity variance (difference between book and physical count)"
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total monetary value of inventory variances"
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage allowed for variances"
    - name: "cycle_count_event_count"
      expr: COUNT(1)
      comment: "Total number of cycle count events performed"
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of cycle counts requiring recount due to variance"
    - name: "recount_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring recount (lower is better)"
    - name: "distinct_warehouse_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of distinct warehouses with cycle count activity"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of distinct stock locations counted"
    - name: "avg_variance_value_per_count"
      expr: AVG(CAST(total_variance_value AS DOUBLE))
      comment: "Average monetary variance per cycle count event"
    - name: "variance_value_rate"
      expr: ROUND(100.0 * SUM(CAST(total_variance_value AS DOUBLE)) / NULLIF(SUM(CAST(total_items_counted AS DOUBLE)), 0), 2)
      comment: "Variance value per item counted (indicates accuracy quality)"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order fulfillment and lead time metrics for inventory planning and supply chain efficiency"
  source: "`vibe_manufacturing_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (open, approved, in transit, closed, cancelled)"
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (purchase, transfer, production, etc.)"
    - name: "source_type"
      expr: source_type
      comment: "Source type for replenishment (vendor, internal, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order (urgent, high, normal, low)"
    - name: "special_procurement_type"
      expr: special_procurement_type
      comment: "Special procurement indicator (consignment, subcontracting, etc.)"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flag indicating whether quality inspection is required upon receipt"
    - name: "serial_number_required"
      expr: serial_number_required
      comment: "Flag indicating whether serial number tracking is required"
    - name: "reference_order_type"
      expr: reference_order_type
      comment: "Type of originating order (sales order, production order, etc.)"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery for demand planning"
    - name: "requested_quarter"
      expr: DATE_TRUNC('QUARTER', requested_delivery_date)
      comment: "Quarter of requested delivery for quarterly planning"
    - name: "confirmed_month"
      expr: DATE_TRUNC('MONTH', confirmed_delivery_date)
      comment: "Month of confirmed delivery for supply planning"
  measures:
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity required across all replenishment orders"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled to date"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for replenishment orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of replenishment orders"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required quantity that has been fulfilled"
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials being replenished"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of distinct stock locations receiving replenishment"
    - name: "avg_required_quantity"
      expr: AVG(CAST(required_quantity AS DOUBLE))
      comment: "Average quantity required per replenishment order"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per replenishment order"
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across all orders"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity maintained"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability metrics for quality management, expiry tracking, and material genealogy"
  source: "`vibe_manufacturing_v1`.`inventory`.`lot_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (released, blocked, restricted, expired)"
    - name: "batch_classification"
      expr: batch_classification
      comment: "Classification of the batch for quality or regulatory purposes"
    - name: "quality_decision"
      expr: quality_decision
      comment: "Quality inspection decision (accepted, rejected, conditional release)"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the batch contains hazardous materials"
    - name: "customer_batch_required_flag"
      expr: customer_batch_required_flag
      comment: "Flag indicating whether customer-specific batch tracking is required"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock type indicator (consignment, project, etc.)"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for accounting purposes"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the batch"
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_date)
      comment: "Month of manufacturing for age analysis"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of expiry for shelf-life management"
    - name: "goods_receipt_month"
      expr: DATE_TRUNC('MONTH', goods_receipt_date)
      comment: "Month of goods receipt for receiving analysis"
  measures:
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across all batches"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use (not blocked or restricted)"
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked due to quality or other issues"
    - name: "total_restricted_quantity"
      expr: SUM(CAST(restricted_quantity AS DOUBLE))
      comment: "Total quantity restricted for specific use"
    - name: "total_batch_cost"
      expr: SUM(CAST(batch_cost_amount AS DOUBLE))
      comment: "Total cost value of all batches"
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Total number of lot/batch records"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with batch tracking"
    - name: "hazmat_batch_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of batches containing hazardous materials"
    - name: "blocked_batch_count"
      expr: COUNT(CASE WHEN blocked_quantity > 0 THEN 1 END)
      comment: "Number of batches with blocked quantity"
    - name: "availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_produced AS DOUBLE)), 0), 2)
      comment: "Percentage of produced quantity that is available for use"
    - name: "blocked_rate"
      expr: ROUND(100.0 * SUM(CAST(blocked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_produced AS DOUBLE)), 0), 2)
      comment: "Percentage of produced quantity that is blocked"
    - name: "avg_batch_cost"
      expr: AVG(CAST(batch_cost_amount AS DOUBLE))
      comment: "Average cost per batch"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity utilization and operational capability metrics for facility management and network optimization"
  source: "`vibe_manufacturing_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (distribution center, cross-dock, cold storage, etc.)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (owned, leased, third-party logistics)"
    - name: "climate_controlled_flag"
      expr: climate_controlled_flag
      comment: "Flag indicating whether the warehouse has climate control"
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Flag indicating whether the warehouse is certified for hazardous materials"
    - name: "automated_storage_flag"
      expr: automated_storage_flag
      comment: "Flag indicating whether the warehouse has automated storage systems"
    - name: "customs_bonded_flag"
      expr: customs_bonded_flag
      comment: "Flag indicating whether the warehouse is a customs bonded facility"
    - name: "iso_9001_certified_flag"
      expr: iso_9001_certified_flag
      comment: "Flag indicating ISO 9001 quality management certification"
    - name: "iso_14001_certified_flag"
      expr: iso_14001_certified_flag
      comment: "Flag indicating ISO 14001 environmental management certification"
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the warehouse location"
    - name: "security_level"
      expr: security_level
      comment: "Security level classification of the warehouse"
    - name: "fire_suppression_system_type"
      expr: fire_suppression_system_type
      comment: "Type of fire suppression system installed"
  measures:
    - name: "total_storage_area_sqm"
      expr: SUM(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Total storage area across all warehouses in square meters"
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_square_meters AS DOUBLE))
      comment: "Total floor area across all warehouses in square meters"
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Total volumetric capacity across all warehouses"
    - name: "total_usable_capacity_cubic_meters"
      expr: SUM(CAST(usable_capacity_cubic_meters AS DOUBLE))
      comment: "Total usable volumetric capacity (excluding aisles, offices, etc.)"
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(usable_capacity_cubic_meters AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_cubic_meters AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity that is usable for storage"
    - name: "warehouse_count"
      expr: COUNT(1)
      comment: "Total number of warehouse facilities"
    - name: "climate_controlled_warehouse_count"
      expr: COUNT(CASE WHEN climate_controlled_flag = TRUE THEN 1 END)
      comment: "Number of warehouses with climate control capability"
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of warehouses certified for hazardous materials"
    - name: "automated_warehouse_count"
      expr: COUNT(CASE WHEN automated_storage_flag = TRUE THEN 1 END)
      comment: "Number of warehouses with automated storage systems"
    - name: "avg_storage_area_sqm"
      expr: AVG(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Average storage area per warehouse in square meters"
    - name: "avg_capacity_cubic_meters"
      expr: AVG(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Average volumetric capacity per warehouse"
$$;