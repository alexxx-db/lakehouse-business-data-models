-- Metric views for domain: marketing | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over marketing campaigns. Tracks spend efficiency, budget utilisation, ROI, and reach performance to steer campaign investment decisions."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g. brand, performance, trade) used to compare effectiveness across campaign categories."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (e.g. active, completed, paused) for operational filtering."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary media channel for the campaign (e.g. digital, TV, OOH) enabling channel-mix analysis."
    - name: "objective"
      expr: objective
      comment: "Stated marketing objective of the campaign (e.g. awareness, conversion, retention) for outcome-based grouping."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the campaign for regional performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which campaign financials are denominated."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the campaign was planned to start, used for time-series trending of campaign launches."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the campaign actually started, used to measure planning accuracy over time."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the campaign is currently active."
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend across campaigns. Core financial KPI for budget accountability and CMO reporting."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget AS DOUBLE))
      comment: "Total approved campaign budget. Used as the denominator for budget utilisation rate."
    - name: "budget_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(total_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of approved campaign budget that has been spent. Signals over/under-spend risk and pacing health."
    - name: "total_planned_media_spend"
      expr: SUM(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Total planned media spend across campaigns. Baseline for media spend variance analysis."
    - name: "total_actual_media_spend"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Total actual media spend incurred. Compared against planned to assess media execution fidelity."
    - name: "media_spend_variance"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE) - CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Absolute variance between actual and planned media spend. Negative = under-spend; positive = over-spend. Drives corrective action."
    - name: "avg_campaign_roi_pct"
      expr: ROUND(AVG(CAST(roi_pct AS DOUBLE)), 2)
      comment: "Average return on investment percentage across campaigns. Primary efficiency KPI for marketing investment decisions."
    - name: "total_target_reach"
      expr: SUM(CAST(target_reach AS DOUBLE))
      comment: "Total planned audience reach across campaigns. Measures scale of marketing exposure planned."
    - name: "total_actual_production_cost"
      expr: SUM(CAST(actual_production_cost_amount AS DOUBLE))
      comment: "Total actual production cost across campaigns. Tracks non-media spend for full cost-of-campaign visibility."
    - name: "production_cost_as_pct_of_spend"
      expr: ROUND(100.0 * SUM(CAST(actual_production_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend AS DOUBLE)), 0), 2)
      comment: "Production cost as a percentage of total actual spend. High ratios indicate inefficient working-media allocation."
    - name: "campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns. Used to normalise spend and reach KPIs and track portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution-level KPI layer over campaign flights (individual media placements). Tracks delivery efficiency, audience metrics, and cost-per-outcome to optimise in-flight media performance."
  source: "`vibe_consumer_goods_v1`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Media channel of the flight (e.g. digital, TV, radio) for channel-level performance benchmarking."
    - name: "platform"
      expr: platform
      comment: "Specific platform within the channel (e.g. YouTube, Meta, TikTok) for granular media optimisation."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of ad placement (e.g. pre-roll, display, sponsored) for creative format performance analysis."
    - name: "campaign_flight_status"
      expr: campaign_flight_status
      comment: "Current status of the flight (e.g. live, completed, paused) for operational monitoring."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied to the flight (e.g. last-click, data-driven) for consistent ROI comparison."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market of the flight for regional media performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which flight financials are denominated."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the flight started, used for time-series trending of media delivery."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of performance measurement, used for periodic reporting alignment."
  measures:
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total media budget spent across flights. Core financial accountability metric for media buyers."
    - name: "total_impressions_delivered"
      expr: SUM(CAST(actual_impressions AS BIGINT))
      comment: "Total impressions delivered across flights. Primary reach metric for awareness campaigns."
    - name: "impression_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions AS DOUBLE)) / NULLIF(SUM(CAST(planned_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of planned impressions actually delivered. Measures media execution fidelity; below 90% triggers vendor escalation."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS BIGINT))
      comment: "Total clicks generated across flights. Engagement signal for performance-oriented campaigns."
    - name: "avg_click_through_rate_pct"
      expr: ROUND(AVG(CAST(ctr AS DOUBLE)), 4)
      comment: "Average click-through rate across flights. Benchmark for creative and audience relevance."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS BIGINT))
      comment: "Total conversions attributed to flights. Direct outcome metric linking media spend to business results."
    - name: "avg_conversion_rate_pct"
      expr: ROUND(AVG(CAST(conversion_rate AS DOUBLE)), 4)
      comment: "Average conversion rate across flights. Key efficiency metric for performance media investment decisions."
    - name: "avg_cost_per_acquisition"
      expr: ROUND(AVG(CAST(cpa AS DOUBLE)), 2)
      comment: "Average cost per acquisition across flights. Critical efficiency KPI — rising CPA triggers budget reallocation."
    - name: "avg_roas"
      expr: ROUND(AVG(CAST(roas AS DOUBLE)), 2)
      comment: "Average return on ad spend across flights. Primary media ROI metric used in steering meetings and agency reviews."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS BIGINT))
      comment: "Total video views delivered. Measures video content reach for brand awareness campaigns."
    - name: "avg_video_completion_rate_pct"
      expr: ROUND(AVG(CAST(video_completion_rate AS DOUBLE)), 4)
      comment: "Average video completion rate across flights. Measures creative quality and audience engagement for video formats."
    - name: "avg_grp"
      expr: ROUND(AVG(CAST(grp AS DOUBLE)), 2)
      comment: "Average Gross Rating Points across flights. Standard broadcast media weight metric used in media planning reviews."
    - name: "flight_count"
      expr: COUNT(DISTINCT campaign_flight_id)
      comment: "Number of distinct campaign flights. Used to normalise per-flight KPIs and assess portfolio complexity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI layer over media spend transactions. Tracks working vs non-working spend, cost efficiency, and delivery variance to govern media investment quality."
  source: "`vibe_consumer_goods_v1`.`marketing`.`media_spend`"
  dimensions:
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel of the spend record (e.g. digital, TV, print) for channel-level budget governance."
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Sub-channel within the media channel for granular spend analysis."
    - name: "media_vehicle"
      expr: media_vehicle
      comment: "Specific media vehicle (publisher/property) for vendor-level spend accountability."
    - name: "buy_type"
      expr: buy_type
      comment: "Buying method (e.g. programmatic, direct, guaranteed) for procurement efficiency analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Ad placement type for format-level spend analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the media spend was incurred for geographic budget governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend transaction."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the spend record (e.g. paid, pending, disputed) for cash-flow and liability tracking."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the spend record for financial close governance."
    - name: "spend_month"
      expr: DATE_TRUNC('MONTH', spend_date)
      comment: "Month of media spend for time-series financial trending."
  measures:
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total media spend incurred. Primary financial KPI for marketing cost governance and CMO reporting."
    - name: "total_working_spend"
      expr: SUM(CAST(working_spend_amount AS DOUBLE))
      comment: "Total working media spend (spend that directly reaches consumers). Higher working spend ratio indicates better media efficiency."
    - name: "total_non_working_spend"
      expr: SUM(CAST(non_working_spend_amount AS DOUBLE))
      comment: "Total non-working spend (production, agency fees, overhead). Tracked to optimise the working-to-non-working ratio."
    - name: "working_spend_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(working_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total spend that is working media. Industry benchmark is 70-80%; below threshold triggers agency contract review."
    - name: "total_invoiced_spend"
      expr: SUM(CAST(invoiced_spend_amount AS DOUBLE))
      comment: "Total invoiced spend amount. Used for accounts-payable reconciliation and financial close accuracy."
    - name: "spend_vs_plan_variance"
      expr: SUM(CAST(variance_to_plan_amount AS DOUBLE))
      comment: "Total variance between actual and planned spend. Positive = over-spend; negative = under-spend. Triggers budget reallocation decisions."
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS BIGINT))
      comment: "Total impressions delivered as reported by media vendors. Used to validate delivery against contracted volumes."
    - name: "avg_cpm_actual"
      expr: ROUND(AVG(CAST(cpm_actual AS DOUBLE)), 2)
      comment: "Average actual cost per thousand impressions. Benchmark for media buying efficiency; rising CPM signals market inflation or poor negotiation."
    - name: "avg_cpc_actual"
      expr: ROUND(AVG(CAST(cpc_actual AS DOUBLE)), 2)
      comment: "Average actual cost per click. Key performance efficiency metric for digital media investment decisions."
    - name: "total_agency_fees"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees incurred. Tracked separately to govern agency cost as a percentage of total spend."
    - name: "agency_fee_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(agency_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Agency fees as a percentage of total media spend. Governs agency cost efficiency; used in contract renegotiation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial governance KPI layer over marketing budgets. Tracks allocation, commitment, and remaining budget to ensure fiscal discipline and prevent over-spend."
  source: "`vibe_consumer_goods_v1`.`marketing`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "period"
      expr: period
      comment: "Budget period (e.g. Q1, H1, monthly) for periodic financial review."
    - name: "marketing_budget_status"
      expr: marketing_budget_status
      comment: "Approval and lifecycle status of the budget (e.g. approved, draft, closed) for governance filtering."
    - name: "category"
      expr: category
      comment: "Budget category (e.g. media, production, events) for spend-type analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency financial consolidation."
    - name: "marketing_budget_name"
      expr: marketing_budget_name
      comment: "Name of the marketing budget for human-readable reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the budget became effective for time-series budget tracking."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all marketing budget lines. Primary financial planning KPI."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total amount spent against the marketing budget. Core actuals metric for budget accountability."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) budget. Critical for cash-flow forecasting and preventing over-commitment."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining unspent and uncommitted budget. Drives reallocation decisions at period-end reviews."
    - name: "budget_consumption_pct"
      expr: ROUND(100.0 * SUM(CAST(spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget consumed. Primary budget health KPI — deviations from plan trigger CFO/CMO intervention."
    - name: "commitment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget committed but not yet spent. High commitment rate late in period signals execution risk."
    - name: "budget_line_count"
      expr: COUNT(DISTINCT budget_id)
      comment: "Number of distinct budget lines. Used to assess budget fragmentation and governance complexity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand health and equity KPI layer over marketing brands. Tracks brand equity, market share, share of voice, and consumer funnel metrics to steer brand investment strategy."
  source: "`vibe_consumer_goods_v1`.`marketing`.`marketing_brand`"
  dimensions:
    - name: "brand_tier"
      expr: brand_tier
      comment: "Strategic tier of the brand (e.g. hero, core, tail) for portfolio prioritisation."
    - name: "brand_category"
      expr: brand_category
      comment: "Product category the brand competes in for category-level brand performance analysis."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the brand (e.g. launch, growth, mature, decline) for investment strategy alignment."
    - name: "architecture_tier"
      expr: architecture_tier
      comment: "Brand architecture tier (e.g. masterbrand, sub-brand, endorsed) for portfolio governance."
    - name: "geographic_market_scope"
      expr: geographic_market_scope
      comment: "Geographic scope of the brand (e.g. global, regional, local) for market-level brand strategy."
    - name: "marketing_brand_status"
      expr: marketing_brand_status
      comment: "Operational status of the brand for active portfolio filtering."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which brand financials are denominated."
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the brand was launched for brand age and cohort analysis."
  measures:
    - name: "avg_brand_equity_score"
      expr: ROUND(AVG(CAST(equity_score AS DOUBLE)), 2)
      comment: "Average brand equity score across brands. Primary brand health KPI used in quarterly brand reviews and M&A valuation."
    - name: "avg_brand_health_index"
      expr: ROUND(AVG(CAST(health_index AS DOUBLE)), 2)
      comment: "Average brand health index. Composite metric tracking brand vitality; declining index triggers brand investment review."
    - name: "avg_market_share_pct"
      expr: ROUND(AVG(CAST(market_share_pct AS DOUBLE)), 2)
      comment: "Average market share percentage across brands. Strategic KPI for competitive positioning and investment prioritisation."
    - name: "avg_share_of_voice_pct"
      expr: ROUND(AVG(CAST(sov_percent AS DOUBLE)), 2)
      comment: "Average share of voice percentage. Measures media presence relative to category; SOV vs SOM gap drives media investment decisions."
    - name: "sov_vs_som_gap"
      expr: ROUND(AVG(CAST(sov_percent AS DOUBLE)) - AVG(CAST(som_percent AS DOUBLE)), 2)
      comment: "Gap between share of voice and share of market. Positive gap indicates over-investment; negative gap signals under-investment relative to market position."
    - name: "avg_awareness_pct"
      expr: ROUND(AVG(CAST(awareness_percent AS DOUBLE)), 2)
      comment: "Average brand awareness percentage. Top-of-funnel brand health metric; low awareness triggers awareness-building campaign investment."
    - name: "avg_consideration_pct"
      expr: ROUND(AVG(CAST(consideration_percent AS DOUBLE)), 2)
      comment: "Average brand consideration percentage. Mid-funnel metric; awareness-to-consideration gap identifies conversion barriers."
    - name: "avg_preference_pct"
      expr: ROUND(AVG(CAST(preference_percent AS DOUBLE)), 2)
      comment: "Average brand preference percentage. Lower-funnel metric linking brand health to purchase intent and revenue."
    - name: "avg_nps_score"
      expr: ROUND(AVG(CAST(nps_score AS DOUBLE)), 2)
      comment: "Average Net Promoter Score across brands. Customer loyalty metric directly linked to organic growth and retention."
    - name: "total_annual_marketing_budget"
      expr: SUM(CAST(annual_marketing_budget AS DOUBLE))
      comment: "Total annual marketing budget allocated across brands. Used to assess brand investment levels relative to equity and market share."
    - name: "total_brand_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total brand portfolio valuation. Strategic financial metric used in M&A, investor reporting, and portfolio prioritisation."
    - name: "brand_count"
      expr: COUNT(DISTINCT marketing_brand_id)
      comment: "Number of distinct marketing brands in the portfolio. Used to assess portfolio complexity and resource allocation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media planning KPI layer over media plans. Tracks planned reach, GRP delivery, CPM efficiency, and budget allocation to govern media strategy before and during execution."
  source: "`vibe_consumer_goods_v1`.`marketing`.`media_plan`"
  dimensions:
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel of the plan (e.g. TV, digital, OOH) for channel-mix planning analysis."
    - name: "media_type"
      expr: media_type
      comment: "Type of media (e.g. paid, earned, owned) for investment mix governance."
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Sub-channel within the media channel for granular planning analysis."
    - name: "media_plan_status"
      expr: media_plan_status
      comment: "Approval and execution status of the media plan for governance filtering."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of media plan (e.g. annual, campaign, tactical) for planning horizon analysis."
    - name: "objective"
      expr: objective
      comment: "Media plan objective (e.g. reach, frequency, conversion) for outcome-based planning review."
    - name: "market"
      expr: market
      comment: "Market the media plan targets for geographic investment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the media plan financials."
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the media plan starts for time-series planning analysis."
  measures:
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned media spend across plans. Primary financial planning KPI for media budget governance."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS BIGINT))
      comment: "Total planned impressions across media plans. Measures planned audience reach scale."
    - name: "total_planned_reach"
      expr: SUM(CAST(planned_reach AS BIGINT))
      comment: "Total planned unique reach across media plans. Key audience planning metric for awareness campaigns."
    - name: "avg_planned_cpm"
      expr: ROUND(AVG(CAST(planned_cpm AS DOUBLE)), 2)
      comment: "Average planned cost per thousand impressions. Benchmark for media buying efficiency at planning stage."
    - name: "avg_planned_grp"
      expr: ROUND(AVG(CAST(planned_grp AS DOUBLE)), 2)
      comment: "Average planned Gross Rating Points. Standard broadcast media weight metric used in media planning approvals."
    - name: "avg_planned_frequency"
      expr: ROUND(AVG(CAST(planned_frequency AS DOUBLE)), 2)
      comment: "Average planned ad frequency. Governs message repetition strategy; too high risks wear-out, too low risks under-exposure."
    - name: "avg_budget_allocation_pct"
      expr: ROUND(AVG(CAST(budget_allocation_percent AS DOUBLE)), 2)
      comment: "Average budget allocation percentage across media plan lines. Used to assess channel investment balance."
    - name: "media_plan_count"
      expr: COUNT(DISTINCT media_plan_id)
      comment: "Number of distinct media plans. Used to assess planning portfolio complexity and resource requirements."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`marketing_consumer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer segment KPI layer tracking segment size, value, engagement, and loyalty metrics to prioritise audience investment and personalisation strategy."
  source: "`vibe_consumer_goods_v1`.`marketing`.`consumer_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of consumer segment (e.g. demographic, behavioural, psychographic) for segmentation methodology analysis."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier of the segment (e.g. tier 1, tier 2) for investment prioritisation."
    - name: "income_bracket"
      expr: income_bracket
      comment: "Income bracket of the segment for value-based targeting analysis."
    - name: "digital_engagement_level"
      expr: digital_engagement_level
      comment: "Digital engagement level of the segment for channel strategy decisions."
    - name: "price_sensitivity_level"
      expr: price_sensitivity_level
      comment: "Price sensitivity level of the segment for promotional strategy and pricing decisions."
    - name: "consumer_segment_status"
      expr: consumer_segment_status
      comment: "Operational status of the segment for active portfolio filtering."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment for regional audience strategy."
    - name: "segmentation_model_type"
      expr: segmentation_model_type
      comment: "Segmentation model used to define the segment for methodology governance."
  measures:
    - name: "total_segment_size"
      expr: SUM(CAST(segment_size AS BIGINT))
      comment: "Total consumer population across segments. Measures total addressable audience for marketing investment sizing."
    - name: "avg_segment_size"
      expr: ROUND(AVG(CAST(segment_size AS DOUBLE)), 0)
      comment: "Average size of consumer segments. Used to assess segment granularity and targeting precision."
    - name: "total_cltv_estimate"
      expr: SUM(CAST(cltv_estimate_usd AS DOUBLE))
      comment: "Total estimated customer lifetime value across segments. Primary value metric for audience investment prioritisation."
    - name: "avg_cltv_estimate"
      expr: ROUND(AVG(CAST(cltv_estimate_usd AS DOUBLE)), 2)
      comment: "Average customer lifetime value estimate per segment. Drives differential investment levels across audience tiers."
    - name: "avg_basket_size_usd"
      expr: ROUND(AVG(CAST(average_basket_size_usd AS DOUBLE)), 2)
      comment: "Average basket size in USD across segments. Links audience profile to revenue per transaction for targeting ROI."
    - name: "avg_nps_score"
      expr: ROUND(AVG(CAST(nps_score_average AS DOUBLE)), 2)
      comment: "Average NPS score across consumer segments. Loyalty metric used to prioritise retention investment by segment."
    - name: "avg_value_index"
      expr: ROUND(AVG(CAST(value_index AS DOUBLE)), 2)
      comment: "Average value index across segments. Composite metric for segment attractiveness used in audience investment decisions."
    - name: "segment_count"
      expr: COUNT(DISTINCT consumer_segment_id)
      comment: "Number of distinct consumer segments. Used to assess segmentation portfolio complexity and coverage."
$$;