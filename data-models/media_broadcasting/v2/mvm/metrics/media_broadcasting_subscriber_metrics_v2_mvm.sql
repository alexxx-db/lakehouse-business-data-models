-- Metric views for domain: subscriber | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscriber metrics tracking customer lifetime value, engagement, and churn risk for strategic retention and growth decisions."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscriber`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the subscriber account (active, suspended, cancelled, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier level of the subscriber (basic, premium, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the subscriber for geographic analysis"
    - name: "registration_source"
      expr: registration_source
      comment: "Channel or source through which the subscriber registered"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle frequency for the subscriber (monthly, annual, etc.)"
    - name: "gender"
      expr: gender
      comment: "Gender of the subscriber for demographic segmentation"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred language setting of the subscriber"
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in
      comment: "Whether subscriber has opted in to marketing communications"
    - name: "parental_control_enabled_flag"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on the account"
    - name: "subscription_start_month"
      expr: DATE_TRUNC('MONTH', subscription_start_date)
      comment: "Month when subscription started for cohort analysis"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month when subscriber registered for cohort analysis"
  measures:
    - name: "total_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Total unique subscribers - primary volume metric for subscriber base sizing and growth tracking"
    - name: "total_lifetime_value"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total lifetime value across all subscribers - critical revenue potential metric for investment decisions"
    - name: "avg_lifetime_value"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average lifetime value per subscriber - key metric for customer acquisition cost justification and segment targeting"
    - name: "total_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Total average revenue per user across subscribers - aggregate revenue efficiency metric"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average ARPU per subscriber - critical pricing and monetization effectiveness metric for strategic planning"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score - early warning metric for retention intervention prioritization"
    - name: "high_churn_risk_subscribers"
      expr: COUNT(DISTINCT CASE WHEN CAST(churn_risk_score AS DOUBLE) >= 70 THEN subscriber_id END)
      comment: "Count of subscribers with high churn risk (score >= 70) - actionable metric for immediate retention campaigns"
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all subscribers - engagement volume metric for content investment ROI"
    - name: "avg_viewing_hours_per_subscriber"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average viewing hours per subscriber - engagement intensity metric for content strategy and stickiness assessment"
    - name: "gdpr_consented_subscribers"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_flag = TRUE THEN subscriber_id END)
      comment: "Count of subscribers with GDPR consent - compliance and addressable audience metric for EU marketing"
    - name: "ccpa_opted_out_subscribers"
      expr: COUNT(DISTINCT CASE WHEN ccpa_opt_out_flag = TRUE THEN subscriber_id END)
      comment: "Count of subscribers who opted out under CCPA - privacy compliance and data usage constraint metric"
    - name: "marketing_addressable_subscribers"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN subscriber_id END)
      comment: "Count of subscribers opted in to marketing - addressable audience size for campaign planning and ROI forecasting"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription lifecycle and revenue metrics for tracking recurring revenue health, churn, and subscription economics."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, suspended, trial, etc.)"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (individual, family, student, etc.)"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle frequency (monthly, annual, quarterly)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which subscription was acquired for CAC and channel ROI analysis"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether subscription is set to auto-renew - retention risk indicator"
    - name: "promotional_rate_flag"
      expr: promotional_rate_flag
      comment: "Whether subscription is on promotional pricing - margin and conversion tracking"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for subscription cancellation for churn root cause analysis"
    - name: "cancellation_initiated_by"
      expr: cancellation_initiated_by
      comment: "Who initiated cancellation (subscriber, system, admin) for churn attribution"
    - name: "parental_control_enabled_flag"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled - family segment indicator"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of subscription enrollment for cohort retention analysis"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of subscription activation for time-to-value analysis"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total unique subscriptions - primary volume metric for subscription base sizing and growth tracking"
    - name: "active_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'active' THEN subscription_id END)
      comment: "Count of active subscriptions - core recurring revenue base metric for MRR/ARR calculation"
    - name: "trial_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'trial' THEN subscription_id END)
      comment: "Count of trial subscriptions - conversion pipeline metric for trial-to-paid optimization"
    - name: "cancelled_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'cancelled' THEN subscription_id END)
      comment: "Count of cancelled subscriptions - churn volume metric for retention program effectiveness"
    - name: "total_base_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Total base rate revenue across all subscriptions - core recurring revenue metric for financial planning"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate per subscription - pricing effectiveness metric for revenue optimization"
    - name: "total_promotional_revenue"
      expr: SUM(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Total promotional rate revenue - discounted revenue metric for promotion ROI assessment"
    - name: "total_subscription_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total lifetime value across all subscriptions - long-term revenue potential for investment justification"
    - name: "avg_subscription_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average lifetime value per subscription - customer value metric for acquisition spend optimization"
    - name: "total_subscription_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Total ARPU across all subscriptions - aggregate revenue efficiency metric"
    - name: "avg_subscription_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average ARPU per subscription - monetization effectiveness metric for pricing strategy"
    - name: "auto_renew_enabled_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN subscription_id END)
      comment: "Count of subscriptions with auto-renew enabled - retention stability metric for churn risk assessment"
    - name: "promotional_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN promotional_rate_flag = TRUE THEN subscription_id END)
      comment: "Count of subscriptions on promotional pricing - discount penetration metric for margin analysis"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_churn_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Churn event metrics for analyzing customer attrition patterns, reasons, and financial impact to drive retention strategies."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`churn_event`"
  dimensions:
    - name: "churn_type"
      expr: churn_type
      comment: "Type of churn (voluntary, involuntary, etc.) for root cause segmentation"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Standardized cancellation reason code for churn driver analysis"
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation occurred (web, app, call center) for friction point identification"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier at time of churn for tier-specific retention strategy"
    - name: "competitor_service_mentioned_flag"
      expr: competitor_service_mentioned_flag
      comment: "Whether competitor was mentioned as churn reason - competitive threat indicator"
    - name: "win_back_offer_presented_flag"
      expr: win_back_offer_presented_flag
      comment: "Whether win-back offer was presented - save attempt tracking"
    - name: "win_back_offer_accepted_flag"
      expr: win_back_offer_accepted_flag
      comment: "Whether win-back offer was accepted - save effectiveness metric"
    - name: "promotional_discount_active_flag"
      expr: promotional_discount_active_flag
      comment: "Whether promotional discount was active at churn - price sensitivity indicator"
    - name: "subscription_tenure_months"
      expr: subscription_tenure_months
      comment: "Subscription tenure in months at churn for lifecycle stage analysis"
    - name: "churn_month"
      expr: DATE_TRUNC('MONTH', churn_timestamp)
      comment: "Month of churn event for trend analysis and seasonality detection"
  measures:
    - name: "total_churn_events"
      expr: COUNT(DISTINCT churn_event_id)
      comment: "Total churn events - primary attrition volume metric for churn rate calculation and retention program sizing"
    - name: "unique_churned_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Unique subscribers who churned - distinct customer loss metric for retention impact assessment"
    - name: "total_lost_lifetime_revenue"
      expr: SUM(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue lost from churned subscribers - financial impact metric for retention investment justification"
    - name: "avg_lost_lifetime_revenue"
      expr: AVG(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue lost per churn event - customer value at risk metric for save offer calibration"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total last payment amount from churned subscribers - immediate revenue loss metric"
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average last payment amount per churn - pricing sensitivity indicator for retention offers"
    - name: "avg_churn_prediction_score"
      expr: AVG(CAST(churn_prediction_score AS DOUBLE))
      comment: "Average churn prediction score at time of churn - model calibration metric for predictive accuracy assessment"
    - name: "competitor_driven_churns"
      expr: COUNT(DISTINCT CASE WHEN competitor_service_mentioned_flag = TRUE THEN churn_event_id END)
      comment: "Count of churns mentioning competitor - competitive loss metric for market positioning strategy"
    - name: "win_back_offers_presented"
      expr: COUNT(DISTINCT CASE WHEN win_back_offer_presented_flag = TRUE THEN churn_event_id END)
      comment: "Count of win-back offers presented - save attempt volume for program reach assessment"
    - name: "win_back_offers_accepted"
      expr: COUNT(DISTINCT CASE WHEN win_back_offer_accepted_flag = TRUE THEN churn_event_id END)
      comment: "Count of win-back offers accepted - save success volume for retention program ROI calculation"
    - name: "promotional_discount_active_churns"
      expr: COUNT(DISTINCT CASE WHEN promotional_discount_active_flag = TRUE THEN churn_event_id END)
      comment: "Count of churns with active promotional discount - price elasticity and promotion effectiveness metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics for multi-user account analysis, household value, and family segment strategies."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household account"
    - name: "household_type"
      expr: household_type
      comment: "Type of household (single, family, shared, etc.) for segment targeting"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the household for tier migration analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country code of household for geographic analysis"
    - name: "language_preference"
      expr: language_preference
      comment: "Language preference of household for content localization strategy"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for payment friction and failure analysis"
    - name: "auto_renew_enabled_flag"
      expr: auto_renew_enabled
      comment: "Whether auto-renew is enabled - retention stability indicator"
    - name: "parental_control_enabled_flag"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled - family household indicator"
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in
      comment: "Whether household opted in to marketing - addressable audience flag"
    - name: "account_created_month"
      expr: DATE_TRUNC('MONTH', account_created_date)
      comment: "Month household account was created for cohort analysis"
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households - primary account base metric for household penetration and growth tracking"
    - name: "total_household_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Total lifetime value across all households - aggregate revenue potential for strategic investment decisions"
    - name: "avg_household_lifetime_value"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average lifetime value per household - household value metric for acquisition and retention spend optimization"
    - name: "total_household_arpu"
      expr: SUM(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Total ARPU across all households - aggregate revenue efficiency metric"
    - name: "avg_household_arpu"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average ARPU per household - household monetization effectiveness for pricing and upsell strategy"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average household churn risk score - early warning metric for household retention intervention"
    - name: "high_churn_risk_households"
      expr: COUNT(DISTINCT CASE WHEN CAST(churn_risk_score AS DOUBLE) >= 70 THEN household_id END)
      comment: "Count of households with high churn risk (score >= 70) - actionable at-risk household volume for retention campaigns"
    - name: "auto_renew_enabled_households"
      expr: COUNT(DISTINCT CASE WHEN auto_renew_enabled = TRUE THEN household_id END)
      comment: "Count of households with auto-renew enabled - stable revenue base metric for churn risk assessment"
    - name: "parental_control_enabled_households"
      expr: COUNT(DISTINCT CASE WHEN parental_control_enabled = TRUE THEN household_id END)
      comment: "Count of households with parental controls - family segment size for family content strategy"
    - name: "marketing_addressable_households"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN household_id END)
      comment: "Count of households opted in to marketing - addressable household base for campaign planning"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription plan performance metrics for pricing strategy, plan mix optimization, and product portfolio decisions."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the subscription plan for plan-level analysis"
    - name: "plan_code"
      expr: plan_code
      comment: "Standardized plan code for system integration and reporting"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the plan (active, sunset, draft) for portfolio management"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of plan (standard, promotional, trial, etc.) for plan category analysis"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the plan (basic, premium, etc.) for tier strategy"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, annual) for payment term analysis"
    - name: "ad_supported_flag"
      expr: ad_supported
      comment: "Whether plan is ad-supported - monetization model indicator"
    - name: "promotional_plan_flag"
      expr: promotional_plan
      comment: "Whether plan is promotional - discount plan tracking"
    - name: "trial_eligible_flag"
      expr: trial_eligible
      comment: "Whether plan is eligible for trial - acquisition funnel indicator"
    - name: "download_enabled_flag"
      expr: download_enabled
      comment: "Whether plan allows downloads - feature differentiation indicator"
  measures:
    - name: "total_subscription_plans"
      expr: COUNT(DISTINCT subscription_plan_id)
      comment: "Total unique subscription plans - portfolio size metric for product complexity management"
    - name: "active_subscription_plans"
      expr: COUNT(DISTINCT CASE WHEN plan_status = 'active' THEN subscription_plan_id END)
      comment: "Count of active subscription plans - current portfolio size for plan rationalization decisions"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across plans - portfolio pricing level for competitive positioning"
    - name: "total_target_arpu"
      expr: SUM(CAST(target_arpu AS DOUBLE))
      comment: "Total target ARPU across all plans - aggregate revenue target for financial planning"
    - name: "avg_target_arpu"
      expr: AVG(CAST(target_arpu AS DOUBLE))
      comment: "Average target ARPU per plan - monetization goal metric for pricing strategy validation"
    - name: "total_target_ltv"
      expr: SUM(CAST(target_ltv AS DOUBLE))
      comment: "Total target LTV across all plans - aggregate lifetime value goal for portfolio optimization"
    - name: "avg_target_ltv"
      expr: AVG(CAST(target_ltv AS DOUBLE))
      comment: "Average target LTV per plan - customer value goal for acquisition spend justification"
    - name: "avg_early_termination_fee"
      expr: AVG(CAST(early_termination_fee AS DOUBLE))
      comment: "Average early termination fee - contract enforcement and churn friction metric"
    - name: "ad_supported_plans"
      expr: COUNT(DISTINCT CASE WHEN ad_supported = TRUE THEN subscription_plan_id END)
      comment: "Count of ad-supported plans - ad-funded monetization portfolio size for dual-revenue strategy"
    - name: "promotional_plans"
      expr: COUNT(DISTINCT CASE WHEN promotional_plan = TRUE THEN subscription_plan_id END)
      comment: "Count of promotional plans - discount plan portfolio size for promotion strategy management"
    - name: "trial_eligible_plans"
      expr: COUNT(DISTINCT CASE WHEN trial_eligible = TRUE THEN subscription_plan_id END)
      comment: "Count of trial-eligible plans - trial funnel breadth for acquisition strategy"
    - name: "download_enabled_plans"
      expr: COUNT(DISTINCT CASE WHEN download_enabled = TRUE THEN subscription_plan_id END)
      comment: "Count of plans with download enabled - offline feature availability for feature strategy"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content entitlement metrics for access control effectiveness, authorization patterns, and content access strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement (active, expired, revoked, suspended)"
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (subscription, rental, purchase, promotional) for access model analysis"
    - name: "access_level"
      expr: access_level
      comment: "Level of access granted (full, preview, limited) for tiering strategy"
    - name: "quality_tier"
      expr: quality_tier
      comment: "Quality tier of entitlement (SD, HD, 4K) for quality differentiation analysis"
    - name: "ad_free_flag"
      expr: ad_free
      comment: "Whether entitlement is ad-free - premium feature indicator"
    - name: "download_enabled_flag"
      expr: download_enabled
      comment: "Whether download is enabled - offline access feature indicator"
    - name: "trial_entitlement_flag"
      expr: trial_entitlement
      comment: "Whether entitlement is trial - trial conversion tracking"
    - name: "early_access_enabled_flag"
      expr: early_access_enabled
      comment: "Whether early access is enabled - premium windowing indicator"
    - name: "auto_renew_flag"
      expr: auto_renew
      comment: "Whether entitlement auto-renews - retention stability indicator"
    - name: "grant_reason"
      expr: grant_reason
      comment: "Reason entitlement was granted (subscription, promotion, compensation) for access attribution"
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total unique entitlements - access grant volume for content access breadth and authorization system load"
    - name: "active_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'active' THEN entitlement_id END)
      comment: "Count of active entitlements - current access base for content consumption potential and rights utilization"
    - name: "expired_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'expired' THEN entitlement_id END)
      comment: "Count of expired entitlements - access loss volume for renewal opportunity sizing"
    - name: "revoked_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'revoked' THEN entitlement_id END)
      comment: "Count of revoked entitlements - access removal volume for compliance and fraud impact assessment"
    - name: "unique_entitled_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Unique subscribers with entitlements - entitled user base for content reach and engagement potential"
    - name: "ad_free_entitlements"
      expr: COUNT(DISTINCT CASE WHEN ad_free = TRUE THEN entitlement_id END)
      comment: "Count of ad-free entitlements - premium access volume for ad-free monetization and user experience strategy"
    - name: "download_enabled_entitlements"
      expr: COUNT(DISTINCT CASE WHEN download_enabled = TRUE THEN entitlement_id END)
      comment: "Count of entitlements with download enabled - offline access volume for feature adoption and storage planning"
    - name: "trial_entitlements"
      expr: COUNT(DISTINCT CASE WHEN trial_entitlement = TRUE THEN entitlement_id END)
      comment: "Count of trial entitlements - trial access volume for conversion funnel sizing and trial program effectiveness"
    - name: "early_access_entitlements"
      expr: COUNT(DISTINCT CASE WHEN early_access_enabled = TRUE THEN entitlement_id END)
      comment: "Count of early access entitlements - premium windowing volume for release strategy and VIP program sizing"
    - name: "auto_renew_entitlements"
      expr: COUNT(DISTINCT CASE WHEN auto_renew = TRUE THEN entitlement_id END)
      comment: "Count of auto-renewing entitlements - stable access base for recurring revenue predictability"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_viewer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewer profile metrics for personalization effectiveness, multi-profile household analysis, and user engagement patterns."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the viewer profile (active, inactive, deleted)"
    - name: "profile_type"
      expr: profile_type
      comment: "Type of profile (adult, child, guest) for audience segmentation"
    - name: "is_kids_profile_flag"
      expr: is_kids_profile
      comment: "Whether profile is designated for kids - child audience indicator"
    - name: "is_default_profile_flag"
      expr: is_default_profile
      comment: "Whether profile is the default - primary user indicator"
    - name: "language_preference"
      expr: language_preference
      comment: "Language preference of the profile for content localization"
    - name: "video_quality_preference"
      expr: video_quality_preference
      comment: "Video quality preference (auto, high, low) for bandwidth and quality strategy"
    - name: "autoplay_enabled_flag"
      expr: autoplay_enabled
      comment: "Whether autoplay is enabled - engagement feature adoption"
    - name: "personalization_enabled_flag"
      expr: personalization_enabled
      comment: "Whether personalization is enabled - recommendation system reach"
    - name: "viewing_history_enabled_flag"
      expr: viewing_history_enabled
      comment: "Whether viewing history is enabled - data collection consent indicator"
    - name: "download_enabled_flag"
      expr: download_enabled
      comment: "Whether downloads are enabled - offline feature adoption"
  measures:
    - name: "total_viewer_profiles"
      expr: COUNT(DISTINCT viewer_profile_id)
      comment: "Total unique viewer profiles - profile proliferation metric for multi-user household penetration and personalization scale"
    - name: "active_viewer_profiles"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN viewer_profile_id END)
      comment: "Count of active viewer profiles - engaged profile base for personalization effectiveness and content targeting"
    - name: "unique_subscribers_with_profiles"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Unique subscribers with viewer profiles - profile adoption rate denominator for multi-profile strategy assessment"
    - name: "kids_profiles"
      expr: COUNT(DISTINCT CASE WHEN is_kids_profile = TRUE THEN viewer_profile_id END)
      comment: "Count of kids profiles - child audience size for kids content strategy and parental control effectiveness"
    - name: "default_profiles"
      expr: COUNT(DISTINCT CASE WHEN is_default_profile = TRUE THEN viewer_profile_id END)
      comment: "Count of default profiles - primary user profile volume for household structure analysis"
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all profiles - aggregate engagement volume for content ROI and infrastructure planning"
    - name: "avg_viewing_hours_per_profile"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average viewing hours per profile - per-profile engagement intensity for personalization effectiveness and content stickiness"
    - name: "personalization_enabled_profiles"
      expr: COUNT(DISTINCT CASE WHEN personalization_enabled = TRUE THEN viewer_profile_id END)
      comment: "Count of profiles with personalization enabled - recommendation system reach for algorithm effectiveness assessment"
    - name: "viewing_history_enabled_profiles"
      expr: COUNT(DISTINCT CASE WHEN viewing_history_enabled = TRUE THEN viewer_profile_id END)
      comment: "Count of profiles with viewing history enabled - data collection consent base for analytics and personalization data availability"
    - name: "autoplay_enabled_profiles"
      expr: COUNT(DISTINCT CASE WHEN autoplay_enabled = TRUE THEN viewer_profile_id END)
      comment: "Count of profiles with autoplay enabled - engagement feature adoption for binge-watching optimization"
    - name: "download_enabled_profiles"
      expr: COUNT(DISTINCT CASE WHEN download_enabled = TRUE THEN viewer_profile_id END)
      comment: "Count of profiles with downloads enabled - offline feature adoption for mobile strategy and storage planning"
$$;