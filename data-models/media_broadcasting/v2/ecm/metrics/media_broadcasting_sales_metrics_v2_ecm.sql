-- Metric views for domain: sales | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising order economics: contracted value, delivery against GRP/TRP targets, discount discipline, and commission exposure. Core revenue-steering KPIs for ad sales leadership."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the ad order (confirmed, pending, cancelled)."
    - name: "order_type"
      expr: order_type
      comment: "Type of ad order (national, local, digital, etc.)."
    - name: "market_code"
      expr: market_code
      comment: "DMA / market the order targets."
    - name: "product_category"
      expr: product_category
      comment: "Advertiser product category for vertical mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Order currency for FX normalization."
    - name: "is_political"
      expr: political_ad_flag
      comment: "Whether the order is a political advertisement (FCC reporting)."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Flight start bucketed to month for time trending."
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of ad orders."
    - name: "total_contracted_value"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total contracted value across orders — top-line revenue commitment."
    - name: "net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Net realized order value after discounts/commissions."
    - name: "avg_contracted_cpm"
      expr: AVG(CAST(contracted_cpm AS DOUBLE))
      comment: "Average contracted CPM — pricing health indicator."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage — pricing discipline / margin erosion signal."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average agency commission rate — distribution cost driver."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total contracted GRP commitment for delivery planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level ad delivery: contracted vs actual impressions/GRP, realized CPM, and revenue. Drives makegood risk and delivery-pacing decisions."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the order line (active, delivered, cancelled)."
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type (linear, digital, addressable)."
    - name: "currency_code"
      expr: currency_code
      comment: "Line currency."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Flight start month for delivery trending."
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of order lines."
    - name: "contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total contracted impressions."
    - name: "actual_impressions_delivered"
      expr: SUM(CAST(actual_impressions_delivered AS DOUBLE))
      comment: "Total actual impressions delivered — measure against contract."
    - name: "contracted_grp"
      expr: SUM(CAST(contracted_grp AS DOUBLE))
      comment: "Total contracted GRP."
    - name: "actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total actual GRP delivered — underdelivery / makegood signal."
    - name: "line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total line revenue."
    - name: "net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net line revenue."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average line CPM — realized pricing."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot-level airing and delivery: impressions delivered, realized CPM, preemption and makegood rates. Operational steering for traffic and delivery teams."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_spot`"
  dimensions:
    - name: "spot_status"
      expr: spot_status
      comment: "Airing status of the spot."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing reconciliation status."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the spot aired in."
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Platform (linear, OTT, CTV) of delivery."
    - name: "market_code"
      expr: market_code
      comment: "Market the spot aired in."
    - name: "scheduled_air_month"
      expr: DATE_TRUNC('MONTH', scheduled_air_date)
      comment: "Scheduled air month for trending."
  measures:
    - name: "spot_count"
      expr: COUNT(1)
      comment: "Number of ad spots."
    - name: "impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered."
    - name: "preempted_spots"
      expr: SUM(CASE WHEN preempted_flag THEN 1 ELSE 0 END)
      comment: "Count of preempted spots — service failure / makegood driver."
    - name: "makegood_spots"
      expr: SUM(CASE WHEN makegood_flag THEN 1 ELSE 0 END)
      comment: "Count of makegood spots — delivery shortfall cost."
    - name: "spot_revenue"
      expr: SUM(CAST(spot_rate_amount AS DOUBLE))
      comment: "Total spot rate revenue."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm_amount AS DOUBLE))
      comment: "Average realized spot CPM."
    - name: "total_grp"
      expr: SUM(CAST(grp_value AS DOUBLE))
      comment: "Total GRP value delivered by spots."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline health: estimated value, win probability, stage mix, and CPM/CPRP pricing of pipeline. Core CRO/VP-Sales forecasting KPIs."
  source: "`vibe_media_broadcasting_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Pipeline stage of the opportunity."
    - name: "deal_type"
      expr: deal_type
      comment: "Deal type (upfront, scatter, digital)."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category for pipeline weighting."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin of the opportunity lead."
    - name: "is_upfront"
      expr: is_upfront
      comment: "Whether opportunity is part of upfront selling."
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Expected close month for pipeline trending."
  measures:
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Number of opportunities in pipeline."
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total unweighted pipeline value."
    - name: "avg_win_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability — pipeline quality."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average opportunity size."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average proposed CPM rate across pipeline."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total target impressions in pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_advertising_audience_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience guarantee delivery: contracted vs delivered GRP/impressions, delivery percentage, makegood liability, and underdelivery. Critical for upfront reconciliation."
  source: "`vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee`"
  dimensions:
    - name: "guarantee_status"
      expr: guarantee_status
      comment: "Status of the audience guarantee."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the guarantee applies to."
    - name: "market_code"
      expr: market_code
      comment: "Market for the guarantee."
    - name: "makegood_required"
      expr: makegood_required_flag
      comment: "Whether a makegood is owed."
    - name: "guarantee_start_month"
      expr: DATE_TRUNC('MONTH', guarantee_period_start_date)
      comment: "Guarantee period start month."
  measures:
    - name: "guarantee_count"
      expr: COUNT(1)
      comment: "Number of audience guarantees."
    - name: "contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total contracted guaranteed impressions."
    - name: "delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS DOUBLE))
      comment: "Total delivered impressions against guarantees."
    - name: "avg_delivery_pct"
      expr: AVG(CAST(delivery_percentage AS DOUBLE))
      comment: "Average delivery percentage — guarantee fulfillment health."
    - name: "total_makegood_grp_owed"
      expr: SUM(CAST(makegood_grp_owed AS DOUBLE))
      comment: "Total GRP owed as makegood — liability exposure."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credits issued against guarantee shortfall."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_makegood`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Makegood liability and resolution: count, approval/resolution status, and GRP at stake. Signals delivery-failure cost and inventory reallocation."
  source: "`vibe_media_broadcasting_v1`.`sales`.`makegood`"
  dimensions:
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the makegood."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the makegood."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the makegood."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Approval month for trending."
  measures:
    - name: "makegood_count"
      expr: COUNT(1)
      comment: "Number of makegoods."
    - name: "total_contracted_grp"
      expr: SUM(CAST(original_contracted_grp AS DOUBLE))
      comment: "Total originally contracted GRP underlying makegoods."
    - name: "total_actual_grp"
      expr: SUM(CAST(original_actual_grp AS DOUBLE))
      comment: "Total actual GRP delivered on the original spots."
    - name: "avg_original_spot_rate"
      expr: AVG(CAST(original_spot_rate AS DOUBLE))
      comment: "Average rate of original spots requiring makegood — cost basis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_agency_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency commission cost and reconciliation: commission amounts, rates, dispute and reconciliation status. Distribution-cost steering for finance/sales ops."
  source: "`vibe_media_broadcasting_v1`.`sales`.`agency_commission`"
  dimensions:
    - name: "commission_status"
      expr: commission_status
      comment: "Status of the commission record."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (standard, override)."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the commission."
    - name: "currency_code"
      expr: currency_code
      comment: "Commission currency."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period the commission belongs to."
  measures:
    - name: "commission_count"
      expr: COUNT(1)
      comment: "Number of commission records."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total agency commission paid/accrued — distribution cost."
    - name: "total_order_gross"
      expr: SUM(CAST(order_gross_amount AS DOUBLE))
      comment: "Total gross order amount backing commissions."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate."
    - name: "override_count"
      expr: SUM(CASE WHEN override_flag THEN 1 ELSE 0 END)
      comment: "Count of commission overrides — exception monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue forecast vs quota: total forecasted revenue, attainment, weighted pipeline, and variance-to-quota by category. Core board-level sales steering."
  source: "`vibe_media_broadcasting_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast submission."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (commit, best case, pipeline)."
    - name: "deal_type"
      expr: deal_type
      comment: "Deal type the forecast covers."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the forecast."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Forecast period start month."
  measures:
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast records."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue."
    - name: "total_commit_revenue"
      expr: SUM(CAST(commit_revenue AS DOUBLE))
      comment: "Total committed revenue — high-confidence forecast."
    - name: "total_quota"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota target."
    - name: "avg_attainment_pct"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average quota attainment percentage."
    - name: "total_weighted_pipeline"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Total probability-weighted pipeline value."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_impression_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital impression delivery quality: served vs viewable impressions, completion/CTR, viewability, and realized revenue. Steers programmatic/CTV performance."
  source: "`vibe_media_broadcasting_v1`.`sales`.`impression_delivery`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Delivery platform type."
    - name: "device_type"
      expr: device_type
      comment: "Device type the impression rendered on."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status."
    - name: "content_genre"
      expr: content_genre
      comment: "Content genre adjacency for impressions."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Delivery month for trending."
  measures:
    - name: "delivery_record_count"
      expr: COUNT(1)
      comment: "Number of delivery records."
    - name: "total_impressions_served"
      expr: SUM(CAST(total_impressions_served AS DOUBLE))
      comment: "Total impressions served."
    - name: "viewable_impressions"
      expr: SUM(CAST(viewable_impressions AS DOUBLE))
      comment: "Total viewable impressions — quality of delivery."
    - name: "completed_views"
      expr: SUM(CAST(completed_views AS DOUBLE))
      comment: "Total completed views."
    - name: "total_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total realized revenue from delivery."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate_percent AS DOUBLE))
      comment: "Average viewability rate — MRC/IAB quality metric."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average completion rate."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal conversion economics: proposed value, win probability, pricing, and proposed delivery. Steers pre-sale yield and close rate (Section 3a stub fix surfacing rich attributes)."
  source: "`vibe_media_broadcasting_v1`.`sales`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Status of the proposal."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (upfront, scatter, digital)."
    - name: "currency_code"
      expr: currency_code
      comment: "Proposal currency."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic of the proposal."
    - name: "proposal_month"
      expr: DATE_TRUNC('MONTH', proposal_date)
      comment: "Proposal date bucketed to month."
  measures:
    - name: "proposal_count"
      expr: COUNT(1)
      comment: "Number of proposals."
    - name: "total_proposed_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE))
      comment: "Total proposed deal value."
    - name: "net_proposed_value"
      expr: SUM(CAST(net_proposed_value AS DOUBLE))
      comment: "Total net proposed value after discounts."
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percent AS DOUBLE))
      comment: "Average proposal win probability — close-rate predictor."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average proposed CPM."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average proposed discount percentage."
    - name: "total_proposed_impressions"
      expr: SUM(CAST(proposed_impressions AS DOUBLE))
      comment: "Total proposed impressions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_scatter_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scatter market order economics: order value, negotiated CPM, delivered impressions/GRP vs target. Steers in-quarter scatter yield (Section 3a/3E stub fix)."
  source: "`vibe_media_broadcasting_v1`.`sales`.`scatter_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the scatter order."
    - name: "order_type"
      expr: order_type
      comment: "Type of scatter order."
    - name: "currency_code"
      expr: currency_code
      comment: "Order currency."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic of the order."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order date bucketed to month."
  measures:
    - name: "scatter_order_count"
      expr: COUNT(1)
      comment: "Number of scatter orders."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total scatter order value."
    - name: "net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net scatter order value."
    - name: "avg_negotiated_cpm"
      expr: AVG(CAST(negotiated_cpm AS DOUBLE))
      comment: "Average negotiated CPM — scatter pricing premium."
    - name: "delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS DOUBLE))
      comment: "Total delivered impressions."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target GRP."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront commitment fulfillment: committed vs delivered spend, fulfillment percentage, cancellation and exercise exposure. Annual upfront-cycle steering."
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Status of the upfront commitment."
    - name: "currency_code"
      expr: currency_code
      comment: "Commitment currency."
    - name: "upfront_year"
      expr: upfront_year
      comment: "Upfront selling year."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic of the commitment."
    - name: "commitment_month"
      expr: DATE_TRUNC('MONTH', commitment_date)
      comment: "Commitment date bucketed to month."
  measures:
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Number of upfront commitments."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed upfront spend."
    - name: "delivered_spend_to_date"
      expr: SUM(CAST(delivered_spend_to_date AS DOUBLE))
      comment: "Total spend delivered to date against commitments."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(total_cancelled_amount AS DOUBLE))
      comment: "Total cancelled commitment amount — attrition exposure."
    - name: "avg_fulfillment_pct"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average commitment fulfillment percentage."
    - name: "remaining_commitment_balance"
      expr: SUM(CAST(remaining_commitment_balance AS DOUBLE))
      comment: "Total remaining commitment balance — open revenue."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront deal economics: committed vs proposed spend, CPM/CPRP pricing, and audience guarantees. Steers upfront negotiation outcomes."
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Status of the upfront deal."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of upfront deal."
    - name: "deal_year"
      expr: deal_year
      comment: "Upfront deal year."
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Pricing basis (CPM, CPRP)."
    - name: "currency_code"
      expr: currency_code
      comment: "Deal currency."
  measures:
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Number of upfront deals."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed upfront spend."
    - name: "total_proposed_spend"
      expr: SUM(CAST(total_proposed_spend AS DOUBLE))
      comment: "Total proposed upfront spend — negotiation gap analysis."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average upfront CPM rate."
    - name: "total_guarantee_impressions"
      expr: SUM(CAST(audience_guarantee_impressions AS DOUBLE))
      comment: "Total guaranteed impressions across upfront deals."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_sponsorship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsorship value and fulfillment: deal value, fulfillment percentage, guaranteed impressions, and exclusivity mix. Steers branded-content revenue."
  source: "`vibe_media_broadcasting_v1`.`sales`.`sponsorship`"
  dimensions:
    - name: "sponsorship_status"
      expr: sponsorship_status
      comment: "Status of the sponsorship."
    - name: "sponsorship_type"
      expr: sponsorship_type
      comment: "Type of sponsorship."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of deliverables."
    - name: "currency_code"
      expr: currency_code
      comment: "Sponsorship currency."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Flight start month."
  measures:
    - name: "sponsorship_count"
      expr: COUNT(1)
      comment: "Number of sponsorships."
    - name: "total_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total sponsorship value."
    - name: "total_guaranteed_impressions"
      expr: SUM(CAST(guaranteed_impressions AS DOUBLE))
      comment: "Total guaranteed sponsorship impressions."
    - name: "avg_fulfillment_pct"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average deliverable fulfillment percentage."
    - name: "exclusivity_count"
      expr: SUM(CASE WHEN category_exclusivity_flag THEN 1 ELSE 0 END)
      comment: "Count of category-exclusive sponsorships — premium positioning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_bid_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programmatic auction performance: bid vs clearing price, win rate, and bid volume. Steers CTV/programmatic OpenRTB economics (Section 3 addressable addition)."
  source: "`vibe_media_broadcasting_v1`.`sales`.`bid_response`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Bid currency."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for losing the bid."
    - name: "is_winner"
      expr: is_winner
      comment: "Whether the bid won the auction."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Response timestamp bucketed to month."
  measures:
    - name: "bid_response_count"
      expr: COUNT(1)
      comment: "Number of bid responses."
    - name: "won_bids"
      expr: SUM(CASE WHEN win_flag THEN 1 ELSE 0 END)
      comment: "Count of winning bids — win-rate numerator."
    - name: "avg_bid_price_cpm"
      expr: AVG(CAST(bid_price_cpm AS DOUBLE))
      comment: "Average bid CPM."
    - name: "avg_clearing_price_cpm"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Average clearing CPM — market price discovery."
    - name: "total_weighted_responses"
      expr: SUM(CAST(sample_weight AS DOUBLE))
      comment: "Sum of sample weights for population-projected metrics."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_dai_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic ad insertion performance: insertion success, completion, revenue, and viewability. Steers addressable CTV monetization."
  source: "`vibe_media_broadcasting_v1`.`sales`.`dai_event`"
  dimensions:
    - name: "insertion_status"
      expr: insertion_status
      comment: "Status of the ad insertion."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform of the DAI event."
    - name: "device_type"
      expr: device_type
      comment: "Device type of delivery."
    - name: "viewability_status"
      expr: viewability_status
      comment: "Viewability status of the impression."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', ad_decision_timestamp)
      comment: "Ad decision month for trending."
  measures:
    - name: "dai_event_count"
      expr: COUNT(1)
      comment: "Number of DAI events."
    - name: "impressions_fired"
      expr: SUM(CASE WHEN impression_fired_flag THEN 1 ELSE 0 END)
      comment: "Count of fired impressions — successful inserts."
    - name: "total_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total DAI revenue."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average completion rate of inserted ads."
    - name: "avg_bid_price_cpm"
      expr: AVG(CAST(bid_price_cpm AS DOUBLE))
      comment: "Average bid CPM for inserted ads."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_avail`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory availability and sellout: projected impressions/GRP, floor pricing, and hold status. Steers yield management and inventory utilization."
  source: "`vibe_media_broadcasting_v1`.`sales`.`avail`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Hold status of the avail."
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type of the avail."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the avail belongs to."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform of the avail."
    - name: "air_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Air date bucketed to month."
  measures:
    - name: "avail_count"
      expr: COUNT(1)
      comment: "Number of inventory avails."
    - name: "total_projected_impressions"
      expr: SUM(CAST(projected_impressions AS DOUBLE))
      comment: "Total projected impressions of available inventory."
    - name: "total_projected_grp"
      expr: SUM(CAST(projected_grp AS DOUBLE))
      comment: "Total projected GRP of available inventory."
    - name: "avg_floor_cpm"
      expr: AVG(CAST(floor_cpm_usd AS DOUBLE))
      comment: "Average floor CPM — pricing floor discipline."
    - name: "preemptible_count"
      expr: SUM(CASE WHEN preemptible_flag THEN 1 ELSE 0 END)
      comment: "Count of preemptible avails — risk inventory."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_content_license_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content licensing deal economics: deal value, minimum guarantees, revenue share, and platform-rights mix. Steers syndication/licensing revenue."
  source: "`vibe_media_broadcasting_v1`.`sales`.`content_license_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Status of the license deal."
    - name: "license_type"
      expr: license_type
      comment: "Type of content license."
    - name: "territory"
      expr: territory
      comment: "Territory of the license."
    - name: "deal_value_currency"
      expr: deal_value_currency
      comment: "Deal value currency."
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_start_date)
      comment: "License start month."
  measures:
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Number of content license deals."
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total content license deal value."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee committed — floor revenue."
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_carriage_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution carriage economics: per-subscriber fees, retransmission consent fees, and ad revenue share. Steers affiliate/MVPD distribution revenue."
  source: "`vibe_media_broadcasting_v1`.`sales`.`carriage_deal`"
  dimensions:
    - name: "carriage_status"
      expr: carriage_status
      comment: "Status of the carriage deal."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of carriage deal."
    - name: "tier_placement"
      expr: tier_placement
      comment: "Tier placement of the channel."
    - name: "currency_code"
      expr: currency_code
      comment: "Deal currency."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Effective start month."
  measures:
    - name: "carriage_deal_count"
      expr: COUNT(1)
      comment: "Number of carriage deals."
    - name: "avg_fee_per_subscriber"
      expr: AVG(CAST(carriage_fee_per_subscriber AS DOUBLE))
      comment: "Average carriage fee per subscriber — distribution yield."
    - name: "total_retrans_fee"
      expr: SUM(CAST(retransmission_consent_fee AS DOUBLE))
      comment: "Total retransmission consent fees."
    - name: "avg_ad_revenue_share"
      expr: AVG(CAST(advertising_revenue_share_pct AS DOUBLE))
      comment: "Average advertising revenue share percentage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_rfp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP pipeline and win economics: budget range, awarded amount, desired reach/GRP. Steers competitive proposal win rates."
  source: "`vibe_media_broadcasting_v1`.`sales`.`rfp`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Status of the RFP."
    - name: "campaign_objective"
      expr: campaign_objective
      comment: "Campaign objective of the RFP."
    - name: "pricing_model_preference"
      expr: pricing_model_preference
      comment: "Preferred pricing model."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the RFP."
    - name: "response_due_month"
      expr: DATE_TRUNC('MONTH', response_due_date)
      comment: "Response due month."
  measures:
    - name: "rfp_count"
      expr: COUNT(1)
      comment: "Number of RFPs."
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total awarded RFP value — won business."
    - name: "avg_budget_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average max budget of RFPs — deal-size indicator."
    - name: "total_desired_impressions"
      expr: SUM(CAST(desired_impressions AS DOUBLE))
      comment: "Total desired impressions across RFPs."
    - name: "avg_desired_reach_pct"
      expr: AVG(CAST(desired_reach_percent AS DOUBLE))
      comment: "Average desired reach percentage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales rep productivity and quota: annual quota, commission rate, and performance tier mix. Steers sales-force capacity and incentive design."
  source: "`vibe_media_broadcasting_v1`.`sales`.`rep`"
  dimensions:
    - name: "rep_status"
      expr: rep_status
      comment: "Status of the sales rep."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier of the rep."
    - name: "commission_plan_type"
      expr: commission_plan_type
      comment: "Commission plan type."
    - name: "deal_type_specialization"
      expr: deal_type_specialization
      comment: "Deal-type specialization of the rep."
  measures:
    - name: "rep_count"
      expr: COUNT(1)
      comment: "Number of sales reps."
    - name: "total_annual_quota"
      expr: SUM(CAST(annual_quota_amount AS DOUBLE))
      comment: "Total annual quota carried — capacity."
    - name: "avg_annual_quota"
      expr: AVG(CAST(annual_quota_amount AS DOUBLE))
      comment: "Average quota per rep."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percentage AS DOUBLE))
      comment: "Average commission rate — incentive cost."
$$;