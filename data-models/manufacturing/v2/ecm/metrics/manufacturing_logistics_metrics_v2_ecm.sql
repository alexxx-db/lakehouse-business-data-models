-- Metric views for domain: logistics | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics covering freight cost, on-time delivery, weight/volume throughput, and hazmat exposure. Used by logistics VPs and supply chain directors to steer carrier strategy and cost reduction initiatives."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail) for modal cost and performance analysis."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (in-transit, delivered, cancelled) for pipeline visibility."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level (standard, express, overnight) to compare cost vs. service tier."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code governing risk and cost transfer point for trade compliance analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic freight cost and volume distribution analysis."
    - name: "direction"
      expr: direction
      comment: "Shipment direction (outbound, inbound, return) for directional flow analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contains hazardous materials, for compliance risk segmentation."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates cold-chain shipments requiring temperature control, for premium cost tracking."
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('MONTH', scheduled_delivery_date)
      comment: "Month of scheduled delivery for trend analysis of delivery volumes and costs."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight classification code affecting rate calculation and carrier billing."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline volume KPI for capacity planning and carrier allocation decisions."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight spend across all shipments. Primary cost KPI for logistics budget management and carrier negotiation."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Tracks cost efficiency trends and benchmarks carrier performance."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms. Drives carrier capacity planning and freight rate negotiations."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume shipped in cubic meters. Used alongside weight to assess dimensional weight billing exposure."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kg. Indicates load consolidation effectiveness and LTL vs FTL optimization opportunity."
    - name: "hazmat_shipment_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of hazardous material shipments. Critical compliance KPI for regulatory reporting and risk management."
    - name: "hazmat_shipment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments containing hazardous materials. Monitors compliance exposure and insurance risk profile."
    - name: "temperature_controlled_shipment_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Number of cold-chain shipments. Tracks premium logistics spend and cold-chain capacity utilization."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used. Measures carrier diversification and dependency concentration risk."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across shipments. Quantifies financial exposure and insurance premium adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics covering invoiced amounts, payment status, audit variances, and three-way match compliance. Used by finance and logistics controllers to manage freight spend, detect billing errors, and enforce carrier contract compliance."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the freight invoice (paid, pending, disputed) for cash flow and AP management."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (matched, unmatched, exception) for invoice audit and compliance tracking."
    - name: "service_type"
      expr: service_type
      comment: "Type of freight service billed (LTL, FTL, express) for cost-by-service analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency freight spend consolidation."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for freight spend trend analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for freight invoices, relevant for working capital and payment terms analysis."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total freight invoiced amount. Primary freight spend KPI for budget tracking and carrier cost management."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved freight amount after audit. Represents validated spend for financial reporting."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed freight charges. Measures billing error exposure and carrier invoice quality."
    - name: "total_audited_amount"
      expr: SUM(CAST(audited_amount AS DOUBLE))
      comment: "Total audited freight amount. Used to reconcile invoiced vs. approved spend and identify overbilling."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge AS DOUBLE))
      comment: "Total fuel surcharge billed. Tracks fuel cost pass-through exposure and hedging strategy effectiveness."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges AS DOUBLE))
      comment: "Total accessorial charges (detention, liftgate, etc.). Identifies operational inefficiencies driving extra carrier fees."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on freight invoices. Required for tax compliance reporting and VAT reclaim processes."
    - name: "invoice_variance_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE) - CAST(approved_amount AS DOUBLE))
      comment: "Total variance between invoiced and approved amounts. Key indicator of carrier overbilling and contract compliance."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoiced_amount AS DOUBLE))
      comment: "Average freight invoice amount. Benchmarks invoice size for anomaly detection and audit prioritization."
    - name: "disputed_invoice_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disputed_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices with disputed amounts. Measures carrier billing quality and audit effectiveness."
    - name: "three_way_match_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status != 'MATCHED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of freight invoices failing three-way match. Critical control KPI for AP fraud prevention and contract compliance."
    - name: "total_freight_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices processed. Volume baseline for AP workload and audit capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight claim metrics covering claim volumes, settlement rates, financial recovery, and carrier liability. Used by logistics risk managers and finance to evaluate carrier reliability, insurance adequacy, and claim recovery effectiveness."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the freight claim (open, settled, denied, escalated) for pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of freight claim (damage, shortage, delay, loss) for root cause analysis by claim category."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the claim for prioritization and management attention tracking."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight class associated with the claim for identifying high-risk commodity categories."
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the claim was filed for trend analysis of claim frequency and seasonal patterns."
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Indicates whether subrogation recovery was pursued, for insurance recovery strategy analysis."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of freight claims filed. Baseline KPI for carrier reliability and risk exposure assessment."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total value of freight claims filed. Quantifies financial exposure from carrier damage and loss events."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount recovered through claim settlements. Measures financial recovery effectiveness."
    - name: "total_settlement_offer_amount"
      expr: SUM(CAST(settlement_offer_amount AS DOUBLE))
      comment: "Total settlement amounts offered by carriers. Used to assess carrier negotiation posture and offer acceptance rates."
    - name: "claim_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount recovered through settlements. Key KPI for claims management effectiveness and carrier accountability."
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average claim value. Benchmarks claim severity and informs insurance coverage adequacy decisions."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim. Tracks negotiation outcomes and carrier settlement behavior."
    - name: "total_declared_value_at_risk"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared value of goods involved in claims. Measures insured asset exposure in the claims portfolio."
    - name: "distinct_carriers_with_claims"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with active or historical claims. Identifies carrier reliability concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master performance and risk metrics covering on-time delivery rates, safety scores, claims ratios, insurance coverage, and contract status. Used by procurement and logistics leadership to manage carrier qualification, contract renewals, and network optimization."
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (asset, broker, NVOCC) for network segmentation and sourcing strategy."
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (active, suspended, inactive) for approved carrier list management."
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode (road, air, ocean, rail) for modal strategy analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the carrier contract (active, expired, pending renewal) for contract lifecycle management."
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country of carrier headquarters for geographic network coverage analysis."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates whether the carrier is certified for hazardous materials transport, for compliance routing."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates cold-chain capability for routing temperature-sensitive shipments."
    - name: "edi_capability_flag"
      expr: edi_capability_flag
      comment: "Indicates EDI integration capability for digital connectivity and automation readiness assessment."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network. Baseline for carrier base size and diversification strategy."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across carriers. Primary carrier performance KPI for service level management and contract enforcement."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average carrier safety score. Critical risk KPI for carrier qualification and insurance premium management."
    - name: "avg_claims_ratio"
      expr: AVG(CAST(claims_ratio AS DOUBLE))
      comment: "Average claims ratio across carriers. Measures cargo damage and loss frequency for carrier risk stratification."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across all carriers. Quantifies aggregate risk coverage in the carrier network."
    - name: "avg_insurance_coverage"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage per carrier. Benchmarks coverage adequacy against cargo value exposure."
    - name: "active_carrier_count"
      expr: COUNT(CASE WHEN carrier_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active carriers. Measures available carrier capacity and network resilience."
    - name: "hazmat_certified_carrier_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of hazmat-certified carriers. Ensures sufficient certified capacity for dangerous goods shipments."
    - name: "edi_enabled_carrier_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edi_capability_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with EDI capability. Tracks digital integration maturity of the carrier network."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment_tracking_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment tracking event metrics covering delivery performance, exception rates, delay durations, and on-time delivery. Used by logistics operations and customer service to monitor real-time delivery performance and proactively manage exceptions."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of tracking event (pickup, in-transit, out-for-delivery, delivered, exception) for delivery stage analysis."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Indicates whether the event occurred on time, for on-time delivery rate calculation."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Reason code for delivery exceptions (weather, address issue, refused) for root cause analysis."
    - name: "event_country_code"
      expr: event_country_code
      comment: "Country where the tracking event occurred for geographic exception hotspot analysis."
    - name: "customs_clearance_flag"
      expr: customs_clearance_flag
      comment: "Indicates whether the event involved customs clearance, for trade compliance delay analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the tracking event for trend analysis of delivery performance over time."
    - name: "signature_required_flag"
      expr: signature_required_flag
      comment: "Indicates whether a signature was required at delivery, for proof-of-delivery compliance tracking."
  measures:
    - name: "total_tracking_events"
      expr: COUNT(1)
      comment: "Total number of tracking events. Baseline for shipment visibility coverage and carrier data quality assessment."
    - name: "on_time_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_time_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tracking events flagged as on-time. Primary delivery performance KPI for carrier SLA management."
    - name: "exception_event_count"
      expr: COUNT(CASE WHEN exception_reason_code IS NOT NULL AND exception_reason_code != '' THEN 1 END)
      comment: "Number of shipment exception events. Measures delivery disruption frequency for operational risk management."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_reason_code IS NOT NULL AND exception_reason_code != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tracking events that are exceptions. Key KPI for carrier reliability and customer satisfaction risk."
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all tracking events. Quantifies aggregate delivery delay impact on customer commitments."
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration per tracking event. Benchmarks carrier delay severity for SLA penalty calculations."
    - name: "distinct_shipments_tracked"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Number of distinct shipments with tracking events. Measures tracking coverage and visibility completeness."
    - name: "signature_obtained_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN signature_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required signatures successfully obtained at delivery. Measures proof-of-delivery compliance for dispute resolution."
    - name: "avg_temperature_reading"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature reading across cold-chain tracking events. Monitors cold-chain integrity for compliance and product quality."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order execution metrics covering freight costs, weight/volume, hazmat exposure, temperature control, and carrier acceptance. Used by logistics planners and operations managers to optimize freight execution, carrier tendering, and cost control."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order (planned, tendered, accepted, in-transit, delivered) for execution pipeline management."
    - name: "service_type"
      expr: service_type
      comment: "Service type of the freight order (LTL, FTL, parcel) for cost and capacity analysis by service category."
    - name: "tender_method"
      expr: tender_method
      comment: "Method used to tender the freight order (spot, contract, auction) for procurement strategy analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code for the freight order governing cost and risk transfer."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Indicates whether the freight order contains hazardous materials for compliance routing."
    - name: "temperature_controlled_indicator"
      expr: temperature_controlled_indicator
      comment: "Indicates cold-chain requirement for premium cost tracking and capacity planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the freight order for expedite cost analysis and service level compliance."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the freight order was created for volume trend and cost trend analysis."
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders. Baseline volume KPI for logistics capacity planning and carrier allocation."
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all orders. Primary cost KPI for logistics budget management and carrier spend analysis."
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(total_freight_cost AS DOUBLE))
      comment: "Average freight cost per order. Benchmarks cost efficiency and identifies outlier orders for cost reduction."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of freight ordered in kilograms. Drives carrier capacity planning and rate negotiation leverage."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of freight ordered in cubic meters. Used for load optimization and dimensional weight billing analysis."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges on freight orders. Identifies operational inefficiencies generating extra carrier fees."
    - name: "carrier_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN carrier_acceptance_status = 'ACCEPTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of freight orders accepted by carriers on first tender. Measures carrier network capacity and tendering effectiveness."
    - name: "hazmat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of freight orders containing hazardous materials. Monitors compliance risk concentration in the freight portfolio."
    - name: "avg_freight_rate_amount"
      expr: AVG(CAST(freight_rate_amount AS DOUBLE))
      comment: "Average contracted freight rate per order. Benchmarks rate competitiveness and tracks rate inflation over time."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound delivery performance metrics covering receipt accuracy, delivery variance, inspection rates, and freight costs. Used by procurement, warehouse, and supply chain managers to manage supplier delivery performance and receiving efficiency."
  source: "`vibe_manufacturing_v1`.`logistics`.`inbound_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the inbound delivery (pending, in-transit, received, blocked) for receiving pipeline management."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt posting status for inventory accuracy and AP three-way match readiness."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for import compliance and receiving delay analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code governing delivery responsibility and cost allocation."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether quality inspection is required upon receipt, for quality gate compliance tracking."
    - name: "delivery_complete_flag"
      expr: delivery_complete_flag
      comment: "Indicates whether the delivery was completed in full, for partial delivery analysis."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('MONTH', expected_delivery_date)
      comment: "Month of expected delivery for inbound volume planning and supplier schedule adherence analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of inbound goods for trade compliance and sourcing diversification analysis."
  measures:
    - name: "total_inbound_deliveries"
      expr: COUNT(1)
      comment: "Total number of inbound deliveries. Baseline volume KPI for receiving capacity planning and supplier activity monitoring."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across inbound deliveries. Measures procurement volume for inventory replenishment analysis."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity actually received. Compared against ordered quantity to measure supplier fill rate performance."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity received. Primary supplier delivery performance KPI for procurement scorecards."
    - name: "total_delivery_variance_quantity"
      expr: SUM(CAST(delivery_variance_quantity AS DOUBLE))
      comment: "Total quantity variance between ordered and received. Quantifies supplier over/under-delivery for contract compliance management."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost. Tracks landed cost components for total cost of ownership analysis."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average inbound freight cost per delivery. Benchmarks inbound logistics efficiency and supplier freight terms."
    - name: "inspection_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inbound deliveries requiring quality inspection. Measures quality risk exposure in the inbound supply chain."
    - name: "complete_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_complete_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries completed in full. Key supplier reliability KPI for procurement performance management."
    - name: "blocked_stock_delivery_count"
      expr: COUNT(CASE WHEN blocked_stock_flag = TRUE THEN 1 END)
      comment: "Number of deliveries placed in blocked stock. Measures quality hold frequency and its impact on inventory availability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs declaration compliance metrics covering duty amounts, compliance screening outcomes, denied party matches, and regulatory holds. Used by trade compliance officers and logistics managers to manage import/export risk and regulatory obligations."
  source: "`vibe_manufacturing_v1`.`logistics`.`customs_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: declaration_status
      comment: "Status of the customs declaration (pending, cleared, held, rejected) for compliance pipeline management."
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (import, export, transit) for directional trade compliance analysis."
    - name: "compliance_screening_outcome"
      expr: compliance_screening_outcome
      comment: "Outcome of compliance screening (pass, fail, review) for risk-based audit prioritization."
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for trade lane compliance risk analysis and embargo monitoring."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for rules-of-origin compliance and preferential duty rate analysis."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicates whether the declaration is under regulatory hold, for compliance escalation tracking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the declared shipment for modal compliance risk analysis."
    - name: "clearance_month"
      expr: DATE_TRUNC('MONTH', clearance_date)
      comment: "Month of customs clearance for trend analysis of clearance volumes and duty payments."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations. Baseline volume KPI for trade compliance workload and resource planning."
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty paid. Primary trade cost KPI for landed cost analysis and duty optimization strategies."
    - name: "total_vat_amount"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT paid on customs declarations. Required for VAT reclaim and tax compliance reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total taxes (duty + VAT + other) on customs declarations. Quantifies total tax burden for trade cost management."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared customs value. Measures trade volume and provides basis for duty rate benchmarking."
    - name: "avg_duty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(declared_value AS DOUBLE)), 0), 2)
      comment: "Average effective duty rate as percentage of declared value. Benchmarks duty burden and identifies duty optimization opportunities."
    - name: "regulatory_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations placed on regulatory hold. Critical compliance KPI for trade risk management and clearance delay analysis."
    - name: "denied_party_match_count"
      expr: COUNT(CASE WHEN denied_party_screening_result IS NOT NULL AND denied_party_screening_result != 'CLEAR' THEN 1 END)
      comment: "Number of declarations with denied party screening alerts. Critical sanctions compliance KPI requiring immediate escalation."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per customs declaration. Used for freight classification and duty basis validation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics lane performance and capacity metrics covering transit times, costs, utilization, and capacity. Used by network design and logistics strategy teams to optimize the freight network, identify underperforming lanes, and prioritize investment."
  source: "`vibe_manufacturing_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_status"
      expr: lane_status
      comment: "Operational status of the lane (active, inactive, seasonal) for network availability management."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of lane (direct, relay, intermodal) for network design and cost structure analysis."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Primary transport mode for the lane for modal network optimization."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier operating the lane for carrier strategy and network resilience analysis."
    - name: "lane_group"
      expr: lane_group
      comment: "Lane grouping for regional or corridor-level network performance analysis."
    - name: "compliance_hazardous_allowed"
      expr: compliance_hazardous_allowed
      comment: "Indicates whether hazardous goods are permitted on this lane for dangerous goods routing compliance."
    - name: "region"
      expr: region
      comment: "Geographic region of the lane for regional network performance benchmarking."
  measures:
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Total number of logistics lanes in the network. Baseline for network coverage and complexity management."
    - name: "total_network_capacity_tons"
      expr: SUM(CAST(capacity_tons AS DOUBLE))
      comment: "Total freight capacity across all lanes in tons. Measures network throughput capacity for supply chain resilience planning."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(average_transit_time_hours AS DOUBLE))
      comment: "Average transit time across lanes in hours. Key service level KPI for customer promise date setting and carrier SLA management."
    - name: "avg_cost_per_mile"
      expr: AVG(CAST(cost_per_mile AS DOUBLE))
      comment: "Average freight cost per mile across lanes. Benchmarks lane cost efficiency for network optimization and carrier negotiation."
    - name: "avg_load_factor_pct"
      expr: AVG(CAST(average_load_factor_percent AS DOUBLE))
      comment: "Average load factor percentage across lanes. Measures capacity utilization efficiency and consolidation opportunity."
    - name: "total_lane_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total network distance in kilometers. Used for carbon emission calculations and fuel cost modeling."
    - name: "avg_lane_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average lane distance in kilometers. Informs transit time expectations and cost-per-km benchmarking."
    - name: "total_lane_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total usage count across all lanes. Identifies high-frequency lanes for priority investment and capacity expansion."
    - name: "active_lane_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lane_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lanes that are currently active. Measures network utilization and identifies dormant capacity."
    - name: "total_volume_capacity_m3"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volumetric capacity across all lanes in cubic meters. Supports load planning and dimensional weight optimization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg execution metrics covering leg-level freight costs, transit times, delays, and route optimization scores. Used by logistics operations to identify bottleneck legs, optimize multi-leg routing, and manage carrier performance at the leg level."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "leg_status"
      expr: leg_status
      comment: "Status of the shipment leg (planned, in-transit, completed, delayed) for execution pipeline visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for this leg for modal cost and performance analysis."
    - name: "load_type"
      expr: load_type
      comment: "Load type (FTL, LTL, parcel) for cost structure and capacity utilization analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates cross-dock handling for cross-dock cost and throughput analysis."
    - name: "is_transshipment"
      expr: is_transshipment
      comment: "Indicates transshipment legs for multi-modal routing complexity and cost analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous materials on this leg for compliance routing verification."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates cold-chain requirement for this leg for premium cost tracking."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for this leg for cross-border delay analysis."
  measures:
    - name: "total_shipment_legs"
      expr: COUNT(1)
      comment: "Total number of shipment legs. Baseline for multi-leg routing complexity and carrier workload analysis."
    - name: "total_leg_freight_cost"
      expr: SUM(CAST(leg_freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipment legs. Enables leg-level cost attribution for route optimization."
    - name: "avg_leg_freight_cost"
      expr: AVG(CAST(leg_freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment leg. Benchmarks leg cost efficiency and identifies high-cost routing segments."
    - name: "total_transit_time_hours"
      expr: SUM(CAST(transit_time_hours AS DOUBLE))
      comment: "Total transit time across all legs in hours. Measures cumulative delivery time for end-to-end lead time analysis."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time per leg in hours. Benchmarks leg-level service performance against carrier SLAs."
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all shipment legs. Quantifies cumulative delay impact on delivery commitments."
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay per leg in hours. Identifies chronically delayed routing segments for network redesign."
    - name: "avg_route_optimization_score"
      expr: AVG(CAST(route_optimization_score AS DOUBLE))
      comment: "Average route optimization score across legs. Measures routing efficiency and TMS optimization effectiveness."
    - name: "total_leg_distance_km"
      expr: SUM(CAST(leg_distance_km AS DOUBLE))
      comment: "Total distance covered across all shipment legs in kilometers. Used for carbon footprint calculation and cost-per-km analysis."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge across all legs. Tracks fuel cost exposure and informs fuel hedging strategy."
    - name: "delayed_leg_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delay_duration_hours > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipment legs experiencing delays. Key operational KPI for carrier performance management and route reliability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_transport_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport route network metrics covering route costs, transit times, capacity constraints, and carbon emissions. Used by network design and sustainability teams to optimize the logistics network, manage route costs, and track carbon footprint."
  source: "`vibe_manufacturing_v1`.`logistics`.`transport_route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Operational status of the transport route (active, inactive, seasonal) for network availability management."
    - name: "route_type"
      expr: route_type
      comment: "Type of route (direct, relay, intermodal) for network design and cost structure analysis."
    - name: "primary_transport_mode"
      expr: primary_transport_mode
      comment: "Primary transport mode for modal network optimization and carbon emission analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service level of the route (standard, express, economy) for cost-service trade-off analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for trade lane analysis and network coverage assessment."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane analysis and customs requirement planning."
    - name: "hazmat_approved"
      expr: hazmat_approved
      comment: "Indicates whether the route is approved for hazardous materials for dangerous goods routing compliance."
    - name: "seasonal_restriction_flag"
      expr: seasonal_restriction_flag
      comment: "Indicates seasonal restrictions on the route for contingency planning and alternative routing."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of transport routes in the network. Baseline for network coverage and routing option availability."
    - name: "total_network_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total network distance across all routes in kilometers. Foundation for carbon emission modeling and fuel cost planning."
    - name: "avg_route_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average route distance in kilometers. Benchmarks network span and informs transit time and cost expectations."
    - name: "avg_standard_freight_cost"
      expr: AVG(CAST(standard_freight_cost AS DOUBLE))
      comment: "Average standard freight cost per route. Benchmarks route cost competitiveness for carrier negotiation and network optimization."
    - name: "total_standard_freight_cost"
      expr: SUM(CAST(standard_freight_cost AS DOUBLE))
      comment: "Total standard freight cost across all routes. Quantifies network cost baseline for budget planning."
    - name: "avg_standard_transit_days"
      expr: AVG(CAST(standard_transit_time_days AS DOUBLE))
      comment: "Average standard transit time in days. Key service level KPI for customer promise date setting and SLA design."
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor_kg_per_km AS DOUBLE))
      comment: "Average carbon emission factor (kg CO2 per km) across routes. Sustainability KPI for carbon footprint reporting and green logistics strategy."
    - name: "total_carbon_emission_potential_kg"
      expr: SUM(CAST(carbon_emission_factor_kg_per_km AS DOUBLE) * CAST(distance_km AS DOUBLE))
      comment: "Total potential carbon emissions (kg CO2) across all routes based on distance and emission factors. Drives decarbonization investment prioritization."
    - name: "avg_cost_per_km"
      expr: AVG(CAST(cost_per_km AS DOUBLE))
      comment: "Average freight cost per kilometer across routes. Normalizes route cost for fair comparison across different distances."
    - name: "hazmat_approved_route_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of routes approved for hazardous materials. Measures dangerous goods routing capacity in the network."
$$;