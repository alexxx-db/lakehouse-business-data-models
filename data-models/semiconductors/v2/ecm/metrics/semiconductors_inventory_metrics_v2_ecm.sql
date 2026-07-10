-- Metric views for domain: inventory | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for wafer lot management covering valuation, yield, cycle time, and lot status distribution. Used by fab operations, finance, and supply chain leadership to steer WIP throughput and inventory investment decisions."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the wafer lot (e.g. active, on-hold, completed, scrapped) for operational segmentation."
    - name: "lot_type"
      expr: lot_type
      comment: "Classification of the lot (e.g. production, engineering, qualification) to distinguish revenue-generating from non-revenue WIP."
    - name: "process_node"
      expr: process_node
      comment: "Technology node associated with the wafer lot, enabling cost and yield analysis by node generation."
    - name: "priority_class"
      expr: priority_class
      comment: "Lot priority classification (e.g. hot, normal, low) for queue management and cycle-time analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (e.g. EUV, DUV) for capacity and cost segmentation."
    - name: "lot_start_month"
      expr: DATE_TRUNC('month', lot_start_date)
      comment: "Month the lot was started, used for trend analysis of wafer starts over time."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is currently on hold, enabling hold-rate analysis."
    - name: "process_stage"
      expr: process_stage
      comment: "Current manufacturing stage of the lot (e.g. front-end, back-end) for WIP stage distribution analysis."
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in mm (e.g. 200mm, 300mm) for capacity and cost segmentation by wafer size."
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency in which the lot is valued, for multi-currency financial reporting."
  measures:
    - name: "total_wip_valuation_amount"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total financial value of all wafer lots in WIP. A primary balance-sheet KPI for inventory investment and fab loading decisions."
    - name: "avg_wip_valuation_per_lot"
      expr: AVG(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Average valuation per wafer lot. Tracks cost-per-lot trends and flags abnormal cost accumulation in WIP."
    - name: "active_lot_count"
      expr: COUNT(CASE WHEN lot_status = 'active' THEN inventory_wafer_lot_id END)
      comment: "Count of active wafer lots currently in production. Core fab throughput KPI used in daily operations reviews."
    - name: "on_hold_lot_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN inventory_wafer_lot_id END)
      comment: "Number of lots currently on hold. Elevated hold counts signal quality or compliance issues requiring immediate management action."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN inventory_wafer_lot_id END) / NULLIF(COUNT(inventory_wafer_lot_id), 0), 2)
      comment: "Percentage of wafer lots currently on hold. A quality and operational risk KPI — high hold rates directly impact delivery commitments and revenue."
    - name: "total_lot_count"
      expr: COUNT(inventory_wafer_lot_id)
      comment: "Total number of wafer lots tracked. Baseline volume metric for normalizing other KPIs and assessing fab loading."
    - name: "distinct_technology_nodes"
      expr: COUNT(DISTINCT fabrication_technology_node_id)
      comment: "Number of distinct technology nodes in active WIP. Indicates fab complexity and multi-node operational burden."
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(actual_completion_date, lot_start_date))
      comment: "Average cycle time in days from lot start to completion. A critical fab efficiency KPI — longer cycle times increase WIP inventory and delay revenue recognition."
    - name: "overdue_lot_count"
      expr: COUNT(CASE WHEN actual_completion_date > target_completion_date THEN inventory_wafer_lot_id END)
      comment: "Number of lots that completed after their target date. Directly impacts customer delivery commitments and revenue timing."
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date <= target_completion_date THEN inventory_wafer_lot_id END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN inventory_wafer_lot_id END), 0), 2)
      comment: "Percentage of completed lots delivered on or before target date. A key customer satisfaction and operational excellence KPI."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory stock position KPIs covering availability, quality inspection, safety stock compliance, and slow-moving inventory risk. Used by supply chain, finance, and operations leadership for inventory health and working capital management."
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g. unrestricted, quality inspection, blocked) for availability segmentation."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status of the stock, critical for die-level inventory quality classification."
    - name: "wafer_process_node"
      expr: wafer_process_node
      comment: "Process node associated with the stock, enabling node-level inventory analysis."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status of the stock, required for regulatory and customer compliance reporting."
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Indicates slow-moving inventory, a key working capital risk indicator."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous material stock requiring special handling and regulatory tracking."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Indicates export-controlled stock subject to ITAR/EAR restrictions."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Financial valuation class of the stock for cost accounting segmentation."
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month of the stock balance snapshot for trend analysis of inventory levels over time."
    - name: "unrestricted_use_flag"
      expr: unrestricted_use_flag
      comment: "Indicates whether stock is available for unrestricted use, a key availability dimension."
  measures:
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity of stock on hand across all locations. Primary inventory position KPI for supply planning and customer fulfillment."
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for allocation (unrestricted, not reserved). Directly drives order fulfillment capability."
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved against open orders. Indicates committed inventory and remaining free stock."
    - name: "total_qty_in_quality_inspection"
      expr: SUM(CAST(qty_quality_inspection AS DOUBLE))
      comment: "Total quantity currently under quality inspection. High values indicate quality bottlenecks impacting shipment readiness."
    - name: "total_qty_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity blocked from use (holds, quality issues). A risk KPI — high blocked quantities reduce effective supply."
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit between locations. Used for supply chain visibility and delivery timing analysis."
    - name: "total_qty_in_wip"
      expr: SUM(CAST(qty_in_wip AS DOUBLE))
      comment: "Total quantity currently in work-in-progress. A fab loading and cycle-time KPI tied to WIP inventory investment."
    - name: "safety_stock_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_available AS DOUBLE)) / NULLIF(SUM(CAST(safety_stock_qty AS DOUBLE)), 0), 2)
      comment: "Ratio of available quantity to safety stock target. Values below 100% signal supply risk and potential stockout exposure."
    - name: "reorder_point_breach_count"
      expr: COUNT(CASE WHEN qty_available < reorder_point_qty THEN stock_balance_id END)
      comment: "Number of stock records where available quantity has fallen below the reorder point. A procurement trigger KPI for supply continuity."
    - name: "slow_moving_stock_record_count"
      expr: COUNT(CASE WHEN slow_moving_flag = TRUE THEN stock_balance_id END)
      comment: "Number of stock records classified as slow-moving. Drives working capital reduction initiatives and excess inventory write-down decisions."
    - name: "avg_safety_stock_qty"
      expr: AVG(CAST(safety_stock_qty AS DOUBLE))
      comment: "Average safety stock quantity across records. Used to benchmark safety stock policy adequacy against demand variability."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial inventory valuation KPIs covering total stock value, cost composition (material, labor, overhead, NRE), valuation variance, and yield impact. Used by finance, cost accounting, and executive leadership for balance sheet management and cost control."
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g. standard cost, moving average) for cost accounting segmentation."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation record for financial classification and reporting."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (e.g. active, closed, pending) for period-end reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation for annual financial reporting and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the valuation for period-end close and trend analysis."
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory (e.g. raw material, WIP, finished goods) for balance sheet classification."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status for die-level valuation segmentation."
    - name: "is_consignment"
      expr: is_consignment
      comment: "Indicates consignment inventory, which has different balance sheet treatment."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Financial valuation class for cost center and GL account mapping."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Indicates SOX-controlled inventory records requiring audit trail and internal controls."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total financial value of inventory on hand. The primary balance-sheet inventory KPI used in financial close, audit, and executive reporting."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component of inventory value. Used for cost-of-goods-sold analysis and material cost trend monitoring."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of inventory value. Tracks fab labor absorption and cost efficiency."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component of inventory value. Used for overhead absorption analysis and cost center performance."
    - name: "total_nre_cost_allocation"
      expr: SUM(CAST(nre_cost_allocation AS DOUBLE))
      comment: "Total NRE (non-recurring engineering) cost allocated to inventory. Tracks design and tooling cost recovery against production volume."
    - name: "total_wip_cost_accumulation"
      expr: SUM(CAST(wip_cost_accumulation AS DOUBLE))
      comment: "Total cost accumulated in work-in-progress. A key WIP investment KPI for fab operations and financial planning."
    - name: "total_valuation_variance"
      expr: SUM(CAST(valuation_variance AS DOUBLE))
      comment: "Total variance between standard and actual inventory cost. Large variances trigger cost accounting investigations and standard cost updates."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across inventory records. Tracks cost trend and informs standard cost setting for the next period."
    - name: "avg_yield_impact_factor"
      expr: AVG(CAST(yield_impact_factor AS DOUBLE))
      comment: "Average yield impact factor on inventory valuation. Quantifies how yield losses translate into cost increases — a critical fab economics KPI."
    - name: "total_quantity_on_hand_valued"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand as recorded in valuation records. Used to reconcile physical inventory counts against financial records."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_die_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for die bank inventory covering probe yield, unit cost, die availability, and quality status. Used by product engineering, supply chain, and finance to manage die inventory value, quality, and fulfillment readiness."
  source: "`vibe_semiconductors_v1`.`inventory`.`die_bank`"
  dimensions:
    - name: "die_bank_status"
      expr: die_bank_status
      comment: "Current status of the die bank (e.g. available, reserved, on-hold, scrapped) for availability analysis."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die certification status — critical for determining which die inventory is shippable to customers."
    - name: "process_node"
      expr: process_node
      comment: "Technology process node of the die, enabling cost and yield analysis by node generation."
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification of the die (speed/power grade) for product mix and revenue optimization analysis."
    - name: "is_consignment"
      expr: is_consignment
      comment: "Indicates whether the die bank is held on consignment, affecting balance sheet treatment."
    - name: "is_engineering_sample"
      expr: is_engineering_sample
      comment: "Indicates engineering sample die banks, which are excluded from commercial revenue calculations."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status for regulatory and customer compliance reporting."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for regulatory and customer compliance reporting."
    - name: "creation_month"
      expr: DATE_TRUNC('month', creation_date)
      comment: "Month the die bank was created, for trend analysis of die inventory build-up over time."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier used for die storage (e.g. waffle pack, gel pack) for handling and logistics planning."
  measures:
    - name: "total_die_bank_value"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(bin_class AS DOUBLE))
      comment: "Total estimated value of die bank inventory (unit cost × bin class quantity proxy). A balance-sheet KPI for die inventory investment."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per die bank record. Tracks die cost trends by node and process, informing pricing and margin decisions."
    - name: "avg_wafer_probe_yield_pct"
      expr: AVG(CAST(wafer_probe_yield_pct AS DOUBLE))
      comment: "Average wafer probe yield percentage across die banks. A primary fab quality and economics KPI — yield directly drives die cost and gross margin."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in mm². Larger die sizes increase cost per wafer and reduce gross margin — a key product economics metric."
    - name: "total_die_bank_records"
      expr: COUNT(die_bank_id)
      comment: "Total number of die bank records. Baseline volume metric for die inventory breadth and portfolio complexity."
    - name: "kgd_certified_die_bank_count"
      expr: COUNT(CASE WHEN kgd_status = 'certified' THEN die_bank_id END)
      comment: "Number of die banks with KGD certification. KGD-certified die commands premium pricing and is required for advanced packaging customers."
    - name: "quality_hold_die_bank_count"
      expr: COUNT(CASE WHEN quality_hold_reason IS NOT NULL THEN die_bank_id END)
      comment: "Number of die banks under quality hold. Directly impacts available supply and customer delivery commitments."
    - name: "avg_storage_temperature_max_c"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum storage temperature requirement across die banks. Used for storage facility planning and compliance with die storage specifications."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_consignment_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for consignment inventory management covering consigned value, consumption rates, liability aging, and compliance status. Used by supply chain, finance, and legal to manage supplier consignment obligations and working capital."
  source: "`vibe_semiconductors_v1`.`inventory`.`consignment_stock`"
  dimensions:
    - name: "consignment_status"
      expr: consignment_status
      comment: "Current status of the consignment (e.g. active, expired, settled) for lifecycle management."
    - name: "consignment_type"
      expr: consignment_type
      comment: "Type of consignment arrangement (e.g. supplier-owned, customer-owned) for financial and legal classification."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status of consigned inventory for quality and pricing segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the consignment valuation for multi-currency financial reporting."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status of consigned inventory for regulatory reporting."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status of consigned inventory for customer and regulatory compliance."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance monitoring of consigned inventory."
    - name: "consignment_start_month"
      expr: DATE_TRUNC('month', consignment_start_date)
      comment: "Month the consignment arrangement started, for aging and trend analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of consigned inventory for trade compliance and tariff analysis."
  measures:
    - name: "total_consigned_quantity"
      expr: SUM(CAST(consigned_quantity AS DOUBLE))
      comment: "Total quantity of inventory held on consignment. Measures the scale of supplier-owned inventory on premises — a key working capital and liability metric."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available from consignment stock. Drives fulfillment planning and supplier replenishment triggers."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed from consignment. Determines payment obligations to suppliers under consignment agreements."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total quantity returned to suppliers from consignment. Tracks consignment efficiency and supplier relationship health."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total consignment quantity currently in transit. Used for supply chain visibility and liability timing."
    - name: "total_valuation_amount"
      expr: SUM(CAST(total_valuation_amount AS DOUBLE))
      comment: "Total financial value of consignment inventory. A balance-sheet liability KPI — represents supplier-owned inventory that becomes payable upon consumption."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per consignment record. Used for cost benchmarking and supplier price negotiation."
    - name: "consumption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(consumed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(consigned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of consigned inventory consumed. Low consumption rates indicate excess consignment liability and potential write-off risk."
    - name: "expiring_consignment_count"
      expr: COUNT(CASE WHEN consignment_expiry_date <= CURRENT_DATE() THEN consignment_stock_id END)
      comment: "Number of consignment records at or past expiry date. Expired consignments create financial liability and compliance risk requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for goods movement transactions covering transaction volume, valuation, reversal rates, and movement type distribution. Used by supply chain, finance, and operations to monitor inventory flow efficiency and financial accuracy."
  source: "`vibe_semiconductors_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (e.g. goods receipt, goods issue, transfer) for transaction classification and analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type involved in the movement (e.g. unrestricted, quality inspection) for inventory flow analysis."
    - name: "movement_month"
      expr: DATE_TRUNC('month', movement_date)
      comment: "Month of the goods movement for trend analysis of inventory flow over time."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the movement was posted to the ledger, for financial period reconciliation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the movement is a reversal transaction. High reversal rates signal process errors or fraud risk."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the goods movement, enabling root cause analysis of inventory adjustments."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (e.g. consignment, project stock) for specialized inventory flow tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the goods movement quantity."
  measures:
    - name: "total_movement_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total financial value of all goods movements. A core inventory flow KPI used in financial close and cost-of-goods-sold calculation."
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all goods movement transactions. Measures inventory throughput and fab material consumption."
    - name: "avg_movement_valuation_amount"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation per goods movement transaction. Tracks unit cost trends and flags abnormal transaction values."
    - name: "total_movement_count"
      expr: COUNT(goods_movement_id)
      comment: "Total number of goods movement transactions. Baseline volume metric for process load and system activity."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN goods_movement_id END)
      comment: "Number of reversal transactions. High reversal counts indicate data quality issues, process errors, or potential fraud — a key internal controls KPI."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN goods_movement_id END) / NULLIF(COUNT(goods_movement_id), 0), 2)
      comment: "Percentage of goods movements that are reversals. A process quality and financial accuracy KPI — high rates trigger audit and process improvement actions."
    - name: "total_reversal_valuation_amount"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN valuation_amount ELSE 0 END)
      comment: "Total financial value of reversed goods movements. Quantifies the financial impact of transaction errors and corrections."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for inventory lot hold management covering hold volume, hold types, regulatory holds, and disposition outcomes. Used by quality, operations, and compliance leadership to manage hold risk, cycle time, and regulatory exposure."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g. open, released, escalated) for hold lifecycle management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (e.g. quality, engineering, regulatory, customer) for root cause and responsibility analysis."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific reason code for the hold, enabling Pareto analysis of hold causes."
    - name: "hold_disposition"
      expr: hold_disposition
      comment: "Disposition outcome of the hold (e.g. use-as-is, rework, scrap) for yield and cost impact analysis."
    - name: "is_regulatory_hold"
      expr: is_regulatory_hold
      comment: "Indicates regulatory holds (ITAR, export control) requiring compliance escalation."
    - name: "hold_priority"
      expr: hold_priority
      comment: "Priority level of the hold for queue management and escalation decisions."
    - name: "hold_month"
      expr: DATE_TRUNC('month', hold_date)
      comment: "Month the hold was initiated for trend analysis of hold frequency over time."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code assigned to the hold for systemic quality improvement analysis."
  measures:
    - name: "total_hold_count"
      expr: COUNT(inventory_lot_hold_id)
      comment: "Total number of lot holds. Baseline KPI for quality and operational risk — high hold counts signal systemic process issues."
    - name: "open_hold_count"
      expr: COUNT(CASE WHEN hold_status = 'open' THEN inventory_lot_hold_id END)
      comment: "Number of currently open holds. A real-time operational risk KPI — open holds block production and shipment."
    - name: "regulatory_hold_count"
      expr: COUNT(CASE WHEN is_regulatory_hold = TRUE THEN inventory_lot_hold_id END)
      comment: "Number of regulatory holds (ITAR, export control, trade compliance). Regulatory holds carry legal and financial penalties — a critical compliance KPI."
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defects per million parts (DPPM) value across held lots. A primary quality KPI — high DPPM drives customer escapes and warranty costs."
    - name: "hold_release_cycle_time_days"
      expr: AVG(DATEDIFF(hold_release_date, hold_date))
      comment: "Average number of days from hold initiation to release. Long hold cycle times delay shipments and increase WIP inventory cost."
    - name: "regulatory_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_hold = TRUE THEN inventory_lot_hold_id END) / NULLIF(COUNT(inventory_lot_hold_id), 0), 2)
      comment: "Percentage of holds that are regulatory in nature. Elevated regulatory hold rates signal export compliance or trade compliance systemic issues."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_kgd_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Known Good Die (KGD) certification covering probe yield, electrical test pass rates, burn-in results, and certification status. Used by product engineering, quality, and sales to manage KGD supply quality and premium product availability."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current KGD certification status (e.g. certified, pending, failed, expired) for supply availability analysis."
    - name: "kgd_grade"
      expr: kgd_grade
      comment: "KGD quality grade assigned to the die bank, used for product tiering and pricing decisions."
    - name: "burn_in_test_result"
      expr: burn_in_test_result
      comment: "Result of burn-in reliability screening (pass/fail) for reliability risk assessment."
    - name: "reliability_screen_result"
      expr: reliability_screen_result
      comment: "Result of reliability screening for advanced packaging qualification."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Indicates KGD lots under quality hold, blocking shipment to customers."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance monitoring of KGD inventory."
    - name: "certification_month"
      expr: DATE_TRUNC('month', certification_date)
      comment: "Month of KGD certification for trend analysis of certification throughput."
    - name: "packaging_application"
      expr: packaging_application
      comment: "Target packaging application (e.g. flip-chip, wire bond, 2.5D) for KGD supply planning by package type."
  measures:
    - name: "avg_probe_yield_pct"
      expr: AVG(CAST(probe_yield_pct AS DOUBLE))
      comment: "Average probe yield percentage across KGD certifications. The primary KGD quality KPI — directly determines die cost and gross margin for advanced packaging customers."
    - name: "avg_electrical_test_pass_rate_pct"
      expr: AVG(CAST(electrical_test_pass_rate_pct AS DOUBLE))
      comment: "Average electrical test pass rate for KGD lots. A key quality KPI for KGD supply — low pass rates reduce available KGD supply and increase cost."
    - name: "avg_dppm_rate"
      expr: AVG(CAST(dppm_rate AS DOUBLE))
      comment: "Average DPPM rate for KGD certified lots. KGD customers (advanced packaging, chiplet) require ultra-low DPPM — this KPI drives quality improvement priorities."
    - name: "total_certifications"
      expr: COUNT(inventory_kgd_certification_id)
      comment: "Total number of KGD certification records. Baseline throughput metric for KGD supply pipeline."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'certified' THEN inventory_kgd_certification_id END)
      comment: "Number of currently active KGD certifications. Directly represents available certified KGD supply for customer orders."
    - name: "quality_hold_certification_count"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN inventory_kgd_certification_id END)
      comment: "Number of KGD certifications under quality hold. Holds block premium KGD supply and directly impact revenue from advanced packaging customers."
    - name: "burn_in_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN burn_in_test_result = 'pass' THEN inventory_kgd_certification_id END) / NULLIF(COUNT(CASE WHEN burn_in_test_result IS NOT NULL THEN inventory_kgd_certification_id END), 0), 2)
      comment: "Percentage of KGD lots passing burn-in reliability screening. Burn-in pass rate is a reliability quality gate — failures indicate infant mortality risk in customer applications."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_finished_good`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for finished goods inventory covering stock value, qualification status, compliance, lifecycle, and quality metrics. Used by sales, supply chain, and finance to manage product availability, compliance posture, and revenue readiness."
  source: "`vibe_semiconductors_v1`.`inventory`.`finished_good`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status of the finished good (e.g. available, reserved, blocked) for fulfillment analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle status (e.g. active, EOL, NRND) for portfolio management and last-time-buy planning."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Product qualification status (e.g. qualified, in-qualification, failed) for customer design-win readiness."
    - name: "package_type"
      expr: package_type
      comment: "Package type of the finished good for supply planning and customer specification matching."
    - name: "product_family"
      expr: product_family
      comment: "Product family for portfolio-level inventory and revenue analysis."
    - name: "aec_q_qualified"
      expr: aec_q_qualified
      comment: "AEC-Q automotive qualification status — automotive customers require this for design-in approval."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for regulatory and customer compliance reporting."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status for regulatory and customer compliance reporting."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance monitoring."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Temperature grade of the finished good (e.g. commercial, industrial, automotive) for market segmentation."
  measures:
    - name: "total_standard_cost_value"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost value of finished goods inventory. Primary balance-sheet KPI for finished goods investment and COGS planning."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per finished good record. Tracks cost trends by product family and package type for pricing and margin management."
    - name: "total_finished_good_count"
      expr: COUNT(finished_good_id)
      comment: "Total number of finished good inventory records. Baseline portfolio breadth metric."
    - name: "aec_q_qualified_count"
      expr: COUNT(CASE WHEN aec_q_qualified = TRUE THEN finished_good_id END)
      comment: "Number of AEC-Q qualified finished goods. Automotive-qualified inventory commands premium pricing and is required for automotive customer fulfillment."
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average DPPM target across finished goods. Tracks quality commitment levels by product and customer segment."
    - name: "eol_product_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'EOL' THEN finished_good_id END)
      comment: "Number of end-of-life finished goods still in inventory. EOL inventory represents write-down risk and requires last-time-buy management."
    - name: "storage_temperature_max_avg_c"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum storage temperature requirement across finished goods. Used for warehouse facility planning and compliance with product storage specifications."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_photomask_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for photomask asset management covering asset valuation, NRE cost, defect rates, usage lifecycle, and qualification status. Used by fab operations, finance, and engineering to manage mask asset investment, quality, and lifecycle decisions."
  source: "`vibe_semiconductors_v1`.`inventory`.`photomask_asset`"
  dimensions:
    - name: "mask_status"
      expr: mask_status
      comment: "Current status of the photomask (e.g. active, retired, under-inspection) for asset lifecycle management."
    - name: "mask_type"
      expr: mask_type
      comment: "Type of photomask (e.g. reticle, pellicle) for asset classification and cost analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (e.g. EUV, DUV, i-line) for mask cost and technology investment analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node the mask is designed for, enabling node-level mask investment analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the mask for quality and maintenance planning."
    - name: "is_mpw_mask"
      expr: is_mpw_mask
      comment: "Indicates multi-project wafer masks, which have different cost sharing and ownership structures."
    - name: "pellicle_present"
      expr: pellicle_present
      comment: "Indicates whether a pellicle is present on the mask, affecting defect risk and inspection requirements."
    - name: "manufacture_month"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Month the mask was manufactured for asset age and depreciation analysis."
    - name: "mask_substrate_material"
      expr: mask_substrate_material
      comment: "Substrate material of the mask (e.g. quartz, chrome) for material cost and quality analysis."
  measures:
    - name: "total_asset_valuation_usd"
      expr: SUM(CAST(asset_valuation_usd AS DOUBLE))
      comment: "Total financial value of photomask assets. A capital asset KPI — photomasks represent significant NRE investment that must be tracked for depreciation and write-off decisions."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost invested in photomask assets. Tracks design and mask tooling investment by technology node and customer program."
    - name: "avg_asset_valuation_usd"
      expr: AVG(CAST(asset_valuation_usd AS DOUBLE))
      comment: "Average valuation per photomask asset. Benchmarks mask cost by lithography type and technology node for investment planning."
    - name: "avg_cd_uniformity_nm"
      expr: AVG(CAST(cd_uniformity_nm AS DOUBLE))
      comment: "Average critical dimension uniformity in nanometers. A key mask quality KPI — poor CD uniformity causes yield loss and requires mask replacement."
    - name: "avg_registration_error_nm"
      expr: AVG(CAST(registration_error_nm AS DOUBLE))
      comment: "Average mask registration error in nanometers. Registration errors cause overlay failures and yield loss — a critical mask quality KPI."
    - name: "avg_meef_value"
      expr: AVG(CAST(meef_value AS DOUBLE))
      comment: "Average mask error enhancement factor (MEEF). High MEEF values indicate process sensitivity to mask defects, driving mask quality requirements."
    - name: "avg_mask_size_mm"
      expr: AVG(CAST(mask_size_mm AS DOUBLE))
      comment: "Average mask size in mm. Used for storage capacity planning and handling equipment requirements."
    - name: "total_mask_asset_count"
      expr: COUNT(photomask_asset_id)
      comment: "Total number of photomask assets under management. Baseline metric for mask fleet size and management complexity."
    - name: "avg_storage_humidity_pct"
      expr: AVG(CAST(storage_humidity_pct AS DOUBLE))
      comment: "Average storage humidity for photomask assets. Humidity control is critical for mask preservation — deviations cause defects and asset write-offs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_physical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for physical inventory count accuracy covering variance rates, count completion, and financial accuracy. Used by finance, operations, and audit to manage inventory accuracy, SOX compliance, and write-down risk."
  source: "`vibe_semiconductors_v1`.`inventory`.`physical_inventory`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the physical count (e.g. in-progress, completed, approved) for count lifecycle management."
    - name: "count_type"
      expr: count_type
      comment: "Type of physical count (e.g. annual, cycle count, spot check) for count methodology analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the physical inventory count for annual compliance and audit reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the count for period-end close and trend analysis."
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory counted (e.g. raw material, WIP, finished goods) for category-level accuracy analysis."
    - name: "variance_exceeds_tolerance_flag"
      expr: variance_exceeds_tolerance_flag
      comment: "Indicates counts where variance exceeds tolerance threshold — a key audit and financial accuracy flag."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Indicates records requiring recount due to initial count discrepancy."
    - name: "freeze_flag"
      expr: freeze_flag
      comment: "Indicates inventory frozen for counting, preventing movements during the count period."
    - name: "count_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of the physical count for trend analysis of count frequency and accuracy over time."
  measures:
    - name: "total_variance_value_usd"
      expr: SUM(CAST(variance_value_usd AS DOUBLE))
      comment: "Total financial value of inventory variances discovered during physical counts. A primary financial accuracy KPI — large variances trigger write-downs and audit findings."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between book and counted inventory. Measures physical inventory accuracy and process control effectiveness."
    - name: "avg_variance_tolerance_pct"
      expr: AVG(CAST(variance_tolerance_pct AS DOUBLE))
      comment: "Average variance tolerance percentage across count records. Used to assess whether tolerance policies are appropriately calibrated for inventory risk."
    - name: "tolerance_breach_count"
      expr: COUNT(CASE WHEN variance_exceeds_tolerance_flag = TRUE THEN physical_inventory_id END)
      comment: "Number of count records where variance exceeds tolerance. Tolerance breaches require investigation and financial adjustment — a key audit and SOX KPI."
    - name: "tolerance_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_exceeds_tolerance_flag = TRUE THEN physical_inventory_id END) / NULLIF(COUNT(physical_inventory_id), 0), 2)
      comment: "Percentage of count records with variance exceeding tolerance. A primary inventory accuracy KPI — high breach rates indicate systemic inventory control failures."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost_usd AS DOUBLE))
      comment: "Total standard cost value of physically counted inventory. Used to reconcile physical count results against book value for financial close."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_flag = TRUE THEN physical_inventory_id END) / NULLIF(COUNT(physical_inventory_id), 0), 2)
      comment: "Percentage of count records requiring recount. High recount rates indicate counting process quality issues and increase count cycle time and cost."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_raw_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for raw material inventory management covering stock levels, cost, compliance, and quality status. Used by supply chain, procurement, and quality to manage material availability, supplier qualification, and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`inventory`.`raw_material`"
  dimensions:
    - name: "material_status"
      expr: material_status
      comment: "Current status of the raw material (e.g. active, discontinued, blocked) for supply planning."
    - name: "material_class"
      expr: material_class
      comment: "Classification of the raw material (e.g. chemical, substrate, gas) for category-level analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group for procurement category management and spend analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Supplier qualification status for the material — unqualified materials cannot be used in production."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for regulatory and customer compliance reporting."
    - name: "reach_svhc_flag"
      expr: reach_svhc_flag
      comment: "Indicates REACH SVHC (substance of very high concern) materials requiring regulatory disclosure."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance monitoring of raw materials."
    - name: "price_control_type"
      expr: price_control_type
      comment: "Price control method (standard vs. moving average) for cost accounting segmentation."
    - name: "wafer_type"
      expr: wafer_type
      comment: "Type of wafer material (e.g. silicon, SOI, SiC) for substrate cost and supply analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance, tariff analysis, and supply chain diversification."
  measures:
    - name: "total_standard_price_value"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Total standard price value across raw material records. A procurement cost baseline KPI for budget planning and supplier negotiation."
    - name: "avg_moving_avg_price"
      expr: AVG(CAST(moving_avg_price AS DOUBLE))
      comment: "Average moving average price across raw materials. Tracks actual material cost trends versus standard, informing cost variance analysis."
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average purity percentage of raw materials. Material purity directly impacts process yield and device performance — a critical quality KPI."
    - name: "avg_wafer_diameter_mm"
      expr: AVG(CAST(wafer_diameter_mm AS DOUBLE))
      comment: "Average wafer diameter across raw material records. Tracks substrate mix (200mm vs 300mm) for capacity and cost planning."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across raw materials. Measures supply buffer investment and risk mitigation posture."
    - name: "total_max_stock_qty"
      expr: SUM(CAST(max_stock_qty AS DOUBLE))
      comment: "Total maximum stock quantity across raw materials. Used for warehouse capacity planning and working capital ceiling analysis."
    - name: "reach_svhc_material_count"
      expr: COUNT(CASE WHEN reach_svhc_flag = TRUE THEN raw_material_id END)
      comment: "Number of raw materials classified as REACH SVHC. SVHC materials require regulatory disclosure and substitution planning — a compliance risk KPI."
    - name: "unqualified_material_count"
      expr: COUNT(CASE WHEN qualification_status != 'qualified' THEN raw_material_id END)
      comment: "Number of raw materials not yet qualified for production use. Unqualified materials cannot be used in production — a supply readiness risk KPI."
    - name: "avg_resistivity_ohm_cm"
      expr: AVG(CAST(resistivity_ohm_cm AS DOUBLE))
      comment: "Average resistivity of raw materials in ohm-cm. Resistivity is a critical substrate specification — deviations cause device performance failures."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_lot_genealogy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for lot genealogy and traceability covering yield at transformation, scrap rates, rework cycles, and genealogy completeness. Used by quality, operations, and compliance to manage lot traceability, yield loss root cause, and regulatory traceability requirements."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy`"
  dimensions:
    - name: "genealogy_status"
      expr: genealogy_status
      comment: "Status of the genealogy record (e.g. complete, incomplete, under-review) for traceability completeness analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of genealogy relationship (e.g. split, merge, transform) for lot flow analysis."
    - name: "parent_entity_type"
      expr: parent_entity_type
      comment: "Type of the parent entity in the genealogy (e.g. wafer lot, die bank) for traceability chain analysis."
    - name: "child_entity_type"
      expr: child_entity_type
      comment: "Type of the child entity in the genealogy for downstream traceability analysis."
    - name: "kgd_status"
      expr: kgd_status
      comment: "KGD status at the genealogy record level for quality traceability."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Indicates genealogy records associated with quality holds for root cause traceability."
    - name: "automotive_ppap_required"
      expr: automotive_ppap_required
      comment: "Indicates lots requiring automotive PPAP documentation — a compliance and customer requirement flag."
    - name: "transformation_month"
      expr: DATE_TRUNC('month', transformation_timestamp)
      comment: "Month of the lot transformation for trend analysis of production flow over time."
  measures:
    - name: "avg_yield_at_transformation_pct"
      expr: AVG(CAST(yield_at_transformation_pct AS DOUBLE))
      comment: "Average yield percentage at each lot transformation step. The primary lot genealogy quality KPI — yield losses at each step compound to determine final die cost and gross margin."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped across all lot transformations. Scrap directly reduces revenue-generating output and increases unit cost — a key yield and cost KPI."
    - name: "total_quantity_in"
      expr: SUM(CAST(quantity_in AS DOUBLE))
      comment: "Total input quantity across all lot transformations. Used as the denominator for overall yield calculation."
    - name: "total_quantity_out"
      expr: SUM(CAST(quantity_out AS DOUBLE))
      comment: "Total output quantity across all lot transformations. Used with quantity_in to calculate overall process yield."
    - name: "overall_transformation_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_out AS DOUBLE)) / NULLIF(SUM(CAST(quantity_in AS DOUBLE)), 0), 2)
      comment: "Overall yield across all lot transformations (output/input). A composite fab efficiency KPI — directly determines die cost, gross margin, and capacity utilization."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_in AS DOUBLE)), 0), 2)
      comment: "Percentage of input quantity scrapped across transformations. High scrap rates signal process control failures and directly erode gross margin."
    - name: "quality_hold_genealogy_count"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN inventory_lot_genealogy_id END)
      comment: "Number of genealogy records associated with quality holds. Used for root cause traceability and containment effectiveness analysis."
    - name: "ppap_required_lot_count"
      expr: COUNT(CASE WHEN automotive_ppap_required = TRUE THEN inventory_lot_genealogy_id END)
      comment: "Number of genealogy records requiring automotive PPAP documentation. PPAP compliance is mandatory for automotive customers — gaps create customer escalations and revenue risk."
$$;