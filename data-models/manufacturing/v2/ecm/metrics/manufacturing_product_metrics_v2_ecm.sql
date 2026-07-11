-- Metric views for domain: product | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the SKU master — covers portfolio size, cost structure, weight/volume profile, and lifecycle health. Used by product management, supply chain, and finance to steer portfolio decisions."
  source: "`vibe_manufacturing_v1`.`product`.`sku_master`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Product type classification (e.g. finished good, raw material, semi-finished) for portfolio segmentation."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the SKU (active, phase-out, obsolete) — critical for portfolio health analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A/B/C) indicating relative value/volume importance of the SKU."
    - name: "make_or_buy_code"
      expr: make_or_buy_code
      comment: "Indicates whether the SKU is manufactured in-house or procured externally — drives sourcing strategy."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating whether the SKU is classified as hazardous material — affects compliance and logistics."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured — used for trade compliance and tariff analysis."
    - name: "lot_control_required"
      expr: lot_control_required
      comment: "Indicates whether lot traceability is required for this SKU — relevant for quality and regulatory reporting."
    - name: "serial_control_required"
      expr: serial_control_required
      comment: "Indicates whether serial number tracking is required — relevant for warranty and asset management."
  measures:
    - name: "total_active_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Total number of distinct active SKUs in the portfolio. Executives use this to assess portfolio breadth and rationalisation opportunities."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost across SKUs. Tracks cost structure trends and informs pricing and margin decisions."
    - name: "total_standard_cost_value"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard costs across all SKUs — proxy for total portfolio cost exposure used in financial planning."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight of SKUs in kilograms. Used by logistics and packaging teams to optimise freight costs."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight of SKUs. Supports material content analysis and environmental reporting."
    - name: "avg_volume"
      expr: AVG(CAST(volume AS DOUBLE))
      comment: "Average volumetric size of SKUs. Informs warehouse slotting, packaging design, and freight optimisation."
    - name: "hazmat_sku_count"
      expr: COUNT(DISTINCT CASE WHEN hazmat_indicator = TRUE THEN sku_master_id END)
      comment: "Number of SKUs classified as hazardous material. Drives compliance investment and logistics surcharge planning."
    - name: "make_sku_count"
      expr: COUNT(DISTINCT CASE WHEN make_or_buy_code = 'M' THEN sku_master_id END)
      comment: "Number of SKUs manufactured in-house. Used to assess manufacturing capacity requirements and make-vs-buy strategy."
    - name: "buy_sku_count"
      expr: COUNT(DISTINCT CASE WHEN make_or_buy_code = 'B' THEN sku_master_id END)
      comment: "Number of SKUs sourced externally. Informs supplier dependency and procurement strategy."
    - name: "lot_controlled_sku_count"
      expr: COUNT(DISTINCT CASE WHEN lot_control_required = TRUE THEN sku_master_id END)
      comment: "Number of SKUs requiring lot traceability. Drives quality system investment and regulatory compliance scope."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs aggregated at the product family level. Used by product strategy, finance, and sales leadership to evaluate family-level performance, margin targets, and lifecycle health."
  source: "`vibe_manufacturing_v1`.`product`.`family`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the product family (active, sunset, obsolete) — key for portfolio rationalisation decisions."
    - name: "family_type"
      expr: family_type
      comment: "Type classification of the product family — used to segment portfolio by strategic category."
    - name: "market_segment"
      expr: market_segment
      comment: "Target market segment for the product family — enables revenue and margin analysis by market."
    - name: "manufacturing_strategy"
      expr: manufacturing_strategy
      comment: "Manufacturing strategy (MTO, MTS, ETO, etc.) assigned to the family — drives production planning approach."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform underpinning the product family — used for R&D investment and roadmap planning."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the product family hierarchy — enables drill-down from portfolio to sub-family analysis."
    - name: "iot_enabled"
      expr: iot_enabled
      comment: "Indicates whether the product family supports IoT connectivity — relevant for digital product strategy."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Indicates whether the family contains hazardous materials — affects compliance and logistics planning."
  measures:
    - name: "total_product_families"
      expr: COUNT(DISTINCT family_id)
      comment: "Total number of distinct product families. Tracks portfolio breadth and rationalisation progress."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across product families. Monitors pricing positioning and premium vs. value mix."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost across product families. Tracks cost structure and informs margin management."
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage across families. A key strategic KPI for portfolio profitability planning."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across product families. Indicates reliability profile of the portfolio — drives warranty cost and service investment."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across product families. Measures serviceability — informs field service capacity and spare parts strategy."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across product families. Tracks supply responsiveness and customer delivery commitments."
    - name: "iot_enabled_family_count"
      expr: COUNT(DISTINCT CASE WHEN iot_enabled = TRUE THEN family_id END)
      comment: "Number of product families with IoT capability. Tracks digital product portfolio growth — a strategic innovation KPI."
    - name: "active_family_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'Active' THEN family_id END)
      comment: "Number of product families in active lifecycle status. Measures the healthy, revenue-generating core of the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials governance KPIs — tracks BOM completeness, configurability, criticality, and revision currency. Used by engineering, manufacturing, and quality leadership to manage BOM integrity."
  source: "`vibe_manufacturing_v1`.`product`.`bom_header`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (active, in-review, obsolete) — used to filter for production-ready BOMs."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (engineering, manufacturing, sales) — enables analysis by BOM purpose."
    - name: "bom_usage"
      expr: bom_usage
      comment: "Intended usage of the BOM (production, costing, sales) — drives routing and cost roll-up decisions."
    - name: "bom_category"
      expr: bom_category
      comment: "Category classification of the BOM — supports portfolio segmentation and governance reporting."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Indicates whether the BOM supports product configuration — relevant for variant management strategy."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags BOMs for critical products — prioritises review and change control resources."
    - name: "is_phantom"
      expr: is_phantom
      comment: "Indicates phantom BOM assemblies — used in production planning to identify pass-through structures."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether the BOM meets environmental compliance requirements (RoHS, REACH, etc.)."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the BOM meets regulatory compliance requirements — critical for market access."
  measures:
    - name: "total_boms"
      expr: COUNT(DISTINCT bom_header_id)
      comment: "Total number of BOMs in the system. Tracks BOM portfolio size and governance workload."
    - name: "active_bom_count"
      expr: COUNT(DISTINCT CASE WHEN bom_status = 'Active' THEN bom_header_id END)
      comment: "Number of BOMs in active status. Measures the production-ready BOM base — a key manufacturing readiness KPI."
    - name: "critical_bom_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical = TRUE THEN bom_header_id END)
      comment: "Number of BOMs flagged as critical. Drives prioritisation of change control and review resources."
    - name: "configurable_bom_count"
      expr: COUNT(DISTINCT CASE WHEN is_configurable = TRUE THEN bom_header_id END)
      comment: "Number of configurable BOMs. Tracks variant management complexity and configure-to-order capability."
    - name: "env_compliant_bom_count"
      expr: COUNT(DISTINCT CASE WHEN environmental_compliance_flag = TRUE THEN bom_header_id END)
      comment: "Number of BOMs meeting environmental compliance requirements. Tracks regulatory readiness for market access."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity across BOMs. Informs standard batch sizing and production planning parameters."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size across BOMs. Used to optimise production run lengths and reduce changeover costs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component-level BOM KPIs — tracks component criticality, scrap rates, cost relevance, and spare part coverage. Used by engineering, procurement, and quality to manage component risk and cost."
  source: "`vibe_manufacturing_v1`.`product`.`product_bom_line`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the BOM line item (stock, non-stock, service, etc.) — drives procurement and planning treatment."
    - name: "product_bom_line_status"
      expr: product_bom_line_status
      comment: "Status of the BOM line (active, obsolete, in-review) — used to filter for production-valid components."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Flags components that are critical to product function — prioritises supply assurance and quality inspection."
    - name: "spare_part_indicator"
      expr: spare_part_indicator
      comment: "Indicates whether the component is also sold as a spare part — relevant for aftermarket revenue planning."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Indicates whether the component is backflushed in production — affects inventory accuracy and costing."
    - name: "bulk_material_indicator"
      expr: bulk_material_indicator
      comment: "Indicates bulk material components — used for material planning and cost roll-up differentiation."
    - name: "cost_relevance_indicator"
      expr: cost_relevance_indicator
      comment: "Indicates whether the component contributes to product cost roll-up — essential for accurate standard costing."
    - name: "component_origin"
      expr: component_origin
      comment: "Origin of the component (internal, external, customer-supplied) — drives sourcing and compliance analysis."
  measures:
    - name: "total_bom_lines"
      expr: COUNT(1)
      comment: "Total number of BOM line items. Measures BOM complexity — a driver of manufacturing and procurement workload."
    - name: "critical_component_line_count"
      expr: COUNT(DISTINCT CASE WHEN critical_component_flag = TRUE THEN product_bom_line_id END)
      comment: "Number of BOM lines flagged as critical components. Drives supply assurance investment and single-source risk mitigation."
    - name: "spare_part_line_count"
      expr: COUNT(DISTINCT CASE WHEN spare_part_indicator = TRUE THEN product_bom_line_id END)
      comment: "Number of BOM lines that are also spare parts. Informs aftermarket parts catalogue completeness and service revenue potential."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average component quantity per assembly. Used in material requirements planning and cost roll-up validation."
    - name: "avg_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage across BOM lines. A key quality and cost KPI — high scrap factors inflate material costs and signal process issues."
    - name: "total_component_weight_kg"
      expr: SUM(CAST(component_weight_kg AS DOUBLE))
      comment: "Total component weight across all BOM lines. Used for product weight validation, freight cost estimation, and environmental reporting."
    - name: "avg_component_weight_kg"
      expr: AVG(CAST(component_weight_kg AS DOUBLE))
      comment: "Average component weight in kilograms. Supports packaging design and logistics optimisation."
    - name: "distinct_components_in_boms"
      expr: COUNT(DISTINCT component_id)
      comment: "Number of distinct components used across all BOMs. Measures component portfolio breadth and rationalisation opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product revision and change velocity KPIs — tracks revision approval rates, change impact scope, and regulatory exposure. Used by engineering, quality, and compliance leadership to govern product change."
  source: "`vibe_manufacturing_v1`.`product`.`product_revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the product revision (draft, approved, released, obsolete) — used to track change pipeline health."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the revision — measures change control throughput and bottlenecks."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Assessed impact level of the revision (minor, major, critical) — drives resource allocation for change implementation."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Root cause category for the revision (quality, regulatory, cost, customer request) — informs continuous improvement priorities."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the revision becomes effective (date-based, serial-based) — affects production scheduling and inventory management."
    - name: "bom_affected_flag"
      expr: bom_affected_flag
      comment: "Indicates whether the revision impacts the BOM — triggers BOM update and re-release workflow."
    - name: "regulatory_approval_required_flag"
      expr: regulatory_approval_required_flag
      comment: "Indicates whether regulatory body approval is required — a critical compliance gate for market access."
    - name: "ppap_required_flag"
      expr: ppap_required_flag
      comment: "Indicates whether PPAP (Production Part Approval Process) is required — relevant for automotive and regulated industries."
  measures:
    - name: "total_revisions"
      expr: COUNT(DISTINCT product_revision_id)
      comment: "Total number of product revisions. Tracks change velocity — high rates may signal quality or design instability."
    - name: "approved_revision_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN product_revision_id END)
      comment: "Number of approved revisions. Measures change control throughput and engineering productivity."
    - name: "regulatory_approval_required_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_required_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions requiring regulatory approval. Tracks compliance exposure and regulatory submission workload."
    - name: "bom_impacting_revision_count"
      expr: COUNT(DISTINCT CASE WHEN bom_affected_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions that impact the BOM. Drives BOM maintenance workload and production disruption risk assessment."
    - name: "ppap_required_revision_count"
      expr: COUNT(DISTINCT CASE WHEN ppap_required_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions requiring PPAP. Tracks supplier qualification workload and customer approval pipeline."
    - name: "customer_notification_required_count"
      expr: COUNT(DISTINCT CASE WHEN customer_notification_required_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions requiring customer notification. Measures customer communication workload and relationship risk."
    - name: "distinct_skus_with_revisions"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs that have active revisions. Indicates breadth of change activity across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification compliance KPIs — tracks certification coverage, expiry risk, and regulatory readiness by market. Used by compliance, product management, and sales to ensure market access."
  source: "`vibe_manufacturing_v1`.`product`.`product_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (safety, environmental, quality, functional safety) — enables compliance gap analysis by category."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, pending renewal) — critical for market access monitoring."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organisation that issued the certification — used to track relationships with regulatory bodies."
    - name: "is_customer_facing"
      expr: is_customer_facing
      comment: "Indicates whether the certification is visible/required by customers — prioritises renewal urgency."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status — mandatory for EU market access; non-compliance blocks sales."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status — mandatory for EU chemical substance regulations."
    - name: "weee_compliant"
      expr: weee_compliant
      comment: "WEEE compliance status — required for electrical/electronic equipment sold in the EU."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT product_certification_id)
      comment: "Total number of product certifications. Tracks certification portfolio size and compliance investment."
    - name: "active_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN product_certification_id END)
      comment: "Number of currently active certifications. Measures the valid compliance coverage of the product portfolio."
    - name: "expired_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Expired' THEN product_certification_id END)
      comment: "Number of expired certifications. A critical risk KPI — expired certifications block market access and sales."
    - name: "rohs_compliant_sku_count"
      expr: COUNT(DISTINCT CASE WHEN rohs_compliant = TRUE THEN sku_master_id END)
      comment: "Number of distinct SKUs with RoHS compliance. Tracks EU market access readiness for the product portfolio."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total spend on product certifications. Tracks compliance investment and informs budget planning for renewals."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification efficiency and identifies high-cost certification types."
    - name: "distinct_certified_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with at least one certification. Measures certification coverage breadth across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering change order (ECO) pipeline KPIs — tracks change velocity, cost impact, urgency, and regulatory exposure. Used by engineering, quality, and program management to govern product change."
  source: "`vibe_manufacturing_v1`.`product`.`change_order`"
  dimensions:
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change order (open, in-review, approved, closed) — tracks pipeline health and throughput."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (design, process, material, documentation) — enables root cause and workload analysis."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Root cause category for the change — informs continuous improvement and quality investment priorities."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change order — measures change control governance effectiveness."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order (critical, high, medium, low) — drives resource allocation and scheduling."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flags urgent change orders requiring expedited processing — used to manage escalation workload."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Indicates whether the change has regulatory implications — triggers compliance review and approval gates."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Indicates whether customers must be notified of the change — affects customer relationship management."
  measures:
    - name: "total_change_orders"
      expr: COUNT(DISTINCT change_order_id)
      comment: "Total number of engineering change orders. Tracks change velocity — a key indicator of product stability and engineering workload."
    - name: "open_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN change_status = 'Open' THEN change_order_id END)
      comment: "Number of open change orders. Measures backlog and pipeline pressure on engineering and quality teams."
    - name: "urgent_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN urgency_flag = TRUE THEN change_order_id END)
      comment: "Number of urgent change orders. Tracks escalation workload and potential production disruption risk."
    - name: "regulatory_impacting_change_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_impact_flag = TRUE THEN change_order_id END)
      comment: "Number of change orders with regulatory impact. Tracks compliance exposure and regulatory submission pipeline."
    - name: "total_impact_assessment_cost"
      expr: SUM(CAST(impact_assessment_cost AS DOUBLE))
      comment: "Total assessed cost impact of all change orders. A key financial KPI for engineering change management — informs budget reserves."
    - name: "avg_impact_assessment_cost"
      expr: AVG(CAST(impact_assessment_cost AS DOUBLE))
      comment: "Average cost impact per change order. Benchmarks change complexity and informs change control investment decisions."
    - name: "customer_notification_required_count"
      expr: COUNT(DISTINCT CASE WHEN customer_notification_required = TRUE THEN change_order_id END)
      comment: "Number of change orders requiring customer notification. Measures customer communication workload and relationship risk."
    - name: "distinct_skus_with_changes"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with active change orders. Indicates breadth of change activity and portfolio instability risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_lifecycle_stage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product lifecycle management KPIs — tracks EOL pipeline, last-time-buy exposure, and lifecycle transition velocity. Used by product management, supply chain, and finance to manage portfolio transitions."
  source: "`vibe_manufacturing_v1`.`product`.`lifecycle_stage`"
  dimensions:
    - name: "lifecycle_stage_code"
      expr: lifecycle_stage_code
      comment: "Current lifecycle stage code (introduction, growth, maturity, decline, EOL) — the primary dimension for portfolio lifecycle analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the lifecycle stage record is currently active — filters for current vs. historical stage assignments."
    - name: "market_demand_trend"
      expr: market_demand_trend
      comment: "Assessed market demand trend (growing, stable, declining) — informs investment and divestment decisions."
    - name: "lifecycle_decision_authority"
      expr: lifecycle_decision_authority
      comment: "Organisational authority responsible for lifecycle decisions — used for governance and accountability reporting."
    - name: "customer_communication_status"
      expr: customer_communication_status
      comment: "Status of customer communication for EOL products — tracks notification compliance and customer readiness."
  measures:
    - name: "total_lifecycle_records"
      expr: COUNT(DISTINCT lifecycle_stage_id)
      comment: "Total number of lifecycle stage records. Tracks the scope of active lifecycle management across the portfolio."
    - name: "active_lifecycle_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN lifecycle_stage_id END)
      comment: "Number of currently active lifecycle stage assignments. Measures the live portfolio under lifecycle governance."
    - name: "distinct_skus_in_lifecycle_management"
      expr: COUNT(DISTINCT primary_lifecycle_sku_master_id)
      comment: "Number of distinct SKUs under active lifecycle management. Tracks portfolio coverage of the lifecycle governance process."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product specification completeness and technical profile KPIs — tracks specification currency, environmental ratings, and power/weight profiles. Used by engineering, quality, and sales to ensure specification integrity."
  source: "`vibe_manufacturing_v1`.`product`.`product_specification`"
  dimensions:
    - name: "specification_status"
      expr: specification_status
      comment: "Current status of the specification (draft, approved, released, obsolete) — used to filter for production-valid specs."
    - name: "specification_type"
      expr: specification_type
      comment: "Type of specification (mechanical, electrical, environmental, functional) — enables gap analysis by specification category."
    - name: "application_suitability"
      expr: application_suitability
      comment: "Application suitability classification — used to match products to customer application requirements."
    - name: "mounting_type"
      expr: mounting_type
      comment: "Mounting type of the product — relevant for installation planning and compatibility analysis."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol supported by the product — critical for IoT and automation integration decisions."
  measures:
    - name: "total_specifications"
      expr: COUNT(DISTINCT product_specification_id)
      comment: "Total number of product specifications. Tracks specification portfolio size and documentation completeness."
    - name: "approved_specification_count"
      expr: COUNT(DISTINCT CASE WHEN specification_status = 'Approved' THEN product_specification_id END)
      comment: "Number of approved specifications. Measures specification governance throughput and engineering readiness."
    - name: "avg_power_rating_watts"
      expr: AVG(CAST(power_rating_watts AS DOUBLE))
      comment: "Average power rating in watts across specifications. Informs energy efficiency analysis and regulatory compliance for energy labelling."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average product weight in kilograms across specifications. Supports logistics planning and product design benchmarking."
    - name: "avg_operating_temp_max_c"
      expr: AVG(CAST(operating_temperature_max_c AS DOUBLE))
      comment: "Average maximum operating temperature across specifications. Tracks thermal performance profile of the product portfolio."
    - name: "avg_operating_temp_min_c"
      expr: AVG(CAST(operating_temperature_min_c AS DOUBLE))
      comment: "Average minimum operating temperature across specifications. Informs suitability for cold-environment applications."
    - name: "avg_current_rating_amperes"
      expr: AVG(CAST(current_rating_amperes AS DOUBLE))
      comment: "Average current rating in amperes. Used for electrical safety compliance and application suitability analysis."
    - name: "distinct_skus_with_specifications"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with at least one specification. Measures specification coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_plant_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level product planning KPIs — tracks MRP parameters, safety stock, lot sizing, and procurement type distribution. Used by supply chain, production planning, and inventory management to optimise replenishment."
  source: "`vibe_manufacturing_v1`.`product`.`plant_data`"
  dimensions:
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP type assigned to the product at this plant (MRP, reorder point, consumption-based) — drives planning algorithm selection."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (in-house production, external procurement, both) — determines supply strategy for the product at this plant."
    - name: "plant_status"
      expr: plant_status
      comment: "Status of the product at this plant (active, blocked, discontinued) — used to filter for plannable materials."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification at plant level — drives cycle counting frequency and inventory management intensity."
    - name: "batch_management_required"
      expr: batch_management_required
      comment: "Indicates whether batch management is required at this plant — affects traceability and quality inspection setup."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Indicates whether components are backflushed at this plant — affects inventory accuracy and costing."
    - name: "negative_stock_allowed"
      expr: negative_stock_allowed
      comment: "Indicates whether negative stock is permitted — a risk indicator for inventory accuracy and financial reporting."
  measures:
    - name: "total_plant_material_records"
      expr: COUNT(DISTINCT plant_data_id)
      comment: "Total number of plant-material planning records. Tracks the scope of active MRP planning across plants and materials."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across plant-material records. Tracks buffer inventory levels — high values indicate supply uncertainty or risk aversion."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all plant-material records. Measures total buffer inventory investment — a key working capital KPI."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across plant-material records. Informs replenishment trigger calibration and service level management."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across plant-material records. Tracks procurement and production minimum order constraints — affects working capital."
    - name: "avg_maximum_lot_size"
      expr: AVG(CAST(maximum_lot_size AS DOUBLE))
      comment: "Average maximum lot size. Informs production run length optimisation and inventory cap management."
    - name: "avg_fixed_lot_size"
      expr: AVG(CAST(fixed_lot_size AS DOUBLE))
      comment: "Average fixed lot size across plant-material records. Used to assess standardisation of production batch sizes."
    - name: "negative_stock_allowed_count"
      expr: COUNT(DISTINCT CASE WHEN negative_stock_allowed = TRUE THEN plant_data_id END)
      comment: "Number of plant-material records where negative stock is permitted. A risk KPI — high counts indicate potential inventory accuracy and financial reporting issues."
    - name: "batch_managed_material_count"
      expr: COUNT(DISTINCT CASE WHEN batch_management_required = TRUE THEN plant_data_id END)
      comment: "Number of plant-material records requiring batch management. Tracks traceability scope and quality system workload."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_catalog_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product catalog KPIs — tracks catalog coverage, pricing currency, orderability, and lifecycle stage distribution. Used by sales, marketing, and product management to manage the commercial product portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`catalog_entry`"
  dimensions:
    - name: "catalog_status"
      expr: catalog_status
      comment: "Current status of the catalog entry (active, inactive, discontinued) — used to filter for commercially available products."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the catalog entry — enables portfolio health analysis by commercial maturity."
    - name: "product_category"
      expr: product_category
      comment: "Product category classification — primary dimension for catalog segmentation and sales analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for the catalog entry (direct, distributor, online) — enables channel mix and pricing analysis."
    - name: "orderable_flag"
      expr: orderable_flag
      comment: "Indicates whether the product can currently be ordered — measures catalog orderability and availability."
    - name: "oem_offering_flag"
      expr: oem_offering_flag
      comment: "Indicates OEM product offerings — used to segment the catalog by go-to-market model."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates hazardous material catalog entries — affects compliance, logistics, and sales channel eligibility."
    - name: "configurable_flag"
      expr: configurable_flag
      comment: "Indicates configurable products in the catalog — relevant for configure-to-order sales process management."
  measures:
    - name: "total_catalog_entries"
      expr: COUNT(DISTINCT catalog_entry_id)
      comment: "Total number of catalog entries. Tracks commercial portfolio breadth and catalog maintenance workload."
    - name: "orderable_entry_count"
      expr: COUNT(DISTINCT CASE WHEN orderable_flag = TRUE THEN catalog_entry_id END)
      comment: "Number of currently orderable catalog entries. Measures commercial availability — a key sales enablement KPI."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across catalog entries. Tracks pricing positioning and premium vs. value portfolio mix."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across catalog entries. Informs order management and customer accessibility of the catalog."
    - name: "configurable_entry_count"
      expr: COUNT(DISTINCT CASE WHEN configurable_flag = TRUE THEN catalog_entry_id END)
      comment: "Number of configurable catalog entries. Tracks configure-to-order capability breadth — a key differentiator in complex manufacturing sales."
    - name: "distinct_skus_in_catalog"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs represented in the catalog. Measures catalog coverage of the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product configuration KPIs — tracks configuration portfolio, pricing complexity, and orderable/quotable coverage. Used by sales engineering, product management, and pricing teams to manage configure-to-order offerings."
  source: "`vibe_manufacturing_v1`.`product`.`configuration`"
  dimensions:
    - name: "configuration_status"
      expr: configuration_status
      comment: "Current status of the configuration (active, obsolete, in-review) — used to filter for valid configurations."
    - name: "configuration_type"
      expr: configuration_type
      comment: "Type of configuration (standard, custom, engineered-to-order) — enables analysis by complexity and margin profile."
    - name: "is_orderable"
      expr: is_orderable
      comment: "Indicates whether the configuration can be ordered — measures commercial readiness of the configuration portfolio."
    - name: "is_quotable"
      expr: is_quotable
      comment: "Indicates whether the configuration can be quoted — tracks sales pipeline enablement."
    - name: "requires_engineering_review"
      expr: requires_engineering_review
      comment: "Indicates configurations requiring engineering review before order acceptance — tracks engineering bottleneck exposure."
    - name: "manufacturing_complexity"
      expr: manufacturing_complexity
      comment: "Assessed manufacturing complexity of the configuration — informs capacity planning and lead time commitments."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the configuration (list, cost-plus, value-based) — enables pricing strategy analysis."
  measures:
    - name: "total_configurations"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Total number of product configurations. Tracks configure-to-order portfolio breadth and complexity."
    - name: "orderable_configuration_count"
      expr: COUNT(DISTINCT CASE WHEN is_orderable = TRUE THEN configuration_id END)
      comment: "Number of orderable configurations. Measures commercial readiness of the CTO portfolio — a key sales enablement KPI."
    - name: "engineering_review_required_count"
      expr: COUNT(DISTINCT CASE WHEN requires_engineering_review = TRUE THEN configuration_id END)
      comment: "Number of configurations requiring engineering review. Tracks engineering bottleneck exposure in the order-to-delivery process."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across configurations. Tracks pricing positioning and informs discount policy decisions."
    - name: "avg_total_configuration_price"
      expr: AVG(CAST(total_configuration_price AS DOUBLE))
      comment: "Average total configuration price including options. Measures average deal value for CTO orders — a key revenue planning KPI."
    - name: "avg_price_adjustment"
      expr: AVG(CAST(price_adjustment AS DOUBLE))
      comment: "Average price adjustment (premium or discount) applied to configurations. Tracks pricing discipline and option monetisation."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight of configurations in kilograms. Supports freight cost estimation and logistics planning for CTO orders."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating in kilowatts across configurations. Informs energy efficiency analysis and regulatory compliance for energy labelling."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_substitution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product substitution KPIs — tracks substitution coverage, interchangeability, and compliance requirements. Used by supply chain, procurement, and quality to manage supply continuity and component risk."
  source: "`vibe_manufacturing_v1`.`product`.`substitution`"
  dimensions:
    - name: "substitution_status"
      expr: substitution_status
      comment: "Current status of the substitution record (active, expired, pending approval) — used to filter for valid substitutions."
    - name: "substitution_type"
      expr: substitution_type
      comment: "Type of substitution (form-fit-function, approved alternate, emergency) — enables risk and compliance analysis."
    - name: "interchangeable_flag"
      expr: interchangeable_flag
      comment: "Indicates full interchangeability — a key supply continuity KPI for procurement and production planning."
    - name: "automatic_substitution_flag"
      expr: automatic_substitution_flag
      comment: "Indicates whether the substitution can be applied automatically in planning — affects MRP and production scheduling."
    - name: "compliance_certification_required_flag"
      expr: compliance_certification_required_flag
      comment: "Indicates whether compliance certification is required for the substitution — tracks regulatory approval workload."
    - name: "quality_equivalence_verified_flag"
      expr: quality_equivalence_verified_flag
      comment: "Indicates whether quality equivalence has been verified — a critical quality gate for substitution approval."
    - name: "customer_notification_required_flag"
      expr: customer_notification_required_flag
      comment: "Indicates whether customers must be notified of the substitution — affects customer relationship management."
  measures:
    - name: "total_substitutions"
      expr: COUNT(DISTINCT substitution_id)
      comment: "Total number of product substitution records. Tracks supply continuity coverage and alternate sourcing options."
    - name: "active_substitution_count"
      expr: COUNT(DISTINCT CASE WHEN substitution_status = 'Active' THEN substitution_id END)
      comment: "Number of active substitution records. Measures available supply continuity options for the product portfolio."
    - name: "interchangeable_substitution_count"
      expr: COUNT(DISTINCT CASE WHEN interchangeable_flag = TRUE THEN substitution_id END)
      comment: "Number of fully interchangeable substitutions. Tracks the highest-quality supply continuity options available."
    - name: "quality_verified_substitution_count"
      expr: COUNT(DISTINCT CASE WHEN quality_equivalence_verified_flag = TRUE THEN substitution_id END)
      comment: "Number of substitutions with verified quality equivalence. Measures the approved, quality-assured substitution pool."
    - name: "avg_price_variance_percent"
      expr: AVG(CAST(price_variance_percent AS DOUBLE))
      comment: "Average price variance percentage between primary and substitute SKUs. Tracks cost impact of substitution decisions — a key procurement KPI."
    - name: "distinct_skus_with_substitutes"
      expr: COUNT(DISTINCT primary_sku_master_id)
      comment: "Number of distinct primary SKUs with at least one substitution option. Measures supply risk coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply agreement KPIs — tracks contracted supply coverage, pricing, and lead time commitments. Used by procurement, supply chain, and finance to manage supplier agreements and supply security."
  source: "`vibe_manufacturing_v1`.`product`.`supply_agreement`"
  dimensions:
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU covered by the supply agreement — primary dimension for supply coverage analysis by product."
    - name: "procurement_contract_id"
      expr: procurement_contract_id
      comment: "Procurement contract under which the supply agreement operates — enables contract performance analysis."
  measures:
    - name: "total_supply_agreements"
      expr: COUNT(DISTINCT supply_agreement_id)
      comment: "Total number of active supply agreements. Tracks contracted supply coverage breadth across the product portfolio."
    - name: "distinct_skus_under_agreement"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs covered by supply agreements. Measures supply security coverage — SKUs without agreements are at supply risk."
    - name: "avg_contracted_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average contracted supply price across agreements. Tracks procurement cost performance vs. market and standard cost."
    - name: "total_contracted_price_value"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Total contracted price value across all supply agreements. Measures total procurement commitment under contract."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average contracted lead time in days across supply agreements. Tracks supplier responsiveness commitments — a key supply chain KPI."
$$;