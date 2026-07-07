-- Metric views for domain: supply | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement KPIs over purchase orders — tracks spend volume, emergency procurement share, and goods-receipt closure rate. Sourced from ICON/SAP procurement modules used by INGO supply chains."
  source: "`vibe_ngo_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (Draft, Approved, Closed, Cancelled) — used to filter active vs. closed spend."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (Standard, Emergency, Framework Call-Off) — key dimension for procurement-method analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement modality (competitive tender, sole source, framework) — required for donor compliance reporting."
    - name: "commodity_category"
      expr: commodity_category
      comment: "High-level commodity category (NFI, Medical, Food, WASH) — enables spend analysis by sector."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — needed for multi-currency spend aggregation."
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Boolean flag indicating whether the PO was raised under emergency procurement procedures — used to track emergency spend share."
    - name: "po_date_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month of PO issuance — enables trend analysis of procurement volumes over time."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against this PO (Pending, Partial, Complete) — used to track delivery closure."
    - name: "invoice_matching_status"
      expr: invoice_matching_status
      comment: "Three-way match status (Matched, Discrepancy, Pending) — critical for accounts-payable and audit readiness."
    - name: "vaccine_procurement_flag"
      expr: vaccine_procurement_flag
      comment: "Indicates whether the PO covers vaccine commodities — used to segregate cold-chain procurement reporting."
  measures:
    - name: "total_po_value_usd"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders in scope. Core KPI for budget utilisation and donor spend reporting."
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Number of purchase orders — baseline volume metric for procurement throughput analysis."
    - name: "avg_po_value_usd"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order — signals whether procurement is fragmented (many small POs) or consolidated."
    - name: "total_tax_amount_usd"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges across POs — relevant for VAT exemption tracking and donor cost-share calculations."
    - name: "total_freight_amount_usd"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs committed on purchase orders — used to monitor logistics cost as a share of total procurement spend."
    - name: "emergency_po_count"
      expr: COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END)
      comment: "Number of POs raised under emergency procurement — high values signal supply-chain stress or inadequate planning lead times."
    - name: "emergency_po_value_usd"
      expr: SUM(CASE WHEN emergency_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total spend on emergency purchase orders — emergency procurement typically carries higher unit costs and donor scrutiny."
    - name: "sole_source_po_count"
      expr: COUNT(CASE WHEN procurement_method = 'Sole Source' THEN 1 END)
      comment: "Number of sole-source POs — donor compliance frameworks (USAID, ECHO) require justification for sole-source awards above thresholds."
    - name: "vaccine_po_value_usd"
      expr: SUM(CASE WHEN vaccine_procurement_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total spend on vaccine procurement — tracked separately for GAVI co-financing reconciliation and EPI programme reporting."
    - name: "subtotal_amount_usd"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-freight subtotals — used to compute effective tax and freight rate percentages at the BI layer."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs — tracks quantity ordered vs. received, outstanding quantities, and unit pricing. Enables fill-rate and delivery-performance analysis at commodity level."
  source: "`vibe_ngo_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (Open, Partially Received, Closed, Cancelled)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the commodity on this line — required for quantity aggregation consistency."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery — used to analyse delivery schedule adherence over time."
  measures:
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered across all PO lines — baseline procurement volume metric."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total units confirmed received — compared against ordered quantity to compute fill rate."
    - name: "total_quantity_outstanding"
      expr: SUM(CAST(quantity_outstanding AS DOUBLE))
      comment: "Total units still outstanding (ordered but not yet received) — key pipeline visibility metric for supply planners."
    - name: "total_line_value_usd"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total committed value across all PO lines — used for spend analysis at commodity level."
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines — benchmarked against framework agreement prices to detect price variance."
    - name: "open_line_count"
      expr: COUNT(CASE WHEN line_status = 'Open' THEN 1 END)
      comment: "Number of open PO lines — high open-line counts signal delivery delays requiring expediting action."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and volume KPIs — tracks receipt volumes, rejection rates, cold-chain integrity, and discrepancy rates. Critical for supply quality assurance and donor asset accountability."
  source: "`vibe_ngo_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (Pending Inspection, Accepted, Rejected, Partial)."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Outcome of quality inspection (Pass, Fail, Pending) — used to track supplier quality performance."
    - name: "condition_on_arrival"
      expr: condition_on_arrival
      comment: "Physical condition of goods on arrival (Good, Damaged, Expired) — key dimension for claims and supplier accountability."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt — enables trend analysis of inbound supply volumes."
    - name: "cold_chain_intact_flag"
      expr: cold_chain_intact_flag
      comment: "Whether cold chain was maintained on arrival — critical for vaccine and pharmaceutical receipts."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates a quantity or quality discrepancy was recorded — used to track supplier reliability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt valuation — needed for multi-currency cost aggregation."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total units received across all goods receipts — primary inbound supply volume metric."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total units rejected at receipt — high rejection volumes signal supplier quality failures requiring corrective action."
    - name: "total_receipt_cost_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received — used for asset valuation, donor reporting, and budget utilisation tracking."
    - name: "total_freight_charges_usd"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges on receipts — used to compute logistics cost as a percentage of goods value."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost at receipt — benchmarked against PO unit price to detect invoice discrepancies."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with recorded discrepancies — used to compute supplier discrepancy rate at the BI layer."
    - name: "cold_chain_breach_count"
      expr: COUNT(CASE WHEN cold_chain_intact_flag = FALSE THEN 1 END)
      comment: "Number of receipts where cold chain was not intact on arrival — critical KPI for vaccine programme quality assurance."
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt records — denominator for discrepancy rate and rejection rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse inventory position KPIs — tracks stock levels, valuation, quarantine volumes, and pipeline status. Enables stock-out risk detection and donor asset accountability reporting."
  source: "`vibe_ngo_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Pipeline status of the inventory position (In Stock, In Transit, On Order) — used for supply pipeline visibility."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition requirement (Ambient, Cold Chain, Ultra Cold) — used to analyse cold-chain capacity utilisation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the commodity — required for quantity aggregation consistency."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Indicates stock is restricted to a specific donor programme — used for donor asset ring-fencing and compliance."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates stock originated from an in-kind donation — tracked separately for valuation and donor acknowledgement."
    - name: "snapshot_date_month"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of the inventory snapshot — enables month-end stock position trending."
    - name: "vvm_current_stage"
      expr: vvm_current_stage
      comment: "Current VVM (Vaccine Vial Monitor) stage of vaccine stock — used to prioritise distribution of heat-exposed stock."
    - name: "country_code"
      expr: country_code
      comment: "Country where the inventory is held — enables geographic stock distribution analysis."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across all inventory positions — primary stock availability metric."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for distribution (on hand minus reserved and quarantined) — used for distribution planning."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total stock held in quarantine pending quality clearance — high quarantine volumes signal supply quality issues."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total stock reserved against distribution orders — used to compute free stock available for new allocations."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total stock currently in transit — included in pipeline stock calculations for supply planning."
    - name: "total_inventory_valuation_usd"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total value of inventory on hand — used for balance sheet reporting, donor asset accountability, and insurance coverage."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory — used to detect cost variance across warehouses and procurement cycles."
    - name: "stock_below_reorder_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_level THEN 1 END)
      comment: "Number of inventory positions where stock on hand is below the reorder level — direct stock-out risk indicator requiring procurement action."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement transaction KPIs — tracks inbound, outbound, and adjustment volumes and values. Enables inventory turnover analysis, loss tracking, and donor commodity accountability."
  source: "`vibe_ngo_v1`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (Receipt, Issue, Transfer, Adjustment, Loss, Return) — primary dimension for movement analysis."
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the movement transaction (Pending, Confirmed, Reversed) — used to filter confirmed movements."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement (e.g. Expiry, Damage, Distribution, Transfer) — used for loss and wastage analysis."
    - name: "movement_date_month"
      expr: DATE_TRUNC('month', movement_date)
      comment: "Month of the stock movement — enables trend analysis of throughput and losses over time."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates the movement relates to in-kind donated commodities — tracked separately for donor acknowledgement."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the movement (Road, Air, Sea) — used for logistics cost and lead-time analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement valuation — needed for multi-currency cost aggregation."
  measures:
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units moved across all stock movement transactions — primary throughput metric for warehouse operations."
    - name: "total_movement_value_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of stock movements — used for commodity accountability, donor reporting, and inventory reconciliation."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movements — used to detect cost variance and validate pricing consistency."
    - name: "loss_adjustment_quantity"
      expr: SUM(CASE WHEN movement_type IN ('Loss', 'Adjustment', 'Expiry', 'Damage') THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity lost or adjusted out of stock — key wastage metric; high values trigger investigation and corrective action."
    - name: "loss_adjustment_value_usd"
      expr: SUM(CASE WHEN movement_type IN ('Loss', 'Adjustment', 'Expiry', 'Damage') THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total value of stock losses and adjustments — used to quantify financial impact of wastage for donor and audit reporting."
    - name: "total_movement_count"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions — baseline throughput metric and denominator for loss-rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile distribution order KPIs — tracks distribution volumes, values, and emergency response share. Core operational metric for programme delivery accountability and beneficiary reach."
  source: "`vibe_ngo_v1`.`supply`.`distribution_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the distribution order (Planned, Dispatched, Delivered, Cancelled)."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (Direct, Partner-Led, Mobile, Fixed Point) — used to analyse delivery modality effectiveness."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for delivery (Road, Air, Boat) — used for logistics cost analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the distribution order (Emergency, High, Normal) — used to track emergency response throughput."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Indicates the order is part of an emergency response — used to segregate emergency vs. development programme distributions."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order creation — enables trend analysis of distribution volumes over time."
    - name: "vaccine_distribution_flag"
      expr: vaccine_distribution_flag
      comment: "Indicates the order covers vaccine commodities — used for EPI programme distribution reporting."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates the distribution involves in-kind donated commodities — tracked for donor acknowledgement."
  measures:
    - name: "total_distribution_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of commodities distributed — primary financial accountability metric for programme delivery."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units distributed across all distribution orders — core programme output metric."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of commodities distributed — used for logistics capacity planning and transport cost analysis."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of commodities distributed — used for cold-chain and transport capacity planning."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport cost across distribution orders — used to compute logistics cost as a share of total distribution value."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END)
      comment: "Number of emergency distribution orders — tracks emergency response throughput and operational surge capacity."
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of distribution orders — baseline volume metric and denominator for emergency share calculations."
    - name: "avg_transport_cost_per_order_usd"
      expr: AVG(CAST(transport_cost_usd AS DOUBLE))
      comment: "Average transport cost per distribution order — used to benchmark logistics efficiency across delivery modalities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution planning KPIs — tracks planned vs. actual distribution coverage, budget, and risk levels. Enables programme planning quality assessment and resource allocation decisions."
  source: "`vibe_ngo_v1`.`supply`.`distribution_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the distribution plan (Draft, Approved, Active, Completed, Cancelled)."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Distribution modality (Cash, In-Kind, Voucher, Mixed) — key dimension for programme design analysis."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (Emergency, Development, Seasonal) — used to segment planning by programme type."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the plan (Low, Medium, High, Critical) — used to prioritise management attention."
    - name: "geographic_coverage_country"
      expr: geographic_coverage_country
      comment: "Country of distribution coverage — enables geographic analysis of planned distribution reach."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned distribution start — used for pipeline planning and resource scheduling."
    - name: "vaccine_campaign_flag"
      expr: vaccine_campaign_flag
      comment: "Indicates the plan covers a vaccine campaign — used to segregate EPI campaign planning metrics."
    - name: "coordination_cluster"
      expr: coordination_cluster
      comment: "UN cluster coordination alignment (Nutrition, Health, Logistics, NFI) — used for inter-agency reporting."
  measures:
    - name: "total_estimated_budget_usd"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across distribution plans — used for resource allocation and donor budget planning."
    - name: "total_estimated_weight_kg"
      expr: SUM(CAST(estimated_total_weight_kg AS DOUBLE))
      comment: "Total estimated weight of commodities to be distributed — used for logistics capacity planning."
    - name: "total_estimated_volume_m3"
      expr: SUM(CAST(estimated_total_volume_m3 AS DOUBLE))
      comment: "Total estimated volume of commodities to be distributed — used for cold-chain and transport capacity planning."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of distribution plans rated high or critical risk — triggers management review and risk mitigation action."
    - name: "total_plan_count"
      expr: COUNT(1)
      comment: "Total number of distribution plans — baseline planning volume metric."
    - name: "avg_estimated_budget_usd"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget per distribution plan — used to benchmark plan scale and detect outliers."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "International and domestic shipment KPIs — tracks freight costs, cold-chain compliance, and delivery performance. Critical for supply chain visibility and donor asset tracking."
  source: "`vibe_ngo_v1`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (In Transit, Arrived, Customs Hold, Delivered, Cancelled)."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (Air Freight, Sea Freight, Road, Courier) — used for cost and lead-time analysis by mode."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (Air, Sea, Road, Rail) — primary dimension for logistics cost benchmarking."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the shipment — used for geographic distribution of supply flows."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country of the shipment — used to analyse supply sourcing geography."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status (Cleared, Pending, Held) — used to track customs delays impacting programme delivery."
    - name: "cold_chain_verified_flag"
      expr: cold_chain_verified_flag
      comment: "Whether cold chain was verified throughout the shipment — critical for vaccine and pharmaceutical shipments."
    - name: "vaccine_shipment_flag"
      expr: vaccine_shipment_flag
      comment: "Indicates the shipment contains vaccine commodities — used to segregate cold-chain shipment reporting."
    - name: "estimated_arrival_date_month"
      expr: DATE_TRUNC('month', estimated_arrival_date)
      comment: "Month of estimated arrival — used for supply pipeline planning and programme delivery scheduling."
  measures:
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost across all shipments — primary logistics cost metric for supply chain efficiency analysis."
    - name: "total_insured_value_usd"
      expr: SUM(CAST(insured_value_usd AS DOUBLE))
      comment: "Total insured value of shipments — used for risk management and insurance coverage adequacy assessment."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(total_cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight shipped — used for logistics capacity planning and freight cost per kg calculations."
    - name: "total_cargo_volume_m3"
      expr: SUM(CAST(total_cargo_volume_m3 AS DOUBLE))
      comment: "Total cargo volume shipped — used for container utilisation and cold-chain capacity planning."
    - name: "cold_chain_breach_shipment_count"
      expr: COUNT(CASE WHEN cold_chain_verified_flag = FALSE AND vaccine_shipment_flag = TRUE THEN 1 END)
      comment: "Number of vaccine shipments where cold chain was not verified — critical quality failure metric requiring immediate investigation."
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipments — baseline volume metric and denominator for cold-chain breach rate calculations."
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment — used to benchmark logistics efficiency and detect cost outliers."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor registry and performance KPIs — tracks prequalification status, performance scores, and blacklist risk. Enables supplier base management and procurement compliance."
  source: "`vibe_ngo_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (Active, Suspended, Blacklisted, Pending Approval)."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (Manufacturer, Distributor, Transporter, Service Provider) — used for vendor base segmentation."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Prequalification status (Prequalified, Expired, Not Qualified) — used to enforce procurement eligibility rules."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the vendor (Preferred, Approved, Conditional, Suspended) — used for vendor stratification."
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Country where the vendor primarily operates — used for local procurement analysis and geographic sourcing strategy."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Indicates the vendor is blacklisted — used to enforce procurement exclusion rules and compliance controls."
    - name: "who_pq_manufacturer_flag"
      expr: who_pq_manufacturer_flag
      comment: "Indicates the vendor is a WHO prequalified manufacturer — critical for vaccine and pharmaceutical procurement eligibility."
    - name: "cold_chain_certified_flag"
      expr: cold_chain_certified_flag
      comment: "Indicates the vendor holds cold-chain certification — required for vaccine and temperature-sensitive commodity procurement."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the registry — baseline metric for vendor base size and diversity."
    - name: "prequalified_vendor_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Prequalified' THEN 1 END)
      comment: "Number of currently prequalified vendors — used to assess procurement competition depth and sourcing risk."
    - name: "blacklisted_vendor_count"
      expr: COUNT(CASE WHEN blacklist_flag = TRUE THEN 1 END)
      comment: "Number of blacklisted vendors — compliance KPI; any active procurement against blacklisted vendors is a critical control failure."
    - name: "avg_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average vendor performance score — used to track overall supplier base quality and identify underperforming vendors."
    - name: "who_pq_vendor_count"
      expr: COUNT(CASE WHEN who_pq_manufacturer_flag = TRUE THEN 1 END)
      comment: "Number of WHO prequalified manufacturers in the vendor base — critical for vaccine procurement eligibility and GAVI compliance."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms (days) across vendors — used for cash flow planning and working capital management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity and cold-chain infrastructure KPIs — tracks storage capacity, cold-chain functionality, and operational status. Enables infrastructure investment decisions and EVM (Effective Vaccine Management) compliance."
  source: "`vibe_ngo_v1`.`supply`.`warehouse`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the warehouse (Active, Inactive, Under Maintenance, Decommissioned)."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (Central Medical Store, Regional Hub, Field Store, Cold Room) — used for infrastructure tier analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (Owned, Leased, Partner, Government) — used for asset management and cost analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located — enables geographic infrastructure analysis."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the warehouse has temperature-controlled storage — used to assess cold-chain infrastructure coverage."
    - name: "vaccine_storage_certified_flag"
      expr: vaccine_storage_certified_flag
      comment: "Whether the warehouse is certified for vaccine storage — critical for EPI programme infrastructure planning."
    - name: "vaccine_storage_tier"
      expr: vaccine_storage_tier
      comment: "Vaccine storage tier (National, Regional, District, Health Facility) — used for cold-chain network analysis."
  measures:
    - name: "total_storage_capacity_m3"
      expr: SUM(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Total storage capacity in cubic metres across all warehouses — primary infrastructure capacity metric."
    - name: "total_cold_chain_capacity_liters"
      expr: SUM(CAST(cold_chain_capacity_liters AS DOUBLE))
      comment: "Total cold-chain storage capacity in litres — critical for vaccine programme capacity planning and EVM assessments."
    - name: "total_freezer_capacity_liters"
      expr: SUM(CAST(freezer_capacity_liters AS DOUBLE))
      comment: "Total freezer capacity in litres — used for ultra-cold chain vaccine storage planning (e.g. mRNA vaccines)."
    - name: "total_ultra_cold_capacity_liters"
      expr: SUM(CAST(ultra_cold_capacity_liters AS DOUBLE))
      comment: "Total ultra-cold storage capacity — required for mRNA vaccine programmes and advanced biologics."
    - name: "avg_cold_chain_functional_pct"
      expr: AVG(CAST(cold_chain_functional_percentage AS DOUBLE))
      comment: "Average percentage of cold-chain equipment that is functional — key EVM indicator; below 80% triggers infrastructure investment."
    - name: "avg_evm_score"
      expr: AVG(CAST(evm_score AS DOUBLE))
      comment: "Average Effective Vaccine Management (EVM) score across warehouses — WHO/UNICEF standard KPI for cold-chain system performance."
    - name: "active_warehouse_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of operationally active warehouses — used for network coverage and capacity planning."
    - name: "vaccine_certified_warehouse_count"
      expr: COUNT(CASE WHEN vaccine_storage_certified_flag = TRUE THEN 1 END)
      comment: "Number of warehouses certified for vaccine storage — used to assess cold-chain network adequacy for EPI programmes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quotation (RFQ) process KPIs — tracks bid competition, award values, and procurement cycle efficiency. Enables procurement transparency and donor compliance reporting."
  source: "`vibe_ngo_v1`.`supply`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (Draft, Published, Evaluation, Awarded, Cancelled)."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (Open Tender, Restricted Tender, Direct Award) — required for donor compliance reporting."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Type of procurement (Goods, Services, Works) — used for spend category analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category being procured — used for spend analysis by sector."
    - name: "emergency_procurement"
      expr: emergency_procurement
      comment: "Indicates the RFQ was issued under emergency procurement procedures — used to track emergency procurement share."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of RFQ issuance — enables trend analysis of procurement activity over time."
  measures:
    - name: "total_estimated_budget_usd"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all RFQs — used for procurement pipeline planning and budget commitment tracking."
    - name: "total_awarded_amount_usd"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ processes — compared against estimated budget to compute savings rate."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all RFQs — used for demand aggregation and framework agreement sizing."
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued — baseline procurement activity metric."
    - name: "emergency_rfq_count"
      expr: COUNT(CASE WHEN emergency_procurement = TRUE THEN 1 END)
      comment: "Number of RFQs issued under emergency procedures — high values signal planning failures and increased procurement risk."
    - name: "avg_estimated_budget_usd"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget per RFQ — used to benchmark procurement scale and detect fragmentation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_bid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid evaluation KPIs — tracks bid scores, award rates, and competition levels. Enables procurement transparency, value-for-money analysis, and donor audit readiness."
  source: "`vibe_ngo_v1`.`supply`.`bid`"
  dimensions:
    - name: "bid_status"
      expr: bid_status
      comment: "Status of the bid (Submitted, Under Evaluation, Awarded, Rejected, Withdrawn)."
    - name: "awarded_flag"
      expr: awarded_flag
      comment: "Indicates whether this bid was awarded the contract — used to compute award rates and competition analysis."
    - name: "currency"
      expr: currency
      comment: "Currency of the bid amount — needed for multi-currency bid comparison."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of bid submission — used for procurement pipeline trend analysis."
  measures:
    - name: "total_bid_amount_usd"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of all bids received — used to assess market pricing and compute savings against awarded amounts."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score across bids — used to assess supplier technical capability and evaluation quality."
    - name: "avg_financial_score"
      expr: AVG(CAST(financial_score AS DOUBLE))
      comment: "Average financial evaluation score across bids — used to assess price competitiveness of the supplier market."
    - name: "avg_total_score"
      expr: AVG(CAST(total_score AS DOUBLE))
      comment: "Average combined evaluation score — used to benchmark overall bid quality and evaluation rigour."
    - name: "total_bid_count"
      expr: COUNT(1)
      comment: "Total number of bids received — used to compute competition level per RFQ (higher bid counts indicate better market competition)."
    - name: "awarded_bid_count"
      expr: COUNT(CASE WHEN awarded_flag = TRUE THEN 1 END)
      comment: "Number of bids that were awarded — used to verify single-award compliance and detect split-award patterns."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement utilisation and performance KPIs — tracks agreement value utilisation, performance ratings, and expiry risk. Enables strategic sourcing decisions and procurement efficiency analysis."
  source: "`vibe_ngo_v1`.`supply`.`framework_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the framework agreement (Active, Expired, Suspended, Terminated)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (Long-Term Agreement, Standing Offer, Blanket Purchase Order) — used for procurement strategy analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the agreement (Global, Regional, Country) — used for sourcing strategy analysis."
    - name: "commodity_categories"
      expr: commodity_categories
      comment: "Commodity categories covered by the agreement — used for spend category analysis."
    - name: "effective_start_date_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — used for agreement vintage analysis."
    - name: "effective_end_date_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the agreement expires — used to identify agreements requiring renewal action."
  measures:
    - name: "total_value_utilized_usd"
      expr: SUM(CAST(total_value_utilized AS DOUBLE))
      comment: "Total value of orders placed against framework agreements — primary utilisation metric for strategic sourcing effectiveness."
    - name: "total_maximum_order_value_usd"
      expr: SUM(CAST(maximum_order_value AS DOUBLE))
      comment: "Total maximum order value across all framework agreements — used as denominator for utilisation rate calculations."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across framework agreements — measures procurement savings achieved through strategic sourcing."
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of framework agreements — baseline metric for strategic sourcing portfolio size."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active framework agreements — used to assess available procurement vehicles and sourcing coverage."
    - name: "avg_maximum_order_quantity"
      expr: AVG(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Average maximum order quantity per agreement — used for supply planning and demand aggregation analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inkind_donation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-kind donation receipt and valuation KPIs — tracks fair market value, quality inspection outcomes, and donor restriction compliance. Critical for donor acknowledgement, IATI reporting, and asset accountability."
  source: "`vibe_ngo_v1`.`supply`.`inkind_donation`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of donor acknowledgement for the in-kind donation (Pending, Sent, Confirmed)."
    - name: "condition_status"
      expr: condition_status
      comment: "Physical condition of donated goods (Good, Damaged, Expired, Unknown) — used for quality and usability analysis."
    - name: "donor_type"
      expr: donor_type
      comment: "Type of donor (Corporate, Government, Individual, Foundation) — used for donor relationship and stewardship analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status of the donation (Unallocated, Allocated, Distributed) — used for asset pipeline tracking."
    - name: "restricted_use_flag"
      expr: restricted_use_flag
      comment: "Indicates the donation has donor-imposed use restrictions — used for compliance and allocation management."
    - name: "iati_reporting_flag"
      expr: iati_reporting_flag
      comment: "Indicates the donation must be reported in IATI — used to ensure transparency reporting compliance."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of donation receipt — enables trend analysis of in-kind donation volumes over time."
    - name: "valuation_currency_code"
      expr: valuation_currency_code
      comment: "Currency used for fair market valuation — needed for multi-currency aggregation."
  measures:
    - name: "total_fair_market_value_usd"
      expr: SUM(CAST(estimated_fair_market_value AS DOUBLE))
      comment: "Total estimated fair market value of in-kind donations received — primary financial accountability metric for in-kind resource mobilisation."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units of in-kind donations received — used for programme resource planning and donor acknowledgement."
    - name: "total_donation_count"
      expr: COUNT(1)
      comment: "Total number of in-kind donation records — baseline volume metric."
    - name: "quality_failed_donation_count"
      expr: COUNT(CASE WHEN quality_inspection_result = 'Failed' THEN 1 END)
      comment: "Number of in-kind donations that failed quality inspection — used to assess donation quality and inform donor engagement."
    - name: "avg_fair_market_value_usd"
      expr: AVG(CAST(estimated_fair_market_value AS DOUBLE))
      comment: "Average fair market value per in-kind donation — used to benchmark donation scale and prioritise acknowledgement effort."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_gavi_cofinancing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GAVI co-financing obligation and payment KPIs — tracks country co-financing obligations, payments, and compliance. Critical for GAVI eligibility maintenance and vaccine programme sustainability."
  source: "`vibe_ngo_v1`.`supply`.`gavi_cofinancing`"
  dimensions:
    - name: "cofinancing_status"
      expr: gavi_cofinancing_status
      comment: "Status of the co-financing arrangement (Compliant, In Default, Pending Payment, Graduated)."
    - name: "cofinancing_phase"
      expr: cofinancing_phase
      comment: "GAVI co-financing phase (Phase 1, Phase 2, Phase 3, Fully Self-Financing) — used to track country graduation progress."
    - name: "gavi_phase"
      expr: gavi_phase
      comment: "GAVI programme phase — used to segment co-financing analysis by programme generation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the co-financing obligation — used for annual compliance tracking."
    - name: "vaccine_name"
      expr: vaccine_name
      comment: "Name of the vaccine covered by the co-financing arrangement — used for antigen-level co-financing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the co-financing amounts — needed for multi-currency aggregation."
  measures:
    - name: "total_cofinancing_obligation_usd"
      expr: SUM(CAST(cofinancing_obligation_usd AS DOUBLE))
      comment: "Total country co-financing obligation to GAVI — primary accountability metric for GAVI partnership compliance."
    - name: "total_cofinancing_paid_usd"
      expr: SUM(CAST(cofinancing_paid_usd AS DOUBLE))
      comment: "Total co-financing payments made — compared against obligation to compute payment compliance rate."
    - name: "total_gavi_contribution_usd"
      expr: SUM(CAST(gavi_contribution_usd AS DOUBLE))
      comment: "Total GAVI contribution to vaccine procurement — used to quantify donor leverage and co-financing ratio."
    - name: "total_country_share_usd"
      expr: SUM(CAST(country_share_amount AS DOUBLE))
      comment: "Total country share of vaccine procurement costs — used to track government health financing commitment."
    - name: "total_doses_procured"
      expr: SUM(CAST(doses_procured AS DOUBLE))
      comment: "Total vaccine doses procured under GAVI co-financing arrangements — primary programme output metric."
    - name: "avg_price_per_dose_usd"
      expr: AVG(CAST(price_per_dose_usd AS DOUBLE))
      comment: "Average price per vaccine dose — benchmarked against GAVI reference prices to assess procurement value for money."
    - name: "avg_cofinancing_rate_pct"
      expr: AVG(CAST(cofinancing_rate_percent AS DOUBLE))
      comment: "Average co-financing rate percentage — used to track country graduation progress and GAVI subsidy dependency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_temperature_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold-chain temperature excursion KPIs — tracks frequency, severity, and commodity impact of cold-chain failures. Critical for vaccine quality assurance and EVM compliance."
  source: "`vibe_ngo_v1`.`supply`.`temperature_excursion`"
  dimensions:
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of temperature excursion (Freeze, Heat, Power Failure) — used to identify root cause patterns."
    - name: "severity"
      expr: severity
      comment: "Severity of the excursion (Minor, Moderate, Severe, Critical) — used to prioritise investigation and corrective action."
    - name: "is_commodity_compromised"
      expr: is_commodity_compromised
      comment: "Whether commodities were compromised by the excursion — used to quantify stock loss risk."
    - name: "commodity_disposition"
      expr: commodity_disposition
      comment: "Disposition decision for affected commodities (Use, Discard, Quarantine, Pending Assessment)."
    - name: "excursion_start_month"
      expr: DATE_TRUNC('month', excursion_start_timestamp)
      comment: "Month of excursion occurrence — enables trend analysis of cold-chain failure frequency."
    - name: "vvm_stage_after"
      expr: vvm_stage_after
      comment: "VVM stage of affected vaccines after the excursion — used to assess heat exposure impact on vaccine potency."
  measures:
    - name: "total_excursion_count"
      expr: COUNT(1)
      comment: "Total number of temperature excursions recorded — primary cold-chain quality metric; high frequency triggers infrastructure review."
    - name: "total_commodities_affected_quantity"
      expr: SUM(CAST(commodities_affected_quantity AS DOUBLE))
      comment: "Total quantity of commodities affected by temperature excursions — used to quantify stock-at-risk and potential programme impact."
    - name: "compromised_excursion_count"
      expr: COUNT(CASE WHEN is_commodity_compromised = TRUE THEN 1 END)
      comment: "Number of excursions where commodities were confirmed compromised — direct measure of cold-chain failure impact on programme supplies."
    - name: "avg_max_temperature_celsius"
      expr: AVG(CAST(max_temperature_celsius AS DOUBLE))
      comment: "Average maximum temperature recorded during excursions — used to assess severity of heat exposure events."
    - name: "avg_min_temperature_celsius"
      expr: AVG(CAST(min_temperature_celsius AS DOUBLE))
      comment: "Average minimum temperature recorded during excursions — used to assess freeze exposure risk for freeze-sensitive vaccines."
    - name: "severe_excursion_count"
      expr: COUNT(CASE WHEN severity IN ('Severe', 'Critical') THEN 1 END)
      comment: "Number of severe or critical temperature excursions — triggers mandatory investigation and donor notification under cold-chain protocols."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_batch_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch and lot traceability KPIs — tracks stock quantities, expiry risk, and WHO prequalification status at batch level. Enables FEFO (First Expiry First Out) management and quality traceability."
  source: "`vibe_ngo_v1`.`supply`.`batch_lot`"
  dimensions:
    - name: "who_pq_status"
      expr: who_pq_status
      comment: "WHO prequalification status of the batch (Prequalified, Not Prequalified, Under Review) — used for quality compliance tracking."
    - name: "is_expired_flag"
      expr: is_expired_flag
      comment: "Indicates the batch has passed its expiry date — used to identify and quarantine expired stock."
    - name: "vvm_stage"
      expr: vvm_stage
      comment: "Current VVM stage of the batch — used to prioritise distribution of heat-exposed vaccine batches."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of manufacture — used for supply chain traceability and import compliance."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of batch expiry — used for FEFO planning and wastage prevention."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the batch — required for quantity aggregation consistency."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received across all batch lots — used for inbound supply volume tracking."
    - name: "total_quantity_remaining"
      expr: SUM(CAST(quantity_remaining AS DOUBLE))
      comment: "Total quantity remaining in stock across all batch lots — used for inventory position and wastage risk assessment."
    - name: "expired_batch_count"
      expr: COUNT(CASE WHEN is_expired_flag = TRUE THEN 1 END)
      comment: "Number of expired batch lots still in the system — high counts indicate wastage risk and FEFO management failures."
    - name: "expired_quantity_remaining"
      expr: SUM(CASE WHEN is_expired_flag = TRUE THEN CAST(quantity_remaining AS DOUBLE) ELSE 0 END)
      comment: "Total quantity remaining in expired batches — direct measure of stock wastage requiring disposal action."
    - name: "total_batch_count"
      expr: COUNT(1)
      comment: "Total number of batch lots — baseline traceability metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_procurement_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement request pipeline KPIs — tracks request volumes, estimated costs, urgency levels, and approval status. Enables demand planning and procurement workload management."
  source: "`vibe_ngo_v1`.`supply`.`procurement_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Status of the procurement request (Draft, Submitted, Approved, Rejected, Converted to PO)."
    - name: "request_type"
      expr: request_type
      comment: "Type of procurement request (Goods, Services, Works) — used for demand category analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the request (Routine, Urgent, Emergency) — used to prioritise procurement processing."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category requested — used for demand aggregation and framework agreement utilisation planning."
    - name: "request_date_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of request submission — enables trend analysis of procurement demand over time."
    - name: "local_procurement_preference"
      expr: local_procurement_preference
      comment: "Indicates a preference for local procurement — used to track local sourcing strategy compliance."
  measures:
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all procurement requests — used for budget commitment forecasting and procurement pipeline planning."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all procurement requests — used for demand aggregation and supply planning."
    - name: "total_request_count"
      expr: COUNT(1)
      comment: "Total number of procurement requests — baseline workload metric for procurement team capacity planning."
    - name: "emergency_request_count"
      expr: COUNT(CASE WHEN urgency_level = 'Emergency' THEN 1 END)
      comment: "Number of emergency procurement requests — high values signal planning failures and increased procurement risk and cost."
    - name: "avg_estimated_unit_cost_usd"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost per procurement request — used to benchmark against actual PO unit prices for savings analysis."
$$;