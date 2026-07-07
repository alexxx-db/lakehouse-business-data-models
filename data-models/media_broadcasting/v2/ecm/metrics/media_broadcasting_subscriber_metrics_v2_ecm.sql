-- Metric views for domain: subscriber | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscriber base KPIs: active subscriber counts, ARPU, LTV, churn risk and engagement for D2C steering."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscriber`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Subscriber account lifecycle status (active, suspended, cancelled)."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier the subscriber is on (e.g. basic, premium)."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cadence of the subscriber (monthly, annual)."
    - name: "country_code"
      expr: country_code
      comment: "Country of the subscriber for geographic segmentation."
    - name: "registration_source"
      expr: registration_source
      comment: "Channel through which the subscriber registered."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month of registration for cohort analysis."
  measures:
    - name: "subscriber_count"
      expr: COUNT(1)
      comment: "Total number of subscribers in scope."
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscriber count for de-duplicated base sizing."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across subscribers — core monetization KPI."
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Aggregate lifetime value of the subscriber base."
    - name: "avg_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average lifetime value per subscriber for cohort value comparison."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average predicted churn risk — leading indicator for retention action."
    - name: "avg_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average viewing hours per subscriber — engagement health metric."
    - name: "marketing_opt_in_count"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN 1 END)
      comment: "Subscribers opted into marketing — addressable base for campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription portfolio KPIs: active subscriptions, recurring revenue (ARPU/LTV), auto-renew and promotional mix."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Lifecycle status of the subscription."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g. standard, trial, gift)."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cadence of the subscription."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel the subscription was acquired through."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subscription pricing."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month the subscription activated for cohort tracking."
  measures:
    - name: "subscription_count"
      expr: COUNT(1)
      comment: "Total subscriptions in scope."
    - name: "active_subscription_count"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN 1 END)
      comment: "Count of active subscriptions — core base KPI."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per subscription."
    - name: "total_base_rate"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Aggregate base rate amount — recurring revenue run-rate proxy."
    - name: "avg_promotional_rate"
      expr: AVG(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Average promotional rate amount on discounted subscriptions."
    - name: "auto_renew_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Subscriptions set to auto-renew — retention stability indicator."
    - name: "promotional_subscription_count"
      expr: COUNT(CASE WHEN promotional_rate_flag = TRUE THEN 1 END)
      comment: "Subscriptions on promotional pricing — discount exposure."
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Aggregate subscription lifetime value."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_churn_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Churn analytics: churn volume, revenue lost, win-back effectiveness and churn prediction for retention steering."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`churn_event`"
  dimensions:
    - name: "churn_type"
      expr: churn_type
      comment: "Voluntary vs involuntary churn classification."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Coded reason for cancellation."
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which the cancellation occurred."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier at the time of churn."
    - name: "churn_month"
      expr: DATE_TRUNC('MONTH', churn_timestamp)
      comment: "Month of churn for trend analysis."
  measures:
    - name: "churn_event_count"
      expr: COUNT(1)
      comment: "Total churn events — core attrition volume metric."
    - name: "churned_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers who churned."
    - name: "total_lost_lifetime_revenue"
      expr: SUM(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Aggregate lifetime revenue lost to churn — quantifies attrition impact."
    - name: "avg_subscription_tenure_at_churn"
      expr: AVG(CAST(subscription_tenure_months AS DOUBLE))
      comment: "Average tenure at churn — loyalty / lifecycle indicator."
    - name: "avg_churn_prediction_score"
      expr: AVG(CAST(churn_prediction_score AS DOUBLE))
      comment: "Average churn prediction score of churned cohort — model validation."
    - name: "win_back_presented_count"
      expr: COUNT(CASE WHEN win_back_offer_presented_flag = TRUE THEN 1 END)
      comment: "Churn events where a win-back offer was presented."
    - name: "win_back_accepted_count"
      expr: COUNT(CASE WHEN win_back_offer_accepted_flag = TRUE THEN 1 END)
      comment: "Churn events where a win-back offer was accepted — recovery effectiveness."
    - name: "competitor_mention_count"
      expr: COUNT(CASE WHEN competitor_service_mentioned_flag = TRUE THEN 1 END)
      comment: "Churns citing a competitor — competitive pressure signal."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan change and MRR movement KPIs: upgrade/downgrade volume, MRR impact and discount exposure."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (upgrade, downgrade, add-on, cancellation)."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason associated with the subscription change."
    - name: "change_channel"
      expr: change_channel
      comment: "Channel where the change was initiated."
    - name: "service_tier_change"
      expr: service_tier_change
      comment: "Direction of service tier change."
    - name: "change_month"
      expr: DATE_TRUNC('MONTH', change_effective_date)
      comment: "Effective month of the change for trend analysis."
  measures:
    - name: "change_count"
      expr: COUNT(1)
      comment: "Total subscription change events."
    - name: "total_mrr_impact"
      expr: SUM(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Net MRR impact from plan changes — core expansion/contraction KPI."
    - name: "total_new_mrr"
      expr: SUM(CAST(new_monthly_recurring_revenue AS DOUBLE))
      comment: "Aggregate new MRR after changes."
    - name: "total_previous_mrr"
      expr: SUM(CAST(previous_monthly_recurring_revenue AS DOUBLE))
      comment: "Aggregate prior MRR before changes — paired with new MRR for net movement."
    - name: "total_discount_applied"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount applied during changes — margin leakage indicator."
    - name: "total_proration"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Aggregate proration amounts from mid-cycle changes."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer / promotion performance KPIs: redemption volume, discount cost, revenue impact and first-time acquisition."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (completed, reversed)."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel where the offer was redeemed."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied in the redemption."
    - name: "attribution_source"
      expr: attribution_source
      comment: "Attribution source for the redemption."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption for campaign trend analysis."
  measures:
    - name: "redemption_count"
      expr: COUNT(1)
      comment: "Total offer redemptions — campaign uptake KPI."
    - name: "total_discount_cost"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount granted — promotional cost."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Aggregate revenue impact of redemptions — promo ROI driver."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered."
    - name: "first_time_subscriber_count"
      expr: COUNT(CASE WHEN first_time_subscriber_flag = TRUE THEN 1 END)
      comment: "Redemptions by first-time subscribers — acquisition contribution."
    - name: "reversed_redemption_count"
      expr: COUNT(CASE WHEN reversal_timestamp IS NOT NULL THEN 1 END)
      comment: "Reversed redemptions — fraud/eligibility leakage indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs: account value, ARPU, churn risk and engagement across the household footprint."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Lifecycle status of the household account."
    - name: "household_type"
      expr: household_type
      comment: "Classification of the household."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the household account."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household for geographic analysis."
    - name: "dma_code"
      expr: dma_code
      comment: "Designated Market Area code for local market segmentation."
  measures:
    - name: "household_count"
      expr: COUNT(1)
      comment: "Total households in scope."
    - name: "avg_arpu"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average revenue per user at household level."
    - name: "total_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Aggregate household lifetime value."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average household lifetime value for cohort comparison."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average household churn risk — proactive retention indicator."
    - name: "marketing_opt_in_count"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN 1 END)
      comment: "Households opted into marketing — addressable base."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_support_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer support operations KPIs: case volume, escalation, churn-linked contacts and retention offers for D2C support steering."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`support_case`"
  dimensions:
    - name: "case_category"
      expr: case_category
      comment: "Category of the support case."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority assigned to the support case."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the support case."
    - name: "channel"
      expr: channel
      comment: "Contact channel of the support case."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied to the case."
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_at)
      comment: "Month the case was opened for trend analysis."
  measures:
    - name: "case_count"
      expr: COUNT(1)
      comment: "Total support cases — contact-centre workload KPI."
    - name: "distinct_subscribers_contacting"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers raising cases — support reach."
    - name: "escalated_case_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Escalated cases — service quality / complexity indicator."
    - name: "churn_related_case_count"
      expr: COUNT(CASE WHEN is_churn_related_flag = TRUE THEN 1 END)
      comment: "Churn-related cases — retention risk signal from support."
    - name: "retention_offer_count"
      expr: COUNT(CASE WHEN retention_offer_made_flag = TRUE THEN 1 END)
      comment: "Cases where a retention offer was made — save-attempt volume."
    - name: "resolved_case_count"
      expr: COUNT(CASE WHEN resolved_at IS NOT NULL THEN 1 END)
      comment: "Resolved cases — used with case_count for resolution rate."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_csat_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voice-of-customer KPIs: CSAT, NPS, effort and sentiment scores driving satisfaction and churn analytics."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`csat_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of satisfaction survey."
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered."
    - name: "survey_status"
      expr: survey_status
      comment: "Completion status of the survey."
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Categorized sentiment of the feedback."
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_timestamp)
      comment: "Month survey was completed for trend tracking."
  measures:
    - name: "survey_count"
      expr: COUNT(1)
      comment: "Total surveys captured."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT score — primary satisfaction KPI."
    - name: "avg_ces_score"
      expr: AVG(CAST(ces_score AS DOUBLE))
      comment: "Average customer effort score — friction indicator."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from feedback analysis."
    - name: "would_recommend_count"
      expr: COUNT(CASE WHEN would_recommend_flag = TRUE THEN 1 END)
      comment: "Respondents who would recommend — advocacy indicator."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Surveys flagged for follow-up — recovery workload."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_device_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device footprint and trust KPIs: registered device volume, fraud risk and offline/HDR capability for streaming experience steering."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`device_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Status of the device registration."
    - name: "registration_source"
      expr: registration_source
      comment: "Source through which the device was registered."
    - name: "drm_security_level"
      expr: drm_security_level
      comment: "DRM security level of the registered device."
    - name: "max_resolution_supported"
      expr: max_resolution_supported
      comment: "Maximum resolution the device supports."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month the device registered for trend analysis."
  measures:
    - name: "device_registration_count"
      expr: COUNT(1)
      comment: "Total registered devices — footprint KPI."
    - name: "distinct_subscribers_with_devices"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers with registered devices."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average device fraud score — account-sharing/abuse indicator."
    - name: "offline_download_enabled_count"
      expr: COUNT(CASE WHEN offline_download_enabled = TRUE THEN 1 END)
      comment: "Devices with offline download — feature adoption."
    - name: "hdr_supported_count"
      expr: COUNT(CASE WHEN hdr_support = TRUE THEN 1 END)
      comment: "HDR-capable devices — premium experience reach."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content entitlement KPIs: active entitlements, ad-free / premium tier mix and trial entitlement exposure."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Status of the entitlement (active, revoked, suspended)."
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement granted."
    - name: "access_level"
      expr: access_level
      comment: "Access level associated with the entitlement."
    - name: "quality_tier"
      expr: quality_tier
      comment: "Quality tier of the entitled content."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective month of the entitlement."
  measures:
    - name: "entitlement_count"
      expr: COUNT(1)
      comment: "Total entitlements in scope."
    - name: "active_entitlement_count"
      expr: COUNT(CASE WHEN entitlement_status = 'active' THEN 1 END)
      comment: "Active entitlements — addressable content access base."
    - name: "distinct_entitled_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers holding entitlements."
    - name: "ad_free_entitlement_count"
      expr: COUNT(CASE WHEN ad_free = TRUE THEN 1 END)
      comment: "Ad-free entitlements — premium monetization mix."
    - name: "trial_entitlement_count"
      expr: COUNT(CASE WHEN trial_entitlement = TRUE THEN 1 END)
      comment: "Trial entitlements — funnel / conversion exposure."
$$;