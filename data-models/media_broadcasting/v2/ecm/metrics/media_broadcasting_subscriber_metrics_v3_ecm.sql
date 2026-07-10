-- Metric views for domain: subscriber | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscriber base health metrics tracking active subscriber counts, churn risk distribution, lifetime value, and engagement signals. Used by executive leadership to monitor subscriber growth, retention risk, and revenue quality."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscriber`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current account status (active, suspended, cancelled) for segmenting subscriber base health."
    - name: "service_tier"
      expr: service_tier
      comment: "Subscription service tier (basic, standard, premium) for revenue and engagement segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Subscriber country for geographic performance analysis and regulatory reporting."
    - name: "registration_source"
      expr: registration_source
      comment: "Acquisition channel through which the subscriber registered, used for marketing attribution."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (monthly, annual) for revenue forecasting and churn pattern analysis."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Subscriber preferred language for localization and content strategy decisions."
    - name: "subscription_start_cohort_month"
      expr: DATE_TRUNC('MONTH', subscription_start_date)
      comment: "Monthly cohort of subscription start date for cohort retention and LTV analysis."
    - name: "subscription_end_date"
      expr: subscription_end_date
      comment: "Subscription end date for identifying upcoming churn and renewal pipeline."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled, used for family-tier product segmentation."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "GDPR consent status for compliance reporting and data processing eligibility."
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "CCPA opt-out flag for privacy compliance segmentation."
  measures:
    - name: "total_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Total unique subscribers in the base. Primary KPI for subscriber growth tracking on executive dashboards."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average Revenue Per User across the subscriber base. Core monetization KPI used to benchmark pricing strategy and tier mix."
    - name: "total_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Sum of ARPU across all subscribers as a proxy for annualized recurring revenue contribution. Used in revenue forecasting."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average predicted lifetime value per subscriber. Drives investment decisions in acquisition spend and retention programs."
    - name: "total_lifetime_value"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total predicted lifetime value across the subscriber base. Used by finance to model long-range revenue projections."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across subscribers. Elevated scores trigger proactive retention intervention by CRM and product teams."
    - name: "high_churn_risk_subscribers"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_score >= 0.7 THEN subscriber_id END)
      comment: "Count of subscribers with churn risk score >= 0.7. Directly informs retention campaign targeting and budget allocation."
    - name: "avg_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average total viewing hours per subscriber. Key engagement signal used to assess content value and predict churn."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all subscribers. Used to measure platform engagement and content consumption at scale."
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gdpr_consent_flag = TRUE THEN subscriber_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Percentage of subscribers with active GDPR consent. Critical compliance KPI monitored by legal and data governance teams."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN subscriber_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Percentage of subscribers opted into marketing communications. Drives addressable audience sizing for campaign planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription lifecycle and recurring revenue metrics tracking MRR, ARR, trial conversion, and subscription health. Core financial and operational KPIs for the subscription business."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current subscription lifecycle status (active, cancelled, suspended, trial) for pipeline and health analysis."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (direct, MVPD, bundle) for product mix and revenue attribution."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (monthly, annual) for cash flow and churn pattern analysis."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscription was acquired for marketing ROI and CAC analysis."
    - name: "promotional_rate_flag"
      expr: promotional_rate_flag
      comment: "Whether the subscription is on a promotional rate, used to track promotional liability and conversion to full price."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Auto-renewal status for predicting renewal revenue and identifying at-risk subscriptions."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of subscription activation for cohort analysis and growth trend reporting."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for cancellation for churn root-cause analysis and product improvement prioritization."
    - name: "trial_start_month"
      expr: DATE_TRUNC('MONTH', trial_start_date)
      comment: "Month trial started for trial-to-paid conversion cohort analysis."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total unique subscriptions. Baseline volume KPI for subscription business scale."
    - name: "active_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'active' THEN subscription_id END)
      comment: "Count of currently active subscriptions. Primary operational KPI for subscriber base health."
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Sum of base subscription rates across all subscriptions. Proxy for gross MRR before discounts."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base subscription rate. Used to track pricing mix and ARPU benchmarking."
    - name: "total_promotional_rate_revenue"
      expr: SUM(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Total revenue from subscriptions on promotional rates. Quantifies promotional discount liability for finance."
    - name: "avg_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average predicted lifetime value per subscription. Informs acquisition investment thresholds and retention ROI."
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Total predicted lifetime value across all subscriptions. Used in long-range financial planning."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average Revenue Per User at subscription level. Core monetization benchmark for pricing and tier strategy."
    - name: "trial_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'trial' THEN subscription_id END)
      comment: "Count of subscriptions currently in trial. Indicates near-term conversion pipeline size."
    - name: "promotional_subscription_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN promotional_rate_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions on promotional pricing. High rates signal revenue risk when promotions expire."
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions with auto-renewal enabled. Leading indicator of renewal revenue predictability."
    - name: "cancelled_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'cancelled' THEN subscription_id END)
      comment: "Count of cancelled subscriptions. Used to calculate gross churn rate and inform retention strategy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_churn_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Churn event analytics tracking cancellation patterns, win-back offer effectiveness, churn prediction accuracy, and revenue loss from subscriber departures. Critical for retention strategy and product investment decisions."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`churn_event`"
  dimensions:
    - name: "churn_type"
      expr: churn_type
      comment: "Type of churn (voluntary, involuntary, payment failure) for root-cause segmentation."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Standardized cancellation reason code for churn driver analysis and product prioritization."
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation was initiated (app, web, phone) for UX and retention intervention design."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier at time of churn for identifying which tiers have highest churn risk."
    - name: "churn_month"
      expr: DATE_TRUNC('MONTH', churn_timestamp)
      comment: "Month of churn event for trend analysis and seasonality detection."
    - name: "competitor_service_mentioned_flag"
      expr: competitor_service_mentioned_flag
      comment: "Whether a competitor was mentioned at cancellation, used for competitive intelligence and win-back targeting."
    - name: "win_back_offer_presented_flag"
      expr: win_back_offer_presented_flag
      comment: "Whether a win-back offer was presented at cancellation, for measuring save attempt coverage."
    - name: "win_back_offer_accepted_flag"
      expr: win_back_offer_accepted_flag
      comment: "Whether the win-back offer was accepted, for measuring save rate effectiveness."
    - name: "promotional_discount_active_flag"
      expr: promotional_discount_active_flag
      comment: "Whether a promotional discount was active at time of churn, for assessing discount-driven retention."
    - name: "payment_failure_count"
      expr: payment_failure_count
      comment: "Number of payment failures prior to churn, for identifying involuntary churn patterns."
  measures:
    - name: "total_churn_events"
      expr: COUNT(DISTINCT churn_event_id)
      comment: "Total number of churn events. Primary volume KPI for gross churn rate calculation."
    - name: "avg_churn_prediction_score"
      expr: AVG(CAST(churn_prediction_score AS DOUBLE))
      comment: "Average churn prediction score at time of actual churn. Used to calibrate model accuracy and threshold tuning."
    - name: "total_last_payment_revenue"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total revenue from final payments before churn. Quantifies immediate revenue loss from churned subscribers."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average final payment amount for churned subscribers. Indicates the revenue tier of churning customers."
    - name: "total_lifetime_revenue_lost"
      expr: SUM(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue from churned subscribers. Quantifies the cumulative value of lost customers for retention ROI modeling."
    - name: "avg_lifetime_revenue_lost"
      expr: AVG(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per churned subscriber. Benchmarks the value of subscribers being lost vs. retained."
    - name: "win_back_offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN win_back_offer_accepted_flag = TRUE THEN churn_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN win_back_offer_presented_flag = TRUE THEN churn_event_id END), 0), 2)
      comment: "Percentage of presented win-back offers that were accepted. Measures save-attempt effectiveness and informs offer design."
    - name: "competitor_churn_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN competitor_service_mentioned_flag = TRUE THEN churn_event_id END) / NULLIF(COUNT(DISTINCT churn_event_id), 0), 2)
      comment: "Percentage of churn events where a competitor was mentioned. Tracks competitive pressure and informs content/pricing strategy."
    - name: "payment_failure_churn_events"
      expr: COUNT(DISTINCT CASE WHEN churn_type = 'involuntary' THEN churn_event_id END)
      comment: "Count of involuntary churn events (payment failures). Drives dunning and payment recovery program investment."
    - name: "avg_days_since_last_viewing"
      expr: AVG(CAST(days_since_last_viewing AS DOUBLE))
      comment: "Average days since last viewing activity at time of churn. Key engagement signal for early churn detection models."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription change event metrics tracking upgrade/downgrade patterns, MRR impact, proration costs, and offer redemption effectiveness. Used by product and finance teams to optimize plan mix and pricing strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of subscription change (upgrade, downgrade, pause, reactivation) for plan migration analysis."
    - name: "change_channel"
      expr: change_channel
      comment: "Channel through which the change was initiated for UX optimization and self-service adoption tracking."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for the subscription change for product and pricing strategy insights."
    - name: "service_tier_change"
      expr: service_tier_change
      comment: "Direction of service tier change (upgrade, downgrade, lateral) for revenue impact segmentation."
    - name: "change_effective_month"
      expr: DATE_TRUNC('MONTH', change_effective_date)
      comment: "Month the change became effective for trend and seasonality analysis."
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Auto-renewal status after the change for predicting future renewal revenue."
    - name: "offer_redemption_status"
      expr: offer_redemption_status
      comment: "Status of offer redemption associated with the change for promotional effectiveness tracking."
  measures:
    - name: "total_subscription_changes"
      expr: COUNT(DISTINCT subscription_change_id)
      comment: "Total number of subscription change events. Baseline volume for plan migration analysis."
    - name: "total_mrr_impact"
      expr: SUM(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Net MRR impact from all subscription changes. Core financial KPI for tracking expansion vs. contraction revenue."
    - name: "avg_mrr_impact"
      expr: AVG(CAST(mrr_impact_amount AS DOUBLE))
      comment: "Average MRR impact per subscription change event. Indicates whether changes are net positive or negative for revenue."
    - name: "total_new_mrr"
      expr: SUM(CAST(new_monthly_recurring_revenue AS DOUBLE))
      comment: "Total new MRR after subscription changes. Used to project forward revenue from the changed subscriber base."
    - name: "total_previous_mrr"
      expr: SUM(CAST(previous_monthly_recurring_revenue AS DOUBLE))
      comment: "Total MRR before subscription changes. Baseline for calculating net MRR expansion or contraction."
    - name: "total_applied_discount"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount value applied across subscription changes. Quantifies promotional cost and discount liability."
    - name: "avg_applied_discount_percentage"
      expr: AVG(CAST(applied_discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied at change time. Tracks discount depth and pricing discipline."
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration credits/charges from mid-cycle changes. Impacts billing accuracy and cash flow timing."
    - name: "upgrade_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN change_type = 'upgrade' THEN subscription_change_id END) / NULLIF(COUNT(DISTINCT subscription_change_id), 0), 2)
      comment: "Percentage of subscription changes that are upgrades. Measures upsell effectiveness and product tier attractiveness."
    - name: "downgrade_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN change_type = 'downgrade' THEN subscription_change_id END) / NULLIF(COUNT(DISTINCT subscription_change_id), 0), 2)
      comment: "Percentage of subscription changes that are downgrades. Signals pricing pressure or content value concerns."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption performance metrics tracking redemption rates, discount costs, revenue impact, and eligibility conversion. Used by marketing and finance to optimize promotional spend and offer design."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (redeemed, failed, reversed) for funnel analysis."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed for attribution and channel effectiveness analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, fixed, free trial) for offer structure analysis."
    - name: "attribution_source"
      expr: attribution_source
      comment: "Marketing attribution source for the redemption, used to measure campaign ROI."
    - name: "first_time_subscriber_flag"
      expr: first_time_subscriber_flag
      comment: "Whether the subscriber is a first-time subscriber, for new vs. returning subscriber offer performance."
    - name: "eligibility_verified_flag"
      expr: eligibility_verified_flag
      comment: "Whether eligibility was verified before redemption, for compliance and fraud risk monitoring."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption for trend analysis and promotional calendar planning."
    - name: "redemption_device_type"
      expr: redemption_device_type
      comment: "Device type used for redemption for platform-specific offer optimization."
  measures:
    - name: "total_redemptions"
      expr: COUNT(DISTINCT offer_redemption_id)
      comment: "Total number of offer redemptions. Baseline volume KPI for promotional program scale."
    - name: "successful_redemptions"
      expr: COUNT(DISTINCT CASE WHEN redemption_status = 'redeemed' THEN offer_redemption_id END)
      comment: "Count of successfully completed redemptions. Measures promotional program effectiveness."
    - name: "total_discount_cost"
      expr: SUM(CAST(applied_discount_amount AS DOUBLE))
      comment: "Total discount value granted through offer redemptions. Core promotional spend KPI for marketing budget management."
    - name: "avg_discount_amount"
      expr: AVG(CAST(applied_discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption. Used to benchmark offer generosity and optimize discount depth."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across redemptions. Tracks pricing discipline and promotional intensity."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact (positive or negative) from offer redemptions. Measures net financial effect of promotional programs."
    - name: "avg_revenue_impact"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per redemption. Used to assess whether offers generate net positive revenue contribution."
    - name: "redemption_success_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN redemption_status = 'redeemed' THEN offer_redemption_id END) / NULLIF(COUNT(DISTINCT offer_redemption_id), 0), 2)
      comment: "Percentage of offer redemption attempts that succeeded. Measures offer funnel conversion and technical reliability."
    - name: "first_time_subscriber_redemption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN first_time_subscriber_flag = TRUE THEN offer_redemption_id END) / NULLIF(COUNT(DISTINCT offer_redemption_id), 0), 2)
      comment: "Percentage of redemptions by first-time subscribers. Measures new subscriber acquisition effectiveness of promotional offers."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reversal_reason IS NOT NULL THEN offer_redemption_id END) / NULLIF(COUNT(DISTINCT offer_redemption_id), 0), 2)
      comment: "Percentage of redemptions that were reversed. High reversal rates indicate fraud, eligibility issues, or operational problems."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics tracking average revenue, churn risk, lifetime value, and service adoption across the subscriber household base. Used for DMA-level market analysis and family plan strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household account for active base segmentation."
    - name: "household_type"
      expr: household_type
      comment: "Type of household (individual, family, shared) for product and pricing strategy segmentation."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the household for revenue and engagement analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household for geographic market analysis."
    - name: "dma_code"
      expr: dma_code
      comment: "Designated Market Area code for local market performance and audience measurement alignment."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for payment mix analysis and involuntary churn risk assessment."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled for family-tier product segmentation."
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Auto-renewal status for renewal revenue predictability analysis."
    - name: "subscription_start_cohort_month"
      expr: DATE_TRUNC('MONTH', subscription_start_date)
      comment: "Monthly cohort of household subscription start for cohort LTV and retention analysis."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Marketing opt-in status for addressable audience sizing."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households. Baseline KPI for household-level subscriber base scale."
    - name: "avg_revenue_per_household"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average revenue per household. Measures monetization efficiency at the household level for pricing strategy."
    - name: "total_household_revenue"
      expr: SUM(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Total revenue contribution across all households. Used in market-level revenue reporting."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average predicted lifetime value per household. Informs acquisition investment and retention program ROI."
    - name: "total_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Total predicted lifetime value across all households. Used in long-range financial planning and market valuation."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across households. Elevated scores trigger proactive retention outreach."
    - name: "high_churn_risk_households"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_score >= 0.7 THEN household_id END)
      comment: "Count of households with high churn risk (score >= 0.7). Directly sizes the at-risk retention intervention pool."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households opted into marketing. Determines addressable audience for promotional campaigns."
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_enabled = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households with auto-renewal enabled. Leading indicator of renewal revenue predictability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement coverage and access metrics tracking active entitlements, trial rates, download enablement, and ad-free adoption. Used by product and content teams to understand access patterns and content monetization."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current entitlement status (active, expired, revoked, suspended) for access coverage analysis."
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (subscription, purchase, rental, promotional) for monetization model analysis."
    - name: "access_level"
      expr: access_level
      comment: "Access level granted by the entitlement for content tier and paywall analysis."
    - name: "quality_tier"
      expr: quality_tier
      comment: "Video quality tier of the entitlement for premium tier adoption tracking."
    - name: "ad_free"
      expr: ad_free
      comment: "Whether the entitlement is ad-free for ad-supported vs. premium tier mix analysis."
    - name: "trial_entitlement"
      expr: trial_entitlement
      comment: "Whether this is a trial entitlement for trial-to-paid conversion funnel analysis."
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether offline download is enabled for premium feature adoption tracking."
    - name: "grant_reason"
      expr: grant_reason
      comment: "Reason the entitlement was granted for access policy and promotional analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month entitlement became effective for cohort and trend analysis."
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total unique entitlements. Baseline volume for content access coverage analysis."
    - name: "active_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'active' THEN entitlement_id END)
      comment: "Count of currently active entitlements. Measures live content access coverage across the subscriber base."
    - name: "trial_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_entitlement = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that are trial-based. Measures trial program scale and conversion pipeline."
    - name: "ad_free_entitlement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_free = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements that are ad-free. Tracks premium tier adoption and ad inventory availability."
    - name: "download_enabled_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN download_enabled = TRUE THEN entitlement_id END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements with offline download enabled. Measures premium feature adoption."
    - name: "revoked_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'revoked' THEN entitlement_id END)
      comment: "Count of revoked entitlements. Tracks access control enforcement and potential fraud or compliance actions."
    - name: "unique_entitled_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with at least one entitlement. Measures content access breadth across the subscriber base."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_device_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device registration metrics tracking device adoption, fraud risk, DRM security levels, and multi-device usage patterns. Used by product and security teams to manage device limits and platform health."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`device_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current device registration status (active, deregistered, suspended) for device fleet health analysis."
    - name: "registration_source"
      expr: registration_source
      comment: "Source through which the device was registered for platform adoption analysis."
    - name: "drm_security_level"
      expr: drm_security_level
      comment: "DRM security level of the device for content protection compliance monitoring."
    - name: "max_resolution_supported"
      expr: max_resolution_supported
      comment: "Maximum video resolution supported by the device for quality tier eligibility analysis."
    - name: "hdr_support"
      expr: hdr_support
      comment: "Whether the device supports HDR for premium content delivery capability analysis."
    - name: "offline_download_enabled"
      expr: offline_download_enabled
      comment: "Whether offline download is enabled on the device for premium feature adoption tracking."
    - name: "parental_control_enabled"
      expr: parental_control_enabled
      comment: "Whether parental controls are enabled on the device for family safety feature adoption."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month of device registration for device growth trend analysis."
    - name: "ad_tracking_consent"
      expr: ad_tracking_consent
      comment: "Whether ad tracking consent was granted on this device for addressable advertising inventory sizing."
  measures:
    - name: "total_device_registrations"
      expr: COUNT(DISTINCT device_registration_id)
      comment: "Total device registrations. Baseline KPI for platform device footprint and multi-device adoption."
    - name: "active_device_registrations"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'active' THEN device_registration_id END)
      comment: "Count of currently active device registrations. Measures live device fleet size for capacity and licensing planning."
    - name: "unique_registered_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with at least one registered device. Measures device adoption breadth."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across device registrations. Elevated scores trigger security review and account protection actions."
    - name: "high_fraud_risk_devices"
      expr: COUNT(DISTINCT CASE WHEN fraud_score >= 0.7 THEN device_registration_id END)
      comment: "Count of device registrations with high fraud risk score (>= 0.7). Directly sizes the fraud investigation queue."
    - name: "ad_tracking_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_tracking_consent = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of devices with ad tracking consent. Determines addressable advertising inventory size on the platform."
    - name: "hdr_capable_device_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hdr_support = TRUE THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of registered devices that support HDR. Informs premium content delivery investment decisions."
    - name: "deregistration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN registration_status = 'deregistered' THEN device_registration_id END) / NULLIF(COUNT(DISTINCT device_registration_id), 0), 2)
      comment: "Percentage of device registrations that have been deregistered. Tracks device churn and account health signals."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_subscription_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription plan catalog metrics tracking plan pricing, feature adoption rates, and plan portfolio health. Used by product and pricing teams to optimize plan design and tier strategy."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current plan status (active, deprecated, sunset) for plan portfolio management."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of subscription plan (individual, family, student, corporate) for market segment analysis."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the plan for revenue tier mix analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, annual) for cash flow and churn pattern analysis."
    - name: "ad_supported"
      expr: ad_supported
      comment: "Whether the plan includes ads for ad-supported vs. premium tier mix analysis."
    - name: "trial_eligible"
      expr: trial_eligible
      comment: "Whether the plan offers a trial period for acquisition funnel analysis."
    - name: "download_enabled"
      expr: download_enabled
      comment: "Whether offline download is included in the plan for premium feature differentiation."
    - name: "promotional_plan"
      expr: promotional_plan
      comment: "Whether this is a promotional plan for tracking promotional plan portfolio size."
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the plan was launched for plan lifecycle and portfolio evolution analysis."
  measures:
    - name: "total_plans"
      expr: COUNT(DISTINCT subscription_plan_id)
      comment: "Total number of subscription plans in the catalog. Measures plan portfolio complexity."
    - name: "active_plans"
      expr: COUNT(DISTINCT CASE WHEN plan_status = 'active' THEN subscription_plan_id END)
      comment: "Count of currently active subscription plans. Measures live plan portfolio size for product management."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across subscription plans. Benchmarks pricing strategy and tier positioning."
    - name: "avg_target_arpu"
      expr: AVG(CAST(target_arpu AS DOUBLE))
      comment: "Average target ARPU across plans. Used to assess whether plan pricing aligns with revenue goals."
    - name: "avg_target_ltv"
      expr: AVG(CAST(target_ltv AS DOUBLE))
      comment: "Average target LTV across plans. Informs plan design decisions to maximize long-term subscriber value."
    - name: "avg_early_termination_fee"
      expr: AVG(CAST(early_termination_fee AS DOUBLE))
      comment: "Average early termination fee across plans. Measures contractual churn protection and revenue recovery mechanisms."
    - name: "ad_supported_plan_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ad_supported = TRUE THEN subscription_plan_id END) / NULLIF(COUNT(DISTINCT subscription_plan_id), 0), 2)
      comment: "Percentage of plans that are ad-supported. Tracks ad-supported tier portfolio share for advertising revenue strategy."
    - name: "trial_eligible_plan_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_eligible = TRUE THEN subscription_plan_id END) / NULLIF(COUNT(DISTINCT subscription_plan_id), 0), 2)
      comment: "Percentage of plans offering a trial period. Measures trial program coverage across the plan portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`subscriber_viewer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewer profile engagement and personalization metrics tracking active profiles, kids profile adoption, viewing hours, and consent rates. Used by product and content teams to optimize personalization and family safety features."
  source: "`vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current profile status (active, inactive, deleted) for active profile base analysis."
    - name: "profile_type"
      expr: profile_type
      comment: "Type of viewer profile (standard, kids, guest) for audience segmentation and content strategy."
    - name: "maturity_rating_level"
      expr: maturity_rating_level
      comment: "Maturity rating level set on the profile for content access and parental control analysis."
    - name: "is_kids_profile"
      expr: is_kids_profile
      comment: "Whether this is a kids profile for COPPA compliance and family product analysis."
    - name: "is_default_profile"
      expr: is_default_profile
      comment: "Whether this is the default profile for primary viewer behavior analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for content localization and language-specific content investment decisions."
    - name: "video_quality_preference"
      expr: video_quality_preference
      comment: "Preferred video quality for bandwidth planning and premium tier upsell targeting."
    - name: "personalization_enabled"
      expr: personalization_enabled
      comment: "Whether personalization is enabled for measuring recommendation engine adoption."
    - name: "viewing_history_enabled"
      expr: viewing_history_enabled
      comment: "Whether viewing history tracking is enabled for data availability in recommendation models."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the profile was created for profile growth trend analysis."
  measures:
    - name: "total_viewer_profiles"
      expr: COUNT(DISTINCT viewer_profile_id)
      comment: "Total viewer profiles. Measures multi-profile adoption and household engagement breadth."
    - name: "active_viewer_profiles"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN viewer_profile_id END)
      comment: "Count of currently active viewer profiles. Measures live engagement surface across the subscriber base."
    - name: "kids_profile_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_kids_profile = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of profiles that are kids profiles. Measures family tier adoption and COPPA compliance scope."
    - name: "avg_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average total viewing hours per viewer profile. Key engagement KPI for content value and churn prediction."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours across all viewer profiles. Platform-wide engagement KPI for content and infrastructure planning."
    - name: "personalization_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN personalization_enabled = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of profiles with personalization enabled. Measures recommendation engine reach and data asset quality."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_consent = TRUE THEN viewer_profile_id END) / NULLIF(COUNT(DISTINCT viewer_profile_id), 0), 2)
      comment: "Percentage of viewer profiles with marketing consent. Determines addressable audience for personalized marketing."
    - name: "unique_subscribers_with_profiles"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers who have created at least one viewer profile. Measures profile feature adoption breadth."
$$;