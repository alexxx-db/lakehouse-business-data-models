-- Metric views for domain: marketing | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic campaign performance metrics tracking budget efficiency, sales lift, and ROI across all marketing campaigns. Used by CMO and VP Marketing to steer campaign investment decisions."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g. LTO, brand, promotional) for performance segmentation."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (active, completed, paused)."
    - name: "owning_brand"
      expr: owning_brand
      comment: "Brand that owns the campaign, enabling brand-level performance comparison."
    - name: "objective"
      expr: objective
      comment: "Primary business objective of the campaign (e.g. traffic, awareness, conversion)."
    - name: "target_market"
      expr: target_market
      comment: "Geographic or demographic market targeted by the campaign."
    - name: "target_daypart"
      expr: target_daypart
      comment: "Daypart targeted by the campaign (breakfast, lunch, dinner, late night)."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the campaign is tied to a limited-time offer."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the campaign was planned to start, for time-series trending."
    - name: "actual_start_date"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month the campaign actually launched, for launch timing analysis."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Mix of media channels used in the campaign."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for portfolio sizing."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total planned marketing budget across all campaigns. Drives investment allocation decisions."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across all campaigns. Compared against budget to assess spend discipline."
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign. Benchmarks investment level per initiative."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned budget actually spent. Signals over/under-spend discipline."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_pct AS DOUBLE))
      comment: "Average actual comparable sales lift percentage delivered by campaigns. Core revenue effectiveness KPI."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_pct AS DOUBLE))
      comment: "Average expected comparable sales lift percentage. Baseline for lift delivery gap analysis."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_pct AS DOUBLE))
      comment: "Average actual average daily transaction lift percentage. Measures traffic-driving effectiveness."
    - name: "lto_campaign_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Number of LTO-linked campaigns. Tracks LTO pipeline volume for menu strategy alignment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance metrics measuring actual vs expected lift, spend efficiency, and ROI at the unit and channel level. Used by field marketing and brand teams to optimize in-flight campaigns."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "execution_channel"
      expr: execution_channel
      comment: "Channel through which the campaign was executed (digital, print, radio, etc.)."
    - name: "campaign_execution_status"
      expr: campaign_execution_status
      comment: "Current status of the execution (launched, completed, cancelled)."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic performance segmentation."
    - name: "target_audience"
      expr: target_audience
      comment: "Audience segment targeted by this execution."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of campaign launch for time-series trending."
    - name: "creative_version"
      expr: creative_version
      comment: "Creative version used in this execution for A/B performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of spend amounts for multi-currency normalization."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of campaign executions. Baseline volume for execution portfolio management."
    - name: "total_channel_spend"
      expr: SUM(CAST(channel_spend_amount AS DOUBLE))
      comment: "Total spend across all campaign executions. Core investment tracking metric."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percentage across executions. Primary efficiency KPI for marketing investment."
    - name: "avg_actual_comp_sales_lift_percent"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comparable sales lift delivered. Measures revenue impact of executions."
    - name: "avg_expected_comp_sales_lift_percent"
      expr: AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average expected comparable sales lift. Baseline for delivery gap analysis."
    - name: "lift_delivery_gap_pct"
      expr: ROUND(AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE)) - AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE)), 2)
      comment: "Gap between actual and expected comp sales lift. Negative values signal underperforming executions requiring intervention."
    - name: "avg_actual_adt_lift_percent"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual ADT (average daily transactions) lift. Measures traffic-driving effectiveness of executions."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click across digital executions. Efficiency benchmark for digital channel investment."
    - name: "avg_cost_per_impression"
      expr: AVG(CAST(cost_per_impression AS DOUBLE))
      comment: "Average cost per impression. Media efficiency KPI for awareness campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_roi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign return-on-investment metrics providing financial accountability for marketing spend. Used by CFO and CMO to evaluate marketing effectiveness and justify budget allocations."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_roi`"
  dimensions:
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Attribution model used (last-touch, multi-touch, etc.) for ROI calculation context."
    - name: "channel"
      expr: channel
      comment: "Marketing channel for channel-level ROI comparison."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic ROI segmentation."
    - name: "campaign_roi_status"
      expr: campaign_roi_status
      comment: "Status of the ROI record (final, preliminary, revised)."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Statistical confidence level of the ROI measurement."
    - name: "measurement_period_start"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month the measurement period started for time-series ROI trending."
    - name: "is_test_roi"
      expr: is_test_roi
      comment: "Flag distinguishing test/holdout ROI measurements from production."
  measures:
    - name: "total_roi_records"
      expr: COUNT(1)
      comment: "Total number of ROI measurement records. Baseline for coverage assessment."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total marketing spend measured. Core investment denominator for ROI calculations."
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue attributed to marketing. Primary revenue impact KPI."
    - name: "total_net_incremental_profit"
      expr: SUM(CAST(net_incremental_profit AS DOUBLE))
      comment: "Total net incremental profit after COGS. True profitability impact of marketing investment."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total COGS impact from marketing-driven volume. Needed for margin-adjusted ROI analysis."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percentage across all measured campaigns. Primary marketing efficiency KPI for executive review."
    - name: "revenue_per_spend_dollar"
      expr: ROUND(SUM(CAST(incremental_revenue AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Incremental revenue generated per dollar of marketing spend. Compound efficiency ratio for investment steering."
    - name: "profit_per_spend_dollar"
      expr: ROUND(SUM(CAST(net_incremental_profit AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Net incremental profit per dollar of marketing spend. Most rigorous marketing efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing spend tracking metrics for budget control, variance analysis, and vendor accountability. Used by finance and marketing operations to manage spend discipline."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_spend`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Media channel for spend allocation analysis."
    - name: "media_type"
      expr: media_type
      comment: "Type of media (TV, digital, OOH, etc.) for spend mix analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget tracking."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly spend pacing analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the spend record (approved, pending, rejected)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend for multi-currency normalization."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag distinguishing estimated vs actual spend records."
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor receiving the spend for vendor-level accountability."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice for spend timing analysis."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total gross marketing spend. Primary budget consumption metric."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend after discounts and adjustments. True cost basis for ROI calculations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on marketing spend. Required for accurate financial reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts received from vendors. Tracks negotiated savings."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between planned and actual spend. Signals budget control issues."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average spend variance percentage. Measures budget forecasting accuracy."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate on marketing spend. Used for tax planning and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_digital_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital marketing performance metrics covering impressions, clicks, conversions, and cost efficiency. Used by digital marketing teams and CMO to optimize digital channel investment."
  source: "`vibe_restaurants_v1`.`marketing`.`digital_campaign_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Digital channel (paid search, social, display, etc.) for channel-level performance comparison."
    - name: "platform"
      expr: platform
      comment: "Specific platform (Google, Meta, TikTok, etc.) for platform-level optimization."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (video, banner, carousel, etc.) for creative format effectiveness analysis."
    - name: "audience_segment"
      expr: audience_segment
      comment: "Audience segment targeted for segment-level performance analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet) for device-level optimization."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional digital performance comparison."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of ad delivery for time-of-day optimization."
    - name: "event_date"
      expr: DATE_TRUNC('week', event_date)
      comment: "Week of performance event for weekly trending."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied for consistent cross-channel comparison."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating LTO-linked digital campaigns for LTO performance isolation."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total ad impressions delivered. Awareness reach metric."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated. Engagement volume metric."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions attributed. Primary digital effectiveness metric."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views. Engagement metric for video creative performance."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual digital spend. Core investment tracking metric."
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to digital campaigns. Revenue impact of digital investment."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate. Measures ad relevance and creative effectiveness."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate. Measures landing page and funnel effectiveness."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click. Efficiency benchmark for paid digital channels."
    - name: "avg_cost_per_acquisition"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average cost per acquisition. Most important digital efficiency KPI for conversion campaigns."
    - name: "avg_cost_per_mille"
      expr: AVG(CAST(cost_per_mille AS DOUBLE))
      comment: "Average CPM (cost per thousand impressions). Efficiency benchmark for awareness campaigns."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percentage for digital campaigns. Executive-level digital investment efficiency KPI."
    - name: "revenue_per_spend_dollar"
      expr: ROUND(SUM(CAST(revenue_attributed AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend AS DOUBLE)), 0), 2)
      comment: "Revenue attributed per dollar of digital spend. Compound efficiency ratio for digital investment steering."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency_average AS DOUBLE))
      comment: "Average ad frequency per user. Monitors ad fatigue risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_media_buy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media buying efficiency metrics tracking contracted vs actual delivery, CPM performance, and spend reconciliation. Used by media planning teams to optimize media investment."
  source: "`vibe_restaurants_v1`.`marketing`.`media_buy`"
  dimensions:
    - name: "media_buy_status"
      expr: media_buy_status
      comment: "Status of the media buy (active, completed, cancelled) for portfolio management."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format for format-level performance comparison."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic media investment analysis."
    - name: "publisher_name"
      expr: publisher_name
      comment: "Publisher or media vendor for vendor-level performance accountability."
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Flag distinguishing programmatic from direct media buys."
    - name: "audience_segment"
      expr: audience_segment
      comment: "Audience segment targeted for segment-level media efficiency analysis."
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month the media flight started for time-series media spend trending."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for financial close and vendor payment management."
  measures:
    - name: "total_media_buys"
      expr: COUNT(1)
      comment: "Total number of media buys. Baseline volume for media portfolio management."
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted media spend. Commitment tracking for budget management."
    - name: "total_net_spend"
      expr: SUM(CAST(net_spend AS DOUBLE))
      comment: "Total net media spend after adjustments. Actual cost basis for ROI calculations."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total actual impressions delivered. Delivery fulfillment metric."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total contracted impressions. Baseline for delivery fulfillment rate calculation."
    - name: "impression_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions AS DOUBLE)) / NULLIF(SUM(CAST(contracted_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted impressions actually delivered. Vendor accountability KPI."
    - name: "avg_actual_cpm"
      expr: AVG(CAST(actual_cpm AS DOUBLE))
      comment: "Average actual CPM achieved. Measures media buying efficiency vs contracted rates."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average contracted CPM rate. Baseline for CPM efficiency comparison."
    - name: "cpm_efficiency_ratio"
      expr: ROUND(AVG(CAST(actual_cpm AS DOUBLE)) / NULLIF(AVG(CAST(cpm_rate AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to contracted CPM. Values below 1.0 indicate favorable media buying outcomes."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-buy adjustments. Tracks make-good credits and billing corrections."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_promotion_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion redemption metrics measuring discount impact, redemption volume, and guest engagement. Used by marketing and finance to evaluate promotion effectiveness and cost."
  source: "`vibe_restaurants_v1`.`marketing`.`promotion_redemption`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Redemption channel (in-store, app, web, drive-thru) for channel-level promotion analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of redemption for time-of-day promotion effectiveness analysis."
    - name: "promotion_redemption_status"
      expr: promotion_redemption_status
      comment: "Status of the redemption (completed, voided, pending) for data quality filtering."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Flag indicating whether the redemption was by a loyalty member. Measures loyalty program promotion lift."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of discount amounts for multi-currency normalization."
    - name: "redemption_timestamp"
      expr: DATE_TRUNC('week', redemption_timestamp)
      comment: "Week of redemption for weekly promotion performance trending."
    - name: "is_test_redemption"
      expr: is_test_redemption
      comment: "Flag to exclude test redemptions from production reporting."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of promotion redemptions. Primary volume metric for promotion uptake."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted. Measures the financial cost of promotions."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_value_before_discount AS DOUBLE))
      comment: "Total order value before discount. Baseline for basket size and discount impact analysis."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_value_after_discount AS DOUBLE))
      comment: "Total order value after discount. Net revenue generated through promoted transactions."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Measures promotion generosity and cost per transaction."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied. Tracks promotion depth across redemptions."
    - name: "avg_order_value_before_discount"
      expr: AVG(CAST(order_value_before_discount AS DOUBLE))
      comment: "Average basket size before discount. Measures whether promotions attract high-value guests."
    - name: "discount_as_pct_of_order_value"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(order_value_before_discount AS DOUBLE)), 0), 2)
      comment: "Discount amount as a percentage of pre-discount order value. Measures promotion cost burden on revenue."
    - name: "loyalty_member_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions by loyalty members. Measures loyalty program engagement with promotions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_fund_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing fund contribution metrics tracking franchisee contributions, compliance, and fund health. Used by franchise finance and marketing leadership to manage cooperative marketing funds."
  source: "`vibe_restaurants_v1`.`marketing`.`fund_contribution`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the contribution (received, pending, overdue) for collection management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for financial close accuracy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of contributions for multi-currency fund management."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Contribution period month for time-series fund health trending."
    - name: "payment_date"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for cash flow analysis."
  measures:
    - name: "total_contributions"
      expr: COUNT(1)
      comment: "Total number of contribution records. Baseline for franchisee participation tracking."
    - name: "total_contribution_amount"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total marketing fund contributions received. Primary fund health metric."
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales basis for contribution calculations. Validates contribution rate compliance."
    - name: "avg_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average contribution per record. Benchmarks franchisee contribution levels."
    - name: "avg_contribution_rate"
      expr: AVG(CAST(contribution_rate AS DOUBLE))
      comment: "Average contribution rate applied. Monitors rate compliance across franchisees."
    - name: "effective_contribution_rate"
      expr: ROUND(100.0 * SUM(CAST(contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Actual contribution amount as a percentage of gross sales. Validates contractual rate compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_influencer_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer activation performance metrics measuring engagement, earned media value, and compliance. Used by brand and social media teams to evaluate influencer investment effectiveness."
  source: "`vibe_restaurants_v1`.`marketing`.`influencer_activation`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social platform (Instagram, TikTok, YouTube, etc.) for platform-level influencer performance."
    - name: "activation_type"
      expr: activation_type
      comment: "Type of influencer activation (sponsored post, story, video, etc.)."
    - name: "influencer_category"
      expr: influencer_category
      comment: "Category of influencer (food, lifestyle, family, etc.) for category-level ROI analysis."
    - name: "influencer_region"
      expr: influencer_region
      comment: "Geographic region of the influencer for regional campaign alignment."
    - name: "influencer_activation_status"
      expr: influencer_activation_status
      comment: "Status of the activation (active, completed, cancelled)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "FTC/regulatory compliance status. Critical for legal risk management."
    - name: "content_go_live_date"
      expr: DATE_TRUNC('month', content_go_live_date)
      comment: "Month content went live for time-series influencer performance trending."
    - name: "ftc_disclosure_flag"
      expr: ftc_disclosure_flag
      comment: "Flag indicating FTC disclosure compliance. Regulatory risk dimension."
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total influencer activations. Baseline volume for influencer program scale."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total influencer fees paid. Core investment tracking for influencer marketing budget."
    - name: "total_earned_media_value"
      expr: SUM(CAST(earned_media_value AS DOUBLE))
      comment: "Total earned media value generated. Measures organic amplification value of influencer content."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions generated by influencer content. Reach metric for awareness campaigns."
    - name: "total_actual_likes"
      expr: SUM(CAST(actual_likes AS DOUBLE))
      comment: "Total likes across all activations. Engagement volume metric."
    - name: "total_actual_comments"
      expr: SUM(CAST(actual_comments AS DOUBLE))
      comment: "Total comments across all activations. Deeper engagement quality metric."
    - name: "avg_engagement_rate"
      expr: AVG(CAST(influencer_engagement_rate AS DOUBLE))
      comment: "Average influencer engagement rate. Primary quality metric for influencer selection and evaluation."
    - name: "earned_media_value_per_spend_dollar"
      expr: ROUND(SUM(CAST(earned_media_value AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Earned media value generated per dollar of influencer spend. Compound efficiency ratio for influencer ROI."
    - name: "ftc_non_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ftc_disclosure_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activations without FTC disclosure. Legal compliance risk KPI requiring immediate action if elevated."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_local_store_marketing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local store marketing (LSM) performance metrics tracking spend efficiency, sales lift, and fund utilization at the unit level. Used by field marketing and franchise operations to optimize local marketing investment."
  source: "`vibe_restaurants_v1`.`marketing`.`local_store_marketing`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of LSM initiative (sponsorship, community event, local media, etc.)."
    - name: "channel"
      expr: channel
      comment: "Channel used for the local marketing initiative."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic LSM performance comparison."
    - name: "local_store_marketing_status"
      expr: local_store_marketing_status
      comment: "Status of the LSM initiative (active, completed, cancelled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for compliance and governance tracking."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the LSM initiative started for time-series trending."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the initiative meets brand compliance standards."
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total LSM initiatives. Baseline for local marketing activity volume."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual LSM spend. Core investment tracking metric."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned LSM spend. Budget baseline for variance analysis."
    - name: "total_lmf_fund_used"
      expr: SUM(CAST(lmf_fund_used AS DOUBLE))
      comment: "Total local marketing fund (LMF) dollars utilized. Measures fund utilization efficiency."
    - name: "total_lmf_remaining_amount"
      expr: SUM(CAST(lmf_remaining_amount AS DOUBLE))
      comment: "Total remaining LMF balance. Identifies under-utilized marketing fund capacity."
    - name: "lmf_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(lmf_fund_used AS DOUBLE)) / NULLIF(SUM(CAST(lmf_fund_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated LMF funds actually utilized. Measures local marketing fund efficiency."
    - name: "spend_variance_amount"
      expr: SUM(CAST(actual_spend AS DOUBLE) - CAST(planned_spend AS DOUBLE))
      comment: "Total variance between actual and planned LSM spend. Signals budget discipline issues."
    - name: "avg_actual_comp_sales_lift_percent"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comp sales lift from LSM initiatives. Revenue effectiveness of local marketing."
    - name: "avg_actual_adt_lift_percent"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual ADT lift from LSM initiatives. Traffic-driving effectiveness of local marketing."
    - name: "active_unit_count"
      expr: COUNT(DISTINCT local_unit_id)
      comment: "Number of distinct restaurant units with active LSM initiatives. Measures local marketing program reach."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_ad_creative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad creative portfolio metrics tracking production investment, ROI estimates, and creative lifecycle. Used by creative and brand teams to manage creative asset efficiency and compliance."
  source: "`vibe_restaurants_v1`.`marketing`.`ad_creative`"
  dimensions:
    - name: "creative_type"
      expr: creative_type
      comment: "Type of creative asset (video, static, animated, etc.) for format-level performance analysis."
    - name: "creative_category"
      expr: creative_category
      comment: "Business category of the creative (LTO, brand, seasonal, etc.)."
    - name: "ad_creative_status"
      expr: ad_creative_status
      comment: "Current status of the creative (active, archived, in-review)."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance review status. Critical for brand integrity management."
    - name: "legal_approval_status"
      expr: legal_approval_status
      comment: "Legal approval status. Required for regulatory compliance tracking."
    - name: "language"
      expr: language
      comment: "Language of the creative for multilingual market analysis."
    - name: "channel_suitability"
      expr: channel_suitability
      comment: "Channels the creative is approved for use on."
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Flag indicating dynamic/personalized creative for dynamic vs static performance comparison."
    - name: "approved_timestamp"
      expr: DATE_TRUNC('month', approved_timestamp)
      comment: "Month of creative approval for production pipeline trending."
  measures:
    - name: "total_creatives"
      expr: COUNT(1)
      comment: "Total creative assets in portfolio. Baseline for creative library management."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost AS DOUBLE))
      comment: "Total creative production investment. Core cost metric for creative budget management."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to creative assets. Investment commitment tracking."
    - name: "avg_production_cost"
      expr: AVG(CAST(production_cost AS DOUBLE))
      comment: "Average production cost per creative. Benchmarks creative production efficiency."
    - name: "total_roi_estimate"
      expr: SUM(CAST(roi_estimate AS DOUBLE))
      comment: "Total estimated ROI across creative portfolio. Forward-looking investment value metric."
    - name: "avg_roi_estimate"
      expr: AVG(CAST(roi_estimate AS DOUBLE))
      comment: "Average estimated ROI per creative. Prioritization metric for creative investment decisions."
    - name: "brand_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of creatives with approved brand compliance status. Brand integrity risk KPI."
    - name: "archived_creative_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_archived = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of archived creatives. Measures creative portfolio freshness and lifecycle management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_lto`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limited-time offer (LTO) marketing performance metrics tracking revenue targets, sales lift, and promotional pricing. Used by brand and menu strategy teams to evaluate LTO effectiveness."
  source: "`vibe_restaurants_v1`.`marketing`.`marketing_lto`"
  dimensions:
    - name: "lto_status"
      expr: lto_status
      comment: "Current status of the LTO (active, completed, cancelled)."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the LTO is currently active."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the LTO launched for time-series LTO performance trending."
    - name: "end_date"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the LTO ended for duration and seasonality analysis."
    - name: "featured_item"
      expr: featured_item
      comment: "Featured menu item for item-level LTO performance comparison."
  measures:
    - name: "total_ltos"
      expr: COUNT(1)
      comment: "Total LTO records. Baseline for LTO pipeline volume management."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total marketing budget allocated to LTOs. Investment tracking for LTO program."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue AS DOUBLE))
      comment: "Total target revenue across LTOs. Revenue goal baseline for LTO program."
    - name: "total_target_sales_amount"
      expr: SUM(CAST(target_sales_amount AS DOUBLE))
      comment: "Total target sales amount across LTOs. Sales goal tracking metric."
    - name: "avg_promo_price"
      expr: AVG(CAST(promo_price AS DOUBLE))
      comment: "Average promotional price point across LTOs. Pricing strategy benchmark."
    - name: "avg_projected_lift_percent"
      expr: AVG(CAST(projected_lift_percent AS DOUBLE))
      comment: "Average projected sales lift percentage. Forward-looking LTO effectiveness expectation."
    - name: "avg_target_lift_pct"
      expr: AVG(CAST(target_lift_pct AS DOUBLE))
      comment: "Average target lift percentage set for LTOs. Goal-setting benchmark for LTO program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for marketing campaigns, combining budget, spend and lift metrics."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the campaign."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., digital, TV)."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign."
    - name: "owning_brand"
      expr: owning_brand
      comment: "Brand owning the campaign."
    - name: "target_market"
      expr: target_market
      comment: "Target market for the campaign."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total allocated budget for the campaign."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Actual spend incurred."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_pct AS DOUBLE))
      comment: "Average actual ADT lift percentage."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_pct AS DOUBLE))
      comment: "Average actual comparable sales lift percentage."
    - name: "is_lto_flag"
      expr: MAX(CASE WHEN is_lto THEN 1 ELSE 0 END)
      comment: "Indicates if campaign is a limited-time offer (1) or not (0)."
$$;