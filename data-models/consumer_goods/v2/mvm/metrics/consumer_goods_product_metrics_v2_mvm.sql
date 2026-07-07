-- Metric views for domain: product | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the SKU master. Covers portfolio health, cost benchmarking, sustainability posture, and lifecycle stage distribution — all critical inputs for product portfolio steering, pricing, and sustainability reporting."
  source: "`vibe_consumer_goods_v1`.`product`.`sku`"
  dimensions:
    - name: "sku_lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the SKU (e.g. Introduction, Growth, Maturity, Decline). Used to segment portfolio health and prioritise investment or discontinuation decisions."
    - name: "sku_status"
      expr: sku_status
      comment: "Operational status of the SKU (e.g. Active, Discontinued, Pending). Drives availability and assortment planning."
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (e.g. Liquid, Powder, Cream). Enables cross-form portfolio analysis."
    - name: "portfolio_classification"
      expr: portfolio_classification
      comment: "Strategic portfolio tier (e.g. Core, Premium, Value). Used for investment prioritisation and margin management."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured or sourced. Relevant for trade compliance, tariff exposure, and supply risk analysis."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Intended consumer demographic for the SKU. Supports segmentation of portfolio performance by consumer cohort."
    - name: "packaging_material_type"
      expr: packaging_material_type
      comment: "Primary packaging material type. Used for sustainability reporting and packaging cost analysis."
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory classification of the SKU. Critical for compliance reporting and market access decisions."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of SKU launch. Enables cohort analysis of new product introductions and time-to-market tracking."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month of SKU discontinuation. Used to track portfolio rationalisation cadence."
    - name: "sub_brand"
      expr: sub_brand
      comment: "Sub-brand the SKU belongs to. Enables brand architecture performance analysis."
    - name: "is_sustainable"
      expr: is_sustainable
      comment: "Flag indicating whether the SKU meets sustainability criteria. Used for ESG portfolio reporting."
    - name: "is_regulated_product"
      expr: is_regulated_product
      comment: "Flag indicating whether the SKU is subject to regulatory oversight. Drives compliance workload planning."
    - name: "is_recyclable_packaging"
      expr: is_recyclable_packaging
      comment: "Flag indicating whether the SKU uses recyclable packaging. Key ESG and sustainability KPI dimension."
  measures:
    - name: "active_sku_count"
      expr: COUNT(CASE WHEN sku_status = 'Active' THEN sku_id END)
      comment: "Number of currently active SKUs in the portfolio. Core portfolio size KPI used in executive portfolio reviews."
    - name: "total_sku_count"
      expr: COUNT(sku_id)
      comment: "Total number of SKUs across all statuses. Baseline for portfolio breadth and complexity assessment."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU in USD. Benchmarks cost efficiency across portfolio segments and informs pricing strategy."
    - name: "avg_msrp_usd"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price per SKU. Used to assess pricing positioning and margin potential by segment."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all SKUs. Represents the aggregate cost base of the product portfolio for financial planning."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per SKU in kilograms. Used for logistics cost modelling and packaging optimisation."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per SKU. Supports fill-rate and net-content compliance monitoring."
    - name: "avg_volume_ml"
      expr: AVG(CAST(volume_ml AS DOUBLE))
      comment: "Average product volume in millilitres. Used for packaging design benchmarking and consumer value analysis."
    - name: "sustainable_sku_count"
      expr: COUNT(CASE WHEN is_sustainable = TRUE THEN sku_id END)
      comment: "Number of SKUs flagged as sustainable. Core ESG KPI for sustainability target tracking and investor reporting."
    - name: "recyclable_packaging_sku_count"
      expr: COUNT(CASE WHEN is_recyclable_packaging = TRUE THEN sku_id END)
      comment: "Number of SKUs with recyclable packaging. Tracks progress against packaging sustainability commitments."
    - name: "regulated_sku_count"
      expr: COUNT(CASE WHEN is_regulated_product = TRUE THEN sku_id END)
      comment: "Number of SKUs subject to regulatory oversight. Drives compliance resource allocation and risk exposure assessment."
    - name: "hazardous_sku_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN sku_id END)
      comment: "Number of SKUs classified as hazardous. Critical for EHS compliance, logistics restrictions, and regulatory reporting."
    - name: "avg_fefo_threshold_pct"
      expr: AVG(CAST(fefo_threshold_pct AS DOUBLE))
      comment: "Average First-Expired-First-Out threshold percentage across SKUs. Informs inventory management policy and waste reduction strategy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio health and investment metrics. Tracks brand lifecycle, geographic reach, licensing exposure, and trade promotion eligibility — essential for brand strategy and portfolio investment decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`product_brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current operational status of the brand (e.g. Active, Divested, Archived). Used to filter live portfolio from historical records."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Strategic tier of the brand (e.g. Premium, Mass, Value). Core dimension for investment prioritisation and margin analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic reach of the brand (e.g. Global, Regional, Local). Used for market expansion and resource allocation decisions."
    - name: "owner_division"
      expr: owner_division
      comment: "Business division that owns the brand. Enables P&L attribution and divisional portfolio performance analysis."
    - name: "architecture_type"
      expr: architecture_type
      comment: "Brand architecture classification (e.g. Masterbrand, Endorsed, Standalone). Supports brand strategy and portfolio simplification initiatives."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Primary distribution channel for the brand. Used for channel strategy and trade investment analysis."
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "Primary market country for the brand. Enables geographic portfolio analysis and market prioritisation."
    - name: "is_licensed_brand"
      expr: is_licensed_brand
      comment: "Flag indicating whether the brand is licensed from a third party. Drives licensing cost and risk exposure analysis."
    - name: "trade_promotion_eligible"
      expr: trade_promotion_eligible
      comment: "Flag indicating whether the brand is eligible for trade promotions. Used for trade spend planning and ROI analysis."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year of brand launch. Enables brand age cohort analysis and portfolio vintage assessment."
    - name: "plm_stage"
      expr: plm_stage
      comment: "Product lifecycle management stage of the brand. Used to align brand investment with lifecycle position."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the brand. Relevant for compliance planning and market access strategy."
  measures:
    - name: "active_brand_count"
      expr: COUNT(CASE WHEN brand_status = 'Active' THEN product_brand_id END)
      comment: "Number of currently active brands in the portfolio. Core brand portfolio size KPI for executive brand reviews."
    - name: "total_brand_count"
      expr: COUNT(product_brand_id)
      comment: "Total number of brands across all statuses. Baseline for portfolio breadth and complexity management."
    - name: "licensed_brand_count"
      expr: COUNT(CASE WHEN is_licensed_brand = TRUE THEN product_brand_id END)
      comment: "Number of licensed brands in the portfolio. Tracks licensing dependency and associated financial risk exposure."
    - name: "trade_promotion_eligible_brand_count"
      expr: COUNT(CASE WHEN trade_promotion_eligible = TRUE THEN product_brand_id END)
      comment: "Number of brands eligible for trade promotions. Informs trade spend budget allocation and promotional planning."
    - name: "nps_tracked_brand_count"
      expr: COUNT(CASE WHEN nps_tracking_enabled = TRUE THEN product_brand_id END)
      comment: "Number of brands with NPS tracking enabled. Indicates the breadth of consumer sentiment measurement across the portfolio."
    - name: "avg_brand_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average financial amount associated with brands. Used as a proxy for brand investment or valuation benchmarking across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D and formulation portfolio metrics. Tracks formulation lifecycle, regulatory compliance, sustainability attributes, and ingredient profile — critical for R&D investment decisions, regulatory submissions, and sustainability commitments."
  source: "`vibe_consumer_goods_v1`.`product`.`formulation`"
  dimensions:
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (e.g. Emulsion, Suspension, Gel). Used to segment R&D portfolio by technology platform."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the formulation (e.g. Development, Active, Obsolete). Drives R&D pipeline and obsolescence management."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the formulation. Critical for market access planning and compliance risk assessment."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the formulation. Used for compliance reporting and market authorisation tracking."
    - name: "product_category"
      expr: product_category
      comment: "Product category the formulation belongs to. Enables cross-category R&D portfolio analysis."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Flag indicating whether the formulation is vegan. Key sustainability and consumer preference dimension."
    - name: "is_cruelty_free"
      expr: is_cruelty_free
      comment: "Flag indicating whether the formulation is cruelty-free. Critical for brand positioning and regulatory compliance in key markets."
    - name: "is_fragrance_free"
      expr: is_fragrance_free
      comment: "Flag indicating whether the formulation is fragrance-free. Relevant for sensitive-skin product lines and allergen compliance."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Flag indicating GMP compliance of the formulation. Mandatory for quality and regulatory audit readiness."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Flag indicating RSPO (sustainable palm oil) certification. Tracks sustainable sourcing commitments in formulations."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions for the formulation. Used for supply chain and logistics planning."
    - name: "approval_date"
      expr: DATE_TRUNC('quarter', approval_date)
      comment: "Quarter of formulation approval. Tracks R&D throughput and time-to-approval trends."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the formulation became effective. Used for portfolio vintage and lifecycle cohort analysis."
  measures:
    - name: "active_formulation_count"
      expr: COUNT(CASE WHEN lifecycle_stage = 'Active' THEN formulation_id END)
      comment: "Number of active formulations in the R&D portfolio. Core R&D pipeline KPI for executive and innovation reviews."
    - name: "total_formulation_count"
      expr: COUNT(formulation_id)
      comment: "Total number of formulations across all lifecycle stages. Baseline for R&D portfolio breadth and complexity."
    - name: "gmp_compliant_formulation_count"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN formulation_id END)
      comment: "Number of GMP-compliant formulations. Tracks regulatory readiness and quality compliance across the R&D portfolio."
    - name: "vegan_formulation_count"
      expr: COUNT(CASE WHEN is_vegan = TRUE THEN formulation_id END)
      comment: "Number of vegan formulations. Tracks progress against vegan product portfolio commitments and consumer demand alignment."
    - name: "cruelty_free_formulation_count"
      expr: COUNT(CASE WHEN is_cruelty_free = TRUE THEN formulation_id END)
      comment: "Number of cruelty-free formulations. Key ESG and brand positioning KPI for consumer goods companies."
    - name: "rspo_certified_formulation_count"
      expr: COUNT(CASE WHEN rspo_certified = TRUE THEN formulation_id END)
      comment: "Number of RSPO-certified formulations. Tracks sustainable palm oil sourcing compliance across the formulation portfolio."
    - name: "avg_active_ingredient_pct"
      expr: AVG(CAST(active_ingredient_pct AS DOUBLE))
      comment: "Average active ingredient percentage across formulations. Benchmarks product efficacy and supports premium positioning decisions."
    - name: "avg_total_solid_content_pct"
      expr: AVG(CAST(total_solid_content_pct AS DOUBLE))
      comment: "Average total solid content percentage. Used for formulation performance benchmarking and cost-efficiency analysis."
    - name: "avg_ph_min"
      expr: AVG(CAST(ph_min AS DOUBLE))
      comment: "Average minimum pH across formulations. Monitors formulation stability profile for quality and safety compliance."
    - name: "avg_ph_max"
      expr: AVG(CAST(ph_max AS DOUBLE))
      comment: "Average maximum pH across formulations. Monitors formulation stability profile for quality and safety compliance."
    - name: "approved_formulation_count"
      expr: COUNT(CASE WHEN regulatory_approval_status = 'Approved' THEN formulation_id END)
      comment: "Number of regulatory-approved formulations. Tracks market-ready R&D output and regulatory submission success rate."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials component metrics. Tracks component costs, critical component exposure, hazardous material risk, scrap rates, and BOM complexity — essential for cost engineering, supply risk management, and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`product`.`bom_line`"
  dimensions:
    - name: "bom_item_category"
      expr: bom_item_category
      comment: "Category of the BOM item (e.g. Raw Material, Packaging, Semi-Finished). Used to segment cost and risk by component type."
    - name: "component_type"
      expr: component_type
      comment: "Type of component in the BOM. Enables analysis of component mix and sourcing strategy."
    - name: "bom_line_status"
      expr: bom_line_status
      comment: "Status of the BOM line (e.g. Active, Obsolete, Pending). Used to filter live BOM structure from historical records."
    - name: "issue_method"
      expr: issue_method
      comment: "Method by which the component is issued to production (e.g. Backflush, Manual). Impacts production cost accounting accuracy."
    - name: "is_critical_component"
      expr: is_critical_component
      comment: "Flag indicating whether the component is critical to the finished product. Drives supply risk prioritisation and dual-sourcing decisions."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the component is a hazardous material. Critical for EHS compliance and logistics restriction planning."
    - name: "bulk_material_flag"
      expr: bulk_material_flag
      comment: "Flag indicating whether the component is a bulk material. Used for inventory management and procurement volume analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which component costs are denominated. Required for multi-currency cost consolidation."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter from which the BOM line is effective. Used for cost trend analysis and BOM change management."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the BOM component quantity. Used for quantity normalisation and procurement planning."
  measures:
    - name: "total_component_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE))
      comment: "Total component cost across all BOM lines in USD. Core cost engineering KPI for product cost management and margin analysis."
    - name: "avg_component_cost_usd"
      expr: AVG(CAST(component_cost_usd AS DOUBLE))
      comment: "Average component cost per BOM line in USD. Benchmarks component cost efficiency and identifies cost reduction opportunities."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total required quantity across all BOM lines. Used for material requirements planning and procurement volume forecasting."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOM components. Tracks material waste efficiency and drives yield improvement initiatives."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN is_critical_component = TRUE THEN bom_line_id END)
      comment: "Number of critical components across all BOMs. Quantifies supply chain risk exposure and informs dual-sourcing investment decisions."
    - name: "hazardous_component_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN bom_line_id END)
      comment: "Number of hazardous material BOM lines. Tracks EHS compliance exposure and regulatory reporting obligations."
    - name: "total_bom_line_count"
      expr: COUNT(bom_line_id)
      comment: "Total number of BOM lines. Measures BOM complexity, which correlates with manufacturing cost and supply chain risk."
    - name: "avg_usage_probability_pct"
      expr: AVG(CAST(usage_probability_pct AS DOUBLE))
      comment: "Average usage probability percentage across BOM lines. Used for probabilistic material requirements planning and inventory optimisation."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across BOM components. Informs procurement strategy and working capital optimisation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging specification metrics covering sustainability, cost, physical dimensions, and compliance. Supports packaging cost reduction, ESG reporting, and regulatory compliance decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`packaging_spec`"
  dimensions:
    - name: "packaging_level"
      expr: packaging_level
      comment: "Level of packaging (e.g. Primary, Secondary, Tertiary). Used to segment packaging cost and sustainability metrics by level."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the packaging specification (e.g. Active, Obsolete). Filters live specs from historical records."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the packaging specification. Tracks readiness for production and compliance with change control processes."
    - name: "component_type"
      expr: component_type
      comment: "Type of packaging component (e.g. Bottle, Cap, Label). Enables cost and sustainability analysis by component type."
    - name: "material_composition"
      expr: material_composition
      comment: "Material composition of the packaging. Used for recyclability assessment and sustainability reporting."
    - name: "recyclability_code"
      expr: recyclability_code
      comment: "Recyclability classification code. Core ESG dimension for packaging sustainability target tracking."
    - name: "is_fsc_certified"
      expr: is_fsc_certified
      comment: "Flag indicating FSC (Forest Stewardship Council) certification. Tracks sustainable fibre sourcing compliance."
    - name: "is_rspo_certified"
      expr: is_rspo_certified
      comment: "Flag indicating RSPO certification for palm-derived packaging materials. Tracks sustainable sourcing commitments."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the packaging spec meets all regulatory requirements. Critical for market access and compliance risk management."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the packaging component. Used for trade compliance and supply risk analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter the packaging specification became effective. Used for change management and cost trend analysis."
  measures:
    - name: "total_unit_cost_usd"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost across all packaging specifications. Core packaging cost KPI for cost engineering and margin management."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per packaging specification. Benchmarks packaging cost efficiency and identifies cost reduction opportunities."
    - name: "avg_gross_weight_g"
      expr: AVG(CAST(gross_weight_g AS DOUBLE))
      comment: "Average gross weight of packaging in grams. Used for logistics cost modelling and lightweighting initiative tracking."
    - name: "avg_tare_weight_g"
      expr: AVG(CAST(tare_weight_g AS DOUBLE))
      comment: "Average tare (packaging-only) weight in grams. Tracks packaging material reduction progress against sustainability targets."
    - name: "avg_pcr_content_pct"
      expr: AVG(CAST(pcr_content_pct AS DOUBLE))
      comment: "Average post-consumer recycled content percentage across packaging specs. Core ESG KPI for circular economy commitments and investor reporting."
    - name: "fsc_certified_spec_count"
      expr: COUNT(CASE WHEN is_fsc_certified = TRUE THEN packaging_spec_id END)
      comment: "Number of FSC-certified packaging specifications. Tracks sustainable fibre sourcing compliance across the packaging portfolio."
    - name: "rspo_certified_spec_count"
      expr: COUNT(CASE WHEN is_rspo_certified = TRUE THEN packaging_spec_id END)
      comment: "Number of RSPO-certified packaging specifications. Tracks sustainable palm oil sourcing in packaging materials."
    - name: "regulatory_compliant_spec_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN packaging_spec_id END)
      comment: "Number of packaging specs meeting all regulatory requirements. Tracks compliance readiness and market access risk."
    - name: "total_packaging_spec_count"
      expr: COUNT(packaging_spec_id)
      comment: "Total number of packaging specifications. Baseline for packaging portfolio complexity and rationalisation analysis."
    - name: "avg_height_mm"
      expr: AVG(CAST(height_mm AS DOUBLE))
      comment: "Average packaging height in millimetres. Used for shelf space planning and logistics cube optimisation."
    - name: "avg_width_mm"
      expr: AVG(CAST(width_mm AS DOUBLE))
      comment: "Average packaging width in millimetres. Used for shelf space planning and logistics cube optimisation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product registration and warranty metrics. Tracks consumer registration rates, warranty uptake, marketing consent, and purchase channel mix — critical for consumer engagement, warranty liability management, and CRM strategy."
  source: "`vibe_consumer_goods_v1`.`product`.`registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Status of the product registration (e.g. Active, Expired, Cancelled). Used to segment active warranty base from lapsed registrations."
    - name: "channel"
      expr: channel
      comment: "Channel through which the product was registered (e.g. Online, In-Store, App). Used for channel attribution and digital engagement analysis."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the product was purchased. Enables cross-channel purchase and registration behaviour analysis."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty associated with the registration. Used for warranty liability segmentation and cost forecasting."
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current status of the warranty (e.g. Active, Expired, Claimed). Tracks warranty liability exposure and claim risk."
    - name: "product_condition"
      expr: product_condition
      comment: "Condition of the product at registration (e.g. New, Refurbished). Used for quality and returns analysis."
    - name: "purchase_date"
      expr: DATE_TRUNC('month', purchase_date)
      comment: "Month of product purchase. Enables cohort analysis of registration behaviour and warranty uptake by purchase vintage."
    - name: "registration_date"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of product registration. Tracks registration volume trends and campaign effectiveness."
    - name: "extended_warranty_flag"
      expr: extended_warranty_flag
      comment: "Flag indicating whether an extended warranty was purchased. Used for extended warranty revenue and attachment rate analysis."
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Flag indicating consumer opt-in to marketing communications. Tracks consent-based marketing reach and CRM list quality."
    - name: "recall_notification_opt_in"
      expr: recall_notification_opt_in
      comment: "Flag indicating consumer opt-in to recall notifications. Critical for product safety recall reach and regulatory compliance."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the registration (e.g. Verified, Pending, Failed). Used to assess data quality and fraud risk in registration data."
  measures:
    - name: "total_registration_count"
      expr: COUNT(registration_id)
      comment: "Total number of product registrations. Core consumer engagement KPI tracking brand loyalty and post-purchase interaction."
    - name: "active_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN registration_id END)
      comment: "Number of currently active product registrations. Represents the active warranty base and engaged consumer population."
    - name: "extended_warranty_count"
      expr: COUNT(CASE WHEN extended_warranty_flag = TRUE THEN registration_id END)
      comment: "Number of registrations with extended warranty purchased. Tracks extended warranty attachment rate and associated revenue opportunity."
    - name: "marketing_opt_in_count"
      expr: COUNT(CASE WHEN marketing_opt_in_flag = TRUE THEN registration_id END)
      comment: "Number of registrations with marketing opt-in consent. Measures addressable CRM audience size for direct marketing campaigns."
    - name: "recall_opt_in_count"
      expr: COUNT(CASE WHEN recall_notification_opt_in = TRUE THEN registration_id END)
      comment: "Number of consumers opted in to recall notifications. Critical safety KPI measuring recall communication reach and regulatory compliance readiness."
    - name: "verified_registration_count"
      expr: COUNT(CASE WHEN verified_flag = TRUE THEN registration_id END)
      comment: "Number of verified product registrations. Tracks data quality and authenticity of the registered consumer base."
    - name: "total_purchase_value_usd"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase value across all registered products. Proxy for consumer value of the registered base and warranty liability exposure."
    - name: "avg_purchase_price_usd"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price of registered products. Used to assess the value tier of the registered consumer base and warranty cost risk."
    - name: "distinct_registered_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one product registration. Tracks breadth of consumer engagement across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GTIN registry and barcode compliance metrics. Tracks GS1 publication status, data pool readiness, EDI eligibility, and market coverage — essential for retail trade compliance, supply chain visibility, and omnichannel readiness."
  source: "`vibe_consumer_goods_v1`.`product`.`gtin_registry`"
  dimensions:
    - name: "gtin_registry_status"
      expr: gtin_registry_status
      comment: "Status of the GTIN registration (e.g. Active, Retired, Pending). Used to filter live GTINs from retired or pending records."
    - name: "gtin_format"
      expr: gtin_format
      comment: "Format of the GTIN (e.g. GTIN-8, GTIN-12, GTIN-14). Used for barcode compliance and retailer requirement analysis."
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging level associated with the GTIN (e.g. Consumer Unit, Case, Pallet). Used for supply chain hierarchy compliance analysis."
    - name: "target_market_country"
      expr: target_market_country
      comment: "Target market country for the GTIN. Enables geographic compliance and market readiness analysis."
    - name: "barcode_symbology"
      expr: barcode_symbology
      comment: "Barcode symbology used (e.g. EAN-13, UPC-A, ITF-14). Used for retailer compliance and point-of-sale readiness assessment."
    - name: "gs1_member_org"
      expr: gs1_member_org
      comment: "GS1 member organisation that issued the GTIN. Used for GS1 compliance and brand ownership tracking."
    - name: "data_pool_published"
      expr: data_pool_published
      comment: "Flag indicating whether the GTIN has been published to a GS1 data pool. Tracks retail data synchronisation readiness."
    - name: "gs1_registry_published"
      expr: gs1_registry_published
      comment: "Flag indicating whether the GTIN is published in the GS1 registry. Tracks global product identification compliance."
    - name: "edi_eligible"
      expr: edi_eligible
      comment: "Flag indicating whether the GTIN is eligible for EDI transactions. Tracks electronic trading readiness with retail partners."
    - name: "is_consumer_unit"
      expr: is_consumer_unit
      comment: "Flag indicating whether the GTIN represents a consumer-facing unit. Used to segment consumer vs. trade unit analysis."
    - name: "activation_date"
      expr: DATE_TRUNC('quarter', activation_date)
      comment: "Quarter of GTIN activation. Tracks new product introduction cadence and GS1 compliance timeline."
    - name: "plm_lifecycle_stage"
      expr: plm_lifecycle_stage
      comment: "PLM lifecycle stage of the GTIN. Used to align GTIN management with product lifecycle decisions."
  measures:
    - name: "active_gtin_count"
      expr: COUNT(CASE WHEN gtin_registry_status = 'Active' THEN gtin_registry_id END)
      comment: "Number of active GTINs in the registry. Core trade compliance KPI tracking the live product identification footprint."
    - name: "total_gtin_count"
      expr: COUNT(gtin_registry_id)
      comment: "Total number of GTINs across all statuses. Baseline for product identification portfolio size and complexity."
    - name: "data_pool_published_count"
      expr: COUNT(CASE WHEN data_pool_published = TRUE THEN gtin_registry_id END)
      comment: "Number of GTINs published to GS1 data pools. Tracks retail data synchronisation compliance and omnichannel readiness."
    - name: "gs1_registry_published_count"
      expr: COUNT(CASE WHEN gs1_registry_published = TRUE THEN gtin_registry_id END)
      comment: "Number of GTINs published in the GS1 global registry. Tracks global product identification compliance and brand protection."
    - name: "edi_eligible_gtin_count"
      expr: COUNT(CASE WHEN edi_eligible = TRUE THEN gtin_registry_id END)
      comment: "Number of EDI-eligible GTINs. Tracks electronic trading readiness with retail and distribution partners."
    - name: "consumer_unit_gtin_count"
      expr: COUNT(CASE WHEN is_consumer_unit = TRUE THEN gtin_registry_id END)
      comment: "Number of GTINs representing consumer-facing units. Used for point-of-sale compliance and consumer product identification analysis."
    - name: "distinct_target_market_count"
      expr: COUNT(DISTINCT target_market_country)
      comment: "Number of distinct target market countries covered by GTINs. Tracks geographic market reach and international trade compliance breadth."
    - name: "avg_net_content_value"
      expr: AVG(CAST(net_content_value AS DOUBLE))
      comment: "Average net content value across GTINs. Used for net content compliance monitoring and consumer value benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw and packaging material portfolio metrics. Tracks material cost, hazardous material exposure, lifecycle status, and physical properties — essential for procurement strategy, EHS compliance, and supply chain risk management."
  source: "`vibe_consumer_goods_v1`.`product`.`material`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (e.g. Raw Material, Packaging, Semi-Finished). Used to segment cost and risk by material category."
    - name: "material_status"
      expr: material_status
      comment: "Operational status of the material (e.g. Active, Blocked, Discontinued). Used to filter live materials from obsolete records."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the material. Drives procurement strategy and material rationalisation decisions."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type for the material (e.g. External, Internal). Used for make-vs-buy analysis and sourcing strategy."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the material. Used for trade compliance, tariff exposure, and supply risk analysis."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Flag indicating whether the material is hazardous. Critical for EHS compliance, logistics restrictions, and regulatory reporting."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the material (e.g. Flammable, Corrosive). Used for EHS risk segmentation and compliance planning."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging type used for the material. Used for logistics and storage planning."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory status of the material. Tracks compliance with chemical regulations (e.g. REACH, TSCA) and market access requirements."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the material record became effective. Used for material portfolio vintage and lifecycle cohort analysis."
  measures:
    - name: "active_material_count"
      expr: COUNT(CASE WHEN material_status = 'Active' THEN material_id END)
      comment: "Number of active materials in the portfolio. Core procurement KPI for material portfolio size and complexity management."
    - name: "total_material_count"
      expr: COUNT(material_id)
      comment: "Total number of materials across all statuses. Baseline for material portfolio breadth and rationalisation analysis."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_flag = TRUE THEN material_id END)
      comment: "Number of hazardous materials in the portfolio. Tracks EHS compliance exposure and regulatory reporting obligations."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per material. Benchmarks material cost efficiency and informs procurement negotiation strategy."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all materials. Represents the aggregate material cost base for financial planning and cost engineering."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average material weight in kilograms. Used for logistics cost modelling and material handling planning."
    - name: "avg_volume_l"
      expr: AVG(CAST(volume_l AS DOUBLE))
      comment: "Average material volume in litres. Used for storage capacity planning and logistics optimisation."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average required storage temperature in Celsius. Used for cold chain planning and storage facility requirement analysis."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers providing materials. Tracks supplier concentration risk and dual-sourcing coverage across the material portfolio."
$$;