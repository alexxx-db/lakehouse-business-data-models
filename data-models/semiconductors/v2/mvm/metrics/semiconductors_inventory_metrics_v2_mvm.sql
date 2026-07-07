-- Metric views for domain: inventory | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_die_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank inventory metrics tracking die quantities, valuation, yield performance, and quality status for semiconductor wafer die inventory management."
  source: "`vibe_semiconductors_v1`.`inventory`.`die_bank`"
  dimensions:
    - name: "bank_status"
      expr: bank_status
      comment: "Current status of the die bank (e.g., available, reserved, on-hold)"
    - name: "die_bank_status"
      expr: die_bank_status
      comment: "Detailed die bank operational status"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Quality disposition status of the die bank"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die certification status"
    - name: "process_node"
      expr: process_node
      comment: "Semiconductor process technology node (e.g., 7nm, 5nm)"
    - name: "storage_form"
      expr: storage_form
      comment: "Physical storage form of the die (e.g., wafer, tape, tray)"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier used for die storage and transport"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL rating indicating moisture sensitivity classification"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicator if die bank is on quality or administrative hold"
    - name: "kgd_certified_flag"
      expr: kgd_certified_flag
      comment: "Boolean indicator if die bank has KGD certification"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Boolean indicator if die bank is consignment inventory"
    - name: "is_engineering_sample"
      expr: is_engineering_sample
      comment: "Boolean indicator if die bank contains engineering samples"
    - name: "entry_year"
      expr: YEAR(entry_date)
      comment: "Year the die bank was entered into inventory"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month the die bank was entered into inventory"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the die bank expires"
  measures:
    - name: "total_die_inventory_value_usd"
      expr: SUM(CAST(inventory_value_usd AS DOUBLE))
      comment: "Total USD valuation of die bank inventory - critical for financial reporting and asset management"
    - name: "total_die_count"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total count of all die units across die banks - key capacity and supply metric"
    - name: "total_available_die_quantity"
      expr: SUM(CAST(die_quantity AS DOUBLE))
      comment: "Total quantity of available die units ready for allocation to production or customer orders"
    - name: "avg_wafer_probe_yield_pct"
      expr: AVG(CAST(wafer_probe_yield_pct AS DOUBLE))
      comment: "Average wafer probe yield percentage - critical quality and manufacturing efficiency indicator"
    - name: "avg_die_value_usd"
      expr: AVG(CAST(die_value_usd AS DOUBLE))
      comment: "Average value per die in USD - key unit economics metric for pricing and margin analysis"
    - name: "total_die_value_usd"
      expr: SUM(CAST(die_value_usd AS DOUBLE))
      comment: "Total aggregate die value in USD across all die banks"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters - impacts cost per die and wafer utilization"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost of die bank inventory - used for cost accounting and variance analysis"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per die - key input for margin and profitability analysis"
    - name: "distinct_die_banks"
      expr: COUNT(DISTINCT die_bank_id)
      comment: "Count of unique die bank inventory records - tracks inventory fragmentation and management complexity"
    - name: "kgd_certified_die_banks"
      expr: SUM(CASE WHEN kgd_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of die banks with Known Good Die certification - quality assurance metric"
    - name: "die_banks_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of die banks currently on hold - risk and operational constraint indicator"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_finished_good`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished goods inventory metrics tracking packaged semiconductor product quantities, valuation, quality status, and compliance for customer fulfillment."
  source: "`vibe_semiconductors_v1`.`inventory`.`finished_good`"
  dimensions:
    - name: "finished_good_status"
      expr: finished_good_status
      comment: "Current status of the finished good inventory"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Detailed inventory availability status"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (e.g., active, EOL, obsolete)"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection and approval status"
    - name: "quality_disposition"
      expr: quality_disposition
      comment: "Quality disposition classification"
    - name: "lot_status"
      expr: lot_status
      comment: "Manufacturing lot status"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Product qualification and certification status"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL rating for moisture sensitivity"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture sensitivity device level classification"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Operating temperature grade classification (e.g., commercial, industrial, automotive)"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Performance speed grade classification"
    - name: "product_family"
      expr: product_family
      comment: "Product family grouping for portfolio analysis"
    - name: "device_type"
      expr: device_type
      comment: "Type of semiconductor device"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Manufacturing country of origin for trade compliance"
    - name: "aec_q_qualified"
      expr: aec_q_qualified
      comment: "Boolean indicator if product is AEC-Q qualified for automotive"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Boolean indicator of RoHS environmental compliance"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Boolean indicator of REACH chemical compliance"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Boolean indicator if product is ITAR export controlled"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicator if inventory is on hold"
    - name: "manufacture_year"
      expr: YEAR(manufacture_date)
      comment: "Year of manufacture"
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month of manufacture"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of expiration"
  measures:
    - name: "total_finished_goods_value_usd"
      expr: SUM(CAST(inventory_value_usd AS DOUBLE))
      comment: "Total USD valuation of finished goods inventory - critical balance sheet and working capital metric"
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost_usd AS DOUBLE))
      comment: "Total standard cost of finished goods inventory - used for cost accounting and margin analysis"
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost per finished good unit - key unit economics metric"
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average defective parts per million target - critical quality performance indicator"
    - name: "distinct_finished_goods"
      expr: COUNT(DISTINCT finished_good_id)
      comment: "Count of unique finished good inventory records - tracks SKU complexity and inventory breadth"
    - name: "aec_q_qualified_units"
      expr: SUM(CASE WHEN aec_q_qualified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of AEC-Q qualified automotive-grade units - automotive market readiness metric"
    - name: "rohs_compliant_units"
      expr: SUM(CASE WHEN rohs_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RoHS compliant units - environmental compliance metric for EU market access"
    - name: "itar_controlled_units"
      expr: SUM(CASE WHEN itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ITAR controlled units - export control risk and compliance metric"
    - name: "units_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of finished goods on quality or administrative hold - operational constraint indicator"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods movement transaction metrics tracking inventory transfers, shipments, receipts, and material flow for supply chain visibility and throughput analysis."
  source: "`vibe_semiconductors_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement transaction (e.g., receipt, issue, transfer, shipment)"
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the goods movement"
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Detailed goods movement processing status"
    - name: "document_type"
      expr: document_type
      comment: "Type of source document triggering the movement"
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Business reason code for the movement"
    - name: "reason_code"
      expr: reason_code
      comment: "Detailed reason classification for the movement"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock being moved (e.g., unrestricted, blocked, quality)"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicator for special stock categories (e.g., consignment, project)"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Test bin classification of the moved material"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean indicator if this is a reversal transaction"
    - name: "movement_year"
      expr: YEAR(movement_date)
      comment: "Year of the goods movement"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month of the goods movement"
    - name: "movement_quarter"
      expr: DATE_TRUNC('QUARTER', movement_date)
      comment: "Quarter of the goods movement"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Fiscal year of posting"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Fiscal month of posting"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Total quantity of goods moved - key throughput and material flow metric"
    - name: "total_movement_value_usd"
      expr: SUM(CAST(movement_value_usd AS DOUBLE))
      comment: "Total USD value of goods movements - critical for financial inventory accounting and working capital analysis"
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total USD value of all goods movements"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount for inventory accounting"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(movement_quantity AS DOUBLE))
      comment: "Average quantity per goods movement transaction - efficiency and batch size indicator"
    - name: "avg_movement_value_usd"
      expr: AVG(CAST(movement_value_usd AS DOUBLE))
      comment: "Average USD value per goods movement - transaction size and value concentration metric"
    - name: "distinct_movements"
      expr: COUNT(DISTINCT goods_movement_id)
      comment: "Count of unique goods movement transactions - activity volume and operational tempo metric"
    - name: "reversal_transactions"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal transactions - data quality and process error indicator"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer lot inventory metrics tracking work-in-process wafer lots, fabrication progress, yield, and valuation for fab operations management."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the wafer lot (e.g., in-process, completed, on-hold)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type classification of the wafer lot (e.g., production, engineering, qualification)"
    - name: "process_stage"
      expr: process_stage
      comment: "Current fabrication process stage of the wafer lot"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used for the wafer lot"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification for lot scheduling and expediting"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicator if wafer lot is on hold"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot hold status"
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in millimeters (e.g., 200mm, 300mm)"
    - name: "lot_start_year"
      expr: YEAR(lot_start_date)
      comment: "Year the wafer lot started fabrication"
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', lot_start_date)
      comment: "Month the wafer lot started fabrication"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Target year for lot completion"
    - name: "actual_completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Actual year of lot completion"
  measures:
    - name: "total_wafer_lot_valuation_usd"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total USD valuation of wafer lot WIP inventory - critical working capital and fab asset metric"
    - name: "avg_wafer_lot_valuation_usd"
      expr: AVG(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Average valuation per wafer lot - unit economics and cost accumulation indicator"
    - name: "distinct_wafer_lots"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Count of unique wafer lots in inventory - fab capacity utilization and WIP complexity metric"
    - name: "wafer_lots_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of wafer lots currently on hold - operational constraint and quality risk indicator"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_raw_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw material inventory metrics tracking chemical, substrate, and consumable materials for semiconductor fabrication supply chain management."
  source: "`vibe_semiconductors_v1`.`inventory`.`raw_material`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type classification of raw material (e.g., chemical, gas, substrate, consumable)"
    - name: "material_status"
      expr: material_status
      comment: "Current status of the raw material"
    - name: "raw_material_status"
      expr: raw_material_status
      comment: "Detailed raw material availability status"
    - name: "material_class"
      expr: material_class
      comment: "Material classification category"
    - name: "material_group"
      expr: material_group
      comment: "Material grouping for procurement and planning"
    - name: "material_grade"
      expr: material_grade
      comment: "Quality grade of the material (e.g., semiconductor grade, electronic grade)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Supplier and material qualification status"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazardous material classification for safety and compliance"
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Boolean indicator if material is hazardous"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Boolean indicator of RoHS environmental compliance"
    - name: "reach_svhc_flag"
      expr: reach_svhc_flag
      comment: "Boolean indicator if material contains REACH substances of very high concern"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Boolean indicator if material is ITAR export controlled"
    - name: "batch_managed"
      expr: batch_managed
      comment: "Boolean indicator if material requires batch/lot tracking"
    - name: "serialized"
      expr: serialized
      comment: "Boolean indicator if material requires serial number tracking"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Boolean indicator if incoming inspection is required"
    - name: "wafer_type"
      expr: wafer_type
      comment: "Type of wafer substrate (e.g., silicon, GaAs, SiC)"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage environmental conditions"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year of material receipt"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of material expiration"
  measures:
    - name: "total_raw_material_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of raw materials on hand - critical supply availability and procurement planning metric"
    - name: "total_raw_material_value_usd"
      expr: SUM(CAST(unit_cost_usd AS DOUBLE))
      comment: "Total USD value of raw material inventory - working capital and procurement spend metric"
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost_usd AS DOUBLE))
      comment: "Average unit cost of raw materials - cost trend and supplier performance indicator"
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price for cost accounting"
    - name: "avg_moving_avg_price"
      expr: AVG(CAST(moving_avg_price AS DOUBLE))
      comment: "Average moving average price - cost volatility and trend indicator"
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity across all materials - inventory policy and service level metric"
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity - supply chain risk buffer and resilience metric"
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average material purity percentage - quality and specification compliance indicator"
    - name: "avg_wafer_diameter_mm"
      expr: AVG(CAST(wafer_diameter_mm AS DOUBLE))
      comment: "Average wafer diameter for substrate materials - technology node and fab capability indicator"
    - name: "distinct_raw_materials"
      expr: COUNT(DISTINCT raw_material_id)
      comment: "Count of unique raw material SKUs - supply chain complexity and vendor management scope metric"
    - name: "hazardous_materials_count"
      expr: SUM(CASE WHEN hazardous_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazardous materials - EHS risk and compliance management metric"
    - name: "itar_controlled_materials_count"
      expr: SUM(CASE WHEN itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ITAR controlled materials - export control and compliance risk metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock balance snapshot metrics tracking inventory levels, availability, reservations, and valuation across all inventory types for working capital and supply chain optimization."
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "balance_type"
      expr: balance_type
      comment: "Type of stock balance (e.g., on-hand, reserved, in-transit)"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock classification type (e.g., unrestricted, blocked, quality)"
    - name: "batch_classification"
      expr: batch_classification
      comment: "Batch quality classification"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Test bin classification for semiconductor products"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status classification"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture sensitivity device level"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock category indicator (e.g., consignment, project)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation classification for accounting"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., FIFO, weighted average)"
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Required storage condition code"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Boolean indicator if stock is export controlled"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Boolean indicator if stock is hazardous material"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Boolean indicator of RoHS compliance"
    - name: "unrestricted_use_flag"
      expr: unrestricted_use_flag
      comment: "Boolean indicator if stock is available for unrestricted use"
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Boolean indicator if stock is slow-moving (inventory optimization flag)"
    - name: "balance_year"
      expr: YEAR(balance_date)
      comment: "Year of the stock balance snapshot"
    - name: "balance_month"
      expr: DATE_TRUNC('MONTH', balance_date)
      comment: "Month of the stock balance snapshot"
    - name: "last_movement_year"
      expr: YEAR(last_movement_date)
      comment: "Year of last inventory movement"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock locations - primary inventory availability metric for supply chain planning"
    - name: "total_quantity_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for allocation - critical ATP (available-to-promise) metric for order fulfillment"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved for orders or production - committed inventory and demand coverage metric"
    - name: "total_quantity_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity blocked from use - quality hold and operational constraint indicator"
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit between locations - supply chain pipeline and lead time metric"
    - name: "total_quantity_in_wip"
      expr: SUM(CAST(qty_in_wip AS DOUBLE))
      comment: "Total quantity in work-in-process - manufacturing pipeline and cycle time indicator"
    - name: "total_quantity_quality_inspection"
      expr: SUM(CAST(qty_quality_inspection AS DOUBLE))
      comment: "Total quantity in quality inspection - quality process throughput and hold metric"
    - name: "total_stock_value_usd"
      expr: SUM(CAST(total_value_usd AS DOUBLE))
      comment: "Total USD value of all stock balances - critical balance sheet and working capital metric for financial management"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount for inventory accounting"
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock AS DOUBLE))
      comment: "Total safety stock quantity - supply chain risk buffer and service level policy metric"
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity - procurement trigger and inventory policy metric"
    - name: "avg_safety_stock_level"
      expr: AVG(CAST(safety_stock_level AS DOUBLE))
      comment: "Average safety stock level - inventory policy and service level indicator"
    - name: "distinct_stock_balances"
      expr: COUNT(DISTINCT stock_balance_id)
      comment: "Count of unique stock balance records - inventory fragmentation and complexity metric"
    - name: "slow_moving_stock_count"
      expr: SUM(CASE WHEN slow_moving_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of slow-moving stock items - inventory optimization and obsolescence risk indicator"
    - name: "export_controlled_stock_count"
      expr: SUM(CASE WHEN export_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of export controlled stock items - trade compliance and regulatory risk metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity and utilization metrics tracking warehouse, cleanroom, and specialized storage facilities for inventory management and facility planning."
  source: "`vibe_semiconductors_v1`.`inventory`.`storage_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (e.g., warehouse, cleanroom, vault, staging)"
    - name: "location_status"
      expr: location_status
      comment: "Current operational status of the storage location"
    - name: "storage_location_status"
      expr: storage_location_status
      comment: "Detailed storage location availability status"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility housing the storage location"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "Cleanroom classification (e.g., Class 1, Class 10, Class 100)"
    - name: "cleanroom_iso_class"
      expr: cleanroom_iso_class
      comment: "ISO cleanroom classification standard"
    - name: "warehouse_zone"
      expr: warehouse_zone
      comment: "Warehouse zone classification for location management"
    - name: "storage_conditions"
      expr: storage_conditions
      comment: "Required environmental storage conditions"
    - name: "hazmat_classification"
      expr: hazmat_classification
      comment: "Hazardous material storage classification"
    - name: "msd_sensitivity_level"
      expr: msd_sensitivity_level
      comment: "Moisture sensitivity device storage capability level"
    - name: "esd_protection_class"
      expr: esd_protection_class
      comment: "Electrostatic discharge protection class"
    - name: "fire_suppression_type"
      expr: fire_suppression_type
      comment: "Type of fire suppression system"
    - name: "country_code"
      expr: country_code
      comment: "Country where storage location is situated"
    - name: "is_active"
      expr: is_active
      comment: "Boolean indicator if storage location is currently active"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Boolean indicator if location has temperature control"
    - name: "humidity_controlled_flag"
      expr: humidity_controlled_flag
      comment: "Boolean indicator if location has humidity control"
    - name: "esd_protected_flag"
      expr: esd_protected_flag
      comment: "Boolean indicator if location has ESD protection"
    - name: "hazmat_approved_flag"
      expr: hazmat_approved_flag
      comment: "Boolean indicator if location is approved for hazmat storage"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Boolean indicator if location is ITAR access controlled"
    - name: "kgd_storage_certified"
      expr: kgd_storage_certified
      comment: "Boolean indicator if location is certified for Known Good Die storage"
    - name: "nitrogen_purge_capable"
      expr: nitrogen_purge_capable
      comment: "Boolean indicator if location has nitrogen purge capability"
    - name: "photomask_storage_capable"
      expr: photomask_storage_capable
      comment: "Boolean indicator if location is suitable for photomask storage"
    - name: "wip_staging_area"
      expr: wip_staging_area
      comment: "Boolean indicator if location is a WIP staging area"
    - name: "commissioned_year"
      expr: YEAR(commissioned_date)
      comment: "Year the storage location was commissioned"
  measures:
    - name: "total_max_capacity_units"
      expr: SUM(CAST(max_capacity_units AS DOUBLE))
      comment: "Total maximum storage capacity across all locations - critical facility planning and expansion metric"
    - name: "avg_current_utilization_pct"
      expr: AVG(CAST(current_utilization_pct AS DOUBLE))
      comment: "Average storage utilization percentage - key facility efficiency and capacity planning indicator"
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum storage temperature - environmental control capability metric"
    - name: "avg_min_temperature_c"
      expr: AVG(CAST(min_temperature_c AS DOUBLE))
      comment: "Average minimum storage temperature - environmental control range indicator"
    - name: "avg_max_humidity_pct"
      expr: AVG(CAST(max_humidity_pct AS DOUBLE))
      comment: "Average maximum humidity percentage - environmental control specification"
    - name: "avg_weight_capacity_kg"
      expr: AVG(CAST(weight_capacity_kg AS DOUBLE))
      comment: "Average weight capacity in kilograms - structural capacity and safety metric"
    - name: "distinct_storage_locations"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Count of unique storage locations - facility footprint and complexity metric"
    - name: "active_storage_locations"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active storage locations - operational capacity availability metric"
    - name: "temperature_controlled_locations"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature controlled locations - specialized storage capability metric"
    - name: "esd_protected_locations"
      expr: SUM(CASE WHEN esd_protected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ESD protected locations - semiconductor-specific storage capability metric"
    - name: "hazmat_approved_locations"
      expr: SUM(CASE WHEN hazmat_approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazmat approved locations - chemical storage compliance and safety metric"
    - name: "itar_controlled_locations"
      expr: SUM(CASE WHEN itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ITAR controlled locations - export control and security compliance metric"
    - name: "kgd_certified_locations"
      expr: SUM(CASE WHEN kgd_storage_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of KGD certified storage locations - high-value die storage capability metric"
$$;