-- Metric views for domain: inventory | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory health metrics derived from stock position records. Tracks on-hand availability, out-of-stock exposure, days-of-supply coverage, and demand sell-through rates to support replenishment and availability decisions."
  source: "`ecommerce_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse or fulfillment node identifier — enables geographic and network-level inventory analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "Stock-keeping unit identifier — enables product-level inventory drill-down."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g. Active, Quarantined, Damaged) — used to filter or segment available vs. unavailable stock."
    - name: "stock_condition"
      expr: stock_condition
      comment: "Physical condition of the stock (e.g. New, Refurbished, Damaged) — critical for quality-based inventory segmentation."
    - name: "velocity_tier"
      expr: velocity_tier
      comment: "Demand velocity classification (e.g. Fast, Medium, Slow) — used to prioritise replenishment and slotting decisions."
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (e.g. Bin, Rack, Bulk) — supports warehouse layout and capacity analysis."
    - name: "inventory_ownership_type"
      expr: inventory_ownership_type
      comment: "Ownership model of the inventory (e.g. Owned, Consignment, 3PL) — important for financial and liability reporting."
    - name: "is_oos"
      expr: is_oos
      comment: "Boolean flag indicating whether the SKU is currently out-of-stock — primary dimension for stockout analysis."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Boolean flag indicating hazardous material classification — required for compliance and storage routing."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month-level bucketing of stock expiry date — enables perishability and write-off risk analysis."
    - name: "last_received_date_month"
      expr: DATE_TRUNC('MONTH', last_received_date)
      comment: "Month of last stock receipt — supports aging and freshness analysis."
    - name: "seller_profile_id"
      expr: seller_profile_id
      comment: "Seller or merchant identifier — enables marketplace multi-seller inventory segmentation."
  measures:
    - name: "total_sku_positions"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with an active stock position. Indicates breadth of inventory assortment and is used to track catalogue coverage across nodes."
    - name: "out_of_stock_sku_count"
      expr: COUNT(DISTINCT CASE WHEN is_oos = TRUE THEN sku_id END)
      comment: "Number of distinct SKUs currently flagged as out-of-stock. A rising value signals availability risk and potential lost sales — a key executive availability KPI."
    - name: "oos_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_oos = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of SKUs that are out-of-stock relative to total SKU positions. Core availability health metric used in QBRs and replenishment steering."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply remaining across stock positions. Measures how long current inventory will last at current demand rates — critical for replenishment planning and stockout prevention."
    - name: "avg_dsr_7d"
      expr: AVG(CAST(dsr_7d AS DOUBLE))
      comment: "Average 7-day demand sell-through rate across positions. Short-term velocity indicator used to detect demand spikes or slowdowns requiring immediate replenishment action."
    - name: "avg_dsr_30d"
      expr: AVG(CAST(dsr_30d AS DOUBLE))
      comment: "Average 30-day demand sell-through rate. Medium-term velocity metric used for monthly replenishment planning and safety stock calibration."
    - name: "avg_dsr_90d"
      expr: AVG(CAST(dsr_90d AS DOUBLE))
      comment: "Average 90-day demand sell-through rate. Long-term velocity indicator used for seasonal planning, supplier negotiations, and strategic inventory positioning."
    - name: "avg_seasonal_velocity_index"
      expr: AVG(CAST(seasonal_velocity_index AS DOUBLE))
      comment: "Average seasonal velocity index across stock positions. Measures how demand velocity compares to seasonal norms — used to identify over/under-stocked seasonal items."
    - name: "peak_dsr_max"
      expr: MAX(CAST(peak_dsr AS DOUBLE))
      comment: "Maximum peak demand sell-through rate observed across positions. Identifies the highest-velocity SKU or node — used to size peak capacity and safety stock buffers."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational inventory flow metrics tracking the volume, value, and composition of stock movements. Supports throughput analysis, financial reconciliation, and movement quality monitoring."
  source: "`ecommerce_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (e.g. Receipt, Shipment, Transfer, Adjustment, Return) — primary dimension for flow analysis."
    - name: "movement_status"
      expr: movement_status
      comment: "Current processing status of the movement (e.g. Pending, Completed, Cancelled) — used to filter confirmed vs. in-progress flows."
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node where the movement originated — enables node-level throughput benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU involved in the movement — enables product-level flow analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Business reason code for the movement (e.g. Damage, Expiry, Customer Return) — used to diagnose root causes of inventory shrinkage or adjustments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which movement value is denominated — required for multi-currency financial reconciliation."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection outcome associated with the movement (e.g. Pass, Fail, Quarantine) — used to track quality-related inventory flows."
    - name: "is_financial_impact"
      expr: is_financial_impact
      comment: "Boolean flag indicating whether the movement has a financial (GL) impact — used to separate operational from financial inventory events."
    - name: "movement_date_month"
      expr: DATE_TRUNC('MONTH', movement_timestamp)
      comment: "Month-level bucketing of movement timestamp — enables trend analysis of inventory flow volumes over time."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting — aligns inventory movements to financial reporting periods."
    - name: "seller_profile_id"
      expr: seller_profile_id
      comment: "Seller identifier — enables marketplace-level movement analysis."
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of source document driving the movement (e.g. Purchase Order, Sales Order, RMA) — supports end-to-end traceability."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units moved across all movement types. Measures overall inventory throughput — a primary operational volume KPI for warehouse capacity and labour planning."
    - name: "total_movement_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of all stock movements. Directly tied to COGS, inventory valuation, and GL reconciliation — a core financial KPI."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movements. Tracks cost trends per SKU or node — used in margin analysis and supplier cost benchmarking."
    - name: "distinct_sku_movement_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that had at least one movement in the period. Measures active inventory breadth and is used to identify dormant or slow-moving SKUs."
    - name: "financial_impact_movement_count"
      expr: COUNT(CASE WHEN is_financial_impact = TRUE THEN stock_movement_id END)
      comment: "Count of movements with a direct financial (GL) impact. Used to reconcile operational movement volumes against financial postings — a key audit and control metric."
    - name: "financial_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_financial_impact = TRUE THEN stock_movement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that carry a financial impact. A declining rate may indicate unposted movements or GL reconciliation gaps — important for finance and audit teams."
    - name: "total_movement_events"
      expr: COUNT(1)
      comment: "Total number of stock movement events. Baseline throughput volume metric used to normalise other KPIs and benchmark warehouse operational load."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment quality and financial impact metrics. Tracks the volume, value, and nature of inventory corrections to identify shrinkage, process failures, and GL reconciliation accuracy."
  source: "`ecommerce_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Category of inventory adjustment (e.g. Damage Write-Off, Cycle Count Correction, Return Receipt) — primary dimension for root-cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Processing status of the adjustment (e.g. Pending, Approved, Posted, Reversed) — used to filter confirmed vs. in-progress adjustments."
    - name: "reason_code"
      expr: reason_code
      comment: "Specific reason driving the adjustment (e.g. Theft, Expiry, Receiving Error) — enables root-cause categorisation of inventory losses."
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node where the adjustment occurred — enables node-level shrinkage benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU subject to the adjustment — enables product-level shrinkage and correction analysis."
    - name: "posted_to_gl_flag"
      expr: posted_to_gl_flag
      comment: "Boolean indicating whether the adjustment has been posted to the general ledger — critical for financial close and audit compliance."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Boolean indicating whether this adjustment is a reversal of a prior entry — used to identify correction activity and net-out duplicate postings."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment value — required for multi-currency financial reporting."
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('MONTH', adjustment_timestamp)
      comment: "Month-level bucketing of adjustment timestamp — enables trend analysis of adjustment frequency and value over time."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting — aligns adjustments to financial reporting periods for close reconciliation."
    - name: "seller_profile_id"
      expr: seller_profile_id
      comment: "Seller identifier — enables marketplace-level adjustment and shrinkage analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost centre responsible for the adjustment — used for financial accountability and budget impact tracking."
  measures:
    - name: "total_adjusted_value"
      expr: SUM(CAST(adjusted_value AS DOUBLE))
      comment: "Total financial value of all inventory adjustments. Directly measures inventory shrinkage, write-offs, and correction costs — a primary P&L and loss-prevention KPI."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total units adjusted across all adjustment events. Measures the physical scale of inventory corrections — used alongside value to compute average adjustment cost per unit."
    - name: "avg_unit_cost_at_adjustment"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost at the time of adjustment. Used to assess whether high-value or low-value items are disproportionately affected by inventory errors."
    - name: "unposted_adjustment_count"
      expr: COUNT(CASE WHEN posted_to_gl_flag = FALSE THEN adjustment_id END)
      comment: "Number of adjustments not yet posted to the general ledger. A high count signals financial close risk and potential GL reconciliation failures — a key audit control metric."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN adjustment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that are reversals. A high reversal rate indicates data quality issues or process errors in the original adjustment workflow — an operational quality KPI."
    - name: "net_quantity_impact"
      expr: SUM((CAST(quantity_after_adjustment AS DOUBLE)) - (CAST(quantity_before_adjustment AS DOUBLE)))
      comment: "Net change in inventory quantity resulting from all adjustments (after minus before). Measures the cumulative physical inventory impact of corrections — used in shrinkage and accuracy reporting."
    - name: "distinct_sku_adjusted_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that received at least one adjustment in the period. A broad spread indicates systemic process issues; concentration on few SKUs may indicate targeted shrinkage or quality problems."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_stock_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory allocation efficiency and fulfilment readiness metrics. Tracks how allocated stock progresses through pick, pack, and ship stages to identify bottlenecks and allocation accuracy."
  source: "`ecommerce_ecm`.`inventory`.`stock_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of stock allocation (e.g. Sales Order, Transfer, Campaign Reserve) — primary dimension for allocation purpose analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g. Allocated, Picked, Packed, Shipped, Cancelled) — used to track fulfilment pipeline progression."
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node fulfilling the allocation — enables node-level pick and pack performance benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being allocated — enables product-level allocation and fulfilment analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the allocation (e.g. Standard, Expedited, VIP) — used to ensure high-priority orders are fulfilled first."
    - name: "allocation_source"
      expr: allocation_source
      comment: "System or channel that originated the allocation (e.g. OMS, WMS, Manual) — used for process traceability and automation rate analysis."
    - name: "inventory_condition"
      expr: inventory_condition
      comment: "Condition of the allocated inventory (e.g. New, Refurbished, Damaged) — ensures quality-appropriate stock is allocated to orders."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicating whether the allocation is on hold — used to identify blocked fulfilment and investigate hold reasons."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_timestamp)
      comment: "Month-level bucketing of allocation creation timestamp — enables trend analysis of allocation volumes over time."
    - name: "seller_profile_id"
      expr: seller_profile_id
      comment: "Seller identifier — enables marketplace-level allocation performance analysis."
    - name: "allocation_reason_code"
      expr: allocation_reason_code
      comment: "Reason code for the allocation event — supports root-cause analysis of allocation patterns and exceptions."
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total units allocated across all allocation records. Measures the volume of inventory committed to orders — a primary demand fulfilment capacity KPI."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total units physically picked from warehouse locations. Measures warehouse pick throughput and is compared to allocated quantity to compute pick accuracy."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total units released from allocation (de-allocated). A high released quantity relative to allocated quantity signals order cancellations or inventory unavailability issues."
    - name: "pick_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(picked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated units that were successfully picked. Core warehouse execution KPI — a low rate indicates pick failures, mislocation, or phantom inventory."
    - name: "on_hold_allocation_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN stock_allocation_id END)
      comment: "Number of allocations currently on hold. Held allocations block fulfilment and degrade customer experience — a key operational exception metric for daily management."
    - name: "cancelled_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'Cancelled' THEN stock_allocation_id END)
      comment: "Number of allocations that were cancelled. High cancellation volumes indicate demand volatility, inventory unavailability, or order management issues — directly impacts revenue and customer satisfaction."
    - name: "allocation_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN allocation_status = 'Cancelled' THEN stock_allocation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations that were cancelled. A rising cancellation rate is a leading indicator of inventory availability problems or demand-supply misalignment."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-warehouse inventory transfer performance metrics. Tracks transfer volumes, freight costs, delivery accuracy, and variance to optimise network inventory balancing and reduce transfer costs."
  source: "`ecommerce_ecm`.`inventory`.`transfer_order`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer order (e.g. Pending, In Transit, Received, Cancelled) — primary dimension for pipeline and exception analysis."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g. Replenishment, Rebalancing, Returns, Cross-Dock) — used to segment transfer activity by business purpose."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being transferred — enables product-level network flow analysis."
    - name: "primary_transfer_warehouse_node_id"
      expr: primary_transfer_warehouse_node_id
      comment: "Source warehouse node of the transfer — used to identify nodes that are net exporters of inventory."
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Destination warehouse node of the transfer — used to identify nodes that are net importers of inventory."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the transfer (e.g. Standard, Urgent) — used to ensure critical replenishment transfers are expedited."
    - name: "shipment_method"
      expr: shipment_method
      comment: "Mode of shipment for the transfer (e.g. Road, Air, Rail) — used for freight cost and lead time analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Boolean indicating whether the transfer uses cross-docking — used to measure cross-dock utilisation and its impact on lead time."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Boolean indicating hazardous material classification — required for compliance routing and cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight cost — required for multi-currency cost reporting."
    - name: "requested_date_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month of transfer request — enables trend analysis of transfer demand over time."
    - name: "seller_profile_id"
      expr: seller_profile_id
      comment: "Seller identifier — enables marketplace-level transfer activity analysis."
  measures:
    - name: "total_transfer_quantity"
      expr: SUM(CAST(transfer_quantity AS DOUBLE))
      comment: "Total units requested for transfer across all transfer orders. Measures the scale of inter-node inventory rebalancing activity — a primary network planning KPI."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units confirmed as received at the destination node. Compared to transfer quantity to compute receipt accuracy and identify in-transit losses."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total units currently in transit between nodes. Measures inventory exposure during transit — used for network visibility and safety stock calibration."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost incurred for all transfer orders. A direct operational cost KPI — used to benchmark carrier performance and identify cost reduction opportunities."
    - name: "avg_freight_cost_per_unit"
      expr: ROUND(SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(transfer_quantity AS DOUBLE)), 0), 4)
      comment: "Average freight cost per unit transferred. Normalises freight cost by volume — the key efficiency metric for comparing transfer lanes, carriers, and shipment methods."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between transferred and received units. Measures in-transit loss, damage, or counting errors — a critical supply chain integrity and shrinkage KPI."
    - name: "transfer_receipt_accuracy_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(transfer_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of transferred units successfully received at destination. Core transfer quality KPI — below 100% indicates in-transit loss, damage, or process failures."
    - name: "cancelled_transfer_count"
      expr: COUNT(CASE WHEN transfer_status = 'Cancelled' THEN transfer_order_id END)
      comment: "Number of transfer orders that were cancelled. High cancellation rates indicate planning instability or supply constraints — used to assess network planning quality."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_safety_stock_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy effectiveness and coverage metrics. Tracks service level targets, safety stock adequacy, reorder point calibration, and holding cost exposure to optimise inventory investment vs. availability trade-offs."
  source: "`ecommerce_ecm`.`inventory`.`safety_stock_rule`"
  dimensions:
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node the safety stock rule applies to — enables node-level policy analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU governed by the safety stock rule — enables product-level policy coverage analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low) — primary dimension for tiered safety stock policy analysis."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (e.g. Fixed, Statistical, Demand-Based) — used to assess policy sophistication and consistency."
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the safety stock rule (e.g. Active, Inactive, Under Review) — used to filter active policies."
    - name: "priority_classification"
      expr: priority_classification
      comment: "Priority tier of the SKU for safety stock purposes — used to ensure critical SKUs have adequate coverage."
    - name: "is_seasonal_product"
      expr: is_seasonal_product
      comment: "Boolean indicating whether the product has seasonal demand patterns — used to segment safety stock policies by demand profile."
    - name: "is_promotional_product"
      expr: is_promotional_product
      comment: "Boolean indicating whether the product is subject to promotional demand — used to assess whether promotional safety stock buffers are adequate."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the safety stock rule became effective — used to track policy rollout and refresh cadence."
    - name: "seller_profile_id"
      expr: seller_profile_id
      comment: "Seller identifier — enables marketplace-level safety stock policy analysis."
    - name: "calculation_frequency"
      expr: calculation_frequency
      comment: "How often the safety stock rule is recalculated (e.g. Daily, Weekly, Monthly) — used to assess policy responsiveness to demand changes."
  measures:
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across all active rules. Measures the typical buffer level maintained — used to assess inventory investment in safety buffers."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock units held across all rules. Measures the aggregate inventory investment in safety buffers — a key working capital KPI for finance and supply chain leadership."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percentage AS DOUBLE))
      comment: "Average service level target across all safety stock rules. Measures the ambition of the availability policy — used to benchmark against actual OOS rates and assess policy adequacy."
    - name: "avg_safety_stock_days_of_cover"
      expr: AVG(CAST(safety_stock_days_of_cover AS DOUBLE))
      comment: "Average days of demand coverage provided by safety stock. Measures how many days of demand the safety buffer can absorb — a key supply chain resilience metric."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across all rules. Measures the trigger level for replenishment — used to assess whether reorder points are calibrated to actual lead times and demand."
    - name: "avg_holding_cost_per_unit_per_day"
      expr: AVG(CAST(holding_cost_per_unit_per_day AS DOUBLE))
      comment: "Average daily holding cost per unit across safety stock rules. Measures the cost of carrying safety buffers — used to optimise the trade-off between availability and inventory carrying cost."
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average estimated cost of a stockout per unit across rules. Used alongside holding cost to calibrate optimal safety stock levels — a key input to inventory optimisation models."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient across rules. Measures demand unpredictability — a high average indicates the portfolio requires larger safety buffers and more frequent policy reviews."
    - name: "distinct_sku_coverage_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by an active safety stock rule. Measures policy coverage breadth — gaps indicate SKUs at risk of stockout without a formal buffer policy."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_warehouse_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse network capacity and capability metrics. Tracks physical capacity, operational characteristics, and network composition to support network design, capacity planning, and compliance decisions."
  source: "`ecommerce_ecm`.`inventory`.`warehouse_node`"
  dimensions:
    - name: "node_type"
      expr: node_type
      comment: "Type of warehouse node (e.g. Fulfilment Centre, Distribution Centre, Returns Hub) — primary dimension for network topology analysis."
    - name: "node_status"
      expr: node_status
      comment: "Operational status of the node (e.g. Active, Decommissioned, Under Construction) — used to filter the active network."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier classification (e.g. Tier 1 National, Tier 2 Regional, Tier 3 Local) — used for hierarchical network capacity analysis."
    - name: "fulfillment_model"
      expr: fulfillment_model
      comment: "Fulfilment model operated at the node (e.g. B2C, B2B, Omnichannel) — used to segment capacity by business model."
    - name: "country_code"
      expr: country_code
      comment: "Country where the node is located — enables geographic capacity and compliance analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional grouping of the node — used for regional capacity planning and network balancing."
    - name: "is_3pl"
      expr: is_3pl
      comment: "Boolean indicating whether the node is operated by a third-party logistics provider — used to segment owned vs. outsourced capacity."
    - name: "is_cold_storage"
      expr: is_cold_storage
      comment: "Boolean indicating cold storage capability — used to assess temperature-controlled capacity for perishable goods."
    - name: "is_hazmat_certified"
      expr: is_hazmat_certified
      comment: "Boolean indicating hazmat certification — used for compliance routing and capacity planning for regulated goods."
    - name: "is_returns_enabled"
      expr: is_returns_enabled
      comment: "Boolean indicating whether the node processes customer returns — used to assess returns network coverage."
    - name: "commissioned_date_year"
      expr: DATE_TRUNC('YEAR', commissioned_date)
      comment: "Year the node was commissioned — used to analyse network age and plan infrastructure refresh cycles."
  measures:
    - name: "total_capacity_sqft"
      expr: SUM(CAST(capacity_sqft AS DOUBLE))
      comment: "Total warehouse floor space in square feet across all nodes. Primary physical capacity KPI — used for network capacity planning, lease management, and expansion decisions."
    - name: "avg_capacity_sqft"
      expr: AVG(CAST(capacity_sqft AS DOUBLE))
      comment: "Average warehouse floor space per node. Used to benchmark node sizes and identify outliers in the network footprint."
    - name: "total_max_weight_capacity_kg"
      expr: SUM(CAST(max_weight_capacity_kg AS DOUBLE))
      comment: "Total maximum weight capacity across all nodes in kilograms. Measures the network's aggregate load-bearing capacity — critical for heavy goods and industrial product categories."
    - name: "active_node_count"
      expr: COUNT(CASE WHEN node_status = 'Active' THEN warehouse_node_id END)
      comment: "Number of currently active warehouse nodes. Measures the operational footprint of the fulfilment network — a key network scale KPI for executive reporting."
    - name: "third_party_node_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_3pl = TRUE THEN warehouse_node_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warehouse nodes operated by third-party logistics providers. Measures outsourcing dependency — a strategic risk and cost management metric for supply chain leadership."
    - name: "cold_storage_node_count"
      expr: COUNT(CASE WHEN is_cold_storage = TRUE THEN warehouse_node_id END)
      comment: "Number of nodes with cold storage capability. Measures temperature-controlled capacity coverage — critical for perishable goods strategy and regulatory compliance."
    - name: "returns_enabled_node_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returns_enabled = TRUE THEN warehouse_node_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nodes enabled for returns processing. Measures returns network coverage — a key customer experience and reverse logistics KPI."
$$;
