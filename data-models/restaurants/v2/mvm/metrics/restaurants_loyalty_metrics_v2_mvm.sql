-- Metric views for domain: loyalty | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member health and engagement metrics. Tracks active membership base, points economics, tier distribution, and opt-in rates to steer program growth and retention strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`member`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the member's loyalty program enrollment (e.g., Active, Suspended, Closed). Primary segmentation for member health analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g., App, Web, In-Store, Drive-Thru). Used to evaluate channel acquisition effectiveness."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of member enrollment. Enables cohort analysis and trend tracking of new member acquisition over time."
    - name: "tier_effective_date_month"
      expr: DATE_TRUNC('MONTH', tier_effective_date)
      comment: "Month the current tier became effective. Used to track tier upgrade/downgrade velocity."
    - name: "last_activity_date_month"
      expr: DATE_TRUNC('MONTH', last_activity_date)
      comment: "Month of the member's most recent activity. Supports recency segmentation and churn risk identification."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Member's preferred communication language. Supports localization and targeted campaign planning."
    - name: "birthday_month"
      expr: birthday_month
      comment: "Month of the member's birthday. Enables birthday reward campaign targeting and seasonal engagement analysis."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the member has opted into email communications. Key dimension for reachable audience sizing."
    - name: "sms_opt_in"
      expr: sms_opt_in
      comment: "Whether the member has opted into SMS communications. Used to size SMS-reachable audience."
    - name: "push_notification_opt_in"
      expr: push_notification_opt_in
      comment: "Whether the member has opted into push notifications. Used to size push-reachable audience for mobile campaigns."
    - name: "gamification_level"
      expr: gamification_level
      comment: "Member's current gamification level. Indicates engagement depth and progression within the loyalty program."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN member_id END)
      comment: "Total number of members with Active program status. Core KPI for measuring the size and health of the loyalty program base."
    - name: "total_members"
      expr: COUNT(member_id)
      comment: "Total count of all loyalty members regardless of status. Used as the denominator for activation and engagement rate calculations."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all lifetime points earned across the member base. Reflects total program engagement and points liability exposure."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all lifetime points redeemed across the member base. Measures program value delivery and redemption health."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points balance per member. Indicates unredeemed points liability and member engagement level."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all members. Represents the aggregate unredeemed points liability on the program."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across loyalty members. Direct indicator of member satisfaction and likelihood to recommend the brand."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points flagged as expiring soon across all members. Drives urgency-based re-engagement campaigns to prevent points lapse."
    - name: "members_with_email_opt_in"
      expr: COUNT(CASE WHEN email_opt_in = TRUE THEN member_id END)
      comment: "Count of members opted into email communications. Defines the reachable email audience for loyalty campaigns."
    - name: "members_with_sms_opt_in"
      expr: COUNT(CASE WHEN sms_opt_in = TRUE THEN member_id END)
      comment: "Count of members opted into SMS communications. Defines the reachable SMS audience for loyalty campaigns."
    - name: "avg_lifetime_points_earned"
      expr: AVG(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Average lifetime points earned per member. Benchmarks member engagement depth and program stickiness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program enrollment funnel and acquisition metrics. Tracks enrollment volume, channel mix, fraud risk, and opt-in rates to optimize member acquisition strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`enrollment_event`"
  dimensions:
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment occurred (e.g., App, Web, In-Store). Primary dimension for acquisition channel performance analysis."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment event (e.g., New, Re-enrollment, Transfer). Distinguishes net-new acquisition from win-back activity."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment event (e.g., Completed, Pending, Rejected). Used to measure enrollment completion rates."
    - name: "enrollment_timestamp_month"
      expr: DATE_TRUNC('MONTH', enrollment_timestamp)
      comment: "Month of enrollment. Enables trend analysis of new member acquisition volume over time."
    - name: "enrollment_country_code"
      expr: enrollment_country_code
      comment: "Country in which the enrollment occurred. Supports geographic acquisition analysis and market expansion tracking."
    - name: "enrollment_device_type"
      expr: enrollment_device_type
      comment: "Device type used during enrollment (e.g., iOS, Android, Desktop). Informs digital channel investment decisions."
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Result of the fraud check performed at enrollment (e.g., Passed, Flagged, Blocked). Used to monitor enrollment fraud risk."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral that drove the enrollment. Measures referral program effectiveness and word-of-mouth acquisition."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Whether the enrolling member opted into email at enrollment. Tracks opt-in capture rate at the point of acquisition."
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Whether the enrolling member opted into marketing communications at enrollment."
    - name: "verification_completed_flag"
      expr: verification_completed_flag
      comment: "Whether identity verification was completed during enrollment. Tracks verification completion rates and friction points."
  measures:
    - name: "total_enrollments"
      expr: COUNT(enrollment_event_id)
      comment: "Total number of enrollment events. Primary volume KPI for loyalty program acquisition performance."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Completed' THEN enrollment_event_id END)
      comment: "Count of enrollments that reached Completed status. Measures successful acquisition funnel conversion."
    - name: "welcome_offer_issued_count"
      expr: COUNT(CASE WHEN welcome_offer_issued_flag = TRUE THEN enrollment_event_id END)
      comment: "Count of enrollments where a welcome offer was issued. Tracks welcome offer distribution rate and acquisition incentive spend."
    - name: "verified_enrollments"
      expr: COUNT(CASE WHEN verification_completed_flag = TRUE THEN enrollment_event_id END)
      comment: "Count of enrollments where identity verification was completed. Measures verified member quality and fraud mitigation effectiveness."
    - name: "flagged_fraud_enrollments"
      expr: COUNT(CASE WHEN fraud_check_status = 'Flagged' THEN enrollment_event_id END)
      comment: "Count of enrollments flagged by fraud checks. Monitors enrollment fraud risk and program integrity."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score at enrollment. Tracks overall fraud risk level across the enrollment population."
    - name: "email_opt_in_enrollments"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN enrollment_event_id END)
      comment: "Count of enrollments with email opt-in captured. Measures email consent capture rate at acquisition."
    - name: "referral_enrollments"
      expr: COUNT(CASE WHEN referral_code IS NOT NULL AND referral_code <> '' THEN enrollment_event_id END)
      comment: "Count of enrollments driven by a referral code. Measures referral program contribution to new member acquisition."
    - name: "unique_enrolled_members"
      expr: COUNT(DISTINCT primary_enrollment_member_id)
      comment: "Count of distinct members enrolled. Deduplicates re-enrollment events to measure net unique member acquisition."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points economy health and liability metrics. Tracks points issuance, balance movements, expiry risk, and transaction economics to manage program financial exposure and member engagement."
  source: "`vibe_restaurants_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points ledger transaction (e.g., Earn, Redeem, Adjust, Expire). Primary dimension for understanding points flow direction."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel that originated the points transaction (e.g., App, POS, Web, Third-Party Delivery). Enables channel-level points economics analysis."
    - name: "transaction_timestamp_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the points ledger transaction. Enables trend analysis of points issuance and redemption over time."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction. Supports annual financial reporting of points liability and program cost."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction. Enables period-over-period comparison of points economics."
    - name: "order_currency_code"
      expr: order_currency_code
      comment: "Currency of the originating order. Supports multi-currency points program financial analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the points transaction (e.g., POS, OLO, Mobile App). Used for system reconciliation and data quality monitoring."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the points transaction has been voided. Used to filter or segment voided vs. valid transactions."
    - name: "points_expiry_date_month"
      expr: DATE_TRUNC('MONTH', points_expiry_date)
      comment: "Month in which points are scheduled to expire. Enables proactive expiry liability management and re-engagement campaign timing."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for manual points adjustments. Tracks adjustment patterns and potential program abuse or operational errors."
  measures:
    - name: "total_points_transactions"
      expr: COUNT(points_ledger_id)
      comment: "Total number of points ledger transactions. Baseline volume metric for points economy activity."
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value associated with points transactions. Measures the revenue base driving points issuance."
    - name: "avg_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value per points transaction. Benchmarks spend per loyalty-engaged transaction vs. non-loyalty baseline."
    - name: "total_points_balance_after"
      expr: SUM(CAST(points_balance_after AS DOUBLE))
      comment: "Sum of post-transaction points balances across all ledger entries. Proxy for aggregate outstanding points liability."
    - name: "avg_points_earn_rate"
      expr: AVG(CAST(points_earn_rate AS DOUBLE))
      comment: "Average points earn rate applied across transactions. Monitors earn rate consistency and detects anomalous accrual patterns."
    - name: "voided_transactions"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN points_ledger_id END)
      comment: "Count of voided points transactions. Tracks reversal volume as an indicator of operational errors or fraud."
    - name: "unique_members_with_activity"
      expr: COUNT(DISTINCT loyalty_member_id)
      comment: "Count of distinct members with points ledger activity. Measures the active, engaged member base driving points economics."
    - name: "unique_orders_with_points"
      expr: COUNT(DISTINCT primary_points_guest_order_id)
      comment: "Count of distinct orders that generated points ledger entries. Measures loyalty program attachment rate to transactions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption performance and discount economics metrics. Tracks redemption volume, discount value delivered, channel mix, and fraud signals to optimize offer strategy and manage promotional cost."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (e.g., Completed, Voided, Pending). Primary dimension for redemption funnel analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Loyalty tier of the redeeming member at time of redemption. Enables tier-level offer performance and ROI analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the redemption occurred (e.g., Breakfast, Lunch, Dinner). Supports daypart-level promotional effectiveness analysis."
    - name: "redemption_timestamp_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of offer redemption. Enables trend analysis of redemption volume and promotional spend over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Supports multi-currency promotional cost analysis."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary discount value delivered through offer redemptions. Measures total promotional cost and investment in member engagement."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption. Benchmarks per-redemption promotional cost for offer ROI analysis."
    - name: "unique_members_redeeming"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who redeemed an offer. Measures breadth of offer program engagement across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points redemption economics and reward utilization metrics. Tracks points depletion, discount value delivered, fraud signals, and channel mix to manage redemption liability and member satisfaction."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the points redemption (e.g., Completed, Reversed, Pending). Primary dimension for redemption funnel health."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward redeemed (e.g., Free Item, Discount, Experience). Measures reward category preference and redemption mix."
    - name: "channel"
      expr: channel
      comment: "Channel through which the redemption occurred (e.g., App, POS, Drive-Thru). Enables channel-level redemption analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the redemption (e.g., Breakfast, Lunch, Dinner). Supports daypart-level redemption pattern analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Loyalty tier of the redeeming member. Enables tier-level redemption behavior and reward cost analysis."
    - name: "redemption_timestamp_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of the redemption event. Enables trend analysis of redemption volume and points liability drawdown."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the redemption was flagged as potentially fraudulent. Used to segment and monitor fraudulent redemption activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Supports multi-currency redemption cost analysis."
    - name: "source"
      expr: source
      comment: "Source system or platform that originated the redemption. Used for system-level reconciliation and attribution."
    - name: "third_party_delivery_partner"
      expr: third_party_delivery_partner
      comment: "Third-party delivery partner associated with the redemption (if applicable). Measures loyalty redemption activity through delivery channels."
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total number of points redemption events. Primary volume KPI for reward utilization and points liability drawdown."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary value of discounts delivered through points redemptions. Measures the financial cost of the rewards program."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount value per redemption. Benchmarks per-redemption reward cost for program ROI analysis."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_total_before_discount AS DOUBLE))
      comment: "Total pre-discount order value on redemption transactions. Measures the revenue base associated with reward-driven visits."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_total_after_discount AS DOUBLE))
      comment: "Total post-discount order value on redemption transactions. Measures net revenue retained after reward discounts."
    - name: "avg_points_balance_before_redemption"
      expr: AVG(CAST(points_balance_before AS DOUBLE))
      comment: "Average member points balance before redemption. Indicates typical redemption threshold behavior and points accumulation patterns."
    - name: "avg_points_balance_after_redemption"
      expr: AVG(CAST(points_balance_after AS DOUBLE))
      comment: "Average member points balance after redemption. Measures residual balance and likelihood of continued engagement post-redemption."
    - name: "fraudulent_redemptions"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN redemption_id END)
      comment: "Count of redemptions flagged as fraudulent. Tracks fraud exposure and informs fraud prevention investment decisions."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across redemptions. Monitors overall fraud risk level in the redemption population."
    - name: "unique_members_redeeming"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who redeemed points. Measures breadth of reward utilization across the active member base."
    - name: "reversed_redemptions"
      expr: COUNT(CASE WHEN redemption_status = 'Reversed' THEN redemption_id END)
      comment: "Count of reversed redemptions. Tracks reversal rate as an indicator of operational issues or fraud."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_reward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward catalog performance and cost metrics. Tracks reward utilization, points cost, monetary value, and availability to optimize the reward portfolio and manage program liability."
  source: "`vibe_restaurants_v1`.`loyalty`.`reward`"
  dimensions:
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward (e.g., Free Item, Discount, Experience, Merchandise). Primary dimension for reward portfolio mix analysis."
    - name: "reward_status"
      expr: reward_status
      comment: "Current status of the reward (e.g., Active, Inactive, Expired). Used to monitor active reward catalog health."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount the reward delivers (e.g., Percentage, Fixed Amount). Enables discount structure analysis across the reward catalog."
    - name: "availability_start_date_month"
      expr: DATE_TRUNC('MONTH', availability_start_date)
      comment: "Month the reward became available. Tracks reward catalog refresh cadence and new reward introduction timing."
    - name: "availability_end_date_month"
      expr: DATE_TRUNC('MONTH', availability_end_date)
      comment: "Month the reward expires. Enables proactive management of expiring rewards and catalog refresh planning."
    - name: "featured_flag"
      expr: featured_flag
      comment: "Whether the reward is featured in the loyalty app or communications. Used to measure featured vs. non-featured reward performance."
    - name: "daypart_restriction"
      expr: daypart_restriction
      comment: "Daypart restriction applied to the reward. Enables analysis of daypart-restricted reward utilization."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "Tax treatment applied to the reward. Supports financial reporting and compliance analysis of reward costs."
  measures:
    - name: "total_active_rewards"
      expr: COUNT(CASE WHEN reward_status = 'Active' THEN reward_id END)
      comment: "Count of currently active rewards in the catalog. Measures the breadth of the active reward portfolio available to members."
    - name: "total_reward_redemption_count"
      expr: SUM(CAST(redemption_count AS DOUBLE))
      comment: "Total number of times rewards have been redeemed across the catalog. Primary utilization KPI for reward portfolio performance."
    - name: "avg_points_cost_per_reward"
      expr: AVG(CAST(points_cost AS DOUBLE))
      comment: "Average points cost required to redeem a reward. Benchmarks reward accessibility and points economy calibration."
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all rewards in the catalog. Measures the aggregate financial value proposition offered to members."
    - name: "avg_monetary_value_per_reward"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per reward. Benchmarks reward generosity and value-to-cost ratio across the catalog."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total COGS associated with rewards in the catalog. Measures the direct cost exposure of the reward portfolio."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value delivered per reward. Monitors discount depth across the reward catalog and its margin impact."
    - name: "featured_rewards_count"
      expr: COUNT(CASE WHEN featured_flag = TRUE THEN reward_id END)
      comment: "Count of featured rewards in the catalog. Tracks the size of the featured reward set used in promotional communications."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points accrual rule configuration and economics metrics. Tracks rule coverage, earn rates, minimum purchase thresholds, and expiration policies to govern points issuance strategy and program cost."
  source: "`vibe_restaurants_v1`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the accrual rule (e.g., Active, Inactive, Pending). Used to monitor active rule coverage."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of accrual rule (e.g., Base Earn, Bonus, Multiplier). Primary dimension for understanding points issuance structure."
    - name: "earning_basis"
      expr: earning_basis
      comment: "Basis on which points are earned (e.g., Dollar Spend, Visit, Item Purchase). Defines the earn mechanic driving member behavior."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel(s) to which the accrual rule applies. Enables channel-level earn rule coverage analysis."
    - name: "franchise_scope"
      expr: franchise_scope
      comment: "Franchise scope of the accrual rule. Supports franchise-level earn rule governance and consistency analysis."
    - name: "member_tier_scope"
      expr: member_tier_scope
      comment: "Member tier(s) to which the accrual rule applies. Enables tier-differentiated earn rule analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the accrual rule became effective. Tracks rule introduction cadence and program evolution."
    - name: "effective_end_date_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the accrual rule expires. Enables proactive management of expiring earn rules."
    - name: "stackable"
      expr: stackable
      comment: "Whether the accrual rule can be stacked with other rules. Monitors stackability exposure and potential over-earning risk."
    - name: "requires_opt_in"
      expr: requires_opt_in
      comment: "Whether the accrual rule requires member opt-in. Tracks opt-in gated earn rules and their member reach implications."
  measures:
    - name: "total_active_rules"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN accrual_rule_id END)
      comment: "Count of currently active accrual rules. Measures the breadth of the active earn rule framework governing points issuance."
    - name: "avg_points_per_unit"
      expr: AVG(CAST(points_per_unit AS DOUBLE))
      comment: "Average points awarded per unit (e.g., per dollar spent) across active rules. Benchmarks earn rate generosity and program cost calibration."
    - name: "avg_fixed_points_amount"
      expr: AVG(CAST(fixed_points_amount AS DOUBLE))
      comment: "Average fixed points amount awarded by flat-rate accrual rules. Monitors fixed earn rule value and cost consistency."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold required to earn points. Measures earn barrier height and its impact on member participation rates."
    - name: "avg_points_expiration_days"
      expr: AVG(CAST(points_expiration_days AS DOUBLE))
      comment: "Average points expiration window in days across accrual rules. Monitors expiration policy generosity and its impact on points liability duration."
    - name: "avg_tier_multiplier"
      expr: AVG(CAST(tier_multiplier_applicable AS DOUBLE))
      comment: "Average tier multiplier applied across accrual rules. Measures the incremental earn advantage granted to higher-tier members."
    - name: "stackable_rules_count"
      expr: COUNT(CASE WHEN stackable = TRUE THEN accrual_rule_id END)
      comment: "Count of accrual rules that are stackable with other rules. Monitors over-earning risk exposure from rule stacking."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty tier structure and benefit economics metrics. Tracks tier configuration, qualification thresholds, multipliers, and benefit eligibility to govern tier strategy and member progression incentives."
  source: "`vibe_restaurants_v1`.`loyalty`.`tier`"
  dimensions:
    - name: "tier_status"
      expr: tier_status
      comment: "Current status of the tier (e.g., Active, Inactive). Used to monitor the active tier structure."
    - name: "qualification_metric"
      expr: qualification_metric
      comment: "Metric used to qualify for the tier (e.g., Points Earned, Visits, Spend). Defines the tier progression mechanic."
    - name: "launch_date_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the tier was launched. Tracks tier introduction history and program evolution."
    - name: "birthday_reward_eligible"
      expr: birthday_reward_eligible
      comment: "Whether members in this tier are eligible for birthday rewards. Tracks birthday benefit coverage across tiers."
    - name: "free_delivery_eligible"
      expr: free_delivery_eligible
      comment: "Whether members in this tier are eligible for free delivery. Measures free delivery benefit exposure and cost implications."
    - name: "exclusive_offers_eligible"
      expr: exclusive_offers_eligible
      comment: "Whether members in this tier are eligible for exclusive offers. Tracks exclusive offer benefit coverage across tiers."
    - name: "priority_support_eligible"
      expr: priority_support_eligible
      comment: "Whether members in this tier are eligible for priority support. Monitors premium service benefit coverage."
    - name: "rollover_points_allowed"
      expr: rollover_points_allowed
      comment: "Whether points rollover is allowed for this tier. Tracks rollover policy generosity and its impact on tier retention."
  measures:
    - name: "total_active_tiers"
      expr: COUNT(CASE WHEN tier_status = 'Active' THEN tier_id END)
      comment: "Count of currently active loyalty tiers. Measures the complexity and breadth of the tier structure."
    - name: "avg_qualification_threshold"
      expr: AVG(CAST(qualification_threshold AS DOUBLE))
      comment: "Average qualification threshold required to achieve a tier. Benchmarks tier attainability and its impact on member progression rates."
    - name: "avg_upgrade_threshold_gap"
      expr: AVG(CAST(qualification_threshold AS DOUBLE) - CAST(downgrade_threshold AS DOUBLE))
      comment: "Average gap between upgrade and downgrade thresholds. Measures tier retention buffer width and its impact on tier stability."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points earn multiplier across tiers. Measures the incremental earn incentive offered to higher-tier members and its cost implications."
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee charged across paid tiers. Measures subscription revenue potential from the tier structure."
    - name: "avg_max_redemption_discount_pct"
      expr: AVG(CAST(max_redemption_discount_pct AS DOUBLE))
      comment: "Average maximum redemption discount percentage allowed per tier. Monitors discount cap generosity and its margin exposure."
    - name: "tiers_with_free_delivery"
      expr: COUNT(CASE WHEN free_delivery_eligible = TRUE THEN tier_id END)
      comment: "Count of tiers offering free delivery eligibility. Measures free delivery benefit exposure and associated cost liability."
$$;