-- Metric views for domain: inventory | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand quantities, stock categories, and valuation across plants and storage locations for inventory planning and financial reporting."
  source: "`vibe_automotive_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where inventory is held"
    - name: "stock_category"
      expr: stock_category
      comment: "Stock category classification (unrestricted, blocked, quality inspection, consignment, in-transit)"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of the stock"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the material (active, obsolete, phase-out)"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for accounting purposes"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', last_movement_timestamp)
      comment: "Month of last inventory movement for aging analysis"
    - name: "is_serialized"
      expr: is_serialized
      comment: "Flag indicating whether the material is serial-number controlled"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of inventory on hand across all stock categories"
    - name: "total_unrestricted_stock"
      expr: SUM(CAST(unrestricted_stock_qty AS DOUBLE))
      comment: "Total unrestricted stock available for use or sale"
    - name: "total_blocked_stock"
      expr: SUM(CAST(blocked_stock_qty AS DOUBLE))
      comment: "Total blocked stock not available for use (quality holds, defects)"
    - name: "total_quality_inspection_stock"
      expr: SUM(CAST(quality_inspection_stock_qty AS DOUBLE))
      comment: "Total stock in quality inspection awaiting release"
    - name: "total_in_transit_stock"
      expr: SUM(CAST(in_transit_stock_qty AS DOUBLE))
      comment: "Total stock in transit between locations"
    - name: "total_consignment_stock"
      expr: SUM(CAST(consignment_stock_qty AS DOUBLE))
      comment: "Total consignment stock held at customer or supplier locations"
    - name: "total_inventory_value"
      expr: SUM(CAST(valuation_price AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total inventory value at valuation price (quantity × unit price)"
    - name: "blocked_stock_rate"
      expr: ROUND(100.0 * SUM(CAST(blocked_stock_qty AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of total inventory that is blocked (quality issue indicator)"
    - name: "stock_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(unrestricted_stock_qty AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of total inventory that is unrestricted and available for use"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs in inventory"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Number of distinct storage locations holding inventory"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory transaction metrics tracking goods receipts, issues, transfers, and adjustments for supply chain velocity and material flow analysis."
  source: "`vibe_automotive_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_id
      comment: "Movement type identifier (receipt, issue, transfer, adjustment)"
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Status of the goods movement transaction"
    - name: "posting_date"
      expr: posting_date
      comment: "Date when the goods movement was posted to inventory"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods movement posting for trend analysis"
    - name: "source_plant"
      expr: source_plant
      comment: "Source plant code for the movement"
    - name: "destination_plant"
      expr: destination_plant
      comment: "Destination plant code for the movement"
    - name: "movement_reason"
      expr: movement_reason
      comment: "Business reason for the goods movement"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status of the moved goods"
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether the movement was automated (AGV, robotic)"
    - name: "is_reversal"
      expr: reversal_indicator
      comment: "Flag indicating whether this is a reversal transaction"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods moved across all transactions"
    - name: "total_movement_value_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total value of goods movements in USD for financial impact analysis"
    - name: "total_movement_value_local"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total value of goods movements in local currency"
    - name: "movement_transaction_count"
      expr: COUNT(1)
      comment: "Total number of goods movement transactions"
    - name: "distinct_parts_moved"
      expr: COUNT(DISTINCT part_master_id)
      comment: "Number of distinct parts involved in goods movements"
    - name: "distinct_source_locations"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Number of distinct source storage locations"
    - name: "automated_movement_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods movements that are automated (efficiency indicator)"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods movements that are reversals (error rate indicator)"
    - name: "avg_movement_value_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average value per goods movement transaction in USD"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy metrics tracking cycle count variances, accuracy rates, and compliance for inventory control and audit readiness."
  source: "`vibe_automotive_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (planned, in-progress, completed, approved)"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (ABC-based, random, full physical inventory)"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the counted material (A=high-value, B=medium, C=low)"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month when the cycle count was performed"
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason code for inventory variance (shrinkage, damage, system error)"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flag indicating whether a recount was required"
    - name: "is_obsolete"
      expr: is_obsolete
      comment: "Flag indicating whether the counted material is obsolete"
    - name: "compliance_iatf16949_flag"
      expr: compliance_iatf16949_flag
      comment: "Flag indicating IATF 16949 compliance requirement"
  measures:
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book quantity (system quantity) before cycle count"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted during cycle count"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity (counted minus book quantity)"
    - name: "cycle_count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(variance_quantity AS DOUBLE) = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts with zero variance (inventory accuracy KPI)"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all cycle counts"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN recount_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring recount (process quality indicator)"
    - name: "cycle_count_transaction_count"
      expr: COUNT(1)
      comment: "Total number of cycle count transactions"
    - name: "distinct_sku_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs cycle counted"
    - name: "distinct_locations_counted"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Number of distinct storage locations cycle counted"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial inventory valuation metrics tracking standard price, moving average price, and write-downs for financial reporting and cost control."
  source: "`vibe_automotive_v1`.`inventory`.`inventory_valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the inventory valuation record"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for accounting categorization"
    - name: "price_control"
      expr: price_control
      comment: "Price control method (standard price vs. moving average price)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation"
    - name: "period"
      expr: period
      comment: "Fiscal period of the valuation"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for the valuation area"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation for trend analysis"
    - name: "obsolescence_flag"
      expr: obsolescence_flag
      comment: "Flag indicating obsolete inventory requiring write-down"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total inventory value at standard or moving average price (balance sheet KPI)"
    - name: "total_stock_quantity"
      expr: SUM(CAST(total_stock_quantity AS DOUBLE))
      comment: "Total stock quantity valued"
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount for obsolescence or damage"
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance between standard and actual cost"
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price per unit across all materials"
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price per unit across all materials"
    - name: "write_down_rate"
      expr: ROUND(100.0 * SUM(CAST(write_down_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory value written down (obsolescence indicator)"
    - name: "distinct_sku_valued"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with valuation records"
    - name: "distinct_gl_accounts"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts used for inventory valuation"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_finished_vehicle_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished vehicle inventory metrics tracking aging, allocation, and stock status for production-to-sales flow and dealer allocation optimization."
  source: "`vibe_automotive_v1`.`inventory`.`finished_vehicle_stock`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Stock status of the finished vehicle (available, allocated, in-transit, sold)"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where vehicle is held (plant, compound, dealer, port)"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where vehicle was produced"
    - name: "model_code"
      expr: model_code
      comment: "Vehicle model code"
    - name: "body_style"
      expr: body_style
      comment: "Vehicle body style (sedan, SUV, truck)"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, hybrid, BEV, PHEV)"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month of vehicle production for aging analysis"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month when vehicle was allocated to dealer or customer"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flag indicating whether vehicle is subject to a recall"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason for inventory hold (quality, recall, missing parts)"
  measures:
    - name: "total_vehicle_count"
      expr: COUNT(1)
      comment: "Total number of finished vehicles in inventory"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of finished vehicle inventory (capital tied up)"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per finished vehicle"
    - name: "avg_aging_days"
      expr: AVG(CAST(aging_days AS DOUBLE))
      comment: "Average days since production (inventory aging KPI)"
    - name: "distinct_models"
      expr: COUNT(DISTINCT model_code)
      comment: "Number of distinct vehicle models in finished goods inventory"
    - name: "distinct_locations"
      expr: COUNT(DISTINCT current_location_code)
      comment: "Number of distinct locations holding finished vehicles"
    - name: "recall_affected_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of finished vehicles affected by recalls"
    - name: "allocated_vehicle_count"
      expr: SUM(CAST(CASE WHEN allocation_date IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of vehicles allocated to dealers or customers"
    - name: "allocation_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN allocation_date IS NOT NULL THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of finished vehicles that are allocated (sales pipeline indicator)"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory replenishment metrics tracking order fulfillment, lead times, and critical shortages for supply chain responsiveness and service level management."
  source: "`vibe_automotive_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the replenishment order (open, in-progress, fulfilled, cancelled)"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the replenishment order"
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (JIT, JIS, safety stock, emergency)"
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method (kanban, MRP, manual, automatic)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order (critical, high, normal, low)"
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered the replenishment (MRP, kanban signal, manual request)"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating critical replenishment order (line-down risk)"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when replenishment order was created"
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders"
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested across all replenishment orders"
    - name: "total_replenishment_cost"
      expr: SUM(CAST(cost_per_unit AS DOUBLE) * CAST(requested_quantity AS DOUBLE))
      comment: "Total cost of replenishment orders (procurement spend)"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for replenishment orders"
    - name: "critical_order_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders marked as critical (supply risk indicator)"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN actual_delivery_timestamp <= promised_delivery_date THEN 1 ELSE 0 END AS INT)) / NULLIF(SUM(CAST(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 ELSE 0 END AS INT)), 0), 2)
      comment: "Percentage of replenishment orders delivered on or before promised date (supplier performance KPI)"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers fulfilling replenishment orders"
    - name: "distinct_skus_replenished"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs being replenished"
    - name: "distinct_destination_locations"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Number of distinct destination locations receiving replenishment"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory hold metrics tracking quality holds, recall holds, and hold release performance for risk management and compliance."
  source: "`vibe_automotive_v1`.`inventory`.`inventory_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Status of the inventory hold (active, released, escalated)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of inventory hold (quality, recall, engineering, supplier)"
    - name: "hold_source"
      expr: hold_source
      comment: "Source system or department that initiated the hold"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the inventory hold"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for held inventory (release, scrap, rework, return)"
    - name: "is_critical_hold"
      expr: is_critical_hold
      comment: "Flag indicating critical hold with high business impact"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when inventory hold was initiated"
  measures:
    - name: "total_quantity_held"
      expr: SUM(CAST(quantity_held AS DOUBLE))
      comment: "Total quantity of inventory under hold (supply risk indicator)"
    - name: "total_hold_count"
      expr: COUNT(1)
      comment: "Total number of inventory hold records"
    - name: "critical_hold_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_critical_hold = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds classified as critical (quality risk indicator)"
    - name: "distinct_skus_on_hold"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs under inventory hold"
    - name: "distinct_locations_with_holds"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Number of distinct storage locations with inventory holds"
    - name: "distinct_recall_campaigns"
      expr: COUNT(DISTINCT recall_campaign_id)
      comment: "Number of distinct recall campaigns causing inventory holds"
    - name: "distinct_supplier_nonconformances"
      expr: COUNT(DISTINCT supplier_nonconformance_id)
      comment: "Number of distinct supplier nonconformances causing holds"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_abc_xyz_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ABC/XYZ inventory classification metrics for strategic inventory segmentation, cycle count planning, and safety stock optimization."
  source: "`vibe_automotive_v1`.`inventory`.`abc_xyz_classification`"
  dimensions:
    - name: "abc_class"
      expr: abc_class
      comment: "ABC classification based on consumption value (A=high-value, B=medium, C=low)"
    - name: "xyz_class"
      expr: xyz_class
      comment: "XYZ classification based on consumption variability (X=stable, Y=variable, Z=sporadic)"
    - name: "classification_method"
      expr: classification_method
      comment: "Method used for ABC/XYZ classification (Pareto, statistical, manual)"
    - name: "abc_xyz_classification_status"
      expr: abc_xyz_classification_status
      comment: "Status of the classification record (active, expired, under review)"
    - name: "is_obsolete"
      expr: is_obsolete
      comment: "Flag indicating obsolete material classification"
    - name: "classification_month"
      expr: DATE_TRUNC('MONTH', classification_date)
      comment: "Month when ABC/XYZ classification was performed"
  measures:
    - name: "total_annual_consumption_value"
      expr: SUM(CAST(annual_consumption_value AS DOUBLE))
      comment: "Total annual consumption value across all classified SKUs (inventory investment KPI)"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity recommended based on ABC/XYZ classification"
    - name: "avg_annual_consumption_value"
      expr: AVG(CAST(annual_consumption_value AS DOUBLE))
      comment: "Average annual consumption value per SKU"
    - name: "distinct_sku_classified"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with ABC/XYZ classification"
    - name: "class_a_sku_count"
      expr: SUM(CAST(CASE WHEN abc_class = 'A' THEN 1 ELSE 0 END AS INT))
      comment: "Number of SKUs classified as A (high-value, tight control required)"
    - name: "class_a_value_concentration"
      expr: ROUND(100.0 * SUM(CASE WHEN abc_class = 'A' THEN CAST(annual_consumption_value AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(annual_consumption_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total consumption value concentrated in Class A SKUs (Pareto principle validation)"
    - name: "obsolete_sku_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_obsolete = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of classified SKUs marked as obsolete (portfolio health indicator)"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_serialized_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Serialized component tracking metrics for high-value parts, batteries, and safety-critical components requiring individual traceability and warranty management."
  source: "`vibe_automotive_v1`.`inventory`.`serialized_unit`"
  dimensions:
    - name: "serialized_unit_status"
      expr: serialized_unit_status
      comment: "Status of the serialized unit (in-stock, installed, in-service, defective, returned)"
    - name: "component_type"
      expr: component_type
      comment: "Type of serialized component (battery, ECU, transmission, turbocharger)"
    - name: "installation_status"
      expr: installation_status
      comment: "Installation status of the serialized unit"
    - name: "health_status"
      expr: health_status
      comment: "Health status of the serialized unit (good, degraded, critical, failed)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the serialized unit (certified, pending, non-compliant)"
    - name: "is_defective"
      expr: is_defective
      comment: "Flag indicating whether the serialized unit is defective"
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month of manufacture for cohort analysis"
    - name: "warranty_status"
      expr: CASE WHEN warranty_end_date >= CURRENT_DATE THEN 'In Warranty' ELSE 'Out of Warranty' END
      comment: "Derived warranty status based on warranty end date"
  measures:
    - name: "total_serialized_units"
      expr: COUNT(1)
      comment: "Total number of serialized units tracked"
    - name: "total_purchase_value"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase value of serialized units (high-value inventory)"
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per serialized unit"
    - name: "defective_unit_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_defective = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of serialized units marked as defective (quality indicator)"
    - name: "avg_battery_capacity_ah"
      expr: AVG(CAST(capacity_ah AS DOUBLE))
      comment: "Average battery capacity in amp-hours for battery components"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight in kilograms per serialized unit"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with serialized unit tracking"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_code)
      comment: "Number of distinct suppliers providing serialized components"
    - name: "distinct_connected_vehicles"
      expr: COUNT(DISTINCT connected_vehicle_id)
      comment: "Number of distinct connected vehicles with installed serialized units"
$$;
