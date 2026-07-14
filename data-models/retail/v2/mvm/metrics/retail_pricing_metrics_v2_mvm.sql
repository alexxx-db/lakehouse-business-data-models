-- Metric views for domain: pricing | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_sku_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU pricing metrics tracking retail prices, margins, markdowns, and competitive positioning across channels and price zones"
  source: "`vibe_retail_v1`.`pricing`.`sku_price`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel (e.g., store, online, mobile) for price differentiation analysis"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., regular, promotional, clearance) for pricing strategy segmentation"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the price for governance tracking"
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Business reason for price change (e.g., cost increase, competitive response, markdown)"
    - name: "is_dynamic_pricing_enabled"
      expr: is_dynamic_pricing_enabled
      comment: "Flag indicating whether dynamic pricing algorithms are active for this SKU"
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Flag indicating whether price is locked and cannot be changed without special approval"
    - name: "effective_date"
      expr: effective_date
      comment: "Date when the price becomes effective for trend analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of price effectiveness for monthly pricing trend analysis"
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of competitor used as pricing reference for competitive positioning analysis"
  measures:
    - name: "total_retail_revenue_potential"
      expr: SUM(CAST(retail_price AS DOUBLE))
      comment: "Sum of all retail prices representing total revenue potential if all SKUs sold one unit"
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price across SKUs for pricing level benchmarking"
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage across SKUs for profitability assessment"
    - name: "avg_initial_markup_pct"
      expr: AVG(CAST(initial_markup_pct AS DOUBLE))
      comment: "Average initial markup percentage for pricing strategy effectiveness"
    - name: "avg_markdown_pct"
      expr: AVG(CAST(markdown_pct AS DOUBLE))
      comment: "Average markdown percentage indicating promotional intensity and margin erosion"
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total dollar value of markdowns representing revenue at risk or promotional investment"
    - name: "avg_price_floor"
      expr: AVG(CAST(price_floor AS DOUBLE))
      comment: "Average minimum allowable price for margin protection analysis"
    - name: "avg_price_ceiling"
      expr: AVG(CAST(price_ceiling AS DOUBLE))
      comment: "Average maximum allowable price for competitive positioning analysis"
    - name: "avg_competitive_price_ref"
      expr: AVG(CAST(competitive_price_ref AS DOUBLE))
      comment: "Average competitor reference price for competitive price gap analysis"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with active pricing for assortment breadth tracking"
    - name: "price_locked_sku_count"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN sku_id END)
      comment: "Number of SKUs with locked prices indicating pricing inflexibility"
    - name: "dynamic_pricing_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN is_dynamic_pricing_enabled = TRUE THEN sku_id END)
      comment: "Number of SKUs with dynamic pricing enabled for automation adoption tracking"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price change event metrics tracking frequency, magnitude, and impact of pricing decisions on margins and competitive positioning"
  source: "`vibe_retail_v1`.`pricing`.`price_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g., increase, decrease, new) for change pattern analysis"
    - name: "change_category"
      expr: change_category
      comment: "Category of price change (e.g., strategic, tactical, reactive) for decision quality assessment"
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for price change for root cause and trigger analysis"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy driving the change (e.g., cost-plus, competitive, value-based)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of price change for governance and compliance tracking"
    - name: "is_cost_change"
      expr: is_cost_change
      comment: "Flag indicating whether change was driven by cost fluctuation"
    - name: "is_margin_breach"
      expr: is_margin_breach
      comment: "Flag indicating whether change resulted in margin policy breach requiring escalation"
    - name: "channel"
      expr: channel
      comment: "Sales channel where price change applies for channel-specific pricing analysis"
    - name: "effective_date"
      expr: effective_date
      comment: "Date when price change becomes effective for timing and seasonality analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of price change effectiveness for monthly trend analysis"
    - name: "competitor_name"
      expr: competitor_name
      comment: "Competitor name if change was competitive response for competitive intelligence"
  measures:
    - name: "total_price_changes"
      expr: COUNT(1)
      comment: "Total number of price change events for pricing volatility and activity tracking"
    - name: "distinct_sku_changed"
      expr: COUNT(DISTINCT price_sku_id)
      comment: "Number of unique SKUs with price changes for pricing churn assessment"
    - name: "avg_retail_price_change_pct"
      expr: AVG(CAST(retail_price_change_pct AS DOUBLE))
      comment: "Average percentage change in retail price for pricing elasticity and magnitude tracking"
    - name: "avg_retail_price_change_amount"
      expr: AVG(CAST(retail_price_change_amount AS DOUBLE))
      comment: "Average dollar change in retail price for absolute pricing impact assessment"
    - name: "total_retail_price_change_amount"
      expr: SUM(CAST(retail_price_change_amount AS DOUBLE))
      comment: "Total dollar value of all retail price changes for aggregate revenue impact"
    - name: "avg_new_margin_pct"
      expr: AVG(CAST(new_margin_pct AS DOUBLE))
      comment: "Average new margin percentage after price change for profitability impact assessment"
    - name: "avg_prior_margin_pct"
      expr: AVG(CAST(prior_margin_pct AS DOUBLE))
      comment: "Average prior margin percentage before price change for baseline comparison"
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average percentage change in cost for cost inflation tracking"
    - name: "margin_breach_count"
      expr: COUNT(CASE WHEN is_margin_breach = TRUE THEN 1 END)
      comment: "Number of price changes that breached margin policy for risk and compliance tracking"
    - name: "cost_driven_change_count"
      expr: COUNT(CASE WHEN is_cost_change = TRUE THEN 1 END)
      comment: "Number of price changes driven by cost fluctuations for cost pass-through analysis"
    - name: "competitive_response_count"
      expr: COUNT(CASE WHEN competitor_name IS NOT NULL THEN 1 END)
      comment: "Number of price changes made in response to competitor actions for competitive agility tracking"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_markdown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown and clearance metrics tracking promotional depth, sell-through performance, and inventory liquidation effectiveness"
  source: "`vibe_retail_v1`.`pricing`.`markdown`"
  dimensions:
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g., promotional, clearance, seasonal) for markdown strategy segmentation"
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current status of markdown (e.g., active, expired, pending) for lifecycle tracking"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for markdown (e.g., slow-moving, end-of-season, damaged) for root cause analysis"
    - name: "clearance_stage"
      expr: clearance_stage
      comment: "Stage of clearance process (e.g., initial, mid, final) for liquidation progression tracking"
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method for disposing unsold inventory (e.g., liquidator, donation, destroy) for recovery optimization"
    - name: "is_competitive_response"
      expr: is_competitive_response
      comment: "Flag indicating markdown was competitive response for competitive pressure assessment"
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Flag indicating item is dead stock with no sales velocity for inventory health tracking"
    - name: "channel"
      expr: channel
      comment: "Sales channel where markdown applies for channel-specific markdown analysis"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of markdown for timing and seasonality analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of markdown start for monthly markdown trend analysis"
  measures:
    - name: "total_markdowns"
      expr: COUNT(1)
      comment: "Total number of markdown events for markdown frequency and activity tracking"
    - name: "distinct_sku_marked_down"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with markdowns for markdown breadth assessment"
    - name: "avg_markdown_pct"
      expr: AVG(CAST(percent AS DOUBLE))
      comment: "Average markdown percentage for promotional depth and margin erosion tracking"
    - name: "avg_markdown_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average dollar markdown amount for absolute promotional investment assessment"
    - name: "total_markdown_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of all markdowns representing total margin investment in promotions"
    - name: "avg_sell_through_actual_pct"
      expr: AVG(CAST(sell_through_actual_pct AS DOUBLE))
      comment: "Average actual sell-through percentage for markdown effectiveness assessment"
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average target sell-through percentage for goal-setting and performance benchmarking"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply at markdown initiation for inventory health and urgency assessment"
    - name: "dead_stock_markdown_count"
      expr: COUNT(CASE WHEN is_dead_stock = TRUE THEN 1 END)
      comment: "Number of markdowns on dead stock items for inventory quality and write-off risk tracking"
    - name: "competitive_response_markdown_count"
      expr: COUNT(CASE WHEN is_competitive_response = TRUE THEN 1 END)
      comment: "Number of markdowns made as competitive response for competitive pressure quantification"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_competitive_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive pricing intelligence metrics tracking price gaps, competitive positioning, and market share opportunities"
  source: "`vibe_retail_v1`.`pricing`.`competitive_price`"
  dimensions:
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of competitor for competitor-specific price gap analysis"
    - name: "competitor_channel"
      expr: competitor_channel
      comment: "Competitor sales channel (e.g., store, online) for cross-channel competitive analysis"
    - name: "match_type"
      expr: match_type
      comment: "Type of product match (e.g., exact, similar, substitute) for match quality assessment"
    - name: "data_source_vendor"
      expr: data_source_vendor
      comment: "Vendor providing competitive price data for data quality and coverage tracking"
    - name: "competitor_promo_flag"
      expr: competitor_promo_flag
      comment: "Flag indicating competitor is running promotion for promotional pressure assessment"
    - name: "competitor_in_stock_flag"
      expr: competitor_in_stock_flag
      comment: "Flag indicating competitor has item in stock for availability-based opportunity analysis"
    - name: "price_gap_trend"
      expr: price_gap_trend
      comment: "Trend of price gap (e.g., widening, narrowing, stable) for competitive momentum tracking"
    - name: "response_status"
      expr: response_status
      comment: "Status of pricing response to competitive gap (e.g., pending, implemented, no action)"
    - name: "observation_date"
      expr: observation_date
      comment: "Date of competitive price observation for recency and trend analysis"
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', observation_date)
      comment: "Month of competitive price observation for monthly competitive trend analysis"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market for regional competitive positioning analysis"
  measures:
    - name: "total_competitive_observations"
      expr: COUNT(1)
      comment: "Total number of competitive price observations for data coverage and freshness tracking"
    - name: "distinct_competitor_count"
      expr: COUNT(DISTINCT competitor_name)
      comment: "Number of unique competitors tracked for competitive landscape breadth"
    - name: "distinct_sku_tracked"
      expr: COUNT(DISTINCT competitive_sku_id)
      comment: "Number of unique SKUs with competitive price tracking for coverage assessment"
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average competitor price for market price level benchmarking"
    - name: "avg_price_gap"
      expr: AVG(CAST(price_gap AS DOUBLE))
      comment: "Average absolute price gap (our price minus competitor price) for competitive positioning assessment"
    - name: "avg_price_gap_pct"
      expr: AVG(CAST(price_gap_pct AS DOUBLE))
      comment: "Average percentage price gap for relative competitive positioning and elasticity analysis"
    - name: "avg_price_index"
      expr: AVG(CAST(price_index AS DOUBLE))
      comment: "Average price index (our price / competitor price * 100) for competitive price positioning"
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average match confidence score for data quality and reliability assessment"
    - name: "competitor_promo_count"
      expr: COUNT(CASE WHEN competitor_promo_flag = TRUE THEN 1 END)
      comment: "Number of observations where competitor is running promotion for promotional pressure tracking"
    - name: "competitor_out_of_stock_count"
      expr: COUNT(CASE WHEN competitor_in_stock_flag = FALSE THEN 1 END)
      comment: "Number of observations where competitor is out of stock for availability-based opportunity identification"
    - name: "response_implemented_count"
      expr: COUNT(CASE WHEN response_status = 'implemented' THEN 1 END)
      comment: "Number of competitive gaps where pricing response was implemented for action rate tracking"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost price metrics tracking landed costs, cost inflation, duty impact, and supplier cost performance for margin management"
  source: "`vibe_retail_v1`.`pricing`.`cost_price`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g., standard, actual, landed) for cost accounting segmentation"
    - name: "cost_status"
      expr: cost_status
      comment: "Status of cost record (e.g., active, pending, expired) for cost lifecycle tracking"
    - name: "cost_change_reason"
      expr: cost_change_reason
      comment: "Reason for cost change (e.g., supplier increase, currency, freight) for cost driver analysis"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for sourcing strategy and duty impact analysis"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial term defining cost responsibility for freight and duty allocation"
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating whether this is the current active cost for cost accuracy tracking"
    - name: "effective_date"
      expr: effective_date
      comment: "Date when cost becomes effective for cost timing and inflation trend analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of cost effectiveness for monthly cost trend analysis"
    - name: "supplier_code"
      expr: supplier_code
      comment: "Supplier code for supplier cost performance and negotiation leverage analysis"
  measures:
    - name: "total_cost_records"
      expr: COUNT(1)
      comment: "Total number of cost records for cost data coverage and maintenance tracking"
    - name: "distinct_sku_costed"
      expr: COUNT(DISTINCT cost_sku_id)
      comment: "Number of unique SKUs with cost records for cost coverage assessment"
    - name: "avg_base_cost"
      expr: AVG(CAST(base_cost AS DOUBLE))
      comment: "Average base cost before freight and duty for supplier cost benchmarking"
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average landed cost including all freight and duty for true cost of goods assessment"
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost across all SKUs for aggregate cost of goods and inventory valuation"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per SKU for logistics cost optimization"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for supply chain cost management and carrier negotiation"
    - name: "avg_duty_amount"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per SKU for tariff impact assessment"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty amount for tariff cost burden and sourcing strategy optimization"
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_pct AS DOUBLE))
      comment: "Average duty rate percentage for tariff exposure and country-of-origin strategy"
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average percentage change in cost for cost inflation and supplier performance tracking"
    - name: "avg_handling_cost"
      expr: AVG(CAST(handling_cost AS DOUBLE))
      comment: "Average handling cost per SKU for warehouse and logistics efficiency assessment"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price approval workflow metrics tracking approval velocity, escalation rates, and governance compliance for pricing authority management"
  source: "`vibe_retail_v1`.`pricing`.`price_approval`"
  dimensions:
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval (e.g., new price, markdown, cost change) for approval workflow segmentation"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status (e.g., pending, approved, rejected) for workflow state tracking"
    - name: "approval_tier"
      expr: approval_tier
      comment: "Approval tier or authority level (e.g., buyer, director, VP) for delegation effectiveness"
    - name: "is_auto_approved"
      expr: is_auto_approved
      comment: "Flag indicating automatic approval via rules for automation adoption tracking"
    - name: "is_escalated"
      expr: is_escalated
      comment: "Flag indicating approval was escalated to higher authority for exception rate tracking"
    - name: "escalation_tier"
      expr: escalation_tier
      comment: "Tier to which approval was escalated for escalation pattern analysis"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for rejection for quality improvement and policy refinement"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy associated with approval for strategy-specific approval patterns"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_timestamp)
      comment: "Month of approval request for monthly approval volume and velocity trends"
    - name: "approval_channel"
      expr: approval_channel
      comment: "Channel through which approval was requested (e.g., system, email, manual) for process efficiency"
  measures:
    - name: "total_approval_requests"
      expr: COUNT(1)
      comment: "Total number of approval requests for approval volume and workload tracking"
    - name: "approved_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of approved requests for approval success rate calculation"
    - name: "rejected_count"
      expr: COUNT(CASE WHEN approval_status = 'rejected' THEN 1 END)
      comment: "Number of rejected requests for quality and policy compliance assessment"
    - name: "pending_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of pending approvals for backlog and bottleneck identification"
    - name: "auto_approved_count"
      expr: COUNT(CASE WHEN is_auto_approved = TRUE THEN 1 END)
      comment: "Number of auto-approved requests for automation effectiveness and rule coverage"
    - name: "escalated_count"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN 1 END)
      comment: "Number of escalated approvals for exception rate and authority delegation effectiveness"
    - name: "avg_proposed_price"
      expr: AVG(CAST(proposed_price AS DOUBLE))
      comment: "Average proposed price for pricing level and change magnitude assessment"
    - name: "avg_current_price"
      expr: AVG(CAST(current_price AS DOUBLE))
      comment: "Average current price for baseline comparison and change impact"
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average percentage price change requested for change magnitude and risk assessment"
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage at proposed price for profitability impact assessment"
    - name: "avg_competitive_price_ref"
      expr: AVG(CAST(competitive_price_ref AS DOUBLE))
      comment: "Average competitive reference price for competitive positioning context in approvals"
$$;