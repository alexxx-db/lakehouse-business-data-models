-- Metric views for domain: inventory | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

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
      comment: "Current status of the stock (e.g., available, blocked, restricted)"
    - name: "stock_type"
      expr: stock_type
      comment: "Type classification of stock (e.g., unrestricted, quality inspection, blocked)"
    - name: "stock_category"
      expr: stock_category
      comment: "Business category of stock for reporting and analysis"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization (A=high value, B=medium, C=low)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for financial accounting and costing"
    - name: "special_stock_type"
      expr: special_stock_type
      comment: "Special stock indicator (e.g., consignment, project stock, customer stock)"
    - name: "consignment_flag"
      expr: consignment_indicator
      comment: "Indicates whether stock is held on consignment"
    - name: "obsolete_flag"
      expr: obsolete_indicator
      comment: "Indicates whether stock is marked as obsolete"
    - name: "slow_moving_flag"
      expr: slow_moving_indicator
      comment: "Indicates whether stock is classified as slow-moving"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', period_end_snapshot_date)
      comment: "Month of the inventory snapshot for period-over-period analysis"
    - name: "snapshot_quarter"
      expr: DATE_TRUNC('QUARTER', period_end_snapshot_date)
      comment: "Quarter of the inventory snapshot for quarterly reporting"
    - name: "snapshot_year"
      expr: YEAR(period_end_snapshot_date)
      comment: "Year of the inventory snapshot for annual trending"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of inventory on hand - primary financial metric for inventory investment"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical quantity of stock on hand across all locations"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use or sale (not reserved or blocked)"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for specific orders or purposes"
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity maintained as buffer against demand variability"
    - name: "avg_valuation_price"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per unit across inventory items"
    - name: "avg_inventory_turnover_days"
      expr: AVG(CAST(inventory_turnover_days AS DOUBLE))
      comment: "Average days to turn inventory - key efficiency metric for working capital management"
    - name: "inventory_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available (not reserved/blocked) - service level indicator"
    - name: "safety_stock_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(safety_stock_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Safety stock as percentage of total inventory - risk buffer metric"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials in inventory - SKU complexity metric"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of unique storage locations holding inventory - distribution complexity"
    - name: "stock_balance_record_count"
      expr: COUNT(1)
      comment: "Total number of stock balance records - granularity baseline"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory transaction and flow metrics for goods receipts, issues, and material movements"
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Standard movement type code (e.g., 101=GR from PO, 261=GI to production, 311=transfer)"
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the movement transaction (e.g., posted, pending, reversed)"
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the movement (e.g., scrap, rework, quality hold)"
    - name: "goods_receipt_flag"
      expr: goods_receipt_indicator
      comment: "Indicates whether movement is a goods receipt (inbound)"
    - name: "goods_issue_flag"
      expr: goods_issue_indicator
      comment: "Indicates whether movement is a goods issue (outbound)"
    - name: "reversal_flag"
      expr: reversal_indicator
      comment: "Indicates whether movement is a reversal of a prior transaction"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock involved in the movement (e.g., unrestricted, quality, blocked)"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock classification for the movement"
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of originating document (e.g., purchase order, production order, sales order)"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of the posting date for monthly movement analysis"
    - name: "posting_quarter"
      expr: DATE_TRUNC('QUARTER', posting_date)
      comment: "Quarter of the posting date for quarterly trending"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year of the posting date for annual reporting"
    - name: "document_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of the document date for transaction timing analysis"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions - primary throughput metric"
    - name: "total_goods_receipt_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total inbound quantity received - supply flow metric"
    - name: "total_goods_issue_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total outbound quantity issued - demand flow metric"
    - name: "net_inventory_change"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN CAST(quantity AS DOUBLE) WHEN goods_issue_indicator = TRUE THEN -CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Net inventory change (receipts minus issues) - inventory build/draw metric"
    - name: "total_reversal_quantity"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity reversed - transaction quality and error metric"
    - name: "movement_transaction_count"
      expr: COUNT(1)
      comment: "Total number of movement transactions - activity volume baseline"
    - name: "distinct_material_moved_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials moved - SKU activity breadth"
    - name: "distinct_location_activity_count"
      expr: COUNT(DISTINCT source_stock_location_id)
      comment: "Number of unique source locations with movement activity - location utilization"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are reversals - transaction quality metric"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per movement transaction - transaction size metric"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle counting performance metrics for variance analysis and audit compliance"
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (e.g., planned, in progress, completed, cancelled)"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., scheduled, ad-hoc, annual physical)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., manual, RF scanner, automated)"
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of items counted (A=high value, B=medium, C=low)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the count results (e.g., pending, approved, rejected)"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of variance adjustments (e.g., not posted, posted, error)"
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Indicates whether a recount is required due to variance exceeding tolerance"
    - name: "count_scope"
      expr: count_scope
      comment: "Scope of the count (e.g., full warehouse, zone, specific materials)"
    - name: "count_zone"
      expr: count_zone
      comment: "Physical zone or area where count was performed"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cycle count for annual compliance reporting"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month of the count date for monthly accuracy trending"
    - name: "count_quarter"
      expr: DATE_TRUNC('QUARTER', count_date)
      comment: "Quarter of the count date for quarterly audit reporting"
  measures:
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances - primary accuracy cost metric"
    - name: "total_variance_quantity"
      expr: SUM(CAST(total_variance_quantity AS DOUBLE))
      comment: "Total quantity variance (positive or negative) - physical accuracy metric"
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory accuracy percentage across counts - key operational KPI"
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance threshold applied to counts - control parameter metric"
    - name: "cycle_count_event_count"
      expr: COUNT(1)
      comment: "Total number of cycle count events - audit activity volume"
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of counts requiring recount due to variance - quality issue indicator"
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring recount - first-time accuracy metric"
    - name: "distinct_warehouse_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouses with cycle count activity - audit coverage breadth"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of unique locations counted - physical audit coverage"
    - name: "avg_variance_value_per_count"
      expr: AVG(CAST(total_variance_value AS DOUBLE))
      comment: "Average variance value per count event - variance magnitude metric"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment planning and execution metrics for stock availability and supply responsiveness"
  source: "`vibe_manufacturing_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g., planned, released, in transit, received)"
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (e.g., automatic, manual, emergency, kanban)"
    - name: "source_type"
      expr: source_type
      comment: "Source of replenishment (e.g., purchase, transfer, production)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order (e.g., high, medium, low)"
    - name: "special_procurement_type"
      expr: special_procurement_type
      comment: "Special procurement indicator (e.g., consignment, subcontracting, direct ship)"
    - name: "inspection_required_flag"
      expr: inspection_required
      comment: "Indicates whether quality inspection is required upon receipt"
    - name: "serial_number_required_flag"
      expr: serial_number_required
      comment: "Indicates whether serial number tracking is required"
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery for demand planning analysis"
    - name: "confirmed_delivery_month"
      expr: DATE_TRUNC('MONTH', confirmed_delivery_date)
      comment: "Month of confirmed delivery for supply commitment tracking"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the replenishment order was created for order generation trending"
  measures:
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity required across all replenishment orders - demand signal metric"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled - supply execution metric"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for replenishment - committed supply metric"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of replenishment orders - procurement investment metric"
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across materials - planning parameter baseline"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity - buffer inventory target"
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required quantity fulfilled - order fill rate KPI"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for replenishment - supply responsiveness metric"
    - name: "avg_estimated_cost_per_order"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per replenishment order - order economics metric"
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders - planning activity volume"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials being replenished - SKU coverage breadth"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of unique locations receiving replenishment - distribution footprint"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material master data quality and planning parameter metrics for inventory policy and procurement strategy"
  source: "`vibe_manufacturing_v1`.`inventory`.`material_master`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (e.g., raw material, finished goods, semi-finished, trading goods)"
    - name: "material_status"
      expr: material_status
      comment: "Lifecycle status of the material (e.g., active, blocked, obsolete, phase-out)"
    - name: "material_group"
      expr: material_group
      comment: "Material group for procurement and planning segmentation"
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification for inventory prioritization (A=high value, B=medium, C=low)"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., external procurement, in-house production, both)"
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP type controlling planning behavior (e.g., reorder point, forecast-based, no planning)"
    - name: "batch_management_flag"
      expr: batch_management_indicator
      comment: "Indicates whether material requires batch/lot management"
    - name: "hazardous_material_flag"
      expr: hazardous_material_indicator
      comment: "Indicates whether material is classified as hazardous"
    - name: "inspection_setup_flag"
      expr: inspection_setup_indicator
      comment: "Indicates whether quality inspection is required for this material"
    - name: "price_control_indicator"
      expr: price_control_indicator
      comment: "Price control method (e.g., standard price, moving average price)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for financial accounting and costing"
  measures:
    - name: "total_standard_price_value"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Sum of standard prices across materials - valuation baseline metric"
    - name: "total_moving_average_price_value"
      expr: SUM(CAST(moving_average_price AS DOUBLE))
      comment: "Sum of moving average prices - actual cost baseline metric"
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock AS DOUBLE))
      comment: "Total safety stock quantity across all materials - buffer inventory target"
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity - replenishment trigger baseline"
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price per material - pricing benchmark"
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price per material - actual cost benchmark"
    - name: "avg_planned_delivery_time_days"
      expr: AVG(CAST(planned_delivery_time_days AS DOUBLE))
      comment: "Average planned delivery time in days - procurement lead time metric"
    - name: "avg_goods_receipt_processing_time_days"
      expr: AVG(CAST(goods_receipt_processing_time_days AS DOUBLE))
      comment: "Average goods receipt processing time - receiving efficiency metric"
    - name: "avg_net_weight"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight per material - logistics planning metric"
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight per material - shipping planning metric"
    - name: "material_master_count"
      expr: COUNT(1)
      comment: "Total number of material master records - SKU portfolio size"
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN 1 END)
      comment: "Number of hazardous materials - compliance and safety metric"
    - name: "batch_managed_material_count"
      expr: COUNT(CASE WHEN batch_management_indicator = TRUE THEN 1 END)
      comment: "Number of batch-managed materials - traceability complexity metric"
    - name: "inspection_required_material_count"
      expr: COUNT(CASE WHEN inspection_setup_indicator = TRUE THEN 1 END)
      comment: "Number of materials requiring quality inspection - QC workload indicator"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity, utilization, and facility performance metrics for network optimization and operational planning"
  source: "`vibe_manufacturing_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse (e.g., active, inactive, under construction)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (e.g., distribution center, cross-dock, cold storage)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (e.g., owned, leased, third-party logistics)"
    - name: "climate_controlled_flag"
      expr: climate_controlled_flag
      comment: "Indicates whether warehouse has climate control capabilities"
    - name: "automated_storage_flag"
      expr: automated_storage_flag
      comment: "Indicates whether warehouse uses automated storage and retrieval systems"
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates whether warehouse is certified for hazardous materials storage"
    - name: "customs_bonded_flag"
      expr: customs_bonded_flag
      comment: "Indicates whether warehouse is a customs bonded facility"
    - name: "iso_9001_certified_flag"
      expr: iso_9001_certified_flag
      comment: "Indicates ISO 9001 quality management certification status"
    - name: "iso_14001_certified_flag"
      expr: iso_14001_certified_flag
      comment: "Indicates ISO 14001 environmental management certification status"
    - name: "country_code"
      expr: country_code
      comment: "Country where warehouse is located for geographic analysis"
    - name: "security_level"
      expr: security_level
      comment: "Security classification level of the warehouse"
  measures:
    - name: "total_storage_area_sqm"
      expr: SUM(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Total storage area in square meters - physical capacity metric"
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_square_meters AS DOUBLE))
      comment: "Total floor area in square meters - facility footprint metric"
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Total volumetric capacity in cubic meters - 3D capacity metric"
    - name: "total_usable_capacity_cubic_meters"
      expr: SUM(CAST(usable_capacity_cubic_meters AS DOUBLE))
      comment: "Total usable volumetric capacity - effective capacity metric"
    - name: "capacity_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(usable_capacity_cubic_meters AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_cubic_meters AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity that is usable - facility efficiency metric"
    - name: "avg_storage_area_per_warehouse"
      expr: AVG(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Average storage area per warehouse - facility size benchmark"
    - name: "avg_temperature_range_celsius"
      expr: AVG(CAST(temperature_range_max_celsius AS DOUBLE) - CAST(temperature_range_min_celsius AS DOUBLE))
      comment: "Average temperature range across climate-controlled warehouses - environmental control metric"
    - name: "warehouse_count"
      expr: COUNT(1)
      comment: "Total number of warehouse facilities - network size metric"
    - name: "active_warehouse_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of active warehouses - operational network size"
    - name: "climate_controlled_warehouse_count"
      expr: COUNT(CASE WHEN climate_controlled_flag = TRUE THEN 1 END)
      comment: "Number of climate-controlled warehouses - specialized capability metric"
    - name: "automated_warehouse_count"
      expr: COUNT(CASE WHEN automated_storage_flag = TRUE THEN 1 END)
      comment: "Number of automated warehouses - technology adoption metric"
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of hazmat-certified warehouses - compliance capability metric"
$$;