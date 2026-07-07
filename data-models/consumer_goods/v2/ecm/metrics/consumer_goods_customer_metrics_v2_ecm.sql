-- Metric views for domain: customer | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`customer_channel_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the channel classification master. Provides executives and commercial leaders with visibility into channel portfolio composition, trade-promotion eligibility, OTIF targets, ordering economics, and digital/EDI readiness — all critical inputs for channel investment decisions, route-to-market strategy, and customer segmentation reviews."
  source: "`vibe_consumer_goods_v1`.`customer`.`channel_classification`"
  dimensions:
    - name: "channel_name"
      expr: channel_name
      comment: "Business name of the channel (e.g. Modern Trade, E-Commerce, DSD). Primary grouping dimension for all channel-level KPIs."
    - name: "channel_code"
      expr: channel_code
      comment: "Short code identifying the channel. Used for filtering and cross-system reconciliation."
    - name: "channel_format"
      expr: channel_format
      comment: "Physical or digital format of the channel (e.g. Hypermarket, Convenience, Online). Enables format-level performance analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment the channel serves (e.g. Mass, Premium, Value). Supports segment-level investment and margin analysis."
    - name: "distribution_model"
      expr: distribution_model
      comment: "How product reaches this channel (e.g. Direct, Distributor, DSD). Key dimension for supply chain and cost-to-serve analysis."
    - name: "primary_tier"
      expr: primary_tier
      comment: "Primary strategic tier of the channel (e.g. Tier 1, Tier 2). Used to prioritise resource allocation and investment levels."
    - name: "secondary_tier"
      expr: secondary_tier
      comment: "Secondary tier classification providing finer-grained channel stratification within the primary tier."
    - name: "tertiary_tier"
      expr: tertiary_tier
      comment: "Tertiary tier for the most granular channel stratification, used in detailed route-to-market planning."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to this channel (e.g. EDLP, Hi-Lo, Promotional). Informs revenue management and trade spend decisions."
    - name: "active_status"
      expr: active_status
      comment: "Whether the channel classification is currently active. Filters operational views to live channels only."
    - name: "applicable_region"
      expr: applicable_region
      comment: "Geographic region where this channel classification applies. Enables regional channel portfolio analysis."
    - name: "order_frequency"
      expr: order_frequency
      comment: "How frequently orders are placed in this channel (e.g. Weekly, Daily). Drives replenishment planning and logistics cost modelling."
    - name: "payment_terms_standard"
      expr: payment_terms_standard
      comment: "Standard payment terms for this channel (e.g. Net 30, Net 60). Informs working capital and cash-flow planning."
    - name: "return_policy"
      expr: return_policy
      comment: "Return policy applicable to this channel. Relevant for reverse logistics cost and customer satisfaction analysis."
    - name: "trade_promotion_eligible_flag"
      expr: trade_promotion_eligible_flag
      comment: "Whether this channel is eligible for trade promotions. Core filter for trade spend eligibility analysis."
    - name: "acv_eligible_flag"
      expr: acv_eligible_flag
      comment: "Whether this channel is eligible for ACV (All Commodity Volume) measurement. Used in distribution and velocity reporting."
    - name: "tdp_eligible_flag"
      expr: tdp_eligible_flag
      comment: "Whether this channel is eligible for TDP (Total Distribution Points) measurement. Key metric for distribution coverage KPIs."
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Whether the channel supports EDI order transmission. Informs digital integration investment and order automation rates."
    - name: "pos_data_available_flag"
      expr: pos_data_available_flag
      comment: "Whether POS sell-out data is available for this channel. Critical for demand sensing and promotional effectiveness measurement."
    - name: "planogram_required_flag"
      expr: planogram_required_flag
      comment: "Whether a planogram is required for this channel. Drives field execution and category management workload planning."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which this channel classification became effective. Used for time-based trend and cohort analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Date on which this channel classification expires or was retired. Used to identify channels approaching end-of-life."
  measures:
    - name: "total_active_channels"
      expr: COUNT(CASE WHEN active_status = 'Active' THEN channel_classification_id END)
      comment: "Count of currently active channel classifications. Baseline KPI for channel portfolio size; a shrinking active count signals rationalisation or market exit."
    - name: "total_channels"
      expr: COUNT(channel_classification_id)
      comment: "Total count of all channel classification records regardless of status. Used as the denominator for activation-rate and eligibility-rate calculations."
    - name: "trade_promotion_eligible_channel_count"
      expr: COUNT(CASE WHEN trade_promotion_eligible_flag = TRUE THEN channel_classification_id END)
      comment: "Number of channels eligible for trade promotions. Directly informs trade spend budget allocation and promotional reach decisions."
    - name: "trade_promotion_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN trade_promotion_eligible_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(channel_classification_id), 0), 2)
      comment: "Percentage of channel classifications that are trade-promotion eligible. A high rate indicates broad promotional reach; a low rate signals constrained trade investment options."
    - name: "edi_capable_channel_count"
      expr: COUNT(CASE WHEN edi_capable_flag = TRUE THEN channel_classification_id END)
      comment: "Number of channels with EDI capability. Tracks digital order automation coverage; low counts indicate manual order processing risk and cost."
    - name: "edi_capability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edi_capable_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(channel_classification_id), 0), 2)
      comment: "Percentage of channels that are EDI-capable. A strategic KPI for digital transformation programmes; executives track this to measure order automation progress."
    - name: "pos_data_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pos_data_available_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(channel_classification_id), 0), 2)
      comment: "Percentage of channels where POS sell-out data is available. Low coverage limits demand sensing accuracy and promotional ROI measurement — a critical data quality KPI for commercial teams."
    - name: "acv_eligible_channel_count"
      expr: COUNT(CASE WHEN acv_eligible_flag = TRUE THEN channel_classification_id END)
      comment: "Number of channels eligible for ACV measurement. Determines the scope of distribution and velocity reporting; gaps indicate blind spots in market coverage tracking."
    - name: "tdp_eligible_channel_count"
      expr: COUNT(CASE WHEN tdp_eligible_flag = TRUE THEN channel_classification_id END)
      comment: "Number of channels eligible for TDP (Total Distribution Points) measurement. TDP is a core KPI for distribution coverage; this count defines the measurable universe."
    - name: "planogram_required_channel_count"
      expr: COUNT(CASE WHEN planogram_required_flag = TRUE THEN channel_classification_id END)
      comment: "Number of channels requiring a planogram. Drives field execution workload and category management resource planning; high counts signal significant in-store execution investment."
    - name: "avg_otif_target_pct"
      expr: ROUND(AVG(CAST(otif_target_percentage AS DOUBLE)), 2)
      comment: "Average OTIF (On-Time In-Full) target percentage across channel classifications. Reflects the aggregate service-level commitment to the channel portfolio; used in supply chain SLA negotiations and logistics performance reviews."
    - name: "max_otif_target_pct"
      expr: ROUND(MAX(CAST(otif_target_percentage AS DOUBLE)), 2)
      comment: "Highest OTIF target percentage across all channel classifications. Identifies the most demanding channel from a service-level perspective, informing logistics prioritisation."
    - name: "min_otif_target_pct"
      expr: ROUND(MIN(CAST(otif_target_percentage AS DOUBLE)), 2)
      comment: "Lowest OTIF target percentage across all channel classifications. Identifies channels with the most relaxed service-level requirements, useful for logistics cost optimisation."
    - name: "avg_minimum_order_quantity"
      expr: ROUND(AVG(CAST(minimum_order_quantity AS DOUBLE)), 2)
      comment: "Average minimum order quantity (MOQ) across channel classifications. A key input for supply chain planning and logistics cost-per-case modelling; high MOQs indicate bulk-buying channels."
    - name: "max_minimum_order_quantity"
      expr: ROUND(MAX(CAST(minimum_order_quantity AS DOUBLE)), 2)
      comment: "Maximum MOQ across all channel classifications. Identifies the channel with the largest minimum order commitment, relevant for inventory and working capital planning."
    - name: "distinct_market_segments_covered"
      expr: COUNT(DISTINCT market_segment)
      comment: "Number of distinct market segments covered by the channel portfolio. A breadth-of-reach KPI; declining count signals portfolio concentration risk or market exit."
    - name: "distinct_distribution_models_used"
      expr: COUNT(DISTINCT distribution_model)
      comment: "Number of distinct distribution models in use across channels. Tracks route-to-market diversity; a single dominant model signals dependency risk and cost-to-serve concentration."
    - name: "distinct_pricing_strategies_deployed"
      expr: COUNT(DISTINCT pricing_strategy)
      comment: "Number of distinct pricing strategies deployed across the channel portfolio. Reflects pricing complexity; too many strategies increase revenue management overhead."
    - name: "channel_with_pos_and_promo_eligible_count"
      expr: COUNT(CASE WHEN pos_data_available_flag = TRUE AND trade_promotion_eligible_flag = TRUE THEN channel_classification_id END)
      comment: "Number of channels that are both trade-promotion eligible AND have POS data available. This intersection defines the universe where promotional ROI can be accurately measured — a critical KPI for trade marketing investment governance."
    - name: "high_service_channel_count"
      expr: COUNT(CASE WHEN otif_target_percentage >= 95 THEN channel_classification_id END)
      comment: "Number of channels with an OTIF target of 95% or above. Identifies the premium service tier of the channel portfolio requiring the highest supply chain reliability investment."
    - name: "sub_channel_count"
      expr: COUNT(CASE WHEN parent_channel_classification_id IS NOT NULL THEN channel_classification_id END)
      comment: "Number of channel classifications that are sub-channels (i.e. have a parent). Measures hierarchy depth and complexity of the channel taxonomy; high counts may indicate over-segmentation."
    - name: "top_level_channel_count"
      expr: COUNT(CASE WHEN parent_channel_classification_id IS NULL THEN channel_classification_id END)
      comment: "Number of top-level (root) channel classifications with no parent. Defines the primary channel architecture breadth used in executive-level channel strategy reviews."
$$;
