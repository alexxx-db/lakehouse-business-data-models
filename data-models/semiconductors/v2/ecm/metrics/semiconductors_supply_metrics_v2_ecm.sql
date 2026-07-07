-- Metric views for domain: supply | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_approved_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved vendor list (AVL) metrics covering vendor quality, risk, and compliance for strategic sourcing governance."
  source: "`vibe_semiconductors_v1`.`supply`.`approved_vendor`"
  dimensions:
    - name: "approved_vendor_status"
      expr: approved_vendor_status
      comment: "Current status of the approved vendor (active, suspended, expired, under review)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for vendor qualification governance."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (distributor, manufacturer, broker) for sourcing channel analysis."
    - name: "quality_tier"
      expr: quality_tier
      comment: "Quality tier assigned to the vendor for differentiated management."
    - name: "financial_rating"
      expr: financial_rating
      comment: "Financial health rating of the approved vendor."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status of the vendor."
    - name: "country_code"
      expr: country_code
      comment: "Country of the approved vendor for geographic concentration analysis."
    - name: "approved_commodity_scope"
      expr: approved_commodity_scope
      comment: "Commodity scope for which the vendor is approved, enabling coverage gap analysis."
  measures:
    - name: "total_approved_vendors"
      expr: COUNT(DISTINCT approved_vendor_id)
      comment: "Total number of approved vendors. Measures AVL coverage for sourcing flexibility."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across approved vendors. Primary AVL quality governance KPI."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across approved vendors. Drives risk-based vendor management and dual-sourcing decisions."
    - name: "active_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN approved_vendor_status = 'Active' THEN approved_vendor_id END)
      comment: "Number of currently active approved vendors. Measures effective sourcing coverage."
    - name: "high_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN risk_score >= 70 THEN approved_vendor_id END)
      comment: "Number of approved vendors with high risk scores. Triggers vendor review and alternative sourcing actions."
    - name: "suspended_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN approved_vendor_status = 'Suspended' THEN approved_vendor_id END)
      comment: "Number of suspended approved vendors. Measures AVL attrition and sourcing risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_consignment_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consignment agreement metrics covering stock levels, value at risk, and agreement compliance for consignment inventory management."
  source: "`vibe_semiconductors_v1`.`supply`.`consignment_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the consignment agreement (active, expired, terminated)."
    - name: "consignment_agreement_status"
      expr: consignment_agreement_status
      comment: "Consignment agreement lifecycle status from source system."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of consignment agreement for portfolio classification."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the consignment agreement."
    - name: "currency_code"
      expr: currency_code
      comment: "Agreement currency for multi-currency portfolio analysis."
    - name: "ownership_transfer_trigger"
      expr: ownership_transfer_trigger
      comment: "Trigger event for ownership transfer (consumption, shipment, invoice) for financial accounting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the consignment agreement for supply risk management."
  measures:
    - name: "total_consignment_agreements"
      expr: COUNT(DISTINCT consignment_agreement_id)
      comment: "Total number of consignment agreements. Measures consignment program coverage."
    - name: "total_consignment_quantity"
      expr: SUM(CAST(consignment_quantity AS DOUBLE))
      comment: "Total consignment stock quantity across all agreements. Measures consignment inventory volume."
    - name: "total_max_consignment_value"
      expr: SUM(CAST(max_consignment_value AS DOUBLE))
      comment: "Total maximum consignment value across agreements. Measures maximum financial exposure from consignment inventory."
    - name: "total_max_stock_level"
      expr: SUM(CAST(max_stock_level AS DOUBLE))
      comment: "Total maximum stock level across consignment agreements. Informs warehouse capacity planning."
    - name: "total_min_stock_level"
      expr: SUM(CAST(min_stock_level AS DOUBLE))
      comment: "Total minimum stock level across agreements. Measures minimum supply buffer commitment."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit in consignment agreements. Tracks consignment pricing trends."
    - name: "total_agreement_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of all consignment agreements. Measures total consignment program financial commitment."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN consignment_agreement_id END)
      comment: "Number of active consignment agreements. Measures current consignment program utilization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_disruption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain disruption impact metrics for risk management and business continuity planning"
  source: "`vibe_semiconductors_v1`.`supply`.`disruption_event`"
  dimensions:
    - name: "disruption_number"
      expr: disruption_number
      comment: "Unique disruption event identifier"
    - name: "disruption_type"
      expr: disruption_type
      comment: "Category of disruption event"
    - name: "disruption_category"
      expr: disruption_category
      comment: "Classification of disruption"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of disruption"
    - name: "disruption_event_status"
      expr: disruption_event_status
      comment: "Current status of disruption event"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Management escalation level"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution progress status"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of disruption event"
    - name: "event_quarter"
      expr: DATE_TRUNC('QUARTER', event_date)
      comment: "Quarter of disruption event"
  measures:
    - name: "total_disruption_events"
      expr: COUNT(DISTINCT disruption_event_id)
      comment: "Total count of supply disruption events for risk exposure tracking"
    - name: "total_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of disruptions for business impact assessment"
    - name: "avg_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per disruption event for risk quantification"
    - name: "total_impacted_po_quantity"
      expr: SUM(CAST(impacted_po_quantity AS DOUBLE))
      comment: "Total purchase order quantity impacted by disruptions for supply continuity planning"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of disruption events for prioritization"
    - name: "critical_disruption_count"
      expr: COUNT(DISTINCT CASE WHEN event_severity = 'Critical' THEN disruption_event_id END)
      comment: "Count of critical severity disruptions requiring immediate executive action"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_disruption_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply disruption event metrics tracking financial impact, severity, and resolution for supply chain resilience management."
  source: "`vibe_semiconductors_v1`.`supply`.`disruption_event`"
  dimensions:
    - name: "disruption_type"
      expr: disruption_type
      comment: "Type of supply disruption (natural disaster, geopolitical, quality, logistics, financial) for root cause analysis."
    - name: "disruption_category"
      expr: disruption_category
      comment: "Category of disruption for structured impact classification."
    - name: "disruption_event_status"
      expr: disruption_event_status
      comment: "Current status of the disruption event (active, contained, resolved)."
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of the disruption event for escalation and response prioritization."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached for the disruption event."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the disruption event."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of disruption resolution for lessons-learned and playbook development."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the disruption involves ITAR-controlled materials or technology."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Whether the disruption involves EAR-controlled items."
  measures:
    - name: "total_disruption_events"
      expr: COUNT(DISTINCT disruption_event_id)
      comment: "Total number of supply disruption events. Baseline supply chain resilience metric."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of supply disruptions. Primary executive KPI for supply chain risk quantification."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per disruption event. Benchmarks disruption severity for risk reserve planning."
    - name: "total_impacted_po_quantity"
      expr: SUM(CAST(impacted_po_quantity AS DOUBLE))
      comment: "Total purchase order quantity impacted by disruptions. Measures supply volume at risk."
    - name: "active_disruption_count"
      expr: COUNT(DISTINCT CASE WHEN disruption_event_status NOT IN ('Resolved','Closed') THEN disruption_event_id END)
      comment: "Number of currently active disruption events. Drives real-time supply continuity response."
    - name: "high_severity_disruption_count"
      expr: COUNT(DISTINCT CASE WHEN event_severity IN ('Critical','High') THEN disruption_event_id END)
      comment: "Number of high or critical severity disruptions. Triggers executive escalation and emergency sourcing actions."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across disruption events. Tracks supply chain risk exposure trend over time."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt quality, quantity accuracy, and compliance metrics for supplier delivery performance management."
  source: "`vibe_semiconductors_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (posted, blocked, reversed) for inbound flow tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of received goods (passed, failed, pending)."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of quality inspection for received materials."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality disposition of received goods (unrestricted, blocked, in-inspection)."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP/ERP movement type code for goods receipt classification."
    - name: "plant_code"
      expr: plant_code
      comment: "Receiving plant for geographic and site-level analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the receipt has compliance issues requiring resolution."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Inventory valuation type for financial accounting purposes."
  measures:
    - name: "total_receipts"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Total number of goods receipts. Baseline inbound supply volume metric."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received from suppliers. Measures inbound supply fulfillment volume."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection. Indicates usable inbound supply."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. Key supplier quality KPI driving corrective actions."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of goods received. Supports accounts payable and inventory valuation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods received after deductions. Used for inventory cost accounting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods receipts. Supports tax compliance and reporting."
    - name: "compliance_issue_receipt_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_flag = TRUE THEN goods_receipt_id END)
      comment: "Number of receipts with compliance flags. Triggers supplier compliance review and corrective action."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score at goods receipt. Monitors inbound supply risk trends."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_goods_receipt_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming material quality and receipt efficiency metrics for inventory and quality control"
  source: "`vibe_semiconductors_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_number"
      expr: receipt_number
      comment: "Goods receipt document number"
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality assessment result"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status"
    - name: "material_number"
      expr: material_number
      comment: "Material identifier"
    - name: "plant_code"
      expr: plant_code
      comment: "Receiving plant code"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year of goods receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt"
  measures:
    - name: "total_receipts"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Total count of goods receipts for receiving volume tracking"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of materials received for inventory planning"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection for yield analysis"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected for supplier quality management"
    - name: "total_receipt_value"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods received for financial reconciliation"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score of received materials for supply chain risk management"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_received AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected for supplier quality performance"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_inbound_logistics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment and logistics performance metrics for supply chain efficiency and cost management"
  source: "`vibe_semiconductors_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_number"
      expr: shipment_number
      comment: "Inbound shipment identifier"
    - name: "inbound_shipment_status"
      expr: inbound_shipment_status
      comment: "Current status of inbound shipment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms"
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin"
    - name: "destination_plant"
      expr: destination_plant
      comment: "Destination plant code"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Customs and regulatory compliance status"
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year of shipment"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month of shipment"
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(DISTINCT inbound_shipment_id)
      comment: "Total count of inbound shipments for logistics volume tracking"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total inbound freight cost for logistics cost optimization"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment for cost benchmarking"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms for capacity planning"
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters for space utilization"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average shipment risk score for supply chain risk management"
    - name: "on_time_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN actual_arrival_date <= expected_arrival_date THEN inbound_shipment_id END)
      comment: "Count of on-time shipments for delivery performance tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment logistics metrics covering freight cost, delivery performance, and compliance for supply chain visibility."
  source: "`vibe_semiconductors_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "inbound_shipment_status"
      expr: inbound_shipment_status
      comment: "Current status of the inbound shipment (in-transit, delivered, delayed, customs-hold)."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Shipment lifecycle status from the source system."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, sea, road, rail) for logistics cost and lead time analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms governing risk and cost transfer for logistics cost allocation."
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for geographic supply flow and trade compliance analysis."
    - name: "destination_plant"
      expr: destination_plant
      comment: "Receiving plant for site-level inbound logistics analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Customs and trade compliance status of the shipment."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the shipment contains ITAR-controlled items."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Whether the shipment contains EAR-controlled items."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether cold chain logistics are required, indicating specialty handling cost."
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(DISTINCT inbound_shipment_id)
      comment: "Total number of inbound shipments. Baseline inbound logistics volume metric."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total inbound freight cost. Primary logistics spend KPI for cost reduction initiatives."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarks logistics efficiency and carrier negotiation."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total inbound shipment weight in kilograms. Supports freight cost allocation and carrier capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total inbound shipment volume in cubic meters. Informs warehouse receiving capacity planning."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across inbound shipments. Monitors supply chain exposure from in-transit goods."
    - name: "delayed_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN inbound_shipment_status IN ('Delayed','On Hold') THEN inbound_shipment_id END)
      comment: "Number of delayed or held inbound shipments. Drives expediting decisions and production schedule adjustments."
    - name: "compliance_hold_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status NOT IN ('Compliant','Cleared') THEN inbound_shipment_id END)
      comment: "Number of shipments with compliance issues. Triggers trade compliance review and customs resolution."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_material_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material certification metrics tracking compliance, PCN impact, and certification validity for supply chain quality and regulatory management."
  source: "`vibe_semiconductors_v1`.`supply`.`material_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of material certification (RoHS, REACH, CoA, ITAR) for compliance program analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (valid, expired, pending, revoked)."
    - name: "material_certification_status"
      expr: material_certification_status
      comment: "Material certification lifecycle status from source system."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the material certification."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard the certification addresses (ISO, IEC, JEDEC, etc.)."
    - name: "pcn_change_type"
      expr: pcn_change_type
      comment: "Type of product change notification associated with the certification."
    - name: "pcn_requalification_decision"
      expr: pcn_requalification_decision
      comment: "Requalification decision triggered by PCN for supply continuity planning."
    - name: "pcn_customer_notification_required"
      expr: pcn_customer_notification_required
      comment: "Whether customer notification is required for PCN-related certification changes."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT material_certification_id)
      comment: "Total number of material certifications. Measures compliance documentation coverage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across material certifications. Informs compliance risk prioritization."
    - name: "avg_test_value"
      expr: AVG(CAST(test_value AS DOUBLE))
      comment: "Average test value from material certifications. Tracks material quality performance trends."
    - name: "expired_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Expired' THEN material_certification_id END)
      comment: "Number of expired material certifications. Triggers urgent renewal to avoid supply disruption and compliance violations."
    - name: "pcn_notification_required_count"
      expr: COUNT(DISTINCT CASE WHEN pcn_customer_notification_required = TRUE THEN material_certification_id END)
      comment: "Number of certifications requiring customer PCN notification. Drives customer communication and requalification program management."
    - name: "requalification_required_count"
      expr: COUNT(DISTINCT CASE WHEN pcn_requalification_decision = 'Required' THEN material_certification_id END)
      comment: "Number of certifications requiring requalification due to PCN. Measures qualification program workload and supply continuity risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material master metrics covering inventory parameters, compliance status, and cost for supply chain planning and regulatory management."
  source: "`vibe_semiconductors_v1`.`supply`.`material_master`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Material type (raw material, semi-finished, finished, service) for spend category analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group for commodity-level supply planning and spend analysis."
    - name: "material_master_status"
      expr: material_master_status
      comment: "Lifecycle status of the material master (active, discontinued, blocked)."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle status for end-of-life and last-time-buy planning."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (external, in-house, subcontracting) for make-vs-buy analysis."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Hazardous material flag for regulatory compliance and logistics planning."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status for EU regulatory compliance tracking."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for environmental regulatory compliance."
    - name: "tsca_compliant"
      expr: tsca_compliant
      comment: "TSCA compliance status for US chemical regulatory compliance."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection is required at goods receipt for quality control planning."
  measures:
    - name: "total_materials"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Total number of material master records. Measures material portfolio size for supply planning coverage."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all materials. Supports inventory valuation and cost accounting."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per material. Benchmarks material cost for should-cost analysis."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across all materials. Measures inventory buffer investment for supply risk mitigation."
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity across materials. Measures replenishment trigger volume for procurement planning."
    - name: "non_compliant_material_count"
      expr: COUNT(DISTINCT CASE WHEN reach_compliant = FALSE OR rohs_compliant = FALSE OR tsca_compliant = FALSE THEN material_master_id END)
      comment: "Number of materials with compliance gaps. Triggers regulatory remediation and supply substitution decisions."
    - name: "hazardous_material_count"
      expr: COUNT(DISTINCT CASE WHEN hazardous_flag = TRUE THEN material_master_id END)
      comment: "Number of hazardous materials in the portfolio. Informs regulatory compliance program scope and logistics planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_material_requirement_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP metrics covering demand coverage, net requirements, and planned order quantities for production supply planning."
  source: "`vibe_semiconductors_v1`.`supply`.`material_requirement_plan`"
  dimensions:
    - name: "material_requirement_plan_status"
      expr: material_requirement_plan_status
      comment: "Current MRP plan status (active, closed, exception) for planning cycle management."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (MRP, MPS, reorder point) for planning strategy analysis."
    - name: "mrp_status"
      expr: mrp_status
      comment: "MRP run status for planning execution monitoring."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for which the MRP plan is generated, enabling site-level supply planning."
    - name: "mrp_controller"
      expr: mrp_controller
      comment: "MRP controller responsible for the plan, enabling workload and performance analysis."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing procedure used in MRP calculation for procurement efficiency analysis."
    - name: "plan_period"
      expr: plan_period
      comment: "Planning period for time-horizon analysis of supply requirements."
    - name: "is_fixed_lot"
      expr: is_fixed_lot
      comment: "Whether fixed lot sizing is applied, affecting order frequency and inventory levels."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for MRP quantities."
  measures:
    - name: "total_gross_requirement"
      expr: SUM(CAST(gross_requirement AS DOUBLE))
      comment: "Total gross material requirement from MRP. Primary supply planning demand signal for procurement."
    - name: "total_net_requirement"
      expr: SUM(CAST(net_requirement AS DOUBLE))
      comment: "Total net material requirement after on-hand and safety stock. Drives planned order creation."
    - name: "total_planned_order_quantity"
      expr: SUM(CAST(planned_order_quantity AS DOUBLE))
      comment: "Total planned order quantity from MRP. Translates into purchase orders and production orders."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity in MRP. Measures inventory coverage against requirements."
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock AS DOUBLE))
      comment: "Total safety stock quantity planned. Measures supply buffer investment for risk mitigation."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned procurement cost from MRP. Supports procurement budget planning and approval."
    - name: "total_demand_quantity"
      expr: SUM(CAST(demand_quantity AS DOUBLE))
      comment: "Total demand quantity driving MRP calculations. Measures production demand volume for capacity planning."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total required quantity from MRP. Measures unfulfilled supply requirements for expediting decisions."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across materials. Benchmarks inventory replenishment trigger levels."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_material_requirement_planning`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material requirements planning metrics for inventory optimization and production planning"
  source: "`vibe_semiconductors_v1`.`supply`.`material_requirement_plan`"
  dimensions:
    - name: "material_number"
      expr: material_number
      comment: "Material identifier"
    - name: "mrp_status"
      expr: mrp_status
      comment: "MRP processing status"
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type"
    - name: "material_requirement_plan_status"
      expr: material_requirement_plan_status
      comment: "Overall MRP plan status"
    - name: "plant_code"
      expr: plant_code
      comment: "Planning plant code"
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing method used"
    - name: "plan_year"
      expr: YEAR(plan_date)
      comment: "Year of MRP plan"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month of MRP plan"
  measures:
    - name: "total_mrp_plans"
      expr: COUNT(DISTINCT material_requirement_plan_id)
      comment: "Total count of MRP plans for planning coverage tracking"
    - name: "total_gross_requirement"
      expr: SUM(CAST(gross_requirement AS DOUBLE))
      comment: "Total gross material requirement for demand planning"
    - name: "total_net_requirement"
      expr: SUM(CAST(net_requirement AS DOUBLE))
      comment: "Total net material requirement after inventory for procurement planning"
    - name: "total_planned_order_quantity"
      expr: SUM(CAST(planned_order_quantity AS DOUBLE))
      comment: "Total planned order quantity for supply planning"
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity for inventory optimization"
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock AS DOUBLE))
      comment: "Total safety stock quantity for buffer stock management"
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned procurement cost for budget planning"
    - name: "inventory_coverage_ratio"
      expr: ROUND(100.0 * SUM(CAST(on_hand_quantity AS DOUBLE)) / NULLIF(SUM(CAST(gross_requirement AS DOUBLE)), 0), 2)
      comment: "Percentage of gross requirement covered by on-hand inventory for stock adequacy"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_osat_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSAT (Outsourced Semiconductor Assembly and Test) work order metrics covering assembly cost, cycle time, and quality for packaging supply management."
  source: "`vibe_semiconductors_v1`.`supply`.`osat_work_order`"
  dimensions:
    - name: "osat_work_order_status"
      expr: osat_work_order_status
      comment: "Current status of the OSAT work order (open, in-progress, completed, cancelled)."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Work order status from source system for operational tracking."
    - name: "package_type"
      expr: package_type
      comment: "Package type (BGA, QFN, flip-chip, etc.) for assembly cost and yield analysis by package."
    - name: "service_type"
      expr: service_type
      comment: "Type of OSAT service (assembly, test, assembly+test) for cost allocation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the work order for procurement governance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the OSAT work order for export control tracking."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating of the OSAT vendor for this work order."
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order for scheduling and resource allocation."
    - name: "substrate_type"
      expr: substrate_type
      comment: "Substrate type used in assembly for material cost analysis."
  measures:
    - name: "total_osat_work_orders"
      expr: COUNT(DISTINCT osat_work_order_id)
      comment: "Total number of OSAT work orders. Baseline packaging outsourcing volume metric."
    - name: "total_assembly_cost"
      expr: SUM(CAST(total_assembly_cost AS DOUBLE))
      comment: "Total assembly cost across all OSAT work orders. Primary packaging cost KPI for margin management."
    - name: "avg_unit_assembly_cost"
      expr: AVG(CAST(unit_assembly_cost AS DOUBLE))
      comment: "Average unit assembly cost. Benchmarks OSAT pricing and drives vendor negotiation."
    - name: "total_nre_charge"
      expr: SUM(CAST(nre_charge AS DOUBLE))
      comment: "Total NRE charges from OSAT vendors. Tracks non-recurring engineering investment in packaging development."
    - name: "total_die_quantity"
      expr: SUM(CAST(die_quantity AS DOUBLE))
      comment: "Total die quantity across OSAT work orders. Measures packaging throughput volume."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score for OSAT work orders. Monitors vendor and supply risk in packaging operations."
    - name: "open_work_order_count"
      expr: COUNT(DISTINCT CASE WHEN osat_work_order_status NOT IN ('Completed','Cancelled','Closed') THEN osat_work_order_id END)
      comment: "Number of open OSAT work orders. Measures active packaging pipeline for capacity and delivery planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-level spend, receipt performance, and delivery compliance metrics for granular procurement analysis."
  source: "`vibe_semiconductors_v1`.`supply`.`po_line`"
  dimensions:
    - name: "po_line_status"
      expr: po_line_status
      comment: "Current status of the PO line (open, partially received, closed, cancelled)."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt status for the line, indicating delivery fulfillment progress."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for ordered quantity, enabling cross-material comparisons."
    - name: "plant"
      expr: plant
      comment: "Destination plant for the PO line, enabling site-level spend analysis."
    - name: "currency"
      expr: currency
      comment: "Currency of the PO line for multi-currency spend reporting."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms for the line item."
    - name: "account_assignment_type"
      expr: account_assignment_type
      comment: "Account assignment category (cost center, project, asset) for spend allocation."
    - name: "is_service_line"
      expr: is_service_line
      comment: "Distinguishes service lines from material lines for spend category analysis."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline for procurement workload and complexity measurement."
    - name: "total_line_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend value across all PO lines. Granular spend management KPI."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Drives supply planning and inventory forecasting."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines. Measures supplier delivery fulfillment."
    - name: "total_receipt_quantity"
      expr: SUM(CAST(receipt_quantity AS DOUBLE))
      comment: "Total quantity formally receipted in the system. Used for goods receipt reconciliation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value captured across PO lines. Quantifies negotiated savings."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across PO lines. Supports tax liability reporting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per PO line. Tracks price trends and supplier pricing consistency."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per PO line after discounts. Measures effective procurement cost."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_product_change_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product change notification (PCN) metrics tracking change impact, requalification requirements, and customer notification compliance."
  source: "`vibe_semiconductors_v1`.`supply`.`product_change_notification`"
  dimensions:
    - name: "pcn_status"
      expr: pcn_status
      comment: "Current PCN status (issued, acknowledged, under review, closed)."
    - name: "product_change_notification_status"
      expr: product_change_notification_status
      comment: "PCN lifecycle status from source system."
    - name: "change_type"
      expr: change_type
      comment: "Type of product change (process, material, design, packaging) for impact classification."
    - name: "change_category"
      expr: change_category
      comment: "Category of change for structured PCN portfolio analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of the PCN impact on customers and supply chain."
    - name: "requalification_status"
      expr: requalification_status
      comment: "Status of requalification triggered by the PCN."
    - name: "requalification_required"
      expr: requalification_required
      comment: "Whether requalification is required for the PCN."
    - name: "required_customer_notification"
      expr: required_customer_notification
      comment: "Whether customer notification is contractually required for this PCN."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether regulatory reporting is required for this PCN."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the PCN involves ITAR-controlled technology."
  measures:
    - name: "total_pcns"
      expr: COUNT(DISTINCT product_change_notification_id)
      comment: "Total number of product change notifications. Measures supply chain change management workload."
    - name: "open_pcn_count"
      expr: COUNT(DISTINCT CASE WHEN pcn_status NOT IN ('Closed','Completed') THEN product_change_notification_id END)
      comment: "Number of open PCNs requiring action. Drives change management prioritization and customer communication."
    - name: "requalification_required_count"
      expr: COUNT(DISTINCT CASE WHEN requalification_required = TRUE THEN product_change_notification_id END)
      comment: "Number of PCNs requiring requalification. Measures qualification program demand and supply continuity risk."
    - name: "customer_notification_required_count"
      expr: COUNT(DISTINCT CASE WHEN required_customer_notification = TRUE THEN product_change_notification_id END)
      comment: "Number of PCNs requiring customer notification. Drives customer communication program and contractual compliance."
    - name: "high_severity_pcn_count"
      expr: COUNT(DISTINCT CASE WHEN impact_severity IN ('Critical','High') THEN product_change_notification_id END)
      comment: "Number of high or critical severity PCNs. Triggers executive escalation and emergency supply planning."
    - name: "regulatory_reporting_pcn_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reporting_required = TRUE THEN product_change_notification_id END)
      comment: "Number of PCNs requiring regulatory reporting. Measures compliance program workload and regulatory risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order volume, value, and procurement cycle metrics for spend management and supplier performance tracking."
  source: "`vibe_semiconductors_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current status of the purchase order (open, closed, cancelled, pending approval)."
    - name: "purchase_order_type"
      expr: purchase_order_type
      comment: "Type of purchase order (standard, blanket, NRE, consignment) for spend categorization."
    - name: "po_type"
      expr: po_type
      comment: "PO type code from source system for detailed procurement classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalization."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant or site receiving the purchase order."
    - name: "purchase_group"
      expr: purchase_group
      comment: "Purchasing group responsible for the order, enabling buyer performance analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms governing risk transfer and logistics cost allocation."
    - name: "is_ear_controlled"
      expr: is_ear_controlled
      comment: "Flags purchase orders involving EAR-controlled items for compliance tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO for procurement governance monitoring."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Total number of distinct purchase orders. Baseline procurement volume metric."
    - name: "total_po_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net spend committed across all purchase orders. Primary spend management KPI."
    - name: "total_po_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross spend including taxes and freight. Used for full cost accounting."
    - name: "total_po_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders. Informs tax planning and compliance."
    - name: "avg_po_net_amount"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net value per purchase order. Benchmarks procurement transaction size."
    - name: "total_po_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units ordered across all purchase orders. Drives capacity and inventory planning."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across purchase orders. Tracks pricing trends and negotiation effectiveness."
    - name: "pending_approval_po_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status NOT IN ('Approved','Rejected') THEN purchase_order_id END)
      comment: "Number of POs awaiting approval. Identifies procurement bottlenecks and cycle time issues."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage achieved across purchase orders. Measures sourcing negotiation effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_purchase_order_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order execution metrics for procurement efficiency, spend analysis, and delivery performance"
  source: "`vibe_semiconductors_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_number"
      expr: po_number
      comment: "Purchase order number"
    - name: "po_status"
      expr: po_status
      comment: "Current status of purchase order"
    - name: "purchase_order_type"
      expr: purchase_order_type
      comment: "Type of purchase order (standard, blanket, contract)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "plant_code"
      expr: plant_code
      comment: "Destination plant for materials"
    - name: "purchasing_org"
      expr: purchasing_org
      comment: "Purchasing organization responsible for PO"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for delivery"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year of purchase order creation"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of purchase order creation"
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Total count of purchase orders for procurement volume tracking"
    - name: "total_po_value"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net purchase order value for spend analysis and budget tracking"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs for logistics cost optimization"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount for financial reporting and compliance"
    - name: "avg_po_value"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average purchase order value for procurement efficiency analysis"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured for supplier negotiation effectiveness"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk assessment metrics for proactive risk mitigation and business continuity"
  source: "`vibe_semiconductors_v1`.`supply`.`risk_assessment`"
  dimensions:
    - name: "assessment_code"
      expr: assessment_code
      comment: "Risk assessment identifier"
    - name: "assessment_name"
      expr: assessment_name
      comment: "Risk assessment name"
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk severity level"
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Status of risk assessment"
    - name: "impact_severity"
      expr: impact_severity
      comment: "Impact severity classification"
    - name: "mitigation_strategy"
      expr: mitigation_strategy
      comment: "Risk mitigation approach"
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Single source supplier risk flag"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of risk assessment"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(DISTINCT risk_assessment_id)
      comment: "Total count of risk assessments for risk management coverage"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score for overall supply chain risk exposure"
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average probability of risk occurrence for risk prioritization"
    - name: "high_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'High' THEN risk_assessment_id END)
      comment: "Count of high-risk assessments requiring immediate mitigation"
    - name: "single_source_risk_count"
      expr: COUNT(DISTINCT CASE WHEN single_source_flag = TRUE THEN risk_assessment_id END)
      comment: "Count of single-source supplier risks for dual-sourcing strategy"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk assessment metrics covering risk scores, probability, and mitigation status for executive supply risk management."
  source: "`vibe_semiconductors_v1`.`supply`.`risk_assessment`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of supply risk (geopolitical, financial, quality, logistics, single-source) for risk portfolio analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk severity level (critical, high, medium, low) for prioritized mitigation planning."
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Current status of the risk assessment (open, mitigated, closed, monitoring)."
    - name: "disruption_status"
      expr: disruption_status
      comment: "Status of any associated supply disruption event."
    - name: "disruption_event_type"
      expr: disruption_event_type
      comment: "Type of disruption event driving the risk assessment."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Identifies single-source supply risks requiring dual-sourcing strategy."
    - name: "geographic_risk"
      expr: geographic_risk
      comment: "Geographic risk classification for geopolitical concentration analysis."
    - name: "geopolitical_risk"
      expr: geopolitical_risk
      comment: "Geopolitical risk rating for strategic supply chain resilience planning."
    - name: "financial_risk"
      expr: financial_risk
      comment: "Financial risk classification for supplier solvency and credit risk monitoring."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(DISTINCT risk_assessment_id)
      comment: "Total number of active risk assessments. Measures supply risk program coverage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supply chain risk score. Primary executive KPI for supply chain resilience monitoring."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average probability of risk materialization. Drives risk prioritization and mitigation investment decisions."
    - name: "high_risk_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level IN ('Critical','High') THEN risk_assessment_id END)
      comment: "Number of high or critical risk assessments. Triggers executive escalation and supply continuity planning."
    - name: "single_source_risk_count"
      expr: COUNT(DISTINCT CASE WHEN single_source_flag = TRUE THEN risk_assessment_id END)
      comment: "Number of single-source supply risks. Drives dual-sourcing strategy and approved vendor expansion."
    - name: "open_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_assessment_status NOT IN ('Closed','Mitigated') THEN risk_assessment_id END)
      comment: "Number of open unmitigated risks. Key supply chain resilience KPI for leadership review."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_sourcing_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing contract portfolio metrics covering contract value, coverage, and compliance for strategic procurement governance."
  source: "`vibe_semiconductors_v1`.`supply`.`sourcing_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sourcing contract (framework, spot, long-term, NRE) for portfolio analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract lifecycle status (active, expired, under negotiation, terminated)."
    - name: "sourcing_contract_status"
      expr: sourcing_contract_status
      comment: "Sourcing contract status from source system."
    - name: "approval_status"
      expr: approval_status
      comment: "Contract approval workflow status for governance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency portfolio analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the contract auto-renews, affecting procurement continuity planning."
    - name: "rebate_tier"
      expr: rebate_tier
      comment: "Rebate tier applicable to the contract for savings tracking."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for spend category analysis and sourcing strategy alignment."
  measures:
    - name: "total_sourcing_contracts"
      expr: COUNT(DISTINCT sourcing_contract_id)
      comment: "Total number of sourcing contracts. Measures procurement contract coverage."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all sourcing contracts. Primary procurement spend under contract KPI."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average sourcing contract value. Benchmarks contract size for negotiation strategy."
    - name: "total_unit_price_value"
      expr: SUM(CAST(unit_price AS DOUBLE))
      comment: "Sum of contracted unit prices. Supports price benchmarking across the contract portfolio."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price. Tracks pricing trends and negotiation effectiveness."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total contracted target quantity. Measures volume commitment under contract for capacity planning."
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN sourcing_contract_id END)
      comment: "Number of active sourcing contracts. Measures current procurement coverage and contract utilization."
    - name: "expiring_contract_count"
      expr: COUNT(DISTINCT CASE WHEN sourcing_contract_status IN ('Expiring','Near Expiry') THEN sourcing_contract_id END)
      comment: "Number of contracts nearing expiry. Triggers contract renewal and renegotiation actions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_sourcing_contract_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing contract value and compliance metrics for strategic sourcing and contract management"
  source: "`vibe_semiconductors_v1`.`supply`.`sourcing_contract`"
  dimensions:
    - name: "contract_number"
      expr: contract_number
      comment: "Sourcing contract number"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sourcing contract"
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status"
    - name: "sourcing_contract_status"
      expr: sourcing_contract_status
      comment: "Sourcing contract lifecycle status"
    - name: "approval_status"
      expr: approval_status
      comment: "Contract approval status"
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Automatic renewal flag"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year contract became effective"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT sourcing_contract_id)
      comment: "Total count of sourcing contracts for contract portfolio management"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all sourcing contracts for spend under management"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value for contract size benchmarking"
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS BIGINT))
      comment: "Total target quantity across contracts for volume commitment tracking"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across contracts for price benchmarking"
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN sourcing_contract_id END)
      comment: "Count of active contracts for active contract portfolio size"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier portfolio health metrics covering risk, financial standing, and quality ratings across the approved supplier base."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classifies supplier by type (e.g., foundry, OSAT, chemical, gas) for portfolio segmentation."
    - name: "supplier_group"
      expr: supplier_group
      comment: "Supplier group or category for strategic sourcing analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of supplier headquarters for geographic concentration risk analysis."
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current lifecycle status of the supplier (active, blocked, under review)."
    - name: "financial_rating"
      expr: financial_rating
      comment: "External financial health rating of the supplier for credit and continuity risk."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality performance tier assigned to the supplier."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether the supplier handles ITAR-controlled materials or technology."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Indicates whether the supplier is subject to EAR export control regulations."
    - name: "is_certified_kga"
      expr: is_certified_kga
      comment: "Whether the supplier holds Known Good Assembly certification."
  measures:
    - name: "total_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total number of distinct suppliers in the portfolio. Baseline for supplier base sizing decisions."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supply risk score across all suppliers. Drives risk mitigation prioritization."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across suppliers. Informs ESG sourcing strategy."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all suppliers. Indicates financial exposure ceiling."
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_score >= 70 THEN supplier_id END)
      comment: "Number of suppliers with risk score >= 70. Triggers supply chain risk review and dual-sourcing decisions."
    - name: "itar_controlled_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled = TRUE THEN supplier_id END)
      comment: "Count of ITAR-controlled suppliers. Critical for export compliance program scoping."
    - name: "single_country_concentration_count"
      expr: COUNT(DISTINCT CASE WHEN country_code IS NOT NULL THEN supplier_id END)
      comment: "Count of suppliers with a known country code, used to assess geographic concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier performance metrics tracking quality, risk, and sustainability for vendor management decisions"
  source: "`vibe_semiconductors_v1`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_name"
      expr: supplier_name
      comment: "Legal name of the supplier"
    - name: "supplier_code"
      expr: supplier_code
      comment: "Unique supplier identifier code"
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of supplier (e.g., strategic, preferred, approved)"
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current operational status of supplier"
    - name: "country_code"
      expr: country_code
      comment: "Country where supplier is registered"
    - name: "financial_rating"
      expr: financial_rating
      comment: "Financial health rating of supplier"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality performance rating tier"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and policy compliance status"
    - name: "supplier_group"
      expr: supplier_group
      comment: "Supplier grouping for strategic segmentation"
    - name: "is_certified_kga"
      expr: is_certified_kga
      comment: "Known Good Assembly certification flag"
  measures:
    - name: "total_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total count of unique suppliers in the supply base"
    - name: "avg_supplier_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across suppliers for supply chain risk management"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score for ESG reporting and supplier selection"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit exposure across all suppliers for financial risk management"
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(risk_score AS DOUBLE) >= 70 THEN supplier_id END)
      comment: "Count of suppliers with high risk scores requiring mitigation action"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit program metrics covering audit scores, findings severity, and corrective action compliance for supply chain governance."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (quality, environmental, financial, security) for program coverage analysis."
    - name: "audit_category"
      expr: audit_category
      comment: "Audit category for detailed classification of audit scope."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, closed)."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit outcome (pass, fail, conditional pass) for supplier qualification decisions."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Qualitative overall rating from the audit for supplier tier management."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions required from audit findings."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome of the audit for regulatory and quality system tracking."
    - name: "supplier_audit_status"
      expr: supplier_audit_status
      comment: "Lifecycle status of the supplier audit record."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the audit covers ITAR-controlled processes or materials."
  measures:
    - name: "total_audits"
      expr: COUNT(DISTINCT supplier_audit_id)
      comment: "Total number of supplier audits conducted. Measures audit program coverage and cadence."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all supplier audits. Primary supplier quality governance KPI."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score. Used for supplier tier classification and sourcing decisions."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score from audits. Supports ESG supplier management programs."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from supplier audits. Drives risk-based audit frequency and mitigation planning."
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(audit_cost_usd AS DOUBLE))
      comment: "Total cost of supplier audit program. Informs audit budget planning and ROI assessment."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Benchmarks audit efficiency and resource planning."
    - name: "failed_audit_count"
      expr: COUNT(DISTINCT CASE WHEN audit_result = 'Fail' THEN supplier_audit_id END)
      comment: "Number of failed audits. Triggers supplier disqualification review and corrective action escalation."
    - name: "open_corrective_action_audit_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_status NOT IN ('Closed','Completed') THEN supplier_audit_id END)
      comment: "Audits with open corrective actions. Measures supplier compliance follow-through and program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_audit_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit and compliance metrics for quality assurance and regulatory adherence"
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_audit`"
  dimensions:
    - name: "audit_number"
      expr: audit_number
      comment: "Unique audit identifier"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted"
    - name: "audit_category"
      expr: audit_category
      comment: "Audit category classification"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of audit"
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit result"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance assessment status"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit"
    - name: "audit_quarter"
      expr: DATE_TRUNC('QUARTER', audit_date)
      comment: "Quarter of audit"
  measures:
    - name: "total_audits"
      expr: COUNT(DISTINCT supplier_audit_id)
      comment: "Total count of supplier audits for compliance program coverage"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score for supplier quality baseline assessment"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score for compliance performance tracking"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from audits for supplier risk management"
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost_usd AS DOUBLE))
      comment: "Total cost of audit program for budget management"
    - name: "avg_audit_duration"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours for resource planning"
    - name: "total_critical_findings"
      expr: SUM(CAST(findings_critical_count AS DOUBLE))
      comment: "Total count of critical findings requiring immediate corrective action"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score for ESG compliance tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier corrective action effectiveness metrics for quality improvement and supplier development"
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_corrective_action`"
  dimensions:
    - name: "car_number"
      expr: car_number
      comment: "Corrective action request number"
    - name: "scar_number"
      expr: scar_number
      comment: "Supplier corrective action request number"
    - name: "car_status"
      expr: car_status
      comment: "CAR status"
    - name: "supplier_corrective_action_status"
      expr: supplier_corrective_action_status
      comment: "Overall SCAR status"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Corrective action implementation status"
    - name: "preventive_action_status"
      expr: preventive_action_status
      comment: "Preventive action implementation status"
    - name: "severity"
      expr: severity
      comment: "Issue severity level"
    - name: "priority"
      expr: priority
      comment: "Action priority level"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of corrective action"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(DISTINCT supplier_corrective_action_id)
      comment: "Total count of supplier corrective actions for quality issue tracking"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions for budget planning"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions for cost impact analysis"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action for cost forecasting"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action for cost benchmarking"
    - name: "closed_action_count"
      expr: COUNT(DISTINCT CASE WHEN closure_date IS NOT NULL THEN supplier_corrective_action_id END)
      comment: "Count of closed corrective actions for closure rate tracking"
    - name: "verified_action_count"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN supplier_corrective_action_id END)
      comment: "Count of verified corrective actions for effectiveness validation"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification program metrics tracking qualification status, audit performance, and corrective action compliance for approved vendor management."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, conditional, disqualified, pending) for approved vendor list management."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (quality, environmental, financial, technical) for program scope analysis."
    - name: "qualification_program_type"
      expr: qualification_program_type
      comment: "Qualification program category for structured supplier development tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall qualification rating for supplier tier assignment."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from qualification findings."
    - name: "supplier_qualification_status"
      expr: supplier_qualification_status
      comment: "Lifecycle status of the qualification record."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted as part of qualification."
    - name: "findings_severity"
      expr: findings_severity
      comment: "Severity of qualification findings (critical, major, minor) for risk-based supplier management."
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT supplier_qualification_id)
      comment: "Total number of supplier qualifications. Measures approved vendor program coverage."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score from qualification assessments. Primary qualification quality KPI."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score at qualification. Informs supplier risk tier assignment."
    - name: "avg_qualification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average overall qualification score. Drives approved vendor list decisions."
    - name: "qualified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN supplier_qualification_id END)
      comment: "Number of qualified suppliers. Measures approved vendor base size for sourcing coverage."
    - name: "disqualified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Disqualified' THEN supplier_qualification_id END)
      comment: "Number of disqualified suppliers. Tracks supplier attrition and sourcing risk exposure."
    - name: "open_corrective_action_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_status NOT IN ('Closed','Completed') THEN supplier_qualification_id END)
      comment: "Qualifications with open corrective actions. Measures supplier compliance program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quotation metrics covering pricing competitiveness, evaluation scores, and award decisions for strategic sourcing effectiveness."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the supplier quotation (submitted, under evaluation, awarded, rejected)."
    - name: "supplier_quotation_status"
      expr: supplier_quotation_status
      comment: "Quotation lifecycle status from source system."
    - name: "award_decision"
      expr: award_decision
      comment: "Award decision outcome (awarded, not awarded, pending) for sourcing decision tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Quotation currency for multi-currency price comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quoted quantities."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for spend category analysis."
    - name: "is_ear_controlled"
      expr: is_ear_controlled
      comment: "Whether the quoted item is EAR-controlled for export compliance tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag on the quotation for regulatory tracking."
  measures:
    - name: "total_quotations"
      expr: COUNT(DISTINCT supplier_quotation_id)
      comment: "Total number of supplier quotations received. Measures sourcing market engagement."
    - name: "total_quoted_total_price"
      expr: SUM(CAST(quoted_total_price AS DOUBLE))
      comment: "Total quoted price across all quotations. Measures total sourcing market value assessed."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price. Benchmarks market pricing for negotiation and should-cost analysis."
    - name: "avg_award_price"
      expr: AVG(CAST(award_price AS DOUBLE))
      comment: "Average awarded price. Measures actual sourcing price achievement vs. quoted price."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average supplier evaluation score from quotation assessment. Measures supplier competitiveness."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount negotiated from quoted price. Measures sourcing negotiation effectiveness."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across quotations. Informs supplier selection risk-adjusted decision making."
    - name: "awarded_quotation_count"
      expr: COUNT(DISTINCT CASE WHEN award_decision = 'Awarded' THEN supplier_quotation_id END)
      comment: "Number of awarded quotations. Measures sourcing decision throughput and program completion rate."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality and performance scorecard metrics for vendor management and continuous improvement"
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "scorecard_period"
      expr: scorecard_period
      comment: "Performance measurement period"
    - name: "scorecard_type"
      expr: scorecard_type
      comment: "Type of scorecard assessment"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall supplier performance rating"
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic importance tier of supplier"
    - name: "supplier_scorecard_status"
      expr: supplier_scorecard_status
      comment: "Status of scorecard assessment"
    - name: "pcn_compliance"
      expr: pcn_compliance
      comment: "Product change notification compliance flag"
    - name: "score_year"
      expr: YEAR(score_date)
      comment: "Year of scorecard assessment"
    - name: "score_quarter"
      expr: DATE_TRUNC('QUARTER', score_date)
      comment: "Quarter of scorecard assessment"
  measures:
    - name: "total_scorecards"
      expr: COUNT(DISTINCT supplier_scorecard_id)
      comment: "Total count of supplier scorecards for performance tracking coverage"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score for supply base health assessment"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score for quality management decisions"
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score for logistics optimization"
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score for sourcing decisions"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate percentage for supply chain reliability"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score for supplier risk mitigation"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard metrics covering delivery, quality, cost, and overall rating for strategic supplier management."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "scorecard_type"
      expr: scorecard_type
      comment: "Type of scorecard (quarterly, annual, project-based) for performance review cadence analysis."
    - name: "scorecard_period"
      expr: scorecard_period
      comment: "Reporting period for the scorecard enabling trend analysis over time."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall qualitative rating assigned to the supplier (Preferred, Approved, Conditional, Disqualified)."
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic classification of the supplier (Tier 1, Tier 2, Strategic Partner) for differentiated management."
    - name: "supplier_scorecard_status"
      expr: supplier_scorecard_status
      comment: "Current status of the scorecard record."
    - name: "pcn_compliance"
      expr: pcn_compliance
      comment: "Whether the supplier is compliant with Product Change Notification obligations."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of scorecard data verification for data quality governance."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score. Primary KPI for supplier ranking and strategic sourcing decisions."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score. Drives supplier quality improvement programs and disqualification decisions."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average on-time delivery score. Informs supply chain reliability and buffer stock decisions."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score. Supports sourcing strategy and renegotiation decisions."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across scorecards. Key supplier reliability KPI."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate metric. Tracks supplier delivery consistency over time."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score from scorecards. Informs supply risk mitigation prioritization."
    - name: "total_scorecards"
      expr: COUNT(DISTINCT supplier_scorecard_id)
      comment: "Total number of supplier scorecards issued. Measures supplier performance review program coverage."
    - name: "pcn_non_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN pcn_compliance = FALSE THEN supplier_scorecard_id END)
      comment: "Number of scorecards where supplier is PCN non-compliant. Triggers compliance escalation and customer notification risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply agreement metrics covering committed volumes, pricing, and capacity reservation for long-term supply security."
  source: "`vibe_semiconductors_v1`.`supply`.`supply_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of supply agreement (capacity reservation, volume commitment, take-or-pay) for portfolio analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the supply agreement (active, expired, under negotiation)."
    - name: "supply_agreement_status"
      expr: supply_agreement_status
      comment: "Supply agreement lifecycle status from source system."
    - name: "currency_code"
      expr: currency_code
      comment: "Agreement currency for multi-currency portfolio analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the agreement auto-renews for supply continuity planning."
    - name: "dual_source_flag"
      expr: dual_source_flag
      comment: "Whether the agreement supports dual sourcing for supply resilience analysis."
    - name: "priority_allocation_flag"
      expr: priority_allocation_flag
      comment: "Whether the agreement includes priority allocation rights during supply constraints."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms in the supply agreement for logistics cost allocation."
  measures:
    - name: "total_supply_agreements"
      expr: COUNT(DISTINCT supply_agreement_id)
      comment: "Total number of supply agreements. Measures long-term supply security coverage."
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total volume committed under supply agreements. Primary supply security KPI for capacity planning."
    - name: "total_capacity_reservation_qty"
      expr: SUM(CAST(capacity_reservation_qty AS DOUBLE))
      comment: "Total capacity reserved under supply agreements. Measures secured manufacturing capacity for production planning."
    - name: "total_unit_price_usd"
      expr: SUM(CAST(unit_price_usd AS DOUBLE))
      comment: "Sum of contracted unit prices across agreements. Supports price benchmarking."
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average contracted unit price in USD. Tracks pricing trends across the supply agreement portfolio."
    - name: "avg_volume_flexibility_percent"
      expr: AVG(CAST(volume_flexibility_percent AS DOUBLE))
      comment: "Average volume flexibility percentage in agreements. Measures supply chain agility and demand response capability."
    - name: "total_liability_cap_usd"
      expr: SUM(CAST(liability_cap_usd AS DOUBLE))
      comment: "Total liability cap across supply agreements. Quantifies maximum financial exposure from agreement breaches."
    - name: "dual_source_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN dual_source_flag = TRUE THEN supply_agreement_id END)
      comment: "Number of dual-source supply agreements. Measures supply resilience program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply forecast accuracy and volume metrics for demand-supply alignment and inventory planning decisions."
  source: "`vibe_semiconductors_v1`.`supply`.`supply_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of supply forecast (consensus, statistical, supplier-confirmed) for forecast hierarchy analysis."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting methodology used for accuracy benchmarking."
    - name: "forecast_period"
      expr: forecast_period
      comment: "Forecast period for time-series trend analysis."
    - name: "supply_forecast_status"
      expr: supply_forecast_status
      comment: "Current status of the forecast (draft, approved, superseded)."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Forecast lifecycle status from source system."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for forecast quantities."
    - name: "is_ltb"
      expr: is_ltb
      comment: "Indicates last-time-buy forecast requiring special procurement action."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag on the forecast for regulatory or export control tracking."
    - name: "demand_signal"
      expr: demand_signal
      comment: "Source of demand signal driving the forecast (customer order, MRP, statistical)."
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted supply quantity. Primary supply planning volume KPI for capacity and procurement decisions."
    - name: "total_prior_forecast_quantity"
      expr: SUM(CAST(prior_forecast_quantity AS DOUBLE))
      comment: "Total prior period forecast quantity. Enables forecast revision analysis and accuracy trending."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total forecast variance quantity (current vs prior). Measures forecast stability and planning reliability."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average forecast confidence level. Informs safety stock and buffer planning decisions."
    - name: "total_forecast_value"
      expr: SUM(CAST(price_per_unit AS DOUBLE) * CAST(forecast_quantity AS DOUBLE))
      comment: "Total estimated value of forecasted supply (price × quantity). Supports procurement budget planning."
    - name: "ltb_forecast_count"
      expr: COUNT(DISTINCT CASE WHEN is_ltb = TRUE THEN supply_forecast_id END)
      comment: "Number of last-time-buy forecasts. Triggers urgent procurement and inventory build decisions."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average forecasted price per unit. Tracks supply cost trends for budget planning."
$$;
