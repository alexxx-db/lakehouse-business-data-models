-- Metric views for domain: inventory | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand, available, reserved, and blocked quantities with valuation for inventory optimization and working capital management"
  source: "`chemical_mfg_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock position (e.g., available, blocked, restricted)"
    - name: "stock_type"
      expr: stock_type
      comment: "Type classification of stock (e.g., unrestricted, quality inspection, blocked)"
    - name: "stock_category"
      expr: stock_category
      comment: "Business category of stock for reporting and analysis"
    - name: "plant_code"
      expr: warehouse_location_id
      comment: "Warehouse location identifier for site-level inventory analysis"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the material is classified as hazardous"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Financial valuation classification for inventory accounting"
    - name: "lot_rotation_method"
      expr: lot_rotation_method
      comment: "Method used for lot rotation (FIFO, FEFO, LIFO)"
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage location (e.g., bulk, rack, tank)"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the inventory snapshot for time-series analysis"
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month of the inventory snapshot for monthly trending"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total physical inventory on hand across all stock positions"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for consumption or sale (unrestricted and unreserved)"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for specific orders or production requirements"
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked from use due to quality or compliance issues"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between locations"
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity currently under quality inspection"
    - name: "total_inventory_value"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE) * CAST(valuation_price AS DOUBLE))
      comment: "Total financial value of on-hand inventory at valuation price"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available for use (availability efficiency)"
    - name: "inventory_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(reserved_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is reserved for specific demand"
    - name: "blocked_inventory_rate"
      expr: ROUND(100.0 * SUM(CAST(blocked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is blocked (quality risk indicator)"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials in stock (SKU complexity)"
    - name: "distinct_lot_count"
      expr: COUNT(DISTINCT lot_id)
      comment: "Number of distinct lots in inventory (lot traceability complexity)"
    - name: "stock_position_count"
      expr: COUNT(1)
      comment: "Total number of unique stock positions"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement and transaction metrics for throughput analysis, FIFO/FEFO compliance, and material flow optimization"
  source: "`chemical_mfg_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP movement type code identifying the nature of the transaction"
    - name: "movement_category"
      expr: movement_category
      comment: "High-level category of movement (e.g., receipt, issue, transfer)"
    - name: "movement_direction"
      expr: movement_direction
      comment: "Direction of movement (inbound, outbound, internal)"
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the movement transaction (posted, pending, cancelled)"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock involved in the movement"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the movement occurred"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether hazardous material was moved"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates whether the material is under quarantine"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this is a reversal transaction"
    - name: "posting_date"
      expr: DATE_TRUNC('day', posting_date)
      comment: "Date the movement was posted to inventory"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the movement was posted for monthly trending"
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the movement (e.g., scrap, rework, transfer)"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_value"
      expr: SUM(CAST(movement_amount AS DOUBLE))
      comment: "Total financial value of inventory movements"
    - name: "movement_transaction_count"
      expr: COUNT(1)
      comment: "Total number of inventory movement transactions"
    - name: "distinct_material_moved_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials involved in movements"
    - name: "distinct_lot_moved_count"
      expr: COUNT(DISTINCT lot_id)
      comment: "Number of distinct lots involved in movements (traceability metric)"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per movement transaction"
    - name: "avg_movement_value"
      expr: AVG(CAST(movement_amount AS DOUBLE))
      comment: "Average financial value per movement transaction"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions (data quality and process error indicator)"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that are reversals (process quality metric)"
    - name: "hazmat_movement_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of movements involving hazardous materials (compliance tracking)"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_quarantine_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold and quarantine metrics for compliance, quality risk management, and disposition cycle time analysis"
  source: "`chemical_mfg_ecm`.`inventory`.`quarantine_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the quarantine hold (active, released, rejected)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (quality, regulatory, safety, customer complaint)"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized reason code for the hold"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision (release, reject, rework, scrap)"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the hold was initiated"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the held material is hazardous"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the hold has been escalated"
    - name: "hold_month"
      expr: DATE_TRUNC('month', hold_date)
      comment: "Month the hold was initiated for trending"
    - name: "ghs_hazard_class"
      expr: ghs_hazard_class
      comment: "GHS hazard classification of the held material"
  measures:
    - name: "total_hold_quantity"
      expr: SUM(CAST(hold_quantity AS DOUBLE))
      comment: "Total quantity of material currently or previously under quarantine hold"
    - name: "total_quantity_released"
      expr: SUM(CAST(affected_quantity_released AS DOUBLE))
      comment: "Total quantity released from quarantine after disposition"
    - name: "total_quantity_rejected"
      expr: SUM(CAST(affected_quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected and not released (quality cost indicator)"
    - name: "hold_count"
      expr: COUNT(1)
      comment: "Total number of quarantine hold events"
    - name: "distinct_material_held_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials placed under hold (quality risk breadth)"
    - name: "distinct_lot_held_count"
      expr: COUNT(DISTINCT lot_id)
      comment: "Number of distinct lots placed under hold (traceability scope)"
    - name: "avg_hold_quantity"
      expr: AVG(CAST(hold_quantity AS DOUBLE))
      comment: "Average quantity per hold event"
    - name: "release_rate"
      expr: ROUND(100.0 * SUM(CAST(affected_quantity_released AS DOUBLE)) / NULLIF(SUM(CAST(hold_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of held quantity that was released (quality pass rate)"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(affected_quantity_rejected AS DOUBLE)) / NULLIF(SUM(CAST(hold_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of held quantity that was rejected (quality failure rate)"
    - name: "escalation_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds that required escalation (process complexity indicator)"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds requiring escalation (decision complexity metric)"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment and variance metrics for inventory accuracy, shrinkage analysis, and financial control monitoring"
  source: "`chemical_mfg_ecm`.`inventory`.`inventory_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (physical count, scrap, rework, write-off)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment (posted, pending approval, cancelled)"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment"
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP movement type code for the adjustment transaction"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the adjustment occurred"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the adjusted material is hazardous"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates whether the adjusted material was under quarantine"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this is a reversal adjustment"
    - name: "sox_threshold_exceeded"
      expr: sox_threshold_exceeded
      comment: "Indicates whether the adjustment exceeded SOX materiality threshold"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the adjustment was posted for trending"
  measures:
    - name: "total_adjustment_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity adjusted (positive and negative)"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_value AS DOUBLE))
      comment: "Total financial impact of inventory adjustments (shrinkage cost)"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of inventory adjustment transactions"
    - name: "distinct_material_adjusted_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials requiring adjustment (accuracy breadth)"
    - name: "avg_adjustment_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per adjustment transaction"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_value AS DOUBLE))
      comment: "Average financial impact per adjustment"
    - name: "sox_threshold_breach_count"
      expr: SUM(CASE WHEN sox_threshold_exceeded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of adjustments exceeding SOX materiality threshold (control risk)"
    - name: "sox_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sox_threshold_exceeded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments exceeding SOX threshold (financial control metric)"
    - name: "reversal_adjustment_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal adjustments (data quality indicator)"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_physical_inventory_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count and variance metrics for inventory accuracy measurement, cycle count effectiveness, and audit compliance"
  source: "`chemical_mfg_ecm`.`inventory`.`physical_inventory_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the physical count (counted, posted, approved, cancelled)"
    - name: "count_type"
      expr: count_type
      comment: "Type of count (annual, cycle, spot, wall-to-wall)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, barcode scan, RFID)"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the count results"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Indicates whether a recount was required"
    - name: "within_tolerance_flag"
      expr: within_tolerance_flag
      comment: "Indicates whether variance was within acceptable tolerance"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the counted material is hazardous"
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine status of the counted material"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the count"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the count"
    - name: "count_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month the count was performed for trending"
  measures:
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book quantity (system quantity before count)"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between book and counted quantity (accuracy gap)"
    - name: "total_inventory_valuation"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total financial value of counted inventory"
    - name: "count_transaction_count"
      expr: COUNT(1)
      comment: "Total number of physical count transactions"
    - name: "distinct_material_counted"
      expr: COUNT(DISTINCT stock_position_id)
      comment: "Number of distinct stock positions counted"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all counts (inventory accuracy metric)"
    - name: "inventory_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN within_tolerance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts within tolerance (inventory accuracy KPI)"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring recount (process quality indicator)"
    - name: "recount_count"
      expr: SUM(CASE WHEN recount_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of counts requiring recount"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot-level inventory and traceability metrics for shelf-life management, quality tracking, and regulatory compliance"
  source: "`chemical_mfg_ecm`.`inventory`.`lot`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current disposition status of the lot (released, blocked, restricted)"
    - name: "gmp_status"
      expr: gmp_status
      comment: "Good Manufacturing Practice status of the lot"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates whether the lot is under quarantine"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether the lot is subject to recall"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the lot contains hazardous material"
    - name: "restricted_substance_flag"
      expr: restricted_substance_flag
      comment: "Indicates whether the lot contains restricted substances"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the lot was manufactured or sourced"
    - name: "grade"
      expr: grade
      comment: "Quality grade of the lot"
    - name: "origin"
      expr: origin
      comment: "Origin classification of the lot (internal production, external purchase)"
    - name: "manufacture_month"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Month the lot was manufactured for aging analysis"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the lot expires for shelf-life planning"
  measures:
    - name: "total_initial_quantity"
      expr: SUM(CAST(initial_quantity AS DOUBLE))
      comment: "Total initial quantity across all lots at receipt"
    - name: "total_current_quantity"
      expr: SUM(CAST(current_quantity AS DOUBLE))
      comment: "Total current remaining quantity across all lots"
    - name: "total_inventory_value"
      expr: SUM(CAST(current_quantity AS DOUBLE) * CAST(inventory_valuation_price AS DOUBLE))
      comment: "Total financial value of current lot inventory"
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Total number of active lots"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active lots"
    - name: "avg_current_quantity_per_lot"
      expr: AVG(CAST(current_quantity AS DOUBLE))
      comment: "Average remaining quantity per lot"
    - name: "lot_consumption_rate"
      expr: ROUND(100.0 * (SUM(CAST(initial_quantity AS DOUBLE)) - SUM(CAST(current_quantity AS DOUBLE))) / NULLIF(SUM(CAST(initial_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of initial lot quantity that has been consumed (turnover indicator)"
    - name: "quarantine_lot_count"
      expr: SUM(CASE WHEN quarantine_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots currently under quarantine"
    - name: "recall_lot_count"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots subject to recall (quality risk metric)"
    - name: "hazmat_lot_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots containing hazardous materials (compliance tracking)"
    - name: "avg_purity_percent"
      expr: AVG(CAST(purity_percent AS DOUBLE))
      comment: "Average purity percentage across lots (quality metric)"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_tank_farm_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time tank inventory and utilization metrics for bulk chemical storage optimization, safety monitoring, and supply planning"
  source: "`chemical_mfg_ecm`.`inventory`.`tank_farm_level`"
  dimensions:
    - name: "tank_farm_name"
      expr: tank_farm_name
      comment: "Name of the tank farm facility"
    - name: "tank_id"
      expr: tank_id
      comment: "Unique identifier of the storage tank"
    - name: "cas_number"
      expr: cas_number
      comment: "CAS registry number of the stored chemical"
    - name: "ghs_hazard_category"
      expr: ghs_hazard_category
      comment: "GHS hazard category of the stored material"
    - name: "hazmat_storage_class"
      expr: hazmat_storage_class
      comment: "Hazmat storage classification"
    - name: "high_level_alarm"
      expr: high_level_alarm
      comment: "Indicates whether high-level alarm is active"
    - name: "low_level_alarm"
      expr: low_level_alarm
      comment: "Indicates whether low-level alarm is active"
    - name: "below_reorder_point_flag"
      expr: below_reorder_point_flag
      comment: "Indicates whether tank level is below reorder point"
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Indicates whether temperature is outside acceptable range"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source system for the level measurement (e.g., PI, SCADA)"
    - name: "measurement_quality"
      expr: measurement_quality
      comment: "Quality indicator of the measurement"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the measurement for time-series analysis"
  measures:
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of material stored across all tanks in cubic meters"
    - name: "total_mass_kg"
      expr: SUM(CAST(mass_kg AS DOUBLE))
      comment: "Total mass of material stored across all tanks in kilograms"
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value_usd AS DOUBLE))
      comment: "Total financial value of tank farm inventory in USD"
    - name: "total_tank_capacity_m3"
      expr: SUM(CAST(tank_capacity_m3 AS DOUBLE))
      comment: "Total storage capacity across all tanks in cubic meters"
    - name: "total_ullage_volume_m3"
      expr: SUM(CAST(ullage_volume_m3 AS DOUBLE))
      comment: "Total available (empty) volume across all tanks"
    - name: "avg_fill_percentage"
      expr: AVG(CAST(level_percent AS DOUBLE))
      comment: "Average fill percentage across all tanks (utilization metric)"
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average storage temperature across all tanks in Celsius"
    - name: "tank_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(volume_m3 AS DOUBLE)) / NULLIF(SUM(CAST(tank_capacity_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of total tank capacity currently utilized (capacity efficiency)"
    - name: "high_level_alarm_count"
      expr: SUM(CASE WHEN high_level_alarm = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tanks with active high-level alarms (safety risk indicator)"
    - name: "low_level_alarm_count"
      expr: SUM(CASE WHEN low_level_alarm = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tanks with active low-level alarms (supply risk indicator)"
    - name: "below_reorder_point_count"
      expr: SUM(CASE WHEN below_reorder_point_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tanks below reorder point (replenishment urgency)"
    - name: "temperature_deviation_count"
      expr: SUM(CASE WHEN temperature_deviation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tanks with temperature deviations (quality risk indicator)"
    - name: "distinct_tank_count"
      expr: COUNT(DISTINCT tank_id)
      comment: "Number of distinct tanks with measurements"
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Total number of tank level measurements"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_stock_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock reservation and allocation metrics for demand fulfillment analysis, order promising accuracy, and inventory commitment tracking"
  source: "`chemical_mfg_ecm`.`inventory`.`stock_reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the reservation (active, fulfilled, cancelled)"
    - name: "reservation_type"
      expr: reservation_type
      comment: "Type of reservation (sales order, production order, work order)"
    - name: "consuming_order_type"
      expr: consuming_order_type
      comment: "Type of order consuming the reservation"
    - name: "priority"
      expr: priority
      comment: "Priority level of the reservation"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the reservation is held"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether reserved material is hazardous"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates whether reserved material is under quarantine"
    - name: "oos_flag"
      expr: oos_flag
      comment: "Indicates whether reservation is out-of-stock"
    - name: "partial_fulfillment_allowed"
      expr: partial_fulfillment_allowed
      comment: "Indicates whether partial fulfillment is permitted"
    - name: "coa_required"
      expr: coa_required
      comment: "Indicates whether Certificate of Analysis is required"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Indicates whether material is REACH compliant"
    - name: "reservation_month"
      expr: DATE_TRUNC('month', reservation_date)
      comment: "Month the reservation was created for trending"
    - name: "requirement_month"
      expr: DATE_TRUNC('month', requirement_date)
      comment: "Month the material is required for demand planning"
  measures:
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all reservations"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled from reservations"
    - name: "total_reservation_value"
      expr: SUM(CAST(reserved_quantity AS DOUBLE) * CAST(valuation_price AS DOUBLE))
      comment: "Total financial value of reserved inventory"
    - name: "reservation_count"
      expr: COUNT(1)
      comment: "Total number of stock reservations"
    - name: "distinct_material_reserved_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active reservations"
    - name: "distinct_order_count"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of distinct orders with reservations"
    - name: "avg_reserved_quantity"
      expr: AVG(CAST(reserved_quantity AS DOUBLE))
      comment: "Average quantity per reservation"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(reserved_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of reserved quantity that has been fulfilled (order promising accuracy)"
    - name: "out_of_stock_reservation_count"
      expr: SUM(CASE WHEN oos_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reservations that are out-of-stock (supply risk indicator)"
    - name: "oos_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN oos_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that are out-of-stock (availability metric)"
    - name: "coa_required_count"
      expr: SUM(CASE WHEN coa_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reservations requiring Certificate of Analysis (compliance workload)"
$$;
