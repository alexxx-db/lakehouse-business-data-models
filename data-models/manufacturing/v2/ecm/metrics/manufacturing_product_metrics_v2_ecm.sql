-- Metric views for domain: product | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU portfolio metrics tracking active product count, cost distribution, weight/volume profiles, and lifecycle health across the product catalog. Used by product management and supply chain leadership to govern the SKU portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`sku_master`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the SKU (e.g., Active, Discontinued, Obsolete) — primary segmentation for portfolio health analysis."
    - name: "product_type"
      expr: product_type
      comment: "Product type classification (e.g., Finished Good, Raw Material, Semi-Finished) for portfolio mix analysis."
    - name: "make_or_buy_code"
      expr: make_or_buy_code
      comment: "Indicates whether the SKU is manufactured in-house or sourced externally — drives sourcing strategy decisions."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low) for prioritization of management attention."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating whether the SKU is classified as hazardous material — relevant for compliance and logistics planning."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is manufactured — used for trade compliance and tariff analysis."
    - name: "product_family_code"
      expr: product_family_code
      comment: "Product family grouping code for portfolio-level aggregation and family performance analysis."
    - name: "lot_control_required"
      expr: lot_control_required
      comment: "Indicates whether lot/batch tracking is required — relevant for quality and traceability reporting."
    - name: "serial_control_required"
      expr: serial_control_required
      comment: "Indicates whether serialized unit tracking is required — relevant for service and warranty management."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the SKU became effective — used to track new product introduction cadence over time."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_master_id END)
      comment: "Count of SKUs currently in Active lifecycle status. Executives use this to monitor portfolio size and rationalization progress."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total number of SKU records in the master catalog. Baseline for portfolio breadth and complexity assessment."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost across all SKUs. Tracks cost profile of the portfolio and informs pricing and margin strategy."
    - name: "total_standard_cost_value"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard costs across all SKUs. Represents total theoretical cost exposure of the product portfolio."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight of SKUs in kilograms. Used for logistics planning and freight cost estimation."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight of SKUs. Used for material content analysis and packaging optimization."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN sku_master_id END)
      comment: "Number of SKUs classified as hazardous materials. Drives compliance, storage, and logistics risk management decisions."
    - name: "discontinued_sku_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Discontinued' THEN sku_master_id END)
      comment: "Count of discontinued SKUs. Monitors portfolio rationalization and end-of-life management effectiveness."
    - name: "make_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'Make' THEN sku_master_id END)
      comment: "Number of SKUs manufactured in-house. Informs capacity planning and make-vs-buy strategic decisions."
    - name: "buy_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'Buy' THEN sku_master_id END)
      comment: "Number of SKUs sourced externally. Informs supplier dependency and procurement strategy."
    - name: "active_sku_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_master_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs in Active status. Key portfolio health indicator — low active % signals rationalization need."
    - name: "lot_controlled_sku_count"
      expr: COUNT(CASE WHEN lot_control_required = TRUE THEN sku_master_id END)
      comment: "Number of SKUs requiring lot/batch control. Drives quality traceability infrastructure and compliance investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line revenue, margin, fulfillment, and pricing metrics. Provides the primary commercial performance view for the product domain — used by sales, finance, and supply chain leadership to track revenue realization, discount leakage, and delivery performance."
  source: "`vibe_manufacturing_v1`.`product`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., Open, Confirmed, Shipped, Cancelled) — primary filter for active vs. closed pipeline."
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item (e.g., Standard, Service, Configurable) — used to segment revenue by product type."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the order line — required for multi-currency revenue analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery fulfillment status of the line — used to track on-time delivery and backlog management."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the order line — used to track revenue recognition and unbilled backlog."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the line is on backorder — key signal for supply-demand imbalance and customer satisfaction risk."
    - name: "fulfillment_priority"
      expr: fulfillment_priority
      comment: "Priority level assigned to the order line for fulfillment sequencing — used in supply allocation decisions."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery date — used to analyze demand timing and seasonal patterns."
    - name: "confirmed_delivery_date"
      expr: DATE_TRUNC('month', confirmed_delivery_date)
      comment: "Month of confirmed delivery date — used to track committed delivery schedule and compare against requests."
    - name: "created_timestamp"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the order line was created — used for order intake trend analysis."
  measures:
    - name: "total_net_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net revenue across order lines after discounts. Primary top-line revenue KPI for the product domain."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_price AS DOUBLE))
      comment: "Total gross revenue before discounts. Used to measure list-price demand and quantify discount impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value given across order lines. Tracks pricing discipline and discount leakage."
    - name: "total_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin amount across order lines. Core profitability KPI for product portfolio performance."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of goods for order lines. Used to compute margin and assess cost efficiency."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across order lines. Required for tax compliance reporting and financial reconciliation."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered. Measures demand volume and drives production and supply planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped. Measures actual fulfillment output and is compared against ordered quantity for fill rate."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed order quantity. Represents committed supply and is used for revenue forecasting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price across order lines. Tracks pricing realization and average selling price trends."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to order lines. Key pricing governance metric — high averages signal margin erosion."
    - name: "order_line_count"
      expr: COUNT(1)
      comment: "Total number of order lines. Baseline volume metric for order complexity and processing load analysis."
    - name: "backorder_line_count"
      expr: COUNT(CASE WHEN backorder_flag = TRUE THEN order_line_id END)
      comment: "Number of order lines currently on backorder. Tracks supply shortfall impact on customer commitments."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been shipped. Core fulfillment KPI — low fill rate signals supply chain failure."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_price AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross revenue. Measures pricing discipline and discount leakage at portfolio level."
    - name: "avg_line_total_amount"
      expr: AVG(CAST(line_total_amount AS DOUBLE))
      comment: "Average total value per order line. Proxy for average order line size — used to assess deal quality and mix."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials governance metrics tracking BOM completeness, revision currency, configurability, and compliance status. Used by engineering, manufacturing, and product management to govern BOM quality and readiness."
  source: "`vibe_manufacturing_v1`.`product`.`bom_header`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., Active, Draft, Obsolete) — primary filter for production-ready BOMs."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g., Production, Engineering, Sales) — used to segment BOM population by purpose."
    - name: "bom_usage"
      expr: bom_usage
      comment: "Intended usage of the BOM (e.g., Production, Costing, Engineering) — drives routing and planning decisions."
    - name: "bom_category"
      expr: bom_category
      comment: "Category classification of the BOM — used for portfolio segmentation and governance reporting."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Indicates whether the BOM supports product configuration — key for configure-to-order product lines."
    - name: "is_phantom"
      expr: is_phantom
      comment: "Indicates whether the BOM is a phantom assembly (no physical stock) — relevant for production planning accuracy."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags BOMs for critical products requiring heightened governance and change control."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the BOM has regulatory compliance requirements — used for compliance risk monitoring."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether the BOM has environmental compliance requirements (e.g., RoHS, REACH)."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the BOM became effective — used to track BOM introduction and revision cadence."
  measures:
    - name: "total_bom_count"
      expr: COUNT(1)
      comment: "Total number of BOM headers. Baseline for BOM portfolio size and complexity management."
    - name: "active_bom_count"
      expr: COUNT(CASE WHEN bom_status = 'Active' THEN bom_header_id END)
      comment: "Number of BOMs in Active status. Measures the production-ready BOM population for manufacturing readiness."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN bom_header_id END)
      comment: "Number of configurable BOMs. Tracks configure-to-order product complexity and variant management scope."
    - name: "critical_bom_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN bom_header_id END)
      comment: "Number of BOMs flagged as critical. Drives prioritization of BOM governance and change control resources."
    - name: "regulatory_compliant_bom_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN bom_header_id END)
      comment: "Number of BOMs with regulatory compliance requirements. Used to scope compliance audit and certification workload."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity across BOMs. Used to understand typical production batch sizing in BOM definitions."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size defined in BOMs. Informs production scheduling and inventory planning parameters."
    - name: "active_bom_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bom_status = 'Active' THEN bom_header_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs in Active status. BOM portfolio health indicator — low active % signals governance backlog."
    - name: "phantom_bom_count"
      expr: COUNT(CASE WHEN is_phantom = TRUE THEN bom_header_id END)
      comment: "Number of phantom BOMs. Tracks virtual assembly complexity in the product structure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product revision and change management metrics tracking revision velocity, approval cycle times, regulatory impact, and change reason distribution. Used by engineering and product management to govern product change control effectiveness."
  source: "`vibe_manufacturing_v1`.`product`.`product_revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the product revision (e.g., Draft, Approved, Released, Obsolete) — primary lifecycle filter."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the revision — used to track pending approvals and bottlenecks in change control."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the revision (e.g., ECO, Customer Request, Regulatory) — used to analyze root causes of product changes."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Impact level of the revision (e.g., Major, Minor, Administrative) — used to prioritize change management resources."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "Type of effectivity (e.g., Date-based, Serial-based) — relevant for production scheduling and inventory management."
    - name: "bom_affected_flag"
      expr: bom_affected_flag
      comment: "Indicates whether the revision affects the BOM — triggers BOM update and re-release workflow."
    - name: "regulatory_approval_required_flag"
      expr: regulatory_approval_required_flag
      comment: "Flags revisions requiring regulatory body approval — used to track compliance-driven change workload."
    - name: "ppap_required_flag"
      expr: ppap_required_flag
      comment: "Indicates whether PPAP (Production Part Approval Process) is required — relevant for automotive and regulated industries."
    - name: "effectivity_date"
      expr: DATE_TRUNC('month', effectivity_date)
      comment: "Month the revision becomes effective — used to track change implementation cadence."
    - name: "release_date"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month the revision was released — used to measure change release velocity over time."
  measures:
    - name: "total_revision_count"
      expr: COUNT(1)
      comment: "Total number of product revisions. Baseline for change management volume and product instability assessment."
    - name: "approved_revision_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN product_revision_id END)
      comment: "Number of approved revisions. Measures change control throughput and approval pipeline health."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN product_revision_id END)
      comment: "Number of revisions awaiting approval. Tracks change control backlog and approval bottlenecks."
    - name: "regulatory_impact_revision_count"
      expr: COUNT(CASE WHEN regulatory_approval_required_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions requiring regulatory approval. Drives compliance workload planning and risk management."
    - name: "bom_impacting_revision_count"
      expr: COUNT(CASE WHEN bom_affected_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions that impact the BOM. Measures manufacturing disruption risk from product changes."
    - name: "ppap_required_revision_count"
      expr: COUNT(CASE WHEN ppap_required_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions requiring PPAP. Tracks supplier qualification workload triggered by product changes."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required_flag = TRUE THEN product_revision_id END)
      comment: "Number of revisions requiring customer notification. Tracks customer communication obligations from product changes."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN product_revision_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions that have been approved. Measures change control process efficiency and throughput rate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product change order metrics tracking change volume, approval cycle performance, cost impact, and implementation status. Used by engineering, quality, and product management leadership to govern the product change process."
  source: "`vibe_manufacturing_v1`.`product`.`change_order`"
  dimensions:
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change order (e.g., Open, In Review, Approved, Closed) — primary lifecycle filter."
    - name: "change_type"
      expr: change_type
      comment: "Type of change order (e.g., Engineering, Process, Supplier) — used to segment change volume by category."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Root cause reason code for the change — used to identify systemic issues driving product changes."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — used to track pending approvals and change control bottlenecks."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation progress status — used to track change execution and closure rates."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order (e.g., Critical, High, Medium, Low) — used for workload prioritization."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Indicates whether the change has regulatory impact — used to scope compliance review workload."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flags urgent change orders requiring expedited processing — used to manage critical change escalations."
    - name: "validation_required"
      expr: validation_required
      comment: "Indicates whether validation testing is required before implementation — tracks validation workload."
    - name: "created_timestamp"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the change order was created — used to track change volume trends over time."
  measures:
    - name: "total_change_order_count"
      expr: COUNT(1)
      comment: "Total number of change orders. Baseline for change management volume and product instability assessment."
    - name: "open_change_order_count"
      expr: COUNT(CASE WHEN change_status = 'Open' THEN change_order_id END)
      comment: "Number of open change orders. Tracks active change backlog and engineering workload."
    - name: "urgent_change_order_count"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN change_order_id END)
      comment: "Number of urgent change orders. Measures critical change pressure on engineering and manufacturing operations."
    - name: "regulatory_impact_change_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN change_order_id END)
      comment: "Number of change orders with regulatory impact. Drives compliance review resource allocation."
    - name: "total_impact_assessment_cost"
      expr: SUM(CAST(impact_assessment_cost AS DOUBLE))
      comment: "Total estimated cost impact across all change orders. Used by finance and product management to budget change programs."
    - name: "avg_impact_assessment_cost"
      expr: AVG(CAST(impact_assessment_cost AS DOUBLE))
      comment: "Average cost impact per change order. Benchmarks change complexity and cost efficiency of the change process."
    - name: "validation_required_count"
      expr: COUNT(CASE WHEN validation_required = TRUE THEN change_order_id END)
      comment: "Number of change orders requiring validation. Tracks validation testing workload and resource requirements."
    - name: "customer_approval_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN change_order_id END)
      comment: "Number of change orders requiring customer approval or notification. Tracks customer-facing change obligations."
    - name: "change_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_status = 'Closed' THEN change_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change orders that have been closed. Measures change management process throughput and backlog clearance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification portfolio metrics tracking certification coverage, expiry risk, compliance status, and regulatory market access. Used by regulatory affairs, product management, and compliance leadership to manage certification obligations."
  source: "`vibe_manufacturing_v1`.`product`.`product_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired, Pending, Revoked) — primary filter for compliance posture."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., Safety, Environmental, Quality, Functional Safety) — used to segment compliance portfolio."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification (e.g., UL, CE, TÜV) — used to track certification authority relationships."
    - name: "certification_level"
      expr: certification_level
      comment: "Level or tier of the certification — used to assess depth of compliance coverage."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Indicates REACH chemical regulation compliance — critical for EU market access."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Indicates RoHS hazardous substance compliance — required for electronics market access in EU and other regions."
    - name: "weee_compliant"
      expr: weee_compliant
      comment: "Indicates WEEE waste electrical equipment compliance — required for EU electronics market."
    - name: "is_customer_facing"
      expr: is_customer_facing
      comment: "Indicates whether the certification is visible/required by customers — used to prioritize renewal efforts."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of certification expiry — used to identify upcoming renewal obligations and expiry risk."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the certification was issued — used to track certification acquisition cadence."
  measures:
    - name: "total_certification_count"
      expr: COUNT(1)
      comment: "Total number of product certifications. Baseline for compliance portfolio scope and management workload."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN product_certification_id END)
      comment: "Number of currently active certifications. Measures compliance coverage and market access enablement."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN product_certification_id END)
      comment: "Number of expired certifications. Tracks compliance gaps and market access risk from lapsed certifications."
    - name: "customer_facing_certification_count"
      expr: COUNT(CASE WHEN is_customer_facing = TRUE THEN product_certification_id END)
      comment: "Number of customer-facing certifications. Measures compliance assets that directly support sales and customer trust."
    - name: "reach_compliant_count"
      expr: COUNT(CASE WHEN reach_compliant = TRUE THEN product_certification_id END)
      comment: "Number of certifications with REACH compliance. Tracks EU chemical regulation coverage across the product portfolio."
    - name: "rohs_compliant_count"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN product_certification_id END)
      comment: "Number of certifications with RoHS compliance. Tracks hazardous substance compliance for electronics products."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost invested in product certifications. Used by finance and regulatory affairs to budget compliance programs."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification investment efficiency and informs budget planning."
    - name: "active_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Active' THEN product_certification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications currently active. Core compliance health KPI — low rate signals market access risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply agreement portfolio metrics tracking contracted volume commitments, pricing, agreement coverage, and renewal risk. Used by procurement, supply chain, and finance leadership to govern supplier supply agreements and cost commitments."
  source: "`vibe_manufacturing_v1`.`product`.`supply_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the supply agreement (e.g., Active, Expired, Pending, Terminated) — primary filter for active supply coverage."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of supply agreement (e.g., Long-term, Spot, Framework) — used to segment supply strategy by agreement structure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement — required for multi-currency cost and commitment analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing delivery responsibility — used to assess logistics cost allocation in supply agreements."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the agreement auto-renews — used to identify agreements requiring active renewal management."
    - name: "agreement_start_date"
      expr: DATE_TRUNC('year', agreement_start_date)
      comment: "Year the agreement started — used to analyze agreement vintage and portfolio renewal cycles."
    - name: "agreement_end_date"
      expr: DATE_TRUNC('month', agreement_end_date)
      comment: "Month the agreement expires — used to identify upcoming renewal obligations and supply continuity risk."
  measures:
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of supply agreements. Baseline for supply agreement portfolio scope and management complexity."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN supply_agreement_id END)
      comment: "Number of active supply agreements. Measures current supply coverage and supplier relationship breadth."
    - name: "total_committed_annual_volume"
      expr: SUM(CAST(committed_annual_volume AS DOUBLE))
      comment: "Total committed annual volume across all supply agreements. Measures supply commitment exposure and demand coverage."
    - name: "total_contracted_volume"
      expr: SUM(CAST(contracted_volume AS DOUBLE))
      comment: "Total contracted volume across supply agreements. Used to assess supply security and volume commitment levels."
    - name: "total_agreed_price_value"
      expr: SUM(CAST(agreed_price_amount AS DOUBLE))
      comment: "Total agreed price value across supply agreements. Measures total procurement cost commitment under active agreements."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across supply agreements. Benchmarks procurement pricing and tracks price trend over time."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across agreements. Informs inventory planning and cash flow requirements."
    - name: "auto_renew_agreement_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN supply_agreement_id END)
      comment: "Number of agreements set to auto-renew. Tracks passive renewal exposure requiring proactive review."
    - name: "active_agreement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN agreement_status = 'Active' THEN supply_agreement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supply agreements currently active. Measures supply agreement portfolio health and coverage rate."
    - name: "avg_maximum_order_quantity"
      expr: AVG(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Average maximum order quantity across agreements. Used to assess supply flexibility and capacity ceiling under agreements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product specification completeness and compliance metrics tracking specification coverage, technical parameter distribution, and regulatory alignment. Used by engineering and quality leadership to govern product specification quality."
  source: "`vibe_manufacturing_v1`.`product`.`product_specification`"
  dimensions:
    - name: "specification_status"
      expr: specification_status
      comment: "Current status of the specification (e.g., Draft, Approved, Obsolete) — primary filter for active specification governance."
    - name: "specification_type"
      expr: specification_type
      comment: "Type of specification (e.g., Mechanical, Electrical, Environmental) — used to segment specification portfolio by discipline."
    - name: "application_suitability"
      expr: application_suitability
      comment: "Application suitability classification — used to match specifications to product use cases and market segments."
    - name: "mounting_type"
      expr: mounting_type
      comment: "Mounting type specification — used for product configuration and installation planning analysis."
    - name: "ip_rating"
      expr: ip_rating
      comment: "Ingress protection rating — used to segment products by environmental protection level for market targeting."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the specification became effective — used to track specification release cadence."
    - name: "approved_date"
      expr: DATE_TRUNC('month', approved_date)
      comment: "Month the specification was approved — used to measure approval cycle time and governance throughput."
  measures:
    - name: "total_specification_count"
      expr: COUNT(1)
      comment: "Total number of product specifications. Baseline for specification portfolio scope and documentation completeness."
    - name: "approved_specification_count"
      expr: COUNT(CASE WHEN specification_status = 'Approved' THEN product_specification_id END)
      comment: "Number of approved specifications. Measures specification governance completeness and product readiness."
    - name: "avg_power_rating_watts"
      expr: AVG(CAST(power_rating_watts AS DOUBLE))
      comment: "Average power rating across product specifications. Used for energy planning, compliance, and product portfolio analysis."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average product weight across specifications. Used for logistics planning and packaging design decisions."
    - name: "avg_operating_temp_max_c"
      expr: AVG(CAST(operating_temperature_max_c AS DOUBLE))
      comment: "Average maximum operating temperature across specifications. Used to assess product suitability for high-temperature applications."
    - name: "avg_operating_temp_min_c"
      expr: AVG(CAST(operating_temperature_min_c AS DOUBLE))
      comment: "Average minimum operating temperature across specifications. Used to assess product suitability for cold-environment applications."
    - name: "avg_current_rating_amperes"
      expr: AVG(CAST(current_rating_amperes AS DOUBLE))
      comment: "Average current rating across electrical product specifications. Used for electrical system design and safety compliance."
    - name: "approved_specification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN specification_status = 'Approved' THEN product_specification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specifications in Approved status. Measures specification governance health and documentation readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_plant_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level product data metrics tracking MRP parameters, inventory policy settings, and production readiness across the product-plant matrix. Used by supply chain and production planning leadership to govern material master data quality."
  source: "`vibe_manufacturing_v1`.`product`.`plant_data`"
  dimensions:
    - name: "plant_status"
      expr: plant_status
      comment: "Status of the product at the plant level (e.g., Active, Blocked, Discontinued) — primary filter for production-ready materials."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (e.g., MRP, Reorder Point, Consumption-based) — used to segment planning strategy across the portfolio."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type at plant level (e.g., In-house, External, Both) — drives make-vs-buy planning decisions."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant identifier — used to analyze material master data completeness and planning parameters by plant."
    - name: "batch_management_required"
      expr: batch_management_required
      comment: "Indicates whether batch management is required at this plant — relevant for quality and traceability compliance."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Indicates whether backflushing is used for material consumption — relevant for production cost accuracy."
    - name: "negative_stock_allowed"
      expr: negative_stock_allowed
      comment: "Indicates whether negative stock is permitted — flags potential inventory accuracy risks."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification at plant level — used to prioritize inventory management attention."
  measures:
    - name: "total_plant_material_records"
      expr: COUNT(1)
      comment: "Total number of product-plant data records. Measures material master data scope and completeness across plants."
    - name: "active_plant_material_count"
      expr: COUNT(CASE WHEN plant_status = 'Active' THEN plant_data_id END)
      comment: "Number of active product-plant records. Measures production-ready material master coverage."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across plant-material records. Used to assess inventory buffer policy and working capital impact."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all plant-material records. Measures total inventory buffer investment."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across plant-material records. Benchmarks replenishment trigger levels for inventory planning."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across plant-material records. Informs production scheduling and procurement order sizing."
    - name: "avg_maximum_lot_size"
      expr: AVG(CAST(maximum_lot_size AS DOUBLE))
      comment: "Average maximum lot size. Used to assess production batch size constraints and inventory accumulation risk."
    - name: "avg_shelf_life_expiration_days"
      expr: AVG(CAST(shelf_life_expiration_days AS DOUBLE))
      comment: "Average shelf life in days across plant-material records. Used to manage perishable inventory and minimize obsolescence."
    - name: "batch_managed_material_count"
      expr: COUNT(CASE WHEN batch_management_required = TRUE THEN plant_data_id END)
      comment: "Number of plant-material records requiring batch management. Tracks traceability infrastructure scope and compliance requirements."
    - name: "negative_stock_allowed_count"
      expr: COUNT(CASE WHEN negative_stock_allowed = TRUE THEN plant_data_id END)
      comment: "Number of plant-material records allowing negative stock. Flags inventory accuracy risk and data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_lifecycle_stage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product lifecycle stage metrics tracking end-of-life planning, last-time-buy exposure, and lifecycle transition velocity. Used by product management and supply chain leadership to govern product discontinuation and portfolio renewal."
  source: "`vibe_manufacturing_v1`.`product`.`lifecycle_stage`"
  dimensions:
    - name: "lifecycle_stage_code"
      expr: lifecycle_stage_code
      comment: "Current lifecycle stage code (e.g., Introduction, Growth, Maturity, Decline, EOL) — primary segmentation for portfolio lifecycle analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the lifecycle stage record is currently active — used to filter current vs. historical stage assignments."
    - name: "market_demand_trend"
      expr: market_demand_trend
      comment: "Market demand trend for the product (e.g., Growing, Stable, Declining) — used to inform portfolio investment decisions."
    - name: "lifecycle_decision_authority"
      expr: lifecycle_decision_authority
      comment: "Organizational authority responsible for lifecycle decisions — used for governance accountability tracking."
    - name: "planned_eol_date"
      expr: DATE_TRUNC('quarter', planned_eol_date)
      comment: "Quarter of planned end-of-life — used to forecast EOL workload and customer communication obligations."
    - name: "last_time_buy_date"
      expr: DATE_TRUNC('month', last_time_buy_date)
      comment: "Month of last-time-buy date — used to manage final procurement and inventory wind-down planning."
    - name: "stage_entry_date"
      expr: DATE_TRUNC('quarter', stage_entry_date)
      comment: "Quarter the product entered the current lifecycle stage — used to track stage duration and transition velocity."
  measures:
    - name: "total_lifecycle_records"
      expr: COUNT(1)
      comment: "Total number of lifecycle stage records. Baseline for lifecycle management portfolio scope."
    - name: "active_lifecycle_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN lifecycle_stage_id END)
      comment: "Number of currently active lifecycle stage assignments. Measures active portfolio under lifecycle management."
    - name: "eol_stage_count"
      expr: COUNT(CASE WHEN lifecycle_stage_code = 'EOL' THEN lifecycle_stage_id END)
      comment: "Number of products in End-of-Life stage. Tracks portfolio rationalization progress and EOL management workload."
    - name: "declining_demand_count"
      expr: COUNT(CASE WHEN market_demand_trend = 'Declining' THEN lifecycle_stage_id END)
      comment: "Number of products with declining market demand. Identifies portfolio at risk of revenue decline requiring strategic action."
    - name: "customer_notification_pending_count"
      expr: COUNT(CASE WHEN customer_notification_date IS NULL AND planned_eol_date IS NOT NULL THEN lifecycle_stage_id END)
      comment: "Number of EOL-planned products where customer notification has not yet been sent. Tracks customer communication obligations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product family portfolio metrics tracking family-level financial targets, lifecycle health, and strategic positioning. Used by product management and finance leadership to govern product line performance and investment allocation."
  source: "`vibe_manufacturing_v1`.`product`.`family`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the product family (e.g., Active, Declining, Discontinued) — primary filter for active portfolio analysis."
    - name: "family_type"
      expr: family_type
      comment: "Type classification of the product family — used to segment portfolio by product line structure."
    - name: "market_segment"
      expr: market_segment
      comment: "Target market segment for the family — used to analyze portfolio coverage and market strategy alignment."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement strategy for the family (e.g., Make, Buy, Hybrid) — informs supply chain strategy decisions."
    - name: "iot_enabled"
      expr: iot_enabled
      comment: "Indicates whether the product family includes IoT-enabled products — tracks digital product portfolio growth."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Indicates whether the family includes hazardous materials — used for compliance and logistics risk management."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the product family hierarchy — used to analyze portfolio structure and aggregation levels."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the product family became effective — used to track portfolio introduction cadence."
  measures:
    - name: "total_family_count"
      expr: COUNT(1)
      comment: "Total number of product families. Baseline for portfolio breadth and product line complexity."
    - name: "active_family_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN family_id END)
      comment: "Number of active product families. Measures current portfolio scope and active product line coverage."
    - name: "iot_enabled_family_count"
      expr: COUNT(CASE WHEN iot_enabled = TRUE THEN family_id END)
      comment: "Number of IoT-enabled product families. Tracks digital transformation progress in the product portfolio."
    - name: "avg_target_margin_pct"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target margin percentage across product families. Benchmarks profitability expectations and portfolio margin strategy."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost across product families. Used to assess cost profile and pricing strategy by family."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across product families. Tracks pricing positioning and price-to-cost ratio at family level."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across product families. Measures reliability profile of the portfolio — key for service and warranty planning."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across product families. Measures serviceability of the portfolio — informs field service resource planning."
    - name: "hazmat_family_count"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN family_id END)
      comment: "Number of product families containing hazardous materials. Tracks compliance and logistics risk scope."
$$;