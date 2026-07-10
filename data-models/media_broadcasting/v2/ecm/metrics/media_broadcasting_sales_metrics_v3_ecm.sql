-- Metric views for domain: sales | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core advertising order KPIs tracking contracted revenue, delivery targets, pricing efficiency, and order pipeline health for executive sales reporting."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the ad order (e.g., confirmed, pending, cancelled) for pipeline segmentation."
    - name: "order_type"
      expr: order_type
      comment: "Type of ad order (upfront, scatter, programmatic) for deal-type analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order for multi-currency revenue reporting."
    - name: "market_code"
      expr: market_code
      comment: "Geographic market code for regional revenue analysis."
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Daypart mix associated with the order for inventory and pricing analysis."
    - name: "product_category"
      expr: product_category
      comment: "Product category of the ad order for vertical revenue segmentation."
    - name: "political_ad_flag"
      expr: political_ad_flag
      comment: "Indicates whether the order is a political ad for compliance and revenue tracking."
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Campaign flight start date for time-series revenue analysis."
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "Campaign flight end date for duration and pacing analysis."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle of the order for cash flow and AR analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for credit risk and DSO analysis."
  measures:
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total contracted revenue across all ad orders. Primary top-line sales KPI for executive revenue reporting."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order values after discounts. Reflects actual recognized revenue potential."
    - name: "avg_contracted_cpm"
      expr: AVG(CAST(contracted_cpm AS DOUBLE))
      comment: "Average contracted CPM across orders. Key pricing efficiency metric for yield management."
    - name: "avg_contracted_cprp"
      expr: AVG(CAST(contracted_cprp AS DOUBLE))
      comment: "Average contracted cost per rating point. Measures pricing competitiveness in audience-guaranteed deals."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted on orders. Monitors pricing discipline and margin erosion."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total gross rating points contracted across all orders. Measures audience delivery commitment volume."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_trp AS DOUBLE))
      comment: "Total target TRP (target rating points) contracted. Measures targeted audience delivery commitments."
    - name: "total_commission_rate_avg"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average agency commission rate across orders. Monitors agency cost as a percentage of revenue."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of ad orders. Baseline volume metric for order pipeline and sales activity tracking."
    - name: "political_ad_order_count"
      expr: COUNT(CASE WHEN political_ad_flag = TRUE THEN 1 END)
      comment: "Count of political ad orders. Critical for FCC compliance tracking and political revenue reporting."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers with active orders. Measures client base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level advertising order KPIs measuring delivery performance, impression fulfillment, pricing, and makegood exposure at the most granular order unit."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (active, cancelled, fulfilled) for pipeline analysis."
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of inventory (linear, digital, programmatic) for yield and revenue mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line for multi-currency revenue reporting."
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Line flight start date for time-series delivery analysis."
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "Line flight end date for pacing and fulfillment tracking."
    - name: "spot_length_seconds"
      expr: spot_length_seconds
      comment: "Spot length for unit pricing and inventory mix analysis."
    - name: "position_preference"
      expr: position_preference
      comment: "Requested position preference (first, last, any) for premium inventory analysis."
    - name: "preemption_priority"
      expr: preemption_priority
      comment: "Preemption priority class for inventory risk and makegood exposure analysis."
    - name: "revenue_recognition_date"
      expr: revenue_recognition_date
      comment: "Date revenue is recognized for ASC 606 compliance and period reporting."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total gross revenue across all order lines. Primary revenue measure at line level."
    - name: "total_net_line_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts at line level. Reflects actual recognized revenue."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS BIGINT))
      comment: "Total impressions contracted across all lines. Measures audience delivery commitment volume."
    - name: "total_actual_impressions_delivered"
      expr: SUM(CAST(actual_impressions_delivered AS BIGINT))
      comment: "Total impressions actually delivered. Core delivery fulfillment KPI."
    - name: "total_contracted_grp"
      expr: SUM(CAST(contracted_grp AS DOUBLE))
      comment: "Total contracted GRP across order lines. Measures audience guarantee exposure."
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total GRP actually delivered. Measures audience delivery performance against guarantees."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average CPM across order lines. Key pricing efficiency metric for yield management."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across order lines. Monitors pricing trends and rate card adherence."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage at line level. Monitors pricing discipline and margin erosion."
    - name: "makegood_line_count"
      expr: COUNT(CASE WHEN makegood_for_line_id IS NOT NULL THEN 1 END)
      comment: "Count of makegood order lines. Measures delivery failure exposure and makegood liability."
    - name: "order_line_count"
      expr: COUNT(1)
      comment: "Total number of order lines. Baseline volume metric for order complexity and workload analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level KPIs measuring budget deployment, audience targeting efficiency, and campaign pipeline health for strategic advertising sales management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current campaign status (active, completed, cancelled) for pipeline and revenue forecasting."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (upfront, scatter, digital, sponsorship) for revenue mix analysis."
    - name: "market_type"
      expr: market_type
      comment: "Market type (national, local, regional) for geographic revenue segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Campaign currency for multi-currency revenue reporting."
    - name: "start_date"
      expr: start_date
      comment: "Campaign start date for time-series revenue and activity analysis."
    - name: "end_date"
      expr: end_date
      comment: "Campaign end date for duration and pacing analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (direct, agency, programmatic) for channel mix revenue analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Campaign priority level for inventory allocation and preemption analysis."
    - name: "makegood_eligible_flag"
      expr: makegood_eligible_flag
      comment: "Whether the campaign is eligible for makegoods, indicating audience guarantee exposure."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget committed across all campaigns. Primary top-line revenue commitment KPI."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average campaign budget size. Measures deal size trends and client investment levels."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total impressions targeted across campaigns. Measures audience delivery commitment volume."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target GRP across campaigns. Measures audience guarantee exposure at portfolio level."
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target CPM across campaigns. Key pricing benchmark for yield management."
    - name: "avg_target_frequency"
      expr: AVG(CAST(target_frequency AS DOUBLE))
      comment: "Average target frequency across campaigns. Measures audience engagement depth commitments."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for sales pipeline and workload analysis."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN campaign_status = 'active' THEN 1 END)
      comment: "Count of currently active campaigns. Measures in-flight revenue and operational workload."
    - name: "makegood_eligible_campaign_count"
      expr: COUNT(CASE WHEN makegood_eligible_flag = TRUE THEN 1 END)
      comment: "Count of campaigns with makegood eligibility. Quantifies audience guarantee liability exposure."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers with campaigns. Measures client base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline KPIs measuring win rates, proposal value, conversion efficiency, and sales cycle performance for revenue forecasting and sales effectiveness analysis."
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current proposal status (draft, submitted, accepted, rejected) for pipeline stage analysis."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (upfront, scatter, sponsorship) for deal-type mix analysis."
    - name: "market_type"
      expr: market_type
      comment: "Market type for geographic pipeline segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Proposal currency for multi-currency pipeline reporting."
    - name: "proposal_date"
      expr: proposal_date
      comment: "Date proposal was created for sales cycle and pipeline aging analysis."
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Proposed campaign flight start for demand forecasting."
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "Proposed campaign flight end for inventory planning."
    - name: "proposal_source"
      expr: proposal_source
      comment: "Source of the proposal (RFP, proactive, renewal) for lead source effectiveness analysis."
    - name: "audience_guarantee_flag"
      expr: audience_guarantee_flag
      comment: "Whether the proposal includes an audience guarantee, indicating deal complexity and risk."
  measures:
    - name: "total_proposed_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE))
      comment: "Total value of all proposals in pipeline. Primary pipeline revenue KPI for sales forecasting."
    - name: "total_net_proposed_value"
      expr: SUM(CAST(net_proposed_value AS DOUBLE))
      comment: "Total net proposed value after discounts. Reflects realistic revenue potential in pipeline."
    - name: "avg_proposed_value"
      expr: AVG(CAST(total_proposed_value AS DOUBLE))
      comment: "Average proposal value. Measures deal size trends and sales productivity."
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percent AS DOUBLE))
      comment: "Average win probability across proposals. Key input for weighted pipeline revenue forecasting."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount offered in proposals. Monitors pricing discipline and margin erosion risk."
    - name: "total_guaranteed_impressions"
      expr: SUM(CAST(guaranteed_impressions AS BIGINT))
      comment: "Total impressions guaranteed in proposals. Measures audience delivery commitment exposure in pipeline."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average CPM proposed. Benchmarks pricing competitiveness across the proposal pipeline."
    - name: "proposal_count"
      expr: COUNT(1)
      comment: "Total number of proposals. Baseline sales activity volume metric."
    - name: "accepted_proposal_count"
      expr: COUNT(CASE WHEN proposal_status = 'accepted' THEN 1 END)
      comment: "Count of accepted proposals. Numerator for win rate calculation and conversion tracking."
    - name: "audience_guarantee_proposal_count"
      expr: COUNT(CASE WHEN audience_guarantee_flag = TRUE THEN 1 END)
      comment: "Count of proposals with audience guarantees. Measures guarantee liability exposure in pipeline."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers in proposal pipeline. Measures client reach and pipeline diversity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront deal KPIs measuring committed spend, pricing, audience guarantees, and deal execution for annual upfront season performance management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current deal status (negotiating, executed, cancelled) for upfront pipeline tracking."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of upfront deal for revenue mix and deal structure analysis."
    - name: "deal_year"
      expr: deal_year
      comment: "Upfront deal year for year-over-year upfront revenue comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Deal currency for multi-currency upfront revenue reporting."
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Pricing basis (CPM, CPRP, flat) for deal economics analysis."
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Daypart mix for inventory allocation and pricing analysis."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Channel mix for multi-platform revenue attribution."
    - name: "makegood_provision_flag"
      expr: makegood_provision_flag
      comment: "Whether deal includes makegood provisions, indicating audience guarantee liability."
    - name: "scatter_conversion_rights"
      expr: scatter_conversion_rights
      comment: "Whether deal includes scatter conversion rights, indicating flexibility and risk."
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed spend across upfront deals. Primary upfront revenue KPI for annual planning."
    - name: "total_proposed_spend"
      expr: SUM(CAST(total_proposed_spend AS DOUBLE))
      comment: "Total proposed spend in upfront negotiations. Measures upfront pipeline before execution."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate across upfront deals. Key pricing benchmark for upfront yield management."
    - name: "avg_cprp_rate"
      expr: AVG(CAST(cprp_rate AS DOUBLE))
      comment: "Average cost per rating point across upfront deals. Measures audience pricing competitiveness."
    - name: "total_audience_guarantee_grp"
      expr: SUM(CAST(audience_guarantee_grp AS DOUBLE))
      comment: "Total GRP guaranteed across upfront deals. Measures audience delivery liability for the upfront book."
    - name: "total_audience_guarantee_impressions"
      expr: SUM(CAST(audience_guarantee_impressions AS BIGINT))
      comment: "Total impressions guaranteed in upfront deals. Quantifies audience delivery commitment volume."
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Total number of upfront deals. Baseline volume metric for upfront season activity."
    - name: "executed_deal_count"
      expr: COUNT(CASE WHEN deal_status = 'executed' THEN 1 END)
      comment: "Count of executed upfront deals. Measures upfront close rate and season execution progress."
    - name: "makegood_provision_deal_count"
      expr: COUNT(CASE WHEN makegood_provision_flag = TRUE THEN 1 END)
      comment: "Count of deals with makegood provisions. Quantifies audience guarantee liability in upfront book."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers in upfront deals. Measures upfront client concentration and diversity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront commitment fulfillment KPIs tracking spend delivery, cancellation exposure, and pacing against committed volumes for revenue assurance."
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current commitment status (active, fulfilled, cancelled) for fulfillment tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Commitment currency for multi-currency revenue reporting."
    - name: "upfront_year"
      expr: upfront_year
      comment: "Upfront year for year-over-year commitment fulfillment comparison."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Commitment effective start date for pacing and delivery analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Commitment effective end date for fulfillment deadline tracking."
    - name: "audience_guarantee_flag"
      expr: audience_guarantee_flag
      comment: "Whether commitment includes audience guarantee for liability exposure analysis."
    - name: "makegood_provision_flag"
      expr: makegood_provision_flag
      comment: "Whether commitment includes makegood provisions for risk assessment."
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed spend across all upfront commitments. Primary revenue assurance KPI."
    - name: "total_delivered_spend"
      expr: SUM(CAST(delivered_spend_to_date AS DOUBLE))
      comment: "Total spend delivered to date against commitments. Measures revenue fulfillment progress."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_commitment_balance AS DOUBLE))
      comment: "Total remaining undelivered commitment balance. Measures at-risk revenue requiring fulfillment."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(total_cancelled_amount AS DOUBLE))
      comment: "Total amount cancelled from commitments. Measures cancellation exposure and revenue risk."
    - name: "avg_fulfillment_percentage"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average fulfillment percentage across commitments. Key pacing KPI for revenue delivery management."
    - name: "total_committed_grp_volume"
      expr: SUM(CAST(committed_grp_volume AS DOUBLE))
      comment: "Total GRP volume committed. Measures audience delivery obligation at portfolio level."
    - name: "total_linear_allocation"
      expr: SUM(CAST(linear_allocation_amount AS DOUBLE))
      comment: "Total linear TV allocation across commitments. Measures linear revenue mix in upfront book."
    - name: "total_digital_allocation"
      expr: SUM(CAST(digital_allocation_amount AS DOUBLE))
      comment: "Total digital allocation across commitments. Measures digital revenue mix in upfront book."
    - name: "total_streaming_allocation"
      expr: SUM(CAST(streaming_allocation_amount AS DOUBLE))
      comment: "Total streaming allocation across commitments. Measures streaming revenue mix in upfront book."
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Total number of upfront commitments. Baseline volume metric for commitment portfolio management."
    - name: "cancellation_option_avg_pct"
      expr: AVG(CAST(cancellation_option_percentage AS DOUBLE))
      comment: "Average cancellation option percentage across commitments. Measures contractual revenue risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_scatter_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scatter order KPIs for tracking scatter market revenue, advertiser activity, and channel placement for short-term inventory monetization management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`scatter_order`"
  dimensions:
    - name: "sales_advertiser_id"
      expr: sales_advertiser_id
      comment: "Advertiser associated with the scatter order for advertiser-level scatter revenue analysis."
    - name: "scheduling_channel_id"
      expr: scheduling_channel_id
      comment: "Channel targeted by the scatter order for channel-level scatter inventory analysis."
  measures:
    - name: "scatter_order_count"
      expr: COUNT(1)
      comment: "Total number of scatter orders. Baseline volume metric for scatter market activity and demand tracking."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT sales_advertiser_id)
      comment: "Number of unique advertisers placing scatter orders. Measures scatter market breadth and client diversity."
    - name: "distinct_channel_count"
      expr: COUNT(DISTINCT scheduling_channel_id)
      comment: "Number of distinct channels targeted by scatter orders. Measures scatter inventory distribution across network."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales opportunity pipeline KPIs measuring deal value, conversion rates, and pipeline health for revenue forecasting and sales performance management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Opportunity pipeline stage for funnel analysis and conversion tracking."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal (upfront, scatter, carriage, syndication) for revenue mix analysis."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (commit, best case, pipeline) for revenue forecasting accuracy."
    - name: "currency_code"
      expr: currency_code
      comment: "Opportunity currency for multi-currency pipeline reporting."
    - name: "close_date"
      expr: close_date
      comment: "Expected close date for pipeline aging and forecast period analysis."
    - name: "product_category"
      expr: product_category
      comment: "Product category for vertical revenue pipeline segmentation."
    - name: "is_upfront"
      expr: is_upfront
      comment: "Whether opportunity is an upfront deal for upfront vs. scatter pipeline split."
    - name: "requires_makegood"
      expr: requires_makegood
      comment: "Whether opportunity requires makegood provisions for deal complexity analysis."
    - name: "daypart"
      expr: daypart
      comment: "Target daypart for inventory demand and pricing analysis."
  measures:
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities in pipeline. Primary pipeline revenue KPI for forecasting."
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average opportunity value. Measures deal size trends and sales productivity."
    - name: "avg_win_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across opportunities. Key input for weighted pipeline revenue forecasting."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate in pipeline opportunities. Benchmarks pricing competitiveness across pipeline."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total impressions targeted in pipeline opportunities. Measures audience demand in pipeline."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities. Baseline pipeline volume metric for sales activity tracking."
    - name: "upfront_opportunity_count"
      expr: COUNT(CASE WHEN is_upfront = TRUE THEN 1 END)
      comment: "Count of upfront opportunities. Measures upfront season pipeline volume."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT sales_account_id)
      comment: "Number of unique accounts with active opportunities. Measures pipeline breadth and account coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast KPIs measuring revenue projections, quota attainment, pipeline accuracy, and variance for executive revenue planning and sales performance management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current forecast status (draft, submitted, approved) for forecast governance tracking."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (commit, best case, pipeline) for revenue confidence segmentation."
    - name: "period_type"
      expr: period_type
      comment: "Period type (monthly, quarterly, annual) for time-horizon analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly revenue planning and QBR reporting."
    - name: "broadcast_year"
      expr: broadcast_year
      comment: "Broadcast year for annual upfront and scatter revenue planning."
    - name: "deal_type"
      expr: deal_type
      comment: "Deal type for revenue mix forecasting (upfront, scatter, carriage, syndication)."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Forecast period start date for time-series revenue analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "Forecast period end date for revenue period attribution."
    - name: "account_segment"
      expr: account_segment
      comment: "Account segment for revenue forecasting by client tier."
  measures:
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue across all forecast records. Primary revenue planning KPI."
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota amount across forecasts. Baseline for quota attainment and performance measurement."
    - name: "total_closed_revenue"
      expr: SUM(CAST(closed_revenue AS DOUBLE))
      comment: "Total closed/booked revenue. Measures actual revenue realized against forecast."
    - name: "total_commit_revenue"
      expr: SUM(CAST(commit_revenue AS DOUBLE))
      comment: "Total committed revenue in forecast. High-confidence revenue measure for planning."
    - name: "total_pipeline_revenue"
      expr: SUM(CAST(pipeline_revenue AS DOUBLE))
      comment: "Total pipeline revenue in forecast. Measures total revenue opportunity in funnel."
    - name: "total_upfront_revenue"
      expr: SUM(CAST(upfront_revenue AS DOUBLE))
      comment: "Total upfront revenue in forecast. Measures upfront season revenue contribution."
    - name: "total_scatter_revenue"
      expr: SUM(CAST(scatter_revenue AS DOUBLE))
      comment: "Total scatter revenue in forecast. Measures scatter market revenue contribution."
    - name: "total_carriage_revenue"
      expr: SUM(CAST(carriage_revenue AS DOUBLE))
      comment: "Total carriage fee revenue in forecast. Measures distribution revenue contribution."
    - name: "total_syndication_revenue"
      expr: SUM(CAST(syndication_revenue AS DOUBLE))
      comment: "Total syndication revenue in forecast. Measures content licensing revenue contribution."
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average quota attainment percentage. Key sales performance KPI for rep and team evaluation."
    - name: "total_variance_to_quota"
      expr: SUM(CAST(variance_to_quota AS DOUBLE))
      comment: "Total variance between forecast and quota. Measures gap to revenue targets for corrective action."
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Total number of forecast records. Baseline volume metric for forecast submission tracking."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_affidavit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Affidavit KPIs measuring spot delivery verification, discrepancy rates, billing accuracy, and compliance for post-air reconciliation and revenue assurance."
  source: "`vibe_media_broadcasting_v1`.`sales`.`affidavit`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the affidavit for billing accuracy and dispute tracking."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy (preemption, wrong length, wrong time) for root cause analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify spot delivery for quality and compliance analysis."
    - name: "actual_air_date"
      expr: actual_air_date
      comment: "Actual air date for time-series delivery and discrepancy analysis."
    - name: "scheduled_air_date"
      expr: scheduled_air_date
      comment: "Scheduled air date for on-time delivery performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the aired spot for inventory and pricing analysis."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a discrepancy was identified for delivery quality monitoring."
    - name: "makegood_required_flag"
      expr: makegood_required_flag
      comment: "Whether a makegood is required for liability and remediation tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the spot was compliant for regulatory and contractual compliance monitoring."
  measures:
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total billing amount across affidavits. Primary revenue assurance KPI for post-air billing."
    - name: "avg_billing_amount"
      expr: AVG(CAST(billing_amount AS DOUBLE))
      comment: "Average billing amount per affidavit. Monitors unit revenue trends and billing consistency."
    - name: "affidavit_count"
      expr: COUNT(1)
      comment: "Total number of affidavits. Baseline volume metric for post-air delivery verification workload."
    - name: "discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of affidavits with discrepancies. Measures delivery quality and billing dispute risk."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN makegood_required_flag = TRUE THEN 1 END)
      comment: "Count of affidavits requiring makegoods. Quantifies makegood liability from delivery failures."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Count of non-compliant affidavits. Measures regulatory and contractual compliance risk."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers with affidavits. Measures post-air billing breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_impression_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital impression delivery KPIs measuring viewability, completion rates, CPM realization, and delivery quality for digital advertising performance management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`impression_delivery`"
  dimensions:
    - name: "insertion_status"
      expr: insertion_status
      comment: "Insertion status of the impression for delivery quality analysis."
    - name: "insertion_type"
      expr: insertion_type
      comment: "Type of insertion (DAI, server-side, client-side) for technology mix analysis."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type (CTV, mobile, desktop) for cross-platform delivery analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type for device-level delivery and viewability analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of delivery for time-of-day performance analysis."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of impression delivery for time-series performance analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status for delivery quality and fraud detection."
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating of the surrounding content for brand safety analysis."
    - name: "geo_target_code"
      expr: geo_target_code
      comment: "Geographic target code for regional delivery performance analysis."
  measures:
    - name: "total_impressions_served"
      expr: SUM(CAST(total_impressions_served AS BIGINT))
      comment: "Total impressions served. Primary digital delivery volume KPI for campaign fulfillment tracking."
    - name: "total_viewable_impressions"
      expr: SUM(CAST(viewable_impressions AS BIGINT))
      comment: "Total viewable impressions. Measures quality-adjusted delivery for advertiser value reporting."
    - name: "total_completed_views"
      expr: SUM(CAST(completed_views AS BIGINT))
      comment: "Total completed video views. Measures full-engagement delivery for video campaign performance."
    - name: "total_click_throughs"
      expr: SUM(CAST(click_throughs AS BIGINT))
      comment: "Total click-throughs. Measures direct response engagement from digital ad delivery."
    - name: "total_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue from impression delivery. Primary digital revenue KPI for yield management."
    - name: "avg_cpm_realized"
      expr: AVG(CAST(cpm_realized AS DOUBLE))
      comment: "Average realized CPM. Measures actual yield vs. contracted CPM for pricing performance."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate_percent AS DOUBLE))
      comment: "Average viewability rate. Key quality metric for advertiser satisfaction and premium pricing justification."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average video completion rate. Measures ad engagement quality for campaign effectiveness reporting."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate_percent AS DOUBLE))
      comment: "Average click-through rate. Measures direct response performance for digital campaign optimization."
    - name: "impression_delivery_count"
      expr: COUNT(1)
      comment: "Total number of impression delivery records. Baseline volume metric for digital delivery activity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_makegood`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Makegood KPIs measuring delivery failure remediation, makegood liability, resolution rates, and financial impact for audience guarantee management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`makegood`"
  dimensions:
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the makegood for liability and remediation tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the proposed makegood for workflow and SLA monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the makegood (preemption, technical failure, etc.) for root cause analysis."
    - name: "original_daypart"
      expr: original_daypart
      comment: "Original daypart of the missed spot for inventory and pricing impact analysis."
    - name: "proposed_daypart"
      expr: proposed_daypart
      comment: "Proposed replacement daypart for makegood value equivalency analysis."
    - name: "original_scheduled_date"
      expr: original_scheduled_date
      comment: "Original scheduled air date for delivery failure timing analysis."
    - name: "actual_air_date"
      expr: actual_air_date
      comment: "Actual makegood air date for resolution timeliness tracking."
    - name: "affidavit_generated_flag"
      expr: affidavit_generated_flag
      comment: "Whether affidavit was generated for the makegood for compliance and billing verification."
  measures:
    - name: "total_original_spot_rate"
      expr: SUM(CAST(original_spot_rate AS DOUBLE))
      comment: "Total original spot rate value of makegoods. Measures financial exposure from delivery failures."
    - name: "avg_original_contracted_grp"
      expr: AVG(CAST(original_contracted_grp AS DOUBLE))
      comment: "Average contracted GRP of original spots requiring makegoods. Measures audience guarantee exposure."
    - name: "avg_original_actual_grp"
      expr: AVG(CAST(original_actual_grp AS DOUBLE))
      comment: "Average actual GRP delivered on original spots. Measures delivery shortfall driving makegood liability."
    - name: "avg_proposed_estimated_grp"
      expr: AVG(CAST(proposed_estimated_grp AS DOUBLE))
      comment: "Average estimated GRP of proposed makegood spots. Measures remediation adequacy."
    - name: "makegood_count"
      expr: COUNT(1)
      comment: "Total number of makegoods. Baseline volume metric for delivery failure and remediation workload."
    - name: "resolved_makegood_count"
      expr: COUNT(CASE WHEN resolution_status = 'resolved' THEN 1 END)
      comment: "Count of resolved makegoods. Measures remediation completion rate for advertiser satisfaction."
    - name: "pending_makegood_count"
      expr: COUNT(CASE WHEN resolution_status = 'pending' THEN 1 END)
      comment: "Count of pending makegoods. Measures outstanding makegood liability requiring resolution."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers with makegoods. Measures breadth of delivery failure impact on client relationships."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_advertising_audience_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience guarantee KPIs measuring delivery performance against contracted GRP/impression commitments, underdelivery exposure, and makegood liability for revenue assurance."
  source: "`vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee`"
  dimensions:
    - name: "guarantee_status"
      expr: guarantee_status
      comment: "Current guarantee status (active, fulfilled, underdelivered) for liability tracking."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the guarantee for inventory and pricing analysis."
    - name: "market_code"
      expr: market_code
      comment: "Market code for geographic guarantee performance analysis."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Measurement source (Nielsen, Comscore) for methodology and data quality analysis."
    - name: "guarantee_period_start_date"
      expr: guarantee_period_start_date
      comment: "Guarantee period start for time-series delivery performance analysis."
    - name: "guarantee_period_end_date"
      expr: guarantee_period_end_date
      comment: "Guarantee period end for fulfillment deadline tracking."
    - name: "makegood_required_flag"
      expr: makegood_required_flag
      comment: "Whether makegood is required for liability and remediation tracking."
  measures:
    - name: "total_contracted_grp"
      expr: SUM(CAST(contracted_grp AS DOUBLE))
      comment: "Total contracted GRP across all guarantees. Measures total audience delivery obligation."
    - name: "total_delivered_grp"
      expr: SUM(CAST(delivered_grp AS DOUBLE))
      comment: "Total GRP actually delivered. Measures audience delivery performance against guarantees."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS BIGINT))
      comment: "Total contracted impressions across guarantees. Measures total impression delivery obligation."
    - name: "total_delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS BIGINT))
      comment: "Total impressions actually delivered. Measures impression delivery fulfillment."
    - name: "total_makegood_grp_owed"
      expr: SUM(CAST(makegood_grp_owed AS DOUBLE))
      comment: "Total GRP owed as makegoods. Quantifies outstanding audience delivery liability."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for underdelivery. Measures financial impact of audience guarantee failures."
    - name: "avg_delivery_percentage"
      expr: AVG(CAST(delivery_percentage AS DOUBLE))
      comment: "Average delivery percentage across guarantees. Key fulfillment KPI for audience guarantee management."
    - name: "avg_delivery_variance_grp"
      expr: AVG(CAST(delivery_variance_grp AS DOUBLE))
      comment: "Average GRP delivery variance. Measures systematic over/underdelivery patterns for inventory planning."
    - name: "guarantee_count"
      expr: COUNT(1)
      comment: "Total number of audience guarantees. Baseline volume metric for guarantee portfolio management."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN makegood_required_flag = TRUE THEN 1 END)
      comment: "Count of guarantees requiring makegoods. Quantifies active makegood liability in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_agency_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency commission KPIs measuring commission costs, payment status, override rates, and reconciliation for agency relationship management and cost control."
  source: "`vibe_media_broadcasting_v1`.`sales`.`agency_commission`"
  dimensions:
    - name: "commission_status"
      expr: commission_status
      comment: "Current commission payment status for AR and cash flow management."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (standard, override, bonus) for cost structure analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (gross, net) for cost accuracy analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for dispute and accuracy tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period commission cost analysis."
    - name: "payment_date"
      expr: payment_date
      comment: "Commission payment date for cash flow and DSO analysis."
    - name: "override_flag"
      expr: override_flag
      comment: "Whether commission was overridden for pricing discipline monitoring."
    - name: "applicable_deal_types"
      expr: applicable_deal_types
      comment: "Deal types the commission applies to for revenue mix cost analysis."
  measures:
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission amount paid to agencies. Primary agency cost KPI for margin management."
    - name: "total_order_gross_amount"
      expr: SUM(CAST(order_gross_amount AS DOUBLE))
      comment: "Total gross order amount underlying commissions. Baseline for commission rate validation."
    - name: "total_order_net_amount"
      expr: SUM(CAST(order_net_amount AS DOUBLE))
      comment: "Total net order amount underlying commissions. Measures net revenue base for commission calculation."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across all agency commissions. Monitors agency cost as percentage of revenue."
    - name: "commission_record_count"
      expr: COUNT(1)
      comment: "Total number of commission records. Baseline volume metric for commission processing workload."
    - name: "override_commission_count"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Count of commission overrides. Monitors non-standard commission approvals for governance."
    - name: "distinct_agency_count"
      expr: COUNT(DISTINCT sales_agency_id)
      comment: "Number of unique agencies receiving commissions. Measures agency relationship breadth and cost concentration."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_political_ad_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Political advertising disclosure KPIs measuring political ad revenue, lowest unit rate compliance, equal time obligations, and FCC filing status for regulatory compliance management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure`"
  dimensions:
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Current disclosure filing status for FCC compliance tracking."
    - name: "political_ad_type"
      expr: political_ad_type
      comment: "Type of political ad (candidate, issue, PAC) for regulatory classification."
    - name: "election_type"
      expr: election_type
      comment: "Type of election (federal, state, local) for regulatory jurisdiction analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of political ad transactions for revenue reporting."
    - name: "air_date"
      expr: air_date
      comment: "Air date of political ad for election cycle and compliance timeline analysis."
    - name: "election_date"
      expr: election_date
      comment: "Election date for pre-election period compliance analysis."
    - name: "lowest_unit_rate_applied"
      expr: lowest_unit_rate_applied
      comment: "Whether lowest unit rate was applied for FCC compliance monitoring."
    - name: "equal_time_obligation_flag"
      expr: equal_time_obligation_flag
      comment: "Whether equal time obligation applies for FCC Section 315 compliance tracking."
    - name: "reasonable_access_flag"
      expr: reasonable_access_flag
      comment: "Whether reasonable access was provided for FCC compliance monitoring."
  measures:
    - name: "total_spot_rate_charged"
      expr: SUM(CAST(spot_rate_charged AS DOUBLE))
      comment: "Total revenue from political ad spots. Primary political revenue KPI for FCC reporting."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value of political ad agreements. Measures political revenue exposure per election cycle."
    - name: "avg_lowest_unit_rate"
      expr: AVG(CAST(lowest_unit_rate_amount AS DOUBLE))
      comment: "Average lowest unit rate across political ads. Key FCC compliance metric for rate card adherence."
    - name: "disclosure_count"
      expr: COUNT(1)
      comment: "Total number of political ad disclosures. Baseline FCC compliance volume metric."
    - name: "lowest_unit_rate_applied_count"
      expr: COUNT(CASE WHEN lowest_unit_rate_applied = TRUE THEN 1 END)
      comment: "Count of disclosures where lowest unit rate was applied. Measures FCC rate compliance adherence."
    - name: "equal_time_obligation_count"
      expr: COUNT(CASE WHEN equal_time_obligation_flag = TRUE THEN 1 END)
      comment: "Count of disclosures with equal time obligations. Measures FCC Section 315 compliance exposure."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique political advertisers. Measures political client base breadth for compliance management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_carriage_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage deal KPIs measuring distribution revenue, subscriber fees, retransmission consent, and deal terms for affiliate and distribution relationship management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`carriage_deal`"
  dimensions:
    - name: "carriage_status"
      expr: carriage_status
      comment: "Current carriage deal status for distribution revenue pipeline tracking."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of carriage deal for revenue structure analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for cash flow and AR management."
    - name: "currency_code"
      expr: currency_code
      comment: "Deal currency for multi-currency distribution revenue reporting."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Deal effective start date for contract lifecycle analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Deal effective end date for renewal pipeline management."
    - name: "retransmission_consent_designation"
      expr: retransmission_consent_designation
      comment: "Whether deal involves retransmission consent for regulatory classification."
    - name: "must_carry_designation"
      expr: must_carry_designation
      comment: "Whether channel has must-carry designation for regulatory and negotiation analysis."
    - name: "hd_tier_flag"
      expr: hd_tier_flag
      comment: "Whether deal includes HD tier for premium revenue analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether deal auto-renews for revenue continuity and churn risk analysis."
  measures:
    - name: "total_carriage_fee_per_subscriber"
      expr: SUM(CAST(carriage_fee_per_subscriber AS DOUBLE))
      comment: "Total carriage fee per subscriber across deals. Primary distribution revenue rate KPI."
    - name: "avg_carriage_fee_per_subscriber"
      expr: AVG(CAST(carriage_fee_per_subscriber AS DOUBLE))
      comment: "Average carriage fee per subscriber. Benchmarks distribution pricing competitiveness."
    - name: "total_retransmission_consent_fee"
      expr: SUM(CAST(retransmission_consent_fee AS DOUBLE))
      comment: "Total retransmission consent fees. Measures retransmission revenue stream contribution."
    - name: "avg_advertising_revenue_share_pct"
      expr: AVG(CAST(advertising_revenue_share_pct AS DOUBLE))
      comment: "Average advertising revenue share percentage. Monitors distribution partner revenue sharing terms."
    - name: "carriage_deal_count"
      expr: COUNT(1)
      comment: "Total number of carriage deals. Baseline volume metric for distribution relationship portfolio."
    - name: "retransmission_consent_deal_count"
      expr: COUNT(CASE WHEN retransmission_consent_designation = TRUE THEN 1 END)
      comment: "Count of retransmission consent deals. Measures retransmission revenue exposure and regulatory obligations."
    - name: "auto_renewal_deal_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Count of auto-renewal deals. Measures revenue continuity and renewal pipeline management."
    - name: "distinct_distribution_partner_count"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners. Measures distribution network breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory KPIs measuring revenue targets, geographic coverage, and territory performance for sales force planning and quota management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current territory status (active, inactive) for sales force coverage analysis."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (national, regional, local) for sales structure analysis."
    - name: "account_segment"
      expr: account_segment
      comment: "Account segment focus of the territory for revenue mix analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel of the territory for channel mix analysis."
    - name: "scatter_market_flag"
      expr: scatter_market_flag
      comment: "Whether territory participates in scatter market for revenue type analysis."
    - name: "upfront_participation_flag"
      expr: upfront_participation_flag
      comment: "Whether territory participates in upfront for seasonal revenue planning."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Territory effective start date for coverage continuity analysis."
  measures:
    - name: "total_revenue_target"
      expr: SUM(CAST(revenue_target_amount AS DOUBLE))
      comment: "Total revenue target across all territories. Primary quota planning KPI for sales force management."
    - name: "avg_revenue_target"
      expr: AVG(CAST(revenue_target_amount AS DOUBLE))
      comment: "Average revenue target per territory. Benchmarks quota allocation equity across sales force."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of sales territories. Baseline metric for sales force coverage and structure analysis."
    - name: "scatter_market_territory_count"
      expr: COUNT(CASE WHEN scatter_market_flag = TRUE THEN 1 END)
      comment: "Count of territories participating in scatter market. Measures scatter market coverage breadth."
    - name: "upfront_territory_count"
      expr: COUNT(CASE WHEN upfront_participation_flag = TRUE THEN 1 END)
      comment: "Count of territories participating in upfront. Measures upfront season sales force coverage."
    - name: "distinct_rep_count"
      expr: COUNT(DISTINCT assigned_sales_rep_id)
      comment: "Number of unique sales reps assigned to territories. Measures sales force deployment and coverage gaps."
$$;