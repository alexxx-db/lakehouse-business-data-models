-- Metric views for domain: subscriber | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:10:12

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscription lifecycle and revenue metrics for active and churned subscriptions, enabling analysis of ARPU, LTV, retention, and subscription health by plan, channel, platform, and renewal behavior."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, suspended, trial, etc.)"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type classification of subscription (individual, family, student, corporate, etc.)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscription was acquired (web, mobile app, partner, retail, etc.)"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the subscription is set to automatically renew at term end"
    - name: "promotional_rate_flag"
      expr: promotional_rate_flag
      comment: "Whether the subscription is currently on a promotional rate"
    - name: "cancellation_initiated_by"
      expr: cancellation_initiated_by
      comment: "Who initiated cancellation (subscriber, system, admin, partner, etc.)"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason code or description for subscription cancellation"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month when the subscription was enrolled, for cohort analysis"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year when the subscription was enrolled"
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
      comment: "Month when the subscription was cancelled"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the subscription is billed"
    - name: "contract_term_months"
      expr: contract_term_months
      comment: "Length of the subscription contract term in months"
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on this subscription"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscription records"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers across all subscriptions"
    - name: "total_subscription_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Sum of base subscription rates across all subscriptions"
    - name: "total_promotional_revenue"
      expr: SUM(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Sum of promotional rates for subscriptions on promotional pricing"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across subscriptions"
    - name: "avg_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average lifetime value per subscription"
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total lifetime value across all subscriptions"
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renew_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions with auto-renew enabled"
    - name: "promotional_subscription_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN promotional_rate_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions currently on promotional pricing"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN cancellation_date IS NOT NULL THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_churn_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Churn analysis metrics tracking subscriber attrition, reasons, lifetime value lost, and win-back effectiveness to inform retention strategies and reduce revenue leakage."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`churn_event`"
  dimensions:
    - name: "churn_type"
      expr: churn_type
      comment: "Type of churn event (voluntary, involuntary, payment failure, competitive, etc.)"
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation was processed (web, mobile, call center, email, etc.)"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Standardized reason code for cancellation"
    - name: "cancellation_reason_description"
      expr: cancellation_reason_description
      comment: "Detailed description of cancellation reason"
    - name: "competitor_service_mentioned_flag"
      expr: competitor_service_mentioned_flag
      comment: "Whether a competitor service was mentioned as reason for churn"
    - name: "win_back_offer_presented_flag"
      expr: win_back_offer_presented_flag
      comment: "Whether a win-back offer was presented to the churning subscriber"
    - name: "win_back_offer_accepted_flag"
      expr: win_back_offer_accepted_flag
      comment: "Whether the win-back offer was accepted by the subscriber"
    - name: "promotional_discount_active_flag"
      expr: promotional_discount_active_flag
      comment: "Whether a promotional discount was active at time of churn"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the subscription at time of churn"
    - name: "churn_month"
      expr: DATE_TRUNC('MONTH', churn_timestamp)
      comment: "Month when churn occurred, for trend analysis"
    - name: "churn_year"
      expr: YEAR(churn_timestamp)
      comment: "Year when churn occurred"
    - name: "subscription_tenure_months"
      expr: subscription_tenure_months
      comment: "Number of months the subscriber was active before churning"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for revenue metrics"
  measures:
    - name: "total_churn_events"
      expr: COUNT(1)
      comment: "Total number of churn events"
    - name: "unique_churned_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers who churned"
    - name: "total_lifetime_revenue_lost"
      expr: SUM(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue lost from churned subscribers"
    - name: "avg_lifetime_revenue_lost"
      expr: AVG(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue lost per churn event"
    - name: "avg_churn_prediction_score"
      expr: AVG(CAST(churn_prediction_score AS DOUBLE))
      comment: "Average churn prediction score across churn events"
    - name: "win_back_offer_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN win_back_offer_accepted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN win_back_offer_presented_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of win-back offers that were accepted by churning subscribers"
    - name: "competitor_driven_churn_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN competitor_service_mentioned_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of churn events where a competitor was mentioned"
    - name: "promotional_churn_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN promotional_discount_active_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of churn events that occurred while a promotional discount was active"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber-level engagement, value, and risk metrics tracking ARPU, LTV, churn risk, viewing behavior, and compliance status to support retention and personalization strategies."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscriber`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the subscriber account (active, suspended, cancelled, trial, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the subscriber (basic, standard, premium, etc.)"
    - name: "registration_source"
      expr: registration_source
      comment: "Source through which the subscriber registered (web, mobile, partner, etc.)"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the subscriber (monthly, annual, quarterly, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the subscriber"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred language setting for the subscriber"
    - name: "gender"
      expr: gender
      comment: "Gender of the subscriber"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the subscriber has opted in to marketing communications"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether the subscriber has provided GDPR consent"
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether the subscriber has opted out under CCPA"
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on the subscriber account"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month when the subscriber registered, for cohort analysis"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year when the subscriber registered"
    - name: "subscription_start_month"
      expr: DATE_TRUNC('MONTH', subscription_start_date)
      comment: "Month when the subscriber's subscription started"
  measures:
    - name: "total_subscribers"
      expr: COUNT(1)
      comment: "Total number of subscriber records"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across all subscribers"
    - name: "total_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Total ARPU across all subscribers"
    - name: "avg_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average lifetime value per subscriber"
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total lifetime value across all subscribers"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across subscribers"
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all subscribers"
    - name: "avg_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average viewing hours per subscriber"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscribers who have opted in to marketing"
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscribers who have provided GDPR consent"
    - name: "ccpa_opt_out_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ccpa_opt_out_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscribers who have opted out under CCPA"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption effectiveness metrics tracking conversion, discount impact, revenue effect, and attribution to optimize promotional strategies and acquisition spend."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (successful, failed, pending, reversed, etc.)"
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed (web, mobile, partner, retail, etc.)"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Marketing attribution source for the redemption"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, fixed amount, trial extension, etc.)"
    - name: "eligibility_verified_flag"
      expr: eligibility_verified_flag
      comment: "Whether eligibility was verified before redemption"
    - name: "first_time_subscriber_flag"
      expr: first_time_subscriber_flag
      comment: "Whether the redeemer was a first-time subscriber"
    - name: "terms_accepted_flag"
      expr: terms_accepted_flag
      comment: "Whether the subscriber accepted the offer terms"
    - name: "redemption_device_type"
      expr: redemption_device_type
      comment: "Type of device used for redemption (mobile, desktop, tablet, smart TV, etc.)"
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month when the offer was redeemed"
    - name: "redemption_year"
      expr: YEAR(redemption_timestamp)
      comment: "Year when the offer was redeemed"
    - name: "discount_duration_months"
      expr: discount_duration_months
      comment: "Duration of the discount in months"
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of offer redemption events"
    - name: "unique_subscribers_redeeming"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers who redeemed offers"
    - name: "unique_offers_redeemed"
      expr: COUNT(DISTINCT offer_id)
      comment: "Distinct count of offers that were redeemed"
    - name: "total_discount_amount"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all redemptions"
    - name: "avg_discount_amount"
      expr: AVG(CAST(applied_discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across redemptions"
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact (positive or negative) from offer redemptions"
    - name: "avg_revenue_impact"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per redemption"
    - name: "redemption_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN redemption_status = 'successful' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemption attempts that were successful"
    - name: "first_time_subscriber_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN first_time_subscriber_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions by first-time subscribers"
    - name: "terms_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN terms_accepted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions where terms were accepted"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level value and engagement metrics tracking ARPU, LTV, churn risk, device usage, and payment behavior to support family plan optimization and retention."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household account (active, suspended, cancelled, trial, etc.)"
    - name: "household_type"
      expr: household_type
      comment: "Type of household (single, family, shared, student, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the household subscription"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the household"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the household"
    - name: "dma_code"
      expr: dma_code
      comment: "Designated Market Area code for the household"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for the household"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method used by the household"
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Whether auto-renewal is enabled for the household"
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled for the household"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the household has opted in to marketing"
    - name: "data_sharing_consent"
      expr: data_sharing_consent
      comment: "Whether the household has consented to data sharing"
    - name: "account_created_month"
      expr: DATE_TRUNC('MONTH', account_created_date)
      comment: "Month when the household account was created"
    - name: "account_created_year"
      expr: YEAR(account_created_date)
      comment: "Year when the household account was created"
    - name: "household_size"
      expr: size
      comment: "Number of members in the household"
  measures:
    - name: "total_households"
      expr: COUNT(1)
      comment: "Total number of household accounts"
    - name: "unique_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Distinct count of households"
    - name: "avg_arpu"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average revenue per user across households"
    - name: "total_arpu"
      expr: SUM(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Total ARPU across all households"
    - name: "avg_ltv"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average lifetime value per household"
    - name: "total_ltv"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Total lifetime value across all households"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across households"
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renew_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households with auto-renewal enabled"
    - name: "parental_control_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN parental_control_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households with parental controls enabled"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households opted in to marketing"
    - name: "data_sharing_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_sharing_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households that have consented to data sharing"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content entitlement and access control metrics tracking authorization patterns, concurrent usage, download behavior, and compliance to optimize content delivery and rights management."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement (active, expired, suspended, revoked, etc.)"
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (subscription, rental, purchase, promotional, etc.)"
    - name: "access_level"
      expr: access_level
      comment: "Level of access granted (full, preview, limited, etc.)"
    - name: "quality_tier"
      expr: quality_tier
      comment: "Quality tier of content access (SD, HD, 4K, etc.)"
    - name: "ad_free"
      expr: ad_free
      comment: "Whether the entitlement includes ad-free viewing"
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether offline download is enabled for this entitlement"
    - name: "early_access_enabled"
      expr: early_access_enabled
      comment: "Whether early access to content is enabled"
    - name: "trial_entitlement"
      expr: trial_entitlement
      comment: "Whether this is a trial entitlement"
    - name: "auto_renew"
      expr: auto_renew
      comment: "Whether the entitlement auto-renews"
    - name: "blackout_exempt"
      expr: blackout_exempt
      comment: "Whether the entitlement is exempt from blackout restrictions"
    - name: "grant_reason"
      expr: grant_reason
      comment: "Reason the entitlement was granted (subscription, purchase, promotion, etc.)"
    - name: "revocation_reason"
      expr: revocation_reason
      comment: "Reason the entitlement was revoked, if applicable"
    - name: "activated_month"
      expr: DATE_TRUNC('MONTH', activated_timestamp)
      comment: "Month when the entitlement was activated"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the entitlement became effective"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month when the entitlement expires"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total number of entitlement records"
    - name: "unique_subscribers_entitled"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with entitlements"
    - name: "unique_titles_entitled"
      expr: COUNT(DISTINCT title_id)
      comment: "Distinct count of titles for which entitlements exist"
    - name: "ad_free_entitlement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ad_free = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements that are ad-free"
    - name: "download_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN download_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements with download enabled"
    - name: "early_access_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN early_access_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements with early access enabled"
    - name: "trial_entitlement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN trial_entitlement = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements that are trial-based"
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renew = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements set to auto-renew"
    - name: "blackout_exempt_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN blackout_exempt = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements exempt from blackout restrictions"
    - name: "revoked_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN revoked_timestamp IS NOT NULL THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that have been revoked"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_viewer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewer profile engagement and personalization metrics tracking viewing hours, content preferences, privacy settings, and profile usage to optimize recommendation and UX strategies."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the viewer profile (active, inactive, suspended, etc.)"
    - name: "profile_type"
      expr: profile_type
      comment: "Type of viewer profile (adult, child, guest, etc.)"
    - name: "is_kids_profile"
      expr: is_kids_profile
      comment: "Whether this is a kids profile with age-appropriate content restrictions"
    - name: "is_default_profile"
      expr: is_default_profile
      comment: "Whether this is the default profile for the subscriber"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for the viewer profile"
    - name: "audio_language"
      expr: audio_language
      comment: "Preferred audio language"
    - name: "subtitle_language"
      expr: subtitle_language
      comment: "Preferred subtitle language"
    - name: "video_quality_preference"
      expr: video_quality_preference
      comment: "Preferred video quality setting (auto, SD, HD, 4K, etc.)"
    - name: "autoplay_enabled"
      expr: autoplay_enabled
      comment: "Whether autoplay is enabled for this profile"
    - name: "autoplay_previews_enabled"
      expr: autoplay_previews_enabled
      comment: "Whether autoplay previews are enabled"
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether offline downloads are enabled for this profile"
    - name: "personalization_enabled"
      expr: personalization_enabled
      comment: "Whether personalization and recommendations are enabled"
    - name: "viewing_history_enabled"
      expr: viewing_history_enabled
      comment: "Whether viewing history tracking is enabled"
    - name: "pin_enabled"
      expr: pin_enabled
      comment: "Whether PIN protection is enabled for this profile"
    - name: "marketing_consent"
      expr: marketing_consent
      comment: "Whether the profile has consented to marketing"
    - name: "data_saver_mode"
      expr: data_saver_mode
      comment: "Whether data saver mode is enabled"
    - name: "last_platform"
      expr: last_platform
      comment: "Last platform used to access this profile"
  measures:
    - name: "total_viewer_profiles"
      expr: COUNT(1)
      comment: "Total number of viewer profiles"
    - name: "unique_subscribers_with_profiles"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers who have viewer profiles"
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all profiles"
    - name: "avg_viewing_hours_per_profile"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average viewing hours per viewer profile"
    - name: "kids_profile_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_kids_profile = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles that are kids profiles"
    - name: "autoplay_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN autoplay_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with autoplay enabled"
    - name: "download_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN download_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with downloads enabled"
    - name: "personalization_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN personalization_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with personalization enabled"
    - name: "viewing_history_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN viewing_history_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with viewing history tracking enabled"
    - name: "pin_protection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pin_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with PIN protection enabled"
    - name: "data_saver_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_saver_mode = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles using data saver mode"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_device_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device registration and usage metrics tracking device types, platform distribution, fraud risk, concurrent limits, and offline capabilities to optimize device management and security."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`device_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the device registration (active, deregistered, suspended, etc.)"
    - name: "registration_source"
      expr: registration_source
      comment: "Source through which the device was registered (app, web, partner, etc.)"
    - name: "deregistration_reason"
      expr: deregistration_reason
      comment: "Reason the device was deregistered, if applicable"
    - name: "offline_download_enabled"
      expr: offline_download_enabled
      comment: "Whether offline downloads are enabled for this device"
    - name: "hdr_support"
      expr: hdr_support
      comment: "Whether the device supports HDR content"
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on this device"
    - name: "ad_tracking_consent"
      expr: ad_tracking_consent
      comment: "Whether the user has consented to ad tracking on this device"
    - name: "device_limit_enforcement_flag"
      expr: device_limit_enforcement_flag
      comment: "Whether device limits are being enforced"
    - name: "max_resolution_supported"
      expr: max_resolution_supported
      comment: "Maximum resolution supported by the device"
    - name: "drm_security_level"
      expr: drm_security_level
      comment: "DRM security level of the device"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month when the device was registered"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year when the device was registered"
    - name: "deregistration_month"
      expr: DATE_TRUNC('MONTH', deregistration_timestamp)
      comment: "Month when the device was deregistered"
  measures:
    - name: "total_device_registrations"
      expr: COUNT(1)
      comment: "Total number of device registration records"
    - name: "unique_devices_registered"
      expr: COUNT(DISTINCT device_registration_id)
      comment: "Distinct count of registered devices"
    - name: "unique_subscribers_with_devices"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with registered devices"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across registered devices"
    - name: "offline_download_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offline_download_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of devices with offline downloads enabled"
    - name: "hdr_support_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hdr_support = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of devices that support HDR content"
    - name: "parental_control_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN parental_control_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of devices with parental controls enabled"
    - name: "ad_tracking_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ad_tracking_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of devices where users have consented to ad tracking"
    - name: "deregistration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN deregistration_timestamp IS NOT NULL THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of devices that have been deregistered"
$$;