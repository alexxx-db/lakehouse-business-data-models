-- Metric views for domain: product | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU master metrics tracking active assortment size, private-label penetration, and physical product characteristics. Used by category managers and merchants to evaluate assortment breadth and composition."
  source: "`vibe_retail_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the SKU (e.g. active, discontinued, pending). Primary filter for active assortment analysis."
    - name: "hierarchy_node"
      expr: item_hierarchy_id
      comment: "Product hierarchy node the SKU belongs to. Enables category-level rollup of assortment metrics."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured or sourced. Used for sourcing diversification and trade compliance analysis."
    - name: "is_private_label"
      expr: private_label_flag
      comment: "Indicates whether the SKU is a private-label product. Drives margin and brand mix analysis."
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Indicates whether the SKU is classified as hazardous material. Affects fulfillment routing and compliance reporting."
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Storage and handling temperature requirement for the SKU (e.g. ambient, refrigerated, frozen). Drives supply chain cost allocation."
  measures:
    - name: "total_active_skus"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'active' THEN sku_id END)
      comment: "Count of distinct active SKUs in the assortment. Core assortment breadth KPI used by merchants and category managers."
    - name: "total_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Total count of all SKUs regardless of lifecycle status. Baseline for assortment size and range management."
    - name: "private_label_sku_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN sku_id END)
      comment: "Count of private-label SKUs. Numerator for private-label penetration rate, a key margin-improvement lever."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight across SKUs. Used for logistics cost modelling and carrier rate negotiation."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight across SKUs. Supports yield and shrink analysis for perishable categories."
    - name: "avg_volume_cubic"
      expr: AVG(CAST(volume AS DOUBLE))
      comment: "Average volumetric size of SKUs. Drives cube utilisation planning for DC and store shelf allocation."
    - name: "hazmat_sku_count"
      expr: COUNT(DISTINCT CASE WHEN hazmat_flag = TRUE THEN sku_id END)
      comment: "Count of hazardous-material SKUs. Compliance and logistics risk KPI monitored by supply chain and regulatory teams."
    - name: "discontinued_sku_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'discontinued' THEN sku_id END)
      comment: "Count of discontinued SKUs. Tracks range rationalisation progress and clearance planning needs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category and merchandise hierarchy performance metrics covering margin targets, private-label penetration targets, and safety stock planning. Used by category managers, planners, and finance for category strategy reviews."
  source: "`vibe_retail_v1`.`product`.`item_hierarchy`"
  dimensions:
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the merchandise hierarchy (e.g. department, category, sub-category). Enables drill-down from division to leaf-node analysis."
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of hierarchy node (e.g. merchandise, financial, planning). Distinguishes reporting structures."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Operational status of the hierarchy node. Filters active vs. retired categories."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic role assigned to the category (e.g. destination, routine, convenience). Drives investment prioritisation."
    - name: "seasonality_indicator"
      expr: seasonality_indicator
      comment: "Seasonality profile of the category. Used for demand planning and promotional calendar alignment."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment approach for the category (e.g. vendor-managed, auto-replenishment). Drives supply chain configuration."
    - name: "is_leaf_node"
      expr: is_leaf_node
      comment: "Indicates whether this node is a leaf (lowest level) in the hierarchy. Leaf nodes are where SKUs are directly assigned."
    - name: "omnichannel_enabled"
      expr: omnichannel_enabled
      comment: "Indicates whether the category is enabled for omnichannel fulfilment. Tracks digital readiness of the assortment."
  measures:
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage across hierarchy nodes. Benchmark for category profitability planning and buyer performance evaluation."
    - name: "avg_private_label_penetration_target_pct"
      expr: AVG(CAST(private_label_penetration_target_percent AS DOUBLE))
      comment: "Average private-label penetration target across categories. Tracks strategic ambition for own-brand growth, a key margin lever."
    - name: "avg_safety_stock_weeks"
      expr: AVG(CAST(safety_stock_weeks AS DOUBLE))
      comment: "Average safety stock cover in weeks across categories. Monitors inventory risk buffer; low values signal stockout exposure."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for hierarchy nodes. Tracks master data completeness; low scores indicate governance gaps that impair downstream analytics."
    - name: "total_active_categories"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'active' THEN item_hierarchy_id END)
      comment: "Count of active category nodes. Baseline for assortment breadth and range management reporting."
    - name: "omnichannel_enabled_category_count"
      expr: COUNT(DISTINCT CASE WHEN omnichannel_enabled = TRUE THEN item_hierarchy_id END)
      comment: "Count of categories enabled for omnichannel fulfilment. Tracks digital transformation progress of the merchandise range."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio performance metrics covering margin, quality, return rates, and private-label composition. Used by brand managers, buyers, and category directors to evaluate brand health and portfolio strategy."
  source: "`vibe_retail_v1`.`product`.`product_brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand (e.g. active, discontinued, under review). Primary filter for active brand portfolio analysis."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Tier classification of the brand (e.g. premium, mainstream, value). Drives pricing strategy and shelf space allocation."
    - name: "brand_type"
      expr: brand_type
      comment: "Type of brand (e.g. national, private-label, licensed). Fundamental dimension for brand mix and margin analysis."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the brand is a private-label brand. Key dimension for own-brand penetration reporting."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the brand is sold exclusively through this retailer. Tracks competitive differentiation of the assortment."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country of origin for the brand. Used for sourcing risk and trade compliance analysis."
    - name: "portfolio_group"
      expr: portfolio_group
      comment: "Portfolio grouping for the brand. Enables rollup reporting across brand families."
  measures:
    - name: "avg_margin_pct"
      expr: AVG(CAST(average_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across brands. Core brand profitability KPI used in quarterly brand reviews and portfolio rationalisation."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across brands. Tracks supplier and brand quality performance; low scores trigger sourcing reviews."
    - name: "avg_return_rate_pct"
      expr: AVG(CAST(return_rate_percent AS DOUBLE))
      comment: "Average product return rate percentage across brands. High return rates signal quality or expectation-mismatch issues requiring brand or product action."
    - name: "total_active_brands"
      expr: COUNT(DISTINCT CASE WHEN brand_status = 'active' THEN product_brand_id END)
      comment: "Count of active brands in the portfolio. Baseline for brand breadth and rationalisation tracking."
    - name: "private_label_brand_count"
      expr: COUNT(DISTINCT CASE WHEN is_private_label = TRUE THEN product_brand_id END)
      comment: "Count of active private-label brands. Tracks own-brand portfolio depth, a strategic margin-improvement lever."
    - name: "exclusive_brand_count"
      expr: COUNT(DISTINCT CASE WHEN is_exclusive = TRUE THEN product_brand_id END)
      comment: "Count of exclusive brands. Measures competitive differentiation of the brand portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall operational and financial metrics tracking recall scope, recovery effectiveness, and financial impact. Used by compliance officers, supply chain leadership, and finance to manage recall risk and cost."
  source: "`vibe_retail_v1`.`product`.`recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g. initiated, in-progress, closed). Primary filter for active recall monitoring."
    - name: "recall_class"
      expr: class
      comment: "Regulatory severity class of the recall (e.g. Class I, II, III). Drives escalation priority and regulatory reporting."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall action (e.g. voluntary, mandatory, market withdrawal). Affects regulatory obligations and communication strategy."
    - name: "remedy_type"
      expr: remedy_type
      comment: "Remedy offered to customers (e.g. refund, replacement, repair). Drives customer service workload and financial provisioning."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the recalled product is a private-label item. Private-label recalls carry higher reputational and financial risk."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country of origin of the recalled product. Used for sourcing risk analysis and supplier accountability."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority overseeing the recall. Tracks compliance obligations by jurisdiction."
  measures:
    - name: "total_units_affected"
      expr: SUM(CAST(units_affected AS BIGINT))
      comment: "Total number of units subject to recall. Primary scale metric for recall severity and resource planning."
    - name: "total_units_recovered"
      expr: SUM(CAST(units_recovered AS BIGINT))
      comment: "Total units successfully recovered from the market. Measures recall execution effectiveness."
    - name: "total_units_in_customer_hands"
      expr: SUM(CAST(units_in_customer_hands AS BIGINT))
      comment: "Total units estimated to remain with customers. Tracks residual consumer safety risk and drives outreach prioritisation."
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate percentage across recalls. Measures how effectively recalled units are retrieved; low rates indicate consumer safety risk."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of recalls. Critical for financial provisioning, insurance claims, and board-level risk reporting."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts recovered from suppliers for recall costs. Tracks cost recovery effectiveness from vendor accountability."
    - name: "active_recall_count"
      expr: COUNT(DISTINCT CASE WHEN recall_status NOT IN ('closed', 'completed') THEN recall_id END)
      comment: "Count of currently active recalls. Operational KPI for compliance team workload and risk exposure monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_category_campaign_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category campaign planning and performance metrics tracking promotional spend efficiency, revenue attainment, and media investment. Used by category managers, marketing, and finance for promotional ROI and budget governance."
  source: "`vibe_retail_v1`.`product`.`category_campaign_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the campaign plan (e.g. draft, approved, executed). Filters plans by stage for pipeline and performance reporting."
    - name: "item_hierarchy_node"
      expr: item_hierarchy_id
      comment: "Merchandise hierarchy node the campaign plan targets. Enables category-level promotional performance rollup."
    - name: "campaign"
      expr: campaign_id
      comment: "Campaign associated with the plan. Links promotional plans to campaign-level performance tracking."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue_amount AS DOUBLE))
      comment: "Total actual revenue generated by category campaign plans. Core revenue attainment KPI for promotional effectiveness."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue_goal AS DOUBLE))
      comment: "Total revenue target across campaign plans. Denominator for revenue attainment rate; tracks ambition vs. delivery."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual promotional spend across campaign plans. Tracks budget consumption and cost discipline."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to category campaign plans. Denominator for spend utilisation rate and budget governance."
    - name: "total_actual_units_sold"
      expr: SUM(CAST(actual_units_sold AS BIGINT))
      comment: "Total actual units sold through campaign plans. Volume KPI for promotional uplift and sell-through analysis."
    - name: "total_target_units"
      expr: SUM(CAST(target_units_goal AS BIGINT))
      comment: "Total unit sales target across campaign plans. Denominator for unit attainment rate."
    - name: "avg_promotional_depth_pct"
      expr: AVG(CAST(promotional_depth_percent AS DOUBLE))
      comment: "Average promotional discount depth across campaign plans. Tracks markdown intensity; excessive depth erodes margin."
    - name: "avg_media_weight_pct"
      expr: AVG(CAST(media_weight_percent AS DOUBLE))
      comment: "Average media weight allocation across campaign plans. Measures promotional support intensity for category investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product compliance status and audit metrics tracking certification coverage, recall exposure, and regulatory adherence. Used by compliance officers, legal, and supply chain to manage regulatory risk across the product range."
  source: "`vibe_retail_v1`.`product`.`product_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the product (e.g. compliant, non-compliant, pending). Primary filter for compliance risk monitoring."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance requirement (e.g. food safety, hazmat, import). Enables compliance gap analysis by regulatory domain."
    - name: "country_code"
      expr: country_code
      comment: "Country for which the compliance record applies. Enables jurisdiction-level compliance reporting."
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status associated with the compliance record. Tracks products under active recall for risk management."
    - name: "prop_65_warning_required"
      expr: prop_65_warning_required
      comment: "Indicates whether a Proposition 65 chemical warning is required. Tracks chemical disclosure compliance obligations."
    - name: "age_restriction_required"
      expr: age_restriction_required
      comment: "Indicates whether the product has an age restriction. Tracks compliance obligations for age-gated products."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(DISTINCT product_compliance_id)
      comment: "Total count of product compliance records. Baseline for compliance coverage and audit scope."
    - name: "non_compliant_record_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'non-compliant' THEN product_compliance_id END)
      comment: "Count of non-compliant product compliance records. Critical risk KPI; non-compliance triggers regulatory action and potential sales suspension."
    - name: "active_recall_record_count"
      expr: COUNT(DISTINCT CASE WHEN recall_status IS NOT NULL AND recall_status != 'closed' THEN product_compliance_id END)
      comment: "Count of compliance records with an active recall. Tracks products currently under recall for consumer safety and regulatory reporting."
    - name: "prop_65_warning_count"
      expr: COUNT(DISTINCT CASE WHEN prop_65_warning_required = TRUE THEN product_compliance_id END)
      comment: "Count of products requiring Proposition 65 chemical warnings. Tracks chemical disclosure compliance obligations in applicable jurisdictions."
    - name: "nutrition_labeling_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN nutrition_labeling_compliant = TRUE THEN product_compliance_id END)
      comment: "Count of products with compliant nutrition labelling. Tracks food labelling regulatory adherence across the range."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product lifecycle event metrics tracking new product introduction velocity, discontinuation rates, and approval cycle times. Used by merchants, buyers, and category managers to manage range refresh cadence and time-to-market."
  source: "`vibe_retail_v1`.`product`.`item_lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (e.g. new item introduction, discontinuation, reactivation). Primary dimension for lifecycle stage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the lifecycle event. Tracks pipeline of pending vs. approved product changes."
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current workflow stage of the lifecycle event. Identifies bottlenecks in the product introduction or discontinuation process."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the lifecycle event relates to a private-label product. Tracks own-brand range change velocity."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the lifecycle event. Enables root-cause analysis of discontinuations and range changes."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the lifecycle event is driven by a regulatory compliance requirement. Tracks compliance-driven range changes."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(DISTINCT item_lifecycle_event_id)
      comment: "Total count of product lifecycle events. Baseline for range change activity volume and process throughput."
    - name: "new_item_introduction_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'new_item_introduction' THEN item_lifecycle_event_id END)
      comment: "Count of new item introduction events. Tracks range innovation velocity; a key merchant performance KPI."
    - name: "discontinuation_event_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'discontinuation' THEN item_lifecycle_event_id END)
      comment: "Count of product discontinuation events. Tracks range rationalisation activity and clearance planning needs."
    - name: "pending_approval_event_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status NOT IN ('approved', 'rejected') THEN item_lifecycle_event_id END)
      comment: "Count of lifecycle events awaiting approval. Tracks approval pipeline backlog; high counts indicate process bottlenecks delaying time-to-market."
    - name: "compliance_driven_event_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = TRUE THEN item_lifecycle_event_id END)
      comment: "Count of lifecycle events driven by regulatory compliance requirements. Tracks compliance-mandated range changes for regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Global trade item number (GTIN) registry quality and coverage metrics. Used by data governance, supply chain, and e-commerce teams to ensure product identification data completeness and global data synchronisation health."
  source: "`vibe_retail_v1`.`product`.`gtin_registry`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Registration status of the GTIN record (e.g. active, pending, discontinued). Primary filter for active GTIN coverage analysis."
    - name: "gtin_type"
      expr: gtin_type
      comment: "Type of GTIN (e.g. GTIN-8, GTIN-12, GTIN-13, GTIN-14). Tracks identifier format distribution across the product range."
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging hierarchy level (e.g. each, inner pack, case, pallet). Enables analysis of GTIN coverage by packaging tier."
    - name: "gdsn_publication_status"
      expr: gdsn_publication_status
      comment: "Publication status in the global data synchronisation network. Tracks data sharing compliance with trading partners."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the GTIN record. Tracks product identification compliance obligations."
    - name: "is_base_unit"
      expr: is_base_unit
      comment: "Indicates whether the GTIN represents the consumer base unit. Filters for consumer-facing product identification coverage."
  measures:
    - name: "total_registered_gtins"
      expr: COUNT(DISTINCT gtin_registry_id)
      comment: "Total count of registered GTIN records. Baseline for product identification coverage across the range."
    - name: "active_gtin_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'active' THEN gtin_registry_id END)
      comment: "Count of active GTIN registrations. Tracks current product identification coverage; gaps cause scan failures and lost sales."
    - name: "gdsn_published_gtin_count"
      expr: COUNT(DISTINCT CASE WHEN gdsn_publication_status = 'published' THEN gtin_registry_id END)
      comment: "Count of GTINs published to the global data synchronisation network. Measures data sharing compliance with retail trading partners."
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight_value AS DOUBLE))
      comment: "Average gross weight across registered GTINs. Supports logistics cost modelling and carrier rate benchmarking."
    - name: "avg_net_content"
      expr: AVG(CAST(net_content_value AS DOUBLE))
      comment: "Average net content value across registered GTINs. Used for unit pricing compliance and consumer labelling accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment business metrics"
  source: "`vibe_retail_v1`.`product`.`assortment`"
  dimensions:
    - name: "Allocation Priority"
      expr: allocation_priority
    - name: "Assignment Effective Date"
      expr: assignment_effective_date
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Received Date"
      expr: last_received_date
    - name: "Max Stock Quantity"
      expr: max_stock_quantity
    - name: "Min Stock Quantity"
      expr: min_stock_quantity
    - name: "Replenishment Lead Time Days"
      expr: replenishment_lead_time_days
    - name: "Stocking Status"
      expr: stocking_status
    - name: "Assignment Effective Date Month"
      expr: DATE_TRUNC('MONTH', assignment_effective_date)
    - name: "Assignment End Date Month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assortment"
      expr: COUNT(DISTINCT assortment_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_category_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Kpi Target business metrics"
  source: "`vibe_retail_v1`.`product`.`category_kpi_target`"
  dimensions:
    - name: "Configuration Notes"
      expr: configuration_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Frequency"
      expr: measurement_frequency
    - name: "Responsible Role"
      expr: responsible_role
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Kpi Target"
      expr: COUNT(DISTINCT category_kpi_target_id)
    - name: "Total Alert Threshold"
      expr: SUM(alert_threshold)
    - name: "Average Alert Threshold"
      expr: AVG(alert_threshold)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_image`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Image business metrics"
  source: "`vibe_retail_v1`.`product`.`image`"
  dimensions:
    - name: "Alt Text"
      expr: alt_text
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Background Color"
      expr: background_color
    - name: "Caption"
      expr: caption
    - name: "Cdn Asset Reference"
      expr: cdn_asset_reference
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Color Profile"
      expr: color_profile
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Dpi"
      expr: dpi
    - name: "Expiration Date"
      expr: expiration_date
    - name: "File Format"
      expr: file_format
    - name: "Has Transparency"
      expr: has_transparency
    - name: "Image Type"
      expr: image_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Image"
      expr: COUNT(DISTINCT image_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Bundle business metrics"
  source: "`vibe_retail_v1`.`product`.`item_bundle`"
  dimensions:
    - name: "Assortment Category"
      expr: assortment_category
    - name: "Bundle Description"
      expr: bundle_description
    - name: "Bundle Name"
      expr: bundle_name
    - name: "Bundle Status"
      expr: bundle_status
    - name: "Bundle Type"
      expr: bundle_type
    - name: "Channel Availability"
      expr: channel_availability
    - name: "Component Sequence"
      expr: component_sequence
    - name: "Component Sku"
      expr: component_sku
    - name: "Component Substitution Allowed"
      expr: component_substitution_allowed
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inventory Deduction Method"
      expr: inventory_deduction_method
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loyalty Points Eligible"
      expr: loyalty_points_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Bundle"
      expr: COUNT(DISTINCT item_bundle_id)
    - name: "Total Bundle Price Amount"
      expr: SUM(bundle_price_amount)
    - name: "Average Bundle Price Amount"
      expr: AVG(bundle_price_amount)
    - name: "Total Component Quantity"
      expr: SUM(component_quantity)
    - name: "Average Component Quantity"
      expr: AVG(component_quantity)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_cross_reference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Cross Reference business metrics"
  source: "`vibe_retail_v1`.`product`.`item_cross_reference`"
  dimensions:
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Reference Status"
      expr: cross_reference_status
    - name: "Cross Reference Type"
      expr: cross_reference_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Item Description"
      expr: external_item_description
    - name: "External Item Number"
      expr: external_item_number
    - name: "External System Instance"
      expr: external_system_instance
    - name: "External System Name"
      expr: external_system_name
    - name: "External Unit Of Measure"
      expr: external_unit_of_measure
    - name: "Internal Unit Of Measure"
      expr: internal_unit_of_measure
    - name: "Is Primary Reference"
      expr: is_primary_reference
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Used Date"
      expr: last_used_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Cross Reference"
      expr: COUNT(DISTINCT item_cross_reference_id)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
    - name: "Total Mapping Confidence Score"
      expr: SUM(mapping_confidence_score)
    - name: "Average Mapping Confidence Score"
      expr: AVG(mapping_confidence_score)
    - name: "Total Usage Count"
      expr: SUM(usage_count)
    - name: "Average Usage Count"
      expr: AVG(usage_count)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_nutritional`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Nutritional business metrics"
  source: "`vibe_retail_v1`.`product`.`item_nutritional`"
  dimensions:
    - name: "Allergen Declaration"
      expr: allergen_declaration
    - name: "Calories From Fat"
      expr: calories_from_fat
    - name: "Calories Per Serving"
      expr: calories_per_serving
    - name: "Contains Eggs"
      expr: contains_eggs
    - name: "Contains Fish"
      expr: contains_fish
    - name: "Contains Milk"
      expr: contains_milk
    - name: "Contains Peanuts"
      expr: contains_peanuts
    - name: "Contains Shellfish"
      expr: contains_shellfish
    - name: "Contains Soybeans"
      expr: contains_soybeans
    - name: "Contains Tree Nuts"
      expr: contains_tree_nuts
    - name: "Contains Wheat"
      expr: contains_wheat
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ingredient Statement"
      expr: ingredient_statement
    - name: "Is Gluten Free"
      expr: is_gluten_free
    - name: "Is Halal Certified"
      expr: is_halal_certified
    - name: "Is Kosher Certified"
      expr: is_kosher_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Nutritional"
      expr: COUNT(DISTINCT item_nutritional_id)
    - name: "Total Added Sugars G"
      expr: SUM(added_sugars_g)
    - name: "Average Added Sugars G"
      expr: AVG(added_sugars_g)
    - name: "Total Calcium Mg"
      expr: SUM(calcium_mg)
    - name: "Average Calcium Mg"
      expr: AVG(calcium_mg)
    - name: "Total Cholesterol Mg"
      expr: SUM(cholesterol_mg)
    - name: "Average Cholesterol Mg"
      expr: AVG(cholesterol_mg)
    - name: "Total Dietary Fiber G"
      expr: SUM(dietary_fiber_g)
    - name: "Average Dietary Fiber G"
      expr: AVG(dietary_fiber_g)
    - name: "Total Iron Mg"
      expr: SUM(iron_mg)
    - name: "Average Iron Mg"
      expr: AVG(iron_mg)
    - name: "Total Monounsaturated Fat G"
      expr: SUM(monounsaturated_fat_g)
    - name: "Average Monounsaturated Fat G"
      expr: AVG(monounsaturated_fat_g)
    - name: "Total Polyunsaturated Fat G"
      expr: SUM(polyunsaturated_fat_g)
    - name: "Average Polyunsaturated Fat G"
      expr: AVG(polyunsaturated_fat_g)
    - name: "Total Potassium Mg"
      expr: SUM(potassium_mg)
    - name: "Average Potassium Mg"
      expr: AVG(potassium_mg)
    - name: "Total Protein G"
      expr: SUM(protein_g)
    - name: "Average Protein G"
      expr: AVG(protein_g)
    - name: "Total Saturated Fat G"
      expr: SUM(saturated_fat_g)
    - name: "Average Saturated Fat G"
      expr: AVG(saturated_fat_g)
    - name: "Total Serving Size Value"
      expr: SUM(serving_size_value)
    - name: "Average Serving Size Value"
      expr: AVG(serving_size_value)
    - name: "Total Servings Per Container"
      expr: SUM(servings_per_container)
    - name: "Average Servings Per Container"
      expr: AVG(servings_per_container)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Variant business metrics"
  source: "`vibe_retail_v1`.`product`.`item_variant`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Auto Substitute Flag"
      expr: auto_substitute_flag
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Consent Required Flag"
      expr: customer_consent_required_flag
    - name: "Display Sequence"
      expr: display_sequence
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inventory Interchangeable Flag"
      expr: inventory_interchangeable_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Relationship Status"
      expr: relationship_status
    - name: "Relationship Type"
      expr: relationship_type
    - name: "Source System Code"
      expr: source_system_code
    - name: "Substitution Priority Rank"
      expr: substitution_priority_rank
    - name: "Substitution Type"
      expr: substitution_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Variant"
      expr: COUNT(DISTINCT item_variant_id)
    - name: "Total Price Differential Amount"
      expr: SUM(price_differential_amount)
    - name: "Average Price Differential Amount"
      expr: AVG(price_differential_amount)
    - name: "Total Variant Dimension Value"
      expr: SUM(variant_dimension_value)
    - name: "Average Variant Dimension Value"
      expr: AVG(variant_dimension_value)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Brand business metrics"
  source: "`vibe_retail_v1`.`product`.`product_brand`"
  dimensions:
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Description"
      expr: brand_description
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Status"
      expr: brand_status
    - name: "Brand Tier"
      expr: brand_tier
    - name: "Brand Type"
      expr: brand_type
    - name: "Country Of Origin Code"
      expr: country_of_origin_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Is Licensed"
      expr: is_licensed
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Launch Date"
      expr: launch_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "License Expiration Date"
      expr: license_expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Brand"
      expr: COUNT(DISTINCT product_brand_id)
    - name: "Total Average Margin Percent"
      expr: SUM(average_margin_percent)
    - name: "Average Average Margin Percent"
      expr: AVG(average_margin_percent)
    - name: "Total Quality Rating"
      expr: SUM(quality_rating)
    - name: "Average Quality Rating"
      expr: AVG(quality_rating)
    - name: "Total Return Rate Percent"
      expr: SUM(return_rate_percent)
    - name: "Average Return Rate Percent"
      expr: AVG(return_rate_percent)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_product_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Compliance business metrics"
  source: "`vibe_retail_v1`.`product`.`product_compliance`"
  dimensions:
    - name: "Age Restriction Required"
      expr: age_restriction_required
    - name: "Allergen Declaration Compliant"
      expr: allergen_declaration_compliant
    - name: "Certification Number"
      expr: certification_number
    - name: "Certifying Body"
      expr: certifying_body
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Compliance Type"
      expr: compliance_type
    - name: "Country Code"
      expr: country_code
    - name: "Country Of Origin Compliant"
      expr: country_of_origin_compliant
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fda Food Facility Registration"
      expr: fda_food_facility_registration
    - name: "Hazmat Classification"
      expr: hazmat_classification
    - name: "Import License Number"
      expr: import_license_number
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Compliance"
      expr: COUNT(DISTINCT product_compliance_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_uom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Uom business metrics"
  source: "`vibe_retail_v1`.`product`.`uom`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Gs1 Uom Code"
      expr: gs1_uom_code
    - name: "Is Base Unit"
      expr: is_base_unit
    - name: "Is Consumer Unit"
      expr: is_consumer_unit
    - name: "Is Fractional Allowed"
      expr: is_fractional_allowed
    - name: "Is Inventory Tracked"
      expr: is_inventory_tracked
    - name: "Is Orderable"
      expr: is_orderable
    - name: "Is Variable Measure"
      expr: is_variable_measure
    - name: "Iso Uom Code"
      expr: iso_uom_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Precision Decimal Places"
      expr: precision_decimal_places
    - name: "Sort Order"
      expr: sort_order
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Uom"
      expr: COUNT(DISTINCT uom_id)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Inverse Conversion Factor"
      expr: SUM(inverse_conversion_factor)
    - name: "Average Inverse Conversion Factor"
      expr: AVG(inverse_conversion_factor)
$$;