-- Metric views for domain: experience | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_amenity_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amenity fulfillment operational and cost metrics. Tracks fulfillment rates, delivery timing, guest satisfaction, and cost per amenity. Used by Rooms Operations and Guest Experience leadership to optimize amenity delivery programs."
  source: "`vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the amenity was fulfilled — primary dimension for property-level amenity program analysis."
    - name: "amenity_category"
      expr: amenity_category
      comment: "Category of amenity (welcome gift, F&B, floral, etc.) for category-level cost and satisfaction analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status (delivered, pending, cancelled, failed) for operational pipeline management."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of amenity delivery (in-room, at-arrival, concierge) for delivery channel optimization."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Boolean indicating whether the amenity was complimentary — separates comp cost from revenue-generating amenity analysis."
    - name: "occasion_type"
      expr: occasion_type
      comment: "Occasion driving the amenity (birthday, anniversary, honeymoon, VIP) for occasion-based program analysis."
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month of scheduled delivery — enables trending of amenity fulfillment volume and cost over time."
    - name: "charge_posted_flag"
      expr: charge_posted_flag
      comment: "Boolean indicating whether the amenity charge was posted to the folio — tracks revenue capture completeness."
  measures:
    - name: "total_amenity_fulfillments"
      expr: COUNT(1)
      comment: "Total number of amenity fulfillment records. Baseline metric for amenity program volume and operational load."
    - name: "total_amenity_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all amenity fulfillments. Measures the financial investment in the amenity program."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per amenity. Benchmarks amenity cost efficiency and identifies procurement optimization opportunities."
    - name: "fulfillment_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'delivered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amenities successfully delivered. Measures operational execution quality of the amenity program."
    - name: "guest_acknowledgment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_acknowledgment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amenity deliveries acknowledged by the guest. Measures guest awareness and engagement with the amenity program."
    - name: "charge_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN charge_posted_flag = TRUE AND is_complimentary = FALSE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_complimentary = FALSE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of non-complimentary amenities with charges successfully posted to the folio. Measures revenue leakage in the amenity program."
    - name: "complimentary_amenity_cost"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of complimentary amenities. Measures the investment in comp amenity programs for loyalty and VIP guests."
    - name: "distinct_guests_receiving_amenities"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Number of unique guests who received amenity fulfillments. Measures amenity program reach across the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_case_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service case activity and resolution efficiency metrics. Tracks activity volume, escalation patterns, compensation offered, and SLA milestone compliance. Used by Guest Relations Operations to manage case workload and resolution quality."
  source: "`vibe_travel_hospitality_v1`.`experience`.`case_activity`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the case activity — primary dimension for property-level service operations analysis."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of case activity (call, email, room visit, escalation) for activity mix analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (open, completed, pending) for workload management."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the case activity (phone, email, chat, in-person) for channel effectiveness analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean indicating whether the activity involved an escalation — tracks escalation frequency."
    - name: "activity_month"
      expr: DATE_TRUNC('month', activity_timestamp)
      comment: "Month the activity occurred — enables trending of case activity volume over time."
    - name: "priority"
      expr: priority
      comment: "Priority level of the case activity — used to assess workload distribution and response prioritization."
    - name: "compensation_offered_flag"
      expr: compensation_offered_flag
      comment: "Boolean indicating whether compensation was offered during this activity — tracks recovery offer frequency."
  measures:
    - name: "total_case_activities"
      expr: COUNT(1)
      comment: "Total number of case activities. Baseline metric for service operations workload volume."
    - name: "total_compensation_value"
      expr: SUM(CAST(compensation_value AS DOUBLE))
      comment: "Total monetary value of compensation offered across all case activities. Measures the financial cost of service recovery at the activity level."
    - name: "avg_compensation_per_activity"
      expr: AVG(CAST(compensation_value AS DOUBLE))
      comment: "Average compensation value per case activity. Benchmarks recovery generosity and identifies outlier compensation events."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case activities that involved an escalation. High rates signal systemic service failures or empowerment gaps."
    - name: "compensation_offer_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compensation_offered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case activities where compensation was offered. Measures recovery program activation frequency."
    - name: "sla_milestone_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_milestone_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case activities that hit SLA milestones on time. Measures service operations adherence to resolution commitments."
    - name: "guest_communication_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_communication_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case activities that included direct guest communication. Measures proactive guest engagement during case resolution."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case activities requiring follow-up. Indicates incomplete resolution and additional service burden on the team."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment metrics tracking request volume, fulfillment rates, costs, and guest satisfaction. Enables operations teams to measure personalization program effectiveness and identify fulfillment bottlenecks."
  source: "`vibe_travel_hospitality_v1`.`experience`.`experience_special_request`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the special request was submitted."
    - name: "request_type"
      expr: request_type
      comment: "Type of special request (room preference, dietary, accessibility, occasion) for category analysis."
    - name: "request_subtype"
      expr: request_subtype
      comment: "Detailed sub-type for granular fulfillment analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (pending, fulfilled, cancelled, declined)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request for workload management."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Guest loyalty tier for tier-based fulfillment analysis."
    - name: "is_service_recovery"
      expr: is_service_recovery
      comment: "Whether the request is part of a service recovery action."
    - name: "is_loyalty_member_request"
      expr: is_loyalty_member_request
      comment: "Whether the request was made by a loyalty program member."
    - name: "request_source"
      expr: request_source
      comment: "Channel through which the request was submitted (app, pre-arrival, front desk)."
    - name: "request_submitted_timestamp_month"
      expr: DATE_TRUNC('month', request_submitted_timestamp)
      comment: "Month the request was submitted for trend analysis."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests submitted. Baseline metric for personalization program volume."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of fulfilling special requests. Tracks personalization program spend."
    - name: "total_charge_to_guest"
      expr: SUM(CAST(charge_to_guest_amount AS DOUBLE))
      comment: "Total amount charged to guests for special requests. Measures revenue generated from personalization services."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per special request. Benchmarks cost planning accuracy."
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN request_status = 'fulfilled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests successfully fulfilled. Core personalization program KPI."
    - name: "complimentary_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests fulfilled complimentarily. Tracks cost of complimentary personalization."
    - name: "repeat_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_request = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests that are repeats from prior stays. High rates indicate strong personalization memory and guest loyalty."
    - name: "service_recovery_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_service_recovery = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests that are service recovery actions. Tracks volume of recovery-driven personalization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_gss_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Satisfaction Score (GSS) program performance metrics. Tracks NPS, promoter/detractor distribution, response rates, and period-over-period variance. Used by Brand Standards, Operations, and Owner Relations teams for brand compliance and management agreement reporting."
  source: "`vibe_travel_hospitality_v1`.`experience`.`gss_score`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which the GSS score was calculated — primary dimension for property-level brand standard compliance."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (monthly, quarterly, annual) for period-appropriate benchmarking."
    - name: "measurement_start_month"
      expr: DATE_TRUNC('month', measurement_start_date)
      comment: "Month the measurement period started — enables time-series trending of GSS performance."
    - name: "department_code"
      expr: department_code
      comment: "Department associated with the GSS score — enables departmental accountability reporting."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for which the score was calculated — enables segment-level satisfaction analysis."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the property — enables brand-level portfolio benchmarking."
    - name: "salt_target_attained_flag"
      expr: salt_target_attained_flag
      comment: "Boolean indicating whether the SALT (Satisfaction and Loyalty Tracking) target was met — primary brand compliance KPI."
    - name: "published_flag"
      expr: published_flag
      comment: "Whether the GSS score has been published/finalized — filters for official vs. draft scores."
  measures:
    - name: "total_gss_records"
      expr: COUNT(1)
      comment: "Total number of GSS score records. Baseline count for measurement program coverage."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across all GSS records. Primary brand loyalty KPI used in management agreements and owner reporting."
    - name: "avg_gss_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average GSS composite value score. The headline satisfaction metric for brand standard compliance reporting."
    - name: "avg_promoter_pct"
      expr: AVG(CAST(promoter_percent AS DOUBLE))
      comment: "Average percentage of promoters (NPS score 9-10). Measures brand advocacy strength across the portfolio."
    - name: "avg_detractor_pct"
      expr: AVG(CAST(detractor_percent AS DOUBLE))
      comment: "Average percentage of detractors (NPS score 0-6). Measures reputational risk and service failure prevalence."
    - name: "avg_passive_pct"
      expr: AVG(CAST(passive_percent AS DOUBLE))
      comment: "Average percentage of passive respondents (NPS score 7-8). Identifies guests at risk of switching to competitors."
    - name: "avg_top_box_pct"
      expr: AVG(CAST(top_box_pct AS DOUBLE))
      comment: "Average top-box percentage (highest satisfaction rating). Used in brand standard compliance thresholds and management agreements."
    - name: "avg_bottom_box_pct"
      expr: AVG(CAST(bottom_box_pct AS DOUBLE))
      comment: "Average bottom-box percentage (lowest satisfaction rating). Tracks severe dissatisfaction prevalence requiring immediate intervention."
    - name: "avg_response_rate_pct"
      expr: AVG(CAST(response_rate_pct AS DOUBLE))
      comment: "Average survey response rate percentage. Measures survey program health and statistical validity of GSS scores."
    - name: "avg_yoy_variance"
      expr: AVG(CAST(yoy_variance AS DOUBLE))
      comment: "Average year-over-year variance in GSS score. Tracks improvement or deterioration trends for strategic planning."
    - name: "avg_prior_period_variance"
      expr: AVG(CAST(prior_period_variance AS DOUBLE))
      comment: "Average variance from prior period GSS score. Enables short-term trend monitoring and early warning of satisfaction decline."
    - name: "salt_target_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN salt_target_attained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GSS records where the SALT target was attained. Primary brand compliance KPI for portfolio-level brand standard reporting."
    - name: "avg_grr_pct"
      expr: AVG(CAST(grr_percent AS DOUBLE))
      comment: "Average Guest Relations Recovery (GRR) percentage. Measures the proportion of dissatisfied guests successfully recovered."
    - name: "avg_confidence_interval_width"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE) - CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average width of the confidence interval for GSS scores. Measures statistical reliability of scores — wide intervals indicate insufficient sample sizes."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_experience_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experience program enrollment and fulfillment metrics. Tracks enrollment volume, program completion rates, satisfaction outcomes, and cost per enrollment. Used by Experience Program Managers and Revenue leadership to evaluate program ROI and guest engagement."
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the enrollment occurred — primary dimension for property-level program performance analysis."
    - name: "program_status"
      expr: program_status
      comment: "Current status of the enrollment (active, completed, cancelled, pending) for pipeline management."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the guest enrolled (front desk, app, OTA, concierge) for channel effectiveness analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or campaign that drove the enrollment — used for marketing attribution."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Boolean indicating whether the enrollment was complimentary — used to separate revenue-generating from comp program analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the enrollment (paid, pending, waived) for revenue recognition tracking."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_timestamp)
      comment: "Month of enrollment — enables trending of program uptake over time."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for enrollment cancellation — used to identify program design or delivery issues."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of experience program enrollments. Baseline metric for program uptake and reach."
    - name: "total_program_revenue"
      expr: SUM(CAST(total_program_cost AS DOUBLE))
      comment: "Total revenue generated from experience program enrollments. Measures the financial contribution of the experience program portfolio."
    - name: "avg_program_cost_per_enrollment"
      expr: AVG(CAST(total_program_cost AS DOUBLE))
      comment: "Average cost per enrollment. Benchmarks program pricing and identifies revenue optimization opportunities."
    - name: "avg_post_program_csat"
      expr: AVG(CAST(post_program_csat_score AS DOUBLE))
      comment: "Average post-program CSAT score. Measures guest satisfaction with experience program delivery — primary program quality KPI."
    - name: "avg_post_program_gss"
      expr: AVG(CAST(post_program_gss_score AS DOUBLE))
      comment: "Average post-program GSS score. Measures the impact of experience programs on overall guest satisfaction."
    - name: "avg_fulfillment_progress_pct"
      expr: AVG(CAST(fulfillment_progress_percentage AS DOUBLE))
      comment: "Average fulfillment progress percentage across enrollments. Measures program delivery completeness and operational execution quality."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN program_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that were cancelled. High cancellation rates signal program design, pricing, or delivery issues."
    - name: "complimentary_enrollment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that were complimentary. Measures the cost of comp program delivery vs. revenue-generating enrollments."
    - name: "distinct_enrolled_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests enrolled in experience programs. Measures program reach across the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest satisfaction and feedback quality metrics. Tracks NPS, CSAT, sentiment, and service recovery signals across all guest feedback submissions. Used by Guest Experience VPs and GMs to steer satisfaction programs and identify service failures."
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_feedback`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the feedback originated — primary slice for property-level performance benchmarking."
    - name: "guest_segment"
      expr: guest_segment
      comment: "Guest segment classification (e.g., leisure, corporate, group) for segment-level satisfaction analysis."
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS bucket (Promoter, Passive, Detractor) for distribution analysis."
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Overall sentiment label (positive, neutral, negative) derived from verbatim analysis."
    - name: "stay_date_from"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Month of stay start date — enables trending of satisfaction scores over time."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month feedback was submitted — used to track survey response velocity and recency."
    - name: "survey_completion_status"
      expr: survey_completion_status
      comment: "Whether the survey was fully completed, partially completed, or abandoned."
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Boolean flag indicating whether the feedback contains a formal complaint."
    - name: "service_recovery_required_flag"
      expr: service_recovery_required_flag
      comment: "Boolean flag indicating whether service recovery was triggered by this feedback."
  measures:
    - name: "total_feedback_submissions"
      expr: COUNT(1)
      comment: "Total number of guest feedback records submitted. Baseline volume metric for survey program health."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall guest satisfaction rating across all feedback submissions. Primary KPI for property-level guest experience performance."
    - name: "avg_nps_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across feedback records — proxy for NPS trend analysis where numeric NPS is available."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT (Customer Satisfaction) score. Directly measures guest satisfaction with service delivery."
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness rating — a leading indicator of housekeeping quality and brand standard compliance."
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service rating — measures staff performance and service delivery quality."
    - name: "avg_fnb_rating"
      expr: AVG(CAST(fnb_rating AS DOUBLE))
      comment: "Average food and beverage rating — used by F&B leadership to assess outlet quality."
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average value-for-money rating — signals pricing perception and rate strategy alignment."
    - name: "avg_room_rating"
      expr: AVG(CAST(room_rating AS DOUBLE))
      comment: "Average room quality rating — informs capital investment and renovation prioritization."
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities rating — measures guest perception of property amenity offerings."
    - name: "complaint_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN complaint_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback submissions that contain a formal complaint. Tracks service failure frequency and brand risk."
    - name: "service_recovery_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_recovery_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback records that triggered a service recovery action. Measures severity of guest dissatisfaction requiring intervention."
    - name: "would_recommend_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN would_recommend_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who indicated they would recommend the property. A leading indicator of organic referral and brand advocacy."
    - name: "would_return_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN would_return_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who indicated they would return. Directly measures loyalty intent and repeat business potential."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average time in hours between feedback submission and management response. Measures responsiveness and SLA adherence for guest feedback management."
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score (GSS) — the primary brand-standard satisfaction KPI used in hotel management agreements and owner reporting."
    - name: "distinct_guests_with_feedback"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles who submitted feedback. Measures survey reach and coverage across the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest interaction metrics tracking touchpoint volume, sentiment, follow-up rates, and VIP engagement. Enables front-of-house leadership to measure service delivery quality and staff-guest engagement effectiveness."
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_interaction`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the guest interaction occurred."
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (check-in, concierge request, complaint, upsell, wellness consultation)."
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the interaction for departmental performance analysis."
    - name: "interaction_outcome"
      expr: interaction_outcome
      comment: "Outcome of the interaction (resolved, escalated, referred, pending)."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification of the interaction (positive, neutral, negative)."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Whether the guest has VIP status, enabling VIP-specific service analysis."
    - name: "guest_initiated_flag"
      expr: guest_initiated_flag
      comment: "Whether the interaction was initiated by the guest or proactively by staff."
    - name: "interaction_timestamp_month"
      expr: DATE_TRUNC('month', interaction_timestamp)
      comment: "Month of interaction for trend analysis."
    - name: "nps_eligible_flag"
      expr: nps_eligible_flag
      comment: "Whether the interaction is eligible to trigger an NPS survey."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of guest interactions recorded. Baseline metric for service touchpoint volume."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across all guest interactions. Tracks overall emotional quality of guest-staff engagement."
    - name: "special_request_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN special_request_fulfilled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions where a special request was fulfilled. Measures service personalization effectiveness."
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions requiring follow-up. Indicates unresolved guest needs."
    - name: "amenity_offer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN amenity_offered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions where an amenity was offered. Measures proactive hospitality and upsell activity."
    - name: "vip_interaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vip_status_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions involving VIP guests. Tracks VIP service engagement levels."
    - name: "distinct_guests_interacted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with recorded interactions. Measures service touchpoint coverage across the guest population."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_online_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online reputation and review performance metrics. Tracks normalized ratings, sentiment, management response rates, and competitive positioning across OTA and review platforms. Used by Revenue Management and Marketing leadership for reputation strategy."
  source: "`vibe_travel_hospitality_v1`.`experience`.`online_review`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property being reviewed — primary dimension for property-level reputation benchmarking."
    - name: "review_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month the review was posted — enables trending of review volume and rating trajectory."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment label (positive, neutral, negative) for distribution analysis of review tone."
    - name: "traveler_type"
      expr: traveler_type
      comment: "Type of traveler (business, leisure, couple, family) for segment-level reputation analysis."
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of the review — used for multilingual reputation management and market reach analysis."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Whether management has responded to the review — tracks response program coverage."
    - name: "competitive_set_flag"
      expr: competitive_set_flag
      comment: "Boolean indicating whether the review is from a competitive set property — enables competitive benchmarking."
    - name: "verified_stay_flag"
      expr: verified_stay_flag
      comment: "Boolean indicating whether the reviewer had a verified stay — filters for authentic review quality."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of online reviews. Baseline volume metric for review program reach and platform coverage."
    - name: "avg_normalized_rating"
      expr: AVG(CAST(normalized_rating AS DOUBLE))
      comment: "Average normalized rating across all review platforms (standardized to a common scale). Primary KPI for cross-platform reputation benchmarking."
    - name: "avg_platform_native_rating"
      expr: AVG(CAST(platform_native_rating AS DOUBLE))
      comment: "Average rating in the platform's native scale. Used for platform-specific reputation reporting (e.g., TripAdvisor, Booking.com)."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average NLP sentiment score across reviews. Tracks emotional tone trends beyond star ratings."
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness sub-rating from online reviews — cross-validates internal housekeeping scores."
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service sub-rating from online reviews — external validation of staff performance."
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average value-for-money rating from online reviews — external signal for pricing strategy alignment."
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities rating from online reviews — informs capital investment prioritization."
    - name: "management_response_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN management_response_status = 'responded' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that received a management response. Measures reputation management program engagement and responsiveness."
    - name: "verified_stay_review_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN verified_stay_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews from verified stays. Measures authenticity of review base and guards against fraudulent review inflation."
    - name: "avg_location_rating"
      expr: AVG(CAST(location_rating AS DOUBLE))
      comment: "Average location rating from online reviews — used in property positioning and marketing messaging."
    - name: "distinct_reviewing_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles who posted online reviews. Measures review program reach across the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property quality audit performance and compliance metrics. Tracks audit scores by department, deficiency rates, corrective action completion, and brand certification outcomes. Used by Brand Standards, Operations, and Ownership teams for compliance and capital planning."
  source: "`vibe_travel_hospitality_v1`.`experience`.`quality_audit`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property being audited — primary dimension for property-level brand compliance benchmarking."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of quality audit (brand standard, health & safety, food safety, etc.) for audit program categorization."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in-progress, completed, failed) for pipeline management."
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Whether the property passed or failed the audit — primary compliance outcome dimension."
    - name: "certification_level_achieved"
      expr: certification_level_achieved
      comment: "Brand certification level achieved (e.g., Gold, Silver, Platinum) — used in owner reporting and franchise agreements."
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month the audit was conducted — enables trending of audit performance over time."
    - name: "brand_compliance_flag"
      expr: brand_compliance_flag
      comment: "Boolean indicating brand standard compliance — primary flag for franchise and management agreement reporting."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Boolean indicating whether corrective action was required — tracks remediation burden across the portfolio."
    - name: "gm_accountability_flag"
      expr: gm_accountability_flag
      comment: "Boolean indicating GM-level accountability for audit findings — used in performance management."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of quality audits conducted. Baseline metric for audit program coverage and frequency."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall quality audit score. Primary KPI for brand standard compliance and property quality benchmarking."
    - name: "avg_housekeeping_score"
      expr: AVG(CAST(housekeeping_score AS DOUBLE))
      comment: "Average housekeeping audit score. Measures cleanliness and room preparation standards compliance."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service delivery audit score. Measures staff service quality against brand standards."
    - name: "avg_fnb_score"
      expr: AVG(CAST(fnb_score AS DOUBLE))
      comment: "Average food and beverage audit score. Measures F&B quality and safety compliance."
    - name: "avg_facility_score"
      expr: AVG(CAST(facility_score AS DOUBLE))
      comment: "Average facility condition audit score. Informs capital expenditure and maintenance investment decisions."
    - name: "avg_spa_score"
      expr: AVG(CAST(spa_score AS DOUBLE))
      comment: "Average spa audit score. Measures spa service and facility quality against brand standards."
    - name: "avg_amenity_score"
      expr: AVG(CAST(amenity_score AS DOUBLE))
      comment: "Average amenity audit score. Measures amenity quality and availability compliance."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_determination = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a pass determination. Primary brand compliance KPI for portfolio-level reporting."
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN brand_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits achieving brand compliance. Used in franchise agreement compliance reporting and owner relations."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action. Measures remediation burden and systemic quality gaps."
    - name: "avg_score_variance_vs_prior"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance in overall score compared to prior audit. Tracks quality improvement or deterioration trends."
    - name: "re_inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN re_inspection_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring re-inspection. High rates indicate persistent quality failures and remediation ineffectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_reputation_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reputation alert management and recovery cost metrics. Tracks alert volume, severity distribution, SLA compliance, recovery costs, and escalation rates. Used by Guest Relations and Marketing leadership to manage online reputation risk."
  source: "`vibe_travel_hospitality_v1`.`experience`.`reputation_alert`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the reputation alert — primary dimension for property-level reputation risk management."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of reputation alert (negative review, social media mention, complaint threshold breach) for categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the alert (critical, high, medium, low) — used to prioritize response resources."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (open, acknowledged, resolved, closed) for pipeline management."
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the underlying complaint — enables root-cause analysis and targeted improvement programs."
    - name: "alert_month"
      expr: DATE_TRUNC('month', triggered_timestamp)
      comment: "Month the alert was triggered — enables trending of reputation risk over time."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Boolean indicating whether the alert was escalated — tracks escalation frequency as a severity signal."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Boolean indicating whether the alert was responded to within SLA — measures reputation response program effectiveness."
  measures:
    - name: "total_reputation_alerts"
      expr: COUNT(1)
      comment: "Total number of reputation alerts triggered. Baseline metric for reputation risk volume monitoring."
    - name: "total_recovery_cost"
      expr: SUM(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Total monetary cost of reputation recovery actions. Measures the financial impact of reputation failures."
    - name: "avg_recovery_cost_per_alert"
      expr: AVG(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Average recovery cost per reputation alert. Benchmarks recovery efficiency and identifies high-cost alert categories."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reputation alerts responded to within SLA. Measures reputation management program responsiveness."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reputation alerts that were escalated. High rates signal systemic reputation failures requiring executive attention."
    - name: "guest_contacted_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_contacted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reputation alerts where the guest was directly contacted. Measures proactive recovery outreach coverage."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score of alerts. Tracks the emotional intensity of reputation issues requiring management attention."
    - name: "avg_variance_from_threshold"
      expr: AVG(CAST(variance_from_threshold AS DOUBLE))
      comment: "Average variance from the alert trigger threshold. Measures how far below acceptable thresholds reputation metrics have fallen."
    - name: "distinct_properties_with_alerts"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active reputation alerts. Measures portfolio-wide reputation risk breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service case resolution and quality metrics. Tracks case volume, resolution speed, SLA compliance, and compensation costs. Used by Guest Relations leadership and Operations VPs to manage service failure rates and recovery effectiveness."
  source: "`vibe_travel_hospitality_v1`.`experience`.`service_case`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the service case originated — primary dimension for property-level service quality benchmarking."
    - name: "case_category"
      expr: case_category
      comment: "High-level category of the service case (e.g., room issue, F&B complaint, billing dispute)."
    - name: "case_subcategory"
      expr: case_subcategory
      comment: "Detailed subcategory for root-cause analysis and targeted service improvement."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (open, in-progress, resolved, closed) for pipeline management."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority (critical, high, medium, low) — used to assess workload distribution and escalation patterns."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Whether the case has been escalated — tracks escalation frequency as a service quality signal."
    - name: "case_origin"
      expr: case_origin
      comment: "Channel through which the case was raised (front desk, OTA, social media, email) for channel-level service analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the case was created — enables trending of case volume and resolution performance over time."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Boolean indicating whether the service failure was preventable — used to drive root-cause elimination programs."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the case was resolved (compensation, apology, room move, etc.) for recovery strategy analysis."
  measures:
    - name: "total_service_cases"
      expr: COUNT(1)
      comment: "Total number of service cases. Baseline volume metric for service failure tracking."
    - name: "avg_resolution_hours"
      expr: AVG(CAST(actual_resolution_hours AS DOUBLE))
      comment: "Average time in hours to resolve a service case. Core operational KPI for service recovery speed and SLA performance."
    - name: "total_compensation_value"
      expr: SUM(CAST(compensation_total_value AS DOUBLE))
      comment: "Total monetary value of compensation offered to resolve service cases. Measures the financial cost of service failures."
    - name: "avg_compensation_per_case"
      expr: AVG(CAST(compensation_total_value AS DOUBLE))
      comment: "Average compensation value per service case. Benchmarks recovery cost efficiency and identifies outlier cases."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service cases resolved within SLA target hours. Critical KPI for service operations accountability and brand standard compliance."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'none' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were escalated. High escalation rates signal systemic service failures requiring management intervention."
    - name: "preventable_case_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service cases that were preventable. Drives continuous improvement programs and root-cause elimination investment."
    - name: "social_media_mention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN social_media_mention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service cases with associated social media mentions. Measures reputational risk exposure from service failures."
    - name: "grr_outcome_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN grr_outcome_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with a positive Guest Relations Recovery (GRR) outcome. Measures recovery program effectiveness."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases requiring follow-up action. Indicates incomplete first-contact resolution and additional service burden."
    - name: "distinct_guests_with_cases"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests who raised service cases. Measures breadth of service failure impact across the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_service_recovery_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service recovery action effectiveness and cost metrics. Tracks recovery action volume, monetary value, fulfillment rates, and post-recovery satisfaction. Used by Guest Relations and Operations leadership to optimize recovery investment and measure program ROI."
  source: "`vibe_travel_hospitality_v1`.`experience`.`service_recovery_action`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the service recovery action was executed — primary dimension for property-level recovery program analysis."
    - name: "recovery_action_category"
      expr: recovery_action_category
      comment: "Category of recovery action (room upgrade, F&B credit, loyalty points, etc.) for recovery mix analysis."
    - name: "recovery_action_type"
      expr: recovery_action_type
      comment: "Specific type of recovery action for granular cost and effectiveness analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Whether the recovery action was fulfilled, pending, or cancelled — tracks execution quality."
    - name: "authorization_level"
      expr: authorization_level
      comment: "Level of authorization required for the recovery action — measures empowerment and escalation patterns."
    - name: "is_proactive"
      expr: is_proactive
      comment: "Boolean indicating whether the recovery was proactive (before complaint) or reactive — measures proactive service culture."
    - name: "action_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the recovery action was created — enables trending of recovery activity and cost over time."
    - name: "guest_acceptance_status"
      expr: guest_acceptance_status
      comment: "Whether the guest accepted the recovery offer — measures recovery offer relevance and effectiveness."
  measures:
    - name: "total_recovery_actions"
      expr: COUNT(1)
      comment: "Total number of service recovery actions executed. Baseline metric for recovery program activity volume."
    - name: "total_recovery_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all service recovery actions. Measures the financial investment in guest recovery programs."
    - name: "avg_recovery_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per recovery action. Benchmarks recovery generosity and identifies cost outliers by category."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'fulfilled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions successfully fulfilled. Measures execution quality of the recovery program."
    - name: "guest_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_acceptance_status = 'accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery offers accepted by guests. Measures relevance and appropriateness of recovery actions offered."
    - name: "proactive_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_proactive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions that were proactive. Measures the maturity of the service culture — higher proactive rates indicate stronger guest-centric operations."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions requiring follow-up. Indicates incomplete first-attempt recovery and additional service burden."
    - name: "distinct_guests_recovered"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests who received service recovery actions. Measures recovery program reach across the guest base."
$$;
