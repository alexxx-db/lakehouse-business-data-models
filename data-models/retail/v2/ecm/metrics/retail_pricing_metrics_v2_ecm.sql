-- Metric views for domain: pricing | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_sku_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core retail price metrics at the SKU level, enabling analysis of retail pricing health, margin performance, markdown depth, and price floor/ceiling compliance across channels and price zones."
  source: "`vibe_retail_v1`.`pricing`.`sku_price`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for which the SKU price applies (e.g. in-store, e-commerce, wholesale), enabling channel-level price analysis."
    - name: "price_type"
      expr: price_type
      comment: "Classification of the price record (e.g. regular, promotional, clearance), used to segment pricing analysis by price lifecycle stage."
    - name: "approval_status"
      expr: approval_status
      comment: "Workflow approval state of the SKU price record, used to filter for approved vs. pending prices in operational dashboards."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the price, enabling multi-currency price analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month in which the SKU price became effective, used for trend analysis of pricing changes over time."
    - name: "is_dynamic_pricing_enabled"
      expr: is_dynamic_pricing_enabled
      comment: "Indicates whether dynamic pricing is active for this SKU price record, enabling comparison of dynamic vs. static pricing outcomes."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Indicates whether the price is locked and cannot be overridden, used to monitor price governance compliance."
  measures:
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail selling price across SKU price records. Executives use this to monitor price positioning and detect unintended price drift across the assortment."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage across active SKU prices. A primary profitability KPI used in category reviews and pricing strategy assessments."
    - name: "avg_initial_markup_pct"
      expr: AVG(CAST(initial_markup_pct AS DOUBLE))
      comment: "Average initial markup percentage at time of price setting. Indicates how aggressively merchandise is marked up before markdowns, a key merchandising health metric."
    - name: "avg_markdown_pct"
      expr: AVG(CAST(markdown_pct AS DOUBLE))
      comment: "Average markdown percentage applied to SKU prices. High values signal excess inventory or weak demand, triggering merchandising intervention."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total dollar value of markdowns applied across SKU price records. A direct measure of margin erosion from price reductions, tracked in P&L reviews."
    - name: "avg_price_floor"
      expr: AVG(CAST(price_floor AS DOUBLE))
      comment: "Average minimum allowable price floor across SKU prices. Used to assess how much pricing headroom exists before floor violations occur."
    - name: "avg_price_ceiling"
      expr: AVG(CAST(price_ceiling AS DOUBLE))
      comment: "Average maximum allowable price ceiling across SKU prices. Used alongside price floor to evaluate the effective pricing band width."
    - name: "count_price_records"
      expr: COUNT(1)
      comment: "Total number of active SKU price records. Used as a baseline denominator for ratio metrics and to monitor pricing catalog completeness."
    - name: "count_dynamic_pricing_enabled"
      expr: COUNT(CASE WHEN is_dynamic_pricing_enabled = TRUE THEN 1 END)
      comment: "Number of SKU prices with dynamic pricing enabled. Tracks adoption of algorithmic pricing, a strategic initiative metric for pricing transformation programs."
    - name: "avg_channel_price_variance"
      expr: AVG(CAST(channel_price_variance AS DOUBLE))
      comment: "Average price variance across channels for the same SKU. Elevated variance may indicate channel conflict or pricing inconsistency requiring governance action."
    - name: "avg_min_advertised_price"
      expr: AVG(CAST(min_advertised_price AS DOUBLE))
      comment: "Average minimum advertised price (MAP) across SKU prices. Used to monitor compliance with vendor MAP policies and protect brand equity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking the volume, magnitude, and margin impact of retail price changes. Used by pricing teams and executives to govern price change velocity, margin risk, and competitive responsiveness."
  source: "`vibe_retail_v1`.`pricing`.`price_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g. regular price change, promotional, competitive response), used to categorize price change activity by business driver."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the price change (e.g. cost-driven, competitive, seasonal), enabling root-cause analysis of pricing movements."
    - name: "channel"
      expr: channel
      comment: "Sales channel affected by the price change, enabling channel-level price change analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the price change, used to monitor governance compliance and identify bottlenecks in the approval pipeline."
    - name: "is_margin_breach"
      expr: is_margin_breach
      comment: "Indicates whether the price change caused a margin floor breach, a critical risk flag for profitability governance."
    - name: "is_cost_change"
      expr: is_cost_change
      comment: "Indicates whether the price change was triggered by a cost change, enabling cost-pass-through analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the price change became effective, used for trend analysis of pricing activity over time."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the price change, enabling structured analysis of price change drivers across the assortment."
  measures:
    - name: "total_price_changes"
      expr: COUNT(1)
      comment: "Total number of price change events. High velocity may indicate pricing instability; used in pricing governance dashboards."
    - name: "avg_retail_price_change_pct"
      expr: AVG(CAST(retail_price_change_pct AS DOUBLE))
      comment: "Average percentage change in retail price across all price change events. Tracks the magnitude of pricing movements and competitive responsiveness."
    - name: "total_retail_price_change_amount"
      expr: SUM(CAST(retail_price_change_amount AS DOUBLE))
      comment: "Total absolute dollar value of retail price changes. Measures the aggregate pricing impact across the assortment in a given period."
    - name: "avg_new_margin_pct"
      expr: AVG(CAST(new_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage after price changes are applied. A leading indicator of post-change profitability used in pricing strategy reviews."
    - name: "avg_prior_margin_pct"
      expr: AVG(CAST(prior_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage before price changes. Used alongside avg_new_margin_pct to quantify the margin impact of pricing decisions."
    - name: "count_margin_breaches"
      expr: COUNT(CASE WHEN is_margin_breach = TRUE THEN 1 END)
      comment: "Number of price changes that breached the minimum margin floor. A critical risk metric reviewed in pricing governance and compliance meetings."
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average cost change percentage associated with price change events. Measures how effectively cost increases are being passed through to retail prices."
    - name: "count_competitive_responses"
      expr: COUNT(CASE WHEN trigger_signal = 'competitive' THEN 1 END)
      comment: "Number of price changes triggered by competitive signals. Tracks the volume of reactive pricing activity, informing competitive strategy investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_competitive_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive pricing intelligence metrics measuring price gaps, price index positioning, and competitive response effectiveness. Used by pricing and category teams to maintain market competitiveness."
  source: "`vibe_retail_v1`.`pricing`.`competitive_price`"
  dimensions:
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor being benchmarked, enabling competitor-specific price gap analysis."
    - name: "competitor_channel"
      expr: competitor_channel
      comment: "Channel through which the competitor price was observed (e.g. in-store, online), enabling channel-level competitive benchmarking."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market where the competitive price was observed, enabling regional competitive analysis."
    - name: "category_code"
      expr: category_code
      comment: "Product category code for the observed competitive price, enabling category-level competitive positioning analysis."
    - name: "response_status"
      expr: response_status
      comment: "Status of the pricing response to the competitive observation (e.g. actioned, pending, no action), used to track competitive response execution."
    - name: "competitor_promo_flag"
      expr: competitor_promo_flag
      comment: "Indicates whether the competitor price is a promotional price, enabling separation of everyday vs. promotional competitive pricing."
    - name: "observation_date_month"
      expr: DATE_TRUNC('month', observation_date)
      comment: "Month of competitive price observation, used for trend analysis of competitive price movements."
    - name: "price_gap_trend"
      expr: price_gap_trend
      comment: "Direction of price gap movement (widening, narrowing, stable), used to monitor competitive positioning trajectory."
  measures:
    - name: "avg_price_index"
      expr: AVG(CAST(price_index AS DOUBLE))
      comment: "Average price index (own price relative to competitor price). Values above 1.0 indicate premium positioning; below 1.0 indicates price leadership. A primary competitive positioning KPI."
    - name: "avg_price_gap"
      expr: AVG(CAST(price_gap AS DOUBLE))
      comment: "Average absolute price gap between own price and competitor price. Directly informs pricing response decisions and competitive strategy."
    - name: "avg_price_gap_pct"
      expr: AVG(CAST(price_gap_pct AS DOUBLE))
      comment: "Average percentage price gap versus competitors. The primary metric for competitive price positioning reviews and pricing strategy calibration."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of product matching between own SKU and competitor product. Low scores indicate data quality issues in competitive intelligence."
    - name: "avg_normalized_unit_price"
      expr: AVG(CAST(normalized_unit_price AS DOUBLE))
      comment: "Average normalized unit price of competitor products, enabling apples-to-apples comparison across different pack sizes and units of measure."
    - name: "count_competitive_observations"
      expr: COUNT(1)
      comment: "Total number of competitive price observations. Measures the breadth of competitive intelligence coverage, a key input to pricing strategy confidence."
    - name: "count_responded_observations"
      expr: COUNT(CASE WHEN response_status = 'implemented' THEN 1 END)
      comment: "Number of competitive observations that resulted in an implemented pricing response. Measures competitive agility and response execution rate."
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average observed competitor price. Used as a market benchmark in pricing strategy reviews and category management meetings."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_markdown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown management metrics tracking markdown depth, sell-through performance, and clearance effectiveness. Used by merchants and finance to manage inventory liquidation and protect margin."
  source: "`vibe_retail_v1`.`pricing`.`markdown`"
  dimensions:
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g. permanent, promotional, clearance), used to segment markdown analysis by business purpose."
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current status of the markdown (e.g. active, expired, cancelled), used to filter for active markdowns in operational reporting."
    - name: "clearance_stage"
      expr: clearance_stage
      comment: "Stage of the clearance process (e.g. initial, final, last chance), enabling analysis of clearance progression and timing."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the markdown is applied, enabling channel-level markdown analysis."
    - name: "is_competitive_response"
      expr: is_competitive_response
      comment: "Indicates whether the markdown was triggered by a competitive price action, enabling separation of reactive vs. planned markdowns."
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Indicates whether the markdown is applied to dead stock inventory, a critical flag for inventory health monitoring."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the markdown became effective, used for trend analysis of markdown activity over time."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the markdown, enabling structured analysis of markdown drivers."
  measures:
    - name: "avg_markdown_percent"
      expr: AVG(CAST(percent AS DOUBLE))
      comment: "Average markdown depth as a percentage of original retail price. A primary merchandising KPI indicating the severity of price reductions across the assortment."
    - name: "total_markdown_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of markdowns taken. Directly impacts gross margin and is a key line item in financial planning and P&L reviews."
    - name: "avg_sell_through_actual_pct"
      expr: AVG(CAST(sell_through_actual_pct AS DOUBLE))
      comment: "Average actual sell-through rate achieved under markdown. Measures markdown effectiveness in liquidating inventory."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average targeted sell-through rate for markdown events. Used alongside actual sell-through to measure markdown plan attainment."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply remaining at markdown initiation. High values indicate excess inventory risk requiring deeper or earlier markdowns."
    - name: "count_markdowns"
      expr: COUNT(1)
      comment: "Total number of markdown events. Used to monitor markdown activity volume and identify categories or channels with elevated markdown frequency."
    - name: "count_dead_stock_markdowns"
      expr: COUNT(CASE WHEN is_dead_stock = TRUE THEN 1 END)
      comment: "Number of markdowns applied to dead stock. A critical inventory health metric indicating the scale of non-moving inventory requiring liquidation."
    - name: "avg_original_retail_price"
      expr: AVG(CAST(original_retail_price AS DOUBLE))
      comment: "Average original retail price before markdown. Used to contextualize markdown depth and assess the price tier of marked-down merchandise."
    - name: "avg_marked_down_price"
      expr: AVG(CAST(marked_down_price AS DOUBLE))
      comment: "Average retail price after markdown is applied. Used alongside original retail price to quantify the effective price reduction delivered to customers."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_margin_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Margin planning and attainment metrics tracking gross margin targets, markdown budget utilization, and sell-through goals by category and season. Used in financial planning and category management reviews."
  source: "`vibe_retail_v1`.`pricing`.`margin_target`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for which the margin target is set, enabling channel-level margin planning analysis."
    - name: "target_status"
      expr: target_status
      comment: "Status of the margin target (e.g. active, draft, approved), used to filter for operative targets in reporting."
    - name: "brand_classification"
      expr: brand_classification
      comment: "Brand classification (e.g. national brand, private label) for the margin target, enabling brand-tier margin analysis."
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g. seasonal, annual, quarterly) for the margin target, enabling period-level margin planning analysis."
    - name: "planning_period_label"
      expr: planning_period_label
      comment: "Label of the planning period (e.g. Spring/Summer, Fall/Winter), used for seasonal margin planning comparisons."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the margin target became effective, used for trend analysis of margin planning over time."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the margin target is locked for the planning period, used to distinguish finalized from draft targets."
  measures:
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average targeted gross margin percentage across margin targets. The primary financial planning KPI for category and channel profitability goals."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average Gross Margin Return on Inventory Investment (GMROI) target. A key retail productivity metric used in merchandise financial planning reviews."
    - name: "avg_target_sell_through_rate_pct"
      expr: AVG(CAST(target_sell_through_rate_pct AS DOUBLE))
      comment: "Average targeted sell-through rate across margin targets. Measures inventory productivity goals and informs markdown planning."
    - name: "total_markdown_budget_total"
      expr: SUM(CAST(markdown_budget_total AS DOUBLE))
      comment: "Total markdown budget allocated across all margin targets. A key financial planning metric for managing margin erosion from planned price reductions."
    - name: "total_markdown_budget_consumed"
      expr: SUM(CAST(markdown_budget_consumed AS DOUBLE))
      comment: "Total markdown budget consumed to date. Used alongside total budget to calculate budget utilization and forecast remaining markdown capacity."
    - name: "total_markdown_budget_remaining"
      expr: SUM(CAST(markdown_budget_remaining AS DOUBLE))
      comment: "Total markdown budget remaining across all active margin targets. Indicates available capacity for further markdowns without breaching financial plan."
    - name: "avg_budget_utilization_pct"
      expr: AVG(CAST(budget_utilization_pct AS DOUBLE))
      comment: "Average markdown budget utilization percentage. High utilization early in a season signals risk of exceeding markdown budget, triggering financial review."
    - name: "avg_minimum_margin_floor_pct"
      expr: AVG(CAST(minimum_margin_floor_pct AS DOUBLE))
      comment: "Average minimum margin floor percentage across targets. Defines the hard profitability boundary below which pricing decisions require escalation."
    - name: "avg_private_label_margin_premium_pct"
      expr: AVG(CAST(private_label_margin_premium_pct AS DOUBLE))
      comment: "Average margin premium targeted for private label products over national brands. A strategic KPI for own-brand profitability programs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost price metrics tracking landed cost, duty burden, freight costs, and cost change trends. Used by finance and merchandising to manage cost of goods and vendor negotiations."
  source: "`vibe_retail_v1`.`pricing`.`cost_price`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost price record (e.g. standard, actual, negotiated), used to segment cost analysis by cost methodology."
    - name: "cost_status"
      expr: cost_status
      comment: "Approval and lifecycle status of the cost price record, used to filter for active and approved costs in financial reporting."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product was sourced, enabling analysis of cost structures by sourcing geography and trade policy impact."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial term (e.g. FOB, CIF, DDP) governing cost responsibility, used to analyze cost structures by delivery terms."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency in which the cost is denominated, enabling multi-currency cost analysis and FX impact assessment."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the cost price became effective, used for trend analysis of cost movements over time."
    - name: "is_current"
      expr: is_current
      comment: "Indicates whether this is the current active cost price record, used to filter for current costs in operational reporting."
  measures:
    - name: "avg_base_cost"
      expr: AVG(CAST(base_cost AS DOUBLE))
      comment: "Average base cost before duties and freight. The foundational cost metric used in margin calculations and vendor negotiation benchmarking."
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average fully landed cost including duties, freight, and handling. The true cost of goods used in margin planning and pricing decisions."
    - name: "avg_duty_amount"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per cost record. Used to quantify tariff burden and assess the financial impact of trade policy changes."
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_pct AS DOUBLE))
      comment: "Average duty rate percentage. A key metric for trade compliance and sourcing strategy, especially when evaluating country-of-origin shifts."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per cost record. Tracks logistics cost trends and informs supply chain optimization decisions."
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average percentage change in cost versus prior cost. A leading indicator of margin pressure requiring pricing or sourcing response."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to cost records. Used to monitor FX exposure in the cost base and inform hedging decisions."
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost across all cost price records. Provides aggregate cost of goods exposure for financial planning and budget reviews."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price override metrics tracking the volume, value, and risk profile of manual price overrides at point of sale. Used by loss prevention, finance, and store operations to govern override compliance."
  source: "`vibe_retail_v1`.`pricing`.`price_override`"
  dimensions:
    - name: "override_type"
      expr: override_type
      comment: "Type of price override (e.g. competitive match, customer accommodation, error correction), used to categorize override activity by business driver."
    - name: "override_status"
      expr: override_status
      comment: "Status of the price override (e.g. approved, voided, pending), used to filter for active overrides in compliance reporting."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the override occurred, enabling channel-level override analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the price override, enabling structured analysis of override drivers for loss prevention and governance."
    - name: "approval_required"
      expr: approval_required
      comment: "Indicates whether the override required management approval, used to assess governance compliance of override activity."
    - name: "exceeds_threshold"
      expr: exceeds_threshold
      comment: "Indicates whether the override exceeded the authorized threshold, a critical risk flag for loss prevention monitoring."
    - name: "shrinkage_related"
      expr: shrinkage_related
      comment: "Indicates whether the override is associated with shrinkage activity, used in loss prevention analysis."
    - name: "override_timestamp_month"
      expr: DATE_TRUNC('month', override_timestamp)
      comment: "Month the override was applied, used for trend analysis of override activity over time."
  measures:
    - name: "total_override_impact"
      expr: SUM(CAST(total_override_impact AS DOUBLE))
      comment: "Total financial impact of all price overrides. A primary loss prevention and margin governance metric reviewed in store operations and audit meetings."
    - name: "avg_override_amount"
      expr: AVG(CAST(override_amount AS DOUBLE))
      comment: "Average dollar amount of price overrides. Used to assess the typical magnitude of override activity and set appropriate authorization thresholds."
    - name: "avg_override_percentage"
      expr: AVG(CAST(override_percentage AS DOUBLE))
      comment: "Average percentage reduction applied via price overrides. Measures the depth of discounting through override activity."
    - name: "count_overrides"
      expr: COUNT(1)
      comment: "Total number of price override events. High volumes may indicate systemic pricing issues or compliance risks requiring investigation."
    - name: "count_threshold_exceeded"
      expr: COUNT(CASE WHEN exceeds_threshold = TRUE THEN 1 END)
      comment: "Number of overrides that exceeded the authorized threshold. A critical compliance metric for loss prevention and pricing governance programs."
    - name: "count_shrinkage_related"
      expr: COUNT(CASE WHEN shrinkage_related = TRUE THEN 1 END)
      comment: "Number of overrides flagged as shrinkage-related. Used by loss prevention to quantify the scale of shrinkage-driven price manipulation."
    - name: "avg_original_price"
      expr: AVG(CAST(original_price AS DOUBLE))
      comment: "Average original price before override. Used to contextualize the magnitude of overrides relative to the standard price point."
    - name: "avg_override_price"
      expr: AVG(CAST(override_price AS DOUBLE))
      comment: "Average price after override is applied. Used alongside original price to measure the effective discount delivered through override activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_sensitivity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price elasticity and demand sensitivity metrics used by pricing scientists and category managers to optimize price points, understand demand curves, and calibrate promotional depth."
  source: "`vibe_retail_v1`.`pricing`.`price_sensitivity`"
  dimensions:
    - name: "elasticity_classification"
      expr: elasticity_classification
      comment: "Classification of price elasticity (e.g. elastic, inelastic, unit elastic), used to segment products by demand sensitivity for pricing strategy."
    - name: "channel"
      expr: channel
      comment: "Sales channel for which the price sensitivity analysis was conducted, enabling channel-specific elasticity analysis."
    - name: "model_type"
      expr: model_type
      comment: "Type of econometric model used for elasticity estimation, used to assess analytical methodology consistency."
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the price sensitivity analysis (e.g. approved, draft, expired), used to filter for validated elasticity estimates."
    - name: "analysis_period_start_month"
      expr: DATE_TRUNC('month', analysis_period_start_date)
      comment: "Month the analysis period started, used for trend analysis of elasticity estimates over time."
  measures:
    - name: "avg_elasticity_coefficient"
      expr: AVG(CAST(elasticity_coefficient AS DOUBLE))
      comment: "Average price elasticity coefficient across analyzed SKUs. The core demand science metric used to calibrate pricing decisions and promotional depth."
    - name: "avg_cross_price_elasticity"
      expr: AVG(CAST(cross_price_elasticity AS DOUBLE))
      comment: "Average cross-price elasticity measuring demand substitution between products. Used to manage cannibalization risk in pricing and promotional planning."
    - name: "avg_promotional_elasticity"
      expr: AVG(CAST(promotional_elasticity AS DOUBLE))
      comment: "Average promotional price elasticity. Measures demand lift sensitivity to promotional price reductions, informing promotional investment decisions."
    - name: "avg_optimal_price_point"
      expr: AVG(CAST(optimal_price_point AS DOUBLE))
      comment: "Average model-recommended optimal price point. Used by pricing teams to calibrate regular prices toward demand-optimal levels."
    - name: "avg_profit_maximizing_price"
      expr: AVG(CAST(profit_maximizing_price AS DOUBLE))
      comment: "Average profit-maximizing price point from demand models. A strategic pricing KPI used to balance volume and margin objectives."
    - name: "avg_revenue_maximizing_price"
      expr: AVG(CAST(revenue_maximizing_price AS DOUBLE))
      comment: "Average revenue-maximizing price point. Used alongside profit-maximizing price to understand the revenue-margin trade-off in pricing decisions."
    - name: "avg_r_squared"
      expr: AVG(CAST(r_squared AS DOUBLE))
      comment: "Average R-squared model fit statistic across price sensitivity analyses. Measures the reliability of elasticity estimates, a data quality KPI for the pricing science function."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of elasticity estimates. Used to assess the trustworthiness of demand models before applying them to pricing decisions."
    - name: "avg_markdown_sensitivity_score"
      expr: AVG(CAST(markdown_sensitivity_score AS DOUBLE))
      comment: "Average markdown sensitivity score indicating how responsive demand is to markdown events. Used to prioritize markdown depth and timing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_audit_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price audit and compliance metrics tracking the volume, margin impact, and override activity captured in the pricing audit trail. Used by compliance, finance, and pricing governance teams."
  source: "`vibe_retail_v1`.`pricing`.`price_audit_log`"
  dimensions:
    - name: "audit_action"
      expr: audit_action
      comment: "Type of pricing action recorded in the audit log (e.g. price set, override, approval, reversal), used to categorize audit activity."
    - name: "audit_event_type"
      expr: audit_event_type
      comment: "Category of audit event, used to segment audit log analysis by event type for compliance reporting."
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the audit log entry, used to filter for active vs. reversed audit records."
    - name: "channel"
      expr: channel
      comment: "Sales channel associated with the audited pricing action, enabling channel-level compliance analysis."
    - name: "is_margin_breach"
      expr: is_margin_breach
      comment: "Indicates whether the audited price action caused a margin breach, a critical compliance flag."
    - name: "is_override"
      expr: is_override
      comment: "Indicates whether the audited action was a price override, used to isolate override activity in compliance reporting."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Indicates whether the pricing action required escalation, used to monitor governance escalation rates."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the audit event, used for trend analysis of pricing compliance activity over time."
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of pricing audit log entries. Measures the volume of auditable pricing activity, a baseline metric for compliance program monitoring."
    - name: "count_margin_breaches"
      expr: COUNT(CASE WHEN is_margin_breach = TRUE THEN 1 END)
      comment: "Number of audited pricing actions that resulted in a margin breach. A critical compliance and financial risk metric reviewed in governance meetings."
    - name: "count_overrides"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Number of audited price override events. Used to monitor override frequency and assess compliance with pricing governance policies."
    - name: "count_escalations"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN 1 END)
      comment: "Number of pricing actions that required escalation. High escalation rates indicate systemic pricing governance issues requiring process improvement."
    - name: "avg_margin_impact"
      expr: AVG(CAST(margin_impact AS DOUBLE))
      comment: "Average margin impact of audited pricing actions. Quantifies the financial consequence of pricing decisions captured in the audit trail."
    - name: "avg_price_change_percent"
      expr: AVG(CAST(price_change_percent AS DOUBLE))
      comment: "Average percentage price change recorded in audit events. Used to assess the magnitude of pricing activity and detect anomalous price movements."
    - name: "avg_new_margin_percent"
      expr: AVG(CAST(new_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage after the audited price action. Used to assess the post-action profitability profile of pricing decisions."
    - name: "avg_prior_margin_percent"
      expr: AVG(CAST(prior_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage before the audited price action. Used alongside new margin to quantify the margin impact of pricing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price zone configuration and performance metrics used to govern geographic and channel-based pricing structures. Used by pricing strategy and finance teams to manage zone-level pricing policies."
  source: "`vibe_retail_v1`.`pricing`.`price_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of price zone (e.g. geographic, channel, competitive), used to segment zone analysis by pricing structure type."
    - name: "zone_status"
      expr: zone_status
      comment: "Operational status of the price zone (e.g. active, inactive, pending), used to filter for active zones in reporting."
    - name: "market_tier"
      expr: market_tier
      comment: "Market tier classification of the price zone (e.g. tier 1, tier 2, rural), enabling market-tier pricing analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code for the price zone, enabling country-level pricing structure analysis."
    - name: "is_competitive_zone"
      expr: is_competitive_zone
      comment: "Indicates whether the zone is designated as a competitive pricing zone, used to analyze pricing aggressiveness by zone."
    - name: "is_ecommerce_enabled"
      expr: is_ecommerce_enabled
      comment: "Indicates whether the price zone applies to e-commerce, enabling omnichannel pricing structure analysis."
    - name: "zone_hierarchy_level"
      expr: zone_hierarchy_level
      comment: "Hierarchical level of the price zone within the zone structure, used for rollup analysis across zone hierarchies."
  measures:
    - name: "avg_base_price_multiplier"
      expr: AVG(CAST(base_price_multiplier AS DOUBLE))
      comment: "Average base price multiplier applied in each zone. Measures the degree of price differentiation across zones relative to the base price."
    - name: "avg_competitive_index"
      expr: AVG(CAST(competitive_index AS DOUBLE))
      comment: "Average competitive price index across price zones. Measures how competitively priced each zone is relative to the market, a key strategic positioning metric."
    - name: "avg_max_markdown_pct"
      expr: AVG(CAST(max_markdown_pct AS DOUBLE))
      comment: "Average maximum markdown percentage allowed per zone. Used to assess the markdown governance headroom available across the zone structure."
    - name: "avg_min_margin_pct"
      expr: AVG(CAST(min_margin_pct AS DOUBLE))
      comment: "Average minimum margin percentage floor across price zones. Defines the profitability guardrails built into the zone pricing structure."
    - name: "count_active_zones"
      expr: COUNT(CASE WHEN zone_status = 'active' THEN 1 END)
      comment: "Number of currently active price zones. Used to monitor the complexity and scale of the pricing zone structure."
    - name: "count_competitive_zones"
      expr: COUNT(CASE WHEN is_competitive_zone = TRUE THEN 1 END)
      comment: "Number of zones designated as competitive pricing zones. Indicates the geographic scope of competitive pricing strategy deployment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_cost_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Zone business metrics"
  source: "`vibe_retail_v1`.`pricing`.`cost_zone`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Competitive Intensity"
      expr: competitive_intensity
    - name: "Cost Review Frequency"
      expr: cost_review_frequency
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Default Cost Method"
      expr: default_cost_method
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Last Cost Review Date"
      expr: last_cost_review_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Zone"
      expr: COUNT(DISTINCT cost_zone_id)
    - name: "Total Annual Revenue Amount"
      expr: SUM(annual_revenue_amount)
    - name: "Average Annual Revenue Amount"
      expr: AVG(annual_revenue_amount)
    - name: "Total Annual Volume Units"
      expr: SUM(annual_volume_units)
    - name: "Average Annual Volume Units"
      expr: AVG(annual_volume_units)
    - name: "Total Approval Threshold Amount"
      expr: SUM(approval_threshold_amount)
    - name: "Average Approval Threshold Amount"
      expr: AVG(approval_threshold_amount)
    - name: "Total Cost Adjustment Factor"
      expr: SUM(cost_adjustment_factor)
    - name: "Average Cost Adjustment Factor"
      expr: AVG(cost_adjustment_factor)
    - name: "Total Duty Factor Percentage"
      expr: SUM(duty_factor_percentage)
    - name: "Average Duty Factor Percentage"
      expr: AVG(duty_factor_percentage)
    - name: "Total Freight Factor Percentage"
      expr: SUM(freight_factor_percentage)
    - name: "Average Freight Factor Percentage"
      expr: AVG(freight_factor_percentage)
    - name: "Total Minimum Margin Percentage"
      expr: SUM(minimum_margin_percentage)
    - name: "Average Minimum Margin Percentage"
      expr: AVG(minimum_margin_percentage)
    - name: "Total Overhead Factor Percentage"
      expr: SUM(overhead_factor_percentage)
    - name: "Average Overhead Factor Percentage"
      expr: AVG(overhead_factor_percentage)
    - name: "Total Target Margin Percentage"
      expr: SUM(target_margin_percentage)
    - name: "Average Target Margin Percentage"
      expr: AVG(target_margin_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Approval business metrics"
  source: "`vibe_retail_v1`.`pricing`.`price_approval`"
  dimensions:
    - name: "Approval Channel"
      expr: approval_channel
    - name: "Approval Notes"
      expr: approval_notes
    - name: "Approval Number"
      expr: approval_number
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Tier"
      expr: approval_tier
    - name: "Approval Type"
      expr: approval_type
    - name: "Business Justification"
      expr: business_justification
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Escalation Tier"
      expr: escalation_tier
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Approval"
      expr: COUNT(DISTINCT price_approval_id)
    - name: "Total Competitive Price Ref"
      expr: SUM(competitive_price_ref)
    - name: "Average Competitive Price Ref"
      expr: AVG(competitive_price_ref)
    - name: "Total Current Price"
      expr: SUM(current_price)
    - name: "Average Current Price"
      expr: AVG(current_price)
    - name: "Total Gross Margin Pct"
      expr: SUM(gross_margin_pct)
    - name: "Average Gross Margin Pct"
      expr: AVG(gross_margin_pct)
    - name: "Total Price Change Pct"
      expr: SUM(price_change_pct)
    - name: "Average Price Change Pct"
      expr: AVG(price_change_pct)
    - name: "Total Proposed Price"
      expr: SUM(proposed_price)
    - name: "Average Proposed Price"
      expr: AVG(proposed_price)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price List business metrics"
  source: "`vibe_retail_v1`.`pricing`.`price_list`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Division Code"
      expr: division_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Default"
      expr: is_default
    - name: "Is Taxable"
      expr: is_taxable
    - name: "List Type"
      expr: list_type
    - name: "Loyalty Tier Code"
      expr: loyalty_tier_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price List"
      expr: COUNT(DISTINCT price_list_id)
    - name: "Total Base Margin Pct"
      expr: SUM(base_margin_pct)
    - name: "Average Base Margin Pct"
      expr: AVG(base_margin_pct)
    - name: "Total Competitive Index"
      expr: SUM(competitive_index)
    - name: "Average Competitive Index"
      expr: AVG(competitive_index)
    - name: "Total Markdown Pct"
      expr: SUM(markdown_pct)
    - name: "Average Markdown Pct"
      expr: AVG(markdown_pct)
    - name: "Total Max Selling Price"
      expr: SUM(max_selling_price)
    - name: "Average Max Selling Price"
      expr: AVG(max_selling_price)
    - name: "Total Min Selling Price"
      expr: SUM(min_selling_price)
    - name: "Average Min Selling Price"
      expr: AVG(min_selling_price)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Strategy business metrics"
  source: "`vibe_retail_v1`.`pricing`.`price_strategy`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Competitor Benchmark Set"
      expr: competitor_benchmark_set
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dynamic Pricing Enabled"
      expr: dynamic_pricing_enabled
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hilo Swing Frequency Days"
      expr: hilo_swing_frequency_days
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Map Enforcement Enabled"
      expr: map_enforcement_enabled
    - name: "Markdown Optimization Enabled"
      expr: markdown_optimization_enabled
    - name: "Notes"
      expr: notes
    - name: "Price Change Approval Required"
      expr: price_change_approval_required
    - name: "Price Review Frequency"
      expr: price_review_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Strategy"
      expr: COUNT(DISTINCT price_strategy_id)
    - name: "Total Approval Threshold Pct"
      expr: SUM(approval_threshold_pct)
    - name: "Average Approval Threshold Pct"
      expr: AVG(approval_threshold_pct)
    - name: "Total Aur Floor"
      expr: SUM(aur_floor)
    - name: "Average Aur Floor"
      expr: AVG(aur_floor)
    - name: "Total Competitive Index Target"
      expr: SUM(competitive_index_target)
    - name: "Average Competitive Index Target"
      expr: AVG(competitive_index_target)
    - name: "Total Cost Plus Markup Pct"
      expr: SUM(cost_plus_markup_pct)
    - name: "Average Cost Plus Markup Pct"
      expr: AVG(cost_plus_markup_pct)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Hilo Promo Depth Pct"
      expr: SUM(hilo_promo_depth_pct)
    - name: "Average Hilo Promo Depth Pct"
      expr: AVG(hilo_promo_depth_pct)
    - name: "Total Private Label Differential Pct"
      expr: SUM(private_label_differential_pct)
    - name: "Average Private Label Differential Pct"
      expr: AVG(private_label_differential_pct)
    - name: "Total Sell Through Rate Target Pct"
      expr: SUM(sell_through_rate_target_pct)
    - name: "Average Sell Through Rate Target Pct"
      expr: AVG(sell_through_rate_target_pct)
    - name: "Total Target Margin Max Pct"
      expr: SUM(target_margin_max_pct)
    - name: "Average Target Margin Max Pct"
      expr: AVG(target_margin_max_pct)
    - name: "Total Target Margin Min Pct"
      expr: SUM(target_margin_min_pct)
    - name: "Average Target Margin Min Pct"
      expr: AVG(target_margin_min_pct)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rule business metrics"
  source: "`vibe_retail_v1`.`pricing`.`rule`"
  dimensions:
    - name: "Adjustment Method"
      expr: adjustment_method
    - name: "Algorithm Version"
      expr: algorithm_version
    - name: "Applicable Days Of Week"
      expr: applicable_days_of_week
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Mode"
      expr: execution_mode
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Loyalty Exclusive"
      expr: loyalty_exclusive
    - name: "Override Approval Required"
      expr: override_approval_required
    - name: "Override Permitted"
      expr: override_permitted
    - name: "Priority"
      expr: priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rule"
      expr: COUNT(DISTINCT rule_id)
    - name: "Total Adjustment Value"
      expr: SUM(adjustment_value)
    - name: "Average Adjustment Value"
      expr: AVG(adjustment_value)
    - name: "Total Competitor Price Index"
      expr: SUM(competitor_price_index)
    - name: "Average Competitor Price Index"
      expr: AVG(competitor_price_index)
    - name: "Total Cost Plus Margin Pct"
      expr: SUM(cost_plus_margin_pct)
    - name: "Average Cost Plus Margin Pct"
      expr: AVG(cost_plus_margin_pct)
    - name: "Total Markdown Depth Pct"
      expr: SUM(markdown_depth_pct)
    - name: "Average Markdown Depth Pct"
      expr: AVG(markdown_depth_pct)
    - name: "Total Max Price"
      expr: SUM(max_price)
    - name: "Average Max Price"
      expr: AVG(max_price)
    - name: "Total Min Price"
      expr: SUM(min_price)
    - name: "Average Min Price"
      expr: AVG(min_price)
    - name: "Total Sell Through Target Pct"
      expr: SUM(sell_through_target_pct)
    - name: "Average Sell Through Target Pct"
      expr: AVG(sell_through_target_pct)
    - name: "Total Trigger Threshold Value"
      expr: SUM(trigger_threshold_value)
    - name: "Average Trigger Threshold Value"
      expr: AVG(trigger_threshold_value)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_rule_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rule Application business metrics"
  source: "`vibe_retail_v1`.`pricing`.`rule_application`"
  dimensions:
    - name: "Adjustment Method"
      expr: adjustment_method
    - name: "Application Status"
      expr: application_status
    - name: "Created Date"
      expr: created_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Sequence"
      expr: execution_sequence
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Override Permitted"
      expr: override_permitted
    - name: "Rule Priority"
      expr: rule_priority
    - name: "Stackable Flag"
      expr: stackable_flag
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rule Application"
      expr: COUNT(DISTINCT rule_application_id)
    - name: "Total Adjustment Value"
      expr: SUM(adjustment_value)
    - name: "Average Adjustment Value"
      expr: AVG(adjustment_value)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_zone_price_list_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zone Price List Assignment business metrics"
  source: "`vibe_retail_v1`.`pricing`.`zone_price_list_assignment`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Assigned By"
      expr: assigned_by
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Active"
      expr: is_active
    - name: "Override Rules"
      expr: override_rules
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Source System Code"
      expr: source_system_code
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
    - name: "Assigned Timestamp Month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Zone Price List Assignment"
      expr: COUNT(DISTINCT zone_price_list_assignment_id)
    - name: "Total Currency Conversion Rate"
      expr: SUM(currency_conversion_rate)
    - name: "Average Currency Conversion Rate"
      expr: AVG(currency_conversion_rate)
$$;