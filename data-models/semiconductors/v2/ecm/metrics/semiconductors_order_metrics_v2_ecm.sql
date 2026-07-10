-- Metric views for domain: order | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs covering order volume, value, backlog, NRE revenue, and fulfilment performance. Primary steering dashboard for Sales Operations and Finance."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Shipped, Cancelled) — primary filter for pipeline vs. closed analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, MPW, NRE, Die-Bank) — drives revenue-mix analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Calendar month of order entry — used for trend and seasonality analysis."
    - name: "order_date_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Fiscal quarter of order entry — aligns with quarterly business review cadence."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue reporting."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel (Direct, Distribution, Online) — key dimension for channel-mix strategy."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End-market vertical (Automotive, Industrial, Consumer, etc.) — critical for market-segment revenue allocation."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country — supports geographic revenue and export-control analysis."
    - name: "order_priority"
      expr: priority
      comment: "Order priority class — used to assess expedite load and premium-service utilisation."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether the order is currently in backlog — separates shipped revenue from open backlog."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag — mandatory dimension for export-compliance reporting."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility flag — required for government-incentive tracking and reporting."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current allocation state of the order — used to identify unallocated demand risk."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders — baseline volume KPI for order intake trend analysis."
    - name: "total_gross_order_value"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Sum of gross order value across all orders — top-line revenue pipeline indicator used in QBRs."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order value (after discounts/adjustments) — primary revenue recognition input."
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total NRE (Non-Recurring Engineering) charges on orders — tracks design-services revenue stream."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across orders — required for tax-liability reporting."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value — tracks deal-size trends; a declining average signals mix shift or pricing pressure."
    - name: "backlog_order_count"
      expr: COUNT(CASE WHEN backlog_flag = TRUE THEN 1 END)
      comment: "Number of orders currently in backlog — key supply-demand imbalance indicator."
    - name: "backlog_value"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Total net value of orders in backlog — forward revenue visibility metric for executive planning."
    - name: "on_hold_order_count"
      expr: COUNT(CASE WHEN order_status = 'Hold' THEN 1 END)
      comment: "Number of orders currently on hold — operational risk indicator; high counts signal credit, compliance, or quality issues."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled orders — demand-loss KPI; spikes indicate customer satisfaction or supply issues."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders cancelled — executive-level demand-health metric; triggers investigation when above threshold."
    - name: "export_license_required_count"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN 1 END)
      comment: "Number of orders requiring export licenses — compliance workload and risk-exposure indicator."
    - name: "chips_act_eligible_order_value"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Net order value attributable to CHIPS Act eligible orders — tracks government-incentive-linked revenue for compliance reporting."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts placing orders — customer breadth and concentration metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level KPIs for revenue, volume, pricing, and fulfilment performance. Enables SKU-level and product-mix analysis for Sales and Supply Chain."
  source: "`vibe_semiconductors_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (Open, Shipped, Cancelled, etc.) — primary filter for open vs. closed line analysis."
    - name: "item_category"
      expr: item_category
      comment: "Product category of the line item — enables product-mix revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the line — required for multi-currency revenue reporting."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing delivery responsibility — affects revenue recognition timing."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the product — required for trade compliance and tariff analysis."
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for the line — geographic revenue distribution dimension."
    - name: "date_entered_month"
      expr: DATE_TRUNC('MONTH', date_entered)
      comment: "Month the order line was entered — used for booking trend analysis."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of customer-requested delivery — used for demand-timing and capacity planning."
    - name: "speed_grade"
      expr: speed_grade
      comment: "Product speed grade — premium-grade mix analysis for pricing and margin management."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Product temperature grade — industrial vs. commercial mix analysis."
    - name: "mpw_order"
      expr: mpw_order
      comment: "Flag indicating this line is part of an MPW (Multi-Project Wafer) order — separates MPW from standard product revenue."
    - name: "die_bank_order"
      expr: die_bank_order
      comment: "Flag indicating this line is fulfilled from die bank inventory — tracks die-bank utilisation."
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of order lines — baseline volume metric for line-level throughput analysis."
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net revenue value across all order lines — primary line-level revenue KPI."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines — demand volume indicator for supply planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped across all lines — fulfilment throughput KPI."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed quantity across lines — committed supply signal for revenue forecasting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit across lines — pricing trend and ASP (Average Selling Price) KPI."
    - name: "fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been shipped — core supply-chain fulfilment performance KPI; directly tied to customer satisfaction and revenue realisation."
    - name: "open_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE) - CAST(shipped_quantity AS DOUBLE))
      comment: "Unshipped quantity remaining on order lines — open demand exposure for supply planning."
    - name: "cancelled_line_count"
      expr: COUNT(CASE WHEN line_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled order lines — demand-loss indicator at line level."
    - name: "partial_shipment_line_count"
      expr: COUNT(CASE WHEN partial_shipment_allowed = TRUE THEN 1 END)
      comment: "Number of lines permitting partial shipment — logistics complexity and customer flexibility indicator."
    - name: "distinct_skus_ordered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs ordered — product breadth and mix-complexity metric for supply chain."
    - name: "total_revenue_mpw_lines"
      expr: SUM(CASE WHEN mpw_order = TRUE THEN CAST(net_value AS DOUBLE) ELSE 0 END)
      comment: "Net revenue from MPW order lines — tracks MPW program revenue contribution for R&D cost recovery analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_backlog_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog health and aging KPIs for demand management. Enables Sales Operations and Supply Chain to monitor open demand risk, allocation gaps, and revenue at risk."
  source: "`vibe_semiconductors_v1`.`order`.`backlog_position`"
  dimensions:
    - name: "backlog_status"
      expr: backlog_status
      comment: "Current backlog status (Open, Allocated, Committed, etc.) — primary filter for backlog health segmentation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation state of the backlog position — identifies unallocated demand at risk."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End-market vertical — enables backlog analysis by strategic market segment."
    - name: "order_type"
      expr: order_type
      comment: "Order type classification — separates standard, MPW, NRE, and die-bank backlog."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the backlog position — geographic demand distribution."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country — export-control and geographic concentration analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — multi-currency backlog valuation."
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the backlog snapshot — enables point-in-time backlog trend analysis."
    - name: "current_commit_month"
      expr: DATE_TRUNC('MONTH', current_commit_date)
      comment: "Month of current commit date — used for near-term revenue commit analysis."
    - name: "design_win_flag"
      expr: design_win_flag
      comment: "Indicates backlog tied to a design win — strategic demand quality indicator."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control flag — compliance risk dimension for backlog."
  measures:
    - name: "total_backlog_positions"
      expr: COUNT(1)
      comment: "Total number of backlog positions — baseline demand volume metric."
    - name: "total_backlog_value"
      expr: SUM(CAST(backlog_value AS DOUBLE))
      comment: "Total value of open backlog — primary forward revenue visibility KPI used in executive planning and investor guidance."
    - name: "total_original_order_quantity"
      expr: SUM(CAST(original_order_quantity AS DOUBLE))
      comment: "Total originally ordered quantity — baseline demand volume for fulfilment gap analysis."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total committed quantity — supply commitment coverage metric."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total allocated quantity — measures how much demand has been matched to supply."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total cancelled quantity — demand-loss volume metric; spikes indicate customer churn or supply failure."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total shipped quantity from backlog positions — fulfilment execution metric."
    - name: "allocation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(allocated_quantity AS DOUBLE)) / NULLIF(SUM(CAST(original_order_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been allocated — supply coverage KPI; low values signal supply shortfall risk."
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price across backlog positions — ASP trend indicator for pricing strategy."
    - name: "design_win_backlog_value"
      expr: SUM(CASE WHEN design_win_flag = TRUE THEN CAST(backlog_value AS DOUBLE) ELSE 0 END)
      comment: "Backlog value tied to design wins — strategic revenue quality metric; design-win backlog is stickier and higher-margin."
    - name: "distinct_customers_in_backlog"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with open backlog — customer concentration and breadth metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution and logistics KPIs covering on-time delivery, freight cost, and quality of outbound shipments. Core operational dashboard for Supply Chain and Logistics."
  source: "`vibe_semiconductors_v1`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (In Transit, Delivered, Delayed, etc.) — primary filter for shipment health."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country — geographic distribution of outbound shipments."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing delivery — affects revenue recognition and logistics cost allocation."
    - name: "service_level"
      expr: service_level
      comment: "Carrier service level (Express, Standard, Economy) — cost vs. speed trade-off analysis."
    - name: "ship_date_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month of shipment — trend analysis for outbound logistics volume."
    - name: "ship_date_quarter"
      expr: DATE_TRUNC('QUARTER', ship_date)
      comment: "Quarter of shipment — aligns with quarterly revenue recognition and logistics cost reporting."
    - name: "is_multi_leg"
      expr: is_multi_leg
      comment: "Multi-leg shipment flag — identifies complex logistics routes with higher cost and risk."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification of the shipment — compliance risk dimension."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments — baseline logistics throughput metric."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped — primary fulfilment volume KPI."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD — logistics cost KPI; directly impacts gross margin."
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared shipment value — customs and insurance exposure metric."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment — logistics efficiency benchmark; rising average signals carrier or route inefficiency."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kg — logistics capacity utilisation metric."
    - name: "pod_confirmed_quantity"
      expr: SUM(CAST(pod_confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by proof-of-delivery — revenue recognition trigger metric under IFRS 15 / ASC 606."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_date <= estimated_arrival_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of shipments delivered on or before estimated arrival date — primary customer service level KPI; directly tied to customer satisfaction scores."
    - name: "damaged_shipment_count"
      expr: COUNT(CASE WHEN damaged_goods_flag = TRUE THEN 1 END)
      comment: "Number of shipments with damaged goods — quality and carrier performance KPI; drives carrier scorecard and insurance claims."
    - name: "damaged_shipment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damaged_goods_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with damage — logistics quality rate; triggers carrier review when above threshold."
    - name: "quantity_shortage_shipment_count"
      expr: COUNT(CASE WHEN quantity_shortage_flag = TRUE THEN 1 END)
      comment: "Number of shipments with quantity shortages — fulfilment accuracy KPI; impacts customer satisfaction and revenue."
    - name: "wrong_part_shipment_count"
      expr: COUNT(CASE WHEN wrong_part_flag = TRUE THEN 1 END)
      comment: "Number of shipments with wrong parts — order accuracy KPI; drives root-cause analysis and process improvement."
    - name: "distinct_customers_shipped"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers receiving shipments — active customer fulfilment breadth metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Merchandise Authorization KPIs for quality, warranty, and customer satisfaction management. Enables Quality and Customer Service teams to track return rates, credit exposure, and root-cause patterns."
  source: "`vibe_semiconductors_v1`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current RMA lifecycle status (Open, Received, Closed, etc.) — primary filter for active vs. resolved returns."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return — root-cause categorisation for quality improvement."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the defect — drives corrective action prioritisation."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of incoming inspection (Confirmed Defect, No Fault Found, etc.) — quality disposition dimension."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates whether the RMA is a warranty claim — separates warranty liability from goodwill returns."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating corrective action is required — drives CAPA workload planning."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of RMA request — trend analysis for return volume and seasonality."
    - name: "request_date_quarter"
      expr: DATE_TRUNC('QUARTER', request_date)
      comment: "Quarter of RMA request — aligns with quarterly quality review cadence."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit amount — multi-currency credit liability reporting."
    - name: "dppm_impact_flag"
      expr: dppm_impact_flag
      comment: "Flag indicating this RMA impacts DPPM (Defective Parts Per Million) metrics — quality KPI linkage."
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total number of RMAs — baseline return volume metric; rising trend signals quality or fulfilment issues."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued for returns — financial liability KPI; directly impacts revenue and margin."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA — tracks severity of returns; rising average indicates higher-value product failures."
    - name: "warranty_rma_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of warranty RMAs — warranty liability exposure metric for Finance and Quality."
    - name: "warranty_credit_amount"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN CAST(credit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total credit value for warranty claims — warranty reserve adequacy KPI for financial planning."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of RMAs requiring corrective action — CAPA workload and quality-system effectiveness indicator."
    - name: "failure_analysis_requested_count"
      expr: COUNT(CASE WHEN failure_analysis_requested = TRUE THEN 1 END)
      comment: "Number of RMAs with failure analysis requested — engineering resource demand for root-cause investigation."
    - name: "dppm_impacting_rma_count"
      expr: COUNT(CASE WHEN dppm_impact_flag = TRUE THEN 1 END)
      comment: "Number of RMAs that impact DPPM metrics — quality KPI linkage for customer scorecards."
    - name: "distinct_customers_with_rma"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with active RMAs — customer satisfaction risk breadth metric."
    - name: "open_rma_count"
      expr: COUNT(CASE WHEN rma_status = 'Open' THEN 1 END)
      comment: "Number of currently open RMAs — operational workload and customer satisfaction risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_allocation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply allocation KPIs measuring how effectively available supply is matched to demand. Critical for Supply Chain, Sales Operations, and Finance to manage constrained-supply scenarios."
  source: "`vibe_semiconductors_v1`.`order`.`allocation_record`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (Firm, Tentative, MPW, Die-Bank) — drives allocation strategy analysis."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of the allocation (Wafer Fab, Die Bank, Finished Goods) — supply-source mix analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status — identifies confirmed vs. pending allocations."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End-market segment — enables allocation prioritisation analysis by strategic market."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of allocation — trend analysis for allocation activity."
    - name: "scheduled_ship_month"
      expr: DATE_TRUNC('MONTH', scheduled_ship_date)
      comment: "Month of scheduled shipment — near-term supply commit visibility."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates allocation is against a backlog order — separates backlog fulfilment from spot demand."
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Indicates allocation is under supply constraint — critical dimension for constrained-supply management."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility — tracks government-incentive-linked allocation volume."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag — export compliance dimension for allocation."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot being allocated (Production, Engineering, MPW) — product-type mix analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of allocation records — baseline allocation activity metric."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to orders — primary supply commitment volume KPI."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed allocation quantity — firm supply commitment metric for revenue forecasting."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped against allocations — allocation execution rate input."
    - name: "allocation_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity that has been shipped — allocation execution effectiveness KPI; low values indicate supply-chain execution failures."
    - name: "constrained_supply_allocation_count"
      expr: COUNT(CASE WHEN constrained_supply_flag = TRUE THEN 1 END)
      comment: "Number of allocations under supply constraint — supply risk exposure metric for executive escalation."
    - name: "constrained_supply_quantity"
      expr: SUM(CASE WHEN constrained_supply_flag = TRUE THEN CAST(allocated_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity allocated under supply constraint — volume of demand at risk due to supply shortage."
    - name: "distinct_skus_allocated"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active allocations — product breadth of supply commitment."
    - name: "distinct_customers_allocated"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with allocations — customer coverage metric for supply fairness analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_wafer_start_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer start authorization KPIs tracking fab capacity commitment, yield targets, and NRE cost for production planning. Critical for Fab Operations, Finance, and Sales to manage wafer starts against demand."
  source: "`vibe_semiconductors_v1`.`order`.`wafer_start_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the wafer start authorization (Approved, Pending, Cancelled) — primary filter for active vs. inactive authorizations."
    - name: "process_node"
      expr: process_node
      comment: "Technology process node — critical dimension for capacity planning by node."
    - name: "process_technology_code"
      expr: process_technology_code
      comment: "Process technology code — detailed technology classification for fab planning."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level — governance and escalation analysis."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority class of the wafer start — capacity allocation prioritisation dimension."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned wafer start — fab capacity loading by month."
    - name: "planned_start_quarter"
      expr: DATE_TRUNC('QUARTER', planned_start_date)
      comment: "Quarter of planned wafer start — quarterly fab capacity planning."
    - name: "is_mpw"
      expr: is_mpw
      comment: "Multi-Project Wafer flag — separates MPW from dedicated production wafer starts."
    - name: "is_nre"
      expr: is_nre
      comment: "NRE flag — identifies engineering wafer starts for cost tracking."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility — tracks government-incentive-linked wafer starts."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in mm (200mm, 300mm) — capacity and cost analysis by wafer size."
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of wafer start authorizations — baseline fab demand volume metric."
    - name: "total_nre_charge_usd"
      expr: SUM(CAST(nre_charge_usd AS DOUBLE))
      comment: "Total NRE charges on wafer start authorizations — NRE revenue and cost recovery KPI."
    - name: "total_wafer_unit_cost_usd"
      expr: SUM(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Total wafer unit cost across authorizations — fab cost exposure metric for Finance."
    - name: "avg_wafer_unit_cost_usd"
      expr: AVG(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Average wafer unit cost — cost-per-wafer trend KPI; rising average signals process or yield issues."
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_pct AS DOUBLE))
      comment: "Average yield target percentage across authorizations — planned yield benchmark for fab performance management."
    - name: "approved_authorization_count"
      expr: COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END)
      comment: "Number of approved wafer start authorizations — confirmed fab demand volume."
    - name: "chips_act_wafer_cost_usd"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(wafer_unit_cost_usd AS DOUBLE) ELSE 0 END)
      comment: "Total wafer cost for CHIPS Act eligible starts — tracks government-incentive-linked fab investment for compliance reporting."
    - name: "mpw_authorization_count"
      expr: COUNT(CASE WHEN is_mpw = TRUE THEN 1 END)
      comment: "Number of MPW wafer start authorizations — MPW program capacity demand metric."
    - name: "nre_authorization_count"
      expr: COUNT(CASE WHEN is_nre = TRUE THEN 1 END)
      comment: "Number of NRE wafer start authorizations — engineering capacity demand metric."
    - name: "distinct_fab_sites"
      expr: COUNT(DISTINCT fab_site_id)
      comment: "Number of distinct fab sites with active wafer start authorizations — fab capacity distribution metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold KPIs for risk management and operational efficiency. Tracks hold volume, financial exposure, SLA compliance, and resolution performance for Credit, Compliance, and Quality teams."
  source: "`vibe_semiconductors_v1`.`order`.`order_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (Credit, Export Control, Quality, etc.) — primary dimension for hold root-cause analysis."
    - name: "hold_status"
      expr: hold_status
      comment: "Current hold status (Active, Released, Escalated) — operational filter for active risk."
    - name: "reason_code"
      expr: reason_code
      comment: "Specific reason code for the hold — granular root-cause categorisation."
    - name: "hold_date_month"
      expr: DATE_TRUNC('MONTH', CAST(hold_date AS DATE))
      comment: "Month the hold was placed — trend analysis for hold frequency."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates the hold has been escalated — identifies high-priority holds requiring executive attention."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates the hold has breached its SLA — process compliance and customer satisfaction risk indicator."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled flag — export compliance dimension for holds."
    - name: "chips_act_review_required"
      expr: chips_act_review_required
      comment: "CHIPS Act review required flag — government-compliance hold dimension."
    - name: "wafer_start_impacted"
      expr: wafer_start_impacted
      comment: "Indicates the hold impacts wafer starts — fab capacity risk dimension."
    - name: "die_bank_impacted"
      expr: die_bank_impacted
      comment: "Indicates the hold impacts die bank inventory — inventory risk dimension."
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of order holds — baseline hold volume metric; rising trend signals systemic issues."
    - name: "total_order_value_at_risk"
      expr: SUM(CAST(order_value_at_risk AS DOUBLE))
      comment: "Total order value at risk due to holds — financial exposure KPI; directly impacts revenue recognition and cash flow."
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Total credit exposure across held orders — credit risk KPI for Finance and Credit Management."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit across held orders — credit policy adequacy benchmark."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN 1 END)
      comment: "Number of currently active holds — real-time operational risk indicator."
    - name: "escalated_hold_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated holds — executive attention queue metric; high count signals systemic process failure."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of holds that have breached SLA — process compliance KPI; directly impacts customer satisfaction."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds breaching SLA — hold resolution efficiency KPI; triggers process review when above threshold."
    - name: "wafer_start_impacted_value"
      expr: SUM(CASE WHEN wafer_start_impacted = TRUE THEN CAST(order_value_at_risk AS DOUBLE) ELSE 0 END)
      comment: "Order value at risk where wafer starts are impacted — fab capacity and revenue risk intersection metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_nre_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) order KPIs for design-services revenue tracking, milestone billing, and project financial performance. Used by Finance, Sales, and Engineering leadership."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — multi-currency NRE revenue reporting."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility — tracks government-incentive-linked NRE revenue."
  measures:
    - name: "total_nre_orders"
      expr: COUNT(1)
      comment: "Total number of NRE orders — baseline NRE pipeline volume metric."
    - name: "distinct_customers_with_nre"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with NRE orders — NRE customer breadth and concentration metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order KPIs for long-term volume commitment management. Tracks committed revenue, release execution, and contract health for Sales and Supply Chain planning."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current blanket order status (Active, Expired, Cancelled) — primary filter for active contract portfolio."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel for the blanket order — channel-mix analysis for long-term commitments."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End-market segment — strategic market commitment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — multi-currency blanket order valuation."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility — tracks government-incentive-linked long-term commitments."
  measures:
    - name: "total_blanket_orders"
      expr: COUNT(1)
      comment: "Total number of blanket orders — baseline long-term commitment portfolio size."
    - name: "distinct_customers_with_blanket"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with blanket orders — long-term customer commitment breadth metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_mpw_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-Project Wafer (MPW) order KPIs for shuttle program management. Tracks MPW revenue, yield performance, and tapeout execution for R&D and Sales leadership."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current MPW order status — primary filter for active vs. completed shuttle orders."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — multi-currency MPW revenue reporting."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of MPW order — shuttle booking trend analysis."
    - name: "order_date_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Quarter of MPW order — quarterly shuttle revenue reporting."
  measures:
    - name: "total_mpw_orders"
      expr: COUNT(1)
      comment: "Total number of MPW orders — shuttle program demand volume metric."
    - name: "distinct_customers_on_mpw"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers on MPW orders — shuttle program customer breadth metric."
    - name: "distinct_shuttles"
      expr: COUNT(DISTINCT mpw_shuttle_id)
      comment: "Number of distinct MPW shuttles with orders — active shuttle program count."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_nre_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE milestone billing and execution KPIs for project revenue recognition and delivery performance. Used by Finance and Engineering to track milestone completion, billing status, and revenue recognition under ASC 606."
  source: "`vibe_semiconductors_v1`.`order`.`order_nre_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current milestone status (Planned, In Progress, Completed, Invoiced) — primary filter for milestone pipeline."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (Design, Tapeout, Silicon, Qualification) — milestone-mix analysis for project tracking."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the milestone — revenue recognition readiness indicator."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — multi-currency milestone revenue reporting."
    - name: "planned_completion_month"
      expr: DATE_TRUNC('MONTH', planned_completion_date)
      comment: "Month of planned milestone completion — near-term revenue recognition pipeline."
    - name: "planned_completion_quarter"
      expr: DATE_TRUNC('QUARTER', planned_completion_date)
      comment: "Quarter of planned milestone completion — quarterly revenue recognition forecast."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the milestone — project risk management dimension."
    - name: "rework_required_flag"
      expr: rework_required_flag
      comment: "Indicates rework is required — quality and schedule risk indicator."
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Indicates the milestone was modified by contract amendment — scope change tracking."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of NRE milestones — baseline project delivery pipeline metric."
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total contracted value of NRE milestones — milestone revenue pipeline KPI."
    - name: "total_revenue_recognition_amount"
      expr: SUM(CAST(revenue_recognition_amount AS DOUBLE))
      comment: "Total revenue recognised from milestones — ASC 606 revenue recognition KPI for Finance."
    - name: "total_effort_hours_planned"
      expr: SUM(CAST(effort_hours_planned AS DOUBLE))
      comment: "Total planned engineering effort hours — resource capacity planning metric."
    - name: "total_effort_hours_actual"
      expr: SUM(CAST(effort_hours_actual AS DOUBLE))
      comment: "Total actual engineering effort hours — resource utilisation and project cost tracking."
    - name: "effort_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(effort_hours_planned AS DOUBLE)) / NULLIF(SUM(CAST(effort_hours_actual AS DOUBLE)), 0), 2)
      comment: "Ratio of planned to actual effort hours — engineering efficiency KPI; values below 100% indicate over-run."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Number of completed milestones — project delivery progress metric."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed — NRE project delivery performance KPI; low rates signal delivery risk."
    - name: "rework_milestone_count"
      expr: COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END)
      comment: "Number of milestones requiring rework — quality and schedule risk metric for NRE projects."
    - name: "on_time_milestone_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date <= planned_completion_date AND actual_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of milestones completed on or before planned date — NRE delivery schedule adherence KPI."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order amendment KPIs tracking change frequency, financial impact, and approval governance. Used by Sales Operations and Finance to manage order book stability and revenue revision risk."
  source: "`vibe_semiconductors_v1`.`order`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current amendment status (Pending, Approved, Rejected) — primary filter for amendment pipeline."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (Quantity, Price, Date, Cancellation) — change-type analysis for order book stability."
    - name: "amended_field_name"
      expr: amended_field_name
      comment: "Name of the field being amended — granular change analysis for process improvement."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required — governance and escalation analysis."
    - name: "amendment_date_month"
      expr: DATE_TRUNC('MONTH', amendment_date)
      comment: "Month of amendment — trend analysis for order book change frequency."
    - name: "amendment_date_quarter"
      expr: DATE_TRUNC('QUARTER', amendment_date)
      comment: "Quarter of amendment — quarterly order book stability analysis."
    - name: "customer_requested_flag"
      expr: customer_requested_flag
      comment: "Indicates amendment was customer-initiated — separates customer-driven vs. internal changes."
    - name: "allocation_impact_flag"
      expr: allocation_impact_flag
      comment: "Indicates amendment impacts supply allocation — supply chain disruption risk dimension."
    - name: "wafer_start_impact_flag"
      expr: wafer_start_impact_flag
      comment: "Indicates amendment impacts wafer starts — fab capacity disruption risk dimension."
    - name: "export_control_review_required"
      expr: export_control_review_required
      comment: "Export control review required flag — compliance workload dimension."
    - name: "chips_act_order_flag"
      expr: chips_act_order_flag
      comment: "CHIPS Act order flag — government-incentive-linked amendment tracking."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of order amendments — order book instability metric; high volume signals demand volatility."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of amendments — net revenue revision KPI for Finance; critical for forecast accuracy."
    - name: "total_quantity_change"
      expr: SUM(CAST(quantity_revised AS DOUBLE) - CAST(quantity_original AS DOUBLE))
      comment: "Net quantity change across amendments — demand revision volume metric for supply planning."
    - name: "total_value_change"
      expr: SUM(CAST(revised_value AS DOUBLE) - CAST(original_value AS DOUBLE))
      comment: "Net value change across amendments — order book value revision metric for revenue forecasting."
    - name: "avg_unit_price_change"
      expr: AVG(CAST(unit_price_revised AS DOUBLE) - CAST(unit_price_original AS DOUBLE))
      comment: "Average unit price change per amendment — pricing revision trend; negative average signals price concessions."
    - name: "customer_requested_amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_requested_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments initiated by customers — demand volatility attribution metric."
    - name: "wafer_start_impacting_amendment_count"
      expr: COUNT(CASE WHEN wafer_start_impact_flag = TRUE THEN 1 END)
      comment: "Number of amendments impacting wafer starts — fab capacity disruption risk metric."
    - name: "pending_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Pending' THEN 1 END)
      comment: "Number of amendments pending approval — approval queue backlog metric for governance."
    - name: "distinct_orders_amended"
      expr: COUNT(DISTINCT primary_amendment_order_id)
      comment: "Number of distinct orders with amendments — order book change breadth metric."
$$;