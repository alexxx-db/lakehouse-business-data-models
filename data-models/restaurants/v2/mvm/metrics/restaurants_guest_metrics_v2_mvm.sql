-- Metric views for domain: guest | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest visit performance metrics tracking visit volume, spend, satisfaction, loyalty engagement, and repeat behavior — the primary operational KPI layer for restaurant guest experience management."
  source: "`vibe_restaurants_v1`.`guest`.`visit`"
  dimensions:
    - name: "visit_date"
      expr: visit_date
      comment: "Calendar date of the guest visit, used for daily/weekly/monthly trend analysis."
    - name: "visit_channel"
      expr: channel
      comment: "Service channel through which the visit occurred (e.g., dine-in, drive-thru, delivery, takeout)."
    - name: "visit_type"
      expr: visit_type
      comment: "Classification of the visit type (e.g., walk-in, reservation, loyalty redemption)."
    - name: "daypart"
      expr: daypart
      comment: "Meal period of the visit (e.g., breakfast, lunch, dinner, late-night) for daypart performance analysis."
    - name: "is_loyalty_visit"
      expr: is_loyalty_visit
      comment: "Flag indicating whether the visit was associated with a loyalty program member."
    - name: "is_repeat_visit"
      expr: is_repeat_visit
      comment: "Flag indicating whether the guest has visited before, used to distinguish new vs. returning guests."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month bucket of the visit date for monthly cohort and trend reporting."
    - name: "visit_week"
      expr: DATE_TRUNC('WEEK', visit_date)
      comment: "Week bucket of the visit date for weekly operational performance tracking."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of guest visits. Baseline volume KPI used to track traffic trends and capacity utilization."
    - name: "total_check_amount"
      expr: SUM(CAST(check_amount AS DOUBLE))
      comment: "Sum of all guest check amounts. Primary revenue proxy at the visit level for top-line performance tracking."
    - name: "avg_check_amount"
      expr: AVG(CAST(check_amount AS DOUBLE))
      comment: "Average check amount per visit. Key pricing and upsell effectiveness KPI used in QBRs and menu strategy."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total guest spend across all visits. Captures full revenue contribution including all spend components."
    - name: "avg_spend_per_visit"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend per visit. Tracks per-visit monetization efficiency and informs promotional strategy."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average guest satisfaction score per visit. Core CX KPI tied directly to retention and NPS outcomes."
    - name: "avg_visit_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average visit duration in minutes. Operational efficiency metric used to manage table turns and throughput."
    - name: "loyalty_visit_count"
      expr: COUNT(CASE WHEN is_loyalty_visit = TRUE THEN 1 END)
      comment: "Number of visits attributed to loyalty program members. Measures loyalty program engagement and ROI."
    - name: "repeat_visit_count"
      expr: COUNT(CASE WHEN is_repeat_visit = TRUE THEN 1 END)
      comment: "Number of repeat visits. Retention signal used to evaluate guest loyalty and frequency programs."
    - name: "unique_guests"
      expr: COUNT(DISTINCT primary_guest_profile_id)
      comment: "Count of distinct guests who visited. Used to measure reach, active guest base size, and retention cohorts."
    - name: "total_check_total"
      expr: SUM(CAST(check_total AS DOUBLE))
      comment: "Sum of check totals across all visits. Provides an alternative total revenue view inclusive of all charges."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest profile health and value metrics covering active guest base, lifetime value, consent rates, and marketing opt-in — essential for CRM strategy, segmentation, and personalization investment decisions."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the guest profile (e.g., active, inactive, merged, deleted)."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of the guest (e.g., regular, VIP, corporate, loyalty member)."
    - name: "country_code"
      expr: country_code
      comment: "Country of the guest for geographic segmentation and regional performance analysis."
    - name: "gender"
      expr: gender
      comment: "Guest gender for demographic segmentation and targeted marketing analysis."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Guest preferred language for localization and communication strategy decisions."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the guest has opted into marketing communications — critical for reachable audience sizing."
    - name: "primary_contact_method"
      expr: primary_contact_method
      comment: "Preferred contact channel (e.g., email, SMS, push) for channel mix optimization."
    - name: "data_source"
      expr: data_source
      comment: "Origin system of the guest profile record for data quality and acquisition channel analysis."
    - name: "profile_created_month"
      expr: DATE_TRUNC('MONTH', record_audit_created)
      comment: "Month the profile was created, used for new guest acquisition cohort analysis."
  measures:
    - name: "total_guest_profiles"
      expr: COUNT(1)
      comment: "Total number of guest profiles. Baseline measure of the known guest universe size."
    - name: "active_guest_profiles"
      expr: COUNT(CASE WHEN profile_status = 'active' THEN 1 END)
      comment: "Number of active guest profiles. Measures the reachable, engaged guest base for CRM and marketing investment."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of total lifetime spend across all guest profiles. Top-line guest value KPI for portfolio valuation."
    - name: "avg_lifetime_spend"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average lifetime spend per guest profile. Core CLV metric used in retention investment and tier strategy decisions."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value across guest profiles. Indicates typical per-visit spend level for pricing and upsell strategy."
    - name: "avg_lifetime_visits"
      expr: AVG(CAST(total_lifetime_visits AS DOUBLE))
      comment: "Average number of lifetime visits per guest. Frequency KPI used to evaluate loyalty program effectiveness."
    - name: "marketing_opt_in_count"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN 1 END)
      comment: "Number of guests opted into marketing. Defines the addressable marketing audience for campaign planning."
    - name: "consent_email_count"
      expr: COUNT(CASE WHEN consent_email = TRUE THEN 1 END)
      comment: "Number of guests with email marketing consent. Drives email channel audience sizing and deliverability planning."
    - name: "consent_sms_count"
      expr: COUNT(CASE WHEN consent_sms = TRUE THEN 1 END)
      comment: "Number of guests with SMS consent. Drives SMS channel audience sizing for promotional and transactional messaging."
    - name: "total_lifetime_visits_sum"
      expr: SUM(CAST(total_lifetime_visits AS DOUBLE))
      comment: "Total lifetime visits across all guest profiles. Aggregate traffic volume proxy for the full guest base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest complaint and resolution quality metrics tracking complaint volume, escalation rates, resolution effectiveness, and satisfaction impact — critical for operational quality management and brand risk mitigation."
  source: "`vibe_restaurants_v1`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: category
      comment: "Category of the complaint (e.g., food quality, service, cleanliness) for root cause analysis."
    - name: "complaint_channel"
      expr: channel
      comment: "Channel through which the complaint was submitted (e.g., in-store, app, phone, social media)."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., open, resolved, escalated) for workload and SLA tracking."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome status for measuring complaint closure rates and resolution quality."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied (e.g., refund, replacement, apology) for resolution strategy analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint for prioritization and escalation threshold management."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the complaint was escalated to a higher tier for escalation rate monitoring."
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_timestamp)
      comment: "Month the complaint was filed for trend and seasonality analysis."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of guest complaints. Baseline quality KPI used to track complaint volume trends and brand health."
    - name: "escalated_complaint_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated complaints. High-severity signal used by operations leadership to assess systemic quality failures."
    - name: "resolved_complaint_count"
      expr: COUNT(CASE WHEN resolution_status = 'resolved' THEN 1 END)
      comment: "Number of complaints with a resolved status. Measures complaint closure effectiveness and team responsiveness."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT score from complaint records. Measures post-complaint satisfaction and recovery effectiveness."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score from complaint records. Tracks loyalty impact of complaint experiences on brand advocacy."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total monetary value of complaint resolutions (refunds, credits). Measures financial cost of service failures."
    - name: "avg_resolution_amount"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average resolution amount per complaint. Informs cost-per-complaint benchmarking and recovery policy calibration."
    - name: "unique_complaining_guests"
      expr: COUNT(DISTINCT complaint_guest_profile_id)
      comment: "Number of distinct guests who filed complaints. Measures breadth of dissatisfaction across the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction survey response metrics covering CSAT, NPS, response rates, and survey completion — the primary voice-of-customer KPI layer for experience management and service improvement decisions."
  source: "`vibe_restaurants_v1`.`guest`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of satisfaction survey (e.g., post-visit, delivery, event) for survey program performance segmentation."
    - name: "satisfaction_survey_status"
      expr: satisfaction_survey_status
      comment: "Current status of the survey record for pipeline and completion tracking."
    - name: "completion_status"
      expr: completion_status
      comment: "Whether the survey was fully completed by the guest — used to calculate response completion rates."
    - name: "daypart"
      expr: daypart
      comment: "Meal period associated with the surveyed visit for daypart-level satisfaction analysis."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the survey was delivered (e.g., email, SMS, in-app) for channel effectiveness analysis."
    - name: "survey_language"
      expr: language
      comment: "Language in which the survey was completed for localization and demographic analysis."
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the visit associated with the survey for time-series satisfaction trend analysis."
    - name: "survey_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month bucket of the associated visit date for monthly satisfaction trend reporting."
  measures:
    - name: "total_surveys_sent"
      expr: COUNT(1)
      comment: "Total number of satisfaction surveys issued. Baseline measure for survey program reach and volume."
    - name: "completed_surveys"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Number of fully completed surveys. Measures survey response quality and program engagement."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT score across all survey responses. Primary guest satisfaction KPI used in executive dashboards and QBRs."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score across all survey responses. Brand loyalty and advocacy KPI used to benchmark against industry standards."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN CAST(nps_score AS DOUBLE) >= 9 THEN 1 END)
      comment: "Number of NPS promoters (score 9-10). Used to calculate net promoter score and identify brand advocates."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN CAST(nps_score AS DOUBLE) <= 6 THEN 1 END)
      comment: "Number of NPS detractors (score 0-6). Used to calculate net promoter score and identify at-risk guests."
    - name: "surveys_with_response"
      expr: COUNT(CASE WHEN response_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of surveys that received any guest response. Measures survey program response rate numerator."
    - name: "unique_surveyed_guests"
      expr: COUNT(DISTINCT primary_satisfaction_guest_profile_id)
      comment: "Number of distinct guests surveyed. Measures breadth of voice-of-customer data collection across the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment portfolio metrics tracking segment health, churn risk, estimated value, and visit frequency — used by marketing and CRM leadership to prioritize segment investment and personalization strategy."
  source: "`vibe_restaurants_v1`.`guest`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of guest segment (e.g., behavioral, demographic, value-based) for segment portfolio analysis."
    - name: "guest_segment_status"
      expr: guest_segment_status
      comment: "Current operational status of the segment (e.g., active, archived, draft)."
    - name: "segment_category"
      expr: category
      comment: "Business category of the segment for grouping related segments in reporting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the segment is currently active and in use for targeting."
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Whether the segment membership is dynamically recalculated vs. static — impacts refresh cost and accuracy."
    - name: "target_channel"
      expr: target_channel
      comment: "Primary marketing channel targeted by this segment for channel mix planning."
    - name: "segmentation_method"
      expr: segmentation_method
      comment: "Method used to define segment membership (e.g., rules-based, ML model, manual) for model governance."
    - name: "segment_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the segment was created for segment lifecycle and portfolio age analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of guest segments defined. Measures the breadth of the segmentation portfolio."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active segments. Measures the live targeting portfolio size for marketing operations."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segments. Identifies portfolio-level retention risk for proactive intervention."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(avg_lifetime_value AS DOUBLE))
      comment: "Average estimated lifetime value across segments. Used to prioritize high-value segment investment and resource allocation."
    - name: "avg_check_amount"
      expr: AVG(CAST(avg_check_amount AS DOUBLE))
      comment: "Average check amount across segments. Indicates typical spend level per segment for pricing and offer strategy."
    - name: "avg_visit_frequency"
      expr: AVG(CAST(avg_visit_frequency AS DOUBLE))
      comment: "Average visit frequency across segments. Frequency KPI used to identify high-engagement vs. lapsing segments."
    - name: "total_lifetime_value_sum"
      expr: SUM(CAST(avg_lifetime_value AS DOUBLE))
      comment: "Sum of average lifetime values across all segments. Proxy for total addressable value of the segmented guest portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment membership metrics tracking active membership counts, assignment confidence, membership scores, and churn signals — used to evaluate segment quality, model accuracy, and CRM targeting effectiveness."
  source: "`vibe_restaurants_v1`.`guest`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the segment membership (e.g., active, exited, pending) for membership lifecycle analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the guest to the segment (e.g., rule-based, ML, manual) for model governance."
    - name: "membership_source"
      expr: membership_source
      comment: "Source system or process that created the membership record for data lineage tracking."
    - name: "is_active"
      expr: is_active
      comment: "Whether the membership is currently active — used to filter to the live targeting audience."
    - name: "joined_date"
      expr: joined_date
      comment: "Date the guest joined the segment for cohort entry analysis."
    - name: "exited_date"
      expr: exited_date
      comment: "Date the guest exited the segment for churn and tenure analysis."
    - name: "membership_month"
      expr: DATE_TRUNC('MONTH', joined_date)
      comment: "Month the guest joined the segment for monthly cohort and growth trend analysis."
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total segment membership records. Baseline measure of total segment assignments across the guest base."
    - name: "active_memberships"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active segment memberships. Defines the live targetable audience size per segment."
    - name: "unique_guests_in_segments"
      expr: COUNT(DISTINCT primary_guest_profile_id)
      comment: "Number of distinct guests assigned to at least one segment. Measures segmentation coverage of the guest base."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score for segment assignments. Measures segmentation model quality and reliability."
    - name: "avg_membership_score"
      expr: AVG(CAST(membership_score AS DOUBLE))
      comment: "Average membership score across all assignments. Indicates the strength of guest-segment fit for targeting precision."
    - name: "avg_assignment_score"
      expr: AVG(CAST(assignment_score AS DOUBLE))
      comment: "Average assignment score at time of segment entry. Used to evaluate assignment model calibration over time."
    - name: "exited_membership_count"
      expr: COUNT(CASE WHEN exited_date IS NOT NULL THEN 1 END)
      comment: "Number of memberships where the guest has exited the segment. Measures segment churn and audience stability."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_digital_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital account health and engagement metrics covering active accounts, account tier distribution, login activity, and security posture — used by digital product and CRM teams to manage the digital guest base."
  source: "`vibe_restaurants_v1`.`guest`.`digital_account`"
  dimensions:
    - name: "digital_account_status"
      expr: digital_account_status
      comment: "Current status of the digital account (e.g., active, suspended, locked, closed)."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier level of the digital account (e.g., standard, premium, VIP) for value-based segmentation."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the digital account (e.g., iOS, Android, web) for platform mix analysis."
    - name: "consent_marketing"
      expr: consent_marketing
      comment: "Whether the account holder has consented to marketing communications — defines digital marketing audience."
    - name: "privacy_opt_out"
      expr: privacy_opt_out
      comment: "Whether the guest has opted out of data processing — critical for compliance and reachable audience sizing."
    - name: "account_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the digital account was created for new account acquisition trend analysis."
    - name: "effective_from"
      expr: effective_from
      comment: "Date from which the digital account became effective for account lifecycle analysis."
  measures:
    - name: "total_digital_accounts"
      expr: COUNT(1)
      comment: "Total number of digital accounts. Baseline measure of the digital guest base size."
    - name: "active_digital_accounts"
      expr: COUNT(CASE WHEN digital_account_status = 'active' THEN 1 END)
      comment: "Number of active digital accounts. Measures the engaged digital audience for app and digital channel investment decisions."
    - name: "marketing_consent_accounts"
      expr: COUNT(CASE WHEN consent_marketing = TRUE THEN 1 END)
      comment: "Number of digital accounts with marketing consent. Defines the addressable digital marketing audience."
    - name: "privacy_opt_out_accounts"
      expr: COUNT(CASE WHEN privacy_opt_out = TRUE THEN 1 END)
      comment: "Number of accounts with privacy opt-out. Compliance KPI used to monitor data processing restrictions."
    - name: "accounts_with_recent_login"
      expr: COUNT(CASE WHEN last_login_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of accounts with a recorded login. Proxy for digital engagement activity across the account base."
    - name: "unique_guests_with_digital_account"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guest profiles with a digital account. Measures digital adoption across the known guest base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent and data privacy compliance metrics tracking consent rates, active consent coverage, and opt-out trends — essential for regulatory compliance (GDPR, CCPA) and addressable marketing audience management."
  source: "`vibe_restaurants_v1`.`guest`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g., marketing, data processing, third-party sharing) for compliance categorization."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., active, revoked, expired) for compliance monitoring."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (e.g., web form, in-store, app) for consent quality assessment."
    - name: "consent_source_channel"
      expr: consent_source_channel
      comment: "Channel through which consent was collected for channel-level compliance reporting."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Purpose for which consent was granted (e.g., email marketing, analytics) for purpose-based compliance tracking."
    - name: "email_consent"
      expr: email_consent
      comment: "Whether email marketing consent was granted — defines email-reachable audience."
    - name: "sms_consent"
      expr: sms_consent
      comment: "Whether SMS consent was granted — defines SMS-reachable audience."
    - name: "marketing_consent"
      expr: marketing_consent
      comment: "Whether general marketing consent was granted — defines the overall marketing-reachable audience."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_timestamp)
      comment: "Month consent was recorded for consent acquisition trend analysis."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records. Baseline compliance KPI for consent management program coverage."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'active' THEN 1 END)
      comment: "Number of currently active consent records. Defines the compliant, reachable audience for marketing and data processing."
    - name: "revoked_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'revoked' THEN 1 END)
      comment: "Number of revoked consent records. Compliance risk KPI used to monitor opt-out trends and regulatory exposure."
    - name: "email_consent_count"
      expr: COUNT(CASE WHEN email_consent = TRUE THEN 1 END)
      comment: "Number of records with active email consent. Defines the email-addressable audience for campaign planning."
    - name: "sms_consent_count"
      expr: COUNT(CASE WHEN sms_consent = TRUE THEN 1 END)
      comment: "Number of records with active SMS consent. Defines the SMS-addressable audience for mobile marketing."
    - name: "marketing_consent_count"
      expr: COUNT(CASE WHEN marketing_consent = TRUE THEN 1 END)
      comment: "Number of records with general marketing consent. Measures total addressable marketing audience under consent compliance."
    - name: "third_party_consent_count"
      expr: COUNT(CASE WHEN third_party_consent = TRUE THEN 1 END)
      comment: "Number of records with third-party data sharing consent. Compliance KPI for data partnership and monetization programs."
    - name: "unique_consenting_guests"
      expr: COUNT(DISTINCT primary_consent_guest_profile_id)
      comment: "Number of distinct guests with at least one consent record. Measures consent program coverage across the guest base."
$$;