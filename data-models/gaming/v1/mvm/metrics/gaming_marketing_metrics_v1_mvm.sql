-- Metric views for domain: marketing | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core campaign performance metrics tracking spend efficiency, reach, engagement, and conversion across channels and campaigns"
  source: "`gaming_ecm`.`marketing`.`campaign_spend`"
  dimensions:
    - name: "spend_date"
      expr: spend_date
      comment: "Date of the spend record"
    - name: "spend_month"
      expr: DATE_TRUNC('MONTH', spend_date)
      comment: "Month of spend for monthly aggregation"
    - name: "spend_quarter"
      expr: DATE_TRUNC('QUARTER', spend_date)
      comment: "Quarter of spend for quarterly business reviews"
    - name: "channel"
      expr: channel
      comment: "Marketing channel (paid social, display, search, etc.)"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Geographic country code for regional performance analysis"
    - name: "is_organic"
      expr: is_organic
      comment: "Whether traffic is organic (true) or paid (false)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of spend reconciliation with ad networks"
    - name: "cohort_date"
      expr: cohort_date
      comment: "Cohort date for cohort-based analysis"
  measures:
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total marketing spend across all campaigns and channels"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS BIGINT))
      comment: "Total ad impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS BIGINT))
      comment: "Total ad clicks received"
    - name: "total_installs"
      expr: SUM(CAST(installs AS BIGINT))
      comment: "Total game installs attributed to campaigns"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click"
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average cost per install - key user acquisition efficiency metric"
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate as a percentage"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate from impression to install"
    - name: "total_discrepancy_amount"
      expr: SUM(CAST(discrepancy_amount AS DOUBLE))
      comment: "Total discrepancy between reported and reconciled spend - financial control metric"
    - name: "campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns active in the period"
    - name: "ad_network_count"
      expr: COUNT(DISTINCT ad_network_id)
      comment: "Number of distinct ad networks used"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_user_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "User acquisition and attribution metrics tracking install quality, fraud, and first-payment conversion"
  source: "`gaming_ecm`.`marketing`.`attribution_record`"
  dimensions:
    - name: "install_date"
      expr: DATE_TRUNC('DAY', install_timestamp)
      comment: "Date of install for daily cohort analysis"
    - name: "install_month"
      expr: DATE_TRUNC('MONTH', install_timestamp)
      comment: "Month of install for monthly cohort tracking"
    - name: "attribution_type"
      expr: attribution_type
      comment: "Type of attribution (click, impression, view-through)"
    - name: "media_source"
      expr: media_source
      comment: "Media source driving the install"
    - name: "channel"
      expr: channel
      comment: "Marketing channel"
    - name: "country_code"
      expr: country_code
      comment: "Country of the user"
    - name: "platform"
      expr: platform
      comment: "Platform (iOS, Android, etc.)"
    - name: "device_type"
      expr: device_type
      comment: "Device type (phone, tablet, etc.)"
    - name: "is_organic"
      expr: is_organic
      comment: "Whether install is organic or paid"
    - name: "fraud_rejection_flag"
      expr: fraud_rejection_flag
      comment: "Whether install was flagged as fraudulent"
    - name: "install_type"
      expr: install_type
      comment: "Type of install (new, reinstall, etc.)"
  measures:
    - name: "total_installs"
      expr: COUNT(1)
      comment: "Total number of attributed installs"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Unique players acquired"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cpi_usd AS DOUBLE))
      comment: "Total cost of user acquisition in USD"
    - name: "avg_cpi"
      expr: AVG(CAST(cpi_usd AS DOUBLE))
      comment: "Average cost per install - key efficiency metric"
    - name: "fraud_rate"
      expr: AVG(CASE WHEN fraud_rejection_flag = true THEN 1.0 ELSE 0.0 END)
      comment: "Percentage of installs flagged as fraudulent - quality control metric"
    - name: "organic_rate"
      expr: AVG(CASE WHEN is_organic = true THEN 1.0 ELSE 0.0 END)
      comment: "Percentage of installs that are organic"
    - name: "paying_user_count"
      expr: COUNT(DISTINCT CASE WHEN payment_id IS NOT NULL THEN player_account_id END)
      comment: "Number of users who made their first payment"
    - name: "unique_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns driving installs"
    - name: "unique_ad_networks"
      expr: COUNT(DISTINCT ad_network_id)
      comment: "Number of distinct ad networks used"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_retention_cohort`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cohort retention and lifetime value metrics for measuring long-term user quality and ROAS"
  source: "`gaming_ecm`.`marketing`.`retention_cohort`"
  dimensions:
    - name: "install_date"
      expr: install_date
      comment: "Install date defining the cohort"
    - name: "install_month"
      expr: DATE_TRUNC('MONTH', install_date)
      comment: "Install month for monthly cohort analysis"
    - name: "install_quarter"
      expr: DATE_TRUNC('QUARTER', install_date)
      comment: "Install quarter for quarterly business reviews"
    - name: "attribution_channel"
      expr: attribution_channel
      comment: "Channel that acquired the cohort"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source that acquired the cohort"
    - name: "country_code"
      expr: country_code
      comment: "Country of the cohort"
    - name: "cohort_status"
      expr: cohort_status
      comment: "Status of the cohort (active, mature, archived)"
    - name: "is_soft_launch"
      expr: is_soft_launch
      comment: "Whether cohort was acquired during soft launch"
  measures:
    - name: "total_cohort_size"
      expr: SUM(CAST(cohort_size AS BIGINT))
      comment: "Total users in cohorts"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total cost to acquire all cohorts"
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average cost per install across cohorts"
    - name: "avg_d1_retention_rate"
      expr: AVG(CAST(d1_retention_rate AS DOUBLE))
      comment: "Average day-1 retention rate - early engagement indicator"
    - name: "avg_d7_retention_rate"
      expr: AVG(CAST(d7_retention_rate AS DOUBLE))
      comment: "Average day-7 retention rate - key product-market fit metric"
    - name: "avg_d30_retention_rate"
      expr: AVG(CAST(d30_retention_rate AS DOUBLE))
      comment: "Average day-30 retention rate - long-term engagement metric"
    - name: "avg_d60_retention_rate"
      expr: AVG(CAST(d60_retention_rate AS DOUBLE))
      comment: "Average day-60 retention rate"
    - name: "avg_d90_retention_rate"
      expr: AVG(CAST(d90_retention_rate AS DOUBLE))
      comment: "Average day-90 retention rate"
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total revenue generated by cohorts"
    - name: "avg_cohort_ltv"
      expr: AVG(CAST(cohort_ltv_estimate AS DOUBLE))
      comment: "Average estimated lifetime value per cohort - strategic investment metric"
    - name: "avg_cohort_arpu"
      expr: AVG(CAST(cohort_arpu AS DOUBLE))
      comment: "Average revenue per user across cohorts"
    - name: "avg_cohort_arppu"
      expr: AVG(CAST(cohort_arppu AS DOUBLE))
      comment: "Average revenue per paying user across cohorts"
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend - primary profitability metric for marketing investment decisions"
    - name: "avg_conversion_to_payer_rate"
      expr: AVG(CAST(conversion_to_payer_rate AS DOUBLE))
      comment: "Average rate of users converting to paying customers - monetization efficiency metric"
    - name: "total_paying_users"
      expr: SUM(CAST(paying_users_count AS BIGINT))
      comment: "Total paying users across cohorts"
    - name: "cohort_count"
      expr: COUNT(1)
      comment: "Number of distinct cohorts"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_campaign_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign budget tracking and variance metrics for financial planning and spend control"
  source: "`gaming_ecm`.`marketing`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the budget"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the budget period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the budget period"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (campaign, title, event, etc.)"
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the budget (draft, approved, active, closed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status"
    - name: "channel"
      expr: channel
      comment: "Marketing channel"
    - name: "geo_region"
      expr: geo_region
      comment: "Geographic region"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial reporting"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend to date"
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining budget available - cash flow planning metric"
    - name: "avg_target_cpi"
      expr: AVG(CAST(target_cpi AS DOUBLE))
      comment: "Average target cost per install"
    - name: "avg_target_roas"
      expr: AVG(CAST(target_roas AS DOUBLE))
      comment: "Average target return on ad spend"
    - name: "avg_target_d7_retention"
      expr: AVG(CAST(target_d7_retention_rate AS DOUBLE))
      comment: "Average target day-7 retention rate"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget line items"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_launch_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game launch performance metrics tracking day-one installs, retention, and launch efficiency against targets"
  source: "`gaming_ecm`.`marketing`.`launch_event`"
  dimensions:
    - name: "scheduled_launch_date"
      expr: scheduled_launch_date
      comment: "Scheduled launch date"
    - name: "actual_launch_date"
      expr: actual_launch_date
      comment: "Actual launch date"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', actual_launch_date)
      comment: "Month of actual launch"
    - name: "launch_quarter"
      expr: DATE_TRUNC('QUARTER', actual_launch_date)
      comment: "Quarter of actual launch"
    - name: "launch_type"
      expr: launch_type
      comment: "Type of launch (global, regional, soft, etc.)"
    - name: "launch_status"
      expr: launch_status
      comment: "Status of the launch"
    - name: "target_platforms"
      expr: target_platforms
      comment: "Platforms targeted for launch"
    - name: "store_featuring_status"
      expr: store_featuring_status
      comment: "Whether the title was featured in app stores"
    - name: "platform_certification_status"
      expr: platform_certification_status
      comment: "Platform certification status"
  measures:
    - name: "total_launch_budget"
      expr: SUM(CAST(launch_budget_usd AS DOUBLE))
      comment: "Total launch marketing budget in USD"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend on launch"
    - name: "total_pre_registration"
      expr: SUM(CAST(pre_registration_count AS BIGINT))
      comment: "Total pre-registrations - early demand indicator"
    - name: "total_day_one_installs"
      expr: SUM(CAST(day_one_actual_installs AS BIGINT))
      comment: "Total day-one installs across launches"
    - name: "total_day_one_target"
      expr: SUM(CAST(day_one_install_target AS BIGINT))
      comment: "Total day-one install targets"
    - name: "avg_day_seven_retention"
      expr: AVG(CAST(day_seven_actual_retention_pct AS DOUBLE))
      comment: "Average day-7 retention percentage - early product quality signal"
    - name: "avg_day_seven_target"
      expr: AVG(CAST(day_seven_retention_target_pct AS DOUBLE))
      comment: "Average day-7 retention target"
    - name: "avg_cpi"
      expr: AVG(CAST(average_cpi_usd AS DOUBLE))
      comment: "Average cost per install during launch"
    - name: "avg_ctr"
      expr: AVG(CAST(average_ctr_pct AS DOUBLE))
      comment: "Average click-through rate during launch"
    - name: "avg_projected_d30_ltv"
      expr: AVG(CAST(projected_d30_ltv_usd AS DOUBLE))
      comment: "Average projected day-30 lifetime value - early monetization forecast"
    - name: "avg_aso_score"
      expr: AVG(CAST(aso_optimization_score AS DOUBLE))
      comment: "Average app store optimization score"
    - name: "launch_count"
      expr: COUNT(1)
      comment: "Number of launch events"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_influencer_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing performance metrics tracking engagement, attribution, and ROI of influencer partnerships"
  source: "`gaming_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of influencer campaigns"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_player_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player segmentation metrics tracking segment size, value, and engagement characteristics for targeted marketing"
  source: "`gaming_ecm`.`marketing`.`player_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the player segment"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, value-based, etc.)"
    - name: "segment_status"
      expr: segment_status
      comment: "Status of the segment (active, deprecated, etc.)"
    - name: "definition_type"
      expr: definition_type
      comment: "How the segment is defined (rule-based, ML, manual, etc.)"
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "Lifetime value tier of the segment"
    - name: "platform_scope"
      expr: platform_scope
      comment: "Platform scope of the segment"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment"
    - name: "segment_priority"
      expr: segment_priority
      comment: "Priority level of the segment for targeting"
    - name: "last_refresh_date"
      expr: last_refresh_date
      comment: "Date segment was last refreshed"
  measures:
    - name: "total_actual_segment_size"
      expr: SUM(CAST(actual_segment_size AS BIGINT))
      comment: "Total actual size of segments"
    - name: "total_estimated_segment_size"
      expr: SUM(CAST(estimated_segment_size AS BIGINT))
      comment: "Total estimated size of segments"
    - name: "avg_arpu"
      expr: AVG(CAST(average_arpu AS DOUBLE))
      comment: "Average revenue per user across segments - segment value metric"
    - name: "avg_arppu"
      expr: AVG(CAST(average_arppu AS DOUBLE))
      comment: "Average revenue per paying user across segments"
    - name: "avg_session_length"
      expr: AVG(CAST(average_session_length_minutes AS DOUBLE))
      comment: "Average session length in minutes - engagement metric"
    - name: "avg_d1_retention"
      expr: AVG(CAST(d1_retention_rate AS DOUBLE))
      comment: "Average day-1 retention rate across segments"
    - name: "avg_d7_retention"
      expr: AVG(CAST(d7_retention_rate AS DOUBLE))
      comment: "Average day-7 retention rate across segments"
    - name: "avg_d30_retention"
      expr: AVG(CAST(d30_retention_rate AS DOUBLE))
      comment: "Average day-30 retention rate across segments"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate to paying user across segments"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score - retention intervention metric"
    - name: "segment_count"
      expr: COUNT(1)
      comment: "Number of player segments"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_audience`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing audience metrics tracking audience size, match rates, and sync health for programmatic targeting"
  source: "`gaming_ecm`.`marketing`.`audience`"
  dimensions:
    - name: "audience_name"
      expr: audience_name
      comment: "Name of the audience"
    - name: "audience_type"
      expr: audience_type
      comment: "Type of audience (custom, lookalike, retargeting, etc.)"
    - name: "audience_status"
      expr: audience_status
      comment: "Status of the audience"
    - name: "platform_scope"
      expr: platform_scope
      comment: "Platform scope (Facebook, Google, etc.)"
    - name: "sync_status"
      expr: sync_status
      comment: "Sync status with ad platform"
    - name: "activation_date"
      expr: activation_date
      comment: "Date audience was activated"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date audience expires"
    - name: "identifier_type"
      expr: identifier_type
      comment: "Type of identifier used (email, device ID, etc.)"
  measures:
    - name: "total_audience_size"
      expr: SUM(CAST(size AS BIGINT))
      comment: "Total size of audiences"
    - name: "total_matched_count"
      expr: SUM(CAST(matched_count AS BIGINT))
      comment: "Total matched users across audiences"
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS BIGINT))
      comment: "Total estimated reach across audiences"
    - name: "avg_match_rate"
      expr: AVG(CAST(match_rate_percentage AS DOUBLE))
      comment: "Average match rate percentage - data quality and targeting precision metric"
    - name: "avg_lookalike_expansion"
      expr: AVG(CAST(lookalike_expansion_percentage AS DOUBLE))
      comment: "Average lookalike expansion percentage"
    - name: "avg_lookalike_seed_size"
      expr: AVG(CAST(lookalike_seed_size AS BIGINT))
      comment: "Average lookalike seed size"
    - name: "avg_d7_retention"
      expr: AVG(CAST(average_d7_retention_rate AS DOUBLE))
      comment: "Average day-7 retention rate of audience members"
    - name: "avg_ltv"
      expr: AVG(CAST(average_ltv_usd AS DOUBLE))
      comment: "Average lifetime value of audience members in USD - audience quality metric"
    - name: "audience_count"
      expr: COUNT(1)
      comment: "Number of audiences"
    - name: "unique_ad_networks"
      expr: COUNT(DISTINCT ad_network_id)
      comment: "Number of unique ad networks audiences are synced to"
$$;
