-- Metric views for domain: logistics | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics covering freight cost, on-time delivery, weight/volume throughput, and hazmat exposure. Used by logistics VPs and supply chain directors to steer carrier strategy and cost management."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail) for segmenting shipment KPIs by channel."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current lifecycle status of the shipment (e.g. in-transit, delivered, cancelled)."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level (e.g. standard, express, overnight) for SLA analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code governing risk and cost transfer point."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic segmentation of shipment flows."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contains hazardous materials."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the shipment requires temperature-controlled handling."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month bucket of scheduled delivery date for trend analysis."
    - name: "direction"
      expr: direction
      comment: "Shipment direction (inbound/outbound) for flow analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline volume KPI for capacity and carrier planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight spend across all shipments. Primary cost KPI for logistics budget management."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Tracks cost efficiency and carrier rate trends."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipped weight in kilograms. Used for capacity planning and freight class analysis."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total shipped volume in cubic metres. Used for load optimisation and carrier capacity negotiations."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_timestamp <= CAST(scheduled_delivery_date AS TIMESTAMP) THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of delivered shipments that arrived on or before the scheduled delivery date. Core carrier performance KPI."
    - name: "hazmat_shipment_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazardous-material shipments. Drives compliance oversight and carrier certification requirements."
    - name: "avg_insurance_value"
      expr: AVG(CAST(insurance_value_amount AS DOUBLE))
      comment: "Average declared insurance value per shipment. Informs risk exposure and insurance premium negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics covering spend, audit variances, payment status, and three-way match outcomes. Used by finance and procurement to control freight spend and detect billing discrepancies."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of freight service (e.g. LTL, FTL, parcel) for spend segmentation."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match outcome (matched, disputed, pending) for AP control."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for trend analysis of freight spend."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency spend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms on the freight invoice for cost responsibility segmentation."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total freight invoiced amount. Primary freight spend KPI for budget vs. actuals tracking."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved freight amount after audit. Reflects validated spend."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed freight amount. Signals billing accuracy issues with carriers."
    - name: "total_audited_amount"
      expr: SUM(CAST(audited_amount AS DOUBLE))
      comment: "Total audited freight amount. Used to measure audit coverage and recovery."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge AS DOUBLE))
      comment: "Total fuel surcharge billed. Tracks fuel cost exposure for carrier contract renegotiation."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges AS DOUBLE))
      comment: "Total accessorial charges (detention, liftgate, etc.). Identifies hidden cost drivers."
    - name: "freight_audit_variance"
      expr: SUM(CAST(invoiced_amount AS DOUBLE) - CAST(audited_amount AS DOUBLE))
      comment: "Total variance between invoiced and audited amounts. Measures overbilling exposure and audit recovery opportunity."
    - name: "avg_freight_cost_per_invoice"
      expr: AVG(CAST(invoiced_amount AS DOUBLE))
      comment: "Average freight cost per invoice. Benchmarks carrier billing levels over time."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on freight invoices. Required for tax compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master performance metrics covering on-time delivery, safety, claims ratio, and insurance coverage. Used by logistics and procurement leadership to manage carrier relationships and sourcing decisions."
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (asset, broker, NVOCC, etc.) for performance segmentation."
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode (road, air, ocean, rail) for modal analysis."
    - name: "carrier_status"
      expr: carrier_status
      comment: "Active/inactive status of the carrier for roster management."
    - name: "safety_rating"
      expr: safety_rating
      comment: "Regulatory safety rating of the carrier for compliance segmentation."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether the carrier is certified to handle hazardous materials."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the carrier offers temperature-controlled services."
  measures:
    - name: "total_active_carriers"
      expr: COUNT(CASE WHEN carrier_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active carriers in the approved roster. Tracks carrier base breadth."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across all carriers. Primary carrier performance KPI."
    - name: "avg_claims_ratio"
      expr: AVG(CAST(claims_ratio AS DOUBLE))
      comment: "Average freight claims ratio across carriers. Measures cargo damage and loss exposure."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score across carriers. Drives carrier qualification and risk management decisions."
    - name: "avg_insurance_coverage"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage amount per carrier. Ensures adequate risk coverage in the carrier base."
    - name: "hazmat_certified_carrier_count"
      expr: SUM(CASE WHEN hazmat_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of hazmat-certified carriers. Ensures sufficient capacity for dangerous goods shipments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order execution metrics covering cost, weight, volume, and tender performance. Used by logistics operations to manage carrier tendering and freight cost control."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: CAST(freight_order_status AS STRING)
      comment: "Current status of the freight order (tendered, accepted, in-transit, delivered)."
    - name: "service_type"
      expr: service_type
      comment: "Service type (LTL, FTL, parcel, etc.) for cost and volume segmentation."
    - name: "tender_method"
      expr: tender_method
      comment: "Method used to tender the freight order (spot, contract, auction) for sourcing analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the freight order for service level analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code for cost responsibility segmentation."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the freight order was created for trend analysis."
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders. Baseline volume KPI for logistics operations."
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all freight orders. Primary cost KPI for logistics spend management."
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(total_freight_cost AS DOUBLE))
      comment: "Average freight cost per order. Benchmarks cost efficiency across service types and carriers."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight shipped via freight orders. Used for capacity planning and rate negotiation."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume shipped via freight orders. Supports load optimisation and carrier capacity management."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges on freight orders. Identifies cost leakage beyond base freight rates."
    - name: "carrier_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN carrier_acceptance_status = 'ACCEPTED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of freight orders accepted by the tendered carrier. Measures carrier responsiveness and tender strategy effectiveness."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_timestamp <= delivery_window_end THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of freight orders delivered within the committed delivery window. Core service performance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound delivery performance metrics covering receipt accuracy, customs clearance, and inspection compliance. Used by warehouse and procurement teams to manage supplier delivery performance."
  source: "`vibe_manufacturing_v1`.`logistics`.`inbound_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the inbound delivery for pipeline visibility."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt posting status for inventory accuracy tracking."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for import compliance monitoring."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code for cost and risk responsibility segmentation."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether quality inspection is required on receipt."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery for trend and backlog analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance and sourcing analysis."
  measures:
    - name: "total_inbound_deliveries"
      expr: COUNT(1)
      comment: "Total number of inbound deliveries. Baseline volume KPI for receiving operations."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across inbound deliveries. Used for supplier fill-rate analysis."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity actually received. Compared against ordered quantity to measure supplier compliance."
    - name: "delivery_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity received. Core supplier delivery performance KPI."
    - name: "total_delivery_variance_quantity"
      expr: SUM(CAST(delivery_variance_quantity AS DOUBLE))
      comment: "Total quantity variance (over/under delivery). Measures supplier accuracy and inventory impact."
    - name: "on_time_receipt_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of inbound deliveries received on or before the expected date. Measures supplier on-time performance."
    - name: "inspection_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inbound deliveries requiring quality inspection. Drives quality resource planning."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average inbound freight cost per delivery. Used for landed cost analysis and supplier negotiation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight claims financial and resolution metrics covering claim amounts, settlement rates, and recovery performance. Used by logistics risk and finance teams to manage carrier liability and insurance recovery."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of freight claim (damage, shortage, delay, loss) for root-cause analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (filed, under review, settled, denied) for pipeline management."
    - name: "claim_reason_code"
      expr: claim_reason_code
      comment: "Reason code for the claim for systemic issue identification."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the claim for management attention prioritisation."
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month the claim was filed for trend analysis."
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Whether subrogation rights have been exercised for insurance recovery tracking."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of freight claims filed. Baseline KPI for carrier damage and loss performance."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all freight claims. Measures gross financial exposure from carrier incidents."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved claim amount. Measures validated financial recovery from carriers."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total settled claim amount. Measures actual cash recovery from freight claims."
    - name: "claim_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount recovered through settlement. Key carrier accountability KPI."
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average claim amount per incident. Benchmarks severity of carrier damage events."
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total quantity of goods damaged or lost in transit. Drives carrier performance reviews and packaging improvements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg transit performance metrics covering delay, cost, and route efficiency. Used by logistics operations to identify bottlenecks in multi-leg shipment execution."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the shipment leg for pipeline visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this leg for modal cost and performance analysis."
    - name: "load_type"
      expr: load_type
      comment: "Load type (FTL, LTL, etc.) for cost efficiency analysis."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for leg delay for root-cause analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Whether this leg involves cross-docking for network design analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether this leg requires temperature control for cold-chain compliance."
    - name: "scheduled_departure_month"
      expr: DATE_TRUNC('month', scheduled_departure_timestamp)
      comment: "Month of scheduled departure for trend analysis."
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Total number of shipment legs. Baseline volume KPI for network complexity analysis."
    - name: "total_leg_freight_cost"
      expr: SUM(CAST(leg_freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipment legs. Enables leg-level cost attribution for network optimisation."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time per leg in hours. Core leg performance KPI for route optimisation."
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all shipment legs. Identifies systemic delay patterns by mode or route."
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay per leg in hours. Benchmarks carrier and route reliability."
    - name: "total_leg_distance_km"
      expr: SUM(CAST(leg_distance_km AS DOUBLE))
      comment: "Total distance covered across all shipment legs. Used for carbon emission calculations and cost-per-km analysis."
    - name: "avg_route_optimisation_score"
      expr: AVG(CAST(route_optimization_score AS DOUBLE))
      comment: "Average route optimisation score per leg. Measures effectiveness of TMS routing decisions."
    - name: "delayed_leg_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN delay_duration_hours > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipment legs experiencing a delay. Drives carrier performance management and route review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_customs_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs declaration compliance metrics covering clearance performance, duty costs, and regulatory hold rates. Used by trade compliance and logistics teams to manage import/export risk."
  source: "`vibe_manufacturing_v1`.`logistics`.`customs_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: CAST(declaration_status AS STRING)
      comment: "Current status of the customs declaration (filed, cleared, held, rejected)."
    - name: "declaration_type"
      expr: CAST(declaration_type AS STRING)
      comment: "Type of customs declaration (import, export, transit) for compliance segmentation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance and tariff analysis."
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for export control and sanctions screening."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for modal customs compliance analysis."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether the declaration is under a regulatory hold."
    - name: "entry_month"
      expr: DATE_TRUNC('month', entry_date)
      comment: "Month of customs entry for trend analysis."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations. Baseline volume KPI for trade compliance operations."
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty paid. Primary trade cost KPI for landed cost and tariff management."
    - name: "total_vat_amount"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT paid on customs declarations. Required for tax compliance and cash flow management."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total taxes (duty + VAT + other) on customs declarations. Comprehensive trade tax exposure KPI."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared customs value. Used for duty rate benchmarking and valuation compliance."
    - name: "regulatory_hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_hold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations placed on regulatory hold. Measures trade compliance risk exposure."
    - name: "avg_duty_per_declaration"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per customs declaration. Benchmarks tariff burden by trade lane."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_trade_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade compliance screening metrics covering denied-party matches, embargo flags, export license requirements, and risk scores. Used by trade compliance officers and legal teams to manage export control risk."
  source: "`vibe_manufacturing_v1`.`logistics`.`trade_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the trade record (compliant, non-compliant, under review)."
    - name: "check_type"
      expr: check_type
      comment: "Type of compliance check performed (denied party, embargo, export license, dual use)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the trade record for prioritisation."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic risk segmentation."
    - name: "dual_use_flag"
      expr: dual_use_flag
      comment: "Whether the shipment involves dual-use goods requiring export control."
    - name: "check_month"
      expr: DATE_TRUNC('month', check_date)
      comment: "Month of compliance check for trend analysis."
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total number of trade compliance checks performed. Baseline KPI for compliance programme coverage."
    - name: "denied_party_match_count"
      expr: SUM(CASE WHEN denied_party_match_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of records with a denied-party list match. Critical risk KPI requiring immediate escalation."
    - name: "embargo_flag_count"
      expr: SUM(CASE WHEN embargo_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of records flagged for embargo violations. Drives legal and compliance escalation."
    - name: "export_license_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN export_license_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trade records requiring an export license. Measures export control compliance burden."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average trade compliance risk score. Tracks overall risk profile of the shipment portfolio."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records requiring escalation. Measures compliance programme stress and resource needs."
    - name: "documentation_completeness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN documentation_complete_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trade records with complete documentation. Drives customs clearance speed and compliance audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_lane_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade lane performance and cost metrics covering transit time, cost efficiency, on-time performance, and capacity utilisation. Used by network design and logistics strategy teams to optimise the freight network."
  source: "`vibe_manufacturing_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_status"
      expr: lane_status
      comment: "Active/inactive status of the lane for network roster management."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of lane (domestic, international, cross-border) for network segmentation."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Primary mode of transport for the lane for modal analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for trade flow analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade flow analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the lane supports temperature-controlled shipments."
    - name: "lane_group"
      expr: lane_group
      comment: "Lane group for regional or strategic network segmentation."
  measures:
    - name: "total_active_lanes"
      expr: COUNT(CASE WHEN lane_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active trade lanes. Measures network breadth and coverage."
    - name: "total_annual_volume"
      expr: SUM(CAST(annual_volume AS DOUBLE))
      comment: "Total annual shipment volume across all lanes. Primary network throughput KPI."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(average_transit_time_hours AS DOUBLE))
      comment: "Average transit time in hours across lanes. Benchmarks network speed for customer service commitments."
    - name: "avg_cost_per_shipment"
      expr: AVG(CAST(average_cost_per_shipment AS DOUBLE))
      comment: "Average cost per shipment across lanes. Identifies high-cost lanes for renegotiation or modal shift."
    - name: "avg_on_time_performance_pct"
      expr: AVG(CAST(on_time_performance_pct AS DOUBLE))
      comment: "Average on-time performance percentage across lanes. Core network reliability KPI."
    - name: "avg_load_factor_pct"
      expr: AVG(CAST(average_load_factor_percent AS DOUBLE))
      comment: "Average load factor percentage across lanes. Measures capacity utilisation efficiency."
    - name: "total_lane_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total usage count across all lanes. Identifies high-frequency lanes for priority investment."
    - name: "avg_cost_per_km"
      expr: AVG(CAST(cost_per_mile AS DOUBLE))
      comment: "Average cost per distance unit across lanes. Benchmarks freight rate efficiency for network optimisation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_load_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load plan utilisation and cost metrics covering weight and volume utilisation, freight cost estimation, and planning efficiency. Used by warehouse and logistics operations to maximise load efficiency."
  source: "`vibe_manufacturing_v1`.`logistics`.`load_plan`"
  dimensions:
    - name: "load_plan_status"
      expr: load_plan_status
      comment: "Current status of the load plan (draft, confirmed, executed) for pipeline management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the load plan for modal efficiency analysis."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (inbound, outbound, transfer) for directional analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the load plan for resource allocation."
    - name: "requires_hazmat_handling"
      expr: requires_hazmat_handling
      comment: "Whether the load plan requires hazmat handling for compliance resource planning."
    - name: "planned_load_month"
      expr: DATE_TRUNC('month', planned_load_date)
      comment: "Month of planned load date for capacity planning trend analysis."
  measures:
    - name: "total_load_plans"
      expr: COUNT(1)
      comment: "Total number of load plans created. Baseline KPI for outbound planning activity."
    - name: "avg_weight_utilisation_pct"
      expr: AVG(CAST(weight_utilization_percentage AS DOUBLE))
      comment: "Average weight utilisation percentage per load plan. Measures how efficiently vehicle weight capacity is used."
    - name: "avg_volume_utilisation_pct"
      expr: AVG(CAST(volume_utilization_percentage AS DOUBLE))
      comment: "Average volume utilisation percentage per load plan. Measures cubic capacity efficiency."
    - name: "total_planned_weight_kg"
      expr: SUM(CAST(total_planned_weight_kg AS DOUBLE))
      comment: "Total planned weight across all load plans. Used for carrier capacity booking."
    - name: "total_planned_volume_m3"
      expr: SUM(CAST(total_planned_volume_m3 AS DOUBLE))
      comment: "Total planned volume across all load plans. Used for trailer and container booking."
    - name: "total_estimated_freight_cost"
      expr: SUM(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total estimated freight cost across all load plans. Supports freight budget forecasting."
    - name: "avg_estimated_freight_cost"
      expr: AVG(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Average estimated freight cost per load plan. Benchmarks planning cost accuracy against actuals."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier contract portfolio metrics covering contract coverage, rate commitments, and performance targets. Used by procurement and logistics leadership to manage carrier agreements and renewal risk."
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the carrier contract (active, expired, pending renewal)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of carrier contract (spot, annual, multi-year) for portfolio analysis."
    - name: "service_mode"
      expr: service_mode
      comment: "Service mode covered by the contract for modal spend analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews for renewal risk management."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the contract became effective for portfolio timeline analysis."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active carrier contracts. Measures contracted carrier coverage."
    - name: "total_minimum_volume_commitment"
      expr: SUM(CAST(minimum_volume_commitment AS DOUBLE))
      comment: "Total minimum volume committed across all carrier contracts. Measures contractual volume obligations."
    - name: "avg_on_time_delivery_target"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average contracted on-time delivery target across carrier contracts. Benchmarks SLA ambition level."
    - name: "avg_insurance_minimum_coverage"
      expr: AVG(CAST(insurance_minimum_coverage_amount AS DOUBLE))
      comment: "Average minimum insurance coverage required across contracts. Ensures adequate risk protection in the carrier base."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of carrier contracts expiring within 90 days. Critical renewal risk KPI for procurement planning."
    - name: "avg_damage_claim_liability_limit"
      expr: AVG(CAST(damage_claim_liability_limit AS DOUBLE))
      comment: "Average damage claim liability limit across contracts. Measures financial protection level in carrier agreements."
$$;