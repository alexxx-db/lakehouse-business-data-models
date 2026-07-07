-- Metric views for domain: guest | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile metrics tracking the active guest base, engagement health, loyalty enrollment, and average spend per guest. Used by CRM, marketing, and executive teams to assess guest acquisition, retention, and value."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the guest profile (active, inactive, merged, suppressed) — used to filter to active guests or analyze churn."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of the guest (e.g., loyalty member, anonymous, corporate) — drives segmentation and personalization strategy."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty program tier of the guest (e.g., Bronze, Silver, Gold) — key dimension for tier-based performance analysis."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the guest has opted into marketing communications — used to size addressable marketing audience."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Guest preferred language — used for localization and communication strategy."
    - name: "data_source"
      expr: data_source
      comment: "Source system or channel through which the guest profile was created — used to evaluate acquisition channel quality."
    - name: "profile_created_month"
      expr: DATE_TRUNC('MONTH', record_audit_created)
      comment: "Month the guest profile was created — used to track new guest acquisition trends over time."
    - name: "last_visit_month"
      expr: DATE_TRUNC('MONTH', last_visit_timestamp)
      comment: "Month of the guest's most recent visit — used to identify recency cohorts and lapsed guests."
  measures:
    - name: "total_active_guests"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Count of distinct active guest profiles. Core KPI for measuring the size of the engaged guest base — directly informs acquisition and retention investment decisions."
    - name: "total_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total count of all guest profiles regardless of status. Used as the denominator for activation and engagement rate calculations."
    - name: "marketing_opted_in_guests"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Count of guests who have opted into marketing communications. Defines the addressable marketing audience size — critical for campaign planning and ROI forecasting."
    - name: "loyalty_enrolled_guests"
      expr: COUNT(DISTINCT CASE WHEN loyalty_tier IS NOT NULL THEN profile_id END)
      comment: "Count of guests enrolled in the loyalty program. Tracks loyalty program penetration — a key strategic KPI for guest retention programs."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of total historical spend across all guest profiles. Measures the aggregate revenue contribution of the guest base — used in LTV and cohort value analysis."
    - name: "avg_lifetime_spend_per_guest"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average total spend per guest profile. Benchmarks guest value and tracks improvement in monetization over time — used in executive QBRs."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value across guest profiles. Indicates typical transaction size per guest — used to evaluate upsell and menu engineering effectiveness."
    - name: "avg_lifetime_visits"
      expr: AVG(CAST(total_lifetime_visits AS DOUBLE))
      comment: "Average number of lifetime visits per guest profile. Measures guest engagement depth — a leading indicator of loyalty and retention health."
    - name: "consent_privacy_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_privacy = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guest profiles with privacy consent granted. Critical compliance KPI — low rates signal regulatory risk under GDPR/CCPA and limit data usage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest visit behavior metrics tracking visit frequency, spend per visit, dwell time, and channel mix. Used by operations, marketing, and loyalty teams to understand visit patterns and optimize guest experience."
  source: "`vibe_restaurants_v1`.`guest`.`guest_visit`"
  dimensions:
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the guest visit — primary time dimension for visit trend analysis."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the guest visit — used for monthly visit volume and spend trend reporting."
    - name: "visit_channel"
      expr: visit_channel
      comment: "Channel through which the visit occurred (dine-in, drive-thru, delivery, mobile order) — used to analyze channel mix and shift."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g., dine-in, takeout, catering) — used to segment visit behavior by service mode."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the visit (breakfast, lunch, dinner, late night) — used to analyze traffic and spend patterns by time of day."
    - name: "is_loyalty_visit"
      expr: is_loyalty_visit
      comment: "Whether the visit was associated with a loyalty program interaction — used to measure loyalty program engagement lift."
    - name: "is_repeat_visit"
      expr: is_repeat_visit
      comment: "Whether the guest has visited before — used to distinguish new vs. returning guest traffic."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of guest visits. Foundational traffic KPI — used to track footfall trends and evaluate marketing and operational effectiveness."
    - name: "unique_visiting_guests"
      expr: COUNT(DISTINCT primary_guest_profile_id)
      comment: "Count of distinct guests who visited. Measures reach of the guest base — distinguishes traffic volume from unique guest engagement."
    - name: "total_visit_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend across all guest visits. Core revenue KPI at the visit level — used to track revenue trends and evaluate promotional effectiveness."
    - name: "avg_spend_per_visit"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend per guest visit. Measures check average — a key metric for menu engineering, upsell programs, and pricing strategy."
    - name: "avg_check_amount"
      expr: AVG(CAST(check_amount AS DOUBLE))
      comment: "Average check amount per visit. Complements avg_spend_per_visit using the check_amount field — used for cross-validation and POS reconciliation."
    - name: "avg_dwell_time_minutes"
      expr: AVG(CAST(visit_duration_minutes AS DOUBLE))
      comment: "Average time guests spend in the restaurant per visit. Operational efficiency KPI — high dwell times may indicate service bottlenecks or positive engagement depending on format."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average guest satisfaction score at the visit level. Direct measure of guest experience quality — used to identify underperforming units, dayparts, or channels."
    - name: "loyalty_visit_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_loyalty_visit = TRUE THEN guest_visit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits associated with a loyalty program interaction. Measures loyalty program engagement penetration — used to evaluate loyalty ROI and enrollment campaigns."
    - name: "repeat_visit_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_repeat_visit = TRUE THEN guest_visit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits from returning guests. Key retention metric — a rising repeat visit rate indicates improving guest loyalty and satisfaction."
    - name: "avg_party_size"
      expr: AVG(CAST(party_size AS DOUBLE))
      comment: "Average party size per visit. Informs capacity planning, table configuration, and combo/family meal promotion strategy."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest lifetime value (LTV) metrics tracking predicted and historical value, visit frequency, and recency. Used by marketing, finance, and CRM teams to prioritize high-value guest retention and acquisition investments."
  source: "`vibe_restaurants_v1`.`guest`.`lifetime_value`"
  dimensions:
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "LTV tier classification of the guest (e.g., high-value, mid-value, at-risk) — used to prioritize retention spend and personalization."
    - name: "ltv_status"
      expr: ltv_status
      comment: "Current status of the LTV record (active, lapsed, churned) — used to segment guests by engagement lifecycle stage."
    - name: "segment"
      expr: segment
      comment: "Guest segment assigned at LTV calculation time — used to analyze value distribution across behavioral segments."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Whether the guest is a loyalty program member — used to compare LTV of loyalty vs. non-loyalty guests."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which LTV is denominated — used for multi-currency market analysis."
    - name: "ltv_calculation_month"
      expr: DATE_TRUNC('MONTH', ltv_calculation_date)
      comment: "Month the LTV was calculated — used to track LTV trend evolution over time."
  measures:
    - name: "total_historical_spend"
      expr: SUM(CAST(total_historical_spend AS DOUBLE))
      comment: "Sum of total historical spend across all guests. Measures the realized revenue contribution of the guest base — used in cohort value and ROI analysis."
    - name: "avg_historical_spend_per_guest"
      expr: AVG(CAST(total_historical_spend AS DOUBLE))
      comment: "Average historical spend per guest. Benchmarks realized guest value — used to evaluate the effectiveness of retention and upsell programs."
    - name: "total_predicted_future_value"
      expr: SUM(CAST(predicted_future_value AS DOUBLE))
      comment: "Sum of predicted future value across all guests. Forward-looking revenue forecast from the guest base — used in financial planning and marketing budget allocation."
    - name: "avg_predicted_future_value"
      expr: AVG(CAST(predicted_future_value AS DOUBLE))
      comment: "Average predicted future value per guest. Measures expected monetization potential — used to prioritize high-value guest retention investments."
    - name: "avg_transactions_per_month"
      expr: AVG(CAST(average_transactions_per_month AS DOUBLE))
      comment: "Average number of transactions per month per guest. Measures visit frequency — a leading indicator of loyalty and engagement health."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value per guest. Measures typical transaction size — used to evaluate upsell effectiveness and menu pricing impact on guest value."
    - name: "loyalty_member_ltv_ratio"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_member_flag = TRUE THEN lifetime_value_id END) / NULLIF(COUNT(DISTINCT lifetime_value_id), 0), 2)
      comment: "Percentage of LTV records belonging to loyalty members. Measures loyalty program penetration in the high-value guest base — used to justify loyalty program investment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_satisfaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction and NPS metrics from post-visit surveys. Used by operations, brand, and franchise teams to monitor guest experience quality, identify service failures, and track improvement over time."
  source: "`vibe_restaurants_v1`.`guest`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of satisfaction survey (post-visit, delivery, catering, digital) — used to compare satisfaction across service modes."
    - name: "satisfaction_survey_status"
      expr: satisfaction_survey_status
      comment: "Status of the survey (completed, partial, abandoned) — used to filter to valid completed responses."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the survey was delivered (email, SMS, in-app, receipt) — used to evaluate survey channel effectiveness."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the visit associated with the survey — used to identify satisfaction patterns by time of day."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the visit associated with the survey — used for monthly satisfaction trend reporting."
    - name: "language"
      expr: language
      comment: "Language in which the survey was completed — used for localization analysis and to ensure representative sampling."
  measures:
    - name: "total_surveys_completed"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END)
      comment: "Count of fully completed satisfaction surveys. Measures survey response volume — used to assess statistical significance of satisfaction scores."
    - name: "survey_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END) / NULLIF(COUNT(DISTINCT satisfaction_survey_id), 0), 2)
      comment: "Percentage of surveys that were fully completed. Measures survey engagement quality — low completion rates signal survey design or delivery issues."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction (CSAT) score across all surveys. Primary guest experience KPI — used in executive dashboards, franchise scorecards, and operational reviews."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score (NPS) across all surveys. Strategic brand health KPI — used to benchmark against industry and track loyalty program impact on advocacy."
    - name: "promoter_count"
      expr: COUNT(DISTINCT CASE WHEN nps_score >= 9 THEN satisfaction_survey_id END)
      comment: "Count of surveys with NPS score of 9 or 10 (promoters). Used to calculate NPS and identify brand advocates for referral and loyalty programs."
    - name: "detractor_count"
      expr: COUNT(DISTINCT CASE WHEN nps_score <= 6 THEN satisfaction_survey_id END)
      comment: "Count of surveys with NPS score of 6 or below (detractors). Used to calculate NPS and identify at-risk guests requiring service recovery."
    - name: "net_promoter_score"
      expr: ROUND(100.0 * (COUNT(DISTINCT CASE WHEN nps_score >= 9 THEN satisfaction_survey_id END) - COUNT(DISTINCT CASE WHEN nps_score <= 6 THEN satisfaction_survey_id END)) / NULLIF(COUNT(DISTINCT CASE WHEN nps_score IS NOT NULL THEN satisfaction_survey_id END), 0), 2)
      comment: "Calculated Net Promoter Score (% promoters minus % detractors). The single most-cited brand loyalty metric — used in board decks, investor reporting, and franchise performance scorecards."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest complaint volume, resolution, and severity metrics. Used by operations, quality assurance, and franchise teams to monitor service failure rates, resolution effectiveness, and escalation risk."
  source: "`vibe_restaurants_v1`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint (food quality, service, cleanliness, order accuracy) — used to identify root causes and prioritize operational improvements."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (open, resolved, escalated, closed) — used to monitor resolution pipeline and SLA compliance."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint (low, medium, high, critical) — used to prioritize response and escalation."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided (refund, replacement, apology, voucher) — used to evaluate resolution strategy effectiveness and cost."
    - name: "channel"
      expr: channel
      comment: "Channel through which the complaint was received (phone, email, social, in-store) — used to identify high-complaint channels and optimize response."
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_timestamp)
      comment: "Month the complaint was filed — used for monthly complaint trend analysis and seasonal pattern detection."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the complaint was escalated — used to filter to high-risk complaints requiring executive attention."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of guest complaints filed. Core service quality KPI — rising complaint volume is an early warning signal for operational or food quality issues."
    - name: "escalated_complaint_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN complaint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that were escalated. Measures severity of service failures — high escalation rates indicate systemic issues requiring leadership intervention."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN resolution_status = 'resolved' THEN complaint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that have been resolved. Measures complaint management effectiveness — low resolution rates signal process failures and increase churn risk."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total monetary value of resolutions provided to guests (refunds, vouchers, etc.). Measures the financial cost of service failures — used in quality cost analysis and franchise accountability."
    - name: "avg_resolution_amount"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average monetary resolution amount per complaint. Benchmarks resolution generosity — used to standardize resolution policies and control service recovery costs."
    - name: "avg_csat_at_complaint"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT score recorded at the time of complaint. Measures guest sentiment at the point of failure — used to correlate complaint severity with satisfaction impact."
    - name: "avg_nps_at_complaint"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score recorded at the time of complaint. Measures brand loyalty impact of service failures — used to quantify the advocacy cost of unresolved complaints."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segmentation health metrics tracking segment size, freshness, and strategic coverage. Used by marketing and CRM teams to manage the guest segmentation model and ensure segments are current and actionable."
  source: "`vibe_restaurants_v1`.`guest`.`guest_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, value-based, lifecycle) — used to categorize and manage the segmentation taxonomy."
    - name: "segment_category"
      expr: segment_category
      comment: "Business category of the segment (retention, acquisition, upsell, win-back) — used to align segments to marketing objectives."
    - name: "guest_segment_status"
      expr: guest_segment_status
      comment: "Current status of the segment (active, inactive, archived) — used to filter to actionable segments."
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Whether the segment is dynamically refreshed or static — used to distinguish real-time from point-in-time segments."
    - name: "target_channel"
      expr: target_channel
      comment: "Primary marketing channel targeted by this segment — used to align segment strategy with channel execution."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment membership is refreshed — used to assess data freshness and operational readiness."
  measures:
    - name: "total_active_segments"
      expr: COUNT(DISTINCT CASE WHEN guest_segment_status = 'active' THEN guest_segment_id END)
      comment: "Count of active guest segments. Measures the breadth of the segmentation model — used to ensure adequate coverage of the guest base for targeted marketing."
    - name: "avg_segment_member_count"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average number of members per segment. Measures segment granularity — very large or very small segments may indicate over- or under-segmentation."
    - name: "avg_segment_avg_ltv"
      expr: AVG(CAST(avg_lifetime_value AS DOUBLE))
      comment: "Average of the per-segment average lifetime value. Measures the value concentration across segments — used to prioritize high-value segment investment."
    - name: "avg_segment_churn_risk"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across all segments. Measures the overall churn exposure of the guest base — used to trigger proactive retention campaigns."
    - name: "avg_visit_frequency_across_segments"
      expr: AVG(CAST(avg_visit_frequency AS DOUBLE))
      comment: "Average visit frequency across all guest segments. Benchmarks engagement depth — used to identify low-frequency segments for re-engagement programs."
    - name: "avg_check_amount_across_segments"
      expr: AVG(CAST(avg_check_amount AS DOUBLE))
      comment: "Average check amount across all guest segments. Measures spending behavior at the segment level — used to identify high-value segments for premium offer targeting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment membership metrics tracking assignment volume, confidence, and membership health. Used by CRM and marketing teams to monitor segment population dynamics and assignment quality."
  source: "`vibe_restaurants_v1`.`guest`.`guest_segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the segment membership (active, exited, pending) — used to filter to current active memberships."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the guest to the segment (rule-based, ML model, manual) — used to evaluate assignment quality and model performance."
    - name: "membership_source"
      expr: membership_source
      comment: "Source system or process that created the membership — used for data lineage and quality auditing."
    - name: "is_active"
      expr: is_active
      comment: "Whether the membership is currently active — primary filter for active segment population analysis."
    - name: "joined_month"
      expr: DATE_TRUNC('MONTH', joined_date)
      comment: "Month the guest joined the segment — used to track segment growth trends over time."
    - name: "exited_month"
      expr: DATE_TRUNC('MONTH', exited_date)
      comment: "Month the guest exited the segment — used to track segment churn and membership stability."
  measures:
    - name: "total_active_memberships"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN guest_segment_membership_id END)
      comment: "Count of currently active segment memberships. Measures the total population across all segments — used to assess segmentation model coverage."
    - name: "unique_segmented_guests"
      expr: COUNT(DISTINCT primary_guest_profile_id)
      comment: "Count of distinct guests assigned to at least one segment. Measures the reach of the segmentation model — guests not in any segment are invisible to targeted marketing."
    - name: "avg_assignment_score"
      expr: AVG(CAST(assignment_score AS DOUBLE))
      comment: "Average assignment score for segment memberships. Measures the confidence of segment assignments — low scores indicate weak signal and potential misclassification."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score for segment memberships. Complements assignment score — used to evaluate ML model quality and segment definition precision."
    - name: "avg_membership_score"
      expr: AVG(CAST(membership_score AS DOUBLE))
      comment: "Average membership score across all segment assignments. Measures overall segment fit quality — used to identify segments with weak member alignment."
    - name: "membership_exit_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_active = FALSE AND exited_date IS NOT NULL THEN guest_segment_membership_id END) / NULLIF(COUNT(DISTINCT guest_segment_membership_id), 0), 2)
      comment: "Percentage of segment memberships that have exited. Measures segment stability — high exit rates may indicate overly narrow segment definitions or rapid guest behavior change."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent and privacy compliance metrics tracking opt-in rates, consent coverage, and regulatory compliance posture. Used by legal, compliance, and marketing teams to manage data usage rights and regulatory risk."
  source: "`vibe_restaurants_v1`.`guest`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (active, revoked, expired) — used to filter to valid active consents."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, analytics, third-party sharing, profiling) — used to analyze consent coverage by purpose."
    - name: "consent_source_channel"
      expr: consent_source_channel
      comment: "Channel through which consent was obtained (app, web, in-store, email) — used to evaluate consent collection channel effectiveness."
    - name: "consent_method"
      expr: consent_method
      comment: "Method of consent collection (opt-in, opt-out, implied) — used for regulatory compliance analysis."
    - name: "data_processing_scope"
      expr: data_processing_scope
      comment: "Scope of data processing authorized by the consent — used to ensure data usage stays within consented boundaries."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_timestamp)
      comment: "Month consent was recorded — used to track consent collection trends and identify regulatory deadline risks."
  measures:
    - name: "total_active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Count of currently active consent records. Measures the size of the legally addressable guest audience — critical for GDPR/CCPA compliance and marketing reach planning."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with marketing consent granted. Measures the marketable audience proportion — directly impacts campaign reach and revenue potential."
    - name: "email_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with email marketing consent. Measures email channel addressability — used to size email campaign audiences and forecast email revenue."
    - name: "sms_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sms_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with SMS marketing consent. Measures SMS channel addressability — used to size SMS campaign audiences and evaluate mobile engagement strategy."
    - name: "third_party_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records permitting third-party data sharing. Measures data monetization and partnership potential — critical for data sharing agreements and co-marketing programs."
    - name: "consent_revocation_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'revoked' THEN consent_record_id END)
      comment: "Count of revoked consent records. Tracks opt-out volume — rising revocations signal brand trust issues or regulatory pressure requiring immediate leadership attention."
    - name: "data_sharing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_sharing_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of guests consenting to data sharing. Measures the breadth of permissioned data usage — used in data governance and partnership strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_identity_resolution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest identity resolution quality metrics tracking match confidence, golden record rates, and duplicate detection. Used by data engineering and CRM teams to monitor the health of the customer data platform and ensure a single view of the guest."
  source: "`vibe_restaurants_v1`.`guest`.`identity_resolution`"
  dimensions:
    - name: "match_method"
      expr: match_method
      comment: "Method used to resolve guest identity (deterministic, probabilistic, manual) — used to evaluate resolution strategy effectiveness."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Guest lifecycle status at time of resolution (new, active, lapsed, churned) — used to analyze identity resolution coverage by lifecycle stage."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest record (loyalty member, anonymous, corporate) — used to segment resolution quality by guest type."
    - name: "golden_record_flag"
      expr: golden_record_flag
      comment: "Whether this record is the designated golden (master) record — used to filter to authoritative guest records."
    - name: "duplicate_flag"
      expr: duplicate_flag
      comment: "Whether this record was identified as a duplicate — used to measure data quality and deduplication effectiveness."
    - name: "merge_event_month"
      expr: DATE_TRUNC('MONTH', merge_event_timestamp)
      comment: "Month a merge event occurred — used to track identity resolution activity over time."
  measures:
    - name: "total_resolved_identities"
      expr: COUNT(DISTINCT identity_resolution_id)
      comment: "Total count of identity resolution records. Measures the scale of the identity graph — used to track CDP coverage and data completeness."
    - name: "golden_record_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN golden_record_flag = TRUE THEN identity_resolution_id END) / NULLIF(COUNT(DISTINCT identity_resolution_id), 0), 2)
      comment: "Percentage of identity records designated as golden records. Measures the completeness of the single-customer-view — low rates indicate unresolved duplicates degrading personalization quality."
    - name: "duplicate_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN duplicate_flag = TRUE THEN identity_resolution_id END) / NULLIF(COUNT(DISTINCT identity_resolution_id), 0), 2)
      comment: "Percentage of identity records flagged as duplicates. Measures data quality risk — high duplicate rates inflate guest counts and degrade personalization and compliance."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of identity match decisions. Measures the reliability of the identity resolution model — low scores indicate weak signal and potential mismatches."
    - name: "avg_data_source_confidence"
      expr: AVG(CAST(data_source_confidence_score AS DOUBLE))
      comment: "Average confidence score of the data source feeding identity resolution. Measures input data quality — used to identify low-quality source systems degrading resolution accuracy."
    - name: "avg_total_lifetime_spend"
      expr: AVG(CAST(total_lifetime_spend AS DOUBLE))
      comment: "Average total lifetime spend per resolved identity. Measures the value of the resolved guest base — used to validate that high-value guests are being correctly unified."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_allergen_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest allergen profile metrics tracking allergen prevalence, severity distribution, and verification rates. Used by food safety, operations, and menu teams to manage allergen risk and ensure safe guest experiences."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interaction event metrics capturing guest engagement channels"
  source: "`vibe_restaurants_v1`.`guest`.`interaction`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Interaction channel (e.g., email, SMS, app)"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction"
    - name: "is_test"
      expr: is_test
      comment: "Flag indicating if the interaction is a test"
    - name: "outcome"
      expr: outcome
      comment: "Resulting outcome of the interaction"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the interaction event"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of interaction events"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_profile_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance metrics derived from guest profiles"
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the guest"
    - name: "guest_type"
      expr: guest_type
      comment: "Guest type"
  measures:
    - name: "total_spent_sum"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of total spend across all guests"
    - name: "average_spent"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average total spend per guest"
    - name: "average_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value per guest"
$$;