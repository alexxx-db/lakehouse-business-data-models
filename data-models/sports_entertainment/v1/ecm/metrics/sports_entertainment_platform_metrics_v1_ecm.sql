-- Metric views for domain: platform | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_digital_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscription revenue and retention metrics for digital streaming and content access products"
  source: "`sports_entertainment_ecm`.`platform`.`digital_subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, expired, trial)"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription product (season pass, league pass, premium, basic)"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (monthly, annual, seasonal)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which subscriber was acquired (web, mobile, partner, promo)"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market or region of the subscriber"
    - name: "churn_risk_tier"
      expr: churn_risk_tier
      comment: "Predicted churn risk segment (high, medium, low)"
    - name: "content_access_tier"
      expr: content_access_tier
      comment: "Level of content access granted (premium, standard, basic)"
    - name: "subscription_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when subscription started, for cohort analysis"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether subscription is set to auto-renew"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscription records"
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN 1 END)
      comment: "Count of currently active subscriptions"
    - name: "total_subscription_revenue"
      expr: SUM(CAST(net_charge AS DOUBLE))
      comment: "Total net subscription revenue after discounts and taxes"
    - name: "total_subscription_charge"
      expr: SUM(CAST(subscription_charge AS DOUBLE))
      comment: "Total gross subscription charges before discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to subscriptions"
    - name: "avg_subscription_revenue"
      expr: AVG(CAST(net_charge AS DOUBLE))
      comment: "Average net revenue per subscription (ARPU proxy)"
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score across subscriptions, indicating content consumption intensity"
    - name: "churned_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled subscriptions"
    - name: "trial_subscriptions"
      expr: COUNT(CASE WHEN trial_end_date IS NOT NULL AND start_date <= trial_end_date THEN 1 END)
      comment: "Count of subscriptions currently or previously in trial period"
    - name: "auto_renew_subscriptions"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Count of subscriptions with auto-renewal enabled, indicating retention intent"
    - name: "high_churn_risk_subscriptions"
      expr: COUNT(CASE WHEN churn_risk_tier = 'high' THEN 1 END)
      comment: "Count of subscriptions at high risk of churn, requiring intervention"
    - name: "payment_failure_count"
      expr: SUM(CAST(payment_failure_count AS BIGINT))
      comment: "Total payment failures across subscriptions, indicating billing health"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_fan_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fan account lifecycle, engagement, and customer value metrics for direct-to-consumer strategy"
  source: "`sports_entertainment_ecm`.`platform`.`fan_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of fan account (active, suspended, deactivated)"
    - name: "account_tier"
      expr: account_tier
      comment: "Account tier or segment (VIP, premium, standard, free)"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (individual, family, corporate)"
    - name: "country_code"
      expr: country_code
      comment: "Country of account registration"
    - name: "cac_source"
      expr: cac_source
      comment: "Customer acquisition cost source or channel"
    - name: "ltv_score_bucket"
      expr: ltv_score_bucket
      comment: "Lifetime value score bucket (high, medium, low)"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of account registration for cohort analysis"
    - name: "is_subscription_active"
      expr: is_subscription_active
      comment: "Whether account has an active subscription"
    - name: "is_mfa_enabled"
      expr: is_mfa_enabled
      comment: "Whether multi-factor authentication is enabled, indicating security posture"
    - name: "gdpr_data_subject_flag"
      expr: gdpr_data_subject_flag
      comment: "Whether account is subject to GDPR regulations"
  measures:
    - name: "total_fan_accounts"
      expr: COUNT(1)
      comment: "Total number of fan accounts"
    - name: "active_fan_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' THEN 1 END)
      comment: "Count of active fan accounts"
    - name: "subscribed_accounts"
      expr: COUNT(CASE WHEN is_subscription_active = TRUE THEN 1 END)
      comment: "Count of accounts with active subscriptions, key revenue driver"
    - name: "avg_arpu_baseline"
      expr: AVG(CAST(arpu_baseline_amount AS DOUBLE))
      comment: "Average revenue per user baseline across accounts"
    - name: "total_arpu_potential"
      expr: SUM(CAST(arpu_baseline_amount AS DOUBLE))
      comment: "Total ARPU potential across all accounts"
    - name: "high_ltv_accounts"
      expr: COUNT(CASE WHEN ltv_score_bucket = 'high' THEN 1 END)
      comment: "Count of high lifetime value accounts, priority retention targets"
    - name: "mfa_enabled_accounts"
      expr: COUNT(CASE WHEN is_mfa_enabled = TRUE THEN 1 END)
      comment: "Count of accounts with MFA enabled, security compliance metric"
    - name: "email_verified_accounts"
      expr: COUNT(CASE WHEN is_email_verified = TRUE THEN 1 END)
      comment: "Count of accounts with verified email, indicating engagement quality"
    - name: "season_ticket_linked_accounts"
      expr: COUNT(CASE WHEN linked_season_ticket_flag = TRUE THEN 1 END)
      comment: "Count of accounts linked to season tickets, high-value segment"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across accounts with survey responses"
    - name: "gdpr_subject_accounts"
      expr: COUNT(CASE WHEN gdpr_data_subject_flag = TRUE THEN 1 END)
      comment: "Count of GDPR data subject accounts, compliance tracking"
    - name: "ccpa_opt_out_accounts"
      expr: COUNT(CASE WHEN ccpa_opt_out_flag = TRUE THEN 1 END)
      comment: "Count of accounts that opted out under CCPA, privacy compliance metric"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_fan_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fan engagement and interaction metrics across digital touchpoints for experience optimization"
  source: "`sports_entertainment_ecm`.`platform`.`fan_interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of fan interaction (view, click, share, purchase, poll_response)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of interaction (completed, abandoned, error)"
    - name: "platform_name"
      expr: platform_name
      comment: "Platform where interaction occurred (web, iOS, Android, smart_tv)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for interaction (mobile, tablet, desktop, tv)"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code of interaction origin"
    - name: "is_authenticated"
      expr: is_authenticated
      comment: "Whether user was authenticated during interaction"
    - name: "is_first_interaction"
      expr: is_first_interaction
      comment: "Whether this was user's first interaction, onboarding metric"
    - name: "ab_test_variant_label"
      expr: ab_test_variant_label
      comment: "A/B test variant label for experiment analysis"
    - name: "referral_source"
      expr: referral_source
      comment: "Source that referred the interaction (organic, paid, social, email)"
    - name: "interaction_date"
      expr: DATE_TRUNC('DAY', interaction_timestamp)
      comment: "Date of interaction for time-series analysis"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of fan interactions across all touchpoints"
    - name: "completed_interactions"
      expr: COUNT(CASE WHEN interaction_status = 'completed' THEN 1 END)
      comment: "Count of successfully completed interactions"
    - name: "unique_fans"
      expr: COUNT(DISTINCT fan_account_id)
      comment: "Distinct count of fans who interacted, measuring reach"
    - name: "authenticated_interactions"
      expr: COUNT(CASE WHEN is_authenticated = TRUE THEN 1 END)
      comment: "Count of interactions by authenticated users, quality signal"
    - name: "first_time_interactions"
      expr: COUNT(CASE WHEN is_first_interaction = TRUE THEN 1 END)
      comment: "Count of first-time interactions, new user acquisition metric"
    - name: "avg_interaction_duration_seconds"
      expr: AVG(CAST(interaction_duration_seconds AS DOUBLE))
      comment: "Average duration of interactions in seconds, engagement depth indicator"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_pct AS DOUBLE))
      comment: "Average completion percentage across interactions, content effectiveness metric"
    - name: "total_purchase_initiated_amount"
      expr: SUM(CAST(purchase_initiated_amount AS DOUBLE))
      comment: "Total purchase amount initiated from interactions, conversion value"
    - name: "purchase_interactions"
      expr: COUNT(CASE WHEN purchase_category IS NOT NULL THEN 1 END)
      comment: "Count of interactions that involved a purchase, conversion metric"
    - name: "social_share_interactions"
      expr: COUNT(CASE WHEN social_share_platform IS NOT NULL THEN 1 END)
      comment: "Count of interactions that resulted in social shares, virality metric"
    - name: "error_interactions"
      expr: COUNT(CASE WHEN error_code IS NOT NULL THEN 1 END)
      comment: "Count of interactions with errors, platform quality metric"
    - name: "total_loyalty_points_awarded"
      expr: SUM(CAST(loyalty_points_awarded AS BIGINT))
      comment: "Total loyalty points awarded through interactions, engagement incentive tracking"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_content_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content recommendation performance and personalization effectiveness metrics"
  source: "`sports_entertainment_ecm`.`platform`.`content_recommendation`"
  dimensions:
    - name: "recommendation_type"
      expr: recommendation_type
      comment: "Type of recommendation (algorithmic, editorial, sponsored, trending)"
    - name: "recommendation_status"
      expr: recommendation_status
      comment: "Status of recommendation (served, clicked, dismissed, completed)"
    - name: "algorithm_name"
      expr: algorithm_name
      comment: "Name of recommendation algorithm used"
    - name: "algorithm_type"
      expr: algorithm_type
      comment: "Type of algorithm (collaborative_filtering, content_based, hybrid)"
    - name: "content_type"
      expr: content_type
      comment: "Type of content recommended (live, vod, highlight, article)"
    - name: "sport_type"
      expr: sport_type
      comment: "Sport type of recommended content"
    - name: "device_type"
      expr: device_type
      comment: "Device type where recommendation was served"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code where recommendation was served"
    - name: "engagement_outcome"
      expr: engagement_outcome
      comment: "Outcome of recommendation (engaged, ignored, dismissed)"
    - name: "is_rights_compliant"
      expr: is_rights_compliant
      comment: "Whether recommendation respected broadcast rights restrictions"
  measures:
    - name: "total_recommendations"
      expr: COUNT(1)
      comment: "Total number of content recommendations served"
    - name: "served_recommendations"
      expr: COUNT(CASE WHEN served_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of recommendations actually served to users"
    - name: "engaged_recommendations"
      expr: COUNT(CASE WHEN engagement_outcome = 'engaged' THEN 1 END)
      comment: "Count of recommendations that resulted in user engagement"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of recommendations, algorithm quality metric"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_pct AS DOUBLE))
      comment: "Average completion percentage of recommended content, relevance indicator"
    - name: "high_confidence_recommendations"
      expr: COUNT(CASE WHEN CAST(confidence_score AS DOUBLE) >= 0.8 THEN 1 END)
      comment: "Count of high-confidence recommendations (score >= 0.8)"
    - name: "upsell_candidate_recommendations"
      expr: COUNT(CASE WHEN is_upsell_candidate = TRUE THEN 1 END)
      comment: "Count of recommendations flagged as upsell opportunities, monetization metric"
    - name: "rights_compliant_recommendations"
      expr: COUNT(CASE WHEN is_rights_compliant = TRUE THEN 1 END)
      comment: "Count of recommendations that respected rights restrictions, compliance metric"
    - name: "suppressed_recommendations"
      expr: COUNT(CASE WHEN suppression_reason IS NOT NULL THEN 1 END)
      comment: "Count of recommendations suppressed due to business rules or rights"
    - name: "unique_fans_recommended"
      expr: COUNT(DISTINCT fan_account_id)
      comment: "Distinct count of fans who received recommendations, reach metric"
    - name: "unique_content_recommended"
      expr: COUNT(DISTINCT asset_id)
      comment: "Distinct count of content assets recommended, catalog coverage metric"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_sla_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement incident tracking and platform reliability metrics"
  source: "`sports_entertainment_ecm`.`platform`.`sla_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of SLA incident (open, investigating, resolved, closed)"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (outage, degradation, latency, error_rate)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of incident (critical, high, medium, low)"
    - name: "is_breach"
      expr: is_breach
      comment: "Whether incident resulted in SLA breach"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (infrastructure, code, third_party, capacity)"
    - name: "affected_region"
      expr: affected_region
      comment: "Geographic region affected by incident"
    - name: "detection_method"
      expr: detection_method
      comment: "How incident was detected (monitoring, user_report, automated_alert)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether incident was escalated to higher support tier"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether incident requires regulatory notification"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month when incident was detected for trend analysis"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of SLA incidents"
    - name: "sla_breaches"
      expr: COUNT(CASE WHEN is_breach = TRUE THEN 1 END)
      comment: "Count of incidents that resulted in SLA breaches, reliability metric"
    - name: "critical_incidents"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN 1 END)
      comment: "Count of critical severity incidents requiring immediate action"
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status IN ('open', 'investigating') THEN 1 END)
      comment: "Count of currently open or under investigation incidents"
    - name: "resolved_incidents"
      expr: COUNT(CASE WHEN incident_status = 'resolved' THEN 1 END)
      comment: "Count of resolved incidents"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty amount from SLA breaches"
    - name: "avg_breach_duration_seconds"
      expr: AVG(CAST(breach_duration_seconds AS DOUBLE))
      comment: "Average duration of SLA breaches in seconds, downtime metric"
    - name: "total_fan_impact"
      expr: SUM(CAST(fan_account_impact_count AS BIGINT))
      comment: "Total number of fan accounts impacted by incidents, customer impact metric"
    - name: "total_arpu_impact"
      expr: SUM(CAST(arpu_impact_estimate AS DOUBLE))
      comment: "Total estimated ARPU impact from incidents, revenue risk metric"
    - name: "escalated_incidents"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of incidents that required escalation, complexity indicator"
    - name: "recurring_incidents"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Count of recurring incidents, systemic issue indicator"
    - name: "regulatory_reportable_incidents"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Count of incidents requiring regulatory notification, compliance metric"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_notification_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing and operational notification campaign performance metrics"
  source: "`sports_entertainment_ecm`.`platform`.`notification_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of campaign (draft, scheduled, active, completed, cancelled)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (promotional, transactional, event_alert, retention)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of campaign (urgent, high, normal, low)"
    - name: "channel_mix"
      expr: channel_mix
      comment: "Mix of channels used (email, push, sms, in_app)"
    - name: "ab_test_enabled"
      expr: ab_test_enabled
      comment: "Whether campaign includes A/B testing"
    - name: "gdpr_lawful_basis"
      expr: gdpr_lawful_basis
      comment: "GDPR lawful basis for campaign (consent, legitimate_interest, contract)"
    - name: "personalization_enabled"
      expr: send_time_optimization_enabled
      comment: "Whether send-time optimization personalization is enabled"
    - name: "campaign_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month of campaign start for trend analysis"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of notification campaigns"
    - name: "active_campaigns"
      expr: COUNT(CASE WHEN campaign_status = 'active' THEN 1 END)
      comment: "Count of currently active campaigns"
    - name: "completed_campaigns"
      expr: COUNT(CASE WHEN campaign_status = 'completed' THEN 1 END)
      comment: "Count of completed campaigns"
    - name: "total_sent"
      expr: SUM(CAST(total_sent AS BIGINT))
      comment: "Total notifications sent across all campaigns"
    - name: "total_delivered"
      expr: SUM(CAST(total_delivered AS BIGINT))
      comment: "Total notifications successfully delivered"
    - name: "total_opened"
      expr: SUM(CAST(total_opened AS BIGINT))
      comment: "Total notifications opened by recipients"
    - name: "total_clicked"
      expr: SUM(CAST(total_clicked AS BIGINT))
      comment: "Total notifications clicked, engagement metric"
    - name: "total_bounced"
      expr: SUM(CAST(total_bounced AS BIGINT))
      comment: "Total notifications bounced, deliverability quality metric"
    - name: "total_unsubscribed"
      expr: SUM(CAST(total_unsubscribed AS BIGINT))
      comment: "Total unsubscribes from campaigns, audience health metric"
    - name: "avg_target_segment_size"
      expr: AVG(CAST(target_segment_size AS DOUBLE))
      comment: "Average target segment size across campaigns"
    - name: "ab_tested_campaigns"
      expr: COUNT(CASE WHEN ab_test_enabled = TRUE THEN 1 END)
      comment: "Count of campaigns with A/B testing enabled, optimization metric"
    - name: "gdpr_compliant_campaigns"
      expr: COUNT(CASE WHEN gdpr_lawful_basis IS NOT NULL THEN 1 END)
      comment: "Count of campaigns with documented GDPR lawful basis, compliance metric"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test and experimentation program performance metrics for platform optimization"
  source: "`sports_entertainment_ecm`.`platform`.`ab_test`"
  dimensions:
    - name: "ab_test_status"
      expr: ab_test_status
      comment: "Current status of A/B test (draft, running, paused, completed, cancelled)"
    - name: "test_type"
      expr: test_type
      comment: "Type of test (feature, ui, algorithm, pricing, content)"
    - name: "test_category"
      expr: test_category
      comment: "Category of test (engagement, conversion, retention, monetization)"
    - name: "conclusion_type"
      expr: conclusion_type
      comment: "Conclusion of test (winner_found, no_difference, inconclusive)"
    - name: "rollout_decision"
      expr: rollout_decision
      comment: "Decision on rollout (full_rollout, partial_rollout, no_rollout)"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for traffic allocation (random, targeted, stratified)"
    - name: "gdpr_article22_applicable"
      expr: gdpr_article22_applicable
      comment: "Whether GDPR Article 22 automated decision-making applies"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when test started for trend analysis"
  measures:
    - name: "total_ab_tests"
      expr: COUNT(1)
      comment: "Total number of A/B tests in experimentation program"
    - name: "running_tests"
      expr: COUNT(CASE WHEN ab_test_status = 'running' THEN 1 END)
      comment: "Count of currently running A/B tests"
    - name: "completed_tests"
      expr: COUNT(CASE WHEN ab_test_status = 'completed' THEN 1 END)
      comment: "Count of completed A/B tests"
    - name: "tests_with_winner"
      expr: COUNT(CASE WHEN winning_variant_key IS NOT NULL THEN 1 END)
      comment: "Count of tests that identified a winning variant, program effectiveness metric"
    - name: "tests_rolled_out"
      expr: COUNT(CASE WHEN rollout_decision = 'full_rollout' THEN 1 END)
      comment: "Count of tests that resulted in full rollout, impact metric"
    - name: "avg_statistical_power"
      expr: AVG(CAST(statistical_power AS DOUBLE))
      comment: "Average statistical power across tests, rigor metric"
    - name: "avg_traffic_allocation_pct"
      expr: AVG(CAST(traffic_allocation_pct AS DOUBLE))
      comment: "Average traffic allocation percentage across tests"
    - name: "avg_minimum_detectable_effect"
      expr: AVG(CAST(minimum_detectable_effect AS DOUBLE))
      comment: "Average minimum detectable effect size, sensitivity metric"
    - name: "early_stopped_tests"
      expr: COUNT(CASE WHEN early_stopping_reason IS NOT NULL THEN 1 END)
      comment: "Count of tests stopped early, efficiency or issue indicator"
    - name: "gdpr_article22_tests"
      expr: COUNT(CASE WHEN gdpr_article22_applicable = TRUE THEN 1 END)
      comment: "Count of tests subject to GDPR Article 22, compliance tracking"
    - name: "ccpa_applicable_tests"
      expr: COUNT(CASE WHEN ccpa_applicable = TRUE THEN 1 END)
      comment: "Count of tests subject to CCPA, privacy compliance metric"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`platform_digital_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital touchpoint platform health, capability, and compliance metrics"
  source: "`sports_entertainment_ecm`.`platform`.`digital_touchpoint`"
  dimensions:
    - name: "touchpoint_status"
      expr: touchpoint_status
      comment: "Current status of touchpoint (active, deprecated, sunset, development)"
    - name: "platform_type"
      expr: platform_type
      comment: "Type of platform (web, mobile_app, smart_tv, voice_assistant, kiosk)"
    - name: "usage_type"
      expr: usage_type
      comment: "Usage type (consumer, partner, internal, api)"
    - name: "channel_category"
      expr: channel_category
      comment: "Category of channel (dtc, b2b, affiliate, white_label)"
    - name: "primary_market"
      expr: primary_market
      comment: "Primary geographic market for touchpoint"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status (approved, pending, rejected)"
    - name: "pci_scope"
      expr: pci_scope
      comment: "Whether touchpoint is in PCI compliance scope"
    - name: "gdpr_consent_required"
      expr: gdpr_consent_required
      comment: "Whether GDPR consent is required for touchpoint"
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of digital touchpoints in platform ecosystem"
    - name: "active_touchpoints"
      expr: COUNT(CASE WHEN touchpoint_status = 'active' THEN 1 END)
      comment: "Count of active digital touchpoints"
    - name: "streaming_capable_touchpoints"
      expr: COUNT(CASE WHEN content_streaming_capable = TRUE THEN 1 END)
      comment: "Count of touchpoints with streaming capability"
    - name: "ticketing_capable_touchpoints"
      expr: COUNT(CASE WHEN ticketing_capable = TRUE THEN 1 END)
      comment: "Count of touchpoints with ticketing capability"
    - name: "merchandise_capable_touchpoints"
      expr: COUNT(CASE WHEN merchandise_capable = TRUE THEN 1 END)
      comment: "Count of touchpoints with merchandise capability"
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_target_pct AS DOUBLE))
      comment: "Average uptime target percentage across touchpoints, reliability standard"
    - name: "avg_arpu_baseline_usd"
      expr: AVG(CAST(arpu_baseline_usd AS DOUBLE))
      comment: "Average ARPU baseline across touchpoints, monetization benchmark"
    - name: "avg_ltv_baseline_usd"
      expr: AVG(CAST(ltv_baseline_usd AS DOUBLE))
      comment: "Average LTV baseline across touchpoints, customer value benchmark"
    - name: "avg_cac_baseline_usd"
      expr: AVG(CAST(cac_baseline_usd AS DOUBLE))
      comment: "Average customer acquisition cost baseline across touchpoints"
    - name: "pci_scope_touchpoints"
      expr: COUNT(CASE WHEN pci_scope = TRUE THEN 1 END)
      comment: "Count of touchpoints in PCI compliance scope, security metric"
    - name: "gdpr_consent_touchpoints"
      expr: COUNT(CASE WHEN gdpr_consent_required = TRUE THEN 1 END)
      comment: "Count of touchpoints requiring GDPR consent, privacy compliance metric"
    - name: "ada_compliant_touchpoints"
      expr: COUNT(CASE WHEN ada_compliant = TRUE THEN 1 END)
      comment: "Count of ADA compliant touchpoints, accessibility metric"
$$;
