-- Metric views for domain: logistics | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier scorecard KPIs measuring on-time delivery, OTIF, tender acceptance, damage rates, and freight spend efficiency. Used by logistics leadership to evaluate and tier carrier relationships."
  source: "`vibe_consumer_goods_v1`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "carrier_performance_status"
      expr: carrier_performance_status
      comment: "Current status of the carrier performance record (e.g. finalized, draft, under review)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport evaluated (e.g. road, rail, air, ocean)."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Carrier performance tier classification (e.g. gold, silver, bronze) for strategic segmentation."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Granularity of the measurement period (e.g. monthly, quarterly, annual)."
    - name: "network_region"
      expr: network_region
      comment: "Geographic network region covered by this performance record."
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier applicable to this carrier performance record."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month bucket of the evaluation period start date for trend analysis."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Publication status of the carrier scorecard (e.g. published, pending, finalized)."
  measures:
    - name: "avg_otif_rate_pct"
      expr: AVG(CAST(otif_rate_pct AS DOUBLE))
      comment: "Average OTIF (On-Time In-Full) delivery rate across evaluated carriers. Primary carrier performance KPI used in QBRs and contract renewals."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across carriers. Drives carrier tier decisions and penalty clause triggers."
    - name: "avg_in_full_rate_pct"
      expr: AVG(CAST(in_full_rate_pct AS DOUBLE))
      comment: "Average in-full delivery rate. Measures completeness of shipment fulfillment, directly impacting customer service levels."
    - name: "avg_tender_acceptance_rate_pct"
      expr: AVG(CAST(tender_acceptance_rate_pct AS DOUBLE))
      comment: "Average tender acceptance rate. Low acceptance rates signal capacity risk and require routing guide adjustments."
    - name: "avg_damage_rate_pct"
      expr: AVG(CAST(damage_rate_pct AS DOUBLE))
      comment: "Average cargo damage rate. Elevated damage rates trigger insurance claims and carrier corrective action plans."
    - name: "avg_claim_rate_pct"
      expr: AVG(CAST(claim_rate_pct AS DOUBLE))
      comment: "Average freight claim rate. High claim rates indicate systemic handling issues and drive carrier deselection."
    - name: "total_freight_spend"
      expr: SUM(CAST(total_freight_spend AS DOUBLE))
      comment: "Total freight spend across all evaluated carrier performance records. Core cost metric for logistics budget management."
    - name: "avg_cost_per_shipment"
      expr: AVG(CAST(average_cost_per_shipment AS DOUBLE))
      comment: "Average cost per shipment. Benchmarked against contracted rates to identify billing discrepancies and cost optimization opportunities."
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite carrier scorecard score. Used to rank carriers and determine preferred carrier status."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage set for carriers. Compared against actual OTIF to measure gap to SLA."
    - name: "avg_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate. Low accuracy drives audit costs and payment delays."
    - name: "avg_edi_compliance_rate_pct"
      expr: AVG(CAST(edi_compliance_rate_pct AS DOUBLE))
      comment: "Average EDI compliance rate. Measures carrier digital integration maturity, impacting automation and visibility."
    - name: "avg_pod_compliance_rate_pct"
      expr: AVG(CAST(pod_compliance_rate_pct AS DOUBLE))
      comment: "Average proof-of-delivery compliance rate. Critical for dispute resolution and customer billing accuracy."
    - name: "total_claims_amount"
      expr: SUM(CAST(total_claims_amount AS DOUBLE))
      comment: "Total value of freight claims filed. Directly impacts logistics cost and carrier liability exposure."
    - name: "carrier_scorecard_count"
      expr: COUNT(1)
      comment: "Number of carrier performance scorecard records. Used to assess coverage and completeness of carrier evaluation program."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_cold_chain_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold chain compliance and temperature excursion metrics. Used by quality assurance and logistics teams to manage product integrity, regulatory compliance, and cold chain risk."
  source: "`vibe_consumer_goods_v1`.`logistics`.`cold_chain_log`"
  dimensions:
    - name: "cold_chain_log_status"
      expr: cold_chain_log_status
      comment: "Status of the cold chain monitoring log record."
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of temperature excursion (e.g. high temp, low temp, humidity). Used to classify cold chain failures."
    - name: "excursion_severity"
      expr: excursion_severity
      comment: "Severity level of the temperature excursion (e.g. minor, major, critical). Drives QA disposition decisions."
    - name: "product_temperature_class"
      expr: product_temperature_class
      comment: "Temperature class of the product being monitored (e.g. frozen, chilled, ambient)."
    - name: "transport_unit_type"
      expr: transport_unit_type
      comment: "Type of transport unit used (e.g. reefer truck, refrigerated container)."
    - name: "qa_disposition"
      expr: qa_disposition
      comment: "QA disposition decision for excursion events (e.g. accept, reject, quarantine)."
    - name: "log_timestamp_month"
      expr: DATE_TRUNC('month', log_timestamp)
      comment: "Month bucket of log timestamp for cold chain excursion trend analysis."
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Flag indicating whether a regulatory report is required for this cold chain event."
  measures:
    - name: "total_excursion_events"
      expr: SUM(CASE WHEN excursion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total count of temperature excursion events. Primary cold chain quality KPI — high counts trigger carrier and process reviews."
    - name: "alert_triggered_count"
      expr: SUM(CASE WHEN alert_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cold chain alerts triggered. Measures real-time monitoring effectiveness and response rate."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average recorded temperature in Celsius. Used to assess whether shipments are maintained within required temperature bands."
    - name: "avg_mean_kinetic_temp_c"
      expr: AVG(CAST(mean_kinetic_temp_c AS DOUBLE))
      comment: "Average mean kinetic temperature. Regulatory-grade metric for assessing cumulative thermal exposure of temperature-sensitive products."
    - name: "avg_humidity_pct"
      expr: AVG(CAST(humidity_pct AS DOUBLE))
      comment: "Average humidity percentage recorded. Used to assess humidity compliance for moisture-sensitive products."
    - name: "regulatory_report_required_count"
      expr: SUM(CASE WHEN regulatory_report_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cold chain events requiring regulatory reporting. Measures regulatory compliance exposure."
    - name: "avg_sensor_battery_pct"
      expr: AVG(CAST(sensor_battery_pct AS DOUBLE))
      comment: "Average sensor battery level. Low battery levels indicate monitoring gaps and data integrity risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_consolidation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment consolidation efficiency metrics covering capacity utilization, cost savings, and volume. Used by logistics planners to maximize load consolidation and reduce per-unit freight costs."
  source: "`vibe_consumer_goods_v1`.`logistics`.`consolidation`"
  dimensions:
    - name: "consolidation_status"
      expr: consolidation_status
      comment: "Current status of the consolidation (e.g. planned, in-progress, completed, cancelled)."
    - name: "consolidation_type"
      expr: consolidation_type
      comment: "Type of consolidation (e.g. LTL-to-FTL, cross-dock, milk run)."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport for the consolidated shipment."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating whether the consolidation involves cold chain shipments."
    - name: "consolidation_date_month"
      expr: DATE_TRUNC('month', consolidation_date)
      comment: "Month bucket of consolidation date for volume and savings trend analysis."
    - name: "optimization_method"
      expr: optimization_method
      comment: "Method used to optimize the consolidation (e.g. weight-based, volume-based, route-based)."
  measures:
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_pct AS DOUBLE))
      comment: "Average load capacity utilization percentage. Low utilization indicates consolidation inefficiency and cost optimization opportunity."
    - name: "total_cost_savings_amount"
      expr: SUM(CAST(cost_savings_amount AS DOUBLE))
      comment: "Total cost savings achieved through consolidation. Directly measures ROI of the consolidation program."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight consolidated in kilograms. Used to measure consolidation throughput and carrier rate optimization."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume consolidated in cubic meters. Used for load planning and capacity utilization analysis."
    - name: "total_consolidation_cost"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of consolidation operations. Used to assess net savings after consolidation handling costs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs clearance and trade compliance metrics covering duty costs, clearance cycle times, inspection rates, and declaration accuracy. Used by trade compliance and logistics teams to manage cross-border risk."
  source: "`vibe_consumer_goods_v1`.`logistics`.`customs_declaration`"
  dimensions:
    - name: "customs_declaration_status"
      expr: customs_declaration_status
      comment: "Current status of the customs declaration (e.g. filed, cleared, held, rejected)."
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (e.g. import, export, transit, re-export)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the declared shipment."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code. Used for country-level trade compliance and duty cost analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin code. Used for rules-of-origin compliance and preferential duty rate eligibility."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Customs inspection status (e.g. not required, pending, completed, failed)."
    - name: "trade_agreement_code"
      expr: trade_agreement_code
      comment: "Trade agreement applied to the declaration (e.g. USMCA, EU-UK TCA). Used to track preferential duty utilization."
    - name: "declaration_date_month"
      expr: DATE_TRUNC('month', declaration_date)
      comment: "Month bucket of declaration date for trade volume and duty cost trending."
    - name: "free_trade_zone_flag"
      expr: free_trade_zone_flag
      comment: "Flag indicating whether the shipment moves through a free trade zone."
  measures:
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty paid. Primary trade compliance cost metric for import cost management and FTA optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on customs declarations. Used for landed cost calculation and tax compliance reporting."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared customs value. Used for duty base validation and trade statistics reporting."
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_pct AS DOUBLE))
      comment: "Average effective duty rate. Used to benchmark duty burden and identify FTA optimization opportunities."
    - name: "inspection_required_count"
      expr: SUM(CASE WHEN inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of declarations requiring customs inspection. High inspection rates signal compliance risk and clearance delays."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of declared shipments. Used for customs valuation validation and freight cost reconciliation."
    - name: "hazmat_declaration_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customs declarations involving hazardous materials. Measures regulatory compliance exposure for dangerous goods."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile delivery performance metrics covering OTIF, delivery completeness, freight cost, and exception rates. Used by logistics operations and customer service to manage delivery SLAs."
  source: "`vibe_consumer_goods_v1`.`logistics`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. scheduled, in-transit, delivered, failed, returned)."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g. standard, express, DSD, cold chain)."
    - name: "delivery_uom"
      expr: delivery_uom
      comment: "Unit of measure for delivery quantities."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating whether cold chain management is required for this delivery."
    - name: "planned_delivery_date_month"
      expr: DATE_TRUNC('month', planned_delivery_date)
      comment: "Month bucket of planned delivery date for delivery performance trending."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month bucket of actual delivery date for on-time delivery trend analysis."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code for failed or delayed deliveries. Used to identify root causes and drive corrective action."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for delivery rejection. Used to reduce rejection rates and improve customer satisfaction."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of delivery records. Baseline volume metric for logistics capacity and route planning."
    - name: "otif_delivery_count"
      expr: SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries that were on-time and in-full. Numerator for OTIF rate calculation."
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN is_on_time = TRUE THEN 1 ELSE 0 END)
      comment: "Count of on-time deliveries. Used to compute on-time delivery rate and SLA compliance."
    - name: "in_full_delivery_count"
      expr: SUM(CASE WHEN is_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of in-full deliveries. Measures order completeness at point of delivery."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered. Used to measure fulfillment completeness and identify shortfall patterns."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered for delivery. Denominator for fill rate calculation."
    - name: "total_refused_quantity"
      expr: SUM(CAST(refused_quantity AS DOUBLE))
      comment: "Total quantity refused at delivery. High refusal rates signal quality or compliance issues."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost for deliveries. Used for last-mile cost management and carrier performance evaluation."
    - name: "signature_captured_count"
      expr: SUM(CASE WHEN signature_captured = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries with electronic signature captured. Measures POD compliance for billing and dispute resolution."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_audit_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight audit KPIs measuring invoice accuracy, billing discrepancies, dispute rates, and recovery amounts. Used by finance and logistics to control freight spend and enforce carrier contract compliance."
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_audit_result`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the freight audit (e.g. pending, completed, disputed, resolved)."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of freight audit performed (e.g. pre-payment, post-payment, spot audit)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the audited freight invoice."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Coded reason for the billing variance. Used to identify systemic carrier billing issues."
    - name: "discrepancy_category"
      expr: discrepancy_category
      comment: "Category of billing discrepancy (e.g. rate error, weight discrepancy, accessorial dispute)."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the audit finding (e.g. open, resolved, written-off)."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month bucket of invoice date for period-over-period audit trend analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for the audited shipment."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced by carriers. Baseline for audit recovery and variance analysis."
    - name: "total_contracted_rate_amount"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total amount expected per contracted rates. Used to compute billing variance against invoiced amounts."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total billing variance (invoiced minus contracted). Measures carrier overbilling exposure."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered through freight audit. Directly measures ROI of the freight audit program."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average billing variance percentage. Used to benchmark carrier invoice accuracy and set audit thresholds."
    - name: "dispute_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audit results with disputes filed. High dispute counts signal systemic carrier billing problems."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total freight cost accrual amount. Used for period-end financial close accuracy."
    - name: "total_actual_vs_standard_variance"
      expr: SUM(CAST(actual_vs_standard_variance AS DOUBLE))
      comment: "Total actual vs. standard cost variance across all audit results. Measures freight cost efficiency against budget."
    - name: "freight_audit_record_count"
      expr: COUNT(1)
      comment: "Total number of freight audit results. Measures audit program coverage and throughput."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight cost analytics covering total spend, cost variance, accessorial charges, and cost allocation. Used by finance and logistics teams to manage transportation budgets and identify savings."
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_cost`"
  dimensions:
    - name: "freight_cost_status"
      expr: freight_cost_status
      comment: "Processing status of the freight cost record (e.g. accrued, invoiced, paid, disputed)."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of freight cost (e.g. line haul, accessorial, fuel surcharge, detention)."
    - name: "cost_category"
      expr: cost_category
      comment: "Business category of the freight cost for P&L allocation and reporting."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport associated with the freight cost."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier associated with the freight cost."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing cost responsibility for the shipment."
    - name: "is_accessorial"
      expr: is_accessorial
      comment: "Flag indicating whether the cost is an accessorial charge (surcharge beyond base freight)."
    - name: "shipment_direction"
      expr: shipment_direction
      comment: "Direction of the shipment (inbound/outbound) for cost allocation analysis."
    - name: "cost_recognition_date_month"
      expr: DATE_TRUNC('month', cost_recognition_date)
      comment: "Month bucket of cost recognition date for period-over-period freight spend trending."
    - name: "accrual_flag"
      expr: accrual_flag
      comment: "Indicates whether the freight cost is an accrual vs. actual invoice. Used for period-end close accuracy."
  measures:
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total freight cost amount. Primary logistics spend metric for budget tracking and carrier contract management."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard (contracted) freight cost. Baseline for variance analysis against actual spend."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and standard freight cost. Positive variance signals overspend requiring investigation."
    - name: "avg_rate_per_kg"
      expr: AVG(CAST(rate_per_kg AS DOUBLE))
      comment: "Average freight rate per kilogram. Used to benchmark carrier pricing and negotiate rate reductions."
    - name: "avg_rate_per_km"
      expr: AVG(CAST(rate_per_km AS DOUBLE))
      comment: "Average freight rate per kilometer. Used for lane-level cost benchmarking and routing optimization."
    - name: "total_hazmat_surcharge"
      expr: SUM(CAST(hazmat_surcharge_amount AS DOUBLE))
      comment: "Total hazmat surcharge costs. Monitored to manage regulatory compliance cost exposure."
    - name: "total_cold_chain_premium"
      expr: SUM(CAST(cold_chain_premium_amount AS DOUBLE))
      comment: "Total cold chain premium costs. Used to assess temperature-controlled logistics cost burden."
    - name: "total_audit_discrepancy_amount"
      expr: SUM(CAST(audit_discrepancy_amount AS DOUBLE))
      comment: "Total freight audit discrepancy amount. Measures billing error exposure and recovery opportunity."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total chargeable weight in kilograms. Used to validate carrier billing and optimize load consolidation."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Used for capacity planning and volumetric rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics covering total invoiced amounts, payment status, disputes, and variance. Used by accounts payable and logistics finance to manage carrier payment cycles and cost control."
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "freight_invoice_status"
      expr: freight_invoice_status
      comment: "Current processing status of the freight invoice (e.g. received, audited, approved, paid, disputed)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of freight invoice (e.g. standard, credit note, accessorial, fuel surcharge)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the invoiced freight service."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g. unpaid, paid, overdue, disputed)."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the carrier (e.g. Net 30, Net 60)."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month bucket of invoice date for period-over-period freight payables trending."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating whether the invoice covers cold chain services."
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the freight invoice (e.g. pending audit, audited, exception)."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_total_amount AS DOUBLE))
      comment: "Total amount invoiced by carriers. Primary freight payables metric for cash flow and budget management."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved invoice amount after audit. Measures the portion of invoices cleared for payment."
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted freight amount. Baseline for invoice variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between invoiced and contracted amounts. Measures carrier overbilling exposure."
    - name: "total_fuel_surcharge_amount"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge billed. Monitored to manage fuel cost exposure and validate surcharge calculations."
    - name: "total_accessorial_amount"
      expr: SUM(CAST(accessorial_amount AS DOUBLE))
      comment: "Total accessorial charges billed. High accessorial spend signals operational inefficiencies (detention, re-delivery)."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on freight invoices. Used for tax compliance and cost allocation."
    - name: "dispute_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed freight invoices. High dispute counts indicate carrier billing quality issues."
    - name: "total_line_haul_amount"
      expr: SUM(CAST(line_haul_amount AS DOUBLE))
      comment: "Total line haul freight charges. Core freight cost component for carrier rate benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order management metrics covering order volume, cost, tender performance, and service level compliance. Used by logistics procurement and operations to manage carrier capacity and freight spend."
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order (e.g. tendered, accepted, in-transit, delivered, cancelled)."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport for the freight order."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier for the freight order."
    - name: "load_type"
      expr: load_type
      comment: "Load type (e.g. FTL, LTL, parcel, intermodal). Used for cost benchmarking and mode optimization."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing trade terms for the freight order."
    - name: "tender_status"
      expr: tender_status
      comment: "Tender status of the freight order (e.g. tendered, accepted, rejected, spot). Used to measure routing guide compliance."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating whether the freight order requires cold chain management."
    - name: "requested_pickup_date_month"
      expr: DATE_TRUNC('month', requested_pickup_date)
      comment: "Month bucket of requested pickup date for freight order volume trending."
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders. Baseline volume metric for logistics capacity planning and carrier allocation."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated freight cost across orders. Used for budget forecasting and carrier rate benchmarking."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual freight cost incurred. Compared against estimated cost to measure freight cost accuracy."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge on freight orders. Monitored to manage fuel cost exposure."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges on freight orders. High accessorial spend signals operational inefficiencies."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total freight weight in kilograms. Used for carrier rate negotiation and capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total freight volume in cubic meters. Used for load planning and mode optimization."
    - name: "pod_received_count"
      expr: SUM(CASE WHEN pod_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of freight orders with proof of delivery received. Measures documentation compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics lane network metrics covering transit time, cost benchmarks, carbon emissions, and lane utilization. Used by network design and transportation teams to optimize the logistics network and reduce cost and emissions."
  source: "`vibe_consumer_goods_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_status"
      expr: lane_status
      comment: "Status of the lane (Active, Inactive, Under Review) for network coverage management."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of lane (Primary, Backup, Spot) for routing guide hierarchy analysis."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transport mode for modal network analysis and optimization."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for cross-border lane analysis and customs planning."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane and import/export analysis."
    - name: "cross_border"
      expr: cross_border
      comment: "Cross-border flag for international lane compliance and cost analysis."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Cold chain requirement for temperature-controlled lane capacity planning."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type for capacity and rate analysis by equipment class."
    - name: "service_level"
      expr: service_level
      comment: "Service level for cost-vs-service network design analysis."
    - name: "network_region"
      expr: network_region
      comment: "Network region for regional lane performance and cost benchmarking."
  measures:
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Total number of logistics lanes. Baseline for network coverage and routing guide completeness."
    - name: "avg_transit_time_days"
      expr: AVG(CAST(transit_time_days AS DOUBLE))
      comment: "Average transit time in days across lanes. Key network design metric; longer transit times increase inventory carrying costs."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average lane distance in kilometers. Used for carbon emission calculation and rate benchmarking."
    - name: "total_annual_volume_weight_kg"
      expr: SUM(CAST(annual_volume_weight_kg AS DOUBLE))
      comment: "Total annual volume weight across lanes. Measures network throughput for capacity planning and carrier volume commitments."
    - name: "avg_benchmark_rate_per_km"
      expr: AVG(CAST(benchmark_rate_per_km AS DOUBLE))
      comment: "Average benchmark freight rate per kilometer. Used to identify lanes with above-market rates for renegotiation."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage across lanes. Sets performance expectations for carrier SLA management."
    - name: "avg_co2_per_shipment_kg"
      expr: AVG(CAST(co2_per_shipment_kg AS DOUBLE))
      comment: "Average CO2 emissions per shipment by lane. Sustainability KPI for carbon footprint reduction and green logistics initiatives."
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Average carbon emission factor per lane. Used for Scope 3 emissions reporting and modal shift decisions."
    - name: "cold_chain_lane_count"
      expr: COUNT(CASE WHEN cold_chain_required = TRUE THEN 1 END)
      comment: "Number of lanes requiring cold chain capability. Tracks temperature-controlled network coverage for product range planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "End-to-end shipment performance metrics covering OTIF, freight cost, cold chain compliance, and shipment volume. Core operational KPI view for logistics directors and supply chain VPs."
  source: "`vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`"
  dimensions:
    - name: "logistics_shipment_status"
      expr: logistics_shipment_status
      comment: "Current status of the shipment (e.g. in-transit, delivered, exception, cancelled)."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transport mode used for the shipment (e.g. road, rail, air, ocean)."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier for the shipment (e.g. standard, express, priority)."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Classification of the shipment (e.g. outbound, inbound, transfer, DSD)."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing trade terms and risk transfer for the shipment."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating whether the shipment requires cold chain management."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating whether the shipment contains hazardous materials."
    - name: "planned_ship_date_month"
      expr: DATE_TRUNC('month', planned_ship_date)
      comment: "Month bucket of planned ship date for trend and seasonality analysis."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month bucket of actual delivery date for delivery performance trending."
    - name: "priority_level"
      expr: priority_level
      comment: "Shipment priority level (e.g. high, medium, low) for triage and escalation analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline volume metric for logistics capacity planning and throughput analysis."
    - name: "otif_shipment_count"
      expr: SUM(CASE WHEN otif_on_time = TRUE AND otif_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments that were both on-time and in-full. Numerator for OTIF rate calculation."
    - name: "on_time_shipment_count"
      expr: SUM(CASE WHEN otif_on_time = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on time. Used to compute on-time delivery rate."
    - name: "in_full_shipment_count"
      expr: SUM(CASE WHEN otif_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered in full. Used to compute in-full delivery rate."
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments. Primary logistics cost metric for budget management and carrier negotiation."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarked against contracted rates to identify cost efficiency opportunities."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms. Used for capacity planning, carrier rate negotiation, and carbon footprint calculation."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Used for load planning and transport utilization analysis."
    - name: "fuel_surcharge_total"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge costs across shipments. Monitored to assess exposure to fuel price volatility."
    - name: "pod_received_count"
      expr: SUM(CASE WHEN pod_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments with proof of delivery received. Measures documentation compliance for billing and dispute resolution."
    - name: "cold_chain_shipment_count"
      expr: SUM(CASE WHEN is_cold_chain = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cold chain shipments. Used to manage temperature-controlled capacity and compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route efficiency and utilization metrics covering distance, duration, capacity utilization, fuel consumption, and CO2 emissions. Used by logistics planners to optimize routing and reduce transportation costs."
  source: "`vibe_consumer_goods_v1`.`logistics`.`route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the route (e.g. planned, in-progress, completed, cancelled)."
    - name: "route_type"
      expr: route_type
      comment: "Type of route (e.g. DSD, inter-DC transfer, customer delivery, milk run)."
    - name: "is_dsd"
      expr: is_dsd
      comment: "Flag indicating whether the route is a Direct Store Delivery route."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating whether the route requires cold chain management."
    - name: "route_date_month"
      expr: DATE_TRUNC('month', route_date)
      comment: "Month bucket of route date for route volume and efficiency trending."
    - name: "optimization_method"
      expr: optimization_method
      comment: "Optimization algorithm or method used for route planning. Used to evaluate routing technology effectiveness."
  measures:
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_pct AS DOUBLE))
      comment: "Average vehicle capacity utilization percentage. Low utilization indicates consolidation opportunities and cost inefficiency."
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(co2_emissions_kg AS DOUBLE))
      comment: "Total CO2 emissions from routes in kilograms. Core sustainability KPI for logistics carbon footprint reporting."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across routes. Used for fuel cost management and emissions reduction planning."
    - name: "avg_actual_distance_km"
      expr: AVG(CAST(actual_distance_km AS DOUBLE))
      comment: "Average actual route distance in kilometers. Compared against planned distance to measure routing efficiency."
    - name: "avg_planned_distance_km"
      expr: AVG(CAST(planned_distance_km AS DOUBLE))
      comment: "Average planned route distance in kilometers. Baseline for route efficiency variance analysis."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual route duration in hours. Used to assess driver productivity and route feasibility."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across routes. Used for route-level cost management and carrier rate validation."
    - name: "otif_compliant_route_count"
      expr: SUM(CASE WHEN otif_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of routes that met OTIF compliance. Used to measure route-level service level performance."
    - name: "avg_vehicle_capacity_utilization_pct"
      expr: AVG(CAST(vehicle_capacity_utilization_pct AS DOUBLE))
      comment: "Average vehicle capacity utilization percentage from the vehicle perspective. Used for fleet right-sizing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-leg shipment performance metrics covering transit time adherence, leg-level freight cost, carbon emissions, and cold chain compliance. Used by transportation managers to optimize multi-modal routing and identify leg-level inefficiencies."
  source: "`vibe_consumer_goods_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "shipment_leg_status"
      expr: shipment_leg_status
      comment: "Status of the shipment leg (In Transit, Completed, Delayed) for leg-level operational monitoring."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transport mode for this leg for multi-modal cost and performance analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (operational field) for detailed leg routing analysis."
    - name: "leg_type"
      expr: leg_type
      comment: "Type of leg (First Mile, Middle Mile, Last Mile) for supply chain stage performance analysis."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Cold chain flag for temperature-controlled leg compliance tracking."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Hazmat flag for regulatory compliance cost tracking by leg."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for cross-border leg analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane leg performance analysis."
    - name: "freight_audit_status"
      expr: freight_audit_status
      comment: "Freight audit status for leg-level invoice accuracy monitoring."
  measures:
    - name: "total_shipment_legs"
      expr: COUNT(1)
      comment: "Total number of shipment legs. Baseline for multi-modal routing complexity and network analysis."
    - name: "total_leg_cost_amount"
      expr: SUM(CAST(leg_cost_amount AS DOUBLE))
      comment: "Total cost across all shipment legs. Enables leg-level cost attribution for multi-modal cost optimization."
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours per leg. Measures leg-level speed performance for transit time optimization."
    - name: "avg_planned_transit_hours"
      expr: AVG(CAST(planned_transit_hours AS DOUBLE))
      comment: "Average planned transit time in hours per leg. Baseline for transit time variance and planning accuracy analysis."
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions across shipment legs. Scope 3 emissions metric for modal shift and carbon reduction decisions."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance across all shipment legs. Network distance metric for cost-per-km benchmarking and route optimization."
    - name: "total_freight_cost_amount"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across shipment legs. Leg-level cost metric for multi-modal cost allocation and optimization."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight across shipment legs. Volume metric for capacity utilization and rate benchmarking by leg."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_tracking_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment tracking event analytics covering exception rates, temperature breaches, SLA compliance, and event velocity. Used by logistics operations to monitor real-time shipment visibility and proactively manage exceptions."
  source: "`vibe_consumer_goods_v1`.`logistics`.`tracking_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of tracking event (Pickup, In Transit, Delivered, Exception) for shipment milestone analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the tracking event for operational monitoring and exception triage."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for modal tracking performance analysis."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flag for exception events for exception rate calculation and trend monitoring."
    - name: "temperature_breach"
      expr: temperature_breach
      comment: "Temperature breach flag for cold chain compliance monitoring."
    - name: "carrier_sla_met"
      expr: carrier_sla_met
      comment: "Flag indicating whether carrier SLA was met for performance accountability."
    - name: "event_country_code"
      expr: event_country_code
      comment: "Country where the event occurred for geographic exception analysis."
    - name: "status_category"
      expr: status_category
      comment: "High-level status category for executive-level shipment status reporting."
  measures:
    - name: "total_tracking_events"
      expr: COUNT(1)
      comment: "Total number of tracking events. Baseline for shipment visibility coverage and data completeness assessment."
    - name: "exception_event_count"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN 1 END)
      comment: "Number of exception tracking events. Measures disruption frequency; high counts trigger carrier and lane reviews."
    - name: "temperature_breach_event_count"
      expr: COUNT(CASE WHEN temperature_breach = TRUE THEN 1 END)
      comment: "Number of temperature breach events. Critical cold chain KPI for product safety and regulatory compliance."
    - name: "sla_met_event_count"
      expr: COUNT(CASE WHEN carrier_sla_met = TRUE THEN 1 END)
      comment: "Number of events where carrier SLA was met. Used to compute carrier SLA compliance rate for contract management."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of tracking events. Quantifies cost of exceptions and disruptions for P&L impact reporting."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded at tracking events. Monitors cold chain integrity across the shipment journey."
    - name: "avg_speed_kmh"
      expr: AVG(CAST(speed_kmh AS DOUBLE))
      comment: "Average vehicle speed at tracking events. Used for route compliance and driver performance monitoring."
    - name: "distinct_shipments_tracked"
      expr: COUNT(DISTINCT logistics_shipment_id)
      comment: "Number of distinct shipments with tracking events. Measures shipment visibility coverage across the logistics network."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_transport_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport exception and disruption metrics covering exception frequency, financial impact, resolution rates, and root cause analysis. Used by logistics operations to reduce disruptions and manage carrier SLA compliance."
  source: "`vibe_consumer_goods_v1`.`logistics`.`transport_exception`"
  dimensions:
    - name: "transport_exception_status"
      expr: transport_exception_status
      comment: "Current status of the transport exception (e.g. open, in-progress, resolved, escalated)."
    - name: "exception_type"
      expr: exception_type
      comment: "Type of transport exception (e.g. delay, damage, lost shipment, customs hold)."
    - name: "exception_category"
      expr: exception_category
      comment: "Business category of the exception for root cause analysis and corrective action prioritization."
    - name: "exception_severity"
      expr: exception_severity
      comment: "Severity level of the exception (e.g. low, medium, high, critical). Drives escalation and response prioritization."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the exception. Used to identify systemic issues and drive process improvements."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport associated with the exception."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the exception (e.g. open, resolved, escalated, written-off)."
    - name: "exception_timestamp_month"
      expr: DATE_TRUNC('month', exception_timestamp)
      comment: "Month bucket of exception timestamp for exception trend and seasonality analysis."
    - name: "otif_impact_flag"
      expr: otif_impact_flag
      comment: "Flag indicating whether the exception impacted OTIF performance. Used to quantify exception impact on service levels."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of transport exceptions. Baseline disruption metric for logistics reliability assessment."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of transport exceptions. Directly measures cost of logistics disruptions for executive reporting."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total freight claim amount from transport exceptions. Measures carrier liability exposure and recovery opportunity."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of exceptions including remediation costs. Used for exception cost management and carrier penalty calculation."
    - name: "avg_delay_duration_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration in hours. Used to assess severity of transit disruptions and SLA breach impact."
    - name: "otif_impacting_exception_count"
      expr: SUM(CASE WHEN otif_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exceptions that impacted OTIF performance. Measures the service level consequence of transport disruptions."
    - name: "cold_chain_breach_count"
      expr: SUM(CASE WHEN cold_chain_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cold chain breach exceptions. Critical quality and regulatory risk metric for temperature-sensitive products."
    - name: "escalated_exception_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated exceptions. High escalation rates indicate systemic carrier or process failures requiring leadership intervention."
    - name: "hazmat_exception_count"
      expr: SUM(CASE WHEN hazmat_involved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exceptions involving hazardous materials. Measures regulatory compliance risk and safety exposure."
$$;
