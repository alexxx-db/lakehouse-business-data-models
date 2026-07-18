-- Metric views for domain: loyalty | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member health and engagement metrics. Tracks active membership, points balances, tier distribution, and opt-in rates to steer program growth and retention strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`member`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current membership status (active, suspended, closed) — primary segmentation for member health analysis."
    - name: "current_tier"
      expr: current_tier
      comment: "Member's current loyalty tier — used to analyze tier distribution and upgrade/downgrade trends."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (app, web, in-store, drive-thru) — informs acquisition channel ROI."
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date the member enrolled — supports cohort analysis and tenure-based segmentation."
    - name: "tier_effective_date"
      expr: tier_effective_date
      comment: "Date the current tier became effective — used to measure tier tenure and upgrade velocity."
    - name: "last_activity_date"
      expr: last_activity_date
      comment: "Date of the member's most recent activity — key dimension for recency-based churn risk segmentation."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the member has opted into email communications — used to measure reachable audience size."
    - name: "push_notification_opt_in"
      expr: push_notification_opt_in
      comment: "Whether the member has opted into push notifications — used to measure mobile-reachable audience."
    - name: "sms_opt_in"
      expr: sms_opt_in
      comment: "Whether the member has opted into SMS communications — used to measure SMS-reachable audience."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Member's preferred communication language — supports localization and inclusivity reporting."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN program_status = 'active' THEN member_id END)
      comment: "Count of members with active program status. Core KPI for program scale and growth tracking."
    - name: "total_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Total distinct loyalty members across all statuses. Baseline for program reach and penetration."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Sum of all unredeemed points balances across members. Represents total loyalty liability on the program's books."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average unredeemed points balance per member. Indicates engagement depth and potential redemption pressure."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all points ever earned across members. Measures cumulative program engagement and accrual volume."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all points ever redeemed across members. Measures redemption utilization and program value delivery."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points at risk of expiration across all members. Drives urgency campaigns to prevent points breakage and member churn."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(DISTINCT member_id), 0), 2)
      comment: "Percentage of members opted into email. Measures reachable audience for email marketing campaigns."
    - name: "push_notification_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN push_notification_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(DISTINCT member_id), 0), 2)
      comment: "Percentage of members opted into push notifications. Measures mobile engagement channel reach."
    - name: "sms_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sms_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(DISTINCT member_id), 0), 2)
      comment: "Percentage of members opted into SMS. Measures direct mobile messaging reach for time-sensitive offers."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points economy metrics tracking accrual, redemption, adjustment, and reversal activity across the loyalty program. Drives financial liability management and member engagement analysis."
  source: "`vibe_restaurants_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (earn, redeem, adjust, expire, reverse) — primary dimension for points flow analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel that originated the points transaction (POS, app, OLO, drive-thru) — used to attribute points volume by channel."
    - name: "transaction_timestamp"
      expr: transaction_timestamp
      comment: "Timestamp of the points transaction — supports time-series trending of points economy activity."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction — aligns points liability reporting to financial close cycles."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction — supports year-over-year points economy comparison."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the transaction has been voided — used to filter clean vs. voided transactions in financial reporting."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for manual point adjustments — used to audit and categorize adjustment activity."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the transaction — used for reconciliation across POS, OLO, and app systems."
  measures:
    - name: "total_points_transactions"
      expr: COUNT(DISTINCT points_ledger_id)
      comment: "Total number of points ledger transactions. Baseline volume metric for points economy activity."
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value associated with points transactions. Measures the revenue base driving points accrual."
    - name: "avg_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value per points transaction. Indicates spend level of loyalty-engaged customers vs. non-members."
    - name: "total_points_earn_rate"
      expr: AVG(CAST(points_earn_rate AS DOUBLE))
      comment: "Average points earn rate applied across transactions. Monitors effective earn rate vs. program design targets."
    - name: "voided_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN points_ledger_id END) / NULLIF(COUNT(DISTINCT points_ledger_id), 0), 2)
      comment: "Percentage of points transactions that were voided. Elevated rates signal POS integration issues or fraud patterns."
    - name: "unique_members_transacting"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members with points ledger activity. Measures active engagement breadth across the member base."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption performance metrics tracking discount delivery, redemption rates, and financial impact. Core KPIs for evaluating offer ROI and promotional effectiveness."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (completed, voided, duplicate) — primary filter for valid vs. invalid redemption analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Loyalty tier of the redeeming member — used to analyze redemption behavior by tier and measure tier-specific offer ROI."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the redemption occurred (breakfast, lunch, dinner, late night) — used to optimize offer timing."
    - name: "redemption_timestamp"
      expr: redemption_timestamp
      comment: "Timestamp of the redemption event — supports time-series trending of redemption activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction — used for multi-currency financial reporting."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered to members. Measures the financial cost of the offer program and promotional liability."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Used to benchmark offer generosity and compare across offer types."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points redemption metrics tracking reward utilization, discount delivery, and fraud exposure. Measures how effectively members convert earned points into value."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the points redemption (completed, reversed, expired) — primary filter for valid redemption analysis."
    - name: "channel"
      expr: channel
      comment: "Channel where the redemption occurred (app, POS, OLO) — used to attribute redemption volume by channel."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward redeemed (free item, discount, experience) — used to analyze reward preference and redemption mix."
    - name: "member_tier"
      expr: member_tier
      comment: "Loyalty tier of the redeeming member — used to analyze redemption behavior by tier."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the redemption — used to optimize reward availability by time of day."
    - name: "redemption_timestamp"
      expr: redemption_timestamp
      comment: "Timestamp of the redemption — supports time-series trending of redemption activity."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the redemption was flagged for fraud — used to monitor fraud exposure in the redemption pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction — used for multi-currency financial reporting."
  measures:
    - name: "total_redemptions"
      expr: COUNT(DISTINCT redemption_id)
      comment: "Total number of points redemptions. Core volume KPI for reward utilization measurement."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered through points redemptions. Measures the financial cost of reward fulfillment."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Benchmarks reward generosity and cost per redemption event."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_total_before_discount AS DOUBLE))
      comment: "Total order value before redemption discount. Measures gross revenue baseline for redemption ROI calculation."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_total_after_discount AS DOUBLE))
      comment: "Total net order value after redemption discount. Measures net revenue retained after reward fulfillment."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across redemptions. Monitors overall fraud risk level in the redemption pipeline."
    - name: "fraud_flagged_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN redemption_id END) / NULLIF(COUNT(DISTINCT redemption_id), 0), 2)
      comment: "Percentage of redemptions flagged for fraud. Critical risk KPI — elevated rates trigger fraud investigation and controls review."
    - name: "unique_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who redeemed rewards. Measures active redemption participation breadth across the member base."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier movement and qualification metrics tracking upgrades, downgrades, and promotional tier activity. Drives tier strategy decisions and member progression management."
  source: "`vibe_restaurants_v1`.`loyalty`.`tier_history`"
  dimensions:
    - name: "tier_change_type"
      expr: tier_change_type
      comment: "Type of tier change (upgrade, downgrade, maintain, promotional) — primary dimension for tier movement analysis."
    - name: "tier_change_reason_code"
      expr: tier_change_reason_code
      comment: "Reason code for the tier change — used to categorize and audit tier movement drivers."
    - name: "new_tier_code"
      expr: new_tier_code
      comment: "The tier the member moved into — used to measure inflow volume by tier."
    - name: "previous_tier_code"
      expr: previous_tier_code
      comment: "The tier the member moved out of — used to measure outflow volume by tier and calculate churn between tiers."
    - name: "is_promotional_tier"
      expr: is_promotional_tier
      comment: "Whether the tier change was promotional (not earned) — used to separate organic vs. promotional tier movements."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Whether the tier change was a manual override — used to audit exception handling and override frequency."
    - name: "tier_change_timestamp"
      expr: tier_change_timestamp
      comment: "Timestamp of the tier change event — supports time-series trending of tier movement velocity."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify the member of their tier change — used to measure notification delivery effectiveness."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the new tier became effective — used for cohort analysis of tier progression timing."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(DISTINCT tier_history_id)
      comment: "Total number of tier change events. Baseline volume metric for tier movement activity."
    - name: "total_upgrades"
      expr: COUNT(CASE WHEN tier_change_type = 'upgrade' THEN tier_history_id END)
      comment: "Count of tier upgrade events. Measures upward member progression — a leading indicator of program health and engagement."
    - name: "total_downgrades"
      expr: COUNT(CASE WHEN tier_change_type = 'downgrade' THEN tier_history_id END)
      comment: "Count of tier downgrade events. Elevated downgrade rates signal declining engagement or overly aggressive qualification thresholds."
    - name: "upgrade_to_downgrade_ratio"
      expr: ROUND(COUNT(CASE WHEN tier_change_type = 'upgrade' THEN tier_history_id END) / NULLIF(COUNT(CASE WHEN tier_change_type = 'downgrade' THEN tier_history_id END), 0), 2)
      comment: "Ratio of upgrades to downgrades. A ratio above 1 indicates net positive tier progression — a key program health indicator."
    - name: "avg_qualifying_spend"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend amount at the time of tier change. Used to calibrate tier qualification thresholds against actual member behavior."
    - name: "avg_qualifying_points_balance"
      expr: AVG(CAST(qualifying_points_balance AS DOUBLE))
      comment: "Average qualifying points balance at tier change. Measures points accumulation required for tier transitions in practice."
    - name: "manual_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_override = TRUE THEN tier_history_id END) / NULLIF(COUNT(DISTINCT tier_history_id), 0), 2)
      comment: "Percentage of tier changes that were manual overrides. High rates indicate process exceptions that may need policy review."
    - name: "notification_sent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN tier_history_id END) / NULLIF(COUNT(DISTINCT tier_history_id), 0), 2)
      comment: "Percentage of tier changes where a notification was successfully sent. Measures member communication effectiveness for tier events."
    - name: "promotional_tier_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_promotional_tier = TRUE THEN tier_history_id END) / NULLIF(COUNT(DISTINCT tier_history_id), 0), 2)
      comment: "Percentage of tier changes that were promotional rather than earned. Used to assess reliance on promotional tier grants vs. organic progression."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member enrollment funnel metrics tracking acquisition volume, channel mix, fraud screening, and opt-in rates. Drives acquisition strategy and enrollment quality management."
  source: "`vibe_restaurants_v1`.`loyalty`.`enrollment_event`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the enrollment (completed, pending, rejected, fraud-blocked) — primary filter for valid enrollment analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment occurred (app, web, in-store, drive-thru) — used to attribute acquisition volume by channel."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (organic, referral, campaign-driven) — used to measure acquisition source mix."
    - name: "enrollment_country_code"
      expr: enrollment_country_code
      comment: "Country where enrollment occurred — used for geographic acquisition analysis and compliance reporting."
    - name: "enrollment_device_type"
      expr: enrollment_device_type
      comment: "Device type used for enrollment (iOS, Android, web) — used to optimize enrollment UX by device."
    - name: "enrollment_timestamp"
      expr: enrollment_timestamp
      comment: "Timestamp of the enrollment event — supports time-series trending of acquisition velocity."
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Result of the fraud check at enrollment (passed, flagged, blocked) — used to monitor enrollment fraud exposure."
    - name: "verification_required_flag"
      expr: verification_required_flag
      comment: "Whether identity verification was required at enrollment — used to analyze friction in the enrollment funnel."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_event_id)
      comment: "Total number of enrollment events. Core acquisition volume KPI for program growth tracking."
    - name: "verified_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_completed_flag = TRUE THEN enrollment_event_id END) / NULLIF(COUNT(DISTINCT enrollment_event_id), 0), 2)
      comment: "Percentage of enrollments where identity verification was completed. Measures enrollment quality and fraud mitigation effectiveness."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in_flag = TRUE THEN enrollment_event_id END) / NULLIF(COUNT(DISTINCT enrollment_event_id), 0), 2)
      comment: "Percentage of new enrollees who opted into email at enrollment. Measures reachable audience captured at acquisition."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in_flag = TRUE THEN enrollment_event_id END) / NULLIF(COUNT(DISTINCT enrollment_event_id), 0), 2)
      comment: "Percentage of new enrollees who opted into marketing communications. Measures marketable audience captured at acquisition."
    - name: "welcome_offer_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN welcome_offer_issued_flag = TRUE THEN enrollment_event_id END) / NULLIF(COUNT(DISTINCT enrollment_event_id), 0), 2)
      comment: "Percentage of enrollments where a welcome offer was issued. Measures welcome offer program execution completeness."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score at enrollment. Monitors overall fraud risk level in the enrollment pipeline — elevated scores trigger controls review."
    - name: "referral_enrollment_count"
      expr: COUNT(CASE WHEN referral_code IS NOT NULL THEN enrollment_event_id END)
      comment: "Count of enrollments driven by a referral code. Measures referral program effectiveness as an acquisition channel."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_challenge_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Challenge participation and completion metrics tracking member engagement with gamification challenges. Drives challenge design decisions and reward ROI analysis."
  source: "`vibe_restaurants_v1`.`loyalty`.`challenge_enrollment`"
  dimensions:
    - name: "challenge_enrollment_status"
      expr: challenge_enrollment_status
      comment: "Status of the challenge enrollment (active, completed, cancelled, disqualified) — primary filter for valid participation analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled in the challenge — used to attribute challenge participation by channel."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward offered for challenge completion — used to analyze reward preference and completion rate by reward type."
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date the member enrolled in the challenge — supports cohort analysis of challenge participation timing."
    - name: "completion_date"
      expr: completion_date
      comment: "Date the member completed the challenge — used to measure time-to-completion and challenge velocity."
    - name: "opt_in_flag"
      expr: opt_in_flag
      comment: "Whether the member explicitly opted into the challenge — used to distinguish opt-in vs. auto-enrolled participation."
    - name: "reward_issued_flag"
      expr: reward_issued_flag
      comment: "Whether the challenge reward was issued — used to monitor reward fulfillment completeness."
  measures:
    - name: "total_challenge_enrollments"
      expr: COUNT(DISTINCT challenge_enrollment_id)
      comment: "Total number of challenge enrollments. Baseline volume metric for gamification engagement."
    - name: "total_completions"
      expr: COUNT(CASE WHEN challenge_enrollment_status = 'completed' THEN challenge_enrollment_id END)
      comment: "Total number of challenge completions. Measures successful engagement outcomes from gamification initiatives."
    - name: "challenge_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN challenge_enrollment_status = 'completed' THEN challenge_enrollment_id END) / NULLIF(COUNT(DISTINCT challenge_enrollment_id), 0), 2)
      comment: "Percentage of challenge enrollments that resulted in completion. Core KPI for challenge design effectiveness — low rates indicate overly difficult or poorly designed challenges."
    - name: "reward_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reward_issued_flag = TRUE THEN challenge_enrollment_id END) / NULLIF(COUNT(CASE WHEN challenge_enrollment_status = 'completed' THEN challenge_enrollment_id END), 0), 2)
      comment: "Percentage of completed challenges where the reward was issued. Measures reward fulfillment execution quality."
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average completion progress percentage across all active enrollments. Measures overall member advancement toward challenge goals."
    - name: "total_reward_value_issued"
      expr: SUM(CASE WHEN reward_issued_flag = TRUE THEN CAST(reward_value AS DOUBLE) ELSE 0 END)
      comment: "Total monetary value of rewards issued for challenge completions. Measures the financial cost of the challenge reward program."
    - name: "unique_participating_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members participating in challenges. Measures gamification reach across the member base."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer distribution and engagement metrics tracking delivery, open, click, and redemption funnel performance. Drives offer targeting strategy and personalization ROI."
  source: "`vibe_restaurants_v1`.`loyalty`.`offer_assignment`"
  dimensions:
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of offer assignment (targeted, broadcast, triggered) — used to compare performance across assignment strategies."
    - name: "assignment_channel"
      expr: assignment_channel
      comment: "Channel used to assign/deliver the offer (push, email, in-app, SMS) — used to measure channel-level offer engagement."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of offer delivery (delivered, failed, pending) — used to monitor offer distribution execution quality."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Redemption status of the assigned offer (redeemed, unredeemed, expired) — primary dimension for conversion funnel analysis."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant assigned — used to compare offer performance across test and control groups."
    - name: "assignment_timestamp"
      expr: assignment_timestamp
      comment: "Timestamp of offer assignment — supports time-series trending of offer distribution activity."
    - name: "is_wallet_visible"
      expr: is_wallet_visible
      comment: "Whether the offer is visible in the member's wallet — used to measure wallet placement impact on redemption rates."
  measures:
    - name: "total_offer_assignments"
      expr: COUNT(DISTINCT offer_assignment_id)
      comment: "Total number of offer assignments. Baseline volume metric for offer distribution reach."
    - name: "offer_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'delivered' THEN offer_assignment_id END) / NULLIF(COUNT(DISTINCT offer_assignment_id), 0), 2)
      comment: "Percentage of assigned offers successfully delivered. Measures distribution execution quality and channel reliability."
    - name: "offer_open_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN opened_timestamp IS NOT NULL THEN offer_assignment_id END) / NULLIF(COUNT(CASE WHEN delivery_status = 'delivered' THEN offer_assignment_id END), 0), 2)
      comment: "Percentage of delivered offers that were opened by the member. Measures offer creative and messaging effectiveness."
    - name: "offer_click_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clicked_timestamp IS NOT NULL THEN offer_assignment_id END) / NULLIF(COUNT(CASE WHEN opened_timestamp IS NOT NULL THEN offer_assignment_id END), 0), 2)
      comment: "Percentage of opened offers that were clicked. Measures offer call-to-action effectiveness and intent-to-redeem signal."
    - name: "offer_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'redeemed' THEN offer_assignment_id END) / NULLIF(COUNT(DISTINCT offer_assignment_id), 0), 2)
      comment: "Percentage of assigned offers that were redeemed. Core offer ROI KPI — directly measures conversion from distribution to revenue impact."
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalization score of assigned offers. Measures the targeting quality of the personalization engine — higher scores should correlate with higher redemption rates."
    - name: "unique_members_receiving_offers"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who received offer assignments. Measures offer program reach across the member base."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty segment definition and sizing metrics tracking segment composition, predicted value, and campaign utilization. Drives audience strategy and segmentation ROI decisions."
  source: "`vibe_restaurants_v1`.`loyalty`.`loyalty_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, predictive, geographic) — used to analyze segment strategy mix."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, inactive, draft) — primary filter for active segment analysis."
    - name: "channel_preference"
      expr: channel_preference
      comment: "Preferred communication channel for the segment — used to align offer distribution strategy with segment preferences."
    - name: "daypart_preference"
      expr: daypart_preference
      comment: "Preferred daypart for the segment — used to optimize offer timing and campaign scheduling."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Whether the segment is a control group — used to separate test and control populations in campaign measurement."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Whether the segment is a test segment — used to filter production vs. test segments in reporting."
    - name: "activation_date"
      expr: activation_date
      comment: "Date the segment was activated — supports cohort analysis of segment lifecycle."
  measures:
    - name: "total_active_segments"
      expr: COUNT(CASE WHEN segment_status = 'active' THEN loyalty_segment_id END)
      comment: "Count of active loyalty segments. Measures the breadth of audience segmentation strategy in production."
    - name: "total_segment_members"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Total members across all segments. Measures the aggregate addressable audience across the segmentation strategy."
    - name: "avg_segment_size"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average number of members per segment. Used to assess segment granularity — very small segments may be over-segmented."
    - name: "total_predicted_incremental_revenue"
      expr: SUM(CAST(predicted_incremental_revenue AS DOUBLE))
      comment: "Total predicted incremental revenue across all active segments. Measures the expected financial return from the segmentation and targeting strategy."
    - name: "avg_predicted_response_rate"
      expr: AVG(CAST(predicted_response_rate AS DOUBLE))
      comment: "Average predicted response rate across segments. Benchmarks model-predicted engagement vs. actual redemption rates to validate the personalization engine."
    - name: "total_lifetime_points_min_threshold"
      expr: AVG(CAST(lifetime_points_min AS DOUBLE))
      comment: "Average minimum lifetime points threshold used to define segments. Measures the engagement bar set for segment qualification."
    - name: "total_acv_max_threshold"
      expr: AVG(CAST(acv_max_threshold AS DOUBLE))
      comment: "Average maximum ACV threshold used in segment definitions. Used to calibrate high-value customer segment boundaries."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral program performance metrics tracking conversion rates, bonus delivery, and fraud exposure. Drives referral program design and acquisition cost optimization."
  source: "`vibe_restaurants_v1`.`loyalty`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Status of the referral (pending, converted, expired, fraud-blocked) — primary filter for valid referral analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the referral was made (app, social, email, in-store) — used to attribute referral volume by channel."
    - name: "source_platform"
      expr: source_platform
      comment: "Platform from which the referral originated — used to measure referral source effectiveness."
    - name: "referral_date"
      expr: referral_date
      comment: "Date the referral was made — supports time-series trending of referral program activity."
    - name: "conversion_date"
      expr: conversion_date
      comment: "Date the referred member converted — used to measure time-to-conversion and referral funnel velocity."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the referral was flagged for fraud — used to monitor referral fraud exposure."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total number of referrals made. Baseline volume metric for referral program activity."
    - name: "total_conversions"
      expr: COUNT(CASE WHEN referral_status = 'converted' THEN referral_id END)
      comment: "Total number of referrals that converted to enrolled members. Core acquisition KPI for referral program effectiveness."
    - name: "referral_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_status = 'converted' THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals that converted to enrolled members. Primary ROI metric for the referral acquisition program."
    - name: "avg_first_transaction_amount"
      expr: AVG(CAST(first_transaction_amount AS DOUBLE))
      comment: "Average first transaction amount of referred members. Measures the initial spend quality of referral-acquired members vs. organic acquisition."
    - name: "fraud_flagged_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals flagged for fraud. Elevated rates indicate referral abuse patterns requiring program controls review."
    - name: "unique_referring_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who made referrals. Measures the breadth of referral program participation across the member base."
$$;
