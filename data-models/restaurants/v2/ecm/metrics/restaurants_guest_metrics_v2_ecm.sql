-- Metric views for domain: guest | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile KPIs measuring guest base size, engagement quality, loyalty enrollment, marketing reachability, and average lifetime spend. Used by CX, Marketing, and Loyalty leadership to steer acquisition, retention, and personalization strategy."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "guest_type"
      expr: guest_type
      comment: "Classifies guests by type (e.g. loyalty member, corporate, walk-in) for segmented analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Guest loyalty tier (e.g. Bronze, Silver, Gold) enabling tier-based performance comparison."
    - name: "profile_status"
      expr: profile_status
      comment: "Active/inactive/suspended status of the guest profile for cohort filtering."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Guest preferred language for localization and communication strategy analysis."
    - name: "country_code"
      expr: country_code
      comment: "Guest country code for geographic segmentation of the guest base."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the guest has opted into marketing communications — critical for reachable audience sizing."
    - name: "data_source"
      expr: data_source
      comment: "Origin system of the guest profile record (e.g. POS, app, web) for data quality and channel attribution."
    - name: "primary_contact_method"
      expr: primary_contact_method
      comment: "Preferred contact method (email, SMS, push) for channel strategy decisions."
  measures:
    - name: "total_active_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct active guest profiles. Core audience size KPI used by Marketing and CX leadership to track guest base growth."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of total lifetime spend across all guest profiles. Primary revenue-linkage KPI for the guest base; drives LTV segmentation and retention investment decisions."
    - name: "avg_lifetime_spend_per_guest"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average lifetime spend per guest profile. Benchmarks guest value and informs acquisition cost thresholds and loyalty investment levels."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value across guest profiles. Indicates spending behavior and is used to set upsell and combo-meal targets."
    - name: "marketing_reachable_guests"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Count of guests who have opted into marketing. Defines the addressable audience for campaigns and directly impacts campaign ROI projections."
    - name: "loyalty_enrolled_guests"
      expr: COUNT(DISTINCT CASE WHEN loyalty_tier IS NOT NULL AND loyalty_tier <> '' THEN profile_id END)
      comment: "Count of guests enrolled in a loyalty tier. Tracks loyalty program penetration — a key driver of repeat visit frequency and lifetime value."
    - name: "email_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_email = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guest profiles with email consent. Governs the legal reachable email audience and is a compliance and marketing effectiveness KPI."
    - name: "sms_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_sms = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guest profiles with SMS consent. Governs the legal reachable SMS audience for time-sensitive promotions and operational alerts."
    - name: "privacy_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_privacy = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guest profiles with privacy consent. Critical compliance KPI for GDPR/CCPA adherence; a drop triggers immediate legal and operational review."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction and NPS KPIs derived from post-visit surveys. Used by Operations, CX, and Franchise leadership to monitor service quality, identify underperforming units, and drive corrective action."
  source: "`vibe_restaurants_v1`.`guest`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (e.g. post-visit, delivery, drive-thru) for channel-specific satisfaction analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the visit occurred (breakfast, lunch, dinner) enabling time-of-day quality analysis."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Service channel (dine-in, drive-thru, delivery, takeout) for channel-level satisfaction benchmarking."
    - name: "completion_status"
      expr: completion_status
      comment: "Whether the survey was fully completed — used to assess survey response quality and completion rates."
    - name: "satisfaction_survey_status"
      expr: satisfaction_survey_status
      comment: "Processing status of the survey record for data quality filtering."
    - name: "language"
      expr: language
      comment: "Language in which the survey was completed for localization and demographic analysis."
    - name: "visit_date"
      expr: DATE_TRUNC('month', visit_date)
      comment: "Visit date truncated to month for trend analysis of satisfaction scores over time."
  measures:
    - name: "total_surveys_completed"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END)
      comment: "Total number of fully completed satisfaction surveys. Baseline volume KPI for survey program health and statistical significance of scores."
    - name: "survey_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END) / NULLIF(COUNT(DISTINCT satisfaction_survey_id), 0), 2)
      comment: "Percentage of initiated surveys that were fully completed. Low completion rates signal survey fatigue or UX issues that reduce the reliability of satisfaction data."
    - name: "total_surveys_distributed"
      expr: COUNT(DISTINCT satisfaction_survey_id)
      comment: "Total surveys distributed across all channels. Used to size the feedback program and assess reach relative to visit volume."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest complaint volume, resolution, and escalation KPIs. Used by Operations, CX, and Quality leadership to monitor service failures, track resolution effectiveness, and identify systemic issues requiring intervention."
  source: "`vibe_restaurants_v1`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint (e.g. food quality, service, cleanliness) for root-cause analysis."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (open, resolved, escalated) for workload and SLA monitoring."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the complaint was resolved (refund, replacement, apology) for resolution strategy analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Whether the complaint has been resolved — used to track open vs. closed complaint backlog."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint for prioritization and escalation threshold monitoring."
    - name: "channel"
      expr: channel
      comment: "Channel through which the complaint was received (app, phone, in-store) for channel-level quality analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the complaint was escalated — used to track escalation rates as a service quality signal."
    - name: "complaint_month"
      expr: DATE_TRUNC('month', complaint_timestamp)
      comment: "Month of complaint submission for trend analysis of complaint volume over time."
  measures:
    - name: "total_complaints"
      expr: COUNT(DISTINCT complaint_id)
      comment: "Total number of guest complaints received. Primary service quality KPI; a rising trend triggers operational investigation and corrective action."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN complaint_id END) / NULLIF(COUNT(DISTINCT complaint_id), 0), 2)
      comment: "Percentage of complaints that were escalated. High escalation rates indicate systemic service failures or inadequate frontline resolution capability."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN resolution_status = 'resolved' THEN complaint_id END) / NULLIF(COUNT(DISTINCT complaint_id), 0), 2)
      comment: "Percentage of complaints that have been resolved. Core SLA compliance KPI for the guest relations function."
    - name: "total_resolution_spend"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total monetary value of complaint resolutions (refunds, vouchers, replacements). Tracks the financial cost of service failures and informs quality investment decisions."
    - name: "avg_resolution_amount"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average monetary resolution amount per complaint. Benchmarks resolution generosity and helps calibrate compensation policy to balance guest satisfaction and cost."
    - name: "consent_given_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_given = TRUE THEN complaint_id END) / NULLIF(COUNT(DISTINCT complaint_id), 0), 2)
      comment: "Percentage of complaints where the guest provided data processing consent. Compliance KPI ensuring complaint data is handled lawfully under privacy regulations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest lifetime value (LTV) KPIs measuring historical spend, predicted future value, visit frequency, and recency. Used by Marketing, Finance, and Loyalty leadership to prioritize retention investment, segment high-value guests, and forecast revenue."
  source: "`vibe_restaurants_v1`.`guest`.`lifetime_value`"
  dimensions:
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "LTV tier classification (e.g. High, Medium, Low) for value-based guest segmentation."
    - name: "ltv_status"
      expr: ltv_status
      comment: "Status of the LTV calculation record for data quality filtering."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Whether the guest is a loyalty program member — enables loyalty vs. non-loyalty LTV comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the LTV amounts for multi-currency reporting normalization."
    - name: "segment"
      expr: segment
      comment: "Guest segment label assigned during LTV calculation for cohort-level value analysis."
    - name: "ltv_calculation_month"
      expr: DATE_TRUNC('month', ltv_calculation_date)
      comment: "Month of LTV calculation for tracking how guest value estimates evolve over time."
  measures:
    - name: "total_historical_spend"
      expr: SUM(CAST(total_historical_spend AS DOUBLE))
      comment: "Sum of all historical spend across guest LTV records. Primary revenue-linkage KPI for the guest base; used in financial forecasting and retention ROI calculations."
    - name: "avg_historical_spend_per_guest"
      expr: AVG(CAST(total_historical_spend AS DOUBLE))
      comment: "Average historical spend per guest LTV record. Benchmarks guest value and informs acquisition cost thresholds and loyalty tier design."
    - name: "total_predicted_future_value"
      expr: SUM(CAST(predicted_future_value AS DOUBLE))
      comment: "Sum of predicted future value across all guests. Forward-looking revenue KPI used by Finance and Marketing to size retention investment and forecast long-term revenue."
    - name: "avg_predicted_future_value"
      expr: AVG(CAST(predicted_future_value AS DOUBLE))
      comment: "Average predicted future value per guest. Used to set per-guest retention spend thresholds and evaluate the ROI of loyalty program enhancements."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value from LTV records. Tracks spending intensity per visit and informs upsell and menu pricing strategy."
    - name: "avg_transactions_per_month"
      expr: AVG(CAST(average_transactions_per_month AS DOUBLE))
      comment: "Average number of transactions per month per guest. Measures visit frequency — a key driver of LTV and loyalty program engagement."
    - name: "loyalty_member_ltv_share"
      expr: ROUND(100.0 * SUM(CASE WHEN loyalty_member_flag = TRUE THEN total_historical_spend ELSE 0 END) / NULLIF(SUM(CAST(total_historical_spend AS DOUBLE)), 0), 2)
      comment: "Percentage of total historical spend attributable to loyalty program members. Quantifies the revenue contribution of the loyalty program — a core justification metric for loyalty investment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent and privacy compliance KPIs tracking consent status, type, channel, and opt-in rates. Used by Legal, Compliance, and Marketing leadership to ensure regulatory adherence (GDPR, CCPA) and manage the legally reachable audience."
  source: "`vibe_restaurants_v1`.`guest`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (active, revoked, expired) for compliance monitoring."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent granted (marketing, data processing, third-party sharing) for purpose-specific compliance reporting."
    - name: "consent_source_channel"
      expr: consent_source_channel
      comment: "Channel through which consent was collected (app, web, in-store) for consent collection strategy analysis."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Business purpose for which consent was granted — required for GDPR purpose-limitation compliance."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to collect consent (opt-in form, verbal, digital signature) for audit trail analysis."
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_timestamp)
      comment: "Month consent was recorded for trend analysis of consent collection volume and revocation rates."
  measures:
    - name: "total_active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Total number of active consent records. Defines the legally compliant audience for data processing and marketing — a critical compliance and marketing reach KPI."
    - name: "total_revoked_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'revoked' THEN consent_record_id END)
      comment: "Total number of revoked consent records. A rising revocation count signals trust erosion or privacy incidents requiring immediate leadership attention."
    - name: "consent_revocation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'revoked' THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records that have been revoked. Key compliance health metric; spikes trigger privacy incident investigation and regulatory notification processes."
    - name: "email_consent_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with email opt-in. Governs the legal email marketing audience size and directly impacts campaign reach and revenue."
    - name: "sms_consent_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sms_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with SMS opt-in. Governs the legal SMS marketing audience and is critical for time-sensitive promotional campaigns."
    - name: "third_party_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records permitting third-party data sharing. Determines the addressable audience for partner marketing programs and data monetization initiatives."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with marketing consent. Core marketing compliance KPI; determines the legally reachable audience for all promotional activities."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_digital_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital account engagement and security KPIs measuring app adoption, account health, two-factor authentication adoption, and privacy opt-out rates. Used by Digital, CX, and Security leadership to drive app engagement and manage digital risk."
  source: "`vibe_restaurants_v1`.`guest`.`digital_account`"
  dimensions:
    - name: "digital_account_status"
      expr: digital_account_status
      comment: "Status of the digital account (active, suspended, locked) for account health segmentation."
    - name: "account_tier"
      expr: account_tier
      comment: "Digital account tier for value-based segmentation of the digital guest base."
    - name: "registration_channel"
      expr: registration_channel
      comment: "Channel through which the digital account was registered (app, web, kiosk) for acquisition channel analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the digital account (iOS, Android, web) for platform strategy decisions."
    - name: "two_factor_enabled"
      expr: two_factor_enabled
      comment: "Whether two-factor authentication is enabled — security posture KPI for the digital guest base."
    - name: "consent_marketing"
      expr: consent_marketing
      comment: "Whether the digital account holder has consented to marketing communications."
  measures:
    - name: "total_active_digital_accounts"
      expr: COUNT(DISTINCT CASE WHEN digital_account_status = 'active' THEN digital_account_id END)
      comment: "Total number of active digital accounts. Primary digital channel adoption KPI; tracks the size of the digitally engaged guest base for app investment decisions."
    - name: "two_factor_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN two_factor_enabled = TRUE THEN digital_account_id END) / NULLIF(COUNT(DISTINCT digital_account_id), 0), 2)
      comment: "Percentage of digital accounts with two-factor authentication enabled. Security posture KPI; low adoption increases fraud and account takeover risk, triggering security investment decisions."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_marketing = TRUE THEN digital_account_id END) / NULLIF(COUNT(DISTINCT digital_account_id), 0), 2)
      comment: "Percentage of digital accounts with marketing consent. Determines the legally reachable digital audience for in-app and push notification campaigns."
    - name: "privacy_opt_out_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN privacy_opt_out = TRUE THEN digital_account_id END) / NULLIF(COUNT(DISTINCT digital_account_id), 0), 2)
      comment: "Percentage of digital accounts that have opted out of data processing. Rising opt-out rates signal privacy trust issues and reduce the addressable digital audience for personalization."
    - name: "third_party_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_third_party = TRUE THEN digital_account_id END) / NULLIF(COUNT(DISTINCT digital_account_id), 0), 2)
      comment: "Percentage of digital accounts consenting to third-party data sharing. Governs the audience available for partner integrations and data monetization programs."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest interaction volume and channel engagement KPIs. Used by Marketing, CX, and Operations leadership to measure touchpoint frequency, channel effectiveness, and campaign-driven engagement."
  source: "`vibe_restaurants_v1`.`guest`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of guest interaction (e.g. complaint, inquiry, promotion redemption) for interaction mix analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (app, web, in-store, call center) for channel effectiveness analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (resolved, escalated, converted) for effectiveness measurement."
    - name: "is_test"
      expr: is_test
      comment: "Whether the interaction is a test record — used to exclude test data from production metrics."
    - name: "interaction_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the interaction event for trend analysis of engagement volume over time."
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_test = FALSE OR is_test IS NULL THEN interaction_id END)
      comment: "Total number of non-test guest interactions. Measures overall guest engagement touchpoint volume — a leading indicator of relationship health and campaign effectiveness."
    - name: "unique_guests_interacted"
      expr: COUNT(DISTINCT CASE WHEN is_test = FALSE OR is_test IS NULL THEN interaction_profile_id END)
      comment: "Number of distinct guests who had at least one interaction. Measures the breadth of guest engagement — used to assess reach of CX and marketing programs."
    - name: "interactions_per_guest"
      expr: ROUND(COUNT(DISTINCT CASE WHEN is_test = FALSE OR is_test IS NULL THEN interaction_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_test = FALSE OR is_test IS NULL THEN interaction_profile_id END), 0), 2)
      comment: "Average number of interactions per engaged guest. Measures engagement depth — high values indicate strong relationship touchpoints; very high values may indicate unresolved issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level spend, loyalty, and engagement KPIs. Used by Marketing and Loyalty leadership to understand multi-member household value, loyalty penetration, and marketing reachability at the household unit of analysis."
  source: "`vibe_restaurants_v1`.`guest`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Status of the household record (active, dissolved) for cohort filtering."
    - name: "household_type"
      expr: household_type
      comment: "Type of household (e.g. family, individual, corporate) for segment-level analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household for value-based segmentation."
    - name: "loyalty_enrolled"
      expr: loyalty_enrolled
      comment: "Whether the household is enrolled in the loyalty program — enables loyalty vs. non-loyalty household comparison."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the household has opted into marketing communications."
    - name: "estimated_income_band"
      expr: estimated_income_band
      comment: "Estimated household income band for demographic-based value segmentation."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Household preferred communication channel for channel strategy optimization."
  measures:
    - name: "total_household_spend"
      expr: SUM(CAST(total_spend AS DOUBLE))
      comment: "Total lifetime spend across all households. Household-level revenue KPI used to size the value of the household guest base and inform family-oriented marketing investment."
    - name: "avg_household_spend"
      expr: AVG(CAST(total_spend AS DOUBLE))
      comment: "Average lifetime spend per household. Benchmarks household value and informs household-targeted loyalty and promotional investment thresholds."
    - name: "avg_check_value_per_household"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value at the household level. Indicates household spending intensity per visit and informs family meal deal and combo pricing strategy."
    - name: "total_household_transactions"
      expr: SUM(CAST(total_transactions AS DOUBLE))
      comment: "Total number of transactions across all households. Measures household visit frequency at scale — a key driver of household LTV and loyalty program ROI."
    - name: "loyalty_enrolled_household_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_enrolled = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households enrolled in the loyalty program. Tracks loyalty penetration at the household level — a strategic KPI for loyalty program growth and family engagement."
    - name: "marketing_reachable_households"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN household_id END)
      comment: "Number of households opted into marketing. Defines the addressable household audience for family-targeted campaigns and promotional offers."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey response quality and sentiment KPIs. Used by CX, Operations, and Brand leadership to measure guest satisfaction scores, sentiment distribution, and response quality at scale."
  source: "`vibe_restaurants_v1`.`guest`.`survey_response`"
  dimensions:
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which the survey response was submitted (app, email, kiosk) for channel-level response quality analysis."
    - name: "response_type"
      expr: response_type
      comment: "Type of survey response (rating, open text, multiple choice) for response format analysis."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the open-text response (positive, neutral, negative) for brand health monitoring."
    - name: "response_status"
      expr: response_status
      comment: "Processing status of the response record for data quality filtering."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether the response was submitted anonymously — affects the ability to follow up with the guest."
    - name: "is_test_response"
      expr: is_test_response
      comment: "Whether the response is a test record — used to exclude test data from production metrics."
    - name: "response_language"
      expr: response_language
      comment: "Language of the survey response for localization and demographic analysis."
    - name: "response_month"
      expr: DATE_TRUNC('month', response_timestamp)
      comment: "Month of response submission for trend analysis of satisfaction and sentiment over time."
  measures:
    - name: "total_responses"
      expr: COUNT(DISTINCT CASE WHEN is_test_response = FALSE OR is_test_response IS NULL THEN survey_response_id END)
      comment: "Total number of non-test survey responses. Baseline volume KPI for survey program health and statistical significance of satisfaction scores."
    - name: "avg_sentiment_score"
      expr: AVG(CASE WHEN is_test_response = FALSE OR is_test_response IS NULL THEN sentiment_score END)
      comment: "Average sentiment score across all non-test responses. Tracks overall brand sentiment — a leading indicator of guest satisfaction and loyalty that triggers brand and operational interventions."
    - name: "avg_response_value"
      expr: AVG(CASE WHEN is_test_response = FALSE OR is_test_response IS NULL THEN response_value END)
      comment: "Average numeric response value (e.g. rating scale score) across non-test responses. Provides a quantitative satisfaction benchmark used in operational scorecards and QBRs."
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sentiment_label = 'negative' AND (is_test_response = FALSE OR is_test_response IS NULL) THEN survey_response_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_test_response = FALSE OR is_test_response IS NULL THEN survey_response_id END), 0), 2)
      comment: "Percentage of responses with negative sentiment. A rising negative sentiment rate is a leading indicator of brand risk and triggers CX and operational corrective action."
    - name: "positive_sentiment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sentiment_label = 'positive' AND (is_test_response = FALSE OR is_test_response IS NULL) THEN survey_response_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_test_response = FALSE OR is_test_response IS NULL THEN survey_response_id END), 0), 2)
      comment: "Percentage of responses with positive sentiment. Tracks brand advocacy and guest delight — used to benchmark CX program effectiveness and identify high-performing units."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment membership KPIs measuring segment size and guest distribution across segments. Used by Marketing and CX leadership to size audience segments for targeted campaigns and personalization programs."
  source: "`vibe_restaurants_v1`.`guest`.`guest_segment_membership`"
  dimensions:
    - name: "guest_segment_id"
      expr: guest_segment_id
      comment: "Identifier of the guest segment — used to group membership counts by segment for audience sizing."
  measures:
    - name: "total_segment_members"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct guest profiles assigned to each segment. Core audience sizing KPI for segment-targeted marketing campaigns and personalization investment decisions."
    - name: "total_segment_memberships"
      expr: COUNT(DISTINCT guest_segment_membership_id)
      comment: "Total number of segment membership records. Tracks the total volume of segment assignments, including guests in multiple segments, for segmentation model coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_identity_resolution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity resolution quality and guest data hygiene KPIs. Used by Data Governance, CX, and Marketing leadership to monitor duplicate detection, golden record quality, and the accuracy of the unified guest identity graph."
  source: "`vibe_restaurants_v1`.`guest`.`identity_resolution`"
  dimensions:
    - name: "match_method"
      expr: match_method
      comment: "Method used to match and resolve guest identities (deterministic, probabilistic) for resolution quality analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the resolved identity record for active vs. archived record analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest in the resolved identity for segment-level data quality analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the resolved guest identity for value-weighted data quality assessment."
    - name: "golden_record_flag"
      expr: golden_record_flag
      comment: "Whether the record is designated as the golden (master) record for the guest identity."
    - name: "duplicate_flag"
      expr: duplicate_flag
      comment: "Whether the record has been flagged as a duplicate — used to track data quality issues in the identity graph."
    - name: "resolution_month"
      expr: DATE_TRUNC('month', merge_event_timestamp)
      comment: "Month of the identity merge event for trend analysis of resolution activity over time."
  measures:
    - name: "total_golden_records"
      expr: COUNT(DISTINCT CASE WHEN golden_record_flag = TRUE THEN identity_resolution_id END)
      comment: "Total number of golden (master) guest records. Measures the size of the unified guest identity graph — the authoritative count of unique guests in the enterprise."
    - name: "duplicate_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN duplicate_flag = TRUE THEN identity_resolution_id END) / NULLIF(COUNT(DISTINCT identity_resolution_id), 0), 2)
      comment: "Percentage of identity records flagged as duplicates. High duplicate rates degrade personalization, inflate guest counts, and increase marketing waste — a critical data quality KPI."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of identity match decisions. Low average confidence indicates the identity resolution model needs retraining, risking incorrect merges and guest data corruption."
    - name: "avg_data_source_confidence_score"
      expr: AVG(CAST(data_source_confidence_score AS DOUBLE))
      comment: "Average confidence score of the data source contributing to identity resolution. Tracks source data quality and informs decisions about which source systems to prioritize in the identity graph."
    - name: "total_lifetime_spend_resolved_guests"
      expr: SUM(CAST(total_lifetime_spend AS DOUBLE))
      comment: "Total lifetime spend across all resolved guest identity records. Provides a revenue-weighted view of the identity graph — used to assess the financial impact of identity resolution quality."
$$;