-- Metric views for domain: loyalty | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic loyalty member health and value metrics. Tracks membership growth, tier distribution, points economics, and lifetime value to steer loyalty program investment and retention strategy."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership (e.g., Active, Suspended, Closed). Used to segment active vs. churned members."
    - name: "tier_id"
      expr: tier_id
      comment: "Foreign key to the loyalty tier. Enables analysis of KPIs by tier level (Base, Silver, Gold, Platinum)."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g., Web, Mobile, Front Desk). Informs acquisition channel effectiveness."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of member enrollment. Used for cohort analysis and year-over-year membership growth tracking."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of member enrollment. Enables monthly enrollment trend analysis."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP status. Used to segment and prioritize high-value member analytics."
    - name: "language_preference"
      expr: language_preference
      comment: "Member's preferred communication language. Supports localization and personalization strategy analysis."
    - name: "last_stay_year"
      expr: DATE_TRUNC('YEAR', last_stay_date)
      comment: "Year of the member's most recent stay. Used to identify recency cohorts and at-risk lapsed members."
    - name: "tier_expiration_month"
      expr: DATE_TRUNC('MONTH', tier_expiration_date)
      comment: "Month when the member's tier status expires. Enables proactive retention campaigns before tier downgrade."
    - name: "member_enrollment_hotel_property_id"
      expr: member_enrollment_hotel_property_id
      comment: "Property where the member enrolled. Identifies top enrollment-generating properties."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN member_id END)
      comment: "Total count of members with Active status. Core KPI for measuring loyalty program scale and health."
    - name: "total_members_enrolled"
      expr: COUNT(member_id)
      comment: "Total count of all enrolled members regardless of status. Tracks overall program reach and acquisition volume."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Sum of lifetime revenue attributed to loyalty members. Directly measures the financial value of the loyalty program to the business."
    - name: "avg_lifetime_revenue_per_member"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per loyalty member. Benchmarks member value and informs tier investment decisions."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total lifetime points earned across all members. Measures program engagement and liability accrual volume."
    - name: "avg_lifetime_points_earned_per_member"
      expr: AVG(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Average lifetime points earned per member. Indicates average engagement depth and earning behavior."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all active members. Represents the program's unredeemed points liability — a critical financial exposure metric."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points balance per member. Signals redemption propensity and engagement level across the member base."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed by members. Measures redemption activity and program utilization — high redemption signals strong member engagement."
    - name: "total_points_expired"
      expr: SUM(CAST(points_expired AS DOUBLE))
      comment: "Total points expired without redemption. High expiry may indicate poor member engagement or overly restrictive redemption rules."
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have been redeemed. Key loyalty health indicator — low rates signal disengagement or redemption friction."
    - name: "total_ytd_revenue"
      expr: SUM(CAST(ytd_revenue AS DOUBLE))
      comment: "Total year-to-date revenue from loyalty members. Tracks in-year revenue contribution of the loyalty base for financial planning."
    - name: "avg_ytd_revenue_per_member"
      expr: AVG(CAST(ytd_revenue AS DOUBLE))
      comment: "Average year-to-date revenue per loyalty member. Benchmarks current-year member productivity against prior periods."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across loyalty members. Measures member satisfaction and advocacy — a leading indicator of retention and referral revenue."
    - name: "avg_salt_score"
      expr: AVG(CAST(salt_score AS DOUBLE))
      comment: "Average SALT (satisfaction) score across loyalty members. Tracks service quality perception among the loyalty base, informing experience investment decisions."
    - name: "vip_member_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN member_id END)
      comment: "Count of members with VIP designation. Tracks the size of the highest-value member segment requiring premium service investment."
    - name: "communication_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN communication_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(member_id), 0), 2)
      comment: "Percentage of members opted into communications. Measures marketing reachability of the loyalty base — critical for campaign ROI planning."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(member_id), 0), 2)
      comment: "Percentage of members opted into email communications. Informs email channel capacity for loyalty marketing campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial metrics for loyalty points transactions. Tracks points flow, earning vs. redemption economics, transfer activity, and transaction quality to manage program liability and member engagement."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (e.g., Earn, Redeem, Adjust, Transfer, Expire). Primary dimension for segmenting points flow analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the points transaction (e.g., Posted, Pending, Reversed). Used to filter for settled vs. in-flight transactions."
    - name: "source_activity_type"
      expr: source_activity_type
      comment: "Business activity that generated the points transaction (e.g., Hotel Stay, F&B, Partner). Identifies which revenue streams drive loyalty earning."
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of the points activity. Enables monthly trend analysis of points earning and redemption volumes."
    - name: "activity_year"
      expr: DATE_TRUNC('YEAR', activity_date)
      comment: "Year of the points activity. Supports year-over-year comparison of points economics."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the ledger. Used for financial period reconciliation of points liability."
    - name: "is_qualifying"
      expr: is_qualifying
      comment: "Indicates whether the transaction counts toward tier qualification. Segments qualifying vs. non-qualifying earning activity."
    - name: "tier_at_transaction"
      expr: tier_at_transaction
      comment: "Member's tier level at the time of the transaction. Enables tier-based analysis of earning and redemption patterns."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of points transfer (Inbound/Outbound). Used to analyze partner program points flow and net transfer position."
    - name: "partner_program_code"
      expr: partner_program_code
      comment: "Partner loyalty program code associated with the transaction. Identifies which partner programs drive points exchange volume."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the points transaction. Enables property-level analysis of points earning and redemption activity."
  measures:
    - name: "total_points_transacted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points amount across all ledger transactions. Measures gross points flow volume — foundational metric for program liability management."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points amount per ledger transaction. Benchmarks transaction-level earning/redemption intensity."
    - name: "total_base_transaction_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total qualifying spend amount underlying points transactions. Measures the revenue base that drives loyalty earning — links program cost to revenue."
    - name: "avg_base_transaction_amount"
      expr: AVG(CAST(base_amount AS DOUBLE))
      comment: "Average qualifying spend per points transaction. Indicates average transaction size driving loyalty earning activity."
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total fees collected on points transfers. Measures revenue generated from points transfer activity — a direct program revenue line."
    - name: "total_balance_after_transaction"
      expr: SUM(CAST(balance_after_transaction AS DOUBLE))
      comment: "Sum of post-transaction balances across all ledger records. Proxy for aggregate outstanding points liability at transaction level."
    - name: "avg_balance_after_transaction"
      expr: AVG(CAST(balance_after_transaction AS DOUBLE))
      comment: "Average member balance after each transaction. Tracks typical points accumulation level and redemption drawdown patterns."
    - name: "transaction_count"
      expr: COUNT(points_ledger_id)
      comment: "Total number of points ledger transactions. Measures program activity volume and member engagement frequency."
    - name: "distinct_active_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members with points ledger activity. Measures the breadth of engaged members transacting within the program."
    - name: "qualifying_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_qualifying = TRUE THEN points_ledger_id END) / NULLIF(COUNT(points_ledger_id), 0), 2)
      comment: "Percentage of transactions that are tier-qualifying. Measures what share of activity contributes to tier advancement — informs tier attainment forecasting."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average currency conversion rate applied to points transactions. Monitors consistency of points valuation across currencies and partner programs."
    - name: "points_per_currency_unit_earned"
      expr: ROUND(SUM(CAST(points_amount AS DOUBLE)) / NULLIF(SUM(CAST(base_amount AS DOUBLE)), 0), 4)
      comment: "Effective points earned per unit of qualifying spend. Measures actual earning rate vs. program design — deviations signal rule misapplication or fraud."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption performance and economics metrics. Tracks redemption volume, points consumed, monetary value delivered, fulfillment efficiency, and cancellation rates to optimize the redemption experience and manage program liability."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (e.g., Free Night, Upgrade, F&B, Partner). Identifies which reward categories drive the most redemption activity."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (e.g., Confirmed, Cancelled, Fulfilled, Pending). Used to segment completed vs. in-flight vs. cancelled redemptions."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the redemption was fulfilled (e.g., Property, Online, Call Center). Informs channel cost and efficiency analysis."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member's tier at the time of redemption. Enables tier-based analysis of redemption behavior and reward preference."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the redemption was requested. Enables monthly trend analysis of redemption demand."
    - name: "request_year"
      expr: DATE_TRUNC('YEAR', request_date)
      comment: "Year the redemption was requested. Supports year-over-year redemption volume and liability release tracking."
    - name: "fulfillment_month"
      expr: DATE_TRUNC('MONTH', fulfillment_date)
      comment: "Month the redemption was fulfilled. Used to measure fulfillment lag and operational throughput."
    - name: "property_id"
      expr: property_id
      comment: "Property where the redemption was fulfilled. Enables property-level redemption load and cost analysis."
    - name: "partner_code"
      expr: partner_code
      comment: "Partner program code for partner redemptions. Identifies partner redemption volume and associated liability transfer."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for redemption cancellation. Identifies systemic issues causing redemption failures — informs process improvement."
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total number of redemption transactions. Measures overall redemption activity volume — core indicator of program utilization."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who have redeemed. Measures redemption breadth across the member base — low rates signal redemption friction."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points consumed through redemptions. Directly measures liability release — a key financial metric for the loyalty program P&L."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points consumed per redemption transaction. Benchmarks redemption cost per event and informs reward catalog pricing."
    - name: "total_monetary_equivalent_value"
      expr: SUM(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Total monetary value of all redemptions. Quantifies the financial benefit delivered to members — measures program value proposition strength."
    - name: "avg_monetary_value_per_redemption"
      expr: AVG(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Average monetary value delivered per redemption. Benchmarks reward generosity and perceived value per redemption event."
    - name: "total_cash_amount"
      expr: SUM(CAST(cash_amount AS DOUBLE))
      comment: "Total cash component of points-plus-cash redemptions. Measures incremental cash revenue generated through hybrid redemption transactions."
    - name: "total_points_refunded"
      expr: SUM(CAST(points_refunded AS DOUBLE))
      comment: "Total points refunded due to cancellations or reversals. High refund volumes signal operational issues or member dissatisfaction."
    - name: "redemption_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions that were cancelled. High cancellation rates indicate friction in the redemption process or unmet member expectations."
    - name: "fulfilled_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'Fulfilled' THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions successfully fulfilled. Measures operational fulfillment effectiveness — a key service quality KPI."
    - name: "avg_monetary_value_per_point_redeemed"
      expr: ROUND(SUM(CAST(monetary_equivalent_value AS DOUBLE)) / NULLIF(SUM(CAST(points_redeemed AS DOUBLE)), 0), 6)
      comment: "Effective monetary value delivered per point redeemed. Measures the real-world value of the loyalty currency — critical for program economics and liability valuation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty promotion performance and budget efficiency metrics. Tracks promotion spend, budget utilization, enrollment, and completion rates to optimize promotional investment and campaign ROI."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of loyalty promotion (e.g., Bonus Points, Double Miles, Free Night). Segments promotion performance by campaign mechanic."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (e.g., Active, Expired, Draft, Cancelled). Used to filter live vs. historical promotions."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started. Enables monthly analysis of promotional activity and spend timing."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the promotion started. Supports year-over-year comparison of promotional investment and effectiveness."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier targeted by the promotion. Enables analysis of promotional investment by member tier segment."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the promotion. Enables property-level promotional spend and performance analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel through which the promotion is distributed. Identifies which channels drive the most promotional engagement."
    - name: "registration_required_flag"
      expr: registration_required_flag
      comment: "Indicates whether member registration is required to participate. Compares opt-in vs. automatic promotion performance."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the promotion can be combined with other offers. Used to analyze combinability impact on budget consumption."
    - name: "approved_by"
      expr: approved_by
      comment: "Approver of the promotion. Enables governance tracking of promotional approval workflows."
  measures:
    - name: "total_promotions"
      expr: COUNT(promotion_id)
      comment: "Total number of promotions created. Measures promotional program activity volume and campaign cadence."
    - name: "total_budget_cap_amount"
      expr: SUM(CAST(budget_cap_amount AS DOUBLE))
      comment: "Total budget allocated across all promotions. Measures total promotional investment commitment for financial planning."
    - name: "total_budget_consumed_amount"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Total budget actually consumed by promotions. Measures actual promotional spend — key input for ROI and cost-per-acquisition calculations."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_consumed_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_cap_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated promotion budget consumed. Measures promotional spend efficiency — under-utilization signals poor campaign execution; over-utilization signals budget risk."
    - name: "avg_budget_cap_per_promotion"
      expr: AVG(CAST(budget_cap_amount AS DOUBLE))
      comment: "Average budget allocated per promotion. Benchmarks typical promotional investment size for planning and approval governance."
    - name: "avg_budget_consumed_per_promotion"
      expr: AVG(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Average budget consumed per promotion. Measures typical promotional cost and informs future budget sizing."
    - name: "total_minimum_spend_threshold"
      expr: SUM(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Sum of minimum spend thresholds across promotions. Measures the aggregate qualifying spend requirement designed into the promotional portfolio."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across promotions. Benchmarks the generosity of the promotional points offer — informs liability impact assessment."
    - name: "active_promotion_count"
      expr: COUNT(CASE WHEN promotion_status = 'Active' THEN promotion_id END)
      comment: "Count of currently active promotions. Measures live promotional exposure and concurrent campaign load on the program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_benefit_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit entitlement utilization and value metrics. Tracks benefit grants, usage, monetary value delivered, and expiry patterns to optimize the benefit portfolio and measure member value delivery."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement`"
  dimensions:
    - name: "benefit_type_code"
      expr: benefit_type_code
      comment: "Type of benefit entitlement (e.g., Room Upgrade, Late Checkout, F&B Credit). Segments benefit performance by reward category."
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the benefit entitlement (e.g., Active, Used, Expired, Revoked). Used to track benefit lifecycle and utilization."
    - name: "entitlement_source"
      expr: entitlement_source
      comment: "Source that granted the benefit (e.g., Tier, Promotion, Manual). Identifies which program mechanisms drive benefit issuance."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier associated with the benefit entitlement. Enables tier-based analysis of benefit cost and utilization."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the benefit became effective. Tracks benefit issuance volume over time."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the benefit expires. Enables proactive identification of benefits at risk of expiring unused."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Indicates whether the benefit is automatically applied. Compares auto-apply vs. manual redemption utilization rates."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Indicates whether the benefit can be transferred to another member. Tracks transferable benefit issuance and associated liability."
    - name: "combinable_flag"
      expr: combinable_flag
      comment: "Indicates whether the benefit can be combined with other offers. Analyzes combinability impact on total benefit cost."
  measures:
    - name: "total_benefit_entitlements_granted"
      expr: COUNT(benefit_entitlement_id)
      comment: "Total number of benefit entitlements granted. Measures the scale of benefit issuance — a key driver of member satisfaction and program cost."
    - name: "distinct_members_with_benefits"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who have received benefit entitlements. Measures benefit program reach across the member base."
    - name: "total_monetary_value_of_benefits"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all benefit entitlements granted. Quantifies the financial cost of the benefit program — critical for loyalty P&L management."
    - name: "avg_monetary_value_per_benefit"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per benefit entitlement. Benchmarks the generosity of individual benefit grants and informs benefit portfolio design."
    - name: "avg_points_multiplier_on_benefits"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier applied through benefit entitlements. Measures the earning acceleration delivered via benefits — informs liability impact."
    - name: "benefit_expiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN entitlement_status = 'Expired' THEN benefit_entitlement_id END) / NULLIF(COUNT(benefit_entitlement_id), 0), 2)
      comment: "Percentage of benefit entitlements that expired unused. High expiry rates indicate poor benefit awareness or redemption friction — signals program design issues."
    - name: "benefit_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN entitlement_status = 'Used' THEN benefit_entitlement_id END) / NULLIF(COUNT(benefit_entitlement_id), 0), 2)
      comment: "Percentage of granted benefits that were actually used. Core measure of benefit program effectiveness and member engagement with the reward portfolio."
    - name: "revoked_benefit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN entitlement_status = 'Revoked' THEN benefit_entitlement_id END) / NULLIF(COUNT(benefit_entitlement_id), 0), 2)
      comment: "Percentage of benefits that were revoked. Elevated revocation rates may signal fraud, policy violations, or operational errors requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty points accrual rule portfolio metrics. Tracks rule configuration, earning rates, tier and segment multipliers, and estimated liability volume to govern the points earning framework and manage program economics."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of accrual rule (e.g., Base Earn, Bonus, Partner). Segments the rule portfolio by earning mechanism."
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the accrual rule (e.g., Active, Inactive, Pending). Used to filter live vs. retired earning rules."
    - name: "earning_basis"
      expr: earning_basis
      comment: "Basis on which points are earned (e.g., Per Currency Unit, Per Night, Per Stay). Identifies the earning mechanic driving points accrual."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual rule. Supports governance tracking of rule approval workflows."
    - name: "property_applicability"
      expr: property_applicability
      comment: "Scope of property applicability for the rule (e.g., All Properties, Specific Properties). Segments rules by geographic or brand scope."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier associated with the accrual rule. Enables analysis of earning rule design by tier level."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the accrual rule became effective. Tracks rule portfolio evolution over time."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Indicates whether the rule can be stacked with other earning rules. Analyzes combinability exposure in the rule portfolio."
  measures:
    - name: "total_active_accrual_rules"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN accrual_rule_id END)
      comment: "Count of currently active accrual rules. Measures the complexity and breadth of the earning rule portfolio — high counts may signal governance risk."
    - name: "total_accrual_rules"
      expr: COUNT(accrual_rule_id)
      comment: "Total count of all accrual rules across all statuses. Measures the full scope of the earning rule portfolio."
    - name: "total_estimated_annual_points_volume"
      expr: SUM(CAST(estimated_annual_points_volume AS DOUBLE))
      comment: "Total estimated annual points volume across all active rules. Measures projected points liability generation — critical for financial planning and hedging."
    - name: "avg_points_per_currency_unit"
      expr: AVG(CAST(points_per_currency_unit AS DOUBLE))
      comment: "Average points awarded per currency unit spent across all rules. Benchmarks the overall generosity of the earning framework."
    - name: "avg_tier_multiplier"
      expr: AVG(CAST(tier_multiplier AS DOUBLE))
      comment: "Average tier multiplier applied across accrual rules. Measures the average earning acceleration provided to tiered members."
    - name: "avg_segment_multiplier"
      expr: AVG(CAST(segment_multiplier AS DOUBLE))
      comment: "Average segment multiplier across accrual rules. Measures the average earning boost provided to targeted member segments."
    - name: "avg_minimum_transaction_amount"
      expr: AVG(CAST(minimum_transaction_amount AS DOUBLE))
      comment: "Average minimum transaction amount required to earn points. Benchmarks the qualifying spend threshold across the rule portfolio — informs accessibility of the earning program."
    - name: "stackable_rule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stackable = TRUE THEN accrual_rule_id END) / NULLIF(COUNT(accrual_rule_id), 0), 2)
      comment: "Percentage of accrual rules that are stackable. High stackability rates increase liability exposure — a key risk governance metric for the program design team."
$$;