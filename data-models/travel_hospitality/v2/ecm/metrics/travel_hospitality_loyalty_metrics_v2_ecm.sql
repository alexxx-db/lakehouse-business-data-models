-- Metric views for domain: loyalty | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points accrual rule configuration metrics tracking earning generosity, rule coverage, and program economics. Used by loyalty program management to govern earning rules, manage liability exposure, and ensure competitive positioning."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of accrual rule (e.g., Base Earn, Bonus Earn, Partner Earn). Used to analyze the composition of the earning rule portfolio."
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the accrual rule (e.g., Active, Inactive, Pending). Used to filter for live earning rules."
    - name: "earning_basis"
      expr: earning_basis
      comment: "Basis on which points are earned (e.g., Revenue, Nights, Transactions). Used to analyze earning rule coverage by activity type."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual rule. Used to track governance compliance in rule deployment."
    - name: "property_id"
      expr: property_id
      comment: "Property to which the accrual rule applies. Used to analyze earning rule coverage and generosity at the property level."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the accrual rule became effective. Used for rule vintage analysis."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Whether the accrual rule can be stacked with other rules. Used to assess combinability risk and potential over-earning scenarios."
  measures:
    - name: "total_accrual_rules"
      expr: COUNT(1)
      comment: "Total count of accrual rules in the program. Measures rule portfolio complexity and governance overhead."
    - name: "active_accrual_rules"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN accrual_rule_id END)
      comment: "Count of currently active accrual rules. Measures the live earning rule footprint and program complexity."
    - name: "avg_points_per_currency_unit"
      expr: AVG(CAST(points_per_currency_unit AS DOUBLE))
      comment: "Average points awarded per currency unit spent across all accrual rules. Measures overall earning generosity and competitive positioning of the program."
    - name: "avg_tier_multiplier"
      expr: AVG(CAST(tier_multiplier AS DOUBLE))
      comment: "Average tier multiplier applied to base earning rates. Used to assess the incremental earning advantage provided to higher-tier members."
    - name: "avg_segment_multiplier"
      expr: AVG(CAST(segment_multiplier AS DOUBLE))
      comment: "Average segment multiplier applied to earning rates. Used to assess targeted earning incentives for specific member segments."
    - name: "total_estimated_annual_points_volume"
      expr: SUM(CAST(estimated_annual_points_volume AS DOUBLE))
      comment: "Sum of estimated annual points volume across all accrual rules. Used for forward-looking points liability forecasting and program financial planning."
    - name: "avg_minimum_transaction_amount"
      expr: AVG(CAST(minimum_transaction_amount AS DOUBLE))
      comment: "Average minimum transaction amount required to trigger earning. Used to assess earning accessibility and ensure rules are calibrated to realistic spend levels."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_benefit_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Entitlement business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`benefit_entitlement`"
  dimensions:
    - name: "Advance Booking Required Days"
      expr: advance_booking_required_days
    - name: "Auto Apply Flag"
      expr: auto_apply_flag
    - name: "Benefit Description"
      expr: benefit_description
    - name: "Benefit Name"
      expr: benefit_name
    - name: "Benefit Type Code"
      expr: benefit_type_code
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Combinable Flag"
      expr: combinable_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligible Property List"
      expr: eligible_property_list
    - name: "Entitlement Source"
      expr: entitlement_source
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Granted Timestamp"
      expr: granted_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Entitlement"
      expr: COUNT(DISTINCT benefit_entitlement_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
    - name: "Total Points Multiplier"
      expr: SUM(points_multiplier)
    - name: "Average Points Multiplier"
      expr: AVG(points_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty certificate issuance and redemption metrics. Tracks certificate portfolio value, redemption rates, expiry patterns, and void activity — used by loyalty operations and finance to manage certificate liability."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`certificate`"
  dimensions:
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certificate (e.g. Free Night, Upgrade, Dining Credit, Spa) — primary dimension for certificate portfolio analysis."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate (e.g. Issued, Redeemed, Expired, Voided) — used to track certificate lifecycle."
    - name: "issue_channel"
      expr: issue_channel
      comment: "Channel through which the certificate was issued — used to analyze issuance distribution."
    - name: "tier_at_issue"
      expr: tier_at_issue
      comment: "Member tier when the certificate was issued — used to analyze certificate issuance by tier."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Whether the certificate can be transferred to another member — used to segment transferable vs. non-transferable liability."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certificate was issued — enables cohort analysis of certificate issuance and redemption patterns."
  measures:
    - name: "total_certificates_issued"
      expr: COUNT(1)
      comment: "Total certificates issued. Baseline volume KPI for certificate program activity."
    - name: "total_face_value_issued"
      expr: SUM(CAST(face_value AS DOUBLE))
      comment: "Total face value of all certificates issued. Measures total certificate liability outstanding — key input to finance liability reporting."
    - name: "avg_face_value_per_certificate"
      expr: AVG(CAST(face_value AS DOUBLE))
      comment: "Average face value per certificate. Used to benchmark certificate generosity and track value trends over time."
    - name: "redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_status = 'Redeemed' THEN certificate_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued certificates that were redeemed. Measures certificate utilization — low rates indicate poor relevance or awareness."
    - name: "expiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_status = 'Expired' THEN certificate_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued certificates that expired unredeemed. High expiry rates indicate member disengagement or poor certificate design."
    - name: "void_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_status = 'Voided' THEN certificate_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates that were voided. Tracks operational exception volume — high void rates may indicate fraud or process issues."
    - name: "complimentary_certificate_count"
      expr: COUNT(CASE WHEN complimentary_flag = TRUE THEN certificate_id END)
      comment: "Count of complimentary certificates issued. Tracks the volume of no-cost certificate grants — used in program cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty fraud detection and resolution metrics. Used by loyalty security and compliance teams to monitor fraud exposure, detection effectiveness, and resolution performance to protect program integrity and member trust."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`fraud_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of fraud alert (e.g., Account Takeover, Points Abuse, Synthetic Identity). Used to categorize fraud patterns and prioritize investigation resources."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the fraud alert (e.g., High, Medium, Low). Used to triage investigation workload and escalation decisions."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the fraud alert (e.g., Open, Under Investigation, Resolved, False Positive). Used to track investigation pipeline."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the fraud (e.g., ML Model, Rule Engine, Manual Report). Used to evaluate detection channel effectiveness."
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the fraud alert (e.g., Account Frozen, Points Reversed, No Action). Used to analyze response patterns."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the fraud was detected. Used for monthly fraud trend analysis and seasonal pattern identification."
    - name: "geolocation_country_code"
      expr: geolocation_country_code
      comment: "Country where the fraudulent activity originated. Used for geographic fraud risk analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the fraudulent activity occurred (e.g., Mobile, Web, Call Center). Used to identify high-risk channels."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether the alert requires regulatory reporting. Used to track compliance obligations arising from fraud incidents."
  measures:
    - name: "total_fraud_alerts"
      expr: COUNT(1)
      comment: "Total count of fraud alerts generated. Measures overall fraud detection volume and program exposure level."
    - name: "total_points_amount_involved"
      expr: SUM(CAST(points_amount_involved AS DOUBLE))
      comment: "Sum of points involved in fraud alerts. Measures the total points at risk from fraudulent activity — directly tied to program liability exposure."
    - name: "total_points_reversed"
      expr: SUM(CAST(points_reversed_amount AS DOUBLE))
      comment: "Sum of points reversed as a result of fraud resolution. Measures the effectiveness of fraud recovery actions in protecting program liability."
    - name: "total_monetary_value_involved"
      expr: SUM(CAST(monetary_value_involved AS DOUBLE))
      comment: "Sum of monetary value involved in fraud alerts. Translates fraud exposure into financial impact for executive risk reporting."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average fraud risk score across all alerts. Used to monitor the overall risk profile of detected fraud and calibrate detection model thresholds."
    - name: "accounts_frozen"
      expr: COUNT(CASE WHEN account_frozen_flag = TRUE THEN fraud_alert_id END)
      comment: "Count of member accounts frozen due to fraud alerts. Measures the operational impact of fraud on member account access."
    - name: "regulatory_reports_required"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN fraud_alert_id END)
      comment: "Count of fraud alerts requiring regulatory reporting. Tracks compliance obligations and regulatory exposure from fraud incidents."
    - name: "distinct_members_affected"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members affected by fraud alerts. Measures the breadth of member impact from fraud activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program enrollment metrics tracking new member acquisition volume, channel mix, and enrollment quality. Used by loyalty acquisition teams and property management to optimize enrollment channels and grow the active member base."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`loyalty_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the enrollment record (e.g., Active, Pending, Rejected). Used to filter for successfully completed enrollments."
    - name: "channel_id"
      expr: channel_id
      comment: "Foreign key to channel.channel. Used to analyze enrollment volume by acquisition channel."
    - name: "property_id"
      expr: property_id
      comment: "Property where the enrollment occurred. Used to attribute enrollment activity to specific properties and measure property-level acquisition performance."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment. Used for monthly new member acquisition trend analysis."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of enrollment. Used for annual acquisition volume reporting."
    - name: "initial_tier"
      expr: initial_tier
      comment: "Tier assigned at enrollment (e.g., Base, Silver via status match). Used to analyze the tier composition of new enrollments."
    - name: "status_match_flag"
      expr: status_match_flag
      comment: "Whether the enrollment included a status match from another program. Used to measure competitive acquisition via status match."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for enrollment (e.g., Mobile, Desktop, Tablet). Used to optimize digital enrollment experience by device."
    - name: "country_code"
      expr: country_code
      comment: "Country of enrollment. Used for geographic acquisition analysis and market expansion tracking."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total count of loyalty program enrollments. Core acquisition KPI measuring new member volume."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN loyalty_enrollment_id END)
      comment: "Count of enrollments with Active status. Measures the volume of successfully activated new members."
    - name: "status_match_enrollments"
      expr: COUNT(CASE WHEN status_match_flag = TRUE THEN loyalty_enrollment_id END)
      comment: "Count of enrollments that included a status match. Measures competitive acquisition volume from status match programs."
    - name: "total_welcome_bonus_points"
      expr: SUM(CAST(welcome_bonus_points AS DOUBLE))
      comment: "Sum of welcome bonus points awarded to new enrollees. Measures the total points liability generated by enrollment incentives."
    - name: "avg_welcome_bonus_points"
      expr: AVG(CAST(welcome_bonus_points AS DOUBLE))
      comment: "Average welcome bonus points per enrollment. Used to benchmark enrollment incentive generosity and optimize acquisition cost."
    - name: "distinct_enrolling_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Count of distinct properties generating enrollments. Measures property-level enrollment program participation breadth."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Enrollment business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`loyalty_enrollment`"
  dimensions:
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Documentation Submitted Flag"
      expr: documentation_submitted_flag
    - name: "Email Consent Flag"
      expr: email_consent_flag
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Enrollment Timestamp"
      expr: enrollment_timestamp
    - name: "Initial Tier"
      expr: initial_tier
    - name: "Ip Address"
      expr: ip_address
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Match Expiry Date"
      expr: match_expiry_date
    - name: "Match Tier Granted"
      expr: match_tier_granted
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Enrollment"
      expr: COUNT(DISTINCT loyalty_enrollment_id)
    - name: "Total Welcome Bonus Points"
      expr: SUM(welcome_bonus_points)
    - name: "Average Welcome Bonus Points"
      expr: AVG(welcome_bonus_points)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member health and value metrics. Tracks active membership base, lifetime value, points liability, and engagement signals used by loyalty program leadership to steer acquisition, retention, and tier strategy."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership account (e.g., Active, Suspended, Closed). Primary filter for active-base analysis."
    - name: "tier_id"
      expr: tier_id
      comment: "Foreign key to loyalty.tier. Used to slice member KPIs by tier level (Base, Silver, Gold, Platinum)."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g., Web, Mobile, Front Desk). Informs acquisition channel effectiveness."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of enrollment. Used for cohort analysis and year-over-year membership growth tracking."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment. Used for monthly enrollment trend analysis."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Boolean flag indicating VIP designation. Used to segment high-value members for targeted analysis."
    - name: "primary_enrollment_property_id"
      expr: primary_member_enrollment_hotel_property_id
      comment: "Property where the member originally enrolled. Used to attribute membership growth to specific properties."
    - name: "communication_opt_in"
      expr: communication_opt_in
      comment: "Whether the member has opted into communications. Used to size reachable audience for marketing campaigns."
    - name: "last_stay_year"
      expr: DATE_TRUNC('YEAR', last_stay_date)
      comment: "Year of the member's most recent stay. Used to identify recency cohorts and lapsed members."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN member_id END)
      comment: "Count of members with Active status. Core KPI for measuring the size of the active loyalty base. Executives use this to track program health and growth trajectory."
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total count of all member records regardless of status. Used as denominator for active rate and churn rate calculations."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all lifetime points earned across the member base. Indicates total program engagement volume and points liability exposure."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Sum of current unredeemed points balances across all members. Represents the outstanding points liability that must be funded by the program."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Sum of all points redeemed by members. Measures redemption activity and program engagement depth."
    - name: "total_points_expired"
      expr: SUM(CAST(points_expired AS DOUBLE))
      comment: "Sum of all points that have expired without redemption. Indicates breakage volume, which directly impacts program liability and P&L."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Sum of lifetime revenue attributed to loyalty members. Core financial KPI linking loyalty program investment to revenue generation."
    - name: "avg_lifetime_revenue_per_member"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per member. Used to benchmark member value and assess ROI of loyalty program spend."
    - name: "total_ytd_revenue"
      expr: SUM(CAST(ytd_revenue AS DOUBLE))
      comment: "Sum of year-to-date revenue from loyalty members. Used in quarterly business reviews to track in-year loyalty revenue contribution."
    - name: "avg_ytd_revenue_per_member"
      expr: AVG(CAST(ytd_revenue AS DOUBLE))
      comment: "Average year-to-date revenue per member. Tracks in-year member productivity and informs tier qualification thresholds."
    - name: "avg_salt_score"
      expr: AVG(CAST(salt_score AS DOUBLE))
      comment: "Average SALT (Satisfaction and Loyalty Tracking) score across members. Measures overall member satisfaction and loyalty sentiment for program quality steering."
    - name: "total_vip_members"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN member_id END)
      comment: "Count of members with VIP designation. Used to track the size of the highest-value member cohort and ensure appropriate service resourcing."
    - name: "members_with_opt_in"
      expr: COUNT(CASE WHEN communication_opt_in = TRUE THEN member_id END)
      comment: "Count of members opted into communications. Defines the reachable audience for loyalty marketing campaigns and promotions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_member_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Preference business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`member_preference`"
  dimensions:
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Confidence Level"
      expr: confidence_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Confirmed Date"
      expr: last_confirmed_date
    - name: "Last Observed Date"
      expr: last_observed_date
    - name: "Last Updated Date"
      expr: last_updated_date
    - name: "Notes"
      expr: notes
    - name: "Observation Count"
      expr: observation_count
    - name: "Override Flag"
      expr: override_flag
    - name: "Preference Category"
      expr: preference_category
    - name: "Preference Source"
      expr: preference_source
    - name: "Preference Status"
      expr: preference_status
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Property Restriction"
      expr: property_restriction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Preference"
      expr: COUNT(DISTINCT member_preference_id)
    - name: "Total Preference Value"
      expr: SUM(preference_value)
    - name: "Average Preference Value"
      expr: AVG(preference_value)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Segment business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`member_segment`"
  dimensions:
    - name: "Allow Overlap Flag"
      expr: allow_overlap_flag
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Campaign Eligible Flag"
      expr: campaign_eligible_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Member Count"
      expr: current_member_count
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusion Criteria"
      expr: exclusion_criteria
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Inclusion Criteria"
      expr: inclusion_criteria
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Refresh Timestamp"
      expr: last_refresh_timestamp
    - name: "Maximum Nights"
      expr: maximum_nights
    - name: "Minimum Nights"
      expr: minimum_nights
    - name: "Minimum Stays"
      expr: minimum_stays
    - name: "Model Version"
      expr: model_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Segment"
      expr: COUNT(DISTINCT member_segment_id)
    - name: "Total Confidence Threshold"
      expr: SUM(confidence_threshold)
    - name: "Average Confidence Threshold"
      expr: AVG(confidence_threshold)
    - name: "Total Engagement Score Threshold"
      expr: SUM(engagement_score_threshold)
    - name: "Average Engagement Score Threshold"
      expr: AVG(engagement_score_threshold)
    - name: "Total Maximum Ltv"
      expr: SUM(maximum_ltv)
    - name: "Average Maximum Ltv"
      expr: AVG(maximum_ltv)
    - name: "Total Minimum Ltv"
      expr: SUM(minimum_ltv)
    - name: "Average Minimum Ltv"
      expr: AVG(minimum_ltv)
    - name: "Total Salt Score Threshold"
      expr: SUM(salt_score_threshold)
    - name: "Average Salt Score Threshold"
      expr: AVG(salt_score_threshold)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_package_purchase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty spa package purchase metrics. Tracks package sales volume, revenue, and session utilization — used by loyalty and spa leadership to evaluate package program performance and member engagement."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`package_purchase`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package purchase (e.g. Active, Expired, Fully Used, Cancelled) — primary dimension for package lifecycle analysis."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the package was purchased — used to analyze package sales channel mix."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the package purchase — used for multi-currency package revenue reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property where the package was purchased — used for property-level package sales analysis."
    - name: "purchase_month"
      expr: DATE_TRUNC('MONTH', purchase_date)
      comment: "Month of package purchase — enables trend analysis of package sales over time."
  measures:
    - name: "total_package_purchases"
      expr: COUNT(1)
      comment: "Total package purchases. Baseline volume KPI for loyalty package program activity."
    - name: "total_package_revenue"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total revenue from loyalty package purchases. Measures the direct revenue contribution of the package program."
    - name: "avg_package_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per package. Used to track package pricing trends and benchmark against market rates."
    - name: "distinct_purchasing_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who purchased packages. Measures package program reach across the member base."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_partner_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Program business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`partner_program`"
  dimensions:
    - name: "Api Authentication Method"
      expr: api_authentication_method
    - name: "Api Integration Endpoint"
      expr: api_integration_endpoint
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Consent Flag"
      expr: data_sharing_consent_flag
    - name: "Earn Eligibility Flag"
      expr: earn_eligibility_flag
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
    - name: "Marketing Consent Flag"
      expr: marketing_consent_flag
    - name: "Maximum Transfer Amount"
      expr: maximum_transfer_amount
    - name: "Minimum Transfer Amount"
      expr: minimum_transfer_amount
    - name: "Partner Code"
      expr: partner_code
    - name: "Partner Contact Email"
      expr: partner_contact_email
    - name: "Partner Contact Name"
      expr: partner_contact_name
    - name: "Partner Contact Phone"
      expr: partner_contact_phone
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Program"
      expr: COUNT(DISTINCT partner_program_id)
    - name: "Total Hotel To Partner Ratio"
      expr: SUM(hotel_to_partner_ratio)
    - name: "Average Hotel To Partner Ratio"
      expr: AVG(hotel_to_partner_ratio)
    - name: "Total Partner To Hotel Ratio"
      expr: SUM(partner_to_hotel_ratio)
    - name: "Average Partner To Hotel Ratio"
      expr: AVG(partner_to_hotel_ratio)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points transaction ledger metrics tracking points flow, accrual, redemption, and transfer activity. Used by loyalty finance and operations teams to manage points liability, detect anomalies, and optimize earning/burning behavior."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (e.g., Earn, Redeem, Adjust, Transfer, Expire). Primary dimension for understanding points flow composition."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the points transaction (e.g., Posted, Pending, Reversed). Used to filter for confirmed vs. in-flight transactions."
    - name: "source_activity_type"
      expr: source_activity_type
      comment: "Business activity that generated the points transaction (e.g., Stay, Dining, Spa). Used to attribute points volume to revenue-generating activities."
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of the points activity. Used for monthly trend analysis of points accrual and redemption."
    - name: "activity_year"
      expr: DATE_TRUNC('YEAR', activity_date)
      comment: "Year of the points activity. Used for annual points liability and program performance reporting."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the ledger. Used for financial period alignment of points liability."
    - name: "is_qualifying"
      expr: is_qualifying
      comment: "Whether the transaction counts toward tier qualification. Used to separate qualifying vs. non-qualifying points for tier management analysis."
    - name: "tier_at_transaction"
      expr: tier_at_transaction
      comment: "Member tier at the time of the transaction. Used to analyze points behavior by tier cohort."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of points transfer (e.g., In, Out). Used to track partner transfer flows and net points position."
    - name: "property_id"
      expr: property_id
      comment: "Property where the points activity originated. Used to attribute points liability to specific properties."
  measures:
    - name: "total_points_transacted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points amount across all ledger transactions. Measures gross points flow volume for liability management and program scale assessment."
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Sum of the base monetary amounts underlying points transactions. Links points activity to revenue value for cost-per-point analysis."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points amount per ledger transaction. Used to benchmark earning generosity and detect anomalous high-value transactions."
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Sum of fees collected on points transfers to partner programs. Measures fee revenue from partner transfer activity."
    - name: "total_balance_after_transaction"
      expr: SUM(CAST(balance_after_transaction AS DOUBLE))
      comment: "Sum of member balances after each transaction. Used as a proxy for total outstanding points liability across the ledger."
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total count of points ledger transactions. Measures program transaction volume and operational throughput."
    - name: "distinct_active_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members with points ledger activity. Measures the breadth of engaged members generating points transactions."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average currency conversion rate applied to points transactions. Used to monitor rate consistency and detect conversion anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_points_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner points transfer metrics tracking volume, value, and performance of points transfers between the loyalty program and partner programs. Used by loyalty partnerships team to manage partner relationships, transfer economics, and member engagement with partner benefits."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`points_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the points transfer (e.g., Completed, Pending, Failed, Reversed). Used to track transfer pipeline health and failure rates."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of the transfer (e.g., Hotel-to-Partner, Partner-to-Hotel). Used to analyze net points flow between the program and partners."
    - name: "partner_program_id"
      expr: partner_program_id
      comment: "Foreign key to loyalty.partner_program. Used to slice transfer metrics by specific partner programs."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the transfer was requested. Used for monthly transfer volume trend analysis."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the transfer was requested (e.g., Mobile App, Web, Call Center). Used to optimize transfer channel experience."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the transfer was reversed. Used to track reversal rates and identify problematic transfer patterns."
    - name: "transfer_fee_currency_code"
      expr: transfer_fee_currency_code
      comment: "Currency of the transfer fee. Used for multi-currency fee revenue analysis."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total count of points transfer transactions. Measures partner transfer program utilization and member engagement with partner benefits."
    - name: "total_hotel_points_transferred"
      expr: SUM(CAST(hotel_points_amount AS DOUBLE))
      comment: "Sum of hotel loyalty points transferred to/from partner programs. Measures the volume of points flowing through partner transfer channels."
    - name: "total_partner_currency_transferred"
      expr: SUM(CAST(partner_currency_amount AS DOUBLE))
      comment: "Sum of partner currency units received or sent in transfers. Used to assess the value exchange in partner transfer transactions."
    - name: "total_transfer_fees_collected"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Sum of fees collected on points transfers. Measures fee revenue generated from partner transfer activity."
    - name: "total_promotional_bonus_points"
      expr: SUM(CAST(promotional_bonus_points AS DOUBLE))
      comment: "Sum of bonus points awarded on promotional transfer offers. Measures the incremental liability cost of transfer promotions."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate applied in points transfers. Used to monitor rate consistency and detect unfavorable conversion trends."
    - name: "failed_transfers"
      expr: COUNT(CASE WHEN transfer_status = 'Failed' THEN points_transfer_id END)
      comment: "Count of failed transfer transactions. High failure rates indicate API integration issues with partner programs that degrade member experience."
    - name: "reversed_transfers"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN points_transfer_id END)
      comment: "Count of reversed transfer transactions. Measures transfer reversal volume, which may indicate fraud, errors, or member disputes."
    - name: "distinct_transferring_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members using the points transfer feature. Measures partner transfer feature adoption across the member base."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_program_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Config business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`program_config`"
  dimensions:
    - name: "Api Integration Enabled Flag"
      expr: api_integration_enabled_flag
    - name: "Cash Plus Points Enabled Flag"
      expr: cash_plus_points_enabled_flag
    - name: "Ccpa Compliant Flag"
      expr: ccpa_compliant_flag
    - name: "Configuration Effective Date"
      expr: configuration_effective_date
    - name: "Configuration Expiry Date"
      expr: configuration_expiry_date
    - name: "Contact Center Email"
      expr: contact_center_email
    - name: "Contact Center Phone"
      expr: contact_center_phone
    - name: "Conversion Currency Code"
      expr: conversion_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Name"
      expr: currency_name
    - name: "Data Retention Policy Months"
      expr: data_retention_policy_months
    - name: "Family Pooling Enabled Flag"
      expr: family_pooling_enabled_flag
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
    - name: "Gifting Enabled Flag"
      expr: gifting_enabled_flag
    - name: "Inactivity Period Months"
      expr: inactivity_period_months
    - name: "Liability Estimation Method"
      expr: liability_estimation_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Config"
      expr: COUNT(DISTINCT program_config_id)
    - name: "Total Breakage Assumption Rate"
      expr: SUM(breakage_assumption_rate)
    - name: "Average Breakage Assumption Rate"
      expr: AVG(breakage_assumption_rate)
    - name: "Total Points To Currency Conversion Rate"
      expr: SUM(points_to_currency_conversion_rate)
    - name: "Average Points To Currency Conversion Rate"
      expr: AVG(points_to_currency_conversion_rate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty promotion portfolio metrics tracking budget utilization, campaign performance, and promotion economics. Used by loyalty marketing leadership to manage promotion spend, evaluate campaign ROI, and optimize the promotion calendar."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., Bonus Points, Double Miles, Free Night, Discount). Used to analyze performance by promotion mechanic."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (e.g., Active, Expired, Cancelled, Draft). Used to filter for live vs. historical promotions."
    - name: "marketing_channel"
      expr: marketing_channel
      comment: "Channel used to distribute the promotion (e.g., Email, Push, In-App, Direct Mail). Used to assess channel effectiveness for promotion delivery."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the promotion. Used to analyze promotion activity and spend at the property level."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier targeted by the promotion. Used to analyze promotion investment by tier segment."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the promotion started. Used for annual promotion portfolio analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started. Used for monthly promotion calendar analysis."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether the promotion can be stacked with other promotions. Used to assess combinability risk and liability exposure."
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total count of promotions in the portfolio. Measures promotion calendar density and program complexity."
    - name: "total_budget_cap_amount"
      expr: SUM(CAST(budget_cap_amount AS DOUBLE))
      comment: "Sum of budget caps across all promotions. Measures total authorized promotion spend for financial planning and control."
    - name: "total_budget_consumed_amount"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Sum of budget actually consumed by promotions. Measures actual promotion spend against authorized budgets for financial oversight."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across promotions. Used to benchmark promotion generosity and assess points liability per promotion."
    - name: "avg_minimum_spend_amount"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold required to qualify for promotions. Used to calibrate promotion accessibility and revenue attachment."
    - name: "active_promotions"
      expr: COUNT(CASE WHEN promotion_status = 'Active' THEN promotion_id END)
      comment: "Count of currently active promotions. Measures live promotion calendar density and concurrent offer complexity."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_promotion_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Distribution business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`promotion_distribution`"
  dimensions:
    - name: "Actual Bookings"
      expr: actual_bookings
    - name: "Channel Priority Rank"
      expr: channel_priority_rank
    - name: "Created Date"
      expr: created_date
    - name: "Distribution Status"
      expr: distribution_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Performance Target Bookings"
      expr: performance_target_bookings
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Distribution"
      expr: COUNT(DISTINCT promotion_distribution_id)
    - name: "Total Budget Allocation Amount"
      expr: SUM(budget_allocation_amount)
    - name: "Average Budget Allocation Amount"
      expr: AVG(budget_allocation_amount)
    - name: "Total Budget Consumed Amount"
      expr: SUM(budget_consumed_amount)
    - name: "Average Budget Consumed Amount"
      expr: AVG(budget_consumed_amount)
    - name: "Total Promotion Rate Multiplier"
      expr: SUM(promotion_rate_multiplier)
    - name: "Average Promotion Rate Multiplier"
      expr: AVG(promotion_rate_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion enrollment and completion metrics measuring campaign participation, bonus award rates, and promotion effectiveness. Used by loyalty marketing to evaluate promotion ROI and optimize future campaign design."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the promotion enrollment (e.g., Enrolled, Completed, Cancelled, Expired). Used to track enrollment funnel stages."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "How the member enrolled in the promotion (e.g., Auto-Enroll, Self-Enroll, Agent). Used to assess enrollment channel effectiveness."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of promotion enrollment. Used for monthly enrollment trend analysis."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the promotion was completed. Used to track completion timing relative to enrollment."
    - name: "tier_at_enrollment"
      expr: tier_at_enrollment
      comment: "Member tier at the time of enrollment. Used to analyze promotion uptake and completion rates by tier."
    - name: "qualifying_activity_type"
      expr: qualifying_activity_type
      comment: "Type of activity required to qualify for the promotion (e.g., Stay, Spend, Dining). Used to assess which activity types drive promotion completion."
    - name: "promotion_id"
      expr: promotion_id
      comment: "Foreign key to loyalty.promotion. Used to slice enrollment metrics by specific promotion campaigns."
    - name: "bonus_currency_code"
      expr: bonus_currency_code
      comment: "Currency of the bonus award. Used for multi-currency promotion cost analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total count of promotion enrollments. Measures promotion reach and member participation volume."
    - name: "total_completions"
      expr: COUNT(CASE WHEN enrollment_status = 'Completed' THEN promotion_enrollment_id END)
      comment: "Count of enrollments that reached completion status. Core promotion effectiveness KPI — measures how many enrolled members fulfilled the qualifying criteria."
    - name: "total_bonus_points_awarded"
      expr: SUM(CAST(bonus_points AS DOUBLE))
      comment: "Sum of bonus points awarded through promotions. Measures total incremental points liability generated by promotion campaigns."
    - name: "total_bonus_amount_awarded"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Sum of monetary bonus amounts awarded. Measures the direct financial cost of promotion fulfillment."
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average completion progress percentage across active enrollments. Used to forecast completion rates and identify promotions where members are stalling."
    - name: "avg_progress_value"
      expr: AVG(CAST(progress_value AS DOUBLE))
      comment: "Average qualifying activity value achieved toward promotion threshold. Used to assess how close members are to earning their bonus."
    - name: "avg_qualifying_threshold"
      expr: AVG(CAST(qualifying_threshold AS DOUBLE))
      comment: "Average qualifying threshold required to complete the promotion. Used to benchmark promotion difficulty and optimize threshold setting."
    - name: "distinct_enrolled_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members enrolled in promotions. Measures unique member reach of promotion campaigns."
    - name: "bonus_awarded_count"
      expr: COUNT(CASE WHEN bonus_awarded_flag = TRUE THEN promotion_enrollment_id END)
      comment: "Count of enrollments where a bonus was actually awarded. Used to track fulfillment rate and ensure bonus delivery accuracy."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_promotion_treatment_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Treatment Rule business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`promotion_treatment_rule`"
  dimensions:
    - name: "Created Date"
      expr: created_date
    - name: "Current Redemptions"
      expr: current_redemptions
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Maximum Redemptions"
      expr: maximum_redemptions
    - name: "Rule Status"
      expr: rule_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Treatment Rule"
      expr: COUNT(DISTINCT promotion_treatment_rule_id)
    - name: "Total Bonus Points Multiplier"
      expr: SUM(bonus_points_multiplier)
    - name: "Average Bonus Points Multiplier"
      expr: AVG(bonus_points_multiplier)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Minimum Spend"
      expr: SUM(minimum_spend)
    - name: "Average Minimum Spend"
      expr: AVG(minimum_spend)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_benefit_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit fulfillment and delivery metrics. Tracks benefit redemption volumes, cost to property, SLA compliance, and exception rates — used by loyalty operations and property management to ensure benefit delivery quality."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_benefit_redemptions"
      expr: COUNT(1)
      comment: "Total benefit redemption events. Baseline volume KPI for benefit delivery operations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points redemption metrics tracking redemption volume, value, and fulfillment performance. Used by loyalty operations and finance to manage redemption liability, optimize reward catalog, and ensure member satisfaction."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (e.g., Free Night, Upgrade, Dining, Spa). Used to analyze redemption mix and reward catalog utilization."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (e.g., Confirmed, Cancelled, Fulfilled). Used to track fulfillment pipeline and cancellation rates."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the redemption was fulfilled (e.g., Property, Online, Call Center). Used to optimize fulfillment operations."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the redemption was requested. Used for monthly redemption trend analysis and liability forecasting."
    - name: "request_year"
      expr: DATE_TRUNC('YEAR', request_date)
      comment: "Year the redemption was requested. Used for annual redemption volume and liability reporting."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier at the time of redemption. Used to analyze redemption behavior by tier and assess tier benefit utilization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption monetary value. Used for multi-currency redemption analysis."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total count of redemption transactions. Measures overall redemption activity volume and program engagement depth."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Sum of all points redeemed. Core liability reduction metric — directly reduces outstanding points balance and program liability."
    - name: "total_points_refunded"
      expr: SUM(CAST(points_refunded AS DOUBLE))
      comment: "Sum of points refunded due to cancellations or disputes. Measures redemption reversal volume and its impact on liability."
    - name: "total_monetary_equivalent_value"
      expr: SUM(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Sum of the monetary equivalent value of all redemptions. Translates points redemptions into dollar value for P&L impact assessment."
    - name: "total_cash_amount"
      expr: SUM(CAST(cash_amount AS DOUBLE))
      comment: "Sum of cash components in cash-plus-points redemptions. Measures cash co-payment revenue from hybrid redemption transactions."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points redeemed per transaction. Used to benchmark redemption cost and assess reward catalog pricing adequacy."
    - name: "avg_monetary_value_per_redemption"
      expr: AVG(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Average monetary equivalent value per redemption. Used to assess the average cost of fulfilling a redemption for program economics."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who have redeemed. Measures redemption participation breadth — a key indicator of program value perception."
    - name: "cancelled_redemptions"
      expr: COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END)
      comment: "Count of cancelled redemptions. High cancellation rates signal fulfillment issues or member dissatisfaction with reward options."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_redemption_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption Rule business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`redemption_rule`"
  dimensions:
    - name: "Advance Booking Days"
      expr: advance_booking_days
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Combinable With Promotions"
      expr: combinable_with_promotions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Property Codes"
      expr: eligible_property_codes
    - name: "Eligible Rate Codes"
      expr: eligible_rate_codes
    - name: "Excluded Property Codes"
      expr: excluded_property_codes
    - name: "Excluded Rate Codes"
      expr: excluded_rate_codes
    - name: "Lra Applicable"
      expr: lra_applicable
    - name: "Maximum Los"
      expr: maximum_los
    - name: "Minimum Los"
      expr: minimum_los
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Redemption Rule"
      expr: COUNT(DISTINCT redemption_rule_id)
    - name: "Total Maximum Earn Per Stay"
      expr: SUM(maximum_earn_per_stay)
    - name: "Average Maximum Earn Per Stay"
      expr: AVG(maximum_earn_per_stay)
    - name: "Total Maximum Redemption Per Transaction"
      expr: SUM(maximum_redemption_per_transaction)
    - name: "Average Maximum Redemption Per Transaction"
      expr: AVG(maximum_redemption_per_transaction)
    - name: "Total Minimum Points Balance"
      expr: SUM(minimum_points_balance)
    - name: "Average Minimum Points Balance"
      expr: AVG(minimum_points_balance)
    - name: "Total Points Rate"
      expr: SUM(points_rate)
    - name: "Average Points Rate"
      expr: AVG(points_rate)
    - name: "Total Tier Multiplier Base"
      expr: SUM(tier_multiplier_base)
    - name: "Average Tier Multiplier Base"
      expr: AVG(tier_multiplier_base)
    - name: "Total Tier Multiplier Gold"
      expr: SUM(tier_multiplier_gold)
    - name: "Average Tier Multiplier Gold"
      expr: AVG(tier_multiplier_gold)
    - name: "Total Tier Multiplier Platinum"
      expr: SUM(tier_multiplier_platinum)
    - name: "Average Tier Multiplier Platinum"
      expr: AVG(tier_multiplier_platinum)
    - name: "Total Tier Multiplier Silver"
      expr: SUM(tier_multiplier_silver)
    - name: "Average Tier Multiplier Silver"
      expr: AVG(tier_multiplier_silver)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_reward_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward Catalog business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`reward_catalog`"
  dimensions:
    - name: "Availability Type"
      expr: availability_type
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Tier Base"
      expr: eligible_tier_base
    - name: "Eligible Tier Gold"
      expr: eligible_tier_gold
    - name: "Eligible Tier Platinum"
      expr: eligible_tier_platinum
    - name: "Eligible Tier Silver"
      expr: eligible_tier_silver
    - name: "Featured Flag"
      expr: featured_flag
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Image Url"
      expr: image_url
    - name: "Inventory Count"
      expr: inventory_count
    - name: "Inventory Threshold"
      expr: inventory_threshold
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reward Catalog"
      expr: COUNT(DISTINCT reward_catalog_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`tier`"
  dimensions:
    - name: "Bonus Points On Enrollment"
      expr: bonus_points_on_enrollment
    - name: "Breakfast Benefit Flag"
      expr: breakfast_benefit_flag
    - name: "Color Code"
      expr: color_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dedicated Support Flag"
      expr: dedicated_support_flag
    - name: "Display Order"
      expr: display_order
    - name: "Downgrade Grace Period Months"
      expr: downgrade_grace_period_months
    - name: "Early Checkin Hours"
      expr: early_checkin_hours
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Guaranteed Availability Flag"
      expr: guaranteed_availability_flag
    - name: "Icon Url"
      expr: icon_url
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Late Checkout Hours"
      expr: late_checkout_hours
    - name: "Lounge Access Flag"
      expr: lounge_access_flag
    - name: "Priority Reservation Flag"
      expr: priority_reservation_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier"
      expr: COUNT(DISTINCT tier_id)
    - name: "Total Points Earning Multiplier"
      expr: SUM(points_earning_multiplier)
    - name: "Average Points Earning Multiplier"
      expr: AVG(points_earning_multiplier)
    - name: "Total Qualification Spend Threshold"
      expr: SUM(qualification_spend_threshold)
    - name: "Average Qualification Spend Threshold"
      expr: AVG(qualification_spend_threshold)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier change history metrics tracking upgrade, downgrade, and retention patterns across the loyalty member base. Used by loyalty program management to evaluate tier qualification effectiveness, status match activity, and tier mobility trends."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`tier_history`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of tier change (e.g., Upgrade, Downgrade, Renewal, Status Match, Override). Primary dimension for analyzing tier mobility direction."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the tier change. Used to distinguish organic qualification from manual overrides and status matches."
    - name: "new_tier_id"
      expr: new_tier_id
      comment: "Foreign key to loyalty.tier for the new tier assigned. Used to analyze which tiers members are moving into."
    - name: "previous_tier_code"
      expr: previous_tier_code
      comment: "Tier code before the change. Used to construct tier transition matrices (e.g., Silver-to-Gold upgrade rates)."
    - name: "qualification_basis"
      expr: qualification_basis
      comment: "Basis on which tier qualification was determined (e.g., Nights, Spend, Points). Used to analyze which qualification track drives the most tier changes."
    - name: "change_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the tier change became effective. Used for annual tier mobility reporting."
    - name: "change_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the tier change became effective. Used for monthly tier movement trend analysis."
    - name: "is_current_tier_flag"
      expr: is_current_tier_flag
      comment: "Whether this record represents the member's current tier. Used to filter for current-state tier distribution analysis."
    - name: "status_match_source_program"
      expr: status_match_source_program
      comment: "Source loyalty program for status match tier grants. Used to analyze competitive status match volume and partner program effectiveness."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(1)
      comment: "Total count of tier change events. Measures overall tier mobility volume and program dynamism."
    - name: "total_upgrades"
      expr: COUNT(CASE WHEN change_type = 'Upgrade' THEN tier_history_id END)
      comment: "Count of tier upgrade events. Measures upward tier mobility — a key indicator of member engagement and program health."
    - name: "total_downgrades"
      expr: COUNT(CASE WHEN change_type = 'Downgrade' THEN tier_history_id END)
      comment: "Count of tier downgrade events. Elevated downgrade rates signal member disengagement or overly aggressive qualification thresholds."
    - name: "total_status_matches"
      expr: COUNT(CASE WHEN change_type = 'Status Match' THEN tier_history_id END)
      comment: "Count of status match tier grants. Measures competitive acquisition activity and the volume of members brought in via status match programs."
    - name: "total_bonus_points_awarded"
      expr: SUM(CAST(bonus_points_awarded AS DOUBLE))
      comment: "Sum of bonus points awarded at tier change events. Measures the incremental points liability generated by tier upgrade bonuses."
    - name: "avg_qualifying_points_achieved"
      expr: AVG(CAST(qualifying_points_achieved AS DOUBLE))
      comment: "Average qualifying points achieved at the time of tier change. Used to benchmark how far above or below threshold members are when they qualify."
    - name: "avg_qualifying_spend_amount"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend amount at tier change. Used to assess the revenue contribution of members at each tier transition point."
    - name: "avg_threshold_spend_required"
      expr: AVG(CAST(threshold_spend_required AS DOUBLE))
      comment: "Average spend threshold required for tier qualification. Used to evaluate whether qualification thresholds are appropriately calibrated to member behavior."
    - name: "distinct_members_with_tier_change"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who experienced a tier change. Measures the breadth of tier mobility across the member base."
    - name: "tier_extensions_granted"
      expr: COUNT(CASE WHEN tier_extension_granted_flag = TRUE THEN tier_history_id END)
      comment: "Count of tier extension grants. Measures the volume of discretionary tier extensions, which represent a cost and a retention investment."
$$;
