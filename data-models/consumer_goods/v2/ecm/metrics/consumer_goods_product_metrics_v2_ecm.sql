-- Metric views for domain: product | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU portfolio metrics covering active product count, cost economics, pricing, and lifecycle health. Primary steering dashboard for portfolio management, brand investment, and supply chain planning."
  source: "`vibe_consumer_goods_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "PLM lifecycle stage of the SKU (e.g. Launch, Growth, Mature, Decline, Discontinued) — used to segment portfolio health."
    - name: "sku_status"
      expr: sku_status
      comment: "Current operational status of the SKU — filters active vs. inactive portfolio."
    - name: "portfolio_classification"
      expr: portfolio_classification
      comment: "Strategic portfolio tier (e.g. Core, Innovation, Tail) — key dimension for resource allocation decisions."
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (e.g. liquid, powder, tablet) — used for formulation and manufacturing segmentation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured — relevant for trade compliance and sourcing risk analysis."
    - name: "packaging_material_type"
      expr: packaging_material_type
      comment: "Primary packaging material type — used for sustainability and recyclability reporting."
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory classification of the SKU — used for compliance segmentation."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of SKU launch — enables cohort analysis of new product introductions."
    - name: "is_sustainable"
      expr: is_sustainable
      comment: "Flag indicating whether the SKU meets sustainability criteria — used for ESG portfolio reporting."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous material classification — used for regulatory and logistics risk segmentation."
    - name: "is_regulated_product"
      expr: is_regulated_product
      comment: "Flag indicating whether the SKU is subject to regulatory oversight — used for compliance workload planning."
    - name: "is_recyclable_packaging"
      expr: is_recyclable_packaging
      comment: "Flag indicating recyclable packaging — used for sustainability KPI segmentation."
  measures:
    - name: "active_sku_count"
      expr: COUNT(DISTINCT CASE WHEN sku_status = 'Active' THEN sku_id END)
      comment: "Number of distinct active SKUs in the portfolio. Executives use this to track portfolio breadth and rationalisation progress."
    - name: "total_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Total distinct SKUs across all lifecycle stages. Baseline portfolio size metric for complexity management."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU in USD. Tracks cost structure trends across portfolio segments and informs pricing strategy."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all SKUs. Used to assess aggregate cost exposure by portfolio segment."
    - name: "avg_msrp_usd"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price per SKU. Tracks pricing positioning across portfolio tiers."
    - name: "avg_gross_margin_proxy_usd"
      expr: AVG(CAST(msrp AS DOUBLE) - CAST(standard_cost AS DOUBLE))
      comment: "Average gross margin proxy (MSRP minus standard cost) per SKU. Proxy for profitability before trade spend — used to prioritise portfolio investment."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per SKU in kilograms. Used for logistics cost modelling and packaging efficiency analysis."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per SKU. Used for freight cost estimation and sustainability reporting."
    - name: "sustainable_sku_count"
      expr: COUNT(DISTINCT CASE WHEN is_sustainable = TRUE THEN sku_id END)
      comment: "Number of SKUs flagged as sustainable. Tracks ESG portfolio commitment and progress toward sustainability targets."
    - name: "sustainable_sku_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_sustainable = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of portfolio SKUs that are sustainable. Key ESG KPI reported to board and sustainability committees."
    - name: "recyclable_packaging_sku_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_recyclable_packaging = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of SKUs with recyclable packaging. Tracks packaging sustainability commitments and regulatory readiness."
    - name: "regulated_sku_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_regulated_product = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of portfolio SKUs subject to regulatory oversight. Used to size compliance workload and risk exposure."
    - name: "discontinued_sku_count"
      expr: COUNT(DISTINCT CASE WHEN sku_status = 'Discontinued' THEN sku_id END)
      comment: "Number of discontinued SKUs. Tracks portfolio rationalisation velocity and tail SKU elimination progress."
    - name: "avg_fefo_threshold_pct"
      expr: AVG(CAST(fefo_threshold_pct AS DOUBLE))
      comment: "Average FEFO (First Expired First Out) threshold percentage across SKUs. Used to assess shelf-life risk exposure in inventory planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials governance metrics covering BOM completeness, compliance, and lifecycle status. Used by R&D, manufacturing, and regulatory teams to ensure production readiness and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`product`.`product_bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Production, Engineering, Costing) — used to segment BOM governance by purpose."
    - name: "bom_category"
      expr: bom_category
      comment: "Category classification of the BOM — used for portfolio and manufacturing segmentation."
    - name: "plm_status"
      expr: plm_status
      comment: "PLM lifecycle status of the BOM — used to track design-to-production readiness."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the BOM — critical for compliance gating decisions."
    - name: "gmp_compliant"
      expr: gmp_compliant
      comment: "Flag indicating GMP compliance of the BOM — used for quality and regulatory audit readiness."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Flag indicating REACH chemical regulation compliance — used for EU market access decisions."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Flag indicating RSPO (sustainable palm oil) certification — used for sustainability reporting."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the BOM became effective — used for cohort analysis of BOM introductions."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Flag indicating whether the BOM supports configurable products — used for manufacturing flexibility analysis."
  measures:
    - name: "total_bom_count"
      expr: COUNT(DISTINCT product_bom_id)
      comment: "Total number of distinct BOMs. Baseline measure for BOM portfolio size and governance workload."
    - name: "approved_bom_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_status = 'Approved' THEN product_bom_id END)
      comment: "Number of BOMs with regulatory approval. Tracks production readiness and compliance gate passage."
    - name: "approved_bom_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_approval_status = 'Approved' THEN product_bom_id END) / NULLIF(COUNT(DISTINCT product_bom_id), 0), 2)
      comment: "Percentage of BOMs with regulatory approval. Key compliance KPI for manufacturing readiness reviews."
    - name: "gmp_compliant_bom_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gmp_compliant = TRUE THEN product_bom_id END) / NULLIF(COUNT(DISTINCT product_bom_id), 0), 2)
      comment: "Percentage of BOMs that are GMP compliant. Used in quality steering meetings to track manufacturing standards adherence."
    - name: "reach_compliant_bom_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reach_compliant = TRUE THEN product_bom_id END) / NULLIF(COUNT(DISTINCT product_bom_id), 0), 2)
      comment: "Percentage of BOMs compliant with REACH chemical regulations. Tracks EU market access risk."
    - name: "rspo_certified_bom_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rspo_certified = TRUE THEN product_bom_id END) / NULLIF(COUNT(DISTINCT product_bom_id), 0), 2)
      comment: "Percentage of BOMs with RSPO certification. Tracks sustainable sourcing commitments in the product portfolio."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base production quantity across BOMs. Used for batch size optimisation and capacity planning."
    - name: "avg_lot_size_from"
      expr: AVG(CAST(lot_size_from AS DOUBLE))
      comment: "Average minimum lot size across BOMs. Used to assess manufacturing flexibility and minimum order constraints."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM line-level metrics covering component cost, scrap, hazardous material exposure, and critical component coverage. Used by supply chain, manufacturing, and sustainability teams for cost and risk management."
  source: "`vibe_consumer_goods_v1`.`product`.`bom_line`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of BOM component (e.g. raw material, packaging, semi-finished) — used to segment cost and risk by component category."
    - name: "bom_item_category"
      expr: bom_item_category
      comment: "BOM item category classification — used for procurement and manufacturing segmentation."
    - name: "issue_method"
      expr: issue_method
      comment: "Method by which the component is issued to production (e.g. backflush, manual) — used for process efficiency analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating hazardous material — used for EHS compliance and logistics risk segmentation."
    - name: "is_critical_component"
      expr: is_critical_component
      comment: "Flag indicating whether the component is critical to production — used for supply risk prioritisation."
    - name: "co_product_flag"
      expr: co_product_flag
      comment: "Flag indicating co-product (by-product) status — used for cost allocation and sustainability reporting."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the BOM line — used to filter active vs. obsolete components."
    - name: "valid_from_date"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month the BOM line became valid — used for component change tracking over time."
  measures:
    - name: "total_component_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE))
      comment: "Total component cost across all BOM lines in USD. Primary cost driver metric for COGS analysis and supplier negotiation."
    - name: "avg_component_cost_usd"
      expr: AVG(CAST(component_cost_usd AS DOUBLE))
      comment: "Average component cost per BOM line. Used to benchmark component pricing and identify cost outliers."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOM lines. Tracks material waste and drives yield improvement initiatives."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total required quantity across all BOM lines. Used for material requirements planning and procurement volume estimation."
    - name: "avg_required_quantity"
      expr: AVG(CAST(required_quantity AS DOUBLE))
      comment: "Average required quantity per BOM line. Used for batch size normalisation and yield analysis."
    - name: "hazardous_component_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hazardous_material_flag = TRUE THEN bom_line_id END) / NULLIF(COUNT(DISTINCT bom_line_id), 0), 2)
      comment: "Percentage of BOM lines containing hazardous materials. Tracks EHS risk exposure and regulatory compliance burden."
    - name: "critical_component_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_critical_component = TRUE THEN bom_line_id END) / NULLIF(COUNT(DISTINCT bom_line_id), 0), 2)
      comment: "Percentage of BOM lines flagged as critical components. Used to prioritise supply risk mitigation and dual-sourcing strategies."
    - name: "avg_usage_probability_pct"
      expr: AVG(CAST(usage_probability_pct AS DOUBLE))
      comment: "Average usage probability percentage across BOM lines. Used for probabilistic material requirements planning in configurable BOMs."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across BOM components. Used to assess procurement flexibility and inventory carrying cost."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product formulation portfolio metrics covering regulatory approval, sustainability credentials, and lifecycle stage distribution. Used by R&D, regulatory affairs, and sustainability teams to govern formulation readiness."
  source: "`vibe_consumer_goods_v1`.`product`.`product_formulation`"
  dimensions:
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (e.g. rinse-off, leave-on, food, beverage) — used to segment regulatory and compliance requirements."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "PLM lifecycle stage of the formulation — used to track R&D pipeline progression."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the formulation — critical gate for market launch decisions."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Flag indicating GMP compliance — used for quality and manufacturing readiness segmentation."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Flag indicating vegan formulation — used for consumer segment targeting and labelling compliance."
    - name: "is_cruelty_free"
      expr: is_cruelty_free
      comment: "Flag indicating cruelty-free status — used for ethical sourcing and market access decisions."
    - name: "is_fragrance_free"
      expr: is_fragrance_free
      comment: "Flag indicating fragrance-free formulation — used for sensitive skin and hypoallergenic product segmentation."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Flag indicating RSPO certification — used for sustainable palm oil sourcing compliance."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the formulation became effective — used for pipeline cohort analysis."
  measures:
    - name: "total_formulation_count"
      expr: COUNT(DISTINCT product_formulation_id)
      comment: "Total number of distinct product formulations. Baseline measure for R&D pipeline size and formulation portfolio complexity."
    - name: "approved_formulation_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_status = 'Approved' THEN product_formulation_id END)
      comment: "Number of formulations with regulatory approval. Tracks pipeline conversion to market-ready status."
    - name: "approved_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_approval_status = 'Approved' THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of formulations with regulatory approval. Key R&D pipeline health KPI for steering meetings."
    - name: "gmp_compliant_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gmp_compliance_flag = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of formulations that are GMP compliant. Tracks manufacturing quality standards adherence across the formulation portfolio."
    - name: "vegan_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_vegan = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of vegan formulations in the portfolio. Tracks alignment with consumer ethical preferences and market positioning."
    - name: "cruelty_free_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_cruelty_free = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of cruelty-free formulations. Tracks ethical sourcing commitments and market access in cruelty-free regulated markets."
    - name: "rspo_certified_formulation_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rspo_certified = TRUE THEN product_formulation_id END) / NULLIF(COUNT(DISTINCT product_formulation_id), 0), 2)
      comment: "Percentage of formulations with RSPO certification. Tracks sustainable palm oil sourcing compliance across the formulation portfolio."
    - name: "avg_active_ingredient_pct"
      expr: AVG(CAST(active_ingredient_pct AS DOUBLE))
      comment: "Average active ingredient concentration percentage across formulations. Used to benchmark product efficacy and differentiation."
    - name: "avg_total_solid_content_pct"
      expr: AVG(CAST(total_solid_content_pct AS DOUBLE))
      comment: "Average total solid content percentage across formulations. Used for manufacturing process optimisation and cost modelling."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_formulation_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulation ingredient compliance and risk metrics covering restricted substances, REACH registration, and natural origin content. Used by regulatory affairs, R&D, and sustainability teams to manage ingredient risk."
  source: "`vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient`"
  dimensions:
    - name: "ingredient_function"
      expr: ingredient_function
      comment: "Functional role of the ingredient (e.g. preservative, emulsifier, active) — used to segment compliance risk by ingredient type."
    - name: "ingredient_status"
      expr: ingredient_status
      comment: "Current status of the ingredient in the formulation — used to filter active vs. obsolete ingredients."
    - name: "fda_status"
      expr: fda_status
      comment: "FDA regulatory status of the ingredient — used for US market compliance segmentation."
    - name: "reach_registration_status"
      expr: reach_registration_status
      comment: "REACH registration status — used for EU chemical compliance tracking."
    - name: "is_active_ingredient"
      expr: is_active_ingredient
      comment: "Flag indicating active ingredient status — used to segment efficacy-critical components."
    - name: "is_prohibited_substance"
      expr: is_prohibited_substance
      comment: "Flag indicating prohibited substance — critical compliance dimension for regulatory risk management."
    - name: "is_restricted_substance"
      expr: is_restricted_substance
      comment: "Flag indicating restricted substance — used for regulatory limit monitoring and compliance reporting."
    - name: "svhc_flag"
      expr: svhc_flag
      comment: "Flag indicating Substance of Very High Concern (SVHC) under REACH — used for EU regulatory risk prioritisation."
    - name: "is_natural_origin"
      expr: is_natural_origin
      comment: "Flag indicating natural origin ingredient — used for natural/organic product claim substantiation."
    - name: "is_palm_derived"
      expr: is_palm_derived
      comment: "Flag indicating palm-derived ingredient — used for RSPO compliance and deforestation risk tracking."
    - name: "halal_status"
      expr: halal_status
      comment: "Halal certification status of the ingredient — used for market access in halal-regulated markets."
    - name: "vegan_status"
      expr: vegan_status
      comment: "Vegan status of the ingredient — used for vegan product claim validation."
  measures:
    - name: "total_ingredient_count"
      expr: COUNT(DISTINCT product_formulation_ingredient_id)
      comment: "Total number of distinct formulation ingredient records. Baseline measure for ingredient portfolio complexity."
    - name: "prohibited_substance_count"
      expr: COUNT(DISTINCT CASE WHEN is_prohibited_substance = TRUE THEN product_formulation_ingredient_id END)
      comment: "Number of ingredient records flagged as prohibited substances. Critical compliance KPI — any non-zero value triggers immediate regulatory action."
    - name: "svhc_ingredient_count"
      expr: COUNT(DISTINCT CASE WHEN svhc_flag = TRUE THEN product_formulation_ingredient_id END)
      comment: "Number of SVHC-flagged ingredient records. Tracks EU REACH compliance risk and drives substitution programmes."
    - name: "restricted_substance_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_restricted_substance = TRUE THEN product_formulation_ingredient_id END) / NULLIF(COUNT(DISTINCT product_formulation_ingredient_id), 0), 2)
      comment: "Percentage of ingredient records that are restricted substances. Used to assess regulatory compliance burden and reformulation risk."
    - name: "natural_origin_ingredient_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_natural_origin = TRUE THEN product_formulation_ingredient_id END) / NULLIF(COUNT(DISTINCT product_formulation_ingredient_id), 0), 2)
      comment: "Percentage of ingredients from natural origin. Tracks natural product positioning and supports claim substantiation."
    - name: "avg_natural_origin_index"
      expr: AVG(CAST(natural_origin_index AS DOUBLE))
      comment: "Average natural origin index across ingredients. Quantifies the degree of natural origin content for product positioning and certification."
    - name: "avg_concentration_nominal_pct"
      expr: AVG(CAST(concentration_nominal_pct AS DOUBLE))
      comment: "Average nominal concentration percentage across ingredients. Used for formulation benchmarking and regulatory limit compliance."
    - name: "avg_regulatory_max_concentration_pct"
      expr: AVG(CAST(regulatory_max_concentration_pct AS DOUBLE))
      comment: "Average regulatory maximum concentration limit across ingredients. Used to assess headroom to regulatory limits and reformulation risk."
    - name: "palm_derived_ingredient_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_palm_derived = TRUE THEN product_formulation_ingredient_id END) / NULLIF(COUNT(DISTINCT product_formulation_ingredient_id), 0), 2)
      comment: "Percentage of palm-derived ingredients. Tracks deforestation risk exposure and RSPO certification scope."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification portfolio metrics covering certification status, cost, and renewal risk. Used by regulatory affairs, sustainability, and commercial teams to manage certification compliance and retailer requirements."
  source: "`vibe_consumer_goods_v1`.`product`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. organic, fair trade, B Corp, ISO) — used to segment compliance investment by certification category."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Pending) — used to track compliance portfolio health."
    - name: "sustainability_pillar"
      expr: sustainability_pillar
      comment: "Sustainability pillar the certification supports (e.g. environmental, social, governance) — used for ESG reporting segmentation."
    - name: "consumer_facing_flag"
      expr: consumer_facing_flag
      comment: "Flag indicating whether the certification is visible to consumers — used to prioritise consumer trust investments."
    - name: "retailer_requirement_flag"
      expr: retailer_requirement_flag
      comment: "Flag indicating retailer-mandated certification — used to prioritise compliance spend by commercial necessity."
    - name: "applicable_markets"
      expr: applicable_markets
      comment: "Markets where the certification applies — used for geographic compliance segmentation."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of certification expiry — used to identify near-term renewal risk."
    - name: "audit_result"
      expr: audit_result
      comment: "Result of the most recent certification audit — used to track compliance quality."
  measures:
    - name: "active_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of active certifications across the product portfolio. Tracks compliance coverage and certification portfolio breadth."
    - name: "total_certification_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications in USD. Tracks compliance investment and informs certification ROI analysis."
    - name: "avg_certification_cost_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Used to benchmark certification spend and identify cost optimisation opportunities."
    - name: "retailer_required_certification_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN retailer_requirement_flag = TRUE THEN certification_id END) / NULLIF(COUNT(DISTINCT certification_id), 0), 2)
      comment: "Percentage of certifications that are retailer-mandated. Tracks commercial compliance obligations vs. voluntary sustainability investments."
    - name: "consumer_facing_certification_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consumer_facing_flag = TRUE THEN certification_id END) / NULLIF(COUNT(DISTINCT certification_id), 0), 2)
      comment: "Percentage of certifications that are consumer-facing. Tracks brand trust investment and on-pack claim coverage."
    - name: "logo_approved_certification_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN logo_usage_approved = TRUE THEN certification_id END) / NULLIF(COUNT(DISTINCT certification_id), 0), 2)
      comment: "Percentage of certifications with approved logo usage. Tracks readiness to use certification marks in marketing and packaging."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product claim compliance and governance metrics covering claim approval rates, legal review status, and regulatory compliance. Used by legal, regulatory, and marketing teams to manage claim risk and substantiation."
  source: "`vibe_consumer_goods_v1`.`product`.`product_claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of product claim (e.g. efficacy, environmental, nutritional, safety) — used to segment compliance risk by claim category."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (e.g. Approved, Pending, Withdrawn) — used to track claim portfolio health."
    - name: "claim_scope"
      expr: claim_scope
      comment: "Scope of the claim (e.g. global, regional, market-specific) — used for geographic compliance segmentation."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body governing the claim — used to segment compliance workload by jurisdiction."
    - name: "fda_reviewed"
      expr: fda_reviewed
      comment: "Flag indicating FDA review completion — used for US market claim compliance tracking."
    - name: "ftc_compliant"
      expr: ftc_compliant
      comment: "Flag indicating FTC compliance — used for US advertising standards compliance."
    - name: "legal_reviewed"
      expr: legal_reviewed
      comment: "Flag indicating legal review completion — used to track claim governance process adherence."
    - name: "marketing_approved"
      expr: marketing_approved
      comment: "Flag indicating marketing approval — used to track claim readiness for commercial use."
    - name: "quantitative_claim"
      expr: quantitative_claim
      comment: "Flag indicating quantitative claim (requires stronger substantiation) — used to prioritise substantiation investment."
    - name: "plm_stage"
      expr: plm_stage
      comment: "PLM stage at which the claim is being managed — used to track claim development pipeline."
  measures:
    - name: "total_claim_count"
      expr: COUNT(DISTINCT product_claim_id)
      comment: "Total number of distinct product claims. Baseline measure for claim portfolio size and governance workload."
    - name: "approved_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'Approved' THEN product_claim_id END)
      comment: "Number of approved product claims. Tracks claim portfolio readiness for commercial deployment."
    - name: "approved_claim_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN claim_status = 'Approved' THEN product_claim_id END) / NULLIF(COUNT(DISTINCT product_claim_id), 0), 2)
      comment: "Percentage of claims with approved status. Key governance KPI for claim compliance steering reviews."
    - name: "legal_reviewed_claim_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN legal_reviewed = TRUE THEN product_claim_id END) / NULLIF(COUNT(DISTINCT product_claim_id), 0), 2)
      comment: "Percentage of claims that have completed legal review. Tracks governance process adherence and legal risk exposure."
    - name: "withdrawn_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'Withdrawn' THEN product_claim_id END)
      comment: "Number of withdrawn claims. Tracks claim risk materialisation and regulatory enforcement actions."
    - name: "quantitative_claim_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quantitative_claim = TRUE THEN product_claim_id END) / NULLIF(COUNT(DISTINCT product_claim_id), 0), 2)
      comment: "Percentage of claims that are quantitative. Quantitative claims require stronger substantiation — used to size R&D and legal investment."
    - name: "avg_claim_value"
      expr: AVG(CAST(claim_value AS DOUBLE))
      comment: "Average quantitative claim value. Used to benchmark claim magnitude and assess substantiation requirements."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_plm_transition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PLM stage gate transition metrics covering pipeline velocity, fast-track rates, and regulatory submission requirements. Used by R&D leadership and portfolio management to steer innovation pipeline throughput."
  source: "`vibe_consumer_goods_v1`.`product`.`plm_transition`"
  dimensions:
    - name: "from_stage_code"
      expr: from_stage_code
      comment: "PLM stage the product is transitioning from — used to identify pipeline bottlenecks by stage."
    - name: "to_stage_code"
      expr: to_stage_code
      comment: "PLM stage the product is transitioning to — used to track pipeline progression."
    - name: "transition_status"
      expr: transition_status
      comment: "Current status of the stage gate transition (e.g. Approved, Pending, Rejected) — used to track gate passage rates."
    - name: "transition_type"
      expr: transition_type
      comment: "Type of PLM transition (e.g. stage advance, hold, kill) — used to segment pipeline health by decision type."
    - name: "is_fast_track"
      expr: is_fast_track
      comment: "Flag indicating fast-track development — used to track accelerated innovation pipeline."
    - name: "regulatory_submission_required"
      expr: regulatory_submission_required
      comment: "Flag indicating regulatory submission requirement — used to size regulatory affairs workload."
    - name: "transition_date"
      expr: DATE_TRUNC('month', transition_date)
      comment: "Month of the PLM transition — used for pipeline velocity trend analysis."
    - name: "transition_reason_code"
      expr: transition_reason_code
      comment: "Reason code for the transition — used to identify systemic pipeline issues (e.g. regulatory hold, resource constraint)."
  measures:
    - name: "total_transition_count"
      expr: COUNT(DISTINCT plm_transition_id)
      comment: "Total number of PLM stage gate transitions. Baseline measure for innovation pipeline activity and throughput."
    - name: "approved_transition_count"
      expr: COUNT(DISTINCT CASE WHEN transition_status = 'Approved' THEN plm_transition_id END)
      comment: "Number of approved stage gate transitions. Tracks pipeline advancement velocity and gate passage success rate."
    - name: "gate_passage_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN transition_status = 'Approved' THEN plm_transition_id END) / NULLIF(COUNT(DISTINCT plm_transition_id), 0), 2)
      comment: "Percentage of stage gate transitions that are approved. Key innovation pipeline health KPI — low rates indicate R&D quality or resource issues."
    - name: "fast_track_transition_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_fast_track = TRUE THEN plm_transition_id END) / NULLIF(COUNT(DISTINCT plm_transition_id), 0), 2)
      comment: "Percentage of transitions on fast-track development path. Tracks agility of innovation pipeline and speed-to-market capability."
    - name: "regulatory_submission_required_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_submission_required = TRUE THEN plm_transition_id END) / NULLIF(COUNT(DISTINCT plm_transition_id), 0), 2)
      comment: "Percentage of transitions requiring regulatory submission. Used to forecast regulatory affairs workload and timeline risk."
    - name: "avg_stage_duration_days"
      expr: AVG(DATEDIFF(stage_exit_date, stage_entry_date))
      comment: "Average number of days spent in a PLM stage (exit date minus entry date). Tracks pipeline velocity and identifies stage-level bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging specification metrics covering cost, sustainability credentials, and compliance status. Used by packaging engineering, procurement, and sustainability teams to optimise packaging cost and environmental impact."
  source: "`vibe_consumer_goods_v1`.`product`.`product_packaging_spec`"
  dimensions:
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging hierarchy level (e.g. primary, secondary, tertiary) — used to segment cost and sustainability by packaging tier."
    - name: "component_type"
      expr: component_type
      comment: "Type of packaging component (e.g. bottle, cap, label, carton) — used for material-level cost and sustainability analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the packaging spec — used to filter active vs. obsolete specifications."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the packaging spec — used to track specification governance."
    - name: "is_fsc_certified"
      expr: is_fsc_certified
      comment: "Flag indicating FSC (Forest Stewardship Council) certification — used for sustainable forestry compliance reporting."
    - name: "is_rspo_certified"
      expr: is_rspo_certified
      comment: "Flag indicating RSPO certification for palm-derived packaging materials — used for sustainable sourcing compliance."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance of the packaging spec — used for market access risk assessment."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous material in packaging — used for EHS and logistics compliance segmentation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the packaging component — used for trade compliance and sourcing risk analysis."
  measures:
    - name: "total_unit_cost_usd"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost across all packaging specifications in USD. Primary packaging cost metric for COGS and procurement negotiations."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per packaging specification. Used to benchmark packaging cost and identify cost reduction opportunities."
    - name: "avg_pcr_content_pct"
      expr: AVG(CAST(pcr_content_pct AS DOUBLE))
      comment: "Average post-consumer recycled (PCR) content percentage across packaging specs. Key sustainability KPI for packaging circularity commitments."
    - name: "fsc_certified_spec_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_fsc_certified = TRUE THEN product_packaging_spec_id END) / NULLIF(COUNT(DISTINCT product_packaging_spec_id), 0), 2)
      comment: "Percentage of packaging specs with FSC certification. Tracks sustainable forestry sourcing compliance."
    - name: "regulatory_compliant_spec_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = TRUE THEN product_packaging_spec_id END) / NULLIF(COUNT(DISTINCT product_packaging_spec_id), 0), 2)
      comment: "Percentage of packaging specs that are regulatory compliant. Tracks market access readiness and compliance risk."
    - name: "avg_gross_weight_g"
      expr: AVG(CAST(gross_weight_g AS DOUBLE))
      comment: "Average gross weight of packaging components in grams. Used for logistics cost modelling and packaging lightweighting initiatives."
    - name: "avg_tare_weight_g"
      expr: AVG(CAST(tare_weight_g AS DOUBLE))
      comment: "Average tare weight of packaging in grams. Used to assess packaging material efficiency and lightweighting progress."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GTIN registry metrics covering GS1 publication status, data pool readiness, and market coverage. Used by supply chain, commercial, and regulatory teams to ensure product identification compliance and retail readiness."
  source: "`vibe_consumer_goods_v1`.`product`.`gtin_registry`"
  dimensions:
    - name: "gtin_format"
      expr: gtin_format
      comment: "GTIN format (e.g. GTIN-8, GTIN-12, GTIN-13, GTIN-14) — used to segment registry by barcode standard."
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging level associated with the GTIN (e.g. consumer unit, case, pallet) — used for supply chain identification analysis."
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the GTIN — used to track registry completeness."
    - name: "gs1_registry_published"
      expr: gs1_registry_published
      comment: "Flag indicating GS1 registry publication — used to track global product identification readiness."
    - name: "data_pool_published"
      expr: data_pool_published
      comment: "Flag indicating data pool publication — used to track retail data synchronisation readiness."
    - name: "is_orderable"
      expr: is_orderable
      comment: "Flag indicating whether the GTIN is orderable — used to track commercial availability."
    - name: "target_market_country"
      expr: target_market_country
      comment: "Target market country for the GTIN — used for geographic market coverage analysis."
    - name: "plm_lifecycle_stage"
      expr: plm_lifecycle_stage
      comment: "PLM lifecycle stage of the registered product — used to segment registry by product maturity."
  measures:
    - name: "total_gtin_count"
      expr: COUNT(DISTINCT gtin_registry_id)
      comment: "Total number of registered GTINs. Baseline measure for product identification portfolio size."
    - name: "gs1_published_gtin_count"
      expr: COUNT(DISTINCT CASE WHEN gs1_registry_published = TRUE THEN gtin_registry_id END)
      comment: "Number of GTINs published to the GS1 registry. Tracks global product identification compliance and retail readiness."
    - name: "gs1_publication_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gs1_registry_published = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(DISTINCT gtin_registry_id), 0), 2)
      comment: "Percentage of GTINs published to GS1 registry. Key retail readiness KPI — low rates indicate supply chain identification gaps."
    - name: "data_pool_publication_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_pool_published = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(DISTINCT gtin_registry_id), 0), 2)
      comment: "Percentage of GTINs published to retail data pools. Tracks data synchronisation readiness with retail trading partners."
    - name: "orderable_gtin_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_orderable = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(DISTINCT gtin_registry_id), 0), 2)
      comment: "Percentage of GTINs that are orderable. Tracks commercial availability of registered products."
    - name: "avg_net_content_value"
      expr: AVG(CAST(net_content_value AS DOUBLE))
      comment: "Average net content value across registered GTINs. Used for pack size benchmarking and consumer value analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku_substitution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU substitution metrics covering substitution approval rates, auto-substitution enablement, and price impact. Used by supply chain, commercial, and customer service teams to manage product availability and substitution risk."
  source: "`vibe_consumer_goods_v1`.`product`.`sku_substitution`"
  dimensions:
    - name: "substitution_type"
      expr: substitution_type
      comment: "Type of substitution (e.g. permanent, temporary, emergency) — used to segment substitution risk by business context."
    - name: "substitution_status"
      expr: substitution_status
      comment: "Current status of the substitution record — used to filter active vs. expired substitutions."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the substitution — used to track governance process adherence."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for the substitution (e.g. discontinuation, shortage, reformulation) — used to identify root causes of substitution activity."
    - name: "auto_substitution_allowed"
      expr: auto_substitution_allowed
      comment: "Flag indicating whether automatic substitution is permitted — used to assess supply chain automation readiness."
    - name: "is_bidirectional"
      expr: is_bidirectional
      comment: "Flag indicating bidirectional substitution — used to assess substitution network flexibility."
    - name: "customer_approval_required"
      expr: customer_approval_required
      comment: "Flag indicating customer approval is required — used to assess commercial risk of substitution execution."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the substitution became effective — used for substitution activity trend analysis."
  measures:
    - name: "active_substitution_count"
      expr: COUNT(DISTINCT CASE WHEN substitution_status = 'Active' THEN sku_substitution_id END)
      comment: "Number of active SKU substitutions. Tracks current supply chain flexibility and product availability risk mitigation."
    - name: "auto_substitution_enabled_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_substitution_allowed = TRUE THEN sku_substitution_id END) / NULLIF(COUNT(DISTINCT sku_substitution_id), 0), 2)
      comment: "Percentage of substitutions with auto-substitution enabled. Tracks supply chain automation capability and order fulfilment resilience."
    - name: "customer_approval_required_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN customer_approval_required = TRUE THEN sku_substitution_id END) / NULLIF(COUNT(DISTINCT sku_substitution_id), 0), 2)
      comment: "Percentage of substitutions requiring customer approval. Tracks commercial friction in substitution execution and service level risk."
    - name: "avg_price_adjustment_pct"
      expr: AVG(CAST(price_adjustment_pct AS DOUBLE))
      comment: "Average price adjustment percentage applied in substitutions. Tracks revenue impact of substitution activity."
    - name: "avg_cogs_impact_pct"
      expr: AVG(CAST(cogs_impact_pct AS DOUBLE))
      comment: "Average COGS impact percentage of substitutions. Tracks cost implications of substitution decisions for margin management."
    - name: "avg_quantity_conversion_factor"
      expr: AVG(CAST(quantity_conversion_factor AS DOUBLE))
      comment: "Average quantity conversion factor across substitutions. Used to assess pack size equivalence and demand planning accuracy in substitution scenarios."
$$;