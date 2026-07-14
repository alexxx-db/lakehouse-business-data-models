-- Metric views for domain: supply | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:28:06

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics performance metrics tracking shipment timeliness, freight costs, and delivery accuracy for supplier parts arriving at manufacturing plants"
  source: "`vibe_automotive_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (in-transit, delivered, delayed, etc.)"
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transportation mode used for the shipment (truck, rail, air, ocean)"
    - name: "carrier_scac"
      expr: carrier_scac
      comment: "Standard Carrier Alpha Code identifying the logistics carrier"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether shipment was expedited due to urgency"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether shipment contains hazardous materials"
    - name: "material_group"
      expr: material_group
      comment: "Material classification group for the shipped parts"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms defining delivery responsibilities"
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month when shipment actually arrived at destination"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', departure_timestamp)
      comment: "Month when shipment departed from supplier location"
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(1)
      comment: "Total number of inbound shipments received from suppliers"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost incurred for inbound shipments"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per inbound shipment"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of all inbound shipments"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume in cubic meters of all inbound shipments"
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per shipment in kilograms"
    - name: "freight_cost_per_kg"
      expr: SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0)
      comment: "Freight cost efficiency measured as cost per kilogram shipped"
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_arrival_timestamp <= estimated_arrival_timestamp THEN 1 END)
      comment: "Count of shipments that arrived on or before estimated arrival time"
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_arrival_timestamp > estimated_arrival_timestamp THEN 1 END)
      comment: "Count of shipments that arrived after estimated arrival time"
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp <= estimated_arrival_timestamp THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND estimated_arrival_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of shipments delivered on time - critical KPI for supplier performance and production continuity"
    - name: "expedited_shipment_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Count of expedited shipments indicating supply chain disruptions"
    - name: "expedited_shipment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expedited = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments requiring expediting - indicator of planning effectiveness"
    - name: "hazardous_shipment_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Count of hazardous material shipments requiring special handling and compliance"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance evaluation metrics tracking quality, delivery, compliance, and overall supplier health for strategic sourcing decisions"
  source: "`vibe_automotive_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Supplier performance tier classification (Platinum, Gold, Silver, Bronze, etc.)"
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the supplier scorecard"
    - name: "supplier_scorecard_status"
      expr: supplier_scorecard_status
      comment: "Status of the supplier scorecard evaluation"
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Flag indicating whether corrective action is required from supplier"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month when supplier evaluation was conducted"
    - name: "evaluation_quarter"
      expr: DATE_TRUNC('QUARTER', evaluation_date)
      comment: "Quarter when supplier evaluation was conducted"
    - name: "evaluator_name"
      expr: evaluator_name
      comment: "Name of the person who conducted the supplier evaluation"
    - name: "scoring_methodology_version"
      expr: scoring_methodology_version
      comment: "Version of the scoring methodology used for evaluation"
  measures:
    - name: "total_supplier_evaluations"
      expr: COUNT(1)
      comment: "Total number of supplier scorecard evaluations conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score across all evaluations"
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across all supplier evaluations - critical for production continuity"
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate - key quality metric for supplier performance"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score measuring adherence to regulatory and contractual requirements"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score measuring supplier communication and issue resolution speed"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score measuring environmental and social responsibility"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score assessing supplier business continuity and supply chain risk"
    - name: "avg_delivery_quantity_accuracy_pct"
      expr: AVG(CAST(delivery_quantity_accuracy_pct AS DOUBLE))
      comment: "Average delivery quantity accuracy percentage - measures order fulfillment precision"
    - name: "avg_ppap_on_time_completion_rate"
      expr: AVG(CAST(ppap_on_time_completion_rate AS DOUBLE))
      comment: "Average PPAP on-time completion rate - critical for new product launch readiness"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END)
      comment: "Count of supplier evaluations requiring corrective action"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations requiring corrective action - indicator of supplier quality issues"
    - name: "top_tier_supplier_count"
      expr: COUNT(CASE WHEN performance_tier IN ('Platinum', 'Gold') THEN 1 END)
      comment: "Count of suppliers in top performance tiers"
    - name: "at_risk_supplier_count"
      expr: COUNT(CASE WHEN CAST(risk_score AS DOUBLE) >= 70 THEN 1 END)
      comment: "Count of suppliers with high risk scores requiring mitigation strategies"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_scheduling_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier scheduling agreement performance metrics tracking delivery rhythm adherence, quality targets, and contract compliance for JIT/JIS supply chains"
  source: "`vibe_automotive_v1`.`supply`.`scheduling_agreement`"
  dimensions:
    - name: "scheduling_agreement_status"
      expr: scheduling_agreement_status
      comment: "Current status of the scheduling agreement (active, expired, suspended, etc.)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of scheduling agreement (JIT, JIS, Kanban, etc.)"
    - name: "delivery_rhythm"
      expr: delivery_rhythm
      comment: "Frequency of scheduled deliveries (hourly, daily, weekly, etc.)"
    - name: "kanban_flag"
      expr: kanban_flag
      comment: "Flag indicating whether agreement uses Kanban pull system"
    - name: "renewal_option"
      expr: renewal_option
      comment: "Flag indicating whether agreement has renewal option"
    - name: "early_termination_allowed"
      expr: early_termination_allowed
      comment: "Flag indicating whether early termination is permitted"
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the scheduling agreement"
    - name: "contract_scope"
      expr: contract_scope
      comment: "Scope of the contract (single-plant, multi-plant, regional, global)"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when scheduling agreement became effective"
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month when scheduling agreement expires"
  measures:
    - name: "total_scheduling_agreements"
      expr: COUNT(1)
      comment: "Total number of active scheduling agreements with suppliers"
    - name: "total_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total annual volume committed across all scheduling agreements"
    - name: "avg_annual_volume_per_agreement"
      expr: AVG(CAST(total_annual_volume AS DOUBLE))
      comment: "Average annual volume per scheduling agreement"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across all scheduling agreements"
    - name: "avg_target_otd_percent"
      expr: AVG(CAST(target_otd_percent AS DOUBLE))
      comment: "Average target on-time delivery percentage set in agreements"
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on-time delivery percentage achieved - critical KPI for JIT supply chain effectiveness"
    - name: "otd_target_achievement_rate"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE)) / NULLIF(AVG(CAST(target_otd_percent AS DOUBLE)), 0)
      comment: "Ratio of actual to target OTD performance - measures supplier delivery reliability"
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target parts-per-million defect rate set in agreements"
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual parts-per-million defect rate achieved - critical quality KPI"
    - name: "quality_target_achievement_rate"
      expr: AVG(CAST(target_ppm AS DOUBLE)) / NULLIF(AVG(CAST(actual_ppm AS DOUBLE)), 0)
      comment: "Ratio of target to actual PPM (higher is better) - measures supplier quality performance vs targets"
    - name: "kanban_agreement_count"
      expr: COUNT(CASE WHEN kanban_flag = TRUE THEN 1 END)
      comment: "Count of agreements using Kanban pull system"
    - name: "kanban_agreement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kanban_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements using Kanban - indicator of lean supply chain maturity"
    - name: "renewable_agreement_count"
      expr: COUNT(CASE WHEN renewal_option = TRUE THEN 1 END)
      comment: "Count of agreements with renewal options"
    - name: "agreements_meeting_otd_target"
      expr: COUNT(CASE WHEN CAST(actual_otd_percent AS DOUBLE) >= CAST(target_otd_percent AS DOUBLE) THEN 1 END)
      comment: "Count of agreements meeting or exceeding on-time delivery targets"
    - name: "agreements_meeting_quality_target"
      expr: COUNT(CASE WHEN CAST(actual_ppm AS DOUBLE) <= CAST(target_ppm AS DOUBLE) THEN 1 END)
      comment: "Count of agreements meeting or exceeding quality targets (lower PPM is better)"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_inbound_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound part master metrics tracking inventory costs, lead times, and part lifecycle for supplier-provided components and materials"
  source: "`vibe_automotive_v1`.`supply`.`inbound_part`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the inbound part (active, phase-out, obsolete, etc.)"
    - name: "material_type"
      expr: material_type
      comment: "Type classification of the material (raw material, component, assembly, etc.)"
    - name: "commodity_group"
      expr: commodity_group
      comment: "Commodity group classification for strategic sourcing"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether part is classified as hazardous material"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the part is manufactured or sourced"
    - name: "ppap_status"
      expr: ppap_status
      comment: "Production Part Approval Process status (approved, pending, rejected)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the part (EA, KG, M, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for part pricing"
    - name: "engineering_change_level"
      expr: engineering_change_level
      comment: "Current engineering change level or revision of the part"
    - name: "last_received_month"
      expr: DATE_TRUNC('MONTH', last_received_date)
      comment: "Month when part was last received from supplier"
  measures:
    - name: "total_inbound_parts"
      expr: COUNT(1)
      comment: "Total number of unique inbound parts in the supply base"
    - name: "total_inventory_value"
      expr: SUM(CAST(average_cost AS DOUBLE))
      comment: "Total inventory value of all inbound parts at average cost - critical for working capital management"
    - name: "avg_part_cost"
      expr: AVG(CAST(average_cost AS DOUBLE))
      comment: "Average cost per inbound part"
    - name: "avg_part_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per part in kilograms"
    - name: "total_part_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all inbound parts in kilograms"
    - name: "avg_part_volume_m3"
      expr: AVG(CAST(length_mm AS DOUBLE) * CAST(width_mm AS DOUBLE) * CAST(height_mm AS DOUBLE) / 1000000000.0)
      comment: "Average volume per part in cubic meters calculated from dimensions"
    - name: "hazardous_part_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Count of parts classified as hazardous materials requiring special handling"
    - name: "hazardous_part_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts that are hazardous materials"
    - name: "ppap_approved_part_count"
      expr: COUNT(CASE WHEN ppap_status = 'approved' THEN 1 END)
      comment: "Count of parts with approved PPAP status - critical for production readiness"
    - name: "ppap_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppap_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts with approved PPAP - indicator of supplier quality readiness"
    - name: "active_part_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN 1 END)
      comment: "Count of parts in active lifecycle status"
    - name: "obsolete_part_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'obsolete' THEN 1 END)
      comment: "Count of obsolete parts requiring phase-out or inventory liquidation"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supply_supplier_id)
      comment: "Count of unique suppliers providing inbound parts"
    - name: "unique_commodity_groups"
      expr: COUNT(DISTINCT commodity_group)
      comment: "Count of unique commodity groups in the supply base"
    - name: "unique_countries_of_origin"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Count of unique countries of origin - indicator of supply chain geographic diversity"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_sourcing_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing nomination metrics tracking supplier selection decisions, nominated volumes, and target pricing for new programs and model launches"
  source: "`vibe_automotive_v1`.`supply`.`sourcing_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the sourcing nomination (pending, approved, rejected, etc.)"
    - name: "commodity"
      expr: commodity
      comment: "Commodity category for the sourced part"
    - name: "is_jit"
      expr: is_jit
      comment: "Flag indicating whether sourcing is for Just-In-Time delivery"
    - name: "is_jis"
      expr: is_jis
      comment: "Flag indicating whether sourcing is for Just-In-Sequence delivery"
    - name: "priority"
      expr: priority
      comment: "Priority level of the sourcing nomination"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the sourcing nomination"
    - name: "program_code"
      expr: program_code
      comment: "Program or vehicle platform code for the nomination"
    - name: "model_year"
      expr: model_year
      comment: "Model year for which the part is being sourced"
    - name: "kit_type"
      expr: kit_type
      comment: "Type of kit or assembly configuration"
    - name: "nomination_month"
      expr: DATE_TRUNC('MONTH', nomination_date)
      comment: "Month when sourcing nomination was submitted"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when sourcing nomination becomes effective"
  measures:
    - name: "total_sourcing_nominations"
      expr: COUNT(1)
      comment: "Total number of sourcing nominations submitted"
    - name: "total_nominated_volume"
      expr: SUM(CAST(nominated_volume AS DOUBLE))
      comment: "Total volume nominated across all sourcing decisions - critical for capacity planning"
    - name: "avg_nominated_volume"
      expr: AVG(CAST(nominated_volume AS DOUBLE))
      comment: "Average nominated volume per sourcing nomination"
    - name: "avg_target_piece_price"
      expr: AVG(CAST(target_piece_price AS DOUBLE))
      comment: "Average target piece price across all nominations - key cost planning metric"
    - name: "total_nominated_value"
      expr: SUM(CAST(nominated_volume AS DOUBLE) * CAST(target_piece_price AS DOUBLE))
      comment: "Total value of nominated volumes at target pricing - critical for program cost forecasting"
    - name: "approved_nomination_count"
      expr: COUNT(CASE WHEN nomination_status = 'approved' THEN 1 END)
      comment: "Count of approved sourcing nominations"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nomination_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nominations approved - indicator of sourcing decision quality"
    - name: "jit_nomination_count"
      expr: COUNT(CASE WHEN is_jit = TRUE THEN 1 END)
      comment: "Count of nominations for Just-In-Time delivery"
    - name: "jis_nomination_count"
      expr: COUNT(CASE WHEN is_jis = TRUE THEN 1 END)
      comment: "Count of nominations for Just-In-Sequence delivery"
    - name: "jit_jis_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_jit = TRUE OR is_jis = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nominations using JIT or JIS - indicator of lean supply chain adoption"
    - name: "high_risk_nomination_count"
      expr: COUNT(CASE WHEN risk_rating IN ('high', 'critical') THEN 1 END)
      comment: "Count of nominations with high or critical risk ratings requiring mitigation"
    - name: "unique_suppliers_nominated"
      expr: COUNT(DISTINCT supply_supplier_id)
      comment: "Count of unique suppliers receiving sourcing nominations"
    - name: "unique_programs"
      expr: COUNT(DISTINCT program_code)
      comment: "Count of unique vehicle programs with sourcing nominations"
    - name: "unique_commodities"
      expr: COUNT(DISTINCT commodity)
      comment: "Count of unique commodity categories being sourced"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply purchase order metrics tracking order volumes and supplier order distribution for production material procurement"
  source: "`vibe_automotive_v1`.`supply`.`supply_purchase_order`"
  dimensions:
    - name: "supplier_id"
      expr: supply_supplier_id
      comment: "Unique identifier for the supplier receiving the purchase order"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier for the purchase order destination"
    - name: "sourcing_nomination_id"
      expr: sourcing_nomination_id
      comment: "Reference to the sourcing nomination that led to this purchase order"
  measures:
    - name: "total_supply_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of supply purchase orders issued to suppliers - key procurement activity metric"
    - name: "unique_suppliers_with_orders"
      expr: COUNT(DISTINCT supply_supplier_id)
      comment: "Count of unique suppliers with active purchase orders - indicator of supply base breadth"
    - name: "unique_plants_ordering"
      expr: COUNT(DISTINCT plant_id)
      comment: "Count of unique plants issuing supply purchase orders"
    - name: "avg_orders_per_supplier"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT supply_supplier_id), 0)
      comment: "Average number of purchase orders per supplier - indicator of order consolidation"
$$;