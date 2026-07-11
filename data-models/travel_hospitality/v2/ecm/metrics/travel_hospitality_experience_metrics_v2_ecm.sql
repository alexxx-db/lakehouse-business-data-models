-- Metric views for domain: experience | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction and feedback metrics including NPS, CSAT, GSS scores, and sentiment analysis across properties, channels, and touchpoints"
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_feedback`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where feedback was collected"
    - name: "feedback_submission_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date feedback was submitted by guest"
    - name: "feedback_submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month feedback was submitted"
    - name: "stay_date_from"
      expr: stay_date_from
      comment: "Guest stay start date"
    - name: "guest_segment"
      expr: guest_segment
      comment: "Market segment of the guest"
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS classification: Promoter, Passive, or Detractor"
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Overall sentiment classification of feedback"
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Whether feedback contains a complaint"
    - name: "service_recovery_required_flag"
      expr: service_recovery_required_flag
      comment: "Whether service recovery action is required"
    - name: "survey_completion_status"
      expr: survey_completion_status
      comment: "Status of survey completion"
    - name: "language_code"
      expr: language_code
      comment: "Language of feedback submission"
    - name: "rate_code"
      expr: rate_code
      comment: "Rate plan code associated with stay"
  measures:
    - name: "total_feedback_count"
      expr: COUNT(1)
      comment: "Total number of guest feedback submissions"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall guest rating score"
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average customer satisfaction (CSAT) score"
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average guest satisfaction score (GSS)"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment analysis score"
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service quality rating"
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness rating"
    - name: "avg_room_rating"
      expr: AVG(CAST(room_rating AS DOUBLE))
      comment: "Average room quality rating"
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities rating"
    - name: "avg_location_rating"
      expr: AVG(CAST(location_rating AS DOUBLE))
      comment: "Average location rating"
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average value for money rating"
    - name: "avg_fnb_rating"
      expr: AVG(CAST(fnb_rating AS DOUBLE))
      comment: "Average food and beverage rating"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average time to respond to feedback in hours"
    - name: "complaint_count"
      expr: SUM(CASE WHEN complaint_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of feedback submissions flagged as complaints"
    - name: "complaint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN complaint_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback submissions that are complaints"
    - name: "service_recovery_required_count"
      expr: SUM(CASE WHEN service_recovery_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of feedback submissions requiring service recovery"
    - name: "service_recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN service_recovery_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback requiring service recovery action"
    - name: "would_recommend_count"
      expr: SUM(CASE WHEN would_recommend_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of guests who would recommend the property"
    - name: "would_return_count"
      expr: SUM(CASE WHEN would_return_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of guests who would return to the property"
    - name: "recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN would_recommend_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who would recommend the property"
    - name: "return_intent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN would_return_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who would return to the property"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles providing feedback"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties receiving feedback"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service case resolution metrics including case volume, resolution time, SLA compliance, compensation, and guest satisfaction outcomes"
  source: "`vibe_travel_hospitality_v1`.`experience`.`service_case`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where service case originated"
    - name: "case_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date service case was created"
    - name: "case_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month service case was created"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service case"
    - name: "case_category"
      expr: case_category
      comment: "Primary category of the service case"
    - name: "case_subcategory"
      expr: case_subcategory
      comment: "Subcategory of the service case"
    - name: "case_origin"
      expr: case_origin
      comment: "Channel through which case was reported"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to case"
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the case"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the issue"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether case was resolved within SLA"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether issue was preventable"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up action is required"
    - name: "grr_outcome_flag"
      expr: grr_outcome_flag
      comment: "Whether case resulted in guaranteed room ready (GRR) outcome"
    - name: "social_media_mention_flag"
      expr: social_media_mention_flag
      comment: "Whether case was mentioned on social media"
    - name: "guest_lifetime_value_segment"
      expr: guest_lifetime_value_segment
      comment: "Lifetime value segment of the guest"
    - name: "guest_satisfaction_post_resolution"
      expr: guest_satisfaction_post_resolution
      comment: "Guest satisfaction level after resolution"
  measures:
    - name: "total_case_count"
      expr: COUNT(1)
      comment: "Total number of service cases"
    - name: "avg_resolution_hours"
      expr: AVG(CAST(actual_resolution_hours AS DOUBLE))
      comment: "Average time to resolve cases in hours"
    - name: "total_compensation_value"
      expr: SUM(CAST(compensation_total_value AS DOUBLE))
      comment: "Total monetary compensation provided across all cases"
    - name: "avg_compensation_value"
      expr: AVG(CAST(compensation_total_value AS DOUBLE))
      comment: "Average compensation value per case"
    - name: "sla_compliant_count"
      expr: SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases resolved within SLA"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases resolved within SLA target"
    - name: "preventable_case_count"
      expr: SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases that were preventable"
    - name: "preventable_case_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were preventable"
    - name: "escalated_case_count"
      expr: SUM(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'None' THEN 1 ELSE 0 END)
      comment: "Number of cases that were escalated"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'None' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases requiring escalation"
    - name: "social_media_case_count"
      expr: SUM(CASE WHEN social_media_mention_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases mentioned on social media"
    - name: "grr_outcome_count"
      expr: SUM(CASE WHEN grr_outcome_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases with guaranteed room ready outcome"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases requiring follow-up"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with service cases"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with service cases"
    - name: "cases_with_compensation_count"
      expr: SUM(CASE WHEN compensation_total_value > 0 THEN 1 ELSE 0 END)
      comment: "Number of cases where compensation was provided"
    - name: "compensation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compensation_total_value > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where compensation was provided"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_gss_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Satisfaction Score (GSS) performance metrics including NPS, top-box/bottom-box percentages, variance analysis, and SALT program attainment"
  source: "`vibe_travel_hospitality_v1`.`experience`.`gss_score`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which GSS score is measured"
    - name: "measurement_start_date"
      expr: measurement_start_date
      comment: "Start date of measurement period"
    - name: "measurement_end_date"
      expr: measurement_end_date
      comment: "End date of measurement period"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (monthly, quarterly, annual)"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code for the property"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental GSS tracking"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for segmented GSS analysis"
    - name: "score_band"
      expr: score_band
      comment: "Performance band classification of GSS score"
    - name: "salt_target_attained_flag"
      expr: salt_target_attained_flag
      comment: "Whether SALT (Service and Loyalty Tracking) target was attained"
    - name: "published_flag"
      expr: published_flag
      comment: "Whether score has been published"
    - name: "brand_qa_review_flag"
      expr: brand_qa_review_flag
      comment: "Whether score requires brand QA review"
    - name: "gm_review_required_flag"
      expr: gm_review_required_flag
      comment: "Whether score requires general manager review"
    - name: "data_source"
      expr: data_source
      comment: "Source system of GSS data"
  measures:
    - name: "total_gss_records"
      expr: COUNT(1)
      comment: "Total number of GSS score records"
    - name: "avg_gss_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average GSS score value"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "avg_top_box_percent"
      expr: AVG(CAST(top_box_percent AS DOUBLE))
      comment: "Average percentage of top-box (highest rating) responses"
    - name: "avg_bottom_box_percent"
      expr: AVG(CAST(bottom_box_percent AS DOUBLE))
      comment: "Average percentage of bottom-box (lowest rating) responses"
    - name: "avg_promoter_percent"
      expr: AVG(CAST(promoter_percent AS DOUBLE))
      comment: "Average percentage of promoters (NPS 9-10)"
    - name: "avg_passive_percent"
      expr: AVG(CAST(passive_percent AS DOUBLE))
      comment: "Average percentage of passives (NPS 7-8)"
    - name: "avg_detractor_percent"
      expr: AVG(CAST(detractor_percent AS DOUBLE))
      comment: "Average percentage of detractors (NPS 0-6)"
    - name: "avg_grr_percent"
      expr: AVG(CAST(grr_percent AS DOUBLE))
      comment: "Average guaranteed room ready (GRR) percentage"
    - name: "avg_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average survey response rate percentage"
    - name: "avg_prior_period_variance"
      expr: AVG(CAST(prior_period_variance AS DOUBLE))
      comment: "Average variance from prior period GSS score"
    - name: "avg_yoy_variance"
      expr: AVG(CAST(yoy_variance AS DOUBLE))
      comment: "Average year-over-year variance in GSS score"
    - name: "salt_target_attained_count"
      expr: SUM(CASE WHEN salt_target_attained_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of periods where SALT target was attained"
    - name: "salt_attainment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN salt_target_attained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of periods where SALT target was attained"
    - name: "total_surveys_sent"
      expr: SUM(CAST(surveys_sent_count AS BIGINT))
      comment: "Total number of surveys sent across all periods"
    - name: "total_service_recovery_cases"
      expr: SUM(CAST(service_recovery_case_count AS BIGINT))
      comment: "Total number of service recovery cases triggered by GSS"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with GSS scores"
    - name: "published_score_count"
      expr: SUM(CASE WHEN published_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of published GSS scores"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_online_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online review reputation metrics including ratings, sentiment, management response rates, and competitive benchmarking"
  source: "`vibe_travel_hospitality_v1`.`experience`.`online_review`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property being reviewed"
    - name: "review_date"
      expr: review_date
      comment: "Date review was posted"
    - name: "review_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month review was posted"
    - name: "ingestion_date"
      expr: DATE_TRUNC('day', ingestion_timestamp)
      comment: "Date review was ingested into system"
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of the review"
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification (positive, neutral, negative)"
    - name: "traveler_type"
      expr: traveler_type
      comment: "Type of traveler (business, leisure, family, etc.)"
    - name: "verified_stay_flag"
      expr: verified_stay_flag
      comment: "Whether stay was verified by platform"
    - name: "competitive_set_flag"
      expr: competitive_set_flag
      comment: "Whether review is from competitive set property"
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response"
    - name: "review_visibility_status"
      expr: review_visibility_status
      comment: "Visibility status of the review"
    - name: "reviewer_location"
      expr: reviewer_location
      comment: "Geographic location of reviewer"
  measures:
    - name: "total_review_count"
      expr: COUNT(1)
      comment: "Total number of online reviews"
    - name: "avg_normalized_rating"
      expr: AVG(CAST(normalized_rating AS DOUBLE))
      comment: "Average normalized rating (standardized scale)"
    - name: "avg_platform_native_rating"
      expr: AVG(CAST(platform_native_rating AS DOUBLE))
      comment: "Average rating on platform native scale"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment analysis score"
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service rating"
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness rating"
    - name: "avg_location_rating"
      expr: AVG(CAST(location_rating AS DOUBLE))
      comment: "Average location rating"
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities rating"
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average value for money rating"
    - name: "verified_stay_count"
      expr: SUM(CASE WHEN verified_stay_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews with verified stays"
    - name: "verified_stay_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verified_stay_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with verified stays"
    - name: "management_responded_count"
      expr: SUM(CASE WHEN management_response_status = 'Responded' THEN 1 ELSE 0 END)
      comment: "Number of reviews with management response"
    - name: "management_response_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN management_response_status = 'Responded' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews receiving management response"
    - name: "competitive_set_review_count"
      expr: SUM(CASE WHEN competitive_set_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews from competitive set properties"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with reviews"
    - name: "unique_reviewers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles leaving reviews"
    - name: "total_helpfulness_votes"
      expr: SUM(CAST(review_helpfulness_count AS BIGINT))
      comment: "Total helpfulness votes across all reviews"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_service_recovery_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service recovery action effectiveness metrics including recovery cost, fulfillment rates, guest acceptance, and post-recovery satisfaction"
  source: "`vibe_travel_hospitality_v1`.`experience`.`service_recovery_action`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where recovery action was taken"
    - name: "action_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date recovery action was created"
    - name: "action_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month recovery action was created"
    - name: "recovery_action_category"
      expr: recovery_action_category
      comment: "Category of recovery action"
    - name: "recovery_action_type"
      expr: recovery_action_type
      comment: "Specific type of recovery action"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for recovery action"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of recovery action fulfillment"
    - name: "guest_acceptance_status"
      expr: guest_acceptance_status
      comment: "Guest acceptance status of recovery action"
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization level required for action"
    - name: "is_proactive"
      expr: is_proactive
      comment: "Whether recovery action was proactive"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up is required"
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used to communicate recovery action"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center charged for recovery action"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary recovery value"
  measures:
    - name: "total_recovery_action_count"
      expr: COUNT(1)
      comment: "Total number of service recovery actions"
    - name: "total_recovery_cost"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all recovery actions"
    - name: "avg_recovery_cost"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per recovery action"
    - name: "proactive_recovery_count"
      expr: SUM(CASE WHEN is_proactive = TRUE THEN 1 ELSE 0 END)
      comment: "Number of proactive recovery actions"
    - name: "proactive_recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_proactive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions that were proactive"
    - name: "fulfilled_action_count"
      expr: SUM(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 ELSE 0 END)
      comment: "Number of recovery actions successfully fulfilled"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions successfully fulfilled"
    - name: "guest_accepted_count"
      expr: SUM(CASE WHEN guest_acceptance_status = 'Accepted' THEN 1 ELSE 0 END)
      comment: "Number of recovery actions accepted by guest"
    - name: "guest_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_acceptance_status = 'Accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions accepted by guests"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recovery actions requiring follow-up"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests receiving recovery actions"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties executing recovery actions"
    - name: "unique_service_cases"
      expr: COUNT(DISTINCT service_case_id)
      comment: "Number of unique service cases with recovery actions"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property quality audit performance metrics including overall scores, deficiency counts, corrective action compliance, and brand certification"
  source: "`vibe_travel_hospitality_v1`.`experience`.`quality_audit`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property being audited"
    - name: "audit_date"
      expr: audit_date
      comment: "Date of quality audit"
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of quality audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of quality audit conducted"
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the audit"
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Organization conducting the audit"
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Pass or fail determination of audit"
    - name: "brand_compliance_flag"
      expr: brand_compliance_flag
      comment: "Whether property is in brand compliance"
    - name: "certification_level_achieved"
      expr: certification_level_achieved
      comment: "Certification level achieved in audit"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "corrective_action_completion_status"
      expr: corrective_action_completion_status
      comment: "Status of corrective action completion"
    - name: "re_inspection_required_flag"
      expr: re_inspection_required_flag
      comment: "Whether re-inspection is required"
    - name: "gm_accountability_flag"
      expr: gm_accountability_flag
      comment: "Whether general manager is accountable for results"
  measures:
    - name: "total_audit_count"
      expr: COUNT(1)
      comment: "Total number of quality audits conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score"
    - name: "avg_housekeeping_score"
      expr: AVG(CAST(housekeeping_score AS DOUBLE))
      comment: "Average housekeeping audit score"
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service audit score"
    - name: "avg_facility_score"
      expr: AVG(CAST(facility_score AS DOUBLE))
      comment: "Average facility audit score"
    - name: "avg_fnb_score"
      expr: AVG(CAST(fnb_score AS DOUBLE))
      comment: "Average food and beverage audit score"
    - name: "avg_spa_score"
      expr: AVG(CAST(spa_score AS DOUBLE))
      comment: "Average spa audit score"
    - name: "avg_amenity_score"
      expr: AVG(CAST(amenity_score AS DOUBLE))
      comment: "Average amenity audit score"
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance from prior audit score"
    - name: "total_critical_deficiencies"
      expr: SUM(CAST(critical_deficiency_count AS BIGINT))
      comment: "Total number of critical deficiencies identified"
    - name: "total_major_deficiencies"
      expr: SUM(CAST(major_deficiency_count AS BIGINT))
      comment: "Total number of major deficiencies identified"
    - name: "total_minor_deficiencies"
      expr: SUM(CAST(minor_deficiency_count AS BIGINT))
      comment: "Total number of minor deficiencies identified"
    - name: "total_deficiencies"
      expr: SUM(CAST(deficiency_count AS BIGINT))
      comment: "Total number of all deficiencies identified"
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_determination = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of audits with pass determination"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_determination = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with pass determination"
    - name: "brand_compliant_count"
      expr: SUM(CASE WHEN brand_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits with brand compliance"
    - name: "brand_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN brand_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits achieving brand compliance"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring corrective action"
    - name: "re_inspection_required_count"
      expr: SUM(CASE WHEN re_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring re-inspection"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties audited"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_experience_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest experience program enrollment and completion metrics including program cost, satisfaction scores, loyalty points, and fulfillment progress"
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where program enrollment occurred"
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date of program enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of program enrollment"
    - name: "program_status"
      expr: program_status
      comment: "Current status of program enrollment"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment occurred"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of enrollment"
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether program enrollment is complimentary"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of enrollment"
    - name: "amenity_fulfillment_status"
      expr: amenity_fulfillment_status
      comment: "Status of amenity fulfillment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of program cost"
  measures:
    - name: "total_enrollment_count"
      expr: COUNT(1)
      comment: "Total number of program enrollments"
    - name: "total_program_cost"
      expr: SUM(CAST(total_program_cost AS DOUBLE))
      comment: "Total cost of all program enrollments"
    - name: "avg_program_cost"
      expr: AVG(CAST(total_program_cost AS DOUBLE))
      comment: "Average cost per program enrollment"
    - name: "avg_post_program_csat_score"
      expr: AVG(CAST(post_program_csat_score AS DOUBLE))
      comment: "Average customer satisfaction score after program completion"
    - name: "avg_post_program_gss_score"
      expr: AVG(CAST(post_program_gss_score AS DOUBLE))
      comment: "Average guest satisfaction score after program completion"
    - name: "avg_fulfillment_progress_percentage"
      expr: AVG(CAST(fulfillment_progress_percentage AS DOUBLE))
      comment: "Average fulfillment progress percentage across enrollments"
    - name: "total_loyalty_points_earned"
      expr: SUM(CAST(loyalty_points_earned AS BIGINT))
      comment: "Total loyalty points earned from program enrollments"
    - name: "complimentary_enrollment_count"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END)
      comment: "Number of complimentary program enrollments"
    - name: "complimentary_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that are complimentary"
    - name: "cancelled_enrollment_count"
      expr: SUM(CASE WHEN cancellation_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled enrollments"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cancellation_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that were cancelled"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests enrolled in programs"
    - name: "unique_programs"
      expr: COUNT(DISTINCT program_id)
      comment: "Number of unique programs with enrollments"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with program enrollments"
    - name: "avg_participant_count"
      expr: AVG(CAST(participant_count AS BIGINT))
      comment: "Average number of participants per enrollment"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_reputation_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reputation management alert metrics including alert volume, response time, SLA compliance, recovery cost, and guest satisfaction post-recovery"
  source: "`vibe_travel_hospitality_v1`.`experience`.`reputation_alert`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which reputation alert was triggered"
    - name: "triggered_date"
      expr: DATE_TRUNC('day', triggered_timestamp)
      comment: "Date alert was triggered"
    - name: "triggered_month"
      expr: DATE_TRUNC('month', triggered_timestamp)
      comment: "Month alert was triggered"
    - name: "alert_type"
      expr: alert_type
      comment: "Type of reputation alert"
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the alert"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of complaint triggering alert"
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department responsible for alert resolution"
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether alert was escalated"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether alert was resolved within SLA"
    - name: "guest_contacted_flag"
      expr: guest_contacted_flag
      comment: "Whether guest was contacted"
    - name: "guest_contact_method"
      expr: guest_contact_method
      comment: "Method used to contact guest"
    - name: "guest_satisfaction_post_recovery"
      expr: guest_satisfaction_post_recovery
      comment: "Guest satisfaction level after recovery"
  measures:
    - name: "total_alert_count"
      expr: COUNT(1)
      comment: "Total number of reputation alerts"
    - name: "avg_actual_response_minutes"
      expr: AVG(CAST(actual_response_minutes AS DOUBLE))
      comment: "Average actual response time in minutes"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score of alerts"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value triggering alerts"
    - name: "avg_variance_from_threshold"
      expr: AVG(CAST(variance_from_threshold AS DOUBLE))
      comment: "Average variance from alert threshold"
    - name: "total_recovery_cost"
      expr: SUM(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Total cost of recovery actions for alerts"
    - name: "avg_recovery_cost"
      expr: AVG(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Average recovery cost per alert"
    - name: "total_loyalty_points_awarded"
      expr: SUM(CAST(loyalty_points_awarded AS BIGINT))
      comment: "Total loyalty points awarded as recovery"
    - name: "escalated_alert_count"
      expr: SUM(CASE WHEN escalated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of alerts that were escalated"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that were escalated"
    - name: "sla_compliant_count"
      expr: SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of alerts resolved within SLA"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts resolved within SLA"
    - name: "guest_contacted_count"
      expr: SUM(CASE WHEN guest_contacted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of alerts where guest was contacted"
    - name: "guest_contact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_contacted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts where guest was contacted"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with reputation alerts"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with reputation alerts"
$$;