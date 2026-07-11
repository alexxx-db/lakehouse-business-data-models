-- Metric views for domain: customer | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`customer_channel_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the channel classification hierarchy. Enables executives to evaluate channel portfolio performance, trade promotion eligibility, OTIF targets, and ordering economics across the channel taxonomy. Supports channel strategy, trade investment prioritization, and distribution model decisions."
  source: "`vibe_consumer_goods_v1`.`customer`.`channel_classification`"
  dimensions:
    - name: "channel_name"
      expr: channel_name
      comment: "The business name of the channel (e.g., Modern Trade, E-Commerce, Foodservice). Primary grouping dimension for channel performance analysis."
    - name: "channel_code"
      expr: channel_code
      comment: "Short alphanumeric code identifying the channel. Used for cross-system reconciliation and reporting filters."
    - name: "channel_format"
      expr: channel_format
      comment: "Physical or digital format of the channel (e.g., Hypermarket, Convenience, Online). Enables format-level benchmarking."
    - name: "distribution_model"
      expr: distribution_model
      comment: "The distribution model associated with the channel (e.g., Direct, Indirect, DSD). Drives supply chain and logistics planning decisions."
    - name: "primary_tier"
      expr: primary_tier
      comment: "Primary strategic tier of the channel (e.g., Tier 1, Tier 2). Used to prioritize trade investment and resource allocation."
    - name: "secondary_tier"
      expr: secondary_tier
      comment: "Secondary tier classification providing finer segmentation within the primary tier for nuanced channel strategy."
    - name: "tertiary_tier"
      expr: tertiary_tier
      comment: "Tertiary tier classification for the most granular channel segmentation, supporting detailed operational planning."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment served by the channel (e.g., Mass, Premium, Value). Aligns channel strategy with brand and portfolio positioning."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the channel (e.g., EDLP, Hi-Lo). Critical for revenue management and promotional planning."
    - name: "active_status"
      expr: active_status
      comment: "Operational status of the channel classification (Active/Inactive). Filters out deprecated channels from live reporting."
    - name: "applicable_region"
      expr: applicable_region
      comment: "Geographic region where this channel classification applies. Enables regional channel strategy analysis."
    - name: "order_frequency"
      expr: order_frequency
      comment: "Expected ordering frequency for the channel (e.g., Weekly, Bi-weekly). Informs supply planning and replenishment cycles."
    - name: "payment_terms_standard"
      expr: payment_terms_standard
      comment: "Standard payment terms for the channel (e.g., Net 30, Net 60). Relevant for cash flow and working capital management."
    - name: "return_policy"
      expr: return_policy
      comment: "Return policy applicable to the channel. Informs reverse logistics planning and financial provisioning for returns."
    - name: "acv_eligible_flag"
      expr: CASE WHEN acv_eligible_flag = TRUE THEN 'ACV Eligible' ELSE 'Not ACV Eligible' END
      comment: "Indicates whether the channel is eligible for All Commodity Volume (ACV) measurement. Used in distribution and velocity reporting."
    - name: "trade_promotion_eligible_flag"
      expr: CASE WHEN trade_promotion_eligible_flag = TRUE THEN 'Trade Promo Eligible' ELSE 'Not Eligible' END
      comment: "Indicates whether the channel qualifies for trade promotion investment. Drives trade spend allocation decisions."
    - name: "tdp_eligible_flag"
      expr: CASE WHEN tdp_eligible_flag = TRUE THEN 'TDP Eligible' ELSE 'Not TDP Eligible' END
      comment: "Indicates whether the channel is eligible for Total Distribution Points (TDP) measurement. Key metric for distribution performance tracking."
    - name: "edi_capable_flag"
      expr: CASE WHEN edi_capable_flag = TRUE THEN 'EDI Capable' ELSE 'Non-EDI' END
      comment: "Indicates whether the channel supports Electronic Data Interchange. Relevant for order automation and operational efficiency planning."
    - name: "planogram_required_flag"
      expr: CASE WHEN planogram_required_flag = TRUE THEN 'Planogram Required' ELSE 'No Planogram' END
      comment: "Indicates whether a planogram is required for this channel. Drives category management and field execution planning."
    - name: "pos_data_available_flag"
      expr: CASE WHEN pos_data_available_flag = TRUE THEN 'POS Data Available' ELSE 'No POS Data' END
      comment: "Indicates whether point-of-sale data is available for this channel. Critical for sell-through analytics and demand sensing."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month in which the channel classification became effective. Used for cohort and lifecycle analysis of channel portfolio evolution."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month in which the channel classification expires or was retired. Used to track channel lifecycle and portfolio churn."
  measures:
    - name: "total_active_channels"
      expr: COUNT(DISTINCT CASE WHEN active_status = 'Active' THEN channel_classification_id END)
      comment: "Count of distinct active channel classifications. Measures the breadth of the active channel portfolio. Executives use this to assess channel coverage and identify portfolio gaps or over-fragmentation."
    - name: "total_channels"
      expr: COUNT(DISTINCT channel_classification_id)
      comment: "Total count of all channel classifications regardless of status. Provides the full universe of channel definitions for portfolio completeness assessment."
    - name: "avg_otif_target_percentage"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average On-Time In-Full (OTIF) target percentage across channel classifications. A key supply chain service level KPI — lower averages signal channels with relaxed service expectations or operational challenges."
    - name: "max_otif_target_percentage"
      expr: MAX(CAST(otif_target_percentage AS DOUBLE))
      comment: "Maximum OTIF target percentage across channels. Identifies the most demanding channel from a service level commitment perspective, informing logistics prioritization."
    - name: "min_otif_target_percentage"
      expr: MIN(CAST(otif_target_percentage AS DOUBLE))
      comment: "Minimum OTIF target percentage across channels. Identifies channels with the lowest service level commitments, which may indicate lower strategic priority or operational constraints."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity (MOQ) across channel classifications. Informs supply chain and logistics planning — higher MOQs indicate channels requiring bulk replenishment strategies."
    - name: "max_minimum_order_quantity"
      expr: MAX(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Maximum minimum order quantity across all channels. Identifies the channel with the highest volume commitment requirement, relevant for production planning and inventory positioning."
    - name: "trade_promotion_eligible_channel_count"
      expr: COUNT(DISTINCT CASE WHEN trade_promotion_eligible_flag = TRUE THEN channel_classification_id END)
      comment: "Count of channel classifications eligible for trade promotion investment. Directly informs trade spend budget allocation and promotional planning scope."
    - name: "trade_promotion_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trade_promotion_eligible_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(DISTINCT channel_classification_id), 0), 2)
      comment: "Percentage of channel classifications eligible for trade promotion. Measures the proportion of the channel portfolio addressable by trade investment — a strategic indicator of trade spend reach."
    - name: "acv_eligible_channel_count"
      expr: COUNT(DISTINCT CASE WHEN acv_eligible_flag = TRUE THEN channel_classification_id END)
      comment: "Count of channel classifications eligible for ACV measurement. ACV eligibility is a prerequisite for distribution velocity reporting — this measure tracks the measurable channel footprint."
    - name: "acv_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN acv_eligible_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(DISTINCT channel_classification_id), 0), 2)
      comment: "Percentage of channels eligible for ACV measurement. Indicates what share of the channel portfolio can be tracked for distribution performance — gaps here represent blind spots in sell-through analytics."
    - name: "pos_data_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pos_data_available_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(DISTINCT channel_classification_id), 0), 2)
      comment: "Percentage of channels with POS data availability. Measures the organization's sell-through data coverage — low rates indicate demand sensing blind spots that impair forecasting accuracy."
    - name: "edi_capable_channel_count"
      expr: COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN channel_classification_id END)
      comment: "Count of EDI-capable channel classifications. EDI capability drives order automation and reduces manual processing costs — this measure tracks the digitally integrated channel footprint."
    - name: "edi_capable_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(DISTINCT channel_classification_id), 0), 2)
      comment: "Percentage of channels with EDI capability. A digital maturity KPI for the channel portfolio — low rates indicate high manual order processing burden and operational inefficiency risk."
    - name: "tdp_eligible_channel_count"
      expr: COUNT(DISTINCT CASE WHEN tdp_eligible_flag = TRUE THEN channel_classification_id END)
      comment: "Count of channel classifications eligible for Total Distribution Points (TDP) measurement. TDP is a core distribution KPI — this measure defines the scope of distribution performance tracking."
    - name: "planogram_required_channel_count"
      expr: COUNT(DISTINCT CASE WHEN planogram_required_flag = TRUE THEN channel_classification_id END)
      comment: "Count of channels requiring planogram compliance. Drives category management resource allocation and field execution planning — higher counts indicate greater shelf management complexity."
    - name: "planogram_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN planogram_required_flag = TRUE THEN channel_classification_id END) / NULLIF(COUNT(DISTINCT channel_classification_id), 0), 2)
      comment: "Percentage of channels requiring planogram compliance. Indicates the proportion of the channel portfolio demanding active shelf management — a proxy for category management investment requirements."
    - name: "active_channel_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN active_status = 'Active' THEN channel_classification_id END) / NULLIF(COUNT(DISTINCT channel_classification_id), 0), 2)
      comment: "Percentage of channel classifications that are currently active. Measures channel portfolio health — a declining rate signals channel consolidation or rationalization activity."
$$;