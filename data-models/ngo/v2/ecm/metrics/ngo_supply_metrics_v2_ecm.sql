-- Metric views for domain: supply | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_procurement_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for procurement pipeline: tracks request volumes, estimated spend, urgency distribution, and approval cycle efficiency. Informs procurement planning and budget utilization decisions."
  source: "`vibe_ngo_v1`.`supply`.`procurement_request`"
  dimensions:
    - name: "procurement_type"
      expr: procurement_request_type
      comment: "Type of procurement request (goods, services, works) for spend categorisation."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the requested items, enabling category-level spend analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification (routine, urgent, emergency) to prioritise procurement pipeline."
    - name: "procurement_status"
      expr: procurement_request_status
      comment: "Current workflow status of the procurement request (draft, submitted, approved, rejected)."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', procurement_request_date)
      comment: "Month the procurement request was raised, for trend analysis."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Approval authority level required, useful for bottleneck analysis."
    - name: "local_procurement_preference"
      expr: local_procurement_preference
      comment: "Flag indicating whether local procurement is preferred, supporting localisation KPIs."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the procurement request is visible to donors, relevant for donor reporting."
  measures:
    - name: "total_procurement_requests"
      expr: COUNT(1)
      comment: "Total number of procurement requests raised. Baseline volume KPI for pipeline monitoring."
    - name: "total_estimated_spend_usd"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated procurement spend across all requests. Core financial planning KPI."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost per procurement request, used to benchmark pricing and detect outliers."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity of items requested across all procurement requests, informing demand planning."
    - name: "emergency_request_count"
      expr: COUNT(CASE WHEN urgency_level = 'emergency' THEN 1 END)
      comment: "Number of emergency procurement requests. High values signal supply chain stress or crisis response demand."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN procurement_request_status = 'approved' THEN 1 END)
      comment: "Number of approved procurement requests. Used to measure approval throughput."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN procurement_request_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procurement requests that have been approved. Low rates indicate bottlenecks or quality issues."
    - name: "sole_source_request_count"
      expr: COUNT(CASE WHEN sole_source_justification IS NOT NULL AND sole_source_justification <> '' THEN 1 END)
      comment: "Number of requests with sole-source justification. Elevated counts may indicate competition or compliance risk."
    - name: "donor_restricted_request_count"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Number of procurement requests with donor visibility, relevant for donor compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for purchase orders: tracks committed spend, delivery performance, and procurement method mix. Core dashboard for supply chain finance and operations leadership."
  source: "`vibe_ngo_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (open, partially received, closed, cancelled)."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, emergency, framework call-off) for spend categorisation."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (competitive bidding, direct, framework) for compliance and efficiency analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of items ordered, enabling category-level spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency spend analysis."
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Indicates whether the PO was raised as an emergency procurement."
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was issued, for trend and seasonality analysis."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt status of the PO, indicating delivery completion."
    - name: "invoice_matching_status"
      expr: invoice_matching_status
      comment: "Invoice matching status for three-way match compliance monitoring."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline procurement activity volume."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Primary financial commitment KPI."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax subtotals across purchase orders, used for net spend analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across purchase orders, relevant for VAT recovery and cost analysis."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across purchase orders. High freight ratios signal logistics inefficiency."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Useful for benchmarking and detecting anomalous orders."
    - name: "emergency_po_count"
      expr: COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END)
      comment: "Number of emergency purchase orders. High counts indicate reactive procurement and potential cost premiums."
    - name: "emergency_po_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs flagged as emergency. A key procurement quality and planning KPI."
    - name: "freight_to_total_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Freight cost as a percentage of total PO value. Measures logistics cost efficiency."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors used. Monitors vendor concentration risk and diversification."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_bid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive procurement KPIs tracking bid quality, award rates, and scoring outcomes. Enables procurement teams and leadership to assess vendor competition health and value-for-money."
  source: "`vibe_ngo_v1`.`supply`.`bid`"
  dimensions:
    - name: "bid_status"
      expr: bid_status
      comment: "Current status of the bid (submitted, evaluated, awarded, rejected)."
    - name: "awarded_flag"
      expr: awarded_flag
      comment: "Whether the bid was awarded, enabling award vs. non-award analysis."
    - name: "currency"
      expr: currency
      comment: "Currency of the bid amount for multi-currency comparison."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month bids were submitted, for pipeline and seasonality analysis."
    - name: "rank"
      expr: rank
      comment: "Bid ranking position in the evaluation, used to analyse competitiveness."
  measures:
    - name: "total_bids_received"
      expr: COUNT(1)
      comment: "Total number of bids received. Baseline measure of market competition."
    - name: "total_bid_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of all bids submitted. Indicates market pricing and budget alignment."
    - name: "avg_bid_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average bid amount. Benchmarks market pricing for procurement planning."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score across bids. Measures vendor technical quality."
    - name: "avg_financial_score"
      expr: AVG(CAST(financial_score AS DOUBLE))
      comment: "Average financial evaluation score across bids. Measures value-for-money of vendor offers."
    - name: "avg_total_score"
      expr: AVG(CAST(total_score AS DOUBLE))
      comment: "Average combined evaluation score. Overall measure of bid quality in the market."
    - name: "awarded_bid_count"
      expr: COUNT(CASE WHEN awarded_flag = TRUE THEN 1 END)
      comment: "Number of bids that were awarded contracts."
    - name: "award_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN awarded_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bids that resulted in an award. Low rates may indicate poor market fit or overly restrictive requirements."
    - name: "distinct_vendor_bidders"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors submitting bids. Measures market competition breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian distribution KPIs tracking delivery volumes, beneficiary reach, transport costs, and emergency response. Core operational dashboard for field and supply chain leadership."
  source: "`vibe_ngo_v1`.`supply`.`distribution_order`"
  dimensions:
    - name: "distribution_order_status"
      expr: distribution_order_status
      comment: "Current status of the distribution order (planned, dispatched, delivered, cancelled)."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (in-kind, cash, voucher) for modality analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used (road, air, sea) for logistics cost and efficiency analysis."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Whether the distribution is part of an emergency response, for crisis vs. development analysis."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Whether cold chain logistics are required, impacting cost and complexity."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the distribution order for operational triage."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', distribution_order_date)
      comment: "Month the distribution order was created, for trend analysis."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether the distribution involves in-kind donated commodities."
    - name: "medical_supplies_flag"
      expr: medical_supplies_flag
      comment: "Whether the order contains medical supplies, for health programme tracking."
  measures:
    - name: "total_distribution_orders"
      expr: COUNT(1)
      comment: "Total number of distribution orders. Baseline operational throughput KPI."
    - name: "total_estimated_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of all distribution orders in USD. Core financial accountability KPI."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of commodities distributed. Measures programme delivery volume."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of commodities distributed in kilograms. Used for logistics planning and cost allocation."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of commodities distributed in cubic metres. Key for warehouse and transport capacity planning."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport cost across distribution orders. Monitors logistics spend efficiency."
    - name: "avg_transport_cost_per_order"
      expr: AVG(CAST(transport_cost_usd AS DOUBLE))
      comment: "Average transport cost per distribution order. Benchmarks logistics efficiency."
    - name: "transport_cost_per_kg"
      expr: ROUND(SUM(CAST(transport_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0), 4)
      comment: "Transport cost per kilogram of commodity distributed. A key humanitarian logistics efficiency ratio."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END)
      comment: "Number of emergency distribution orders. Tracks crisis response operational load."
    - name: "emergency_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution orders that are emergency responses. High rates indicate sustained crisis operations."
    - name: "distinct_project_sites_served"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites receiving distributions. Measures geographic programme reach."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and financial KPIs: tracks receipt volumes, discrepancy rates, rejection rates, and total cost. Informs vendor performance management and supply chain quality control."
  source: "`vibe_ngo_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (pending inspection, accepted, rejected, partial)."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for received goods."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a quantity or quality discrepancy was recorded on receipt."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', goods_receipt_date)
      comment: "Month goods were received, for trend and seasonality analysis."
    - name: "customs_cleared"
      expr: customs_cleared
      comment: "Whether customs clearance has been completed, relevant for import compliance tracking."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the receipt is visible to donors for reporting purposes."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts processed. Baseline supply chain throughput KPI."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all goods receipts."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity actually received. Compared against ordered to compute fill rate."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected on quality grounds. High values indicate vendor quality issues."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received. A core vendor delivery performance KPI."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_rejected AS DOUBLE)) / NULLIF(SUM(CAST(quantity_received AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected on quality inspection. Drives vendor performance management."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received. Core financial accountability measure for procurement."
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges incurred on goods receipts. Monitors inbound logistics costs."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods. Used for price benchmarking and variance analysis."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts with a recorded discrepancy. Key supply chain quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and valuation KPIs: tracks stock levels, availability, quarantine rates, and total valuation by warehouse and commodity. Essential for supply planning and donor accountability."
  source: "`vibe_ngo_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Pipeline status of the inventory (in-pipeline, available, depleted) for supply planning."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition requirements (ambient, cold chain, hazmat) for warehouse planning."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Whether the stock is donor-restricted, impacting allocation flexibility."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether the inventory originated from an in-kind donation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the inventory is held, for geographic stock analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the inventory valuation."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the inventory snapshot, for trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the commodity, enabling like-for-like comparisons."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of stock physically on hand. Primary inventory availability KPI."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for allocation (on hand minus reserved and quarantined)."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for planned distributions. Indicates committed pipeline."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity held in quarantine. High values signal quality or compliance issues."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or to distribution points."
    - name: "total_inventory_valuation"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total financial value of inventory on hand. Core asset and donor accountability KPI."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory. Used for valuation benchmarking and cost variance analysis."
    - name: "quarantine_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_quarantined AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock in quarantine. A key supply quality and risk KPI."
    - name: "stock_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_available AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock that is available for distribution. Measures effective stock utilisation."
    - name: "distinct_warehouses_with_stock"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of distinct warehouses holding stock. Measures geographic stock distribution."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics and shipment performance KPIs: tracks freight costs, delivery timeliness, cold chain usage, and customs clearance. Informs logistics strategy and carrier performance management."
  source: "`vibe_ngo_v1`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (in transit, delivered, delayed, cancelled)."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (import, export, internal transfer) for logistics categorisation."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, sea, road, rail) for cost and speed analysis."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the shipment requires temperature-controlled logistics (cold chain)."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status, relevant for import compliance and delay analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of shipment origin for trade flow analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of shipment destination for geographic reach analysis."
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', actual_departure_date)
      comment: "Month of actual departure for shipment trend analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline logistics throughput KPI."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost across all shipments in USD. Core logistics spend KPI."
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarks carrier pricing and route efficiency."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(total_cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight shipped in kilograms. Used for logistics capacity and cost-per-kg analysis."
    - name: "total_cargo_volume_m3"
      expr: SUM(CAST(total_cargo_volume_m3 AS DOUBLE))
      comment: "Total cargo volume shipped in cubic metres. Key for container and transport capacity planning."
    - name: "total_insured_value_usd"
      expr: SUM(CAST(insured_value_usd AS DOUBLE))
      comment: "Total insured value of shipments. Monitors insurance coverage adequacy relative to cargo value."
    - name: "freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_cargo_weight_kg AS DOUBLE)), 0), 4)
      comment: "Freight cost per kilogram of cargo. A standard logistics efficiency benchmark."
    - name: "cold_chain_shipment_count"
      expr: COUNT(CASE WHEN temperature_controlled = TRUE THEN 1 END)
      comment: "Number of shipments requiring cold chain logistics. Informs cold chain capacity planning."
    - name: "cold_chain_shipment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_controlled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments requiring cold chain. Drives cold chain investment decisions."
    - name: "distinct_origin_countries"
      expr: COUNT(DISTINCT origin_country_code)
      comment: "Number of distinct countries of origin. Measures supply source diversification."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement KPIs tracking commodity flows, costs, and quality inspection outcomes. Enables warehouse managers and supply chain directors to monitor inventory dynamics and loss rates."
  source: "`vibe_ngo_v1`.`supply`.`stock_movement`"
  dimensions:
    - name: "stock_movement_type"
      expr: stock_movement_type
      comment: "Type of stock movement (receipt, issue, transfer, adjustment, loss) for flow categorisation."
    - name: "stock_movement_status"
      expr: stock_movement_status
      comment: "Current status of the stock movement record."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the stock movement, enabling root cause analysis of adjustments and losses."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the moved stock."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether the movement involves in-kind donated commodities."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the stock movement."
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', stock_movement_date)
      comment: "Month of the stock movement for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the stock movement valuation."
  measures:
    - name: "total_stock_movements"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Baseline warehouse activity KPI."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of commodities moved across all transactions. Measures warehouse throughput."
    - name: "total_movement_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of stock movements. Core financial accountability for inventory transactions."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of commodities moved. Used for cost variance and pricing analysis."
    - name: "loss_adjustment_count"
      expr: COUNT(CASE WHEN reason_code IN ('loss', 'damage', 'expiry', 'theft') THEN 1 END)
      comment: "Number of stock movements attributed to losses, damage, expiry, or theft. Drives loss reduction initiatives."
    - name: "distinct_commodities_moved"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities involved in stock movements. Measures portfolio breadth of warehouse activity."
    - name: "distinct_source_warehouses"
      expr: COUNT(DISTINCT source_warehouse_id)
      comment: "Number of distinct source warehouses involved in movements. Monitors inter-warehouse transfer activity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor registry and performance KPIs: tracks vendor prequalification status, performance scores, blacklist rates, and geographic diversity. Informs vendor management and procurement risk decisions."
  source: "`vibe_ngo_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (active, suspended, blacklisted, pending)."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (supplier, transporter, service provider) for category analysis."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Vendor prequalification status, indicating eligibility for procurement."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification (gold, silver, bronze) for vendor segmentation."
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Country where the vendor operates, for geographic sourcing analysis."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Whether the vendor is currently blacklisted, critical for compliance screening."
    - name: "gmp_certification_flag"
      expr: gmp_certification_flag
      comment: "Whether the vendor holds Good Manufacturing Practice certification, relevant for medical/pharmaceutical procurement."
  measures:
    - name: "total_vendors"
      expr: COUNT(1)
      comment: "Total number of vendors in the registry. Baseline vendor pool size KPI."
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'active' THEN 1 END)
      comment: "Number of currently active vendors. Measures available procurement market size."
    - name: "prequalified_vendor_count"
      expr: COUNT(CASE WHEN prequalification_status = 'approved' THEN 1 END)
      comment: "Number of prequalified vendors eligible for procurement. Key procurement readiness KPI."
    - name: "prequalification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prequalification_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors that are prequalified. Measures vendor registry quality."
    - name: "blacklisted_vendor_count"
      expr: COUNT(CASE WHEN blacklist_flag = TRUE THEN 1 END)
      comment: "Number of blacklisted vendors. Monitors compliance and sanctions risk in the vendor pool."
    - name: "blacklist_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blacklist_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors that are blacklisted. A key procurement compliance risk indicator."
    - name: "avg_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average vendor performance score. Drives vendor tiering and contract renewal decisions."
    - name: "avg_warehouse_capacity_sqm"
      expr: AVG(CAST(warehouse_capacity_sqm AS DOUBLE))
      comment: "Average warehouse capacity of vendors in square metres. Informs vendor selection for large-volume procurement."
    - name: "distinct_operating_countries"
      expr: COUNT(DISTINCT country_of_operation)
      comment: "Number of distinct countries where vendors operate. Measures geographic sourcing diversification."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse network capacity and operational KPIs: tracks storage capacity, temperature-controlled facilities, and geographic coverage. Informs warehouse network planning and investment decisions."
  source: "`vibe_ngo_v1`.`supply`.`warehouse`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse (active, inactive, decommissioned)."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (owned, rented, partner, field store) for asset management."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the warehouse for cost and asset classification."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the warehouse has temperature-controlled storage capability."
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Whether the warehouse is certified for hazardous materials storage."
    - name: "customs_bonded"
      expr: customs_bonded
      comment: "Whether the warehouse is customs-bonded, relevant for import/export operations."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located, for geographic network analysis."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the warehouse, relevant for high-value or sensitive commodity storage."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouses in the network. Baseline network size KPI."
    - name: "active_warehouse_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of currently active warehouses. Measures operational network capacity."
    - name: "total_storage_capacity_m3"
      expr: SUM(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Total storage capacity across all warehouses in cubic metres. Core network capacity planning KPI."
    - name: "avg_storage_capacity_m3"
      expr: AVG(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Average storage capacity per warehouse. Used for facility benchmarking and investment planning."
    - name: "cold_chain_warehouse_count"
      expr: COUNT(CASE WHEN temperature_controlled = TRUE THEN 1 END)
      comment: "Number of warehouses with temperature-controlled storage. Informs cold chain network adequacy."
    - name: "cold_chain_capacity_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_controlled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warehouses with cold chain capability. Drives cold chain investment decisions."
    - name: "hazmat_certified_count"
      expr: COUNT(CASE WHEN hazmat_certified = TRUE THEN 1 END)
      comment: "Number of warehouses certified for hazardous materials. Ensures adequate hazmat storage capacity."
    - name: "distinct_countries_covered"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with warehouse presence. Measures geographic network coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement utilisation and performance KPIs: tracks agreement values, utilisation rates, vendor performance, and renewal patterns. Informs strategic sourcing and long-term vendor relationship management."
  source: "`vibe_ngo_v1`.`supply`.`framework_agreement`"
  dimensions:
    - name: "framework_agreement_status"
      expr: framework_agreement_status
      comment: "Current status of the framework agreement (active, expired, terminated, pending renewal)."
    - name: "framework_agreement_type"
      expr: framework_agreement_type
      comment: "Type of framework agreement (long-term, emergency, category-specific) for strategic sourcing analysis."
    - name: "call_off_mechanism"
      expr: call_off_mechanism
      comment: "Mechanism for calling off orders under the framework (mini-competition, direct call-off)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the framework agreement for multi-currency analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the framework agreement is visible to donors for reporting."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the framework agreement became effective, for cohort and vintage analysis."
  measures:
    - name: "total_framework_agreements"
      expr: COUNT(1)
      comment: "Total number of framework agreements. Baseline strategic sourcing portfolio KPI."
    - name: "total_value_utilized"
      expr: SUM(CAST(total_value_utilized AS DOUBLE))
      comment: "Total value utilised across all framework agreements. Measures strategic sourcing spend channelled through frameworks."
    - name: "total_maximum_order_value"
      expr: SUM(CAST(maximum_order_value AS DOUBLE))
      comment: "Total maximum order value ceiling across framework agreements. Measures total contracted procurement capacity."
    - name: "avg_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_value_utilized AS DOUBLE)) / NULLIF(SUM(CAST(maximum_order_value AS DOUBLE)), 0), 2)
      comment: "Average utilisation of framework agreement value ceilings. Low rates indicate underused strategic contracts."
    - name: "avg_performance_rating"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across framework agreements. Measures procurement value-for-money."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN framework_agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active framework agreements. Measures live strategic sourcing coverage."
    - name: "distinct_vendors_under_framework"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors covered by framework agreements. Measures strategic vendor portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inkind_donation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-kind donation receipt and valuation KPIs: tracks donation volumes, fair market values, quality inspection outcomes, and donor restriction compliance. Core for donor accountability and resource mobilisation reporting."
  source: "`vibe_ngo_v1`.`supply`.`inkind_donation`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of donor acknowledgment for the in-kind donation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Whether the donated commodity has been allocated to a programme."
    - name: "condition_status"
      expr: condition_status
      comment: "Physical condition of the donated goods on receipt."
    - name: "donor_type"
      expr: donor_type
      comment: "Type of donor (corporate, government, individual, multilateral) for resource mobilisation analysis."
    - name: "restricted_use_flag"
      expr: restricted_use_flag
      comment: "Whether the donation has restricted use conditions, impacting allocation flexibility."
    - name: "quality_inspection_flag"
      expr: quality_inspection_flag
      comment: "Whether a quality inspection was conducted on the donated goods."
    - name: "valuation_currency_code"
      expr: valuation_currency_code
      comment: "Currency used for the fair market valuation of the donation."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month the in-kind donation was received, for trend analysis."
    - name: "iati_reporting_flag"
      expr: iati_reporting_flag
      comment: "Whether the donation is subject to IATI transparency reporting."
  measures:
    - name: "total_inkind_donations"
      expr: COUNT(1)
      comment: "Total number of in-kind donations received. Baseline resource mobilisation KPI."
    - name: "total_fair_market_value"
      expr: SUM(CAST(estimated_fair_market_value AS DOUBLE))
      comment: "Total estimated fair market value of in-kind donations. Core donor accountability and resource mobilisation KPI."
    - name: "avg_fair_market_value"
      expr: AVG(CAST(estimated_fair_market_value AS DOUBLE))
      comment: "Average fair market value per in-kind donation. Benchmarks donation size and donor generosity."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of in-kind donated commodities received."
    - name: "restricted_donation_count"
      expr: COUNT(CASE WHEN restricted_use_flag = TRUE THEN 1 END)
      comment: "Number of donations with restricted use conditions. High counts reduce allocation flexibility."
    - name: "restricted_donation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restricted_use_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of in-kind donations with use restrictions. Informs programme flexibility and donor negotiation strategy."
    - name: "quality_inspected_count"
      expr: COUNT(CASE WHEN quality_inspection_flag = TRUE THEN 1 END)
      comment: "Number of donations that underwent quality inspection. Measures quality assurance coverage."
    - name: "distinct_donor_types"
      expr: COUNT(DISTINCT donor_type)
      comment: "Number of distinct donor types contributing in-kind donations. Measures donor base diversification."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) process KPIs: tracks bid competition, award values, and procurement method compliance. Enables procurement leadership to assess market engagement and competitive procurement health."
  source: "`vibe_ngo_v1`.`supply`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (draft, published, closed, awarded, cancelled)."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (open tender, restricted, direct) for compliance analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Type of procurement (goods, services, works) for spend categorisation."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the RFQ for category management analysis."
    - name: "emergency_procurement"
      expr: emergency_procurement
      comment: "Whether the RFQ was issued as an emergency procurement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RFQ budget and award amounts."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued, for procurement pipeline trend analysis."
  measures:
    - name: "total_rfqs_issued"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline procurement market engagement KPI."
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all RFQs. Measures procurement pipeline value."
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQs. Measures actual procurement spend committed through competitive process."
    - name: "avg_bids_received_per_rfq"
      expr: AVG(CAST(received_bid_count AS DOUBLE))
      comment: "Average number of bids received per RFQ. A key market competition health indicator — low averages signal poor market engagement."
    - name: "avg_responsive_bids_per_rfq"
      expr: AVG(CAST(responsive_bid_count AS DOUBLE))
      comment: "Average number of responsive bids per RFQ. Measures quality of market response to procurement requirements."
    - name: "budget_to_award_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(awarded_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_budget_amount AS DOUBLE)), 0), 2)
      comment: "Awarded amount as a percentage of estimated budget. Measures procurement value-for-money and budget accuracy."
    - name: "emergency_rfq_count"
      expr: COUNT(CASE WHEN emergency_procurement = TRUE THEN 1 END)
      comment: "Number of emergency RFQs issued. High counts indicate reactive procurement and potential value-for-money risk."
    - name: "emergency_rfq_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_procurement = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs issued as emergency procurements. A key procurement planning quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_waybill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waybill and last-mile delivery KPIs: tracks dispatch vs. receipt discrepancies, transport costs, cold chain compliance, and delivery completion. Informs last-mile logistics quality and accountability."
  source: "`vibe_ngo_v1`.`supply`.`waybill`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the waybill shipment (in transit, delivered, discrepancy reported)."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment covered by the waybill."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the waybill delivery."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the waybill covers temperature-controlled cargo."
    - name: "receipt_signature_captured_flag"
      expr: receipt_signature_captured_flag
      comment: "Whether a delivery receipt signature was captured, indicating confirmed delivery."
    - name: "customs_clearance_required_flag"
      expr: customs_clearance_required_flag
      comment: "Whether customs clearance is required for the waybill shipment."
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', dispatch_date)
      comment: "Month of dispatch for trend analysis."
  measures:
    - name: "total_waybills"
      expr: COUNT(1)
      comment: "Total number of waybills issued. Baseline last-mile delivery throughput KPI."
    - name: "total_dispatched_quantity"
      expr: SUM(CAST(total_dispatched_quantity AS DOUBLE))
      comment: "Total quantity dispatched across all waybills."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_received_quantity AS DOUBLE))
      comment: "Total quantity confirmed received at destination."
    - name: "total_discrepancy_quantity"
      expr: SUM(CAST(discrepancy_quantity AS DOUBLE))
      comment: "Total quantity discrepancy between dispatched and received. Measures last-mile loss and accountability gaps."
    - name: "delivery_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_dispatched_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of dispatched quantity confirmed received. Core last-mile delivery accountability KPI."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discrepancy_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_dispatched_quantity AS DOUBLE)), 0), 2)
      comment: "Discrepancy quantity as a percentage of dispatched quantity. Measures last-mile loss rate."
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost across all waybills. Monitors last-mile logistics spend."
    - name: "avg_transport_cost_per_waybill"
      expr: AVG(CAST(transport_cost_amount AS DOUBLE))
      comment: "Average transport cost per waybill. Benchmarks last-mile delivery cost efficiency."
    - name: "signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN receipt_signature_captured_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with a captured receipt signature. Measures delivery accountability and documentation compliance."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average delivery distance in kilometres. Used for route optimisation and cost-per-km analysis."
$$;