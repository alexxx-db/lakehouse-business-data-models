-- Metric views for domain: inventory | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_die_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank inventory KPIs tracking wafer-level die inventory, yield performance, quality status, and valuation for semiconductor manufacturing."
  source: "`vibe_semiconductors_v1`.`inventory`.`die_bank`"
  dimensions:
    - name: "die_bank_status"
      expr: die_bank_status
      comment: "Current status of the die bank (available, reserved, quarantined, scrapped)"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Quality bin classification of dies (e.g., bin 1 = highest quality, bin 2-N = lower grades)"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status indicating tested and verified quality level"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Physical carrier type used for die storage (waffle pack, gel pack, tape, etc.)"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL rating (1-6) indicating moisture sensitivity and required handling"
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Accounting method for inventory valuation (FIFO, LIFO, weighted average, standard cost)"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Flag indicating whether inventory is held on consignment from supplier"
    - name: "is_engineering_sample"
      expr: is_engineering_sample
      comment: "Flag indicating engineering sample vs production material"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS (Restriction of Hazardous Substances) compliance flag"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH (Registration, Evaluation, Authorization of Chemicals) compliance flag"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month when die bank shelf life expires"
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month when die bank was created"
    - name: "last_inspection_month"
      expr: DATE_TRUNC('MONTH', last_inspection_date)
      comment: "Month of last quality inspection"
  measures:
    - name: "total_die_inventory_value"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(quantity_available AS DOUBLE))
      comment: "Total inventory value of available dies (unit cost × available quantity)"
    - name: "total_available_die_quantity"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity of dies available for use"
    - name: "total_reserved_die_quantity"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity of dies reserved for specific orders or projects"
    - name: "total_scrapped_die_quantity"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity of dies scrapped due to quality or expiry issues"
    - name: "avg_wafer_probe_yield_pct"
      expr: AVG(CAST(wafer_probe_yield_pct AS DOUBLE))
      comment: "Average wafer probe yield percentage across die banks"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per die"
    - name: "inventory_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_reserved AS DOUBLE)) / NULLIF(SUM(CAST(quantity_initial AS DOUBLE)), 0), 2)
      comment: "Percentage of initial inventory that has been reserved (reserved / initial × 100)"
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_scrapped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_initial AS DOUBLE)), 0), 2)
      comment: "Percentage of initial inventory scrapped (scrapped / initial × 100)"
    - name: "die_bank_count"
      expr: COUNT(DISTINCT die_bank_id)
      comment: "Number of distinct die banks"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_finished_good`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished goods inventory KPIs tracking packaged semiconductor products, quality status, compliance, and inventory valuation."
  source: "`vibe_semiconductors_v1`.`inventory`.`finished_good`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (available, reserved, blocked, in transit, etc.)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (active, NRND, obsolete, discontinued)"
    - name: "package_type"
      expr: package_type
      comment: "Semiconductor package type (QFN, BGA, SOIC, DIP, etc.)"
    - name: "device_type"
      expr: device_type
      comment: "Device type classification (MCU, ASIC, FPGA, analog, power, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Product qualification status (qualified, in qualification, not qualified)"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Operating temperature grade (commercial, industrial, automotive, military)"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Performance speed grade classification"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture Sensitivity Level (MSL 1-6) for handling and storage"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag"
    - name: "aec_q_qualified"
      expr: aec_q_qualified
      comment: "AEC-Q automotive qualification flag"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR (International Traffic in Arms Regulations) controlled flag"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status flag"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where product was manufactured"
    - name: "shelf_life_expiry_month"
      expr: DATE_TRUNC('MONTH', shelf_life_expiry_date)
      comment: "Month when shelf life expires"
    - name: "eol_month"
      expr: DATE_TRUNC('MONTH', eol_date)
      comment: "End-of-life month for product"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(standard_cost AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total inventory value at standard cost (standard cost × quantity on hand)"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of finished goods on hand"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per unit"
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average defective parts per million target"
    - name: "finished_good_sku_count"
      expr: COUNT(DISTINCT finished_good_id)
      comment: "Number of distinct finished good SKUs"
    - name: "avg_storage_temp_max_c"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum storage temperature in Celsius"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods movement transaction KPIs tracking inventory flows, material transfers, consumption, and valuation changes across the supply chain."
  source: "`vibe_semiconductors_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (receipt, issue, transfer, adjustment, scrap, return)"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type classification (unrestricted, quality inspection, blocked, consignment)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement (production consumption, customer shipment, quality hold, etc.)"
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of reference document (purchase order, sales order, production order, transfer order)"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (consignment, project stock, pipeline, etc.)"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether this is a reversal transaction"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Quality bin classification of moved material"
    - name: "source_plant_code"
      expr: source_plant_code
      comment: "Source plant/facility code"
    - name: "destination_plant_code"
      expr: destination_plant_code
      comment: "Destination plant/facility code"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month when movement occurred"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when movement was posted to accounting"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of all movements"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per movement transaction"
    - name: "avg_valuation_amount"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation amount per movement transaction"
    - name: "movement_transaction_count"
      expr: COUNT(DISTINCT goods_movement_id)
      comment: "Number of distinct goods movement transactions"
    - name: "avg_unit_value"
      expr: AVG(CAST(valuation_amount AS DOUBLE) / NULLIF(CAST(quantity AS DOUBLE), 0))
      comment: "Average unit value (valuation amount / quantity)"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer lot inventory KPIs tracking work-in-process wafer lots, process stage, yield, cycle time, and valuation through fabrication."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of wafer lot (active, on hold, completed, scrapped)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot (production, engineering, qualification, pilot)"
    - name: "process_stage"
      expr: process_stage
      comment: "Current process stage (front-end, back-end, test, final)"
    - name: "process_node"
      expr: process_node
      comment: "Process technology node (e.g., 7nm, 14nm, 28nm, 65nm)"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (DUV, EUV, i-line, etc.)"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification for lot scheduling (hot, normal, low)"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Flag indicating whether lot is on hold"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot hold (quality, engineering, material shortage, etc.)"
    - name: "current_operation_step"
      expr: current_operation_step
      comment: "Current operation step in the process flow"
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', lot_start_date)
      comment: "Month when lot started fabrication"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Target month for lot completion"
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Actual month when lot was completed"
  measures:
    - name: "total_wip_valuation"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total work-in-process inventory valuation"
    - name: "total_current_wafer_count"
      expr: SUM(CAST(wafer_count_current AS DOUBLE))
      comment: "Total current wafer count across all lots"
    - name: "total_start_wafer_count"
      expr: SUM(CAST(wafer_count_start AS DOUBLE))
      comment: "Total starting wafer count across all lots"
    - name: "total_good_wafer_count"
      expr: SUM(CAST(good_wafer_count AS DOUBLE))
      comment: "Total good wafer count passing quality criteria"
    - name: "total_scrap_wafer_count"
      expr: SUM(CAST(scrap_wafer_count AS DOUBLE))
      comment: "Total scrapped wafer count"
    - name: "wafer_lot_count"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Number of distinct wafer lots in inventory"
    - name: "avg_wafer_count_per_lot"
      expr: AVG(CAST(wafer_count_current AS DOUBLE))
      comment: "Average wafer count per lot"
    - name: "wafer_yield_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(good_wafer_count AS DOUBLE)) / NULLIF(SUM(CAST(wafer_count_start AS DOUBLE)), 0), 2)
      comment: "Wafer yield rate percentage (good wafers / start wafers × 100)"
    - name: "wafer_scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_wafer_count AS DOUBLE)) / NULLIF(SUM(CAST(wafer_count_start AS DOUBLE)), 0), 2)
      comment: "Wafer scrap rate percentage (scrap wafers / start wafers × 100)"
    - name: "avg_valuation_per_lot"
      expr: AVG(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Average inventory valuation per wafer lot"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_raw_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw material inventory KPIs tracking wafers, chemicals, gases, and consumables used in semiconductor fabrication with quality, compliance, and reorder metrics."
  source: "`vibe_semiconductors_v1`.`inventory`.`raw_material`"
  dimensions:
    - name: "material_status"
      expr: material_status
      comment: "Current material status (active, blocked, obsolete, discontinued)"
    - name: "material_class"
      expr: material_class
      comment: "Material classification (wafer, chemical, gas, photomask, consumable)"
    - name: "material_group"
      expr: material_group
      comment: "Material group for categorization and reporting"
    - name: "wafer_type"
      expr: wafer_type
      comment: "Type of wafer (silicon, GaN, SiC, SOI, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Supplier/material qualification status (qualified, in qualification, not qualified)"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazardous material classification (flammable, toxic, corrosive, etc.)"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions (ambient, refrigerated, inert atmosphere, etc.)"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag"
    - name: "reach_svhc_flag"
      expr: reach_svhc_flag
      comment: "REACH Substance of Very High Concern flag"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR controlled material flag"
    - name: "batch_managed"
      expr: batch_managed
      comment: "Flag indicating batch/lot management requirement"
    - name: "serialized"
      expr: serialized
      comment: "Flag indicating serial number tracking requirement"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flag indicating incoming inspection requirement"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for material"
    - name: "lot_size_type"
      expr: lot_size_type
      comment: "Lot sizing method (fixed, variable, economic order quantity)"
  measures:
    - name: "total_inventory_value_moving_avg"
      expr: SUM(CAST(moving_avg_price AS DOUBLE) * CAST(reorder_point_qty AS DOUBLE))
      comment: "Total inventory value at moving average price (approximated using reorder point as proxy for on-hand)"
    - name: "total_inventory_value_standard"
      expr: SUM(CAST(standard_price AS DOUBLE) * CAST(reorder_point_qty AS DOUBLE))
      comment: "Total inventory value at standard price (approximated using reorder point as proxy for on-hand)"
    - name: "avg_moving_avg_price"
      expr: AVG(CAST(moving_avg_price AS DOUBLE))
      comment: "Average moving average price per material"
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price per material"
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity across all materials"
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across all materials"
    - name: "total_max_stock_qty"
      expr: SUM(CAST(max_stock_qty AS DOUBLE))
      comment: "Total maximum stock quantity across all materials"
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average material purity percentage"
    - name: "avg_wafer_diameter_mm"
      expr: AVG(CAST(wafer_diameter_mm AS DOUBLE))
      comment: "Average wafer diameter in millimeters"
    - name: "avg_resistivity_ohm_cm"
      expr: AVG(CAST(resistivity_ohm_cm AS DOUBLE))
      comment: "Average resistivity in ohm-centimeters for wafer materials"
    - name: "raw_material_sku_count"
      expr: COUNT(DISTINCT raw_material_id)
      comment: "Number of distinct raw material SKUs"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation KPIs tracking committed inventory for orders, projects, and production with fulfillment and allocation metrics."
  source: "`vibe_semiconductors_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current reservation status (active, fulfilled, expired, cancelled)"
    - name: "reservation_type"
      expr: reservation_type
      comment: "Type of reservation (sales order, production order, project, engineering)"
    - name: "priority"
      expr: priority
      comment: "Reservation priority level (high, normal, low)"
    - name: "reason"
      expr: reason
      comment: "Reason for reservation (customer order, production requirement, engineering sample, etc.)"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of reserved inventory (available, in transit, quality hold, etc.)"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Quality bin classification of reserved material"
    - name: "is_kgd"
      expr: is_kgd
      comment: "Known Good Die flag for reserved material"
    - name: "reservation_month"
      expr: DATE_TRUNC('MONTH', reservation_timestamp)
      comment: "Month when reservation was created"
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Requested delivery month for reserved material"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_timestamp)
      comment: "Month when reservation expires"
  measures:
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all reservations"
    - name: "avg_reserved_quantity"
      expr: AVG(CAST(reserved_quantity AS DOUBLE))
      comment: "Average quantity per reservation"
    - name: "reservation_count"
      expr: COUNT(DISTINCT reservation_id)
      comment: "Number of distinct reservations"
    - name: "unique_customers_with_reservations"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with active reservations"
    - name: "unique_products_reserved"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products with reservations"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock balance snapshot KPIs tracking on-hand, available, reserved, blocked, and in-transit inventory quantities with aging and turnover metrics."
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type classification (unrestricted, quality inspection, blocked, returns)"
    - name: "batch_classification"
      expr: batch_classification
      comment: "Batch quality classification"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Quality bin classification"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture Sensitivity Level"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (consignment, project, pipeline, etc.)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for accounting purposes"
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Required storage condition code"
    - name: "wafer_process_node"
      expr: wafer_process_node
      comment: "Process technology node for wafer inventory"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control restriction flag"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Hazardous material flag"
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Slow-moving inventory flag"
    - name: "unrestricted_use_flag"
      expr: unrestricted_use_flag
      comment: "Unrestricted use flag"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of inventory snapshot"
    - name: "shelf_life_expiry_month"
      expr: DATE_TRUNC('MONTH', shelf_life_expiry_date)
      comment: "Month when shelf life expires"
    - name: "last_goods_receipt_month"
      expr: DATE_TRUNC('MONTH', last_goods_receipt_date)
      comment: "Month of last goods receipt"
    - name: "last_goods_issue_month"
      expr: DATE_TRUNC('MONTH', last_goods_issue_date)
      comment: "Month of last goods issue"
  measures:
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock balances"
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for use (unrestricted and not reserved)"
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved for orders or projects"
    - name: "total_qty_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity blocked due to quality or other holds"
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit between locations"
    - name: "total_qty_in_wip"
      expr: SUM(CAST(qty_in_wip AS DOUBLE))
      comment: "Total quantity in work-in-process"
    - name: "total_qty_quality_inspection"
      expr: SUM(CAST(qty_quality_inspection AS DOUBLE))
      comment: "Total quantity in quality inspection"
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity across all materials"
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across all materials"
    - name: "inventory_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_available AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available (available / on-hand × 100)"
    - name: "inventory_reservation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_reserved AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is reserved (reserved / on-hand × 100)"
    - name: "inventory_blocked_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_blocked AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is blocked (blocked / on-hand × 100)"
    - name: "stock_balance_record_count"
      expr: COUNT(DISTINCT stock_balance_id)
      comment: "Number of distinct stock balance records"
    - name: "avg_qty_on_hand"
      expr: AVG(CAST(qty_on_hand AS DOUBLE))
      comment: "Average quantity on hand per stock balance record"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location KPIs tracking warehouse and cleanroom capacity, utilization, environmental compliance, and specialized storage capabilities."
  source: "`vibe_semiconductors_v1`.`inventory`.`storage_location`"
  dimensions:
    - name: "location_status"
      expr: location_status
      comment: "Current status of storage location (active, inactive, maintenance, decommissioned)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (warehouse, cleanroom, fab stockroom, OSAT partner, etc.)"
    - name: "cleanroom_iso_class"
      expr: cleanroom_iso_class
      comment: "ISO cleanroom classification (ISO 1-9)"
    - name: "access_restriction_level"
      expr: access_restriction_level
      comment: "Access restriction level (public, restricted, controlled, classified)"
    - name: "hazmat_classification"
      expr: hazmat_classification
      comment: "Hazardous material storage classification"
    - name: "esd_protection_class"
      expr: esd_protection_class
      comment: "Electrostatic discharge protection class"
    - name: "msd_sensitivity_level"
      expr: msd_sensitivity_level
      comment: "Moisture sensitivity level capability"
    - name: "fire_suppression_type"
      expr: fire_suppression_type
      comment: "Fire suppression system type (sprinkler, FM-200, inert gas, etc.)"
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Inventory valuation method used at this location"
    - name: "country_code"
      expr: country_code
      comment: "Country code where location is situated"
    - name: "is_osat_partner_location"
      expr: is_osat_partner_location
      comment: "Flag indicating OSAT (Outsourced Assembly and Test) partner location"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR controlled location flag"
    - name: "kgd_storage_certified"
      expr: kgd_storage_certified
      comment: "Known Good Die storage certification flag"
    - name: "msd_floor_life_capable"
      expr: msd_floor_life_capable
      comment: "MSD floor life tracking capability flag"
    - name: "nitrogen_purge_capable"
      expr: nitrogen_purge_capable
      comment: "Nitrogen purge capability flag"
    - name: "photomask_storage_capable"
      expr: photomask_storage_capable
      comment: "Photomask storage capability flag"
    - name: "shelf_life_tracking_enabled"
      expr: shelf_life_tracking_enabled
      comment: "Shelf life tracking enabled flag"
    - name: "wip_staging_area"
      expr: wip_staging_area
      comment: "Work-in-process staging area flag"
  measures:
    - name: "total_max_capacity_units"
      expr: SUM(CAST(max_capacity_units AS DOUBLE))
      comment: "Total maximum capacity across all storage locations"
    - name: "total_current_utilization_units"
      expr: SUM(CAST(current_utilization_units AS DOUBLE))
      comment: "Total current utilization across all storage locations"
    - name: "total_weight_capacity_kg"
      expr: SUM(CAST(weight_capacity_kg AS DOUBLE))
      comment: "Total weight capacity in kilograms"
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum temperature in Celsius"
    - name: "avg_min_temperature_c"
      expr: AVG(CAST(min_temperature_c AS DOUBLE))
      comment: "Average minimum temperature in Celsius"
    - name: "avg_max_humidity_pct"
      expr: AVG(CAST(max_humidity_pct AS DOUBLE))
      comment: "Average maximum humidity percentage"
    - name: "avg_min_humidity_pct"
      expr: AVG(CAST(min_humidity_pct AS DOUBLE))
      comment: "Average minimum humidity percentage"
    - name: "storage_location_count"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Number of distinct storage locations"
    - name: "capacity_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(current_utilization_units AS DOUBLE)) / NULLIF(SUM(CAST(max_capacity_units AS DOUBLE)), 0), 2)
      comment: "Overall capacity utilization rate (current utilization / max capacity × 100)"
    - name: "avg_capacity_per_location"
      expr: AVG(CAST(max_capacity_units AS DOUBLE))
      comment: "Average maximum capacity per storage location"
$$;