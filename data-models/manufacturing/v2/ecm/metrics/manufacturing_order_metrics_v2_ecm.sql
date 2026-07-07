-- Metric views for domain: order | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over sales orders — order volume, revenue, average order value, and order mix by channel, type, and status. Used by Sales VPs and COOs to steer order intake, pricing, and fulfillment strategy."
  source: "`vibe_manufacturing_v1`.`order`.`order_header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., Open, Confirmed, Delivered, Cancelled) — primary filter for pipeline vs. closed analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., Standard, Rush, Blanket Release) — used to segment order mix and prioritization."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales org responsible for the order — enables regional and organizational performance comparison."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the order was placed (e.g., Direct, Distributor, Online) — critical for channel mix analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed — enables trend analysis of order intake over time."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the order — used to track expedited vs. standard order volumes."
    - name: "order_reason"
      expr: order_reason
      comment: "Business reason for the order — supports demand pattern and root-cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the order — required for multi-currency revenue reporting."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of the customer-requested delivery date — used to align demand with supply planning."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Total number of distinct sales orders — primary volume KPI for order intake tracking."
    - name: "total_net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net order value across all orders — top-line revenue KPI used in QBRs and board decks."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross order value including taxes and surcharges — used for gross revenue reporting."
    - name: "total_tax_collected"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount across all orders — used for tax liability and compliance reporting."
    - name: "avg_order_value"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net value per order — key pricing and customer segmentation KPI; a declining AOV signals pricing pressure or mix shift."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per order in kilograms — used by logistics to plan freight capacity and cost."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped across all orders — freight volume KPI for logistics capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volumetric size of all orders in cubic meters — used for warehouse and transport capacity planning."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers placing orders — measures customer breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order KPIs covering revenue, quantity, pricing, and fulfillment performance. Used by Sales Operations and Supply Chain to manage order profitability and delivery commitments."
  source: "`vibe_manufacturing_v1`.`order`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., Open, Confirmed, Delivered, Cancelled) — primary filter for open order book analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery fulfillment status of the line — used to identify lines at risk of late delivery."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity — required for accurate volume aggregation."
    - name: "plant"
      expr: plant
      comment: "Manufacturing or fulfillment plant assigned to the line — enables plant-level order load analysis."
    - name: "sales_org"
      expr: sales_org
      comment: "Sales organization responsible for the line — supports regional revenue breakdown."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the line — used for channel mix and margin analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of the line — used to track lines blocked by quality holds."
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Flag indicating whether the line is on backorder — key metric for customer service and supply risk."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the scheduled delivery date — used for demand and fulfillment trend analysis."
  measures:
    - name: "total_order_lines"
      expr: COUNT(DISTINCT line_id)
      comment: "Total number of distinct order lines — baseline volume metric for order complexity and workload."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue across all order lines — line-level revenue KPI for product and channel profitability."
    - name: "total_gross_price"
      expr: SUM(CAST(gross_price AS DOUBLE))
      comment: "Total gross price before discounts across all lines — used to measure discount impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across all order lines — critical for margin leakage and pricing discipline analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all order lines — used for tax compliance and reporting."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines — demand volume KPI for production and supply planning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery — measures supply commitment vs. demand."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers — used to measure unmet demand and backlog."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price across all order lines — pricing trend KPI; decline signals price erosion."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per line after discounts — used to track effective pricing vs. list price."
    - name: "confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity that has been confirmed for delivery — measures supply availability and order fulfillment capability; a low rate signals supply constraints."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_price AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross price — pricing discipline KPI; high values indicate margin leakage from excessive discounting."
    - name: "total_backorder_lines"
      expr: COUNT(CASE WHEN backorder_indicator = TRUE THEN line_id END)
      comment: "Number of order lines currently on backorder — customer service risk KPI; high backorder counts signal supply-demand imbalance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance KPIs covering on-time delivery, freight costs, and delivery quality. Used by Supply Chain and Customer Service leadership to manage fulfillment reliability and logistics spend."
  source: "`vibe_manufacturing_v1`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g., Pending, In Transit, Delivered, Failed) — primary filter for open vs. completed deliveries."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., Standard, Express, Partial) — used to segment delivery performance by service level."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping terms and conditions applied to the delivery — used for freight cost and carrier performance analysis."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier responsible for the delivery — enables carrier performance benchmarking."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Origin shipping point for the delivery — used for warehouse and dispatch performance analysis."
    - name: "country"
      expr: country
      comment: "Destination country of the delivery — enables geographic delivery performance analysis."
    - name: "is_partial_delivery"
      expr: is_partial_delivery
      comment: "Flag indicating whether the delivery is a partial fulfillment — used to track split delivery rates."
    - name: "is_backorder"
      expr: is_backorder
      comment: "Flag indicating whether the delivery originated from a backorder — used to measure backorder fulfillment performance."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of the planned delivery date — used for delivery volume trend analysis."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month the delivery was actually completed — used to compare planned vs. actual delivery timing."
  measures:
    - name: "total_deliveries"
      expr: COUNT(DISTINCT delivery_id)
      comment: "Total number of distinct deliveries — baseline volume KPI for logistics throughput."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all deliveries — logistics spend KPI used to manage carrier costs and negotiate contracts."
    - name: "total_freight_tax"
      expr: SUM(CAST(freight_tax_amount AS DOUBLE))
      comment: "Total freight tax amount — used for tax compliance and total landed cost calculation."
    - name: "total_freight_total"
      expr: SUM(CAST(freight_total_amount AS DOUBLE))
      comment: "Total all-in freight cost including taxes — true logistics cost KPI for P&L and cost-to-serve analysis."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery — used to benchmark carrier efficiency and identify cost outliers."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped across all deliveries in kilograms — freight capacity utilization KPI."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volumetric size of all deliveries in cubic meters — used for transport capacity planning."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date THEN delivery_id END)
      comment: "Number of deliveries completed on or before the planned delivery date — numerator for OTD rate calculation."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date THEN delivery_id END) / NULLIF(COUNT(DISTINCT delivery_id), 0), 2)
      comment: "Percentage of deliveries completed on or before the planned date — premier customer service KPI; directly impacts customer satisfaction scores and SLA compliance."
    - name: "partial_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial_delivery = TRUE THEN delivery_id END) / NULLIF(COUNT(DISTINCT delivery_id), 0), 2)
      comment: "Percentage of deliveries that were partial — measures fulfillment completeness; high rates indicate supply shortfalls or picking inefficiencies."
    - name: "hazmat_delivery_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN delivery_id END)
      comment: "Number of deliveries containing hazardous materials — compliance and risk management KPI for regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level delivery KPIs covering quantity accuracy, picking performance, and quality status. Used by Warehouse Operations and Quality teams to manage fulfillment accuracy and inspection compliance."
  source: "`vibe_manufacturing_v1`.`order`.`delivery_item`"
  dimensions:
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Status of the goods movement for the delivery item — used to track items pending vs. completed goods issue."
    - name: "picking_status"
      expr: picking_status
      comment: "Picking status of the delivery item — used to manage warehouse pick queue and identify bottlenecks."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status of the delivery item — used to track items blocked by quality holds."
    - name: "item_category"
      expr: item_category
      comment: "Category classification of the delivery item — used for product mix and fulfillment analysis."
    - name: "plant"
      expr: plant
      comment: "Plant from which the item is being shipped — enables plant-level fulfillment performance analysis."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping condition applied to the item — used for freight and handling cost analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the delivery item — used to classify goods issue transactions."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the delivery date for the item — used for volume trend analysis."
  measures:
    - name: "total_delivery_items"
      expr: COUNT(DISTINCT delivery_item_id)
      comment: "Total number of distinct delivery line items — baseline volume KPI for warehouse throughput."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all delivery items — demand volume baseline for fulfillment analysis."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total quantity picked in the warehouse — measures warehouse execution progress against order demand."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity actually delivered to customers — actual fulfillment volume KPI."
    - name: "pick_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_picked AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been picked — warehouse execution KPI; gaps indicate picking shortfalls or inventory discrepancies."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_delivered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully delivered — premier order fulfillment KPI; directly measures customer order satisfaction."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all delivered items in kilograms — used for freight cost allocation and logistics planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of all delivered items in cubic meters — used for transport capacity utilization analysis."
    - name: "items_pending_quality_inspection"
      expr: COUNT(CASE WHEN quality_inspection_status NOT IN ('Passed', 'Released') THEN delivery_item_id END)
      comment: "Number of delivery items pending or failing quality inspection — quality risk KPI; high counts indicate fulfillment delays due to quality holds."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization KPIs covering return volumes, credit values, and return reasons. Used by Customer Service and Finance leadership to manage return rates, credit exposure, and product quality signals."
  source: "`vibe_manufacturing_v1`.`order`.`order_rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA (e.g., Pending, Approved, Received, Closed) — primary filter for open vs. resolved returns."
    - name: "rma_type"
      expr: rma_type
      comment: "Type of return (e.g., Defective, Wrong Item, Warranty, Customer Change) — used to classify return root causes."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return — used for Pareto analysis of return drivers."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RMA request — used to track authorization bottlenecks."
    - name: "is_warranty_claim"
      expr: is_warranty_claim
      comment: "Flag indicating whether the return is a warranty claim — used to separate warranty liability from commercial returns."
    - name: "is_damaged"
      expr: is_damaged
      comment: "Flag indicating whether the returned item was damaged — used to assess carrier and handling damage rates."
    - name: "is_repairable"
      expr: is_repairable
      comment: "Flag indicating whether the returned item can be repaired — used to optimize disposition decisions and recovery value."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the RMA was requested — used for return volume trend analysis."
  measures:
    - name: "total_rmas"
      expr: COUNT(DISTINCT order_rma_id)
      comment: "Total number of distinct RMA requests — baseline return volume KPI; rising trend signals product quality or fulfillment issues."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued for returns — financial exposure KPI for Finance and Customer Service; directly impacts revenue recognition."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all RMAs — cash outflow KPI for treasury and customer service cost management."
    - name: "total_handling_fee"
      expr: SUM(CAST(handling_fee AS DOUBLE))
      comment: "Total handling fees charged on returns — used to assess cost recovery from return processing."
    - name: "total_net_return_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of returned goods — used to calculate net revenue impact of returns."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit value per RMA — used to benchmark return severity and identify high-value return patterns."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN is_warranty_claim = TRUE THEN order_rma_id END)
      comment: "Number of RMAs that are warranty claims — warranty liability KPI used by Finance and Engineering to manage warranty reserves."
    - name: "damaged_return_count"
      expr: COUNT(CASE WHEN is_damaged = TRUE THEN order_rma_id END)
      comment: "Number of returns involving damaged goods — carrier and handling quality KPI; high counts trigger carrier performance reviews."
    - name: "repairable_return_count"
      expr: COUNT(CASE WHEN is_repairable = TRUE THEN order_rma_id END)
      comment: "Number of returned items that are repairable — asset recovery KPI; high counts indicate refurbishment and resale opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_fulfillment_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance KPIs measuring on-time delivery performance against contractual commitments. Used by Customer Service VPs and Account Managers to manage SLA adherence and identify breach risk."
  source: "`vibe_manufacturing_v1`.`order`.`fulfillment_sla`"
  dimensions:
    - name: "fulfillment_sla_status"
      expr: fulfillment_sla_status
      comment: "Current status of the SLA agreement (e.g., Active, Expired, Breached) — primary filter for active SLA monitoring."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., Delivery Lead Time, Order Confirmation, Fill Rate) — used to segment SLA performance by commitment type."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Boolean flag indicating whether the SLA was met — primary compliance indicator for SLA performance reporting."
    - name: "applicable_product_category_code"
      expr: applicable_product_category_code
      comment: "Product category to which the SLA applies — used to analyze SLA performance by product segment."
    - name: "expedite_eligible"
      expr: expedite_eligible
      comment: "Flag indicating whether expediting is allowed under this SLA — used to assess escalation options for at-risk orders."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the SLA became effective — used for cohort analysis of SLA performance over time."
  measures:
    - name: "total_sla_agreements"
      expr: COUNT(DISTINCT fulfillment_sla_id)
      comment: "Total number of active SLA agreements — baseline coverage KPI for customer commitment management."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN fulfillment_sla_id END)
      comment: "Number of SLA agreements where the commitment was met — numerator for SLA compliance rate."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN fulfillment_sla_id END) / NULLIF(COUNT(DISTINCT fulfillment_sla_id), 0), 2)
      comment: "Percentage of SLA agreements where the commitment was met — premier customer service KPI; breaches trigger penalty clauses and customer escalations."
    - name: "avg_on_time_delivery_threshold_pct"
      expr: AVG(CAST(on_time_delivery_threshold_pct AS DOUBLE))
      comment: "Average contractual on-time delivery threshold across all SLAs — used to benchmark the stringency of customer commitments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods issue KPIs covering inventory outflow volumes, values, and posting performance. Used by Supply Chain and Finance to manage inventory accuracy, cost of goods sold, and outbound logistics."
  source: "`vibe_manufacturing_v1`.`order`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue posting (e.g., Posted, Reversed, Pending) — primary filter for completed vs. open goods movements."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code — used to classify goods issue transactions by business purpose."
    - name: "plant"
      expr: plant
      comment: "Plant from which goods were issued — enables plant-level inventory outflow analysis."
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location from which goods were issued — used for warehouse-level inventory management."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the goods issue was reversed — used to identify and investigate posting errors."
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether the goods issue was system-automated — used to measure automation adoption in outbound logistics."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_timestamp)
      comment: "Month the goods issue was posted — used for inventory outflow trend analysis and period-end reconciliation."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status at time of goods issue — used to track goods issued under quality holds or waivers."
  measures:
    - name: "total_goods_issues"
      expr: COUNT(DISTINCT goods_issue_id)
      comment: "Total number of distinct goods issue transactions — baseline outbound inventory movement volume KPI."
    - name: "total_issued_quantity"
      expr: SUM(CAST(issued_quantity AS DOUBLE))
      comment: "Total quantity of goods issued — inventory outflow volume KPI used for COGS calculation and inventory reconciliation."
    - name: "total_goods_value"
      expr: SUM(CAST(total_value_cost AS DOUBLE))
      comment: "Total cost value of goods issued — COGS contribution KPI used by Finance for period-end inventory valuation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of goods issued — revenue-side goods movement value for financial reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods issues — used for tax liability reporting and compliance."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN goods_issue_id END) / NULLIF(COUNT(DISTINCT goods_issue_id), 0), 2)
      comment: "Percentage of goods issues that were reversed — data quality and process accuracy KPI; high reversal rates indicate posting errors or process breakdowns."
    - name: "avg_value_per_goods_issue"
      expr: AVG(CAST(total_value_cost AS DOUBLE))
      comment: "Average cost value per goods issue transaction — used to benchmark transaction size and identify outliers."
    - name: "automated_goods_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN goods_issue_id END) / NULLIF(COUNT(DISTINCT goods_issue_id), 0), 2)
      comment: "Percentage of goods issues processed automatically — automation adoption KPI; higher rates reduce manual effort and posting errors."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order lifecycle event KPIs measuring status transition velocity, SLA breach rates, and process bottlenecks. Used by Sales Operations and Customer Service to manage order cycle time and escalation triggers."
  source: "`vibe_manufacturing_v1`.`order`.`order_status_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of status change event (e.g., Created, Confirmed, Shipped, Cancelled) — used to analyze order lifecycle stage distribution."
    - name: "new_status"
      expr: new_status
      comment: "The status the order transitioned to — used to measure order flow through lifecycle stages."
    - name: "previous_status"
      expr: previous_status
      comment: "The status the order transitioned from — used to identify common transition paths and bottlenecks."
    - name: "event_source"
      expr: event_source
      comment: "System or process that triggered the status event — used to attribute status changes to specific systems or users."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether this status event represents an SLA breach — primary filter for SLA compliance monitoring."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the status event occurred — used for order lifecycle trend analysis."
  measures:
    - name: "total_status_events"
      expr: COUNT(DISTINCT order_status_event_id)
      comment: "Total number of order status change events — baseline order activity volume KPI."
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN order_status_event_id END)
      comment: "Total number of status events that triggered an SLA breach — customer service risk KPI; directly impacts penalty exposure and customer satisfaction."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN order_status_event_id END) / NULLIF(COUNT(DISTINCT order_status_event_id), 0), 2)
      comment: "Percentage of order status events that resulted in an SLA breach — premier order management KPI; high rates signal systemic process failures requiring executive intervention."
    - name: "distinct_orders_with_events"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct orders that have had at least one status event — used to measure order activity coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order utilization and commitment KPIs. Used by Sales and Procurement leadership to manage long-term customer commitments, release cadence, and contract value realization."
  source: "`vibe_manufacturing_v1`.`order`.`blanket_order`"
  dimensions:
    - name: "blanket_order_status"
      expr: blanket_order_status
      comment: "Current status of the blanket order (e.g., Active, Expired, Closed) — primary filter for active contract monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of blanket order contract — used to segment commitment analysis by contract structure."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the blanket order — enables regional contract performance analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the blanket order — used for channel mix analysis of long-term commitments."
    - name: "is_jit_enabled"
      expr: is_jit_enabled
      comment: "Flag indicating whether just-in-time releases are enabled — used to segment JIT vs. standard blanket order performance."
    - name: "release_frequency"
      expr: release_frequency
      comment: "Frequency of scheduled releases (e.g., Weekly, Monthly) — used to plan supply and production scheduling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the blanket order — required for multi-currency contract value reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the blanket order became effective — used for contract cohort analysis."
  measures:
    - name: "total_blanket_orders"
      expr: COUNT(DISTINCT blanket_order_id)
      comment: "Total number of active blanket orders — baseline long-term commitment volume KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed contract value across all blanket orders — strategic revenue pipeline KPI used in sales forecasting and capacity planning."
    - name: "total_released_value"
      expr: SUM(CAST(cumulative_released_value AS DOUBLE))
      comment: "Total value released against blanket orders to date — measures contract consumption and revenue realization."
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total value committed under blanket orders — used to measure firm demand backlog from long-term contracts."
    - name: "contract_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_value AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value that has been released — contract consumption KPI; low utilization signals under-ordering risk or customer demand shortfall."
    - name: "total_contract_quantity"
      expr: SUM(CAST(total_contract_quantity AS DOUBLE))
      comment: "Total quantity committed across all blanket orders — demand volume KPI for production and supply planning."
    - name: "total_released_quantity"
      expr: SUM(CAST(cumulative_released_quantity AS DOUBLE))
      comment: "Total quantity released against blanket orders — measures actual demand draw-down against committed volumes."
    - name: "quantity_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of committed quantity that has been released — volume consumption KPI; used alongside value utilization to detect price vs. volume mix shifts."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value per blanket order — used to benchmark deal size and identify strategic vs. transactional customers."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_pricing_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing condition KPIs covering discount rates, surcharges, and tax exposure. Used by Revenue Management and Finance to govern pricing discipline, margin protection, and tax compliance."
  source: "`vibe_manufacturing_v1`.`order`.`pricing_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of pricing condition (e.g., Base Price, Discount, Surcharge, Tax) — primary dimension for pricing structure analysis."
    - name: "condition_status"
      expr: condition_status
      comment: "Current status of the pricing condition (e.g., Active, Expired, Pending) — used to filter active vs. historical pricing."
    - name: "condition_group"
      expr: condition_group
      comment: "Grouping of related pricing conditions — used for pricing procedure and customer group analysis."
    - name: "condition_origin"
      expr: condition_origin
      comment: "Source of the pricing condition (e.g., Manual, Contract, Price List) — used to audit pricing overrides and contract compliance."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the pricing condition is currently active — used to filter live pricing conditions."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether the condition applies to expedited orders — used to analyze premium pricing on rush orders."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing condition — required for multi-currency pricing analysis."
    - name: "validity_start_month"
      expr: DATE_TRUNC('MONTH', validity_start_date)
      comment: "Month the pricing condition became valid — used for pricing trend and seasonality analysis."
  measures:
    - name: "total_pricing_conditions"
      expr: COUNT(DISTINCT pricing_condition_id)
      comment: "Total number of distinct pricing conditions — baseline pricing complexity KPI; high counts may indicate pricing governance issues."
    - name: "total_condition_value"
      expr: SUM(CAST(condition_value AS DOUBLE))
      comment: "Total monetary value of all pricing conditions — used to measure the aggregate financial impact of pricing adjustments."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted across all pricing conditions — margin leakage KPI; directly impacts gross margin and requires executive oversight."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharge amount applied — used to measure revenue recovery from freight, handling, and special service charges."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all pricing conditions — tax liability KPI for compliance and financial reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after all pricing conditions applied — effective revenue KPI after discounts and surcharges."
    - name: "avg_condition_rate_percent"
      expr: AVG(CAST(condition_rate_percent AS DOUBLE))
      comment: "Average pricing condition rate as a percentage — used to benchmark discount and surcharge rates across the order book."
    - name: "discount_to_net_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Discount amount as a percentage of net revenue — pricing discipline KPI; high ratios indicate margin erosion from excessive discounting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold KPIs measuring hold frequency, duration risk, and financial exposure. Used by Order Management and Finance to manage order release bottlenecks and credit/compliance risk."
  source: "`vibe_manufacturing_v1`.`order`.`hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold applied to the order (e.g., Credit, Compliance, Quality, Manual) — primary dimension for hold root-cause analysis."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., Active, Released, Escalated) — used to filter open vs. resolved holds."
    - name: "hold_category"
      expr: hold_category
      comment: "Category of the hold — used to group holds by business function (e.g., Financial, Operational, Regulatory)."
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason the hold was applied — used for Pareto analysis of hold drivers."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Flag indicating whether the hold was automatically generated by the system — used to distinguish automated risk controls from manual interventions."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the hold is compliance-related — used to prioritize regulatory holds for immediate resolution."
    - name: "priority"
      expr: priority
      comment: "Priority level of the hold — used to triage hold resolution workload."
    - name: "applied_month"
      expr: DATE_TRUNC('MONTH', applied_timestamp)
      comment: "Month the hold was applied — used for hold volume trend analysis."
  measures:
    - name: "total_holds"
      expr: COUNT(DISTINCT hold_id)
      comment: "Total number of distinct order holds — baseline hold volume KPI; rising trends signal systemic order management issues."
    - name: "active_holds"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN hold_id END)
      comment: "Number of currently active holds — real-time order book risk KPI; high active hold counts indicate revenue at risk."
    - name: "total_hold_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial value of orders under hold — revenue at risk KPI; directly measures the financial impact of order holds on cash flow."
    - name: "avg_hold_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average financial value per hold — used to benchmark hold severity and prioritize resolution efforts."
    - name: "compliance_hold_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN hold_id END)
      comment: "Number of holds flagged as compliance-related — regulatory risk KPI; compliance holds require immediate escalation to avoid legal exposure."
    - name: "system_generated_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_system_generated = TRUE THEN hold_id END) / NULLIF(COUNT(DISTINCT hold_id), 0), 2)
      comment: "Percentage of holds generated automatically by the system — automation effectiveness KPI; high rates indicate robust automated risk controls."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order amendment KPIs measuring change frequency, financial impact, and approval cycle performance. Used by Sales Operations and Finance to manage order change risk, pricing accuracy, and contract discipline."
  source: "`vibe_manufacturing_v1`.`order`.`amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g., Quantity Change, Price Change, Delivery Date Change, Address Change) — used to classify change drivers."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g., Pending, Approved, Rejected) — used to track amendment pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the amendment — used to identify bottlenecks in the change approval process."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the amendment — used for Pareto analysis of change drivers."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the amendment is critical — used to prioritize high-impact changes for expedited approval."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the amendment — used to triage amendment processing workload."
    - name: "amendment_month"
      expr: DATE_TRUNC('MONTH', amendment_timestamp)
      comment: "Month the amendment was submitted — used for change volume trend analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(DISTINCT amendment_id)
      comment: "Total number of order amendments — baseline change volume KPI; high amendment rates signal poor order quality at entry or unstable customer demand."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised order value across all amendments — measures the financial scale of order changes."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original order value before amendments — baseline for measuring amendment financial impact."
    - name: "net_amendment_value_impact"
      expr: SUM(CAST(revised_amount AS DOUBLE) - CAST(original_amount AS DOUBLE))
      comment: "Net financial impact of amendments (revised minus original) — revenue adjustment KPI; positive values indicate upsells, negative values indicate order reductions."
    - name: "avg_quantity_change"
      expr: AVG(CAST(revised_quantity AS DOUBLE) - CAST(original_quantity AS DOUBLE))
      comment: "Average quantity change per amendment — demand volatility KPI; large average changes indicate unstable customer demand patterns."
    - name: "critical_amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN amendment_id END) / NULLIF(COUNT(DISTINCT amendment_id), 0), 2)
      comment: "Percentage of amendments flagged as critical — escalation risk KPI; high rates indicate systemic order instability requiring process intervention."
    - name: "distinct_orders_amended"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct orders that have been amended — measures the breadth of order change activity across the order book."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule line KPIs measuring delivery commitment accuracy, quantity confirmation rates, and backorder exposure. Used by Supply Chain and Customer Service to manage delivery scheduling and MRP alignment."
  source: "`vibe_manufacturing_v1`.`order`.`line`"
  dimensions:
    - name: "plant"
      expr: plant
      comment: "Plant responsible for fulfilling the schedule line — enables plant-level delivery commitment analysis."
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Flag indicating whether the schedule line is on backorder — used to measure backorder exposure."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of the customer-requested delivery date — used to compare requested vs. confirmed delivery timing."
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers across all schedule lines — demand volume KPI for supply planning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery — supply commitment KPI; gap vs. requested quantity measures unmet demand."
    - name: "schedule_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity confirmed for delivery — supply availability KPI; low rates signal supply constraints or MRP planning gaps."
$$;