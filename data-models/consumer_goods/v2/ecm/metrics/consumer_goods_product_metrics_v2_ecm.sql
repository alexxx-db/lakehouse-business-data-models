-- Metric views for domain: product | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM line-level metrics covering component cost, quantity, scrap, and compliance. Used by procurement, R&D, and manufacturing to optimize formulation economics and manage material risk."
  source: "`vibe_consumer_goods_v1`.`product`.`bom_line`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of BOM component (e.g. Raw Material, Packaging, Semi-Finished) — used to segment cost and compliance analysis."
    - name: "bom_item_category"
      expr: bom_item_category
      comment: "SAP-style BOM item category — used for procurement and planning segmentation."
    - name: "bom_line_status"
      expr: bom_line_status
      comment: "Current status of the BOM line — used to filter active vs. obsolete components."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the component is a hazardous material — used for EHS and logistics compliance."
    - name: "is_critical_component"
      expr: is_critical_component
      comment: "Flag indicating whether the component is critical to the formulation — used for supply risk prioritization."
    - name: "co_product_flag"
      expr: co_product_flag
      comment: "Flag indicating whether the line represents a co-product — used for by-product accounting."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the BOM line became effective — used to track component change cadence."
  measures:
    - name: "total_component_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE))
      comment: "Total component cost across all BOM lines in USD. Primary COGS driver metric used by finance and procurement."
    - name: "avg_component_cost_usd"
      expr: AVG(CAST(component_cost_usd AS DOUBLE))
      comment: "Average component cost per BOM line. Used to benchmark material cost efficiency across formulations."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOM lines. Used by manufacturing and R&D to identify waste reduction opportunities."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total required quantity across all BOM lines. Used for material requirements planning and procurement volume estimation."
    - name: "avg_usage_probability_pct"
      expr: AVG(CAST(usage_probability_pct AS DOUBLE))
      comment: "Average usage probability percentage across BOM lines. Used for alternative item planning and supply risk modeling."
    - name: "critical_component_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_component = TRUE THEN bom_line_id END)
      comment: "Number of BOM lines flagged as critical components. Used by supply chain to prioritize dual-sourcing and safety stock investments."
    - name: "hazardous_component_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hazardous_material_flag = TRUE THEN bom_line_id END) / NULLIF(COUNT(DISTINCT bom_line_id), 0), 2)
      comment: "Percentage of BOM lines containing hazardous materials. Used by EHS and regulatory teams to manage compliance exposure."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across BOM components. Used by procurement to assess supplier MOQ constraints and working capital impact."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification metrics covering certification portfolio health, cost, and expiry risk. Used by regulatory affairs, sustainability, and commercial teams to manage third-party certifications."
  source: "`vibe_consumer_goods_v1`.`product`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Organic, Fair Trade, Cruelty-Free) — primary lens for certification portfolio analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Pending) — used to track certification health."
    - name: "sustainability_pillar"
      expr: sustainability_pillar
      comment: "Sustainability pillar the certification supports (e.g. Environmental, Social, Governance) — used for ESG reporting."
    - name: "consumer_facing_flag"
      expr: consumer_facing_flag
      comment: "Flag indicating whether the certification is consumer-facing — used to prioritize renewal and compliance efforts."
    - name: "retailer_requirement_flag"
      expr: retailer_requirement_flag
      comment: "Flag indicating whether the certification is required by a retailer — used to prioritize compliance with key customer requirements."
    - name: "audit_result"
      expr: audit_result
      comment: "Result of the most recent certification audit — used to track compliance performance."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of certification expiry — used to identify upcoming renewal deadlines."
  measures:
    - name: "active_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of active certifications across the product portfolio. Used by regulatory and sustainability teams to track certification coverage."
    - name: "total_certification_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications in USD. Used by finance and sustainability to budget and track certification investment."
    - name: "avg_certification_cost_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Used to benchmark certification cost efficiency and prioritize renewal investments."
    - name: "consumer_facing_certification_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consumer_facing_flag = TRUE THEN certification_id END) / NULLIF(COUNT(DISTINCT certification_id), 0), 2)
      comment: "Percentage of certifications that are consumer-facing. Used to assess brand trust and consumer claims coverage."
    - name: "retailer_required_certification_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN retailer_requirement_flag = TRUE THEN certification_id END) / NULLIF(COUNT(DISTINCT certification_id), 0), 2)
      comment: "Percentage of certifications required by retailers. Used to prioritize compliance investments protecting key customer relationships."
    - name: "expiring_within_90_days_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN certification_id END)
      comment: "Number of certifications expiring within the next 90 days. Used as an operational alert to trigger renewal processes before lapse."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GTIN registry metrics covering GS1 publication status, data pool readiness, and pack hierarchy coverage. Used by supply chain, commercial, and regulatory teams to manage global trade item number governance."
  source: "`vibe_consumer_goods_v1`.`product`.`gtin_registry`"
  dimensions:
    - name: "gtin_registry_status"
      expr: gtin_registry_status
      comment: "Current status of the GTIN registration — used to filter active vs. retired GTINs."
    - name: "gtin_format"
      expr: gtin_format
      comment: "Format of the GTIN (e.g. GTIN-8, GTIN-12, GTIN-13, GTIN-14) — used to segment by barcode standard."
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging level the GTIN is assigned to (e.g. Each, Inner Pack, Case, Pallet) — used for pack hierarchy coverage analysis."
    - name: "gs1_registry_published"
      expr: gs1_registry_published
      comment: "Flag indicating GS1 registry publication status — used to track global data synchronization readiness."
    - name: "data_pool_published"
      expr: data_pool_published
      comment: "Flag indicating data pool publication status — used to track retailer data synchronization readiness."
    - name: "is_consumer_unit"
      expr: is_consumer_unit
      comment: "Flag indicating whether the GTIN is a consumer unit — used to segment consumer-facing vs. trade GTINs."
    - name: "is_orderable"
      expr: is_orderable
      comment: "Flag indicating whether the GTIN is orderable — used to track commercial availability."
    - name: "target_market_country"
      expr: target_market_country
      comment: "Target market country for the GTIN — used for market-specific compliance and data synchronization analysis."
  measures:
    - name: "active_gtin_count"
      expr: COUNT(DISTINCT CASE WHEN gtin_registry_status = 'Active' THEN gtin_registry_id END)
      comment: "Number of active GTINs in the registry. Used by supply chain and commercial teams to track the live product identifier portfolio."
    - name: "gs1_published_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gs1_registry_published = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(DISTINCT gtin_registry_id), 0), 2)
      comment: "Percentage of GTINs published to the GS1 registry. Used to track global data synchronization completeness and retailer onboarding readiness."
    - name: "data_pool_published_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_pool_published = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(DISTINCT gtin_registry_id), 0), 2)
      comment: "Percentage of GTINs published to the data pool. Used to track retailer data synchronization coverage and identify gaps."
    - name: "orderable_gtin_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_orderable = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(DISTINCT gtin_registry_id), 0), 2)
      comment: "Percentage of GTINs that are orderable. Used to track commercial availability of the product portfolio."
    - name: "avg_net_content_value"
      expr: AVG(CAST(net_content_value AS DOUBLE))
      comment: "Average net content value across GTINs. Used for pack size benchmarking and consumer value analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_pack_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pack hierarchy metrics tracking packaging dimensions, weights, and sustainability attributes for logistics optimization and sustainability reporting."
  source: "`vibe_consumer_goods_v1`.`product`.`hierarchy`"
  dimensions:
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the pack hierarchy (e.g. Each, Inner Pack, Case, Pallet) for packaging structure analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material master metrics tracking material portfolio, cost, and compliance attributes for procurement and formulation cost management decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`material`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (e.g. Raw Material, Packaging, Semi-Finished) for portfolio segmentation."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification for spend category and sourcing analysis."
    - name: "material_status"
      expr: material_status
      comment: "Current status of the material for active portfolio management."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the material for PLM and procurement planning."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Flag indicating hazardous material for EHS compliance and handling requirements."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for sourcing risk and trade compliance analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g. External, Internal) for make-vs-buy analysis."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging type for material handling and storage analysis."
  measures:
    - name: "total_materials"
      expr: COUNT(DISTINCT material_id)
      comment: "Total number of materials in the master data; used for material portfolio complexity and maintenance burden assessment."
    - name: "hazardous_material_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hazardous_flag = TRUE THEN material_id END) / NULLIF(COUNT(DISTINCT material_id), 0), 2)
      comment: "Percentage of materials classified as hazardous; used for EHS risk management and regulatory compliance planning."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per material; used for COGS benchmarking and procurement efficiency tracking."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all materials; used for material cost base and procurement budget analysis."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per material in kilograms; used for logistics cost estimation and packaging optimization."
    - name: "avg_volume_l"
      expr: AVG(CAST(volume_l AS DOUBLE))
      comment: "Average volume per material in liters; used for storage capacity planning and logistics optimization."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature requirement across materials; used for cold chain infrastructure planning and cost management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_plm_transition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PLM stage-gate transition metrics covering pipeline velocity, approval cycle times, and fast-track rates. Used by R&D leadership and portfolio management to steer innovation pipeline throughput."
  source: "`vibe_consumer_goods_v1`.`product`.`plm_transition`"
  dimensions:
    - name: "from_stage_code"
      expr: from_stage_code
      comment: "PLM stage the product is transitioning from — used to analyze pipeline flow at each gate."
    - name: "to_stage_code"
      expr: to_stage_code
      comment: "PLM stage the product is transitioning to — used to track advancement through the innovation funnel."
    - name: "plm_transition_status"
      expr: plm_transition_status
      comment: "Current status of the PLM transition (e.g. Approved, Pending, Rejected) — used to track gate review outcomes."
    - name: "transition_type"
      expr: transition_type
      comment: "Type of PLM transition (e.g. Stage Advance, Withdrawal, Fast-Track) — used to segment pipeline activity."
    - name: "is_fast_track"
      expr: is_fast_track
      comment: "Flag indicating fast-track designation — used to monitor expedited innovation pipeline activity."
    - name: "regulatory_submission_required"
      expr: regulatory_submission_required
      comment: "Flag indicating whether a regulatory submission is required for this transition — used to size regulatory workload."
    - name: "transition_date"
      expr: DATE_TRUNC('quarter', transition_date)
      comment: "Quarter of the PLM transition — used to track innovation pipeline velocity over time."
  measures:
    - name: "total_transition_count"
      expr: COUNT(DISTINCT plm_transition_id)
      comment: "Total number of PLM stage-gate transitions. Baseline metric for innovation pipeline activity volume."
    - name: "approved_transition_count"
      expr: COUNT(DISTINCT CASE WHEN plm_transition_status = 'Approved' THEN plm_transition_id END)
      comment: "Number of approved PLM transitions. Used by R&D leadership to track successful gate passage rate."
    - name: "gate_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN plm_transition_status = 'Approved' THEN plm_transition_id END) / NULLIF(COUNT(DISTINCT plm_transition_id), 0), 2)
      comment: "Percentage of PLM transitions that are approved. Used to assess innovation pipeline health and gate review rigor."
    - name: "fast_track_transition_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_fast_track = TRUE THEN plm_transition_id END) / NULLIF(COUNT(DISTINCT plm_transition_id), 0), 2)
      comment: "Percentage of PLM transitions designated as fast-track. Used to monitor expedited pipeline share and resource allocation."
    - name: "regulatory_submission_required_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_submission_required = TRUE THEN plm_transition_id END) / NULLIF(COUNT(DISTINCT plm_transition_id), 0), 2)
      comment: "Percentage of PLM transitions requiring regulatory submission. Used by regulatory affairs to forecast submission workload."
    - name: "avg_stage_cycle_days"
      expr: AVG(CAST(DATEDIFF(stage_exit_date, stage_entry_date) AS DOUBLE))
      comment: "Average number of days spent in a PLM stage (exit minus entry date). Used by R&D leadership to identify bottleneck stages and accelerate time-to-market."
    - name: "avg_days_to_revised_launch"
      expr: AVG(CAST(DATEDIFF(revised_launch_date, target_launch_date) AS DOUBLE))
      comment: "Average slippage in days between target and revised launch date. Used to track innovation pipeline schedule adherence and identify systemic delays."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials metrics covering BOM completeness, compliance, and cost. Used by R&D, manufacturing, and procurement to manage formulation governance and cost-of-goods."
  source: "`vibe_consumer_goods_v1`.`product`.`product_bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Production, Engineering, Costing) — used to segment BOM analysis by purpose."
    - name: "bom_category"
      expr: bom_category
      comment: "Category classification of the BOM — used for portfolio and compliance segmentation."
    - name: "product_bom_status"
      expr: product_bom_status
      comment: "Current status of the BOM (e.g. Active, Obsolete, Draft) — used to filter operational vs. historical BOMs."
    - name: "gmp_compliant"
      expr: gmp_compliant
      comment: "Flag indicating GMP compliance of the BOM — critical for regulated product manufacturing."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Flag indicating REACH regulatory compliance — used for EU market access decisions."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Flag indicating RSPO (sustainable palm oil) certification — used for sustainability reporting."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the BOM became effective — used to track BOM change cadence over time."
  measures:
    - name: "active_bom_count"
      expr: COUNT(DISTINCT CASE WHEN product_bom_status = 'Active' THEN product_bom_id END)
      comment: "Number of active BOMs. Used by manufacturing and R&D to track the live formulation footprint."
    - name: "total_bom_count"
      expr: COUNT(DISTINCT product_bom_id)
      comment: "Total number of BOMs across all statuses. Baseline for BOM governance and lifecycle management."
    - name: "gmp_compliant_bom_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gmp_compliant = TRUE THEN product_bom_id END) / NULLIF(COUNT(DISTINCT product_bom_id), 0), 2)
      comment: "Percentage of BOMs that are GMP compliant. Regulatory and quality leadership use this to assess manufacturing readiness."
    - name: "reach_compliant_bom_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reach_compliant = TRUE THEN product_bom_id END) / NULLIF(COUNT(DISTINCT product_bom_id), 0), 2)
      comment: "Percentage of BOMs meeting REACH compliance. Used by regulatory affairs to manage EU market access risk."
    - name: "rspo_certified_bom_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rspo_certified = TRUE THEN product_bom_id END) / NULLIF(COUNT(DISTINCT product_bom_id), 0), 2)
      comment: "Percentage of BOMs with RSPO certification. Tracks sustainable sourcing commitments at the formulation level."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity per BOM. Used for batch sizing and production planning benchmarking."
    - name: "avg_lot_size_from"
      expr: AVG(CAST(lot_size_from AS DOUBLE))
      comment: "Average minimum lot size across BOMs. Used by supply chain to calibrate minimum production run economics."
    - name: "avg_lot_size_to"
      expr: AVG(CAST(lot_size_to AS DOUBLE))
      comment: "Average maximum lot size across BOMs. Used to understand production capacity ceiling per formulation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product brand metrics tracking brand portfolio health, trade promotion eligibility, and sustainability certification for brand strategy and investment decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`product_brand`"
  dimensions:
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier classification (e.g. Premium, Mass, Value) for portfolio investment prioritization."
    - name: "product_brand_status"
      expr: product_brand_status
      comment: "Current status of the product brand for active portfolio management."
    - name: "architecture_type"
      expr: architecture_type
      comment: "Brand architecture type (e.g. Masterbrand, Sub-brand, Endorsed) for brand strategy analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the brand for market expansion and investment decisions."
    - name: "primary_category"
      expr: primary_category
      comment: "Primary product category of the brand for portfolio mix analysis."
    - name: "is_licensed_brand"
      expr: is_licensed_brand
      comment: "Flag indicating licensed brand status for royalty and IP management."
    - name: "trade_promotion_eligible"
      expr: trade_promotion_eligible
      comment: "Flag indicating trade promotion eligibility for commercial planning."
    - name: "nps_tracking_enabled"
      expr: nps_tracking_enabled
      comment: "Flag indicating whether NPS tracking is enabled for brand health monitoring."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year of brand launch for brand age and portfolio vintage analysis."
  measures:
    - name: "total_brands"
      expr: COUNT(DISTINCT product_brand_id)
      comment: "Total number of product brands in the portfolio; used for brand portfolio breadth and management complexity assessment."
    - name: "active_brands"
      expr: COUNT(DISTINCT CASE WHEN product_brand_status = 'Active' THEN product_brand_id END)
      comment: "Count of currently active brands; used for portfolio health and investment focus decisions."
    - name: "trade_promotion_eligible_brand_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trade_promotion_eligible = TRUE THEN product_brand_id END) / NULLIF(COUNT(DISTINCT product_brand_id), 0), 2)
      comment: "Percentage of brands eligible for trade promotion; used for commercial planning and trade spend allocation."
    - name: "licensed_brand_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_licensed_brand = TRUE THEN product_brand_id END) / NULLIF(COUNT(DISTINCT product_brand_id), 0), 2)
      comment: "Percentage of licensed brands in the portfolio; used for IP risk management and royalty cost planning."
    - name: "nps_tracked_brand_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN nps_tracking_enabled = TRUE THEN product_brand_id END) / NULLIF(COUNT(DISTINCT product_brand_id), 0), 2)
      comment: "Percentage of brands with NPS tracking enabled; used for brand health monitoring coverage and consumer insight investment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product claim metrics covering claim portfolio health, regulatory compliance, and approval status. Used by marketing, regulatory affairs, and legal to govern consumer-facing claims."
  source: "`vibe_consumer_goods_v1`.`product`.`product_claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of product claim (e.g. Efficacy, Environmental, Certification) — used to segment claim compliance analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (e.g. Approved, Under Review, Withdrawn) — used to track claim governance."
    - name: "channel"
      expr: channel
      comment: "Sales/marketing channel where the claim is used — used to segment claim compliance by channel."
    - name: "fda_reviewed"
      expr: fda_reviewed
      comment: "Flag indicating FDA review completion — used for US regulatory compliance tracking."
    - name: "ftc_compliant"
      expr: ftc_compliant
      comment: "Flag indicating FTC compliance — used for US advertising compliance monitoring."
    - name: "marketing_approved"
      expr: marketing_approved
      comment: "Flag indicating marketing approval — used to track claims cleared for consumer-facing use."
    - name: "legal_reviewed"
      expr: legal_reviewed
      comment: "Flag indicating legal review completion — used for claims governance and risk management."
    - name: "quantitative_claim"
      expr: quantitative_claim
      comment: "Flag indicating whether the claim is quantitative — used to prioritize substantiation requirements."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter the claim became effective — used to track new claim introduction cadence."
  measures:
    - name: "approved_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'Approved' THEN product_claim_id END)
      comment: "Number of approved product claims. Used by marketing and regulatory to track the live approved claims portfolio."
    - name: "total_claim_count"
      expr: COUNT(DISTINCT product_claim_id)
      comment: "Total number of product claims across all statuses. Baseline for claims governance workload sizing."
    - name: "claim_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN claim_status = 'Approved' THEN product_claim_id END) / NULLIF(COUNT(DISTINCT product_claim_id), 0), 2)
      comment: "Percentage of claims that are approved. Used by regulatory and legal leadership to assess claims governance effectiveness."
    - name: "ftc_compliant_claim_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ftc_compliant = TRUE THEN product_claim_id END) / NULLIF(COUNT(DISTINCT product_claim_id), 0), 2)
      comment: "Percentage of claims that are FTC compliant. Used to assess US advertising regulatory risk exposure."
    - name: "claims_pending_review_count"
      expr: COUNT(DISTINCT CASE WHEN legal_reviewed = FALSE OR marketing_approved = FALSE THEN product_claim_id END)
      comment: "Number of claims pending legal or marketing review. Used to manage claims governance backlog and prioritize review resources."
    - name: "avg_claim_value"
      expr: AVG(CAST(claim_value AS DOUBLE))
      comment: "Average quantitative claim value across claims. Used by R&D and marketing to benchmark efficacy claim levels."
    - name: "withdrawn_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'Withdrawn' THEN product_claim_id END)
      comment: "Number of withdrawn claims. Used by regulatory and legal to track claims risk events and remediation activity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product formulation metrics covering regulatory compliance, sustainability attributes, and formulation lifecycle. Used by R&D, regulatory affairs, and sustainability teams to govern the commercialized formulation portfolio."
  source: "`vibe_consumer_goods_v1`.`product`.`product_formulation`"
  dimensions:
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (e.g. Rinse-Off, Leave-On, Oral Care) — used to segment compliance and sustainability analysis."
    - name: "product_formulation_status"
      expr: product_formulation_status
      comment: "Current lifecycle status of the formulation — used to filter active vs. obsolete formulations."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "PLM lifecycle stage of the formulation — used to track R&D-to-commercial progression."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the formulation — used by regulatory affairs to track market authorization."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Flag indicating GMP compliance — critical for regulated market access."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Flag indicating vegan formulation status — used for consumer claims and market segmentation."
    - name: "is_cruelty_free"
      expr: is_cruelty_free
      comment: "Flag indicating cruelty-free status — used for consumer claims and retailer compliance."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Flag indicating RSPO certification — used for sustainable palm oil commitment tracking."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter the formulation became effective — used to track new formulation introduction cadence."
  measures:
    - name: "active_formulation_count"
      expr: COUNT(DISTINCT CASE WHEN product_formulation_status = 'Active' THEN product_formulation_id END)
      comment: "Number of active commercialized formulations. Used by R&D and portfolio management to track the live formulation footprint."
    - name: "gmp_compliant_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gmp_compliance_flag = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of formulations that are GMP compliant. Regulatory leadership uses this to assess manufacturing readiness across the portfolio."
    - name: "vegan_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_vegan = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of formulations with vegan status. Tracks progress against consumer-facing sustainability and ethical sourcing commitments."
    - name: "cruelty_free_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_cruelty_free = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of formulations certified cruelty-free. Used for retailer compliance and brand positioning reporting."
    - name: "avg_ph_range"
      expr: AVG(CAST(ph_max AS DOUBLE) - CAST(ph_min AS DOUBLE))
      comment: "Average pH range (max minus min) across formulations. Used by R&D to assess formulation stability breadth."
    - name: "avg_total_solid_content_pct"
      expr: AVG(CAST(total_solid_content_pct AS DOUBLE))
      comment: "Average total solid content percentage across formulations. Used for product performance benchmarking and packaging design."
    - name: "avg_active_ingredient_pct"
      expr: AVG(CAST(active_ingredient_pct AS DOUBLE))
      comment: "Average active ingredient concentration across formulations. Used by R&D to benchmark efficacy levels across the portfolio."
    - name: "rspo_certified_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rspo_certified = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of formulations with RSPO certification. Tracks sustainable palm oil sourcing commitments at the formulation level."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_formulation_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulation ingredient metrics covering concentration levels, regulatory compliance, and sustainability attributes. Used by R&D, regulatory affairs, and procurement to manage ingredient risk and compliance."
  source: "`vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient`"
  dimensions:
    - name: "ingredient_function"
      expr: ingredient_function
      comment: "Functional role of the ingredient (e.g. Preservative, Emulsifier, Active) — used to segment compliance and cost analysis."
    - name: "ingredient_status"
      expr: ingredient_status
      comment: "Current status of the ingredient in the formulation — used to filter active vs. obsolete ingredients."
    - name: "fda_status"
      expr: fda_status
      comment: "FDA regulatory status of the ingredient — used for US market compliance analysis."
    - name: "ifra_compliance_status"
      expr: ifra_compliance_status
      comment: "IFRA fragrance compliance status — used for fragrance ingredient regulatory management."
    - name: "is_active_ingredient"
      expr: is_active_ingredient
      comment: "Flag indicating whether the ingredient is an active ingredient — used to segment efficacy-driving components."
    - name: "is_prohibited_substance"
      expr: is_prohibited_substance
      comment: "Flag indicating whether the ingredient is a prohibited substance — critical compliance risk indicator."
    - name: "is_restricted_substance"
      expr: is_restricted_substance
      comment: "Flag indicating whether the ingredient is a restricted substance — used for regulatory limit monitoring."
    - name: "svhc_flag"
      expr: svhc_flag
      comment: "Flag indicating SVHC (Substance of Very High Concern) status under REACH — used for EU compliance risk management."
    - name: "is_natural_origin"
      expr: is_natural_origin
      comment: "Flag indicating natural origin of the ingredient — used for natural/organic claims and consumer transparency."
    - name: "is_palm_derived"
      expr: is_palm_derived
      comment: "Flag indicating palm-derived origin — used for RSPO and deforestation commitment tracking."
  measures:
    - name: "total_ingredient_count"
      expr: COUNT(DISTINCT product_formulation_ingredient_id)
      comment: "Total number of formulation ingredient records. Baseline for ingredient portfolio complexity management."
    - name: "prohibited_substance_ingredient_count"
      expr: COUNT(DISTINCT CASE WHEN is_prohibited_substance = TRUE THEN product_formulation_ingredient_id END)
      comment: "Number of ingredient records flagged as prohibited substances. Any non-zero value is a critical compliance alert requiring immediate remediation."
    - name: "restricted_substance_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_restricted_substance = TRUE THEN product_formulation_ingredient_id END) / NULLIF(COUNT(DISTINCT product_formulation_ingredient_id), 0), 2)
      comment: "Percentage of ingredient records that are restricted substances. Used by regulatory affairs to size compliance monitoring workload."
    - name: "svhc_ingredient_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN svhc_flag = TRUE THEN product_formulation_ingredient_id END) / NULLIF(COUNT(DISTINCT product_formulation_ingredient_id), 0), 2)
      comment: "Percentage of ingredients flagged as SVHC under REACH. Used to assess EU regulatory exposure and drive reformulation priorities."
    - name: "natural_origin_ingredient_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_natural_origin = TRUE THEN product_formulation_ingredient_id END) / NULLIF(COUNT(DISTINCT product_formulation_ingredient_id), 0), 2)
      comment: "Percentage of ingredients from natural origin. Used for natural/organic product claims and consumer transparency reporting."
    - name: "avg_concentration_nominal_pct"
      expr: AVG(CAST(concentration_nominal_pct AS DOUBLE))
      comment: "Average nominal concentration percentage across ingredients. Used by R&D to benchmark formulation density and efficacy."
    - name: "avg_regulatory_max_concentration_pct"
      expr: AVG(CAST(regulatory_max_concentration_pct AS DOUBLE))
      comment: "Average regulatory maximum concentration limit across ingredients. Used to assess headroom between actual and permitted concentrations."
    - name: "avg_natural_origin_index"
      expr: AVG(CAST(natural_origin_index AS DOUBLE))
      comment: "Average natural origin index across formulation ingredients. Used for ISO 16128 natural origin reporting and consumer claims substantiation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging specification metrics covering sustainability, cost, and compliance. Used by packaging engineering, sustainability, and procurement to optimize packaging design and track ESG commitments."
  source: "`vibe_consumer_goods_v1`.`product`.`product_packaging_spec`"
  dimensions:
    - name: "packaging_level"
      expr: packaging_level
      comment: "Level of packaging (e.g. Primary, Secondary, Tertiary) — used to segment packaging analysis by level."
    - name: "component_type"
      expr: component_type
      comment: "Type of packaging component (e.g. Bottle, Cap, Label) — used for component-level cost and compliance analysis."
    - name: "product_packaging_spec_status"
      expr: product_packaging_spec_status
      comment: "Current status of the packaging spec — used to filter active vs. obsolete specifications."
    - name: "is_fsc_certified"
      expr: is_fsc_certified
      comment: "Flag indicating FSC (Forest Stewardship Council) certification — used for sustainable sourcing reporting."
    - name: "is_rspo_certified"
      expr: is_rspo_certified
      comment: "Flag indicating RSPO certification for palm-derived packaging materials — used for sustainability commitments."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous material content in packaging — used for logistics and regulatory compliance."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the packaging component — used for trade compliance and sourcing risk analysis."
  measures:
    - name: "active_packaging_spec_count"
      expr: COUNT(DISTINCT CASE WHEN product_packaging_spec_status = 'Active' THEN product_packaging_spec_id END)
      comment: "Number of active packaging specifications. Used by packaging engineering to track the live packaging portfolio."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost across all packaging specifications. Used by procurement and finance to track packaging cost exposure."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per packaging specification. Used to benchmark packaging cost efficiency and track cost reduction initiatives."
    - name: "avg_pcr_content_pct"
      expr: AVG(CAST(pcr_content_pct AS DOUBLE))
      comment: "Average post-consumer recycled content percentage across packaging specs. Key ESG KPI tracking progress against PCR content commitments."
    - name: "avg_gross_weight_g"
      expr: AVG(CAST(gross_weight_g AS DOUBLE))
      comment: "Average gross weight per packaging component in grams. Used for lightweighting initiatives and logistics cost optimization."
    - name: "fsc_certified_spec_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_fsc_certified = TRUE THEN product_packaging_spec_id END) / NULLIF(COUNT(DISTINCT product_packaging_spec_id), 0), 2)
      comment: "Percentage of packaging specs with FSC certification. Tracks sustainable fiber sourcing commitments."
    - name: "rspo_certified_spec_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_rspo_certified = TRUE THEN product_packaging_spec_id END) / NULLIF(COUNT(DISTINCT product_packaging_spec_id), 0), 2)
      comment: "Percentage of packaging specs with RSPO certification. Tracks sustainable palm oil commitments in packaging materials."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product registration metrics covering consumer registration volume, warranty uptake, and marketing consent rates. Used by consumer insights, marketing, and product teams to track post-purchase engagement."
  source: "`vibe_consumer_goods_v1`.`product`.`product_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the product registration (e.g. Active, Expired, Pending) — used to track registration health."
    - name: "registration_channel"
      expr: registration_channel
      comment: "Channel through which the product was registered (e.g. Web, Mobile, In-Store) — used for channel attribution analysis."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the product was purchased — used to correlate purchase and registration behavior."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty associated with the registration — used to segment warranty program analysis."
    - name: "extended_warranty_flag"
      expr: extended_warranty_flag
      comment: "Flag indicating extended warranty purchase — used to track extended warranty attach rates."
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Flag indicating marketing opt-in consent — used for consent rate tracking and CRM segmentation."
    - name: "registration_date"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of product registration — used to track registration volume trends over time."
  measures:
    - name: "total_registration_count"
      expr: COUNT(DISTINCT product_registration_id)
      comment: "Total number of product registrations. Used by consumer insights and marketing to track post-purchase engagement volume."
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in_flag = TRUE THEN product_registration_id END) / NULLIF(COUNT(DISTINCT product_registration_id), 0), 2)
      comment: "Percentage of registrations with marketing opt-in consent. Used by marketing to track consent rate and size addressable CRM audience."
    - name: "extended_warranty_attach_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN extended_warranty_flag = TRUE THEN product_registration_id END) / NULLIF(COUNT(DISTINCT product_registration_id), 0), 2)
      comment: "Percentage of registrations with extended warranty purchase. Used by product and finance teams to track warranty revenue attachment."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price at time of registration. Used by consumer insights to understand price point distribution of registered consumers."
    - name: "total_purchase_value"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase value across all registrations. Used to estimate the consumer value pool represented by registered products."
    - name: "recall_notification_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN recall_notification_opt_in = TRUE THEN product_registration_id END) / NULLIF(COUNT(DISTINCT product_registration_id), 0), 2)
      comment: "Percentage of registrations opted in for recall notifications. Used by product safety and regulatory teams to assess recall communication reach."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU portfolio metrics covering active product count, cost economics, weight/volume characteristics, and lifecycle stage distribution. Used by product portfolio managers and supply chain leaders to steer assortment decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "PLM lifecycle stage of the SKU (e.g. Launch, Growth, Mature, Decline, Discontinued) — primary lens for portfolio health analysis."
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (e.g. Liquid, Powder, Cream) — used to segment portfolio by format."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured — used for trade compliance and sourcing risk analysis."
    - name: "is_regulated_product"
      expr: is_regulated_product
      comment: "Flag indicating whether the SKU is subject to regulatory oversight — used to segment regulated vs. non-regulated portfolio."
    - name: "is_sustainable"
      expr: is_sustainable
      comment: "Flag indicating whether the SKU meets sustainability criteria — used for ESG portfolio reporting."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether the SKU contains hazardous materials — used for logistics and compliance segmentation."
    - name: "packaging_material_type"
      expr: packaging_material_type
      comment: "Type of primary packaging material — used for sustainability and recyclability analysis."
    - name: "portfolio_classification"
      expr: portfolio_classification
      comment: "Strategic portfolio classification (e.g. Core, Innovation, Tail) — used for investment prioritization."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of SKU launch — used to track new product introduction cadence over time."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month of SKU discontinuation — used to track portfolio rationalization activity."
  measures:
    - name: "active_sku_count"
      expr: COUNT(DISTINCT CASE WHEN sku_status = 'Active' THEN sku_id END)
      comment: "Number of distinct active SKUs in the portfolio. Executives use this to track portfolio size and rationalization progress."
    - name: "total_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Total number of distinct SKUs across all lifecycle stages. Baseline portfolio breadth metric."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU in USD. Used by finance and supply chain to benchmark cost competitiveness and track cost reduction initiatives."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all SKUs. Used to estimate total portfolio cost exposure."
    - name: "avg_msrp_usd"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price across SKUs. Used to track pricing positioning and premium mix."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per SKU in kilograms. Used for logistics cost modeling and sustainability reporting."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per SKU. Used for fill-rate and content efficiency analysis."
    - name: "avg_volume_ml"
      expr: AVG(CAST(volume_ml AS DOUBLE))
      comment: "Average volume per SKU in milliliters. Used for packaging efficiency and logistics cube optimization."
    - name: "sustainable_sku_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_sustainable = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of SKUs meeting sustainability criteria. Key ESG KPI tracked by sustainability and executive leadership."
    - name: "regulated_sku_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_regulated_product = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of SKUs subject to regulatory oversight. Used by regulatory affairs to size compliance workload."
    - name: "recyclable_packaging_sku_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_recyclable_packaging = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of SKUs with recyclable packaging. Tracks progress against packaging sustainability commitments."
    - name: "avg_fefo_threshold_pct"
      expr: AVG(CAST(fefo_threshold_pct AS DOUBLE))
      comment: "Average FEFO (First Expired First Out) threshold percentage across SKUs. Used by supply chain to calibrate shelf-life risk policies."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku_substitution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU substitution metrics tracking substitution portfolio, COGS impact, and auto-substitution enablement for supply continuity and customer service management."
  source: "`vibe_consumer_goods_v1`.`product`.`sku_substitution`"
  dimensions:
    - name: "substitution_type"
      expr: substitution_type
      comment: "Type of SKU substitution (e.g. Permanent, Temporary, Reformulation) for substitution reason analysis."
    - name: "sku_substitution_status"
      expr: sku_substitution_status
      comment: "Current status of the substitution record for active substitution management."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the substitution for root cause and supply risk analysis."
    - name: "auto_substitution_allowed"
      expr: auto_substitution_allowed
      comment: "Flag indicating whether auto-substitution is allowed for order fulfillment automation."
    - name: "atp_substitution_enabled"
      expr: atp_substitution_enabled
      comment: "Flag indicating ATP-driven substitution enablement for supply planning integration."
    - name: "is_bidirectional"
      expr: is_bidirectional
      comment: "Flag indicating bidirectional substitution for symmetric supply flexibility."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel for the substitution for channel-specific supply continuity management."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the substitution became effective for substitution trend analysis."
  measures:
    - name: "total_substitutions"
      expr: COUNT(DISTINCT sku_substitution_id)
      comment: "Total number of SKU substitution records; used for supply flexibility and portfolio change management assessment."
    - name: "active_substitutions"
      expr: COUNT(DISTINCT CASE WHEN sku_substitution_status = 'Active' THEN sku_substitution_id END)
      comment: "Count of currently active SKU substitutions; used for supply continuity and order fulfillment planning."
    - name: "auto_substitution_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_substitution_allowed = TRUE THEN sku_substitution_id END) / NULLIF(COUNT(DISTINCT sku_substitution_id), 0), 2)
      comment: "Percentage of substitutions with auto-substitution allowed; used for order management automation and customer service efficiency."
    - name: "avg_cogs_impact_pct"
      expr: AVG(CAST(cogs_impact_pct AS DOUBLE))
      comment: "Average COGS impact percentage of SKU substitutions; used for margin management and substitution cost-benefit analysis."
    - name: "avg_price_adjustment_pct"
      expr: AVG(CAST(price_adjustment_pct AS DOUBLE))
      comment: "Average price adjustment percentage for substitutions; used for revenue impact assessment and customer pricing management."
    - name: "avg_quantity_conversion_factor"
      expr: AVG(CAST(quantity_conversion_factor AS DOUBLE))
      comment: "Average quantity conversion factor for substitutions; used for demand planning normalization and inventory equivalence calculations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply agreement metrics covering contracted volume, pricing, service levels, and agreement health. Used by procurement, supply chain, and finance to manage supplier commitments and cost-of-goods."
  source: "`vibe_consumer_goods_v1`.`product`.`supply_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of supply agreement (e.g. Long-Term, Spot, Framework) — used to segment commitment analysis."
    - name: "supply_agreement_status"
      expr: supply_agreement_status
      comment: "Current status of the agreement (e.g. Active, Expired, Pending) — used to filter live vs. historical agreements."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the supply agreement — used for logistics cost and risk allocation analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Flag indicating automatic renewal — used to identify agreements requiring proactive renegotiation."
    - name: "agreement_start_date"
      expr: DATE_TRUNC('year', agreement_start_date)
      comment: "Year the agreement started — used to track agreement vintage and renewal cycles."
    - name: "agreement_end_date"
      expr: DATE_TRUNC('month', agreement_end_date)
      comment: "Month the agreement ends — used to identify upcoming expirations requiring action."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN supply_agreement_status = 'Active' THEN supply_agreement_id END)
      comment: "Number of active supply agreements. Used by procurement to track the live supplier commitment portfolio."
    - name: "total_contracted_volume"
      expr: SUM(CAST(contracted_volume AS DOUBLE))
      comment: "Total contracted volume across all supply agreements. Used by supply chain to assess committed supply coverage."
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total committed volume across supply agreements. Used to track take-or-pay obligations and supply security."
    - name: "avg_agreed_unit_price"
      expr: AVG(CAST(agreed_unit_price AS DOUBLE))
      comment: "Average agreed unit price across supply agreements. Used by procurement and finance to benchmark supplier pricing and track cost trends."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average contracted service level target percentage. Used by supply chain to assess supplier performance commitments."
    - name: "avg_sla_fill_rate_pct"
      expr: AVG(CAST(sla_fill_rate_pct AS DOUBLE))
      comment: "Average SLA fill rate percentage across agreements. Used to benchmark supplier reliability commitments."
    - name: "expiring_within_90_days_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN supply_agreement_id END)
      comment: "Number of supply agreements expiring within 90 days. Used by procurement to trigger renegotiation and prevent supply disruption."
    - name: "avg_annual_volume_commitment"
      expr: AVG(CAST(annual_volume_commitment AS DOUBLE))
      comment: "Average annual volume commitment per agreement. Used for demand planning and supplier capacity allocation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_vmi_sku_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VMI SKU assignment metrics covering inventory policy parameters, replenishment efficiency, and service level targets. Used by supply chain and sales to manage vendor-managed inventory programs."
  source: "`vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment`"
  dimensions:
    - name: "vmi_sku_assignment_status"
      expr: vmi_sku_assignment_status
      comment: "Current status of the VMI SKU assignment — used to filter active vs. inactive VMI arrangements."
    - name: "auto_replenishment_enabled"
      expr: auto_replenishment_enabled
      comment: "Flag indicating whether auto-replenishment is enabled — used to segment automated vs. manual VMI management."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting method used for VMI replenishment — used to assess forecast methodology coverage."
    - name: "replenishment_frequency"
      expr: replenishment_frequency
      comment: "Frequency of replenishment (e.g. Daily, Weekly) — used to segment VMI operational cadence."
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Flag indicating consignment arrangement — used to segment ownership transfer point analysis."
    - name: "assignment_effective_date"
      expr: DATE_TRUNC('month', assignment_effective_date)
      comment: "Month the VMI assignment became effective — used to track VMI program growth over time."
  measures:
    - name: "active_vmi_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_sku_assignment_status = 'Active' THEN vmi_sku_assignment_id END)
      comment: "Number of active VMI SKU assignments. Used by supply chain to track the scale of vendor-managed inventory programs."
    - name: "avg_target_service_level_pct"
      expr: AVG(CAST(target_service_level_pct AS DOUBLE))
      comment: "Average target service level percentage across VMI assignments. Used to benchmark service commitments and identify under-served assignments."
    - name: "avg_safety_stock_qty"
      expr: AVG(CAST(safety_stock_qty AS DOUBLE))
      comment: "Average safety stock quantity across VMI assignments. Used by supply chain to assess inventory buffer levels and working capital impact."
    - name: "avg_max_stock_level"
      expr: AVG(CAST(max_stock_level AS DOUBLE))
      comment: "Average maximum stock level across VMI assignments. Used to assess inventory ceiling policies and storage capacity requirements."
    - name: "avg_min_stock_level"
      expr: AVG(CAST(min_stock_level AS DOUBLE))
      comment: "Average minimum stock level across VMI assignments. Used to assess reorder point policies and stockout risk."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across VMI assignments. Used to calibrate replenishment trigger levels."
    - name: "auto_replenishment_enabled_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_replenishment_enabled = TRUE THEN vmi_sku_assignment_id END) / NULLIF(COUNT(DISTINCT vmi_sku_assignment_id), 0), 2)
      comment: "Percentage of VMI assignments with auto-replenishment enabled. Used to track automation adoption in VMI programs."
$$;
