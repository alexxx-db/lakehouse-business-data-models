-- Metric views for domain: loyalty | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member health and value metrics. Tracks membership growth, engagement, tier distribution, points economics, and lifetime value — essential for loyalty program steering and investment decisions."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership (e.g., Active, Suspended, Closed). Used to segment active vs. churned members."
    - name: "tier_id"
      expr: tier_id
      comment: "Foreign key to the loyalty tier. Used to segment members by tier level for tier-based performance analysis."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of member enrollment. Used to track cohort-based membership growth trends."
    - name: "enrollment_date_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of member enrollment. Used for annual cohort and vintage analysis."
    - name: "last_stay_date_month"
      expr: DATE_TRUNC('MONTH', last_stay_date)
      comment: "Month of the member's most recent stay. Used to identify recency cohorts and dormancy patterns."
    - name: "currency_preference"
      expr: currency_preference
      comment: "Member's preferred currency. Used for regional and currency-based segmentation."
    - name: "language_preference"
      expr: language_preference
      comment: "Member's preferred language. Used for localization and regional engagement analysis."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP status. Used to isolate high-value member segments."
    - name: "communication_opt_in"
      expr: communication_opt_in
      comment: "Whether the member has opted into communications. Used to measure reachable audience size."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the member has opted into email communications. Used for email channel reach analysis."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN member_id END)
      comment: "Total number of members with Active status. Core KPI for loyalty program scale and health."
    - name: "total_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Total distinct loyalty members across all statuses. Used as the denominator for penetration and conversion rates."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Sum of lifetime revenue attributed to loyalty members. Directly measures the revenue contribution of the loyalty program."
    - name: "avg_lifetime_revenue_per_member"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per loyalty member. Indicates the average economic value of a member — key for ROI and acquisition cost benchmarking."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points ever earned by all members. Measures program engagement volume and liability accrual scale."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total unredeemed points balance across all active members. Represents outstanding loyalty liability on the balance sheet."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed by members. Measures program utilization and member engagement with redemption benefits."
    - name: "total_points_expired"
      expr: SUM(CAST(points_expired AS DOUBLE))
      comment: "Total points that have expired without redemption. High expiry rates signal disengagement and potential member dissatisfaction."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average unredeemed points balance per member. Indicates average engagement depth and potential redemption demand."
    - name: "total_ytd_revenue"
      expr: SUM(CAST(ytd_revenue AS DOUBLE))
      comment: "Total year-to-date revenue from loyalty members. Used for in-year performance tracking against annual targets."
    - name: "avg_ytd_revenue_per_member"
      expr: AVG(CAST(ytd_revenue AS DOUBLE))
      comment: "Average year-to-date revenue per loyalty member. Tracks in-year member value trends for forecasting and incentive planning."
    - name: "avg_salt_score"
      expr: AVG(CAST(salt_score AS DOUBLE))
      comment: "Average SALT (Satisfaction and Loyalty Tracking) score across members. Directly measures member satisfaction — a leading indicator of retention and churn."
    - name: "vip_member_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN member_id END)
      comment: "Count of members with VIP status. Used to track the size of the highest-value member segment."
    - name: "email_opt_in_member_count"
      expr: COUNT(CASE WHEN email_opt_in = TRUE THEN member_id END)
      comment: "Count of members opted into email communications. Measures the reachable audience for email-driven loyalty campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points transaction economics and flow metrics. Tracks points earned, redeemed, adjusted, and transferred — essential for liability management, program engagement, and fraud monitoring."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (e.g., Earn, Redeem, Adjust, Transfer, Expire). Used to segment points flow by transaction category."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the points transaction (e.g., Posted, Pending, Reversed). Used to filter to confirmed vs. in-flight transactions."
    - name: "source_activity_type"
      expr: source_activity_type
      comment: "The business activity that generated the points transaction (e.g., Hotel Stay, F&B, Spa). Used to attribute points volume to revenue-generating activities."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of the points activity. Used for monthly trend analysis of points flow."
    - name: "activity_date_year"
      expr: DATE_TRUNC('YEAR', activity_date)
      comment: "Year of the points activity. Used for annual points economics reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the ledger. Used for accounting period alignment."
    - name: "tier_at_transaction"
      expr: tier_at_transaction
      comment: "Member tier at the time of the transaction. Used to analyze points economics by tier segment."
    - name: "is_qualifying"
      expr: is_qualifying
      comment: "Whether the transaction counts toward tier qualification. Used to separate qualifying from non-qualifying activity."
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Currency of the base transaction amount. Used for multi-currency points economics analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the points transaction. Used for property-level points economics analysis."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of a points transfer (Inbound/Outbound). Used to analyze partner transfer flows."
    - name: "partner_program_code"
      expr: partner_program_code
      comment: "Partner loyalty program code for transfer transactions. Used to evaluate partner program exchange volumes."
  measures:
    - name: "total_points_earned"
      expr: SUM(CASE WHEN transaction_type = 'Earn' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points earned across all earn transactions. Measures program engagement and accrual volume — drives liability forecasting."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'Redeem' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points redeemed. Measures member utilization of earned benefits — a key engagement and satisfaction indicator."
    - name: "total_points_adjusted"
      expr: SUM(CASE WHEN transaction_type = 'Adjust' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points adjusted (manual corrections). High adjustment volumes may signal operational or system issues requiring investigation."
    - name: "total_points_transferred"
      expr: SUM(CASE WHEN transaction_type = 'Transfer' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points transferred to/from partner programs. Measures partner program engagement and exchange economics."
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base transaction amount (in local currency) across all ledger entries. Used to compute points-per-currency-unit yield and validate accrual rule effectiveness."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points amount per ledger transaction. Tracks the average transaction size in points — useful for detecting anomalies and benchmarking accrual rule performance."
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total fees collected on points transfer transactions. Measures revenue generated from partner transfer activity."
    - name: "total_qualifying_transactions"
      expr: COUNT(CASE WHEN is_qualifying = TRUE THEN points_ledger_id END)
      comment: "Count of transactions that qualify toward tier status. Used to monitor tier qualification pipeline and forecast tier upgrade volumes."
    - name: "total_transactions"
      expr: COUNT(DISTINCT points_ledger_id)
      comment: "Total distinct points ledger transactions. Used as the baseline volume measure for points activity."
    - name: "avg_balance_after_transaction"
      expr: AVG(CAST(balance_after_transaction AS DOUBLE))
      comment: "Average member balance after each transaction. Tracks the average outstanding liability per transaction event — useful for liability trend monitoring."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average currency-to-points conversion rate applied across transactions. Used to monitor consistency of accrual rule application and detect rate anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption activity and value metrics. Tracks redemption volume, points consumed, monetary equivalent value, and fulfillment performance — critical for liability management and member benefit utilization."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (e.g., Free Night, Upgrade, F&B, Spa, Partner). Used to analyze redemption mix and reward category popularity."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (e.g., Confirmed, Cancelled, Fulfilled, Pending). Used to track fulfillment pipeline and cancellation rates."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier at the time of redemption. Used to analyze redemption behavior by tier segment."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the redemption was fulfilled. Used to evaluate fulfillment channel efficiency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Used for multi-currency redemption value analysis."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the redemption was requested. Used for monthly redemption volume and liability release trend analysis."
    - name: "request_date_year"
      expr: DATE_TRUNC('YEAR', request_date)
      comment: "Year the redemption was requested. Used for annual redemption economics reporting."
    - name: "fulfillment_date_month"
      expr: DATE_TRUNC('MONTH', fulfillment_date)
      comment: "Month the redemption was fulfilled. Used to track fulfillment lag and operational throughput."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel through which the redemption was initiated. Used to attribute redemption volume to booking and service channels."
    - name: "property_outlet_id"
      expr: property_outlet_id
      comment: "Property outlet associated with the redemption. Used for outlet-level redemption analysis."
    - name: "partner_code"
      expr: partner_code
      comment: "Partner code for partner-based redemptions. Used to evaluate partner redemption program performance."
  measures:
    - name: "total_redemptions"
      expr: COUNT(DISTINCT redemption_id)
      comment: "Total number of distinct redemption transactions. Core volume KPI for redemption program utilization."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points consumed through redemptions. Directly measures loyalty liability release — critical for program cost management."
    - name: "total_monetary_equivalent_value"
      expr: SUM(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Total monetary equivalent value of all redemptions. Measures the economic cost of the redemption program in currency terms."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points consumed per redemption transaction. Used to benchmark redemption efficiency and detect high-cost redemption patterns."
    - name: "avg_monetary_value_per_redemption"
      expr: AVG(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Average monetary equivalent value per redemption. Used to assess the average cost per redemption event for program economics."
    - name: "total_cash_amount"
      expr: SUM(CAST(cash_amount AS DOUBLE))
      comment: "Total cash component of redemptions (points + cash redemptions). Measures hybrid redemption revenue contribution."
    - name: "total_points_refunded"
      expr: SUM(CAST(points_refunded AS DOUBLE))
      comment: "Total points refunded due to cancellations or reversals. High refund volumes indicate fulfillment issues or member dissatisfaction."
    - name: "cancelled_redemption_count"
      expr: COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END)
      comment: "Count of cancelled redemptions. Used to calculate cancellation rate and identify fulfillment or member experience issues."
    - name: "fulfilled_redemption_count"
      expr: COUNT(CASE WHEN redemption_status = 'Fulfilled' THEN redemption_id END)
      comment: "Count of successfully fulfilled redemptions. Used to measure fulfillment success rate and operational efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier movement and qualification metrics. Tracks upgrades, downgrades, status matches, and qualification performance — essential for understanding tier dynamics, retention risk, and program health."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`tier_history`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of tier change (e.g., Upgrade, Downgrade, Renewal, Status Match, Override). Used to segment tier movement by change category."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the tier change. Used to diagnose drivers of tier movement and identify systemic issues."
    - name: "qualification_basis"
      expr: qualification_basis
      comment: "Basis on which tier qualification was achieved (e.g., Nights, Points, Spend, Status Match). Used to analyze which qualification paths are most common."
    - name: "previous_tier_code"
      expr: previous_tier_code
      comment: "Tier code before the change. Used to build tier transition matrices and identify downgrade risk segments."
    - name: "is_current_tier_flag"
      expr: is_current_tier_flag
      comment: "Whether this record represents the member's current active tier. Used to filter to current-state tier distribution."
    - name: "tier_extension_granted_flag"
      expr: tier_extension_granted_flag
      comment: "Whether a tier extension was granted. Used to measure the volume of retention-driven tier extensions."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the tier change became effective. Used for monthly tier movement trend analysis."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the tier change became effective. Used for annual tier dynamics reporting."
    - name: "qualifying_period_start_date_month"
      expr: DATE_TRUNC('MONTH', qualifying_period_start_date)
      comment: "Month the qualifying period started. Used to align tier qualification analysis to program year cycles."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that triggered the tier change. Used to audit data provenance and identify system-driven vs. manual changes."
    - name: "status_match_source_program"
      expr: status_match_source_program
      comment: "External program from which a status match was sourced. Used to evaluate competitive status match program effectiveness."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(DISTINCT tier_history_id)
      comment: "Total number of tier change events. Baseline volume KPI for tier movement activity."
    - name: "total_upgrades"
      expr: COUNT(CASE WHEN change_type = 'Upgrade' THEN tier_history_id END)
      comment: "Total number of tier upgrade events. Measures program engagement success — upgrades indicate members are deepening their relationship with the brand."
    - name: "total_downgrades"
      expr: COUNT(CASE WHEN change_type = 'Downgrade' THEN tier_history_id END)
      comment: "Total number of tier downgrade events. A leading indicator of member disengagement and potential churn risk."
    - name: "total_status_matches"
      expr: COUNT(CASE WHEN change_type = 'Status Match' THEN tier_history_id END)
      comment: "Total number of status match tier grants. Measures competitive acquisition activity and the scale of status match programs."
    - name: "total_tier_extensions"
      expr: COUNT(CASE WHEN tier_extension_granted_flag = TRUE THEN tier_history_id END)
      comment: "Total number of tier extensions granted. Measures the scale of retention-driven tier extension activity and associated program cost."
    - name: "total_bonus_points_awarded_on_tier_change"
      expr: SUM(CAST(bonus_points_awarded AS DOUBLE))
      comment: "Total bonus points awarded in connection with tier changes (e.g., upgrade bonuses). Measures the points liability cost of tier change incentives."
    - name: "avg_qualifying_points_achieved"
      expr: AVG(CAST(qualifying_points_achieved AS DOUBLE))
      comment: "Average qualifying points achieved at the time of tier change. Used to benchmark how far above or below threshold members are qualifying — informs threshold calibration."
    - name: "avg_qualifying_spend_amount"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend amount at the time of tier change. Used to assess the revenue quality of tier-qualifying members."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend across all tier change events. Measures the revenue volume associated with tier qualification activity."
    - name: "members_with_current_tier"
      expr: COUNT(CASE WHEN is_current_tier_flag = TRUE THEN member_id END)
      comment: "Count of members with a current active tier record. Used to validate tier assignment completeness and measure tiered member population."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion enrollment and completion metrics. Tracks enrollment volume, completion rates, and bonus award performance — essential for evaluating promotional campaign ROI and member engagement."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion_enrollment`"
  dimensions:
    - name: "promotion_enrollment_status"
      expr: promotion_enrollment_status
      comment: "Current status of the promotion enrollment (e.g., Enrolled, Completed, Opted Out, Expired). Used to segment enrollment pipeline by stage."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled in the promotion. Used to evaluate which channels drive the most promotion sign-ups."
    - name: "bonus_awarded_flag"
      expr: bonus_awarded_flag
      comment: "Whether a bonus was awarded for this enrollment. Used to measure bonus fulfillment rate and identify unfulfilled completions."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of promotion enrollment. Used for monthly enrollment trend analysis."
    - name: "enrollment_date_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of promotion enrollment. Used for annual campaign performance reporting."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the promotion was completed. Used to track completion velocity and campaign fulfillment timelines."
    - name: "promotion_id"
      expr: promotion_id
      comment: "Foreign key to the promotion. Used to group enrollment and completion metrics by specific campaign."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the promotion award was issued. Used to track award fulfillment timing."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT promotion_enrollment_id)
      comment: "Total number of promotion enrollments. Core volume KPI for campaign reach and member participation."
    - name: "total_completions"
      expr: COUNT(CASE WHEN promotion_enrollment_status = 'Completed' THEN promotion_enrollment_id END)
      comment: "Total number of completed promotion enrollments. Measures campaign effectiveness — completions drive bonus point liability and member satisfaction."
    - name: "total_opt_outs"
      expr: COUNT(CASE WHEN promotion_enrollment_status = 'Opted Out' THEN promotion_enrollment_id END)
      comment: "Total number of members who opted out of a promotion. High opt-out rates signal poor campaign targeting or relevance issues."
    - name: "total_bonuses_awarded"
      expr: COUNT(CASE WHEN bonus_awarded_flag = TRUE THEN promotion_enrollment_id END)
      comment: "Total number of enrollments where a bonus was awarded. Used to measure bonus fulfillment volume and validate award processing."
    - name: "distinct_members_enrolled"
      expr: COUNT(DISTINCT member_id)
      comment: "Number of distinct members enrolled in promotions. Measures the breadth of promotional campaign reach across the member base."
    - name: "distinct_promotions_with_enrollments"
      expr: COUNT(DISTINCT promotion_id)
      comment: "Number of distinct promotions that have at least one enrollment. Used to assess active campaign portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion program economics and budget metrics. Tracks promotion budget utilization, bonus multipliers, and spend thresholds — essential for campaign investment governance and ROI management."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., Bonus Points, Double Points, Free Night, Spend Challenge). Used to analyze performance by promotion category."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (e.g., Active, Expired, Cancelled, Draft). Used to filter to live vs. historical campaigns."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started. Used for campaign launch trend analysis."
    - name: "start_date_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the promotion started. Used for annual campaign portfolio reporting."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the promotion ended. Used to align campaign performance to completion periods."
    - name: "registration_required_flag"
      expr: registration_required_flag
      comment: "Whether registration is required to participate. Used to compare opt-in vs. automatic promotion performance."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether the promotion can be stacked with other offers. Used to assess combinability risk and liability exposure."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier targeted by the promotion. Used to analyze promotion investment by tier segment."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the promotion. Used for property-level campaign performance analysis."
    - name: "segment_id"
      expr: segment_id
      comment: "Guest segment targeted by the promotion. Used to evaluate segment-specific campaign effectiveness."
  measures:
    - name: "total_budget_cap"
      expr: SUM(CAST(budget_cap_amount AS DOUBLE))
      comment: "Total budget allocated across all promotions. Used to measure total promotional investment commitment."
    - name: "total_budget_consumed"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Total budget consumed across all promotions. Used to track promotional spend against allocated budgets."
    - name: "avg_budget_utilization_rate"
      expr: AVG(CAST(budget_consumed_amount AS DOUBLE) / NULLIF(CAST(budget_cap_amount AS DOUBLE), 0))
      comment: "Average budget utilization rate per promotion (consumed / cap). Measures how efficiently promotional budgets are being deployed — under-utilization signals targeting or awareness issues."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across promotions. Used to benchmark the generosity of active promotions and assess liability exposure."
    - name: "avg_minimum_spend_threshold"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold required to qualify for promotions. Used to calibrate promotion accessibility and revenue qualification requirements."
    - name: "total_active_promotions"
      expr: COUNT(CASE WHEN promotion_status = 'Active' THEN promotion_id END)
      comment: "Count of currently active promotions. Used to monitor the live promotional portfolio size and complexity."
    - name: "total_promotions"
      expr: COUNT(DISTINCT promotion_id)
      comment: "Total number of distinct promotions. Used as the baseline count for promotion portfolio analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_benefit_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit entitlement utilization and value metrics. Tracks benefit grants, usage, monetary value, and expiry — essential for understanding the cost and effectiveness of loyalty benefit programs."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement`"
  dimensions:
    - name: "benefit_type_code"
      expr: benefit_type_code
      comment: "Type of benefit entitlement (e.g., Free Breakfast, Room Upgrade, Late Checkout, Spa Credit). Used to analyze benefit mix and utilization by category."
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the benefit entitlement (e.g., Active, Used, Expired, Revoked). Used to track benefit lifecycle and utilization rates."
    - name: "entitlement_source"
      expr: entitlement_source
      comment: "Source that granted the entitlement (e.g., Tier, Promotion, Manual). Used to attribute benefit costs to their originating program."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier associated with the benefit entitlement. Used to analyze benefit cost and utilization by tier level."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the benefit became effective. Used for monthly benefit grant trend analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the benefit expires. Used to forecast upcoming benefit expiry volumes and liability release."
    - name: "granted_timestamp_month"
      expr: DATE_TRUNC('MONTH', granted_timestamp)
      comment: "Month the benefit was granted. Used for grant volume trend analysis."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the benefit is automatically applied. Used to compare auto-applied vs. member-initiated benefit utilization."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Whether the benefit can be transferred to another member. Used to assess transferability risk and benefit sharing patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the benefit monetary value. Used for multi-currency benefit cost analysis."
  measures:
    - name: "total_benefit_entitlements"
      expr: COUNT(DISTINCT benefit_entitlement_id)
      comment: "Total number of benefit entitlements granted. Core volume KPI for benefit program scale."
    - name: "total_monetary_value_of_benefits"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all benefit entitlements granted. Measures the total economic cost of the benefit program — critical for program P&L management."
    - name: "avg_monetary_value_per_benefit"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per benefit entitlement. Used to benchmark benefit generosity and assess cost per benefit event."
    - name: "total_active_benefits"
      expr: COUNT(CASE WHEN entitlement_status = 'Active' THEN benefit_entitlement_id END)
      comment: "Count of currently active (unused, non-expired) benefit entitlements. Represents outstanding benefit liability."
    - name: "total_expired_benefits"
      expr: COUNT(CASE WHEN entitlement_status = 'Expired' THEN benefit_entitlement_id END)
      comment: "Count of expired benefit entitlements. High expiry rates indicate members are not utilizing their benefits — a satisfaction and engagement risk signal."
    - name: "total_revoked_benefits"
      expr: COUNT(CASE WHEN entitlement_status = 'Revoked' THEN benefit_entitlement_id END)
      comment: "Count of revoked benefit entitlements. Used to monitor compliance and fraud-related benefit revocations."
    - name: "avg_points_multiplier_on_benefits"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier applied to benefit entitlements. Used to assess the points earning enhancement provided through benefit programs."
    - name: "distinct_members_with_benefits"
      expr: COUNT(DISTINCT member_id)
      comment: "Number of distinct members holding at least one benefit entitlement. Measures the breadth of benefit program reach across the member base."
$$;