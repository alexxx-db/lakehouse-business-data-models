-- Metric views for domain: order | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for order intake, value, and fulfillment performance at the order header level. Used by Sales VPs and Supply Chain leaders to monitor order pipeline health, revenue exposure, and delivery commitments."
  source: "`vibe_manufacturing_v1`.`order`.`order_header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Confirmed, Shipped, Cancelled). Primary dimension for pipeline stage analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Rush, Blanket Release). Drives fulfillment routing and SLA assignment."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the order. Used to triage backlog and allocate capacity."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales distribution channel through which the order was placed. Enables channel-mix revenue analysis."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the order. Supports regional and organizational revenue attribution."
    - name: "order_currency"
      expr: order_currency
      comment: "Currency in which the order is denominated. Required for multi-currency revenue normalization."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms for the order. Informs cash flow forecasting and credit risk analysis."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of the customer-requested delivery date. Used to bucket demand commitments by period."
    - name: "order_placed_month"
      expr: DATE_TRUNC('month', order_placed_timestamp)
      comment: "Month the order was placed. Primary time dimension for order intake trend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery responsibility. Affects freight cost allocation and risk transfer point."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Total number of distinct orders. Baseline volume KPI for order intake monitoring and capacity planning."
    - name: "total_net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net order value across all orders. Primary revenue pipeline measure used in QBRs and board reporting."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross order value before tax deductions. Used to assess top-line revenue exposure."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax liability across all orders. Required for tax compliance reporting and cash flow planning."
    - name: "avg_order_net_value"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net value per order. Strategic KPI for monitoring deal size trends and pricing effectiveness."
    - name: "avg_order_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per order in kilograms. Used by logistics to plan carrier capacity and freight cost budgeting."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of all orders in kilograms. Drives freight capacity planning and logistics cost forecasting."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volumetric size of all orders in cubic meters. Used for warehouse space and container utilization planning."
    - name: "avg_currency_rate"
      expr: AVG(CAST(currency_rate AS DOUBLE))
      comment: "Average exchange rate applied across orders. Used by Finance to assess FX exposure in multi-currency order books."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order KPIs covering revenue, quantity, pricing, and fulfillment performance. Used by Sales Operations and Supply Chain to analyze product-level demand, pricing effectiveness, and delivery execution."
  source: "`vibe_manufacturing_v1`.`order`.`line`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status of the order line (e.g. Pending, Shipped, Delivered, Backordered). Core dimension for fulfillment performance analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of the line item. Used to track quality-related holds and rejections at line level."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason code for line rejection. Drives root-cause analysis of order fulfillment failures."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the order line. Enables channel-level revenue and volume analysis."
    - name: "plant"
      expr: plant
      comment: "Manufacturing or fulfillment plant assigned to the line. Used for plant-level capacity and output analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity. Required for volume normalization across product lines."
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Flag indicating whether the line is on backorder. Key dimension for backlog and service level analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of the scheduled delivery date. Used to bucket line-level demand by delivery period."
    - name: "promised_date_month"
      expr: DATE_TRUNC('month', promised_date)
      comment: "Month of the promised delivery date. Used to measure promise-to-actual delivery performance."
  measures:
    - name: "total_order_lines"
      expr: COUNT(DISTINCT line_id)
      comment: "Total number of distinct order lines. Baseline volume measure for order complexity and workload analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Sum of net price across all order lines. Primary line-level revenue measure for product and channel mix analysis."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_price AS DOUBLE))
      comment: "Sum of gross price across all order lines before discounts. Used to assess pricing power and discount impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across order lines. Strategic KPI for pricing governance and margin protection."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across order lines. Required for tax compliance and financial reporting."
    - name: "total_sales_revenue"
      expr: SUM(CAST(sales_price AS DOUBLE))
      comment: "Sum of sales price across all order lines. Used for top-line revenue reporting by product and channel."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers across all order lines. Drives demand planning and inventory replenishment decisions."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for fulfillment. Measures supply commitment against customer demand."
    - name: "total_sales_quantity"
      expr: SUM(CAST(sales_quantity AS DOUBLE))
      comment: "Total quantity sold across all order lines. Core volume KPI for sales performance and market share analysis."
    - name: "avg_net_price_per_line"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per order line. Used to monitor pricing trends and average selling price (ASP) movements."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across order lines. Tracks product quality at point of order fulfillment for supplier and production accountability."
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight AS DOUBLE))
      comment: "Total gross weight across all order lines. Used for freight planning and logistics cost allocation."
    - name: "total_volume"
      expr: SUM(CAST(volume AS DOUBLE))
      comment: "Total volumetric size across all order lines. Drives container and warehouse space planning."
    - name: "backorder_line_count"
      expr: COUNT(CASE WHEN backorder_indicator = TRUE THEN line_id END)
      comment: "Number of order lines currently on backorder. Critical KPI for service level monitoring and customer escalation management."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_price AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross price. Measures pricing discipline and discount leakage across the order book."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity confirmed for fulfillment. Key supply chain KPI measuring ability to meet customer demand commitments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery execution KPIs covering freight costs, on-time performance, and logistics efficiency. Used by Supply Chain and Logistics leaders to monitor delivery reliability and cost-to-serve."
  source: "`vibe_manufacturing_v1`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. In Transit, Delivered, Failed). Primary dimension for delivery pipeline monitoring."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g. Standard, Express, Drop-Ship). Used to analyze cost and performance by delivery mode."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping condition code governing carrier and route selection. Enables cost and SLA analysis by shipping mode."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Origin shipping point for the delivery. Used for plant-level outbound logistics performance analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the delivery. Used to assess whether high-priority deliveries are being expedited appropriately."
    - name: "is_backorder"
      expr: is_backorder
      comment: "Flag indicating whether the delivery fulfills a backorder. Used to track backorder clearance rates."
    - name: "is_partial_delivery"
      expr: is_partial_delivery
      comment: "Flag indicating a partial delivery was made. Tracks split-shipment frequency and its impact on customer satisfaction."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the delivery contains hazardous materials. Required for compliance and carrier routing analysis."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('month', planned_delivery_date)
      comment: "Month of the planned delivery date. Used to bucket delivery commitments by period for capacity planning."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month of the actual delivery date. Used to measure delivery volume trends and seasonal patterns."
    - name: "country"
      expr: country
      comment: "Destination country of the delivery. Enables geographic analysis of delivery performance and freight costs."
  measures:
    - name: "total_deliveries"
      expr: COUNT(DISTINCT delivery_id)
      comment: "Total number of distinct deliveries. Baseline volume KPI for outbound logistics workload and throughput."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all deliveries. Primary cost KPI for logistics spend management and carrier negotiation."
    - name: "total_freight_tax"
      expr: SUM(CAST(freight_tax_amount AS DOUBLE))
      comment: "Total freight tax across all deliveries. Required for tax compliance and landed cost calculation."
    - name: "total_freight_total"
      expr: SUM(CAST(freight_total_amount AS DOUBLE))
      comment: "Total all-in freight cost including tax. Used for cost-to-serve analysis and customer profitability."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery. Benchmarks carrier efficiency and identifies cost outliers for renegotiation."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total weight shipped across all deliveries in kilograms. Used for carrier capacity planning and freight rate benchmarking."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume shipped across all deliveries in cubic meters. Drives container utilization and warehouse throughput analysis."
    - name: "partial_delivery_count"
      expr: COUNT(CASE WHEN is_partial_delivery = TRUE THEN delivery_id END)
      comment: "Number of partial deliveries. High partial delivery rates signal supply constraints and negatively impact customer satisfaction scores."
    - name: "backorder_delivery_count"
      expr: COUNT(CASE WHEN is_backorder = TRUE THEN delivery_id END)
      comment: "Number of deliveries fulfilling backorders. Tracks backlog clearance velocity and supply recovery performance."
    - name: "partial_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial_delivery = TRUE THEN delivery_id END) / NULLIF(COUNT(DISTINCT delivery_id), 0), 2)
      comment: "Percentage of deliveries that were partial. Key customer experience KPI — high rates indicate supply chain fragmentation."
    - name: "avg_gross_weight_per_delivery_kg"
      expr: AVG(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Average shipment weight per delivery. Used to optimize load planning and assess carrier rate efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level delivery KPIs covering quantity accuracy, picking performance, and quality at the shipment line level. Used by Warehouse Operations and Quality teams to monitor fulfillment precision and goods movement efficiency."
  source: "`vibe_manufacturing_v1`.`order`.`delivery_item`"
  dimensions:
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Status of the goods movement for the delivery item. Tracks physical inventory transfer completion."
    - name: "picking_status"
      expr: picking_status
      comment: "Warehouse picking status for the item. Used to monitor pick completion rates and warehouse throughput."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the delivery item. Tracks quality gate pass/fail rates at point of shipment."
    - name: "item_category"
      expr: item_category
      comment: "Category classification of the delivery item. Enables product-category-level fulfillment analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code. Distinguishes standard shipments from returns, transfers, and adjustments."
    - name: "plant"
      expr: plant
      comment: "Plant from which the item was shipped. Enables plant-level outbound performance benchmarking."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping condition for the item. Used to analyze fulfillment performance by shipping mode."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of the item delivery date. Used to trend item-level fulfillment volumes over time."
  measures:
    - name: "total_delivery_items"
      expr: COUNT(DISTINCT delivery_item_id)
      comment: "Total number of distinct delivery line items. Baseline volume KPI for warehouse throughput and pick workload."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all delivery items. Measures demand volume flowing through the warehouse."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total quantity picked in the warehouse. Measures warehouse execution against order demand."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity actually delivered to customers. Core fulfillment volume KPI for revenue recognition and customer service."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of delivered items in kilograms. Used for freight cost allocation and carrier performance benchmarking."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of delivered items in cubic meters. Drives container and warehouse space utilization analysis."
    - name: "pick_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_picked AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully picked. Measures warehouse accuracy — low rates indicate pick errors, shortages, or process failures."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_delivered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually delivered. Key customer service KPI measuring end-to-end fulfillment completeness."
    - name: "quantity_shortfall"
      expr: SUM(CAST(quantity_ordered AS DOUBLE) - CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity gap between what was ordered and what was delivered. Quantifies unfulfilled demand for backorder and supply recovery planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Merchandise Authorization KPIs covering return volumes, credit exposure, and return reason analysis. Used by Customer Service, Quality, and Finance leaders to manage return rates, credit liability, and product quality feedback loops."
  source: "`vibe_manufacturing_v1`.`order`.`order_rma`"
  dimensions:
    - name: "order_rma_status"
      expr: order_rma_status
      comment: "Current status of the RMA (e.g. Pending, Approved, Received, Closed). Primary dimension for return pipeline management."
    - name: "rma_type"
      expr: rma_type
      comment: "Type of return (e.g. Defective, Wrong Item, Warranty). Drives root-cause analysis and quality improvement initiatives."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return. Used to identify systemic quality or fulfillment issues requiring corrective action."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RMA request. Tracks authorization bottlenecks in the returns process."
    - name: "is_warranty_claim"
      expr: is_warranty_claim
      comment: "Flag indicating whether the return is a warranty claim. Separates warranty liability from standard returns for financial provisioning."
    - name: "is_damaged"
      expr: is_damaged
      comment: "Flag indicating whether the returned item was damaged. Used to assess carrier damage rates and packaging quality."
    - name: "is_repairable"
      expr: is_repairable
      comment: "Flag indicating whether the returned item can be repaired. Drives repair vs. scrap disposition decisions and cost recovery."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RMA credit. Required for multi-currency credit liability reporting."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the RMA was requested. Used to trend return volumes and identify seasonal quality patterns."
  measures:
    - name: "total_rmas"
      expr: COUNT(DISTINCT order_rma_id)
      comment: "Total number of distinct RMAs. Baseline return volume KPI for customer service workload and quality performance monitoring."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued or pending across all RMAs. Primary financial KPI for return liability and revenue reversal exposure."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount across all RMAs. Measures cash outflow from returns for cash flow and P&L impact analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of returned goods. Used to quantify the revenue impact of returns on the order book."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax associated with RMAs. Required for tax reclaim processing and compliance reporting."
    - name: "total_handling_fee"
      expr: SUM(CAST(handling_fee AS DOUBLE))
      comment: "Total handling fees charged on returns. Measures cost recovery from return processing operations."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit value per RMA. Tracks average return value to identify high-value return patterns requiring management attention."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN is_warranty_claim = TRUE THEN order_rma_id END)
      comment: "Number of RMAs that are warranty claims. Tracks warranty liability exposure and product reliability performance."
    - name: "damaged_return_count"
      expr: COUNT(CASE WHEN is_damaged = TRUE THEN order_rma_id END)
      comment: "Number of returns involving damaged goods. Used to assess carrier damage rates and packaging adequacy."
    - name: "warranty_claim_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_warranty_claim = TRUE THEN order_rma_id END) / NULLIF(COUNT(DISTINCT order_rma_id), 0), 2)
      comment: "Percentage of RMAs that are warranty claims. Strategic quality KPI — rising rates signal product reliability issues requiring engineering intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order amendment KPIs measuring change frequency, value impact, and approval cycle times. Used by Sales Operations and Customer Service to monitor order instability, rework costs, and amendment processing efficiency."
  source: "`vibe_manufacturing_v1`.`order`.`order_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Quantity Change, Price Change, Delivery Date Change). Identifies the most common sources of order instability."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected). Tracks amendment pipeline and approval bottlenecks."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval decision on the amendment. Used to measure approval rates and rejection patterns."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the amendment. Drives root-cause analysis of order changes and customer behavior patterns."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the amendment is business-critical. Used to prioritize amendment processing and escalation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment values. Required for multi-currency financial impact analysis."
    - name: "amendment_month"
      expr: DATE_TRUNC('month', amendment_timestamp)
      comment: "Month the amendment was submitted. Used to trend amendment frequency and identify periods of high order instability."
  measures:
    - name: "total_amendments"
      expr: COUNT(DISTINCT order_amendment_id)
      comment: "Total number of order amendments. Baseline KPI for order instability — high amendment rates increase operational cost and delivery risk."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original order value before amendments. Baseline for measuring the financial scale of order changes."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised order value after amendments. Used to measure net revenue impact of order changes."
    - name: "total_value_change"
      expr: SUM(CAST(revised_amount AS DOUBLE) - CAST(original_amount AS DOUBLE))
      comment: "Net change in order value due to amendments. Quantifies revenue uplift or erosion from order modifications."
    - name: "total_quantity_change"
      expr: SUM(CAST(revised_quantity AS DOUBLE) - CAST(original_quantity AS DOUBLE))
      comment: "Net change in order quantity due to amendments. Measures demand volatility and its impact on production and inventory planning."
    - name: "avg_value_change_per_amendment"
      expr: AVG(CAST(revised_amount AS DOUBLE) - CAST(original_amount AS DOUBLE))
      comment: "Average value change per amendment. Identifies whether amendments are systematically increasing or decreasing order values."
    - name: "critical_amendment_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN order_amendment_id END)
      comment: "Number of critical amendments requiring expedited processing. Used to manage escalation workload and SLA compliance."
    - name: "critical_amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN order_amendment_id END) / NULLIF(COUNT(DISTINCT order_amendment_id), 0), 2)
      comment: "Percentage of amendments flagged as critical. High rates indicate systemic order quality issues or customer instability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold KPIs measuring hold frequency, duration, and financial exposure. Used by Credit, Compliance, and Sales Operations to manage order release velocity and identify systemic hold causes."
  source: "`vibe_manufacturing_v1`.`order`.`order_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold placed on the order (e.g. Credit, Compliance, Quality). Primary dimension for hold root-cause analysis."
    - name: "hold_category"
      expr: hold_category
      comment: "Category grouping for the hold. Used to aggregate hold volumes by business function for management reporting."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g. Active, Released, Escalated). Tracks hold pipeline and release backlog."
    - name: "hold_source"
      expr: hold_source
      comment: "System or process that triggered the hold. Used to identify automated vs. manual hold sources and process improvement opportunities."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the hold is compliance-related. Separates regulatory holds from operational holds for risk reporting."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Flag indicating whether the hold was automatically generated. Used to assess automation effectiveness in credit and compliance controls."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the hold amount. Required for multi-currency financial exposure reporting."
    - name: "placed_month"
      expr: DATE_TRUNC('month', placed_timestamp)
      comment: "Month the hold was placed. Used to trend hold frequency and identify periods of elevated credit or compliance risk."
  measures:
    - name: "total_holds"
      expr: COUNT(DISTINCT order_hold_id)
      comment: "Total number of order holds placed. Baseline KPI for order release friction — high hold counts delay revenue recognition."
    - name: "total_hold_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial value of orders currently or historically on hold. Measures revenue at risk from hold-related delays."
    - name: "avg_hold_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average financial value per hold. Used to assess the typical revenue impact of a hold event and prioritize release actions."
    - name: "compliance_hold_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN order_hold_id END)
      comment: "Number of holds flagged as compliance-related. Tracks regulatory risk exposure in the order book."
    - name: "system_generated_hold_count"
      expr: COUNT(CASE WHEN is_system_generated = TRUE THEN order_hold_id END)
      comment: "Number of holds automatically generated by system controls. Measures effectiveness of automated credit and compliance monitoring."
    - name: "compliance_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN order_hold_id END) / NULLIF(COUNT(DISTINCT order_hold_id), 0), 2)
      comment: "Percentage of holds that are compliance-related. Rising rates signal increasing regulatory risk in the order pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods issue KPIs covering outbound inventory movement values, reversal rates, and posting performance. Used by Inventory Control and Finance to monitor inventory outflow accuracy and cost of goods issued."
  source: "`vibe_manufacturing_v1`.`order`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue posting (e.g. Posted, Reversed, Pending). Primary dimension for goods movement pipeline analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code. Distinguishes standard outbound shipments from transfers, adjustments, and reversals."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status at time of goods issue. Used to track quality-related holds on outbound inventory."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the goods issue was reversed. High reversal rates signal posting errors or process failures."
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether the goods issue was automatically posted. Measures automation adoption in outbound inventory processing."
    - name: "plant"
      expr: plant
      comment: "Plant from which goods were issued. Enables plant-level inventory outflow and cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue valuation. Required for multi-currency inventory cost reporting."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_timestamp)
      comment: "Month the goods issue was posted. Primary time dimension for inventory outflow trend analysis and period-end reconciliation."
  measures:
    - name: "total_goods_issues"
      expr: COUNT(DISTINCT goods_issue_id)
      comment: "Total number of goods issue postings. Baseline volume KPI for outbound inventory transaction throughput."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods issued. Primary financial KPI for cost of goods sold (COGS) and inventory outflow reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on goods issued. Required for tax compliance and landed cost analysis."
    - name: "total_cost_value"
      expr: SUM(CAST(total_value_cost AS DOUBLE))
      comment: "Total cost value of goods issued. Used for inventory valuation, COGS calculation, and margin analysis."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods issued across all postings. Measures physical inventory outflow volume for supply planning."
    - name: "avg_cost_per_issue"
      expr: AVG(CAST(total_value_cost AS DOUBLE))
      comment: "Average cost value per goods issue posting. Used to benchmark unit cost trends and identify cost anomalies."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN goods_issue_id END)
      comment: "Number of goods issues that were reversed. High reversal counts indicate posting errors, process failures, or fraudulent activity."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN goods_issue_id END) / NULLIF(COUNT(DISTINCT goods_issue_id), 0), 2)
      comment: "Percentage of goods issues that were reversed. Key process quality KPI — high rates increase audit risk and inventory inaccuracy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order KPIs measuring committed value, release utilization, and contract compliance. Used by Procurement and Sales leaders to monitor long-term supply agreements, release cadence, and commitment fulfillment."
  source: "`vibe_manufacturing_v1`.`order`.`blanket_order`"
  dimensions:
    - name: "blanket_order_status"
      expr: blanket_order_status
      comment: "Current status of the blanket order (e.g. Active, Expired, Closed). Primary dimension for agreement portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of blanket order contract. Used to analyze commitment structures and pricing arrangements by contract category."
    - name: "contract_status_reason"
      expr: contract_status_reason
      comment: "Reason for the current contract status. Used to understand why agreements are inactive or terminated."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the blanket order. Enables channel-level commitment and release analysis."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization owning the blanket order. Supports organizational-level commitment portfolio analysis."
    - name: "release_frequency"
      expr: release_frequency
      comment: "Frequency at which releases are expected (e.g. Weekly, Monthly). Used to assess release cadence compliance."
    - name: "is_jit_enabled"
      expr: is_jit_enabled
      comment: "Flag indicating whether Just-In-Time delivery is enabled. Used to segment JIT vs. standard blanket order performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the blanket order. Required for multi-currency commitment portfolio reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the blanket order became effective. Used to analyze agreement vintage and portfolio renewal patterns."
  measures:
    - name: "total_blanket_orders"
      expr: COUNT(DISTINCT blanket_order_id)
      comment: "Total number of active blanket orders. Baseline KPI for long-term supply agreement portfolio size."
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total value committed across all blanket orders. Primary financial KPI for long-term revenue and supply commitment exposure."
    - name: "total_released_value"
      expr: SUM(CAST(cumulative_released_value AS DOUBLE))
      comment: "Total value released against blanket orders. Measures actual revenue realization from committed agreements."
    - name: "total_committed_quantity"
      expr: SUM(CAST(total_committed_quantity AS DOUBLE))
      comment: "Total quantity committed across all blanket orders. Used for long-range demand planning and capacity reservation."
    - name: "total_released_quantity"
      expr: SUM(CAST(cumulative_released_quantity AS DOUBLE))
      comment: "Total quantity released against blanket orders. Measures physical fulfillment progress against committed volumes."
    - name: "release_value_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_value AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_value AS DOUBLE)), 0), 2)
      comment: "Percentage of committed value that has been released. Measures blanket order utilization — low rates may indicate demand shortfalls or supply issues."
    - name: "release_quantity_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of committed quantity that has been released. Key procurement KPI for monitoring take-or-pay compliance and demand realization."
    - name: "avg_committed_value_per_order"
      expr: AVG(CAST(total_committed_value AS DOUBLE))
      comment: "Average committed value per blanket order. Used to benchmark deal size and assess portfolio concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_fulfillment_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment SLA KPIs measuring on-time delivery thresholds, SLA coverage, and contract compliance. Used by Customer Service and Supply Chain leaders to monitor service level commitments and identify at-risk customer agreements."
  source: "`vibe_manufacturing_v1`.`order`.`fulfillment_sla`"
  dimensions:
    - name: "fulfillment_sla_status"
      expr: fulfillment_sla_status
      comment: "Current status of the SLA agreement (e.g. Active, Expired, Breached). Primary dimension for SLA portfolio health monitoring."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. Delivery, Response, Resolution). Used to analyze performance by SLA category."
    - name: "expedite_eligible"
      expr: expedite_eligible
      comment: "Flag indicating whether expedited fulfillment is permitted under the SLA. Used to assess premium service tier coverage."
    - name: "applicable_product_category_code"
      expr: applicable_product_category_code
      comment: "Product category to which the SLA applies. Enables product-category-level service level analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the SLA became effective. Used to analyze SLA portfolio vintage and renewal patterns."
  measures:
    - name: "total_sla_agreements"
      expr: COUNT(DISTINCT fulfillment_sla_id)
      comment: "Total number of fulfillment SLA agreements. Baseline KPI for service commitment portfolio size."
    - name: "avg_on_time_delivery_threshold_pct"
      expr: AVG(CAST(on_time_delivery_threshold_pct AS DOUBLE))
      comment: "Average on-time delivery threshold committed across SLA agreements. Benchmarks the service level bar set with customers — rising averages indicate tightening commitments."
    - name: "expedite_eligible_count"
      expr: COUNT(CASE WHEN expedite_eligible = TRUE THEN fulfillment_sla_id END)
      comment: "Number of SLA agreements with expedite eligibility. Measures premium service tier exposure and associated cost risk."
    - name: "expedite_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedite_eligible = TRUE THEN fulfillment_sla_id END) / NULLIF(COUNT(DISTINCT fulfillment_sla_id), 0), 2)
      comment: "Percentage of SLA agreements that allow expedited fulfillment. High rates increase logistics cost exposure and operational complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_pricing_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing condition KPIs measuring discount depth, surcharge application, and net pricing effectiveness. Used by Revenue Management and Sales Finance to monitor pricing discipline, tax exposure, and condition-level margin impact."
  source: "`vibe_manufacturing_v1`.`order`.`pricing_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of pricing condition (e.g. Discount, Surcharge, Tax, Freight). Primary dimension for pricing component analysis."
    - name: "condition_status"
      expr: condition_status
      comment: "Current status of the pricing condition (e.g. Active, Expired, Inactive). Used to filter active vs. historical pricing analysis."
    - name: "condition_group"
      expr: condition_group
      comment: "Grouping of related pricing conditions. Enables analysis of pricing bundles and condition hierarchies."
    - name: "condition_origin"
      expr: condition_origin
      comment: "Source of the pricing condition (e.g. Manual, Contract, Automatic). Used to assess pricing governance and manual override rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing condition. Required for multi-currency pricing analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the pricing condition is currently active. Used to filter live pricing conditions for real-time analysis."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether the condition applies to expedited orders. Used to analyze premium pricing uplift from expedite surcharges."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the pricing condition. Required for tax compliance and jurisdiction-level tax analysis."
    - name: "condition_effective_month"
      expr: DATE_TRUNC('month', condition_effective_timestamp)
      comment: "Month the pricing condition became effective. Used to trend pricing condition changes over time."
  measures:
    - name: "total_pricing_conditions"
      expr: COUNT(DISTINCT pricing_condition_id)
      comment: "Total number of pricing conditions applied. Baseline KPI for pricing complexity and condition volume management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after all pricing conditions. Primary revenue measure at the pricing condition level."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across all pricing conditions. Key margin management KPI for pricing governance and leakage control."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharge revenue collected. Measures recovery of premium service costs through pricing conditions."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all pricing conditions. Required for tax liability reporting and compliance."
    - name: "avg_condition_rate"
      expr: AVG(CAST(condition_rate AS DOUBLE))
      comment: "Average pricing condition rate applied. Used to benchmark discount and surcharge rates across the order book."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across pricing conditions. Used by Tax to monitor effective tax rate trends and jurisdiction mix."
    - name: "discount_to_net_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of net amount. Measures pricing discipline — high ratios indicate margin erosion from excessive discounting."
$$;