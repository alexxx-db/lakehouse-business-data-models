-- Metric views for domain: loyalty | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty membership KPIs tracking active member base, engagement health, points economics, and tier distribution. Used by CMO and Loyalty VP to steer program investment and retention strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`member`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current membership status (active, suspended, closed) for cohort segmentation."
    - name: "current_tier"
      expr: current_tier
      comment: "Member's current loyalty tier for tier-based performance analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (app, in-store, web) to evaluate acquisition channel effectiveness."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for cohort and vintage analysis."
    - name: "tier_effective_date_month"
      expr: DATE_TRUNC('MONTH', tier_effective_date)
      comment: "Month when current tier became effective, used for tier upgrade trend analysis."
    - name: "last_activity_date_month"
      expr: DATE_TRUNC('MONTH', last_activity_date)
      comment: "Month of last member activity for recency segmentation."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether member has opted into email communications, for reachability analysis."
    - name: "push_notification_opt_in"
      expr: push_notification_opt_in
      comment: "Whether member has opted into push notifications, for digital engagement analysis."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN program_status = 'active' THEN member_id END)
      comment: "Count of members with active program status. Primary KPI for program scale and health."
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total member records regardless of status. Used as denominator for activation and churn rate calculations."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all lifetime points earned across members. Indicates total program engagement volume and liability exposure."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all lifetime points redeemed. Measures redemption activity and program value delivery to members."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total unredeemed points balance across all members. Represents outstanding loyalty liability on the balance sheet."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average points balance per member. Indicates typical member engagement depth and pending redemption potential."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across members. Key satisfaction and advocacy KPI for loyalty program health."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points at risk of expiration. Drives urgency campaigns and re-engagement initiatives."
    - name: "members_with_email_opt_in"
      expr: COUNT(CASE WHEN email_opt_in = TRUE THEN member_id END)
      comment: "Count of members opted into email. Determines reachable audience size for email marketing campaigns."
    - name: "members_with_push_opt_in"
      expr: COUNT(CASE WHEN push_notification_opt_in = TRUE THEN member_id END)
      comment: "Count of members opted into push notifications. Determines mobile-reachable audience for real-time offers."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points economics and transaction-level KPIs tracking earn/burn patterns, order value, and points liability. Used by Finance and Loyalty teams to manage program economics and liability."
  source: "`vibe_restaurants_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (earn, redeem, adjust, expire) for earn/burn analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel where the transaction originated (app, POS, web, delivery) for channel economics analysis."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of transaction for trend and seasonality analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting alignment."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual financial reporting."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the transaction was voided, for data quality and fraud monitoring."
    - name: "restaurant_number"
      expr: restaurant_number
      comment: "Restaurant identifier for unit-level points economics analysis."
  measures:
    - name: "total_points_transactions"
      expr: COUNT(1)
      comment: "Total number of points ledger transactions. Baseline volume metric for program activity."
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value associated with points transactions. Measures revenue driven by loyalty program engagement."
    - name: "avg_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value per loyalty transaction. Key indicator of loyalty member spend vs. non-member baseline."
    - name: "total_points_balance_after"
      expr: SUM(CAST(points_balance_after AS DOUBLE))
      comment: "Sum of post-transaction points balances. Proxy for total outstanding points liability at a point in time."
    - name: "avg_points_earn_rate"
      expr: AVG(CAST(points_earn_rate AS DOUBLE))
      comment: "Average points earn rate per transaction. Monitors program generosity and cost-per-engagement."
    - name: "voided_transaction_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN points_ledger_id END)
      comment: "Count of voided points transactions. Elevated void rates signal fraud, system errors, or operational issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward redemption KPIs measuring program value delivery, discount economics, fraud exposure, and member redemption behavior. Used by Loyalty and Finance leadership to optimize reward catalog and cost management."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (completed, voided, pending) for pipeline and completion analysis."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward redeemed (free item, discount, points) for reward catalog performance analysis."
    - name: "channel"
      expr: channel
      comment: "Redemption channel (app, POS, drive-thru, delivery) for channel-level redemption analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier at time of redemption for tier-based value analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of redemption (breakfast, lunch, dinner) for time-of-day redemption pattern analysis."
    - name: "redemption_date_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption for trend analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the redemption was flagged as fraudulent, for fraud monitoring."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total redemption events. Primary volume KPI for reward program utilization."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered through redemptions. Represents direct program cost and member value delivered."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Monitors reward generosity and cost-per-redemption trends."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_total_before_discount AS DOUBLE))
      comment: "Total order value before loyalty discount applied. Measures gross revenue influenced by loyalty redemptions."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_total_after_discount AS DOUBLE))
      comment: "Total net order value after loyalty discount. Measures net revenue from loyalty-influenced transactions."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across redemptions. Elevated scores indicate systemic fraud risk requiring investigation."
    - name: "fraudulent_redemption_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN redemption_id END)
      comment: "Count of redemptions flagged as fraudulent. Key risk KPI for loyalty program integrity."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who redeemed rewards. Measures active redemption participation rate denominator."
    - name: "avg_points_balance_before"
      expr: AVG(CAST(points_balance_before AS DOUBLE))
      comment: "Average points balance before redemption. Indicates typical member engagement depth at redemption trigger."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer-level redemption performance KPIs measuring discount delivery, offer effectiveness, and channel attribution. Used by Marketing and Loyalty teams to optimize offer strategy and ROI."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (completed, voided, duplicate) for quality analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier at time of offer redemption for tier-based offer performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of offer redemption for time-of-day offer performance analysis."
    - name: "redemption_date_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of offer redemption for trend analysis."
  measures:
    - name: "total_offer_redemptions"
      expr: COUNT(1)
      comment: "Total offer redemption events. Primary volume KPI for offer utilization."
    - name: "total_discount_delivered"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered through offer redemptions. Represents direct offer program cost."
    - name: "avg_discount_per_redemption"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per offer redemption. Monitors offer cost efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier movement KPIs tracking upgrade/downgrade velocity, qualification economics, and tier program health. Used by Loyalty leadership to evaluate tier structure effectiveness and member progression."
  source: "`vibe_restaurants_v1`.`loyalty`.`tier_history`"
  dimensions:
    - name: "tier_change_type"
      expr: tier_change_type
      comment: "Type of tier change (upgrade, downgrade, maintain, initial) for tier movement analysis."
    - name: "new_tier_code"
      expr: new_tier_code
      comment: "Tier the member moved into, for destination tier analysis."
    - name: "previous_tier_code"
      expr: previous_tier_code
      comment: "Tier the member moved from, for origin tier analysis."
    - name: "tier_change_reason_code"
      expr: tier_change_reason_code
      comment: "Reason code for the tier change for root cause analysis of tier movements."
    - name: "is_promotional_tier"
      expr: is_promotional_tier
      comment: "Whether the tier change was promotional vs. earned, for organic vs. promotional tier analysis."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Whether the tier change was a manual override, for operational quality monitoring."
    - name: "tier_change_date_month"
      expr: DATE_TRUNC('MONTH', tier_change_timestamp)
      comment: "Month of tier change for trend analysis."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify member of tier change, for communication effectiveness analysis."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(1)
      comment: "Total tier change events. Baseline volume metric for tier program activity."
    - name: "tier_upgrades"
      expr: COUNT(CASE WHEN tier_change_type = 'upgrade' THEN tier_history_id END)
      comment: "Count of tier upgrades. Key indicator of member progression and program engagement success."
    - name: "tier_downgrades"
      expr: COUNT(CASE WHEN tier_change_type = 'downgrade' THEN tier_history_id END)
      comment: "Count of tier downgrades. Elevated downgrades signal member disengagement or over-generous tier thresholds."
    - name: "avg_qualifying_spend"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend amount at time of tier change. Benchmarks tier qualification economics."
    - name: "avg_qualifying_points_balance"
      expr: AVG(CAST(qualifying_points_balance AS DOUBLE))
      comment: "Average qualifying points balance at tier change. Indicates typical engagement depth required for tier movement."
    - name: "avg_tier_duration_days"
      expr: AVG(CAST(tier_duration_days AS DOUBLE))
      comment: "Average number of days members spend in a tier before changing. Measures tier stickiness and progression velocity."
    - name: "manual_override_count"
      expr: COUNT(CASE WHEN is_manual_override = TRUE THEN tier_history_id END)
      comment: "Count of manual tier overrides. High counts indicate operational exceptions requiring process review."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN tier_history_id END)
      comment: "Count of tier changes where notification was sent. Measures member communication coverage for tier events."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member enrollment KPIs tracking acquisition volume, channel mix, fraud screening, and welcome offer delivery. Used by Marketing and Loyalty leadership to optimize acquisition strategy and onboarding quality."
  source: "`vibe_restaurants_v1`.`loyalty`.`enrollment_event`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the enrollment (completed, pending, rejected) for funnel analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment occurred for acquisition channel attribution."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (organic, referral, campaign) for acquisition source analysis."
    - name: "enrollment_country_code"
      expr: enrollment_country_code
      comment: "Country of enrollment for geographic acquisition analysis."
    - name: "enrollment_device_type"
      expr: enrollment_device_type
      comment: "Device type used for enrollment (mobile, desktop, kiosk) for UX optimization."
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Result of fraud screening at enrollment for acquisition quality monitoring."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_timestamp)
      comment: "Month of enrollment for acquisition trend analysis."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Whether member opted into email at enrollment, for reachable acquisition analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total enrollment events. Primary acquisition volume KPI for loyalty program growth."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'completed' THEN enrollment_event_id END)
      comment: "Count of successfully completed enrollments. Measures effective acquisition after funnel drop-off."
    - name: "verified_enrollments"
      expr: COUNT(CASE WHEN verification_completed_flag = TRUE THEN enrollment_event_id END)
      comment: "Count of enrollments with completed identity verification. Measures data quality and fraud prevention coverage."
    - name: "welcome_offer_issued_count"
      expr: COUNT(CASE WHEN welcome_offer_issued_flag = TRUE THEN enrollment_event_id END)
      comment: "Count of enrollments where welcome offer was issued. Measures onboarding offer delivery rate."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score at enrollment. Elevated scores indicate acquisition quality issues or bot activity."
    - name: "referral_enrollments"
      expr: COUNT(CASE WHEN referral_code IS NOT NULL THEN enrollment_event_id END)
      comment: "Count of enrollments attributed to referrals. Measures referral program effectiveness as an acquisition channel."
    - name: "email_opt_in_enrollments"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN enrollment_event_id END)
      comment: "Count of enrollments with email opt-in. Measures reachable audience growth from new acquisitions."
    - name: "terms_accepted_enrollments"
      expr: COUNT(CASE WHEN terms_accepted_flag = TRUE THEN enrollment_event_id END)
      comment: "Count of enrollments with terms accepted. Compliance KPI for regulatory and legal requirements."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_challenge_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Challenge participation and completion KPIs measuring gamification engagement, reward delivery, and challenge ROI. Used by Loyalty and Marketing teams to optimize challenge design and member activation."
  source: "`vibe_restaurants_v1`.`loyalty`.`challenge_enrollment`"
  dimensions:
    - name: "challenge_enrollment_status"
      expr: challenge_enrollment_status
      comment: "Status of the challenge enrollment (active, completed, cancelled, disqualified) for funnel analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which member enrolled in the challenge for channel attribution."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or campaign that drove challenge enrollment for attribution analysis."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward offered for challenge completion for reward mechanics analysis."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_timestamp)
      comment: "Month of challenge enrollment for trend analysis."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of challenge completion for completion velocity analysis."
    - name: "reward_issued_flag"
      expr: reward_issued_flag
      comment: "Whether the challenge reward was issued, for reward delivery monitoring."
  measures:
    - name: "total_challenge_enrollments"
      expr: COUNT(1)
      comment: "Total challenge enrollment events. Baseline volume KPI for gamification program participation."
    - name: "completed_challenges"
      expr: COUNT(CASE WHEN challenge_enrollment_status = 'completed' THEN challenge_enrollment_id END)
      comment: "Count of completed challenge enrollments. Measures challenge completion rate numerator."
    - name: "rewards_issued"
      expr: COUNT(CASE WHEN reward_issued_flag = TRUE THEN challenge_enrollment_id END)
      comment: "Count of challenge enrollments where reward was issued. Measures reward delivery fulfillment rate."
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average challenge completion progress percentage. Indicates typical member engagement depth with challenges."
    - name: "avg_reward_value"
      expr: AVG(CAST(reward_value AS DOUBLE))
      comment: "Average reward value for completed challenges. Monitors challenge cost-per-completion economics."
    - name: "total_reward_value_issued"
      expr: SUM(CASE WHEN reward_issued_flag = TRUE THEN CAST(reward_value AS DOUBLE) ELSE 0 END)
      comment: "Total reward value issued through challenge completions. Measures total challenge program cost."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty visit KPIs measuring member visit frequency, spend per visit, and qualifying visit rates. Used by Loyalty and Operations leadership to evaluate program-driven traffic and spend lift."
  source: "`vibe_restaurants_v1`.`loyalty`.`loyalty_visit`"
  dimensions:
    - name: "visit_channel"
      expr: visit_channel
      comment: "Channel of the loyalty visit (in-store, drive-thru, delivery, app) for channel mix analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the visit (breakfast, lunch, dinner, late night) for time-of-day traffic analysis."
    - name: "is_qualifying_visit"
      expr: is_qualifying_visit
      comment: "Whether the visit qualified for points earning, for program engagement quality analysis."
    - name: "visit_date_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of visit for trend and seasonality analysis."
    - name: "visit_date_week"
      expr: DATE_TRUNC('WEEK', visit_date)
      comment: "Week of visit for weekly traffic pattern analysis."
  measures:
    - name: "total_loyalty_visits"
      expr: COUNT(1)
      comment: "Total loyalty member visits. Primary traffic KPI for program-driven visit volume."
    - name: "qualifying_visits"
      expr: COUNT(CASE WHEN is_qualifying_visit = TRUE THEN loyalty_visit_id END)
      comment: "Count of visits that qualified for points earning. Measures effective program engagement rate."
    - name: "total_visit_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend across all loyalty member visits. Measures revenue directly attributable to loyalty members."
    - name: "avg_spend_per_visit"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend per loyalty visit. Key indicator of loyalty member check average vs. non-member baseline."
    - name: "total_check_amount"
      expr: SUM(CAST(check_amount AS DOUBLE))
      comment: "Total check amount across loyalty visits. Measures gross transaction value from loyalty members."
    - name: "avg_check_amount"
      expr: AVG(CAST(check_amount AS DOUBLE))
      comment: "Average check amount per loyalty visit. Monitors loyalty member average transaction value trends."
    - name: "distinct_visiting_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members with visits in the period. Measures active member base generating traffic."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_program_campaign_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program-campaign budget allocation KPIs tracking marketing investment distribution across loyalty programs. Used by Marketing Finance and Loyalty leadership to govern campaign spend allocation and ROI accountability."
  source: "`vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the budget allocation (active, pending, closed) for pipeline management."
    - name: "program_campaign_allocation_status"
      expr: program_campaign_allocation_status
      comment: "Detailed allocation status for workflow tracking."
    - name: "currency"
      expr: currency
      comment: "Currency of the allocation for multi-currency program analysis."
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the campaign allocation for audience-based budget analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of allocation for budget trend analysis."
    - name: "allocation_start_date_month"
      expr: DATE_TRUNC('MONTH', allocation_start_date)
      comment: "Month allocation period begins for forward-looking budget planning."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total program-campaign allocation records. Baseline volume for allocation activity."
    - name: "total_allocated_budget"
      expr: SUM(CAST(allocated_budget AS DOUBLE))
      comment: "Total budget allocated across program-campaign combinations. Primary financial KPI for loyalty marketing investment."
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total allocation amount committed. Measures actual committed spend vs. allocated budget."
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average allocation percentage per program-campaign pair. Monitors budget concentration and diversification."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocation value. Used for financial reconciliation against marketing fund contributions."
    - name: "distinct_programs_funded"
      expr: COUNT(DISTINCT program_id)
      comment: "Count of distinct loyalty programs receiving campaign budget. Measures program portfolio investment breadth."
    - name: "distinct_campaigns_allocated"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Count of distinct campaigns with loyalty program allocations. Measures campaign portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points adjustment KPIs tracking manual and systematic corrections to member balances. Used by Loyalty Operations and Finance to monitor adjustment volume, reasons, and financial impact on program liability."
  source: "`vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (credit, debit, correction, goodwill) for adjustment category analysis."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Business reason for the adjustment for root cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment for operational reporting."
    - name: "loyalty_adjustment_status"
      expr: loyalty_adjustment_status
      comment: "Status of the adjustment (approved, pending, reversed) for workflow monitoring."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the adjustment is a reversal of a prior adjustment, for net adjustment analysis."
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month of adjustment for trend analysis."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total adjustment records. Baseline volume KPI for operational exception monitoring."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total net adjustment amount. Measures financial impact of manual corrections on program liability."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment amount per record. Monitors typical correction magnitude for anomaly detection."
    - name: "total_points_adjusted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points adjusted across all records. Measures points liability impact from manual corrections."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN loyalty_adjustment_id END)
      comment: "Count of reversal adjustments. High reversal rates indicate upstream processing errors requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer catalog performance and configuration metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type/category of the offer"
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer"
    - name: "start_date"
      expr: DATE_TRUNC('day', start_date)
      comment: "Offer start date"
    - name: "end_date"
      expr: DATE_TRUNC('day', end_date)
      comment: "Offer end date"
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of offers defined"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value across offers"
    - name: "total_points_multiplier"
      expr: SUM(CAST(points_multiplier AS DOUBLE))
      comment: "Sum of points multiplier configured for offers"
    - name: "stackable_offers_count"
      expr: COUNT(CASE WHEN stackable_flag THEN 1 END)
      comment: "Number of offers that are stackable"
$$;