-- Metric views for domain: guest | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 19:59:49

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest profile metrics tracking customer lifetime value, engagement, and demographic segmentation for strategic marketing and retention decisions."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the guest profile (active, inactive, suspended) for cohort analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of guest (new, returning, VIP, etc.) for segmentation and targeting."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Guest's preferred language for localized marketing and service delivery."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether guest has opted into marketing communications for campaign targeting."
    - name: "gender"
      expr: gender
      comment: "Guest gender for demographic analysis and personalization."
    - name: "country_code"
      expr: country_code
      comment: "Guest country for geographic market analysis."
    - name: "state"
      expr: state
      comment: "Guest state/province for regional performance tracking."
    - name: "city"
      expr: city
      comment: "Guest city for local market analysis."
    - name: "data_source"
      expr: data_source
      comment: "Origin system of guest profile for data quality and channel attribution."
    - name: "primary_contact_method"
      expr: primary_contact_method
      comment: "Preferred contact channel (email, SMS, phone) for communication strategy."
    - name: "birthday_month"
      expr: birthday_month
      comment: "Month of guest birthday for seasonal campaign planning."
  measures:
    - name: "total_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of guest profiles for customer base sizing and growth tracking."
    - name: "total_lifetime_value"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Aggregate lifetime spend across all guests for revenue attribution and customer value analysis."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average lifetime spend per guest for customer value benchmarking and segment comparison."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction size per guest for pricing strategy and upsell opportunity identification."
    - name: "marketing_opt_in_count"
      expr: SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests opted into marketing for addressable audience sizing."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests opted into marketing for consent health monitoring and campaign reach estimation."
    - name: "email_consent_count"
      expr: SUM(CASE WHEN consent_email = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests consented to email for email campaign audience sizing."
    - name: "sms_consent_count"
      expr: SUM(CASE WHEN consent_sms = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests consented to SMS for SMS campaign audience sizing."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest visit metrics tracking foot traffic, frequency, and visit patterns for operational planning and guest engagement strategy."
  source: "`vibe_restaurants_v1`.`guest`.`visit`"
  dimensions:
    - name: "visit_date"
      expr: DATE_TRUNC('day', CAST(visit_id AS TIMESTAMP))
      comment: "Date of visit for daily traffic trend analysis (using visit_id as proxy timestamp)."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total count of guest visits for traffic volume tracking and capacity planning."
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique guests visiting for reach and engagement measurement."
    - name: "visits_per_guest"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Average visit frequency per guest for loyalty and retention assessment."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest complaint metrics tracking service quality, resolution effectiveness, and customer satisfaction risk for operational excellence and brand protection."
  source: "`vibe_restaurants_v1`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of complaint (open, resolved, escalated) for case management and SLA tracking."
    - name: "category"
      expr: category
      comment: "Complaint category (food quality, service, cleanliness, etc.) for root cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification for prioritization and escalation management."
    - name: "channel"
      expr: channel
      comment: "Channel through which complaint was received for omnichannel service quality monitoring."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome status for closure rate and effectiveness tracking."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided (refund, replacement, apology, etc.) for cost and policy analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether complaint was escalated for severity and handling effectiveness assessment."
    - name: "complaint_month"
      expr: DATE_TRUNC('month', complaint_timestamp)
      comment: "Month of complaint for trend analysis and seasonal pattern identification."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total complaint volume for service quality monitoring and trend detection."
    - name: "unique_complaining_guests"
      expr: COUNT(DISTINCT complaint_profile_id)
      comment: "Unique guests filing complaints for dissatisfaction reach and churn risk assessment."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints escalated for first-contact resolution effectiveness and training needs identification."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total financial compensation paid for complaint cost tracking and budget management."
    - name: "avg_resolution_amount"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average compensation per complaint for cost-per-incident benchmarking and policy evaluation."
    - name: "complaints_per_guest"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT complaint_profile_id), 0), 2)
      comment: "Average complaints per complaining guest for repeat-issue identification and service recovery effectiveness."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction survey metrics tracking NPS, CSAT, and feedback trends for customer experience management and service improvement prioritization."
  source: "`vibe_restaurants_v1`.`guest`.`satisfaction_survey`"
  dimensions:
    - name: "satisfaction_survey_status"
      expr: satisfaction_survey_status
      comment: "Survey completion status for response rate tracking."
    - name: "completion_status"
      expr: completion_status
      comment: "Whether survey was fully completed for data quality assessment."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (transactional, relationship, etc.) for program effectiveness comparison."
    - name: "daypart"
      expr: daypart
      comment: "Time of day for daypart-specific experience analysis."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which survey was delivered for channel effectiveness comparison."
    - name: "language"
      expr: language
      comment: "Survey language for localized experience tracking."
    - name: "nps_score"
      expr: nps_score
      comment: "Net Promoter Score value for loyalty and advocacy measurement."
    - name: "csat_score"
      expr: csat_score
      comment: "Customer Satisfaction Score value for satisfaction level tracking."
    - name: "survey_month"
      expr: DATE_TRUNC('month', response_timestamp)
      comment: "Month of survey response for trend analysis."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total survey volume for feedback program scale and engagement tracking."
    - name: "unique_surveyed_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique guests providing feedback for voice-of-customer reach measurement."
    - name: "completed_surveys"
      expr: SUM(CASE WHEN completion_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of fully completed surveys for data quality and engagement assessment."
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys completed for survey design effectiveness and respondent burden evaluation."
    - name: "consent_given_count"
      expr: SUM(CASE WHEN consent_given = TRUE THEN 1 ELSE 0 END)
      comment: "Count of surveys with consent for follow-up for actionable feedback pool sizing."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest preference metrics tracking dietary needs, communication preferences, and personalization data for targeted marketing and service customization."
  source: "`vibe_restaurants_v1`.`guest`.`preference`"
  dimensions:
    - name: "preference_type"
      expr: preference_type
      comment: "Type of preference recorded for preference portfolio analysis."
    - name: "preference_status"
      expr: preference_status
      comment: "Status of preference record for data currency tracking."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan dietary preference for menu planning and inventory optimization."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Vegetarian dietary preference for menu planning and inventory optimization."
    - name: "has_gluten_allergy"
      expr: has_gluten_allergy
      comment: "Gluten allergy flag for food safety and menu customization."
    - name: "has_nut_allergy"
      expr: has_nut_allergy
      comment: "Nut allergy flag for food safety and menu customization."
    - name: "has_dairy_allergy"
      expr: has_dairy_allergy
      comment: "Dairy allergy flag for food safety and menu customization."
    - name: "is_halal"
      expr: is_halal
      comment: "Halal dietary requirement for menu planning and cultural accommodation."
    - name: "is_kosher"
      expr: is_kosher
      comment: "Kosher dietary requirement for menu planning and cultural accommodation."
    - name: "favorite_cuisine"
      expr: favorite_cuisine
      comment: "Preferred cuisine type for personalization and menu development."
    - name: "preferred_daypart"
      expr: preferred_daypart
      comment: "Preferred dining time for capacity planning and promotional timing."
    - name: "preferred_seating"
      expr: preferred_seating
      comment: "Seating preference for table management and guest experience optimization."
    - name: "preferred_service_channel"
      expr: preferred_service_channel
      comment: "Preferred service channel (dine-in, takeout, delivery) for channel mix planning."
    - name: "communication_channel_preference"
      expr: communication_channel_preference
      comment: "Preferred communication channel for marketing effectiveness optimization."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for localized communication."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Marketing consent status for campaign targeting."
  measures:
    - name: "total_preferences"
      expr: COUNT(1)
      comment: "Total preference records for personalization data richness assessment."
    - name: "unique_guests_with_preferences"
      expr: COUNT(DISTINCT preference_profile_id)
      comment: "Unique guests with recorded preferences for personalization coverage measurement."
    - name: "vegan_guest_count"
      expr: SUM(CASE WHEN is_vegan = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vegan guests for menu planning and inventory decisions."
    - name: "vegetarian_guest_count"
      expr: SUM(CASE WHEN is_vegetarian = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vegetarian guests for menu planning and inventory decisions."
    - name: "gluten_allergy_count"
      expr: SUM(CASE WHEN has_gluten_allergy = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests with gluten allergies for food safety risk management and menu development."
    - name: "nut_allergy_count"
      expr: SUM(CASE WHEN has_nut_allergy = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests with nut allergies for food safety risk management and menu development."
    - name: "dairy_allergy_count"
      expr: SUM(CASE WHEN has_dairy_allergy = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests with dairy allergies for food safety risk management and menu development."
    - name: "halal_guest_count"
      expr: SUM(CASE WHEN is_halal = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests requiring halal options for menu planning and cultural accommodation strategy."
    - name: "kosher_guest_count"
      expr: SUM(CASE WHEN is_kosher = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests requiring kosher options for menu planning and cultural accommodation strategy."
    - name: "active_preference_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active preferences for data currency and personalization effectiveness."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent record metrics tracking privacy compliance, consent health, and regulatory adherence for legal risk management and marketing program governance."
  source: "`vibe_restaurants_v1`.`guest`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status for compliance monitoring and addressable audience tracking."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, data processing, etc.) for consent portfolio management."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Purpose for which consent was granted for use-case specific compliance."
    - name: "consent_method"
      expr: consent_method
      comment: "Method through which consent was captured for audit trail and quality assessment."
    - name: "consent_source_channel"
      expr: consent_source_channel
      comment: "Channel where consent was obtained for channel effectiveness and compliance tracking."
    - name: "email_consent"
      expr: email_consent
      comment: "Email consent flag for email marketing audience sizing."
    - name: "sms_consent"
      expr: sms_consent
      comment: "SMS consent flag for SMS marketing audience sizing."
    - name: "marketing_consent"
      expr: marketing_consent
      comment: "Marketing consent flag for overall marketing addressability."
    - name: "data_sharing_consent"
      expr: data_sharing_consent
      comment: "Data sharing consent flag for third-party partnership compliance."
    - name: "third_party_consent"
      expr: third_party_consent
      comment: "Third-party consent flag for partner marketing compliance."
    - name: "consent_language"
      expr: consent_language
      comment: "Language in which consent was provided for regulatory compliance verification."
    - name: "consent_version"
      expr: consent_version
      comment: "Version of consent terms for audit trail and re-consent campaign management."
    - name: "privacy_notice_version"
      expr: privacy_notice_version
      comment: "Privacy notice version for compliance tracking and update campaign management."
    - name: "consent_revoked_reason"
      expr: consent_revoked_reason
      comment: "Reason for consent revocation for opt-out analysis and program improvement."
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_timestamp)
      comment: "Month of consent for consent acquisition trend analysis."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records for consent management scale and audit readiness."
    - name: "email_consent_count"
      expr: SUM(CASE WHEN email_consent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of email consents for email marketing addressable audience sizing."
    - name: "sms_consent_count"
      expr: SUM(CASE WHEN sms_consent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SMS consents for SMS marketing addressable audience sizing."
    - name: "marketing_consent_count"
      expr: SUM(CASE WHEN marketing_consent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of marketing consents for overall marketing reach estimation."
    - name: "data_sharing_consent_count"
      expr: SUM(CASE WHEN data_sharing_consent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of data sharing consents for partnership program compliance and opportunity sizing."
    - name: "third_party_consent_count"
      expr: SUM(CASE WHEN third_party_consent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of third-party consents for partner marketing compliance and revenue opportunity."
    - name: "email_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records with email consent for consent health monitoring and campaign planning."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records with marketing consent for consent program effectiveness and regulatory compliance assessment."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest interaction metrics tracking engagement touchpoints, channel effectiveness, and customer journey for omnichannel strategy optimization and engagement program ROI."
  source: "`vibe_restaurants_v1`.`guest`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (click, view, purchase, inquiry, etc.) for engagement pattern analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which interaction occurred for omnichannel effectiveness comparison."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of interaction (success, failure, abandoned, etc.) for conversion and effectiveness tracking."
    - name: "is_test"
      expr: is_test
      comment: "Whether interaction was a test for data quality filtering."
    - name: "interaction_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of interaction for engagement trend analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total interaction volume for engagement scale and activity level tracking."
    - name: "unique_interacting_guests"
      expr: COUNT(DISTINCT interaction_profile_id)
      comment: "Unique guests with interactions for engagement reach and active user measurement."
    - name: "interactions_per_guest"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT interaction_profile_id), 0), 2)
      comment: "Average interactions per guest for engagement depth and stickiness assessment."
    - name: "non_test_interactions"
      expr: SUM(CASE WHEN is_test = FALSE THEN 1 ELSE 0 END)
      comment: "Count of production interactions for accurate engagement measurement excluding test data."
$$;
