-- Metric views for domain: supply | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic inventory health metrics tracking stock availability, utilisation, and valuation across warehouses and commodities. Enables supply chain managers and executives to monitor pipeline adequacy, identify stock-out risk, and optimise pre-positioning of humanitarian supplies."
  source: "`vibe_ngo_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse identifier — primary grouping axis for geographic stock analysis."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity identifier — enables per-item stock health analysis."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the warehouse location — supports country-level pipeline reporting."
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Current pipeline status of the stock (e.g. In Pipeline, Confirmed, At Risk) — critical for supply planning."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition category (e.g. Ambient, Cold Chain) — relevant for cold-chain compliance monitoring."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Indicates whether stock is donor-restricted — affects allocation flexibility."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether stock originated from an in-kind donation — important for donor reporting."
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the inventory snapshot — enables trend analysis over time."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiry date of the batch — used to identify near-expiry stock requiring urgent distribution."
    - name: "award_id"
      expr: award_id
      comment: "Grant award identifier — enables stock tracking by funding source."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention identifier — links stock to specific humanitarian response activities."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across all selected warehouses and commodities. Core pipeline adequacy KPI used in supply reviews and donor reporting."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for allocation (on-hand minus reserved and quarantined). Directly drives distribution planning decisions."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for planned distributions. High reservation rates signal upcoming dispatch activity."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity held in quarantine pending quality clearance. Elevated quarantine levels indicate quality or compliance risk."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or to distribution points. Key for pipeline visibility."
    - name: "total_stock_valuation_usd"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total monetary value of inventory on hand. Used by finance and donors to assess asset exposure and pipeline investment."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory records. Benchmarks procurement efficiency and informs budget forecasting."
    - name: "stock_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_reserved AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock that is reserved for distribution. High utilisation indicates strong demand alignment; very low rates may signal over-stocking or planning gaps."
    - name: "quarantine_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_quarantined AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock in quarantine. A rising quarantine rate signals quality or supplier issues requiring immediate investigation."
    - name: "stock_below_reorder_level_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_level AND reorder_level > 0 THEN 1 END)
      comment: "Number of inventory records where on-hand quantity has fallen below the reorder threshold. Directly triggers procurement action to prevent stock-outs."
    - name: "stock_above_maximum_count"
      expr: COUNT(CASE WHEN quantity_on_hand > maximum_stock_level AND maximum_stock_level > 0 THEN 1 END)
      comment: "Number of inventory records where stock exceeds the maximum level. Indicates over-stocking risk, potential wastage, and tied-up capital."
    - name: "distinct_commodities_in_stock"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities with active inventory balances. Measures breadth of supply pipeline coverage."
    - name: "distinct_warehouses_with_stock"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of distinct warehouses holding stock. Indicates geographic distribution of the supply pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement performance metrics covering order volume, spend, lead times, and process compliance. Enables procurement managers and finance teams to monitor purchasing efficiency, vendor performance, and budget utilisation."
  source: "`vibe_ngo_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g. Draft, Approved, Received, Cancelled) — primary lifecycle dimension."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Emergency, Framework) — differentiates procurement modalities."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. Open Tender, Direct Procurement, Framework Agreement) — critical for compliance reporting."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodities being procured — enables spend analysis by supply category."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency spend analysis."
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Indicates whether the PO was raised under emergency procurement procedures — key for compliance and cost analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — enables vendor-level spend and performance analysis."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office that raised the PO — supports geographic spend analysis."
    - name: "fund_id"
      expr: fund_id
      comment: "Donor fund identifier — links procurement spend to funding sources."
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Current approval workflow status — identifies bottlenecks in the procurement approval process."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt status on the PO — tracks fulfilment completion."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm governing delivery responsibility — affects total landed cost analysis."
    - name: "po_date"
      expr: po_date
      comment: "Date the purchase order was raised — primary time dimension for trend analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention identifier — links procurement to specific humanitarian activities."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement workload and throughput analysis."
    - name: "total_procurement_spend_usd"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all purchase orders. Primary spend KPI used in budget utilisation and donor financial reporting."
    - name: "total_freight_spend_usd"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across purchase orders. Logistics cost component used to assess transport efficiency and total landed cost."
    - name: "total_tax_amount_usd"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges on purchase orders. Relevant for VAT recovery analysis and country-level cost benchmarking."
    - name: "avg_po_value_usd"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order. Benchmarks procurement scale and identifies outlier orders requiring review."
    - name: "emergency_po_count"
      expr: COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END)
      comment: "Number of purchase orders raised under emergency procedures. High emergency PO rates indicate procurement planning gaps and typically carry cost premiums."
    - name: "emergency_po_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs raised as emergency procurements. A key compliance and efficiency KPI — high rates signal reactive rather than planned procurement."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(DATEDIFF(actual_delivery_date, po_date))
      comment: "Average number of days from PO creation to actual delivery. Core procurement lead-time KPI used to assess vendor and logistics performance."
    - name: "delivery_delay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND expected_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of POs where actual delivery exceeded the expected delivery date. Measures vendor and logistics reliability — directly impacts distribution planning."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_workflow_status NOT IN ('Approved', 'Completed', 'Cancelled') THEN 1 END)
      comment: "Number of POs currently awaiting approval. Identifies bottlenecks in the procurement approval pipeline that delay supply delivery."
    - name: "distinct_vendors_used"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors engaged. Measures vendor base diversity — low counts may indicate single-source dependency risk."
    - name: "freight_as_pct_of_total_spend"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Freight costs as a percentage of total procurement spend. High freight ratios indicate logistics inefficiency or remote delivery challenges."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and fulfilment metrics tracking quantity accuracy, rejection rates, inspection compliance, and cost at point of delivery. Enables supply chain and quality teams to monitor vendor delivery performance and identify systemic quality issues."
  source: "`vibe_ngo_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (e.g. Pending, Accepted, Rejected, Partial) — primary lifecycle dimension."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity received — enables quality analysis by item type."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor who supplied the goods — core dimension for vendor performance scorecarding."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Receiving warehouse — enables location-level receipt analysis."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a quantity or quality discrepancy was recorded at receipt — key quality signal."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Outcome of the quality inspection (e.g. Passed, Failed, Pending) — drives quality compliance reporting."
    - name: "condition_on_arrival"
      expr: condition_on_arrival
      comment: "Physical condition of goods on arrival (e.g. Good, Damaged, Partial) — informs claims and vendor accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt transaction — required for multi-currency cost analysis."
    - name: "goods_receipt_date"
      expr: goods_receipt_date
      comment: "Date goods were received — primary time dimension for receipt trend analysis."
    - name: "customs_cleared"
      expr: customs_cleared
      comment: "Whether customs clearance was completed — relevant for import compliance monitoring."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention linked to this receipt — connects supply delivery to programmatic outcomes."
  measures:
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all receipts. Baseline for fulfilment rate calculation."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity actually received. Core supply delivery KPI."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected at receipt due to quality or condition failures. Elevated rejection volumes signal vendor quality issues."
    - name: "fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully received. Primary vendor delivery performance KPI — shortfalls directly impact distribution capacity."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_rejected AS DOUBLE)) / NULLIF(SUM(CAST(quantity_received AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected due to quality failures. A rising rejection rate triggers vendor review and may indicate systemic supply quality risk."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts with recorded discrepancies. High discrepancy rates indicate documentation, logistics, or vendor reliability issues."
    - name: "total_receipt_cost_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received. Used for budget tracking and donor financial reporting."
    - name: "total_freight_charges_usd"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges incurred at receipt. Contributes to total landed cost analysis."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost at receipt. Benchmarks procurement pricing and identifies cost anomalies by vendor or commodity."
    - name: "inspection_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_status IS NOT NULL AND inspection_status != 'Pending' THEN 1 END) / NULLIF(COUNT(CASE WHEN inspection_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of receipts requiring inspection that have a completed inspection outcome. Measures quality control process compliance."
    - name: "distinct_vendors_delivering"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with goods receipts in the period. Measures active supplier base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile distribution performance metrics tracking order volumes, delivery timeliness, beneficiary reach, and transport costs. Enables programme and logistics managers to monitor distribution effectiveness and identify operational bottlenecks."
  source: "`vibe_ngo_v1`.`supply`.`distribution_order`"
  dimensions:
    - name: "distribution_order_status"
      expr: distribution_order_status
      comment: "Current status of the distribution order (e.g. Planned, Dispatched, Delivered, Cancelled) — primary lifecycle dimension."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. General Food Distribution, Targeted, Emergency) — key programmatic segmentation."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used (e.g. Road, Air, River) — enables logistics cost and efficiency analysis by modality."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the distribution order — used to track emergency vs. routine distribution performance."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Indicates whether the order is part of an emergency response — critical for emergency operations reporting."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office responsible for the distribution — enables geographic performance comparison."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Implementing partner organisation — enables partner performance analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention — links distribution activity to programmatic outcomes."
    - name: "fund_id"
      expr: fund_id
      comment: "Donor fund — enables distribution cost tracking by funding source."
    - name: "distribution_order_date"
      expr: distribution_order_date
      comment: "Date the distribution order was created — primary time dimension for trend analysis."
    - name: "nfi_flag"
      expr: nfi_flag
      comment: "Indicates whether the order contains Non-Food Items — enables NFI vs. food distribution analysis."
    - name: "medical_supplies_flag"
      expr: medical_supplies_flag
      comment: "Indicates whether the order contains medical supplies — enables health supply chain analysis."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the distribution involves in-kind donated commodities — relevant for donor reporting."
  measures:
    - name: "total_distribution_orders"
      expr: COUNT(1)
      comment: "Total number of distribution orders. Baseline throughput metric for distribution operations."
    - name: "total_estimated_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of commodities distributed. Primary financial KPI for programme spend and donor accountability."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport costs incurred for distribution. Key logistics efficiency metric — high transport costs relative to commodity value indicate operational inefficiency."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of commodities dispatched across all distribution orders. Core programme output metric."
    - name: "total_weight_distributed_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of commodities distributed in kilograms. Used for logistics capacity planning and transport cost benchmarking."
    - name: "total_volume_distributed_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of commodities distributed in cubic metres. Drives warehouse and transport capacity planning."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND scheduled_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of distribution orders delivered on or before the scheduled date. Primary last-mile reliability KPI — directly impacts beneficiary access to assistance."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(DATEDIFF(actual_delivery_date, distribution_order_date))
      comment: "Average days from order creation to actual delivery. Measures end-to-end distribution cycle time — a key operational efficiency indicator."
    - name: "transport_cost_per_unit_usd"
      expr: ROUND(SUM(CAST(transport_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_quantity AS DOUBLE)), 0), 4)
      comment: "Transport cost per unit of commodity distributed. Benchmarks logistics efficiency across corridors, modalities, and partners."
    - name: "emergency_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution orders classified as emergency response. High rates indicate reactive operations and may signal planning or pipeline gaps."
    - name: "cancelled_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN distribution_order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution orders that were cancelled. Elevated cancellation rates indicate planning failures, security constraints, or access issues."
    - name: "distinct_partners_distributing"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct implementing partners executing distributions. Measures partner network breadth and dependency concentration."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement velocity and quality metrics tracking commodity flows, loss rates, and transport efficiency. Enables supply chain managers to monitor stock turnover, identify losses, and assess logistics performance across the supply network."
  source: "`vibe_ngo_v1`.`supply`.`stock_movement`"
  dimensions:
    - name: "stock_movement_type"
      expr: stock_movement_type
      comment: "Type of stock movement (e.g. Receipt, Issue, Transfer, Adjustment, Loss) — primary classification for flow analysis."
    - name: "stock_movement_status"
      expr: stock_movement_status
      comment: "Current status of the movement record — identifies pending or disputed movements."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity being moved — enables per-item flow and loss analysis."
    - name: "source_warehouse_id"
      expr: source_warehouse_id
      comment: "Origin warehouse — enables corridor-level flow analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the movement — enables cost and efficiency analysis by modality."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement (e.g. Distribution, Transfer, Damage, Expiry) — critical for loss categorisation."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the movement — tracks compliance with quality standards."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the movement involves in-kind donated stock — relevant for donor accountability."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organisation associated with the movement — enables partner-level accountability."
    - name: "award_id"
      expr: award_id
      comment: "Grant award linked to the movement — enables fund-level stock flow tracking."
    - name: "stock_movement_date"
      expr: stock_movement_date
      comment: "Date of the stock movement — primary time dimension for velocity and trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement valuation — required for multi-currency cost analysis."
  measures:
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of commodities moved across all movement types. Baseline throughput metric for supply chain velocity."
    - name: "total_movement_value_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of stock movements. Used for financial reconciliation and donor asset accountability reporting."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock movements. Benchmarks commodity pricing consistency across the supply chain."
    - name: "loss_quantity"
      expr: SUM(CASE WHEN stock_movement_type IN ('Loss', 'Damage', 'Expiry', 'Write-off') THEN quantity ELSE 0 END)
      comment: "Total quantity lost through damage, expiry, or write-off. A critical accountability metric — high losses trigger investigation and corrective action."
    - name: "loss_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN stock_movement_type IN ('Loss', 'Damage', 'Expiry', 'Write-off') THEN quantity ELSE 0 END) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total stock moved that was lost, damaged, or written off. Key supply chain quality KPI — high loss rates directly reduce programme impact and donor confidence."
    - name: "distinct_commodities_moved"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities with stock movements in the period. Measures supply chain breadth and activity coverage."
    - name: "distinct_movement_corridors"
      expr: COUNT(DISTINCT source_warehouse_id)
      comment: "Number of distinct origin warehouses with outbound movements. Indicates geographic distribution network activity."
    - name: "avg_quantity_per_movement"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per stock movement transaction. Benchmarks movement batch sizes — very small averages may indicate inefficient dispatch practices."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_waybill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment tracking and transport performance metrics covering delivery accuracy, discrepancy rates, and transport costs. Enables logistics managers to monitor carrier performance, route efficiency, and last-mile delivery reliability."
  source: "`vibe_ngo_v1`.`supply`.`waybill`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. In Transit, Delivered, Delayed, Cancelled) — primary lifecycle dimension."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g. Internal Transfer, Last Mile, Cross-border) — enables analysis by logistics modality."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the shipment — used to track emergency vs. routine delivery performance."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Transport vendor/carrier — enables carrier performance scorecarding."
    - name: "origin_warehouse_id"
      expr: origin_warehouse_id
      comment: "Origin warehouse — enables corridor-level performance analysis."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office responsible for the shipment — supports geographic performance comparison."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the shipment required temperature-controlled transport — relevant for cold-chain compliance."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the shipment contains hazardous materials — relevant for compliance and risk reporting."
    - name: "customs_clearance_required_flag"
      expr: customs_clearance_required_flag
      comment: "Indicates whether customs clearance was required — relevant for cross-border shipment analysis."
    - name: "dispatch_date"
      expr: dispatch_date
      comment: "Date the shipment was dispatched — primary time dimension for trend analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention linked to the shipment — connects logistics activity to programmatic outcomes."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of waybills/shipments. Baseline logistics throughput metric."
    - name: "total_dispatched_quantity"
      expr: SUM(CAST(total_dispatched_quantity AS DOUBLE))
      comment: "Total quantity dispatched across all shipments. Core supply delivery output metric."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_received_quantity AS DOUBLE))
      comment: "Total quantity confirmed received at destination. Used to calculate in-transit losses."
    - name: "total_discrepancy_quantity"
      expr: SUM(CAST(discrepancy_quantity AS DOUBLE))
      comment: "Total quantity discrepancy between dispatched and received. Elevated discrepancies indicate theft, damage, or documentation failures."
    - name: "shipment_discrepancy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discrepancy_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_dispatched_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of dispatched quantity with recorded discrepancies at receipt. Key accountability KPI — high rates trigger investigation and may indicate diversion risk."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost across all shipments. Primary logistics spend KPI used in cost-efficiency analysis."
    - name: "transport_cost_per_km_usd"
      expr: ROUND(SUM(CAST(transport_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(distance_km AS DOUBLE)), 0), 4)
      comment: "Transport cost per kilometre. Benchmarks route and carrier efficiency — high cost-per-km may indicate inefficient routing or premium carrier use."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND estimated_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of shipments delivered on or before the estimated delivery date. Primary carrier reliability KPI."
    - name: "avg_transit_time_days"
      expr: AVG(DATEDIFF(actual_delivery_date, dispatch_date))
      comment: "Average transit time in days from dispatch to delivery. Benchmarks route and corridor efficiency."
    - name: "receipt_signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN receipt_signature_captured_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with a captured delivery signature. Measures last-mile accountability compliance — low rates indicate documentation gaps that expose the organisation to audit risk."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct transport vendors used. Measures carrier base diversity and single-source dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor registry and performance metrics tracking supplier qualification status, performance scores, and risk flags. Enables procurement and compliance teams to manage vendor risk, monitor prequalification currency, and maintain a high-quality supplier base."
  source: "`vibe_ngo_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g. Active, Suspended, Blacklisted, Inactive) — primary risk classification."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g. Supplier, Transporter, Service Provider) — enables category-level analysis."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Vendor prequalification status — critical for procurement compliance; only prequalified vendors should receive contracts."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification (e.g. Preferred, Standard, Probation) — used for vendor stratification and contract allocation."
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Country where the vendor operates — enables geographic vendor base analysis."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Indicates whether the vendor is blacklisted — critical compliance and risk flag."
    - name: "gmp_certification_flag"
      expr: gmp_certification_flag
      comment: "Indicates whether the vendor holds Good Manufacturing Practice certification — relevant for pharmaceutical and food supply procurement."
    - name: "commodity_categories"
      expr: commodity_categories
      comment: "Commodity categories the vendor supplies — enables supply category coverage analysis."
  measures:
    - name: "total_active_vendors"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of currently active vendors. Baseline metric for supplier base size and procurement capacity."
    - name: "blacklisted_vendor_count"
      expr: COUNT(CASE WHEN blacklist_flag = TRUE THEN 1 END)
      comment: "Number of blacklisted vendors. A compliance KPI — any procurement from blacklisted vendors represents a critical control failure."
    - name: "prequalification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active vendors with current approved prequalification. Measures procurement compliance — low rates indicate risk of contracting with unvetted suppliers."
    - name: "avg_vendor_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average vendor performance score across the supplier base. Tracks overall supply base quality — declining scores trigger vendor development or replacement actions."
    - name: "high_performing_vendor_count"
      expr: COUNT(CASE WHEN performance_tier = 'Preferred' THEN 1 END)
      comment: "Number of vendors classified in the preferred/high-performance tier. Measures the depth of the high-quality supplier pool available for strategic procurement."
    - name: "prequalification_expiry_risk_count"
      expr: COUNT(CASE WHEN prequalification_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of approved vendors whose prequalification expires within 90 days. Proactive risk metric — enables timely renewal to avoid procurement disruption."
    - name: "distinct_countries_covered"
      expr: COUNT(DISTINCT country_of_operation)
      comment: "Number of distinct countries where active vendors operate. Measures geographic supply base coverage — critical for assessing procurement reach in field operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution planning metrics tracking plan coverage, budget adequacy, risk levels, and approval compliance. Enables programme managers and planners to assess planning quality, identify high-risk plans, and monitor budget alignment across distribution activities."
  source: "`vibe_ngo_v1`.`supply`.`distribution_plan`"
  dimensions:
    - name: "distribution_plan_status"
      expr: distribution_plan_status
      comment: "Current status of the distribution plan (e.g. Draft, Approved, Active, Completed, Cancelled) — primary lifecycle dimension."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. General Food Distribution, Targeted, Emergency) — key programmatic segmentation."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Distribution modality (e.g. In-Kind, Cash, Voucher) — critical for programme design and donor reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the plan (e.g. Low, Medium, High, Critical) — drives prioritisation and oversight intensity."
    - name: "geographic_coverage_country"
      expr: geographic_coverage_country
      comment: "Country of distribution — primary geographic dimension."
    - name: "beneficiary_category"
      expr: beneficiary_category
      comment: "Category of beneficiaries targeted (e.g. Refugees, IDPs, Host Community) — enables population-level analysis."
    - name: "coordination_cluster"
      expr: coordination_cluster
      comment: "Humanitarian coordination cluster (e.g. Food Security, Nutrition, NFI) — enables cluster-level planning analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the plan — links distribution planning to donor commitments."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office responsible for the plan — enables geographic performance comparison."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the distribution — primary time dimension for planning horizon analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the plan requires formal approval — relevant for governance compliance monitoring."
  measures:
    - name: "total_distribution_plans"
      expr: COUNT(1)
      comment: "Total number of distribution plans. Baseline planning activity metric."
    - name: "total_estimated_budget_usd"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all distribution plans. Primary financial planning KPI used in resource allocation and donor pipeline reporting."
    - name: "total_estimated_weight_kg"
      expr: SUM(CAST(estimated_total_weight_kg AS DOUBLE))
      comment: "Total estimated weight of commodities to be distributed. Drives logistics capacity planning and transport procurement."
    - name: "total_estimated_volume_m3"
      expr: SUM(CAST(estimated_total_volume_m3 AS DOUBLE))
      comment: "Total estimated volume of commodities to be distributed. Used for warehouse and transport capacity planning."
    - name: "high_risk_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution plans classified as high or critical risk. Elevated rates signal operational environment deterioration and require management escalation."
    - name: "plan_approval_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_required_flag = TRUE AND distribution_plan_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN approval_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of plans requiring approval that have been formally approved. Measures governance compliance — unapproved active plans represent a control risk."
    - name: "plan_execution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_start_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN distribution_plan_status = 'Approved' THEN 1 END), 0), 2)
      comment: "Percentage of approved plans that have commenced execution. Low execution rates indicate implementation bottlenecks or access constraints."
    - name: "avg_plan_duration_days"
      expr: AVG(DATEDIFF(planned_end_date, planned_start_date))
      comment: "Average planned duration of distribution plans in days. Benchmarks planning horizon and identifies unusually short or long distribution cycles."
    - name: "distinct_countries_covered"
      expr: COUNT(DISTINCT geographic_coverage_country)
      comment: "Number of distinct countries covered by distribution plans. Measures geographic programme reach."
$$;