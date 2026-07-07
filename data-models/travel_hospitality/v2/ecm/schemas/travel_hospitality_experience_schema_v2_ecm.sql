-- Schema for Domain: experience | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`experience` COMMENT 'Guest experience, service quality, and service recovery management including guest feedback, NPS surveys, complaint case management, GRR (Guest Recovery Rate), and satisfaction tracking. Manages service recovery workflows, amenity fulfillment, special request tracking, and GSS/CSAT scoring. Integrates with Medallia as the primary experience analytics platform and Salesforce CRM for case management. Supports SALT programs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` (
    `guest_feedback_id` BIGINT COMMENT 'Unique identifier for the guest feedback submission record. Primary key for the guest feedback entity.',
    `channel_booking_id` BIGINT COMMENT 'Foreign key linking to channel.channel_booking. Business justification: Post-stay feedback must link to originating channel booking to enable channel performance analysis by guest satisfaction, NPS by distribution partner, and channel mix optimization based on experience ',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Guest feedback tracks F&B outlet-specific ratings (fnb_rating attribute exists). Links feedback to specific restaurant/bar for outlet-level performance analysis, service recovery targeting, and operat',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Guest satisfaction analysis requires linking feedback to specific room type products for product-level quality metrics, defect tracking, and renovation prioritization. Replaces denormalized room_type_',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Event planners provide separate feedback on meeting spaces. Sales teams require space-level satisfaction scores for proposals and contract renewals. Real business process: meeting space performance da',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Guest feedback analysis by loyalty tier drives service recovery prioritization, tier-specific satisfaction benchmarking, and retention campaign targeting. Hospitality operations require immediate memb',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to experience.nps_survey. Business justification: Guest feedback submissions should reference the specific NPS survey instrument used for the response. This links the feedback record to the survey definition, enabling analysis by survey version, camp',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Guest feedback is routed to specific departments (Housekeeping, Front Desk, F&B) for service recovery and performance improvement. Hotels track feedback by org_unit for departmental scorecards, manage',
    `profile_id` BIGINT COMMENT 'Reference to the guest who submitted the feedback. Links to the guest master profile for loyalty and experience tracking.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Guest feedback routinely references specific facilities (pool, gym, restaurant). Operations teams need facility-level satisfaction tracking to prioritize maintenance and route complaints to facility m',
    `property_id` BIGINT COMMENT 'Reference to the property where the guest experience occurred. Essential for property-level satisfaction benchmarking and operational improvement.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation associated with this feedback submission. Links feedback to the specific stay or booking that prompted the response.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Facility-specific feedback (noise, cleanliness, maintenance issues) must link to exact room for targeted corrective action, out-of-order decisions, and room-level quality tracking. Critical for operat',
    `service_case_id` BIGINT COMMENT 'Reference to the service recovery case created in Salesforce CRM if this feedback triggered a complaint or service recovery workflow. Links feedback to resolution tracking.',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Guest feedback is collected at specific touchpoints in the journey (post-checkout survey, post-stay email, in-app feedback). Linking feedback to touchpoint enables touchpoint-level satisfaction analys',
    `amenities_rating` DECIMAL(18,2) COMMENT 'Guest rating of property amenities including pool, fitness center, business center, and other facilities. Informs capital expenditure and FF&E decisions.',
    `cleanliness_rating` DECIMAL(18,2) COMMENT 'Guest rating specific to property cleanliness standards across all areas. Essential metric for housekeeping operations and health compliance.',
    `complaint_flag` BOOLEAN COMMENT 'Boolean indicator whether this feedback contains a complaint requiring service recovery action. Triggers case management workflow in Salesforce CRM.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this feedback record was first created in the data platform. Used for data lineage and audit trail purposes.',
    `csat_score` DECIMAL(18,2) COMMENT 'Transaction-specific satisfaction rating typically on a 1-5 or 1-10 scale. Measures satisfaction with a specific interaction or service touchpoint.',
    `feedback_number` STRING COMMENT 'Human-readable business identifier for the feedback submission. Used for case tracking and guest communication reference.. Valid values are `^FB-[0-9]{10}$`',
    `fnb_rating` DECIMAL(18,2) COMMENT 'Guest rating specific to food and beverage quality, variety, and service. Key metric for F&B operations and outlet performance.',
    `gss_score` DECIMAL(18,2) COMMENT 'Overall guest satisfaction score typically on a 0-100 scale or 1-5 scale. Composite metric aggregating multiple satisfaction dimensions. Key performance indicator for property operations and service quality.',
    `guest_segment` STRING COMMENT 'Business segment classification of the guest. FIT (Free Independent Traveler), MICE (Meetings Incentives Conferences Exhibitions). Used for segment-specific satisfaction analysis and targeted service improvements. [ENUM-REF-CANDIDATE: Transient|Group|Contract|Wholesale|FIT|Corporate|Leisure|MICE — 8 candidates stripped; promote to reference product]',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the feedback was submitted. Used for multilingual sentiment analysis and regional experience tracking.. Valid values are `^[A-Z]{3}$`',
    `location_rating` DECIMAL(18,2) COMMENT 'Guest rating of property location convenience, accessibility, and surrounding area. Influences market positioning and guest segment targeting.',
    `nps_classification` STRING COMMENT 'Categorical classification of the NPS score. Promoter (9-10) indicates strong loyalty, Passive (7-8) indicates satisfaction without enthusiasm, Detractor (0-6) indicates dissatisfaction and churn risk.. Valid values are `Promoter|Passive|Detractor`',
    `nps_score` STRING COMMENT 'Guest rating on a 0-10 scale indicating likelihood to recommend the property. 0-6 are detractors, 7-8 are passives, 9-10 are promoters. Core metric for loyalty measurement and SALT program reporting.',
    `overall_rating` DECIMAL(18,2) COMMENT 'General overall rating provided by the guest, typically on a 1-5 star scale. Used for aggregated property ratings and guest experience benchmarking.',
    `rate_code` STRING COMMENT 'Rate plan code under which the guest booked. Used for analyzing satisfaction by rate segment and pricing strategy effectiveness.',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Number of hours between survey invitation and guest response submission. Metric for survey engagement and recency of experience recall.',
    `room_rating` DECIMAL(18,2) COMMENT 'Guest rating specific to room quality, cleanliness, comfort, and amenities. Key operational metric for housekeeping and room standards.',
    `sentiment_indicator` STRING COMMENT 'Automated or manual classification of the overall sentiment expressed in the feedback. Derived from verbatim comments and ratings through natural language processing or analyst review.. Valid values are `Positive|Neutral|Negative|Mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numerical sentiment score typically ranging from -1.0 (very negative) to +1.0 (very positive). Generated through natural language processing of verbatim comments.',
    `service_rating` DECIMAL(18,2) COMMENT 'Guest rating specific to staff service quality, responsiveness, and professionalism. Critical metric for training and service excellence programs.',
    `service_recovery_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this feedback requires formal service recovery intervention. Used for GRR (Guest Recovery Rate) calculation and case prioritization.',
    `stay_date_from` DATE COMMENT 'Start date of the guest stay associated with this feedback. Used for temporal analysis and linking feedback to operational conditions during the stay period.',
    `stay_date_to` DATE COMMENT 'End date of the guest stay associated with this feedback. Used for calculating length of stay context and temporal correlation with feedback timing.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the guest submitted the feedback. Critical for recency analysis and service recovery response time tracking.',
    `survey_completion_status` STRING COMMENT 'Indicator of whether the guest completed the entire survey, partially completed it, or abandoned it. Used for survey design optimization and response quality assessment.. Valid values are `Complete|Partial|Abandoned`',
    `survey_invitation_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the survey invitation was sent to the guest. Used for calculating response time and survey engagement metrics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this feedback record was last modified in the data platform. Tracks enrichment activities such as sentiment scoring updates or case linkage.',
    `value_rating` DECIMAL(18,2) COMMENT 'Guest perception of value for money received. Critical metric for pricing strategy and revenue management decisions.',
    `verbatim_comment` STRING COMMENT 'Free-text comment provided by the guest describing their experience in their own words. Rich qualitative data for sentiment analysis, theme extraction, and service recovery prioritization.',
    `would_recommend_flag` BOOLEAN COMMENT 'Boolean indicator whether the guest explicitly stated they would recommend the property to others. Complementary metric to NPS for loyalty measurement.',
    `would_return_flag` BOOLEAN COMMENT 'Boolean indicator whether the guest explicitly stated they would return to the property. Key metric for repeat business potential and guest retention forecasting.',
    CONSTRAINT pk_guest_feedback PRIMARY KEY(`guest_feedback_id`)
) COMMENT 'Core transactional record of guest feedback submissions captured across all touchpoints including post-stay surveys, in-stay pulse checks, real-time feedback, and NPS survey responses. Sourced primarily from Medallia and integrated with OPERA PMS stay data. Captures NPS scores (0-10 with promoter/passive/detractor classification), GSS (Guest Satisfaction Score), CSAT ratings, verbatim comments, sentiment indicators, survey type discriminator (NPS, CSAT, pulse, general), response channel (email, SMS, kiosk, app), stay reference, property, and submission timestamp. Serves as the single authoritative source for all guest voice data including NPS responses in the experience domain. Drives SALT program reporting and trend analysis by property, segment, and time period.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` (
    `nps_survey_id` BIGINT COMMENT 'Unique identifier for the NPS survey instrument and campaign definition. Primary key.',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: NPS surveys can be linked to specific experience programs (SALT programs) to measure program-specific guest satisfaction. The nps_survey already has salt_program_linked_flag (boolean) but no FK to ide',
    `survey_template_id` BIGINT COMMENT 'Reference to the master survey template or design framework from which this survey instance was created. Supports template-based survey design and standardization.',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: NPS surveys are deployed at specific touchpoints in the guest journey (post-checkout, post-stay, post-service). This FK links the survey definition to the touchpoint where it is triggered, enabling to',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant if this survey is part of a controlled experiment to optimize survey design, question wording, or distribution strategy (e.g., Control, Variant_A, Variant_B). Null if not part of an A/B test.',
    `anonymous_response_flag` BOOLEAN COMMENT 'Indicates whether guest responses to this survey are collected anonymously (True) without linking to guest profiles, or are attributed to specific guests (False) for follow-up and service recovery.',
    `compliance_review_date` DATE COMMENT 'The date when this survey was last reviewed for compliance with data privacy and guest communication regulations. Null if not yet reviewed.',
    `compliance_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this survey has been reviewed and approved for compliance with data privacy regulations (GDPR, CCPA) and guest communication standards (True) or is pending review (False).',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this survey instrument definition.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this survey instrument record was first created in the system.',
    `detractor_threshold_max` STRING COMMENT 'The maximum NPS score (typically 6 on a 0-10 scale) for a guest response to be classified as a Detractor. Standard NPS methodology uses 0-6 as detractors.',
    `distribution_frequency` STRING COMMENT 'The frequency at which this survey is distributed: one_time (single campaign), daily, weekly, monthly, quarterly (scheduled intervals), or event_triggered (distributed based on business events).. Valid values are `one_time|daily|weekly|monthly|quarterly|event_triggered`',
    `effective_end_date` DATE COMMENT 'The date when this survey campaign ends and stops distributing to guests. Null for ongoing campaigns without a defined end date.',
    `effective_start_date` DATE COMMENT 'The date when this survey campaign becomes active and begins distribution to guests. Supports scheduled campaign launches.',
    `estimated_completion_minutes` STRING COMMENT 'The estimated time (in minutes) required for a guest to complete the entire survey. Used to set guest expectations and optimize response rates.',
    `follow_up_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic follow-up workflows (e.g., service recovery case creation for detractors, thank-you messages for promoters) are enabled for responses to this survey (True) or disabled (False).',
    `incentive_description` STRING COMMENT 'Description of the incentive offered to guests for completing the survey (e.g., 500 loyalty points, Entry into monthly prize draw, 10% discount on next stay). Null if no incentive is offered.',
    `incentive_offered_flag` BOOLEAN COMMENT 'Indicates whether an incentive (e.g., loyalty points, discount, prize entry) is offered to guests who complete this survey (True) or no incentive is provided (False).',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the primary language of the survey instrument (e.g., en for English, es for Spanish, fr for French). Multi-language surveys may have translations managed separately.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this survey instrument definition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this survey instrument record was last updated or modified.',
    `medallia_survey_code` STRING COMMENT 'The unique identifier for this survey in the Medallia experience analytics platform. Used for integration and data synchronization with the source system.',
    `multi_language_enabled_flag` BOOLEAN COMMENT 'Indicates whether this survey supports multiple language options for guests (True) or is available in a single language only (False).',
    `passive_threshold_min` STRING COMMENT 'The minimum NPS score (typically 7 on a 0-10 scale) required for a guest response to be classified as Passive. Standard NPS methodology uses 7-8 as passives.',
    `program_owner` STRING COMMENT 'The business unit, department, or individual responsible for managing and overseeing this survey campaign (e.g., Guest Experience Team, Regional Operations, Loyalty Program Management).',
    `promoter_threshold_min` STRING COMMENT 'The minimum NPS score (typically 9 on a 0-10 scale) required for a guest response to be classified as a Promoter. Standard NPS methodology uses 9-10 as promoters.',
    `property_scope` STRING COMMENT 'The geographic or organizational scope of the survey deployment: enterprise_wide (all properties), regional (specific region or market), property_specific (single property), brand_specific (specific brand within portfolio).. Valid values are `enterprise_wide|regional|property_specific|brand_specific`',
    `question_count` STRING COMMENT 'The total number of questions included in this survey instrument, including the core NPS question and any follow-up or supplementary questions.',
    `response_collection_window_hours` STRING COMMENT 'The time window (in hours) after survey distribution during which guest responses are actively collected before the survey invitation expires (e.g., 72 hours for post-checkout surveys).',
    `salt_program_linked_flag` BOOLEAN COMMENT 'Indicates whether this survey is formally linked to the enterprise SALT (Satisfaction and Loyalty Tracking) program for strategic guest experience measurement (True) or is a standalone survey (False).',
    `survey_code` STRING COMMENT 'Unique external business identifier or code for the survey instrument used for integration and reporting (e.g., NPS-POST-CO-2024Q1).',
    `survey_description` STRING COMMENT 'Detailed description of the surveys purpose, objectives, and scope. Provides context for survey administrators and analysts.',
    `survey_name` STRING COMMENT 'Business-friendly name of the NPS survey campaign or instrument (e.g., Post-Checkout NPS Q1 2024, Luxury Segment Satisfaction Survey).',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey campaign: draft (design phase), active (live and collecting responses), paused (temporarily suspended), completed (campaign ended), archived (historical record).. Valid values are `draft|active|paused|completed|archived`',
    `survey_type` STRING COMMENT 'Classification of the survey based on its purpose and timing: transactional (post-transaction), relationship (periodic guest sentiment), event_based (triggered by specific events), or periodic (scheduled intervals).. Valid values are `transactional|relationship|event_based|periodic`',
    `survey_version` STRING COMMENT 'Version identifier for the survey instrument to track design iterations and changes over time (e.g., v1.0, v2.1, 2024-Q1). Supports A/B testing and longitudinal analysis.',
    `target_response_rate_percent` DECIMAL(18,2) COMMENT 'The target response rate (as a percentage) that the survey campaign aims to achieve. Used for performance monitoring and optimization (e.g., 25.00 represents 25% target response rate).',
    `target_segment` STRING COMMENT 'The guest segment or audience targeted by this survey (e.g., Luxury Tier Loyalty Members, Business Travelers, Leisure FIT Guests, Group Event Attendees). May reference loyalty tiers, booking channels, or demographic segments.',
    `trigger_event` STRING COMMENT 'The business event or condition that triggers distribution of this survey to a guest: post_checkout (after guest checks out), post_stay (after reservation completion), post_event (after attending an event), post_fnb_visit (after F&B experience), post_spa_visit (after spa service), post_meeting (after MICE event), scheduled (time-based distribution). [ENUM-REF-CANDIDATE: post_checkout|post_stay|post_event|post_fnb_visit|post_spa_visit|post_meeting|scheduled — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_nps_survey PRIMARY KEY(`nps_survey_id`)
) COMMENT 'Master definition record for NPS (Net Promoter Score) survey instruments and campaign programs administered to guests. Manages survey design templates, question sets, distribution logic and cadence, target guest segments, trigger conditions (post-checkout, post-event, post-F&B visit, post-spa), response collection windows, and program ownership. Tracks promoter/passive/detractor classification thresholds, survey versioning, active/inactive status, and SALT (Satisfaction and Loyalty Tracking) program linkage. This is the survey INSTRUMENT and CAMPAIGN definition — individual guest responses are captured in guest_feedback with survey_type=NPS. Supports A/B testing of survey formats and channel optimization for response rate improvement.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` (
    `service_case_id` BIGINT COMMENT 'Unique identifier for the guest service recovery case. Primary key for the service case entity.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Service cases are assigned to and owned by specific departments for resolution, workload balancing, and SLA tracking. Hotels measure case resolution time by org_unit for operational performance manage',
    `channel_booking_id` BIGINT COMMENT 'Foreign key linking to channel.channel_booking. Business justification: Service recovery cases originate from bookings; tracking channel source enables identification of problematic distribution partners, supports recovery cost allocation by channel, and informs OTA partn',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Service cases originate from specific F&B outlets (restaurant complaints, room service issues, food quality problems). Required for outlet-level accountability, manager escalation, cost center allocat',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Service cases frequently originate from health/safety incidents (guest injuries, illness, property hazards). Operations require linking guest service recovery to formal incident reports for liability ',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Product-level issue tracking (all suites have faulty HVAC, deluxe rooms lack promised amenities) requires room type linkage for systemic problem identification, brand standard compliance, and portfoli',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Event-related service cases (AV failure, temperature issues, catering problems) are a major category. Event services teams require space-level case tracking for SLA compliance and space-specific issue',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Service case resolution workflows require direct member access for tier-based recovery authorization limits, points compensation rules, and VIP escalation protocols. Real process: tiered service recov',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or team currently responsible for resolving this case.',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Service cases involving guest data breaches, unauthorized access, or privacy violations must link to formal privacy incident records for GDPR/CCPA compliance, breach notification requirements, and reg',
    `profile_id` BIGINT COMMENT 'Reference to the guest who initiated or is the subject of this service case.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Service cases frequently originate from facility issues (pool closure, restaurant complaint, gym equipment failure). Maintenance teams need facility-level case tracking for work order prioritization a',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where the service case originated or is being managed.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation associated with this service case, if applicable. Nullable for cases not tied to a specific reservation.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Service cases (maintenance, housekeeping, facility complaints) require direct room linkage for work order generation, out-of-order status updates, and room-specific issue resolution tracking. Essentia',
    `tertiary_service_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the staff member who last modified the service case record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Service cases frequently involve vendor-related complaints (late delivery, quality issues, vendor staff behavior). Case management requires vendor tracking for accountability, vendor performance scori',
    `actual_resolution_hours` DECIMAL(18,2) COMMENT 'Actual elapsed time in hours from case creation to resolution. Used for SLA compliance tracking and performance analysis.',
    `case_category` STRING COMMENT 'Primary classification of the service issue. [ENUM-REF-CANDIDATE: room_quality|service_failure|billing_dispute|amenity_issue|noise_complaint|safety_concern|cleanliness|food_beverage|maintenance|staff_behavior — promote to reference product]',
    `case_description` STRING COMMENT 'Detailed narrative description of the guest complaint or service issue. Captures the full context of the problem as reported by the guest or staff.',
    `case_number` STRING COMMENT 'Externally-visible unique case identifier displayed to guests and staff. Human-readable business identifier for tracking and reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `case_origin` STRING COMMENT 'Channel through which the service case was initiated. Tracks the source of guest feedback or complaint.. Valid values are `front_desk|call_center|ota_review|social_media|survey|loyalty_desk`',
    `case_status` STRING COMMENT 'Current lifecycle status of the service case. Tracks progression through the service recovery workflow from creation to closure. [ENUM-REF-CANDIDATE: new|assigned|in_progress|pending_guest|escalated|resolved|closed — 7 candidates stripped; promote to reference product]',
    `case_subcategory` STRING COMMENT 'Detailed subcategory providing granular classification within the primary case category. Enables detailed root cause analysis.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the case was formally closed after guest confirmation or follow-up completion. Nullable for open or resolved-but-not-closed cases.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation total value.. Valid values are `^[A-Z]{3}$`',
    `compensation_total_value` DECIMAL(18,2) COMMENT 'Total monetary value of all compensation provided to the guest for service recovery, including refunds, credits, upgrades, and amenities. Expressed in property local currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service case record was first created in the system. Represents the business event timestamp for case initiation.',
    `escalation_status` STRING COMMENT 'Indicates whether and to what level the case has been escalated beyond the initial assigned owner.. Valid values are `not_escalated|escalated_to_manager|escalated_to_gm|escalated_to_corporate`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the case was escalated to a higher authority level. Nullable if never escalated.',
    `follow_up_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the required follow-up with the guest was completed. Nullable if no follow-up was required or not yet completed.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up with the guest is required after initial resolution. True if follow-up is needed, False otherwise.',
    `grr_outcome_flag` BOOLEAN COMMENT 'Indicates whether the guest was successfully recovered (satisfied with resolution). True if guest expressed satisfaction post-resolution, False otherwise. Used to calculate GRR KPI.',
    `guest_lifetime_value_segment` STRING COMMENT 'Lifetime value segment classification of the guest at case creation. Used to prioritize high-value guest recovery efforts.. Valid values are `high|medium|low`',
    `guest_satisfaction_post_resolution` STRING COMMENT 'Guest satisfaction score collected after case resolution, typically on a 1-5 or 1-10 scale. Nullable if guest did not provide feedback.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service case record was last updated. Used for audit trail and change tracking.',
    `nps_post_resolution` STRING COMMENT 'Net Promoter Score collected after case resolution, on a 0-10 scale. Nullable if guest did not provide NPS feedback.',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the service failure could have been prevented through better processes, training, or systems. Used for operational improvement analysis.',
    `priority_level` STRING COMMENT 'Urgency classification for case resolution. P1 (Critical - immediate safety/security), P2 (High - significant guest impact), P3 (Medium - moderate impact), P4 (Low - minor inconvenience).. Valid values are `P1|P2|P3|P4`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the actions taken to resolve the case, including staff interactions, compensation provided, and guest response.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the case was marked as resolved. Nullable for open cases.',
    `resolution_type` STRING COMMENT 'Primary method used to resolve the guest service case. Tracks the recovery action category.. Valid values are `compensation|apology|service_recovery|refund|upgrade|points_credit`',
    `root_cause` STRING COMMENT 'Identified underlying cause of the service failure. Used for trend analysis and process improvement initiatives.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the case was resolved within the defined SLA timeframe for its priority level. True if compliant, False if SLA was breached.',
    `sla_target_hours` STRING COMMENT 'Target number of hours for case resolution based on priority level. Used to calculate SLA compliance.',
    `social_media_mention_flag` BOOLEAN COMMENT 'Indicates whether the guest mentioned or threatened to mention the issue on social media platforms. True if social media risk identified, False otherwise.',
    `source_system_case_code` STRING COMMENT 'Original case identifier from the source operational system. Used for data lineage and reconciliation with source systems.',
    CONSTRAINT pk_service_case PRIMARY KEY(`service_case_id`)
) COMMENT 'Authoritative transactional record for guest service recovery cases and complaint management, sourced from Salesforce CRM Case Management module. Captures case origin (front desk, call center, OTA review, social media, survey, loyalty desk), case category (room quality, service failure, billing dispute, amenity issue, noise complaint, safety concern), priority level (P1-P4), assigned owner, current status, escalation status, resolution type, resolution timestamp, GRR (Guest Recovery Rate) outcome tracking, compensation total value, SLA compliance flag, and guest satisfaction post-resolution. Manages the full service recovery workflow from case creation through activity logging, escalation (tracked in case_activity), recovery action execution, resolution, and guest follow-up. Parent record for case_activity and service_recovery_action.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` (
    `case_activity_id` BIGINT COMMENT 'Unique identifier for the case activity record. Primary key for the case activity log.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Case activities involve outlet-specific actions (manager follow-up, chef consultation, meal replacement). Tracks which F&B location handled recovery activity, essential for outlet performance metrics,',
    `guest_feedback_id` BIGINT COMMENT 'Foreign key linking to experience.guest_feedback. Business justification: Case activities can be triggered by guest feedback submissions requiring service recovery. When feedback indicates complaint or low satisfaction, a case activity may be created to address it. This FK ',
    `online_review_id` BIGINT COMMENT 'Foreign key linking to experience.online_review. Business justification: Case activities can be triggered by online reviews requiring management response or service recovery. When a negative review is published, case activity tracks the response actions. This FK links the ',
    `employee_id` BIGINT COMMENT 'Reference to the employee or agent responsible for performing or logging this activity. Supports accountability and performance tracking.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile associated with the service case. Links activity to guest history and loyalty program.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Case activities document facility-specific actions (inspected pool, tested gym equipment, visited restaurant). Root cause analysis requires facility context to identify systemic issues. Real business ',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where the activity took place. Supports multi-property operations and location-based analysis.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Case activities (room inspections, follow-up visits, maintenance verification) require room linkage to document which specific unit was inspected/serviced. Critical for audit trail of room-specific se',
    `service_case_id` BIGINT COMMENT 'Reference to the parent service recovery case that this activity belongs to. Links activity to the case lifecycle.',
    `activity_description` STRING COMMENT 'Detailed narrative of the activity, actions taken, observations, or communications. Provides full context for audit trail and service recovery analysis.',
    `activity_number` STRING COMMENT 'Business-facing unique identifier for the activity. Used for tracking and reference in communications.',
    `activity_status` STRING COMMENT 'Current state of the activity within its lifecycle. Tracks completion and workflow progression.. Valid values are `pending|completed|cancelled|deferred`',
    `activity_subject` STRING COMMENT 'Brief summary or title of the activity. Provides quick context for the action taken.',
    `activity_timestamp` TIMESTAMP COMMENT 'Date and time when the activity occurred or was logged. Primary event timestamp for chronological sequencing and SLA (Service Level Agreement) tracking.',
    `activity_type` STRING COMMENT 'Classification of the activity action taken within the service case. Determines workflow and required fields. [ENUM-REF-CANDIDATE: note|email|call|escalation|resolution|compensation|guest_follow_up|internal_review|manager_approval — 9 candidates stripped; promote to reference product]',
    `agent_name` STRING COMMENT 'Full name of the agent or employee who performed the activity. Denormalized for reporting convenience.',
    `attachment_count` STRING COMMENT 'Number of files or documents attached to this activity (e.g., photos, receipts, correspondence). Supports evidence tracking and documentation completeness.',
    `communication_channel` STRING COMMENT 'Medium through which the activity or communication occurred. Supports channel preference analysis and omnichannel service tracking. [ENUM-REF-CANDIDATE: phone|email|in_person|sms|chat|social_media|mobile_app — 7 candidates stripped; promote to reference product]',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation value. Supports multi-currency operations and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `compensation_offered_flag` BOOLEAN COMMENT 'Indicates whether compensation or amenity was offered to the guest during this activity. Supports compensation tracking and GRR (Guest Recovery Rate) analysis.',
    `compensation_type` STRING COMMENT 'Category of compensation or recovery gesture offered. Populated when compensation_offered_flag is true. Supports compensation strategy analysis. [ENUM-REF-CANDIDATE: room_upgrade|discount|refund|loyalty_points|amenity|complimentary_service|future_credit — 7 candidates stripped; promote to reference product]',
    `compensation_value` DECIMAL(18,2) COMMENT 'Monetary value of the compensation offered. Populated when compensation_offered_flag is true. Used for service recovery cost tracking and ROI (Return on Investment) analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this activity record was first created in the source system. Supports audit trail and data lineage tracking.',
    `department_code` STRING COMMENT 'Code identifying the department or functional area responsible for the activity (e.g., front desk, housekeeping, F&B (Food and Beverage), guest services).',
    `duration_minutes` STRING COMMENT 'Length of time spent on the activity in minutes. Used for agent productivity analysis and workload management.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this activity represents an escalation to higher authority. Used for escalation frequency monitoring and GRR (Guest Recovery Rate) compliance.',
    `escalation_level` STRING COMMENT 'Authority level to which the case was escalated. Populated when activity_type is escalation. Tracks escalation hierarchy and decision-making authority.. Valid values are `supervisor|manager|director|regional|corporate`',
    `escalation_reason` STRING COMMENT 'Explanation for why the case was escalated. Populated when activity_type is escalation. Supports root cause analysis of escalation patterns.',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up action should be completed. Populated when follow_up_required_flag is true. Supports task scheduling and accountability.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action is needed after this activity. Used for task management and ensuring closure.',
    `guest_communication_flag` BOOLEAN COMMENT 'Indicates whether this activity involved direct communication with the guest. Used for tracking guest touchpoints and engagement frequency.',
    `guest_sentiment` STRING COMMENT 'Assessed emotional tone or satisfaction level of the guest during this activity. Supports sentiment tracking and early warning for escalation risk.. Valid values are `very_negative|negative|neutral|positive|very_positive`',
    `internal_notes` STRING COMMENT 'Confidential notes for internal use only, not shared with the guest. Supports team collaboration and knowledge transfer.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this activity record was last updated in the source system. Supports change tracking and data freshness monitoring.',
    `outcome` STRING COMMENT 'Result or conclusion of the activity. Captures resolution status, guest response, or next steps required.',
    `priority` STRING COMMENT 'Urgency level assigned to the activity. Influences workflow sequencing and resource allocation.. Valid values are `low|medium|high|urgent`',
    `resolution_commitment` STRING COMMENT 'Specific commitment or promise made to the guest during this activity. Tracks service recovery pledges and follow-through requirements.',
    `resolution_deadline` TIMESTAMP COMMENT 'Target date and time by which the committed resolution must be delivered. Used for SLA (Service Level Agreement) milestone tracking and escalation monitoring.',
    `sla_milestone_flag` BOOLEAN COMMENT 'Indicates whether this activity represents a key SLA (Service Level Agreement) milestone (e.g., first response, resolution). Used for compliance tracking and performance measurement.',
    `sla_milestone_type` STRING COMMENT 'Classification of the SLA (Service Level Agreement) milestone achieved. Populated when sla_milestone_flag is true. Supports detailed SLA (Service Level Agreement) performance analysis.. Valid values are `first_response|acknowledgment|resolution|follow_up|closure`',
    `source_record_reference` STRING COMMENT 'Unique identifier of the activity record in the source system. Enables traceability and reconciliation with operational systems.',
    CONSTRAINT pk_case_activity PRIMARY KEY(`case_activity_id`)
) COMMENT 'Chronological activity log for service recovery cases tracking all actions, communications, escalations, and status transitions within a service_case lifecycle. Captures activity type (note, email, call, escalation, resolution, compensation, guest follow-up), activity timestamp, agent or department responsible, guest communication flag, outcome, and escalation-specific fields (escalation reason, recipient authority level, resolution commitment, resolution deadline) when activity_type is escalation. Enables full audit trail of service recovery workflows, SLA milestone tracking, and escalation frequency monitoring. Sourced from Salesforce CRM activity timeline. Supports GRR compliance reporting through escalation path visibility.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` (
    `service_recovery_action_id` BIGINT COMMENT 'Unique identifier for the service recovery action record. Primary key.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Service recovery actions (compensation, upgrades, refunds) often require formal corrective action tracking for quality assurance, root cause analysis, and compliance with brand standards. Links guest-',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Recovery actions (comped meals, F&B vouchers, wine bottles) are fulfilled at specific outlets. Required for cost center tracking, outlet P&L impact, inventory reconciliation, and measuring recovery ef',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Room upgrades (most common recovery action) require room type linkage to track upgrade paths, calculate displacement cost, verify upgrade eligibility, and measure recovery effectiveness by room type t',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Service recovery actions often award loyalty points as compensation. This FK enables proper tracking of points awarded, updates to member balance, and audit trail. The loyalty_points_awarded column be',
    `employee_id` BIGINT COMMENT 'Reference to the employee who authorized the service recovery action.',
    `profile_id` BIGINT COMMENT 'Reference to the guest receiving the service recovery action.',
    `property_id` BIGINT COMMENT 'Reference to the property where the service recovery action was authorized and fulfilled.',
    `reputation_alert_id` BIGINT COMMENT 'Foreign key linking to experience.reputation_alert. Business justification: Service recovery actions can be triggered by reputation alerts (e.g., alert fires when NPS score breaches threshold, recovery action is initiated to address the issue). This FK tracks the alert that p',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation associated with this recovery action, if applicable.',
    `service_case_id` BIGINT COMMENT 'Reference to the originating service case that triggered this recovery action. Links to the complaint or service issue being resolved.',
    `tertiary_service_created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created the service recovery action record in the system.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Recovery actions often involve vendor-provided amenities (spa treatments, restaurant credits, transportation services). Tracking vendor enables accurate cost allocation, vendor performance assessment,',
    `action_description` STRING COMMENT 'Detailed description of the specific service recovery action taken, including any customization or personalization for the guest.',
    `action_number` STRING COMMENT 'Business-facing unique identifier for the service recovery action, used for tracking and reference in guest communications and internal reporting.. Valid values are `^SRA-[0-9]{8,12}$`',
    `authorization_level` STRING COMMENT 'Level of management authorization required and obtained for this recovery action. Reflects the escalation tier based on recovery value and type.. Valid values are `front_desk|supervisor|manager|general_manager|regional_director`',
    `authorized_timestamp` TIMESTAMP COMMENT 'Date and time when the service recovery action was authorized by the responsible manager or employee.',
    `communication_channel` STRING COMMENT 'Channel through which the service recovery action was communicated and delivered to the guest.. Valid values are `in_person|phone|email|sms|mobile_app|letter`',
    `cost_center_code` STRING COMMENT 'Cost center code to which the recovery action cost is allocated for financial reporting and Gross Operating Profit (GOP) analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service recovery action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value of the recovery action.. Valid values are `^[A-Z]{3}$`',
    `follow_up_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the follow-up action with the guest was completed, if applicable.',
    `follow_up_required` BOOLEAN COMMENT 'Boolean flag indicating whether additional follow-up with the guest is required after the initial recovery action.',
    `fulfillment_notes` STRING COMMENT 'Free-text notes documenting the fulfillment process, guest reaction, or any special circumstances related to the delivery of the recovery action.',
    `fulfillment_status` STRING COMMENT 'Current status of the service recovery action fulfillment. Tracks whether the action has been completed, is in progress, or was cancelled.. Valid values are `pending|in_progress|fulfilled|cancelled|declined`',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Date and time when the service recovery action was successfully fulfilled and delivered to the guest.',
    `gl_account_code` STRING COMMENT 'General Ledger account code used to record the financial impact of the service recovery action in the accounting system.',
    `guest_acceptance_status` STRING COMMENT 'Indicates whether the guest accepted, declined, or has not yet responded to the service recovery action offer.. Valid values are `accepted|declined|pending`',
    `is_proactive` BOOLEAN COMMENT 'Boolean flag indicating whether the recovery action was proactively offered by the property before the guest complained (True) or was reactive in response to a complaint (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service recovery action record was last updated or modified.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Monetary value of the service recovery action in the propertys local currency. Represents the cost or value of the compensation extended to the guest.',
    `post_recovery_gss_score` STRING COMMENT 'Guest Satisfaction Score (GSS) collected after the service recovery action. Measures guest satisfaction with the recovery process and outcome.',
    `post_recovery_nps_score` STRING COMMENT 'Net Promoter Score (NPS) collected from the guest after the service recovery action was delivered. Measures the impact of recovery on guest loyalty.',
    `reason_code` STRING COMMENT 'Standardized code indicating the primary reason or root cause that necessitated the service recovery action. [ENUM-REF-CANDIDATE: room_issue|service_delay|billing_error|amenity_failure|staff_behavior|cleanliness|noise|maintenance|overbooking|food_quality|safety_concern|other — promote to reference product]',
    `recovery_action_category` STRING COMMENT 'High-level category of the recovery action: monetary compensation, non-monetary benefit, experiential enhancement, or recognition/apology.. Valid values are `monetary|non_monetary|experiential|recognition`',
    `recovery_action_type` STRING COMMENT 'Type of service recovery action extended to the guest. Includes room upgrade, complimentary night, Food and Beverage (F&B) credit, loyalty points award, amenity delivery, or written apology.. Valid values are `room_upgrade|complimentary_night|fnb_credit|loyalty_points_award|amenity_delivery|written_apology`',
    `recovery_effectiveness_score` STRING COMMENT 'Numerical score (1-10) indicating the effectiveness of the recovery action based on guest feedback or follow-up survey responses. Used for Guest Recovery Rate (GRR) analysis.',
    CONSTRAINT pk_service_recovery_action PRIMARY KEY(`service_recovery_action_id`)
) COMMENT 'Records specific service recovery actions and compensations extended to guests as part of GRR (Guest Recovery Rate) management. Captures recovery action type (room upgrade, complimentary night, F&B credit, loyalty points award, amenity delivery, written apology), monetary value of recovery, authorization level required, fulfillment status, fulfillment timestamp, and linkage to the originating service_case. Enables tracking of recovery cost, recovery effectiveness, and GRR KPI reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` (
    `experience_special_request_id` BIGINT COMMENT 'Unique identifier for the guest special request record. Primary key.',
    `ada_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_assessment. Business justification: Special requests for accessibility accommodations (wheelchair access, visual/hearing aids, room modifications) directly inform ADA assessment requirements and barrier remediation tracking. Essential f',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Special dining requests (dietary accommodations, celebration cakes, private dining, wine pairings) are fulfilled by specific outlets. Essential for operational fulfillment tracking, outlet workload pl',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who submitted the special request. Links to the guest master record.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Room type preference requests (upgrade to suite, ocean view room) require room type linkage for inventory availability checking, upgrade eligibility verification, and tracking demand patterns by room ',
    `service_case_id` BIGINT COMMENT 'Reference to a service recovery case if the special request is part of a guest complaint resolution or service recovery workflow. Links to Salesforce CRM case management.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member assigned to fulfill the request. Links to the workforce employee record responsible for execution.',
    `property_id` BIGINT COMMENT 'Reference to the property where the special request is to be fulfilled. Links to the property master record.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation associated with this special request. Links to the reservation under which the request was submitted.',
    `reservation_special_request_id` BIGINT COMMENT 'add column reservation_special_request_id (BIGINT) with FK to reservation.reservation_special_request.reservation_special_request_id - experience special requests are derived from reservation special requests.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Room-specific requests (extra pillows, temperature adjustment, connecting room setup) require room linkage for fulfillment routing to housekeeping/maintenance, tracking repeat requests by unit, and id',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred by the property for fulfilling the special request. Captured post-fulfillment for financial analysis and service cost management.',
    `actual_fulfillment_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was actually completed and delivered to the guest. Used to measure fulfillment timeliness and service performance.',
    `advance_notice_hours` STRING COMMENT 'Number of hours of advance notice required for this request type. Defines the minimum lead time needed for successful fulfillment.',
    `assigned_department` STRING COMMENT 'The operational department responsible for fulfilling the special request. Determines routing and accountability for execution. [ENUM-REF-CANDIDATE: front_desk|housekeeping|concierge|food_beverage|maintenance|spa|transportation|guest_services|events — 9 candidates stripped; promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Explanation for why the special request was cancelled or declined. Captures the business rationale for non-fulfillment.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was cancelled. Applicable when guest withdraws the request or property declines fulfillment.',
    `charge_to_guest_amount` DECIMAL(18,2) COMMENT 'Amount charged to the guest folio for the special request fulfillment. Zero if the request is complimentary or included in the rate.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this special request record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with the special request. Defines the currency context for cost and charge amounts.. Valid values are `^[A-Z]{3}$`',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated cost to the property for fulfilling the special request. Used for budgeting and cost tracking of guest service delivery.',
    `fulfillment_deadline_timestamp` TIMESTAMP COMMENT 'Target date and time by which the special request must be fulfilled. Defines the service level agreement commitment for the request.',
    `fulfillment_location` STRING COMMENT 'Specific location within the property where the request is to be fulfilled. May reference room number, venue name, or facility area.',
    `fulfillment_notes` STRING COMMENT 'Staff notes documenting the fulfillment process, actions taken, and any special circumstances. Provides operational context and audit trail.',
    `guest_feedback_comment` STRING COMMENT 'Free-text feedback provided by the guest regarding the special request fulfillment experience. Captures qualitative satisfaction data.',
    `guest_satisfaction_rating` STRING COMMENT 'Guest-provided satisfaction score for the special request fulfillment. Typically on a 1-5 or 1-10 scale. Used to measure request fulfillment quality.',
    `is_complimentary` BOOLEAN COMMENT 'Indicates whether the special request fulfillment was provided as a complimentary service with no charge to the guest. Used for service recovery and loyalty gestures.',
    `is_loyalty_member_request` BOOLEAN COMMENT 'Indicates whether the special request was submitted by a loyalty program member. Used to track and prioritize requests from program participants.',
    `is_repeat_request` BOOLEAN COMMENT 'Indicates whether this is a recurring request from the guest based on historical preference data. Used to identify guest patterns and preferences.',
    `is_service_recovery` BOOLEAN COMMENT 'Indicates whether the special request is part of a service recovery action to address a guest complaint or service failure. Used to track recovery effectiveness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this special request record was last updated. Audit trail for change tracking and data currency.',
    `loyalty_tier` STRING COMMENT 'The loyalty program tier level of the guest at the time of request submission. Influences priority and fulfillment standards.. Valid values are `standard|silver|gold|platinum|diamond`',
    `priority_level` STRING COMMENT 'Priority classification for fulfillment sequencing. Determines the urgency and resource allocation for the request based on guest status and request nature.. Valid values are `low|medium|high|urgent|vip`',
    `request_acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was acknowledged by staff. Marks the transition from pending to active processing.',
    `request_description` STRING COMMENT 'Detailed free-text description of the special request as submitted by the guest or captured by staff. Contains the full context and specifics of the guest need.',
    `request_number` STRING COMMENT 'Business identifier for the special request. Human-readable unique reference number used for tracking and communication with guests and staff.. Valid values are `^SR-[0-9]{8,12}$`',
    `request_source` STRING COMMENT 'The channel or interface through which the special request was submitted. Tracks the origin point of the guest request. [ENUM-REF-CANDIDATE: reservation_system|guest_app|front_desk|concierge|loyalty_program|call_center|email|website|ota_channel — 9 candidates stripped; promote to reference product]',
    `request_status` STRING COMMENT 'Current lifecycle status of the special request. Tracks the request from submission through fulfillment or closure. [ENUM-REF-CANDIDATE: pending|acknowledged|assigned|in_progress|fulfilled|partially_fulfilled|cancelled|declined|expired — 9 candidates stripped; promote to reference product]',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was originally submitted by the guest or entered into the system. Principal business event timestamp for the request lifecycle.',
    `request_subtype` STRING COMMENT 'Detailed subcategory of the request type. Provides granular classification for specific request variations within the primary type.',
    `request_type` STRING COMMENT 'Classification of the special request by category. Defines the nature of the guest need or preference being requested. [ENUM-REF-CANDIDATE: room_preference|accessibility_need|dietary_requirement|celebration_setup|early_checkin|late_checkout|amenity_delivery|pillow_menu|transportation|spa_booking|childcare|pet_accommodation — 12 candidates stripped; promote to reference product]',
    `requires_advance_notice_flag` BOOLEAN COMMENT 'Indicates whether the request type requires advance notice for fulfillment. Used to manage guest expectations and operational planning.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this special request in the source operational system. Enables traceability back to the system of record.',
    `special_instructions` STRING COMMENT 'Additional instructions or special handling requirements for fulfilling the request. Captures nuanced guest preferences and operational guidance.',
    CONSTRAINT pk_experience_special_request PRIMARY KEY(`experience_special_request_id`)
) COMMENT 'Single source of truth is reservation.reservation_special_request. Master record for guest special requests submitted at booking, pre-arrival, or during stay. Captures request type (room preference, accessibility need, dietary requirement, celebration setup, early check-in, late checkout, amenity delivery, pillow menu, transportation), request source (reservation system, guest app, front desk, concierge, loyalty program), fulfillment status, assigned department, fulfillment deadline, actual fulfillment timestamp, and guest satisfaction outcome. Integrates with OPERA PMS guest profile and reservation data. Tracks request fulfillment rate as a key experience KPI. Distinct from amenity_fulfillment which tracks the physical delivery execution of amenity items — special_request captures the guests intent and fulfillment lifecycle at a higher level. SSOT: defers to reservation.reservation_special_request (MVM).reservation_special_request as single source of truth] [SSOT:special_request] Canonical single-source-of-truth for the special_request concept; other domain variants are domain-specific specializations referencing this owner. SSOT: defers to canonical reservation.reservation_special_request (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` (
    `amenity_fulfillment_id` BIGINT COMMENT 'Unique identifier for the amenity fulfillment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Amenity costs (both complimentary and charged) must be tracked by department cost center for expense allocation, budget variance analysis, and departmental P&L reporting. Essential for USALI departmen',
    `employee_id` BIGINT COMMENT 'Reference to the staff member (housekeeping, concierge, or room service) who delivered the amenity.',
    `experience_special_request_id` BIGINT COMMENT 'Foreign key linking to experience.experience_special_request. Business justification: Amenity fulfillments often originate from guest special requests (e.g., champagne on arrival, extra pillows, dietary accommodations). This FK links the fulfillment record to the originating request, e',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: F&B amenities (welcome drinks, birthday cakes, fruit baskets, minibar items) are prepared/delivered by specific outlets. Required for cost allocation, outlet workload tracking, inventory reconciliatio',
    `food_safety_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.food_safety_cert. Business justification: Amenity fulfillment involving food/beverage items (welcome amenities, in-room dining, special dietary requests) must reference food safety certifications for compliance verification, allergen tracking',
    `guest_experience_enrollment_id` BIGINT COMMENT 'Foreign key linking to experience.guest_experience_enrollment. Business justification: Amenities can be delivered as part of experience program enrollment (e.g., SALT program includes welcome amenity package, spa program includes in-room amenities). This FK links amenity delivery to the',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile receiving the amenity.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Amenity transactions require GL account posting for revenue recognition (charged amenities) or expense recognition (complimentary). Critical for daily revenue posting, financial statement accuracy, an',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Amenities are delivered to or consumed at facilities (spa treatment, pool cabana reservation, restaurant booking). Fulfillment tracking requires facility location for logistics coordination and facili',
    `property_id` BIGINT COMMENT 'Reference to the property where the amenity is being fulfilled.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation associated with this amenity fulfillment.',
    `room_amenity_id` BIGINT COMMENT 'Foreign key linking to inventory.room_amenity. Business justification: Links guest amenity consumption to inventory amenity records for tracking usage rates, replenishment scheduling, cost allocation, and identifying missing/damaged amenities. Essential for amenity inven',
    `service_recovery_action_id` BIGINT COMMENT 'Foreign key linking to experience.service_recovery_action. Business justification: Amenity fulfillments are often part of service recovery actions (e.g., complimentary champagne after a complaint, upgraded amenities as compensation). This FK links the fulfillment to the service reco',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or supplier who provided the amenity item, if sourced externally.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time when the amenity was delivered to the guest room.',
    `amenity_category` STRING COMMENT 'Classification of the amenity by purpose or program type. [ENUM-REF-CANDIDATE: welcome_gift|vip_package|loyalty_benefit|celebration_package|special_occasion|room_upgrade_amenity|complimentary_service — 7 candidates stripped; promote to reference product]',
    `amenity_code` STRING COMMENT 'Standardized code identifying the type of amenity (e.g., WINE_CHEESE, FRUIT_BASKET, FLOWERS, CHAMPAGNE, CHOCOLATE, WELCOME_KIT).',
    `amenity_description` STRING COMMENT 'Detailed description of the amenity contents and presentation.',
    `amenity_name` STRING COMMENT 'Human-readable name of the amenity item or package.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the amenity fulfillment was cancelled.',
    `cancelled_by` STRING COMMENT 'Name or identifier of the person who cancelled the amenity fulfillment.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the amenity fulfillment was cancelled.',
    `charge_posted_flag` BOOLEAN COMMENT 'Indicates whether a charge for the amenity has been posted to the guest folio (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the amenity fulfillment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_agent_name` STRING COMMENT 'Name of the staff member who delivered the amenity.',
    `delivery_method` STRING COMMENT 'The method or service channel used to deliver the amenity to the guest.. Valid values are `pre_arrival_setup|in_room_delivery|concierge_handoff|turndown_service|check_in_delivery`',
    `dietary_restrictions` STRING COMMENT 'Any dietary restrictions or allergies to consider for food and beverage amenities.',
    `folio_reference` STRING COMMENT 'Reference to the guest folio where the amenity charge was posted, if applicable.',
    `fulfillment_status` STRING COMMENT 'Current status of the amenity fulfillment workflow.. Valid values are `pending|scheduled|in_progress|delivered|cancelled|failed`',
    `guest_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the guest acknowledged receipt of the amenity (True/False).',
    `guest_acknowledgment_timestamp` TIMESTAMP COMMENT 'The date and time when the guest acknowledged receipt of the amenity.',
    `guest_feedback` STRING COMMENT 'Free-text feedback or comments provided by the guest regarding the amenity.',
    `guest_satisfaction_score` STRING COMMENT 'Numeric satisfaction score provided by the guest for the amenity experience, typically on a scale of 1-5 or 1-10.',
    `is_complimentary` BOOLEAN COMMENT 'Indicates whether the amenity was provided complimentary (True) or charged to the guest (False).',
    `last_modified_by` STRING COMMENT 'User or system identifier of the person or process that last modified the amenity fulfillment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the amenity fulfillment record was last updated.',
    `loyalty_tier` STRING COMMENT 'The guests loyalty program tier at the time of amenity fulfillment (e.g., Silver, Gold, Platinum, Diamond).',
    `occasion_type` STRING COMMENT 'The special occasion or reason for the amenity delivery, if applicable. [ENUM-REF-CANDIDATE: birthday|anniversary|honeymoon|business_milestone|vip_visit|apology|none — 7 candidates stripped; promote to reference product]',
    `quantity` STRING COMMENT 'Number of units or servings of the amenity to be delivered.',
    `room_number` STRING COMMENT 'The room number where the amenity is to be delivered.',
    `scheduled_delivery_date` DATE COMMENT 'The date on which the amenity is scheduled to be delivered.',
    `scheduled_delivery_time` TIMESTAMP COMMENT 'The precise date and time when the amenity is scheduled to be delivered to the guest room.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the amenity fulfillment (quantity × unit cost) in the propertys local currency.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the amenity item in the propertys local currency.',
    `created_by` STRING COMMENT 'User or system identifier of the person or process that created the amenity fulfillment record.',
    CONSTRAINT pk_amenity_fulfillment PRIMARY KEY(`amenity_fulfillment_id`)
) COMMENT 'Operational record tracking the delivery and fulfillment of in-room amenities, welcome gifts, and curated guest experience packages. Captures amenity type, quantity, delivery location (room number), scheduled delivery time, actual delivery time, delivery agent, fulfillment status, cost, and guest acknowledgment. Supports pre-arrival amenity programs, VIP welcome setups, loyalty elite benefit fulfillment, and celebration packages. Distinct from special_request as amenity_fulfillment tracks the physical delivery execution.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` (
    `guest_interaction_id` BIGINT COMMENT 'Unique identifier for each guest interaction touchpoint record. Primary key for the guest_interaction data product.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Guest interactions at F&B venues (sommelier consultations, chef table visits, dietary consultations, service recovery conversations) occur at specific outlets. Essential for touchpoint mapping, outlet',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Interaction analysis by room type (suite guests require more concierge service, economy rooms have more maintenance calls) enables product-level service design, staffing allocation, and identifying ro',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Front desk, concierge, and service staff interactions require real-time loyalty tier visibility for benefit fulfillment (upgrades, late checkout), personalized greetings, and service level differentia',
    `employee_id` BIGINT COMMENT 'Reference to the employee who conducted the interaction. Enables staff engagement scoring and service quality attribution.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who participated in this interaction. Links to the guest master data product.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Guest interactions occur at specific facilities (concierge desk, restaurant host stand, spa reception). Interaction analytics require facility-level segmentation for staffing optimization and service ',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where the interaction occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation associated with this interaction, if applicable. Null for non-stay interactions.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Guest interactions (in-room service calls, facility inquiries, room issue reports) require room linkage for context documentation, issue pattern identification by unit, and tracking interaction freque',
    `service_case_id` BIGINT COMMENT 'Reference to a formal service recovery case if this interaction escalated to case management. Null for interactions that did not escalate.',
    `tertiary_guest_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the staff member or system user who last modified this interaction record.',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Guest interactions occur at specific touchpoints in the guest journey (pre-arrival, check-in, in-stay, checkout, post-stay). Linking interaction to touchpoint enables journey analytics and touchpoint ',
    `amenity_description` STRING COMMENT 'Description of the amenity or gesture offered, if applicable. Null if no amenity was provided.',
    `amenity_offered_flag` BOOLEAN COMMENT 'Boolean indicator of whether a complimentary amenity or service recovery gesture was offered during this interaction.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this interaction record was first created in the source system. Used for audit trail and data lineage.',
    `department_code` STRING COMMENT 'Code identifying the hotel department responsible for the interaction (e.g., FD for Front Desk, CONC for Concierge, HSK for Housekeeping, FB for Food and Beverage).. Valid values are `^[A-Z]{2,6}$`',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up action should be completed. Null if no follow-up is required.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this interaction requires subsequent follow-up action by staff or management.',
    `guest_initiated_flag` BOOLEAN COMMENT 'Boolean indicator of whether the interaction was initiated by the guest (true) or proactively by staff (false). Distinguishes reactive vs proactive service.',
    `guest_satisfaction_rating` STRING COMMENT 'Immediate satisfaction rating provided by the guest at the conclusion of the interaction, typically on a 1-5 or 1-10 scale. Null if not collected.',
    `interaction_duration_minutes` STRING COMMENT 'Length of the interaction in minutes. Used for staff productivity analysis and service quality assessment.',
    `interaction_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language used during the interaction.. Valid values are `^[A-Z]{3}$`',
    `interaction_location` STRING COMMENT 'Specific location within the property where the interaction occurred (e.g., Front Desk, Lobby, Guest Room 305, Pool Area).',
    `interaction_notes` STRING COMMENT 'Detailed narrative notes captured by staff describing the interaction content, guest requests, and any commitments made. Confidential business information.',
    `interaction_number` STRING COMMENT 'Human-readable business identifier for the interaction, used for tracking and reference in service recovery workflows.. Valid values are `^INT-[0-9]{10}$`',
    `interaction_outcome` STRING COMMENT 'The result or disposition of the interaction at the time of logging. Indicates whether the guest need was addressed or requires follow-up.. Valid values are `resolved|escalated|pending|referred|acknowledged|no_action_required`',
    `interaction_source_system` STRING COMMENT 'The operational system that originally captured this interaction record. Used for data lineage and quality assessment.. Valid values are `OPERA|SALESFORCE|MEDALLIA|MOBILE_APP|KIOSK|OTHER`',
    `interaction_subject` STRING COMMENT 'Brief summary or subject line describing the interaction topic. Used for quick reference and categorization.',
    `interaction_timestamp` TIMESTAMP COMMENT 'The date and time when the interaction occurred in the property local timezone. Primary business event timestamp for journey sequencing and touchpoint analysis.',
    `interaction_type` STRING COMMENT 'Classification of the interaction based on its primary purpose and nature. Enables journey mapping and touchpoint analysis. [ENUM-REF-CANDIDATE: check_in_greeting|check_out_farewell|concierge_inquiry|complaint|compliment|service_request|loyalty_recognition|proactive_outreach|room_visit|amenity_delivery|special_occasion_recognition|upsell_offer|feedback_solicitation|emergency_response|vip_welcome|other — promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this interaction record was last updated in the source system. Used for change tracking and audit trail.',
    `nps_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this interaction is eligible for inclusion in Net Promoter Score survey sampling.',
    `sentiment_classification` STRING COMMENT 'Assessed sentiment or emotional tone of the interaction, either manually classified by staff or automatically derived from text analytics.. Valid values are `very_positive|positive|neutral|negative|very_negative|not_assessed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment score ranging from -100 (very negative) to +100 (very positive). Derived from natural language processing or manual assessment.',
    `special_request_fulfilled_flag` BOOLEAN COMMENT 'Boolean indicator of whether a special request made during this interaction was successfully fulfilled.',
    `vip_status_flag` BOOLEAN COMMENT 'Boolean indicator of whether the guest was flagged as VIP at the time of interaction. Used for personalized service tracking.',
    CONSTRAINT pk_guest_interaction PRIMARY KEY(`guest_interaction_id`)
) COMMENT 'Record of all meaningful touchpoint interactions between hotel staff and guests during a stay or engagement, sourced from Salesforce CRM and OPERA PMS. Captures interaction type (check-in greeting, concierge inquiry, complaint, compliment, service request, loyalty recognition, proactive outreach), interaction channel (in-person, phone, chat, app, SMS), department, staff member, interaction timestamp, sentiment classification, outcome, and follow-up required flag. Enables guest journey mapping, personalization of future stays, and identification of service recovery opportunities before they escalate to formal cases. Feeds experience analytics for staff engagement scoring and touchpoint optimization.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the experience program. Primary key.',
    `property_id` BIGINT COMMENT 'FK connection added per structural fix',
    `amenity_package_code` STRING COMMENT 'Reference code linking to the standard amenity package associated with this experience program.',
    `benefits_summary` STRING COMMENT 'Summary of benefits, amenities, and services included in the experience program offering.',
    `blackout_dates` STRING COMMENT 'Comma-separated list of date ranges when this experience program is not available (e.g., peak holiday periods).',
    `booking_window_days` STRING COMMENT 'Number of days in advance that guests must book to be eligible for this experience program. Null indicates no advance booking requirement.',
    `program_category` STRING COMMENT 'Broader business category grouping for the experience program used for reporting and analytics.. Valid values are `Guest Recognition|Service Recovery|Loyalty Enhancement|Special Occasion|Wellness|Food and Beverage`',
    `program_code` STRING COMMENT 'Unique business identifier code for the experience program used across systems and communications.. Valid values are `^[A-Z0-9]{6,12}$`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program cost estimate.. Valid values are `^[A-Z]{3}$`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost per guest enrollment for delivering this experience program including amenities, services, and operational costs.',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created this experience program record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this experience program record was first created in the system.',
    `csat_target_score` DECIMAL(18,2) COMMENT 'Target CSAT score that this experience program aims to achieve. CSAT is a standard satisfaction measurement.',
    `program_description` STRING COMMENT 'Detailed narrative description of the experience program including objectives, benefits, and guest experience elements.',
    `effective_end_date` DATE COMMENT 'Date when the experience program expires or is no longer available. Null indicates open-ended program.',
    `effective_start_date` DATE COMMENT 'Date when the experience program becomes active and available for guest enrollment.',
    `eligibility_criteria` STRING COMMENT 'Business rules and requirements that determine which guests qualify for enrollment in this experience program.',
    `eligible_property_list` STRING COMMENT 'Comma-separated list of property codes where this experience program is available and can be offered to guests.',
    `eligible_rate_plans` STRING COMMENT 'Comma-separated list of rate plan codes that qualify for this experience program. Null indicates all rate plans are eligible.',
    `eligible_room_types` STRING COMMENT 'Comma-separated list of room type codes that qualify for this experience program. Null indicates all room types are eligible.',
    `enrollment_type` STRING COMMENT 'Method by which guests are enrolled into the experience program.. Valid values are `Automatic|Opt-In|Staff Assigned|Invitation Only`',
    `external_partner_name` STRING COMMENT 'Name of external partner or vendor involved in delivering this experience program. Null if fully internal.',
    `gss_target_score` DECIMAL(18,2) COMMENT 'Target GSS that this experience program aims to achieve. GSS is a standard hospitality satisfaction metric.',
    `last_modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified this experience program record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this experience program record was last updated or modified.',
    `loyalty_tier_requirement` STRING COMMENT 'Minimum loyalty program tier required for guest eligibility. Null indicates no loyalty tier requirement.',
    `marketing_channel` STRING COMMENT 'Primary marketing channel through which this experience program is promoted (e.g., Email, Website, Mobile App, In-Property).',
    `maximum_los` STRING COMMENT 'Maximum number of nights for which this experience program applies. Null indicates no maximum restriction.',
    `minimum_los` STRING COMMENT 'Minimum number of nights a guest must stay to qualify for this experience program. LOS is a standard hospitality metric.',
    `program_name` STRING COMMENT 'Full descriptive name of the experience program as displayed to guests and staff.',
    `nps_target_score` STRING COMMENT 'Target NPS score that this experience program aims to achieve or maintain. NPS is a key guest satisfaction metric.',
    `owner` STRING COMMENT 'Name or identifier of the business unit, department, or individual responsible for managing this experience program.',
    `owner_department` STRING COMMENT 'Department or division that owns and manages this experience program.. Valid values are `Guest Experience|Loyalty|Marketing|Revenue Management|Operations|Food and Beverage`',
    `points_redemption_eligible` BOOLEAN COMMENT 'Indicates whether guests can use loyalty points to redeem or upgrade to this experience program.',
    `points_redemption_value` STRING COMMENT 'Number of loyalty points required to redeem this experience program. Null if not redeemable via points.',
    `program_status` STRING COMMENT 'Current lifecycle status of the experience program indicating availability and operational state.. Valid values are `Active|Inactive|Suspended|Pilot|Retired`',
    `program_type` STRING COMMENT 'Classification of the experience program type. SALT refers to Satisfaction and Loyalty Tracking programs.. Valid values are `SALT|VIP Welcome|Anniversary Package|Wellness Journey|Culinary Experience|Romance Package`',
    `revenue_impact_flag` BOOLEAN COMMENT 'Indicates whether this experience program has direct revenue implications (e.g., upsell packages) or is purely cost-based (e.g., service recovery).',
    `salt_program_flag` BOOLEAN COMMENT 'Indicates whether this is a SALT (Satisfaction and Loyalty Tracking) program used for systematic guest satisfaction measurement.',
    `service_recovery_flag` BOOLEAN COMMENT 'Indicates whether this experience program is designed for service recovery and guest issue resolution purposes.',
    `target_guest_segment` STRING COMMENT 'Primary guest segment or persona this program is designed for (e.g., Elite Loyalty Members, Business Travelers, Families, Honeymooners).',
    `terms_and_conditions` STRING COMMENT 'Legal terms, conditions, and restrictions applicable to this experience program.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master definition of curated guest experience programs and SALT (Satisfaction and Loyalty Tracking) programs offered across properties. Captures program name, program type (SALT, VIP welcome, anniversary package, wellness journey, culinary experience), target guest segment, eligible property list, program validity period, enrollment criteria, associated benefits, and program owner. Serves as the catalog of experience offerings that can be assigned to guests or reservations.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` (
    `guest_experience_enrollment_id` BIGINT COMMENT 'Unique identifier for the guest experience enrollment record. Primary key.',
    `compliance_training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Experience programs requiring specialized service delivery (spa treatments, adventure activities, culinary experiences) must verify staff training completion for liability protection, insurance compli',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Experience program costs must be allocated to responsible department cost centers for budget tracking, variance reporting, and departmental P&L accountability. Essential for program ROI analysis and c',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or experience host assigned to guide and support the guest through the program.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Program costs and guest charges require GL posting for financial statement accuracy, revenue/expense recognition, and audit compliance. Critical for monthly financial close and program cost accounting',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Experience program enrollments (spa packages, culinary experiences, local tours) by loyalty members enable integrated benefits (points earning, tier discounts), cross-program personalization, and holi',
    `profile_id` BIGINT COMMENT 'Identifier of the guest enrolled in the experience program. Links to the guest master record.',
    `program_id` BIGINT COMMENT 'Identifier of the curated experience program the guest is enrolled in (e.g., culinary tour, spa retreat, adventure package).',
    `property_id` BIGINT COMMENT 'Identifier of the property where the experience program is being delivered.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the reservation associated with this experience enrollment. Links to the reservation record.',
    `service_case_id` BIGINT COMMENT 'Identifier of any service recovery case opened related to this experience enrollment, if applicable.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the guest completed or exited the experience program.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the guest began participating in the experience program.',
    `amenity_fulfillment_status` STRING COMMENT 'Status of amenity fulfillment associated with the experience program (not applicable, pending, in progress, completed, partially completed, failed).. Valid values are `not_applicable|pending|in_progress|completed|partially_completed|failed`',
    `cancellation_date` DATE COMMENT 'Date when the enrollment was cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the enrollment was cancelled (guest request, no show, property issue, weather, health, schedule conflict, other). [ENUM-REF-CANDIDATE: guest_request|no_show|property_issue|weather|health|schedule_conflict|other — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `enrollment_channel` STRING COMMENT 'Channel through which the guest enrolled in the experience program (web, mobile app, front desk, concierge, call center, email).. Valid values are `web|mobile_app|front_desk|concierge|call_center|email`',
    `enrollment_date` DATE COMMENT 'Date when the guest enrolled in the experience program.',
    `enrollment_number` STRING COMMENT 'Externally visible unique enrollment confirmation number provided to the guest.. Valid values are `^EXP-[A-Z0-9]{8,12}$`',
    `enrollment_source` STRING COMMENT 'Source or trigger that led to the enrollment (guest initiated, staff recommended, loyalty offer, package inclusion, upgrade, complimentary).. Valid values are `guest_initiated|staff_recommended|loyalty_offer|package_inclusion|upgrade|complimentary`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the guest enrolled in the experience program.',
    `feedback_comments` STRING COMMENT 'Free-text feedback comments provided by the guest about their experience program participation.',
    `feedback_received_date` DATE COMMENT 'Date when post-program feedback was received from the guest.',
    `fulfillment_progress_percentage` DECIMAL(18,2) COMMENT 'Percentage of the experience program activities completed by the guest (0.00 to 100.00).',
    `is_complimentary` BOOLEAN COMMENT 'Indicates whether the experience program enrollment was provided complimentary to the guest (true) or was a paid enrollment (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was last modified in the system.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for participating in this experience program.',
    `notes` STRING COMMENT 'Internal operational notes related to the experience enrollment, used by staff for coordination and service delivery.',
    `participant_count` STRING COMMENT 'Number of participants included in this enrollment (guest plus accompanying guests).',
    `payment_status` STRING COMMENT 'Payment status for the experience program enrollment (not required, pending, authorized, paid, refunded, waived).. Valid values are `not_required|pending|authorized|paid|refunded|waived`',
    `post_program_csat_score` DECIMAL(18,2) COMMENT 'Customer Satisfaction (CSAT) score provided by the guest after completing the experience program, typically on a scale of 1.00 to 5.00.',
    `post_program_gss_score` DECIMAL(18,2) COMMENT 'Guest Satisfaction Score (GSS) provided by the guest after completing the experience program, typically on a scale of 1.00 to 5.00 or 1.00 to 10.00.',
    `post_program_nps_score` STRING COMMENT 'Net Promoter Score (NPS) provided by the guest after completing the experience program, ranging from 0 to 10.',
    `program_status` STRING COMMENT 'Current lifecycle status of the guests participation in the experience program (enrolled, confirmed, active, in progress, completed, cancelled, no show). [ENUM-REF-CANDIDATE: enrolled|confirmed|active|in_progress|completed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `scheduled_end_date` DATE COMMENT 'Scheduled date when the experience program is set to conclude for the guest.',
    `scheduled_start_date` DATE COMMENT 'Scheduled date when the experience program is set to begin for the guest.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or preferences the guest has for the experience program (dietary restrictions, accessibility needs, activity preferences).',
    `total_program_cost` DECIMAL(18,2) COMMENT 'Total cost charged to the guest for the experience program enrollment.',
    CONSTRAINT pk_guest_experience_enrollment PRIMARY KEY(`guest_experience_enrollment_id`)
) COMMENT 'Association record linking a specific guest and reservation to an experience program, capturing enrollment date, enrollment channel, program status (enrolled, active, completed, cancelled), fulfillment progress, assigned experience host, and guest satisfaction outcome post-program. Enables tracking of which guests are participating in which curated experience programs and measures program effectiveness through post-program NPS and GSS scores.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` (
    `online_review_id` BIGINT COMMENT 'Unique identifier for the online review record. Primary key for the online review entity.',
    `channel_booking_id` BIGINT COMMENT 'Foreign key linking to channel.channel_booking. Business justification: Reviews reference specific stays; linking to channel booking enables verified stay validation, channel attribution for reputation management, and identification of review patterns by distribution sour',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Online reviews frequently mention specific restaurants/bars by name. Links review sentiment to outlet for reputation management, outlet-level sentiment analysis, competitive benchmarking, and identify',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Event reviews on platforms like Cvent specifically rate meeting spaces. Sales teams aggregate space-level reviews for RFP responses and contract negotiations. Real business process: meeting space repu',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Linking reviews to loyalty members enables program effectiveness analysis (do higher tiers give better reviews?), targeted recovery for high-LTV detractors, and member review sentiment tracking for re',
    `ota_partner_id` BIGINT COMMENT 'Foreign key linking to channel.ota_partner. Business justification: Reviews posted on OTA platforms must link to partner entity for partner-specific reputation tracking, content quality monitoring, and management response SLA compliance by partner. Essential for OTA c',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who authored this review, if the guest can be matched to internal records.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Online reviews routinely mention specific facilities by name (pool, restaurant, gym). Reputation management teams need facility-level sentiment analysis to prioritize capital improvements and respond ',
    `property_id` BIGINT COMMENT 'Reference to the property that this review is about. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation associated with this guest stay, if available. Links to the reservation record in the PMS.',
    `amenities_rating` DECIMAL(18,2) COMMENT 'Sub-rating for property amenities and facilities on a normalized 0-5 scale, if provided by the platform.',
    `cleanliness_rating` DECIMAL(18,2) COMMENT 'Sub-rating for cleanliness on a normalized 0-5 scale, if provided by the platform. Key dimension for housekeeping performance.',
    `competitive_set_flag` BOOLEAN COMMENT 'Indicates whether this review is part of the competitive set analysis for benchmarking. True if included in competitive reputation tracking.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when this review record was ingested into the unified reputation management system from the external platform.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this review record was last updated in the system, typically when management response or platform metadata changed.',
    `location_rating` DECIMAL(18,2) COMMENT 'Sub-rating for property location on a normalized 0-5 scale, if provided by the platform.',
    `management_response_status` STRING COMMENT 'Current status of management response to this review. Tracks service recovery workflow completion.. Valid values are `not_responded|responded|pending_response|no_response_needed`',
    `management_response_text` STRING COMMENT 'Full text of the management response posted to the review platform. Documents service recovery communication.',
    `management_response_timestamp` TIMESTAMP COMMENT 'Date and time when the management response was posted to the review platform. Tracks response time performance.',
    `normalized_rating` DECIMAL(18,2) COMMENT 'Overall rating normalized to a standard 0-5 scale for cross-platform comparison and aggregation. Enables unified reputation scoring.',
    `platform_native_rating` DECIMAL(18,2) COMMENT 'Overall rating score as provided by the guest on the platforms native scale. Stored in original format before normalization.',
    `platform_rating_scale` STRING COMMENT 'The native rating scale used by the review platform (e.g., 1-5 stars, 1-10 points). Enables interpretation of platform_native_rating.. Valid values are `1-5|1-10|1-100|percentage`',
    `platform_review_code` STRING COMMENT 'Unique identifier assigned by the external review platform to this review. Used for deduplication and tracking.',
    `response_author_name` STRING COMMENT 'Name or title of the property representative who authored the management response (e.g., General Manager, Guest Relations Manager).',
    `review_body_text` STRING COMMENT 'Full text content of the review written by the guest. Contains detailed feedback, experiences, and opinions.',
    `review_date` DATE COMMENT 'Date when the review was published on the external platform. This is the primary business event timestamp for reputation tracking.',
    `review_helpfulness_count` STRING COMMENT 'Number of users on the review platform who marked this review as helpful. Indicates review influence and visibility.',
    `review_language_code` STRING COMMENT 'ISO 639-2 three-letter language code of the review text. Supports multilingual reputation management.. Valid values are `^[A-Z]{3}$`',
    `review_source_url` STRING COMMENT 'Direct URL link to the original review on the external platform. Enables quick access for verification and response.',
    `review_title` STRING COMMENT 'Title or headline of the review as provided by the guest. Summarizes the main sentiment or topic.',
    `review_visibility_status` STRING COMMENT 'Current visibility status of the review on the external platform. Tracks whether review is publicly visible.. Valid values are `published|hidden|removed|flagged|pending_moderation`',
    `reviewer_alias` STRING COMMENT 'Public username or alias of the reviewer as displayed on the review platform. May be pseudonymous.',
    `reviewer_location` STRING COMMENT 'Geographic location of the reviewer as provided by the review platform, typically city and country.',
    `sentiment_classification` STRING COMMENT 'AI-derived sentiment classification of the review text. Supports automated reputation monitoring and alert triggering.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment score ranging from -1.0 (most negative) to +1.0 (most positive) derived from natural language processing of review text.',
    `service_rating` DECIMAL(18,2) COMMENT 'Sub-rating for service quality on a normalized 0-5 scale, if provided by the platform. Key dimension for guest experience.',
    `stay_end_date` DATE COMMENT 'End date of the guest stay period referenced in the review, if provided by the platform.',
    `stay_start_date` DATE COMMENT 'Start date of the guest stay period referenced in the review, if provided by the platform.',
    `traveler_type` STRING COMMENT 'Type of traveler as indicated by the reviewer or inferred from the review. Supports segmented reputation analysis.. Valid values are `business|leisure|family|couple|solo|group`',
    `value_rating` DECIMAL(18,2) COMMENT 'Sub-rating for value for money on a normalized 0-5 scale, if provided by the platform. Key dimension for pricing perception.',
    `verified_stay_flag` BOOLEAN COMMENT 'Indicates whether the review platform verified that the reviewer actually stayed at the property. True if verified, False otherwise.',
    CONSTRAINT pk_online_review PRIMARY KEY(`online_review_id`)
) COMMENT 'Record of guest reviews published on external OTA and review platforms (TripAdvisor, Google, Booking.com, Expedia, Yelp) captured and ingested for unified reputation management. Captures platform name, review rating (normalized and platform-native scales), review title, review body text, reviewer alias, review date, property, stay period reference, management response status, management response text, response timestamp, and AI-derived sentiment classification. Enables benchmarking of online reputation scores alongside direct Medallia survey feedback and supports competitive set reputation analysis.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` (
    `reputation_alert_id` BIGINT COMMENT 'Unique identifier for the reputation alert record. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Reputation alerts triggered by F&B issues (food quality complaints, service delays, health concerns) require outlet-level accountability. Essential for escalation routing to outlet managers, tracking ',
    `guest_feedback_id` BIGINT COMMENT 'Foreign key linking to experience.guest_feedback. Business justification: Reputation alerts can be triggered by internal guest feedback when NPS/GSS scores breach thresholds (e.g., detractor score, low CSAT). This FK links the alert to the specific feedback submission that ',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Product-level reputation issues (all ocean view rooms overpriced, suites dont meet expectations) require room type linkage for portfolio-wide response, pricing adjustments, and identifying systemic p',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Reputation alerts for loyalty members trigger tier-appropriate escalation paths and recovery budgets. Real process: platinum member negative review alerts route to GM immediately with higher compensat',
    `online_review_id` BIGINT COMMENT 'Foreign key linking to experience.online_review. Business justification: Reputation alerts are often triggered by negative online reviews on OTA platforms (TripAdvisor, Google, Booking.com). This FK links the alert to the specific review that triggered it, enabling review-',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or manager assigned to investigate and resolve the alert. Links to workforce management system.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest associated with the feedback or review that triggered the alert. May be null for anonymous reviews.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the alert was triggered. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the reservation associated with the feedback event. May be null if feedback is not tied to a specific reservation.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Reputation alerts triggered by room-specific issues in reviews (room 305 has mold, noisy HVAC in corner rooms) require room linkage for immediate investigation, out-of-order decisions, and tracking re',
    `service_case_id` BIGINT COMMENT 'Identifier of the service recovery case created in Salesforce CRM in response to this alert. Null if no case has been created yet.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned user acknowledged receipt of the alert. Used to track response time SLA compliance.',
    `actual_response_minutes` STRING COMMENT 'Actual time in minutes from alert trigger to acknowledgment. Calculated as difference between triggered_timestamp and acknowledged_timestamp.',
    `alert_number` STRING COMMENT 'Human-readable business identifier for the alert, formatted as ALT-YYYYMMDD sequence. Used for tracking and communication.. Valid values are `^ALT-[0-9]{8}$`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the alert. Tracks progression from initial trigger through acknowledgment, investigation, resolution, and closure.. Valid values are `new|acknowledged|in_progress|resolved|closed|escalated`',
    `alert_type` STRING COMMENT 'Classification of the alert based on the triggering condition. Values: low_nps_threshold_breach (NPS score below threshold), negative_ota_review (negative review on OTA platform), repeat_complaint_pattern (multiple complaints from same guest or about same issue), gss_drop (Guest Satisfaction Score drop), csat_threshold_breach (Customer Satisfaction below threshold), social_media_escalation (negative social media mention).. Valid values are `low_nps_threshold_breach|negative_ota_review|repeat_complaint_pattern|gss_drop|csat_threshold_breach|social_media_escalation`',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was assigned to a specific user for action. Null if alert has not yet been assigned.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was formally closed after verification and documentation. Final lifecycle timestamp.',
    `complaint_category` STRING COMMENT 'Primary category of the guest complaint or concern identified in the feedback. Examples: room_cleanliness, staff_service, noise, amenities, billing, food_quality. Supports root cause analysis and trend identification. [ENUM-REF-CANDIDATE: room_cleanliness|staff_service|noise|amenities|billing|food_quality|maintenance|check_in_process|check_out_process|reservation_issue|loyalty_program|parking|wifi|temperature_control|bedding_comfort|bathroom_condition — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was first created in the system. Audit trail field.',
    `department_responsible` STRING COMMENT 'Hotel department identified as responsible for addressing the issue that triggered the alert. Used for routing and accountability. [ENUM-REF-CANDIDATE: front_desk|housekeeping|food_and_beverage|maintenance|reservations|guest_services|management|sales|events — 9 candidates stripped; promote to reference product]',
    `escalated_flag` BOOLEAN COMMENT 'Indicates whether the alert was escalated to senior management or corporate level due to severity or lack of timely resolution. True if escalated, false otherwise.',
    `escalated_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was escalated. Null if alert was not escalated.',
    `guest_contact_method` STRING COMMENT 'Method used to contact the guest for service recovery. Null if guest was not contacted.. Valid values are `phone|email|in_person|sms|letter|no_contact`',
    `guest_contacted_flag` BOOLEAN COMMENT 'Indicates whether the guest was directly contacted by management as part of the resolution process. True if contact was made, false otherwise.',
    `guest_satisfaction_post_recovery` STRING COMMENT 'Guest satisfaction level measured after service recovery action was taken. Used to calculate Guest Recovery Rate (GRR) effectiveness.. Valid values are `satisfied|neutral|dissatisfied|not_measured`',
    `loyalty_points_awarded` STRING COMMENT 'Number of loyalty program points awarded to the guest as part of service recovery. Null if no points were awarded.',
    `notes` STRING COMMENT 'Free-text field for additional context, investigation findings, or special circumstances related to the alert. Used for knowledge capture and future reference.',
    `recovery_cost_amount` DECIMAL(18,2) COMMENT 'Monetary value of service recovery compensation provided to the guest (room credit, refund, amenity value, loyalty points cash equivalent). Used to calculate Guest Recovery Rate (GRR) cost.',
    `recovery_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the recovery cost amount. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `resolution_action_taken` STRING COMMENT 'Description of the corrective action or service recovery measure taken to address the alert. Examples: guest contacted and apology issued, room upgraded, refund processed, staff retraining scheduled, maintenance work order created.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was marked as resolved after corrective action was completed. Used to calculate resolution time metrics.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'AI-generated sentiment analysis score of the review text, ranging from -1.0 (very negative) to +1.0 (very positive). Generated by Medallia natural language processing engine.',
    `severity_level` STRING COMMENT 'Severity classification of the alert indicating urgency of management response. Critical requires immediate action, high requires same-day response, medium within 24 hours, low within 48 hours.. Valid values are `critical|high|medium|low`',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the alert response met the SLA target. True if actual_response_minutes <= sla_response_minutes, false otherwise.',
    `sla_response_minutes` STRING COMMENT 'Target response time in minutes based on alert severity level, as defined by SALT program SLA standards. Used to measure compliance.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Configured threshold value that was breached to trigger the alert. Represents the minimum acceptable performance level for the metric.',
    `triggered_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was triggered by the Medallia alert engine based on threshold breach or pattern detection.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was last modified. Audit trail field for tracking changes throughout the alert lifecycle.',
    `variance_from_threshold` DECIMAL(18,2) COMMENT 'Calculated difference between the metric value and threshold value. Negative values indicate below-threshold performance. Helps prioritize alert severity.',
    CONSTRAINT pk_reputation_alert PRIMARY KEY(`reputation_alert_id`)
) COMMENT 'Operational alert record triggered when guest feedback, NPS scores, or online reviews breach defined thresholds requiring management attention. Captures alert type (low NPS threshold breach, negative OTA review, repeat complaint pattern, GSS drop), severity level, triggering metric value, threshold value, property, alert timestamp, assigned recipient, acknowledgment status, and resolution action taken. Sourced from Medallia alert engine and integrated with Salesforce CRM for case creation.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` (
    `gss_score_id` BIGINT COMMENT 'Unique identifier for the GSS score measurement record.',
    `market_segment_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT 'Reference to the property where this GSS score was measured.',
    `bottom_box_pct` DECIMAL(18,2) COMMENT '',
    `bottom_box_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents who gave the lowest satisfaction ratings (bottom-box scores), typically 1-2 on a 5-point scale or 0-6 on a 10-point scale.',
    `brand_code` STRING COMMENT 'Brand identifier for the property (e.g., luxury, premium, select-service segment), used for brand-level GSS aggregation and QA reviews.',
    `brand_qa_review_flag` BOOLEAN COMMENT 'Boolean indicator of whether this GSS score has been flagged for brand-level quality assurance review due to performance concerns or significant variance.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when the GSS score was calculated and recorded in the system.',
    `comparison_period_score` STRING COMMENT '',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for the GSS score, typically at 95% confidence level.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for the GSS score, typically at 95% confidence level.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GSS score record was first created in the data platform.',
    `data_source` STRING COMMENT 'Source system from which the GSS score data was derived (Medallia, Salesforce CRM, Manual Entry, Integrated Multi-Source).. Valid values are `MEDALLIA|SALESFORCE|MANUAL|INTEGRATED`',
    `department_code` STRING COMMENT 'Department or touchpoint area for which this GSS score was calculated (e.g., Front Desk, Housekeeping, F&B, Overall Property). [ENUM-REF-CANDIDATE: FRONT_DESK|HOUSEKEEPING|FNB|CONCIERGE|SPA|MAINTENANCE|OVERALL|EVENTS|VALET|ROOM_SERVICE — 10 candidates stripped; promote to reference product]',
    `detractor_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents classified as detractors (score 0-6 on likelihood-to-recommend scale).',
    `gm_review_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this GSS score requires General Manager review and action plan due to falling below acceptable thresholds or being classified as Critical.',
    `grr_percent` DECIMAL(18,2) COMMENT 'Guest Recovery Rate percentage for the measurement period, calculated as the percentage of service recovery cases that resulted in successful guest satisfaction restoration.',
    `market_segment` STRING COMMENT 'Primary market segment of guests included in this GSS measurement (Transient, Group, Contract, Wholesale, Complementary).. Valid values are `TRANSIENT|GROUP|CONTRACT|WHOLESALE|COMPLEMENTARY`',
    `measurement_end_date` DATE COMMENT 'End date of the measurement period for this GSS score.',
    `measurement_period_type` STRING COMMENT 'Frequency or granularity of the GSS measurement period (daily, weekly, monthly, quarterly, annual).. Valid values are `DAILY|WEEKLY|MONTHLY|QUARTERLY|ANNUAL`',
    `measurement_start_date` DATE COMMENT 'Start date of the measurement period for this GSS score.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this GSS score measurement, including context for anomalies, data quality issues, or special circumstances affecting the score.',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score calculated for the same measurement period and scope, derived from likelihood-to-recommend survey responses.',
    `passive_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents classified as passives (score 7-8 on likelihood-to-recommend scale).',
    `period_end_date` DATE COMMENT '',
    `period_start_date` DATE COMMENT '',
    `prior_period_score` DECIMAL(18,2) COMMENT 'GSS score value from the immediately preceding measurement period of the same type, used for sequential trend comparison.',
    `prior_period_variance` DECIMAL(18,2) COMMENT 'Variance between current GSS score and prior period score, calculated as (gss_score_value - prior_period_score).',
    `promoter_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents classified as promoters (score 9-10 on likelihood-to-recommend scale).',
    `published_flag` BOOLEAN COMMENT 'Boolean indicator of whether this GSS score has been published and made available to property management and brand QA teams (True if published, False if draft or under review).',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when the GSS score was published and made available to stakeholders.',
    `region_code` STRING COMMENT 'Geographic region code for the property, used for regional GSS benchmarking and performance comparison.',
    `response_rate_pct` DECIMAL(18,2) COMMENT '',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of surveys that received responses, calculated as (sample_size / surveys_sent_count) * 100.',
    `salt_target_attained_flag` BOOLEAN COMMENT 'Boolean indicator of whether the GSS score met or exceeded the SALT program target (True if gss_score_value >= salt_target_score).',
    `salt_target_score` DECIMAL(18,2) COMMENT 'Target GSS score defined by the SALT program for this property, department, and measurement period.',
    `sample_size` STRING COMMENT 'Number of survey responses included in the GSS score calculation for this measurement period.',
    `score_average` STRING COMMENT '',
    `score_band` STRING COMMENT 'Categorical classification of the GSS score into performance bands (Excellent, Good, Needs Improvement, Critical) based on brand-defined thresholds.. Valid values are `EXCELLENT|GOOD|NEEDS_IMPROVEMENT|CRITICAL`',
    `score_median` STRING COMMENT '',
    `score_stddev` STRING COMMENT '',
    `service_recovery_case_count` STRING COMMENT 'Number of service recovery cases opened during the measurement period for this property and department, sourced from Salesforce CRM case management.',
    `survey_response_count` STRING COMMENT '',
    `surveys_sent_count` STRING COMMENT 'Total number of surveys sent to guests during the measurement period.',
    `top_box_pct` DECIMAL(18,2) COMMENT '',
    `top_box_percent` DECIMAL(18,2) COMMENT 'Percentage of respondents who gave the highest satisfaction rating (top-box score), typically 5 on a 5-point scale or 9-10 on a 10-point scale.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this GSS score record was last updated in the data platform.',
    `value` DECIMAL(18,2) COMMENT 'The calculated GSS score value for the measurement period, typically on a 0-100 scale derived from aggregated Medallia survey responses.',
    `variance_pct` DECIMAL(18,2) COMMENT '',
    `yoy_score` DECIMAL(18,2) COMMENT 'GSS score value from the same measurement period in the prior year, used for year-over-year comparison.',
    `yoy_variance` DECIMAL(18,2) COMMENT 'Variance between current GSS score and year-over-year score, calculated as (gss_score_value - yoy_score).',
    CONSTRAINT pk_gss_score PRIMARY KEY(`gss_score_id`)
) COMMENT 'Periodic GSS (Guest Satisfaction Score) measurement record at property and department level, derived from aggregating Medallia survey responses. Captures GSS score value, measurement period (daily, weekly, monthly, quarterly), property, department or touchpoint area, sample size, response rate, confidence interval, prior period score for trend comparison, YoY comparison, score band classification (excellent, good, needs improvement, critical), and SALT program target attainment flag. Serves as the operational scorecard record driving GM accountability, brand QA reviews, and property-level experience performance management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` (
    `quality_audit_id` BIGINT COMMENT 'Unique identifier for the quality audit record. Primary key for the quality audit entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Quality audits (brand standards, service excellence) often run concurrently with or trigger regulatory compliance audits (health, safety, accessibility). Hospitality operations track which compliance ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality audit costs (auditor fees, corrective action expenses, re-inspection costs) must be tracked by cost center for departmental budget accountability and quality assurance program cost management.',
    `follow_up_quality_audit_id` BIGINT COMMENT 'Self-referencing FK on quality_audit (follow_up_quality_audit_id)',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Brand quality audits inspect room type compliance with standards (suite amenities, deluxe finishes, ADA features). Room type linkage enables product-level scoring, deficiency tracking, and certificati',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Meeting space audits cover fire safety, AV functionality, accessibility compliance. Brand standards require space-level audit documentation for insurance and liability purposes. Real business process:',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Quality audits inspect individual facilities (restaurant health scores, pool safety certifications, spa licensing). Compliance teams track facility-level audit scores for regulatory reporting and bran',
    `property_id` BIGINT COMMENT 'Identifier of the property where the quality audit was conducted. Links to the property master record.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Audits sample specific rooms for inspection. Room linkage documents which units were audited, tracks deficiencies by room, and enables follow-up re-inspection scheduling. Critical for audit trail and ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Quality audits assess vendor-delivered services (F&B providers, housekeeping suppliers, maintenance contractors, spa operators). Audit findings directly impact vendor performance scorecards, contract ',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the audit fieldwork concluded. Captures the precise moment the audit inspection was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the audit fieldwork commenced. Captures the precise moment the audit inspection began.',
    `amenity_score` DECIMAL(18,2) COMMENT 'Category score evaluating the quality, availability, and condition of property amenities including fitness centers, pools, business centers, and guest conveniences.',
    `audit_date` DATE COMMENT 'The date on which the quality audit was conducted or completed. Represents the primary business event timestamp for the audit inspection.',
    `audit_notes` STRING COMMENT 'Free-text field capturing additional context, observations, commendations, or special circumstances noted during the audit that provide qualitative insight beyond numerical scores.',
    `audit_report_url` STRING COMMENT 'Web link or file path to the detailed audit report document containing full findings, deficiency descriptions, photographic evidence, and corrective action recommendations.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the quality audit. Scheduled indicates planned future audit, in progress means audit is actively being conducted, completed means audit fieldwork is done, under review indicates findings are being validated, closed means all corrective actions are complete, and cancelled means audit was terminated before completion.. Valid values are `scheduled|in_progress|completed|under_review|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the quality audit indicating the auditing body or program. Forbes Travel Guide evaluates luxury service standards, AAA Diamond assesses overall quality, brand standard ensures compliance with corporate guidelines, mystery shop provides anonymous guest perspective, internal QA validates operational adherence, and health safety covers regulatory compliance inspections.. Valid values are `forbes_travel_guide|aaa_diamond|brand_standard|mystery_shop|internal_qa|health_safety`',
    `auditor_certification_number` STRING COMMENT 'Professional certification or credential number of the auditor, validating their qualification to conduct quality audits in the hospitality industry.',
    `auditor_name` STRING COMMENT 'Full name of the primary auditor or inspector who conducted the quality audit. May represent an individual evaluator or lead inspector for team audits.',
    `auditor_organization` STRING COMMENT 'Name of the organization or entity that the auditor represents, such as Forbes Travel Guide, AAA, brand quality assurance team, or third-party mystery shopping firm.',
    `brand_compliance_flag` BOOLEAN COMMENT 'Indicates whether the property met all mandatory brand standards and compliance requirements during the audit. True means full compliance achieved, false indicates brand standard violations requiring remediation.',
    `certification_level_achieved` STRING COMMENT 'The quality classification or rating level awarded based on audit results, such as Forbes 5-Star, Forbes 4-Star, AAA 5-Diamond, AAA 4-Diamond, or brand-specific tier designations. Drives market positioning and guest expectations.',
    `corrective_action_completion_date` DATE COMMENT 'The actual date when all required corrective actions were completed and verified. Used to measure remediation cycle time and compliance with deadlines.',
    `corrective_action_completion_status` STRING COMMENT 'Current status of corrective action implementation. Not started means no work has begun, in progress indicates active remediation, completed means property reports actions done, verified means auditor confirmed completion, and overdue means deadline has passed without completion.. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `corrective_action_deadline` DATE COMMENT 'The date by which all required corrective actions must be completed and verified. Used to track remediation timelines and ensure accountability for quality improvement.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether the audit findings require formal corrective action plans to be developed and implemented. True means corrective actions are mandatory, false means audit was clean or findings are informational only.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this quality audit record was first created in the system. Represents the initial data capture event for audit trail purposes.',
    `critical_deficiency_count` STRING COMMENT 'Number of critical or high-severity deficiencies identified that pose immediate risk to guest safety, brand reputation, or regulatory compliance. Requires urgent remediation.',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies, non-conformances, or findings identified during the audit. Provides a quantitative measure of quality gaps requiring corrective action.',
    `facility_score` DECIMAL(18,2) COMMENT 'Category score assessing physical property condition, maintenance standards, cleanliness, and facility upkeep. Evaluates the tangible aspects of the guest experience.',
    `fnb_score` DECIMAL(18,2) COMMENT 'Category score assessing food and beverage operations including restaurant service, menu quality, culinary execution, bar service, and dining experience standards.',
    `gm_accountability_flag` BOOLEAN COMMENT 'Indicates whether the audit results are tied to General Manager performance evaluation and accountability metrics. True means GM is formally accountable for audit outcomes and corrective actions.',
    `housekeeping_score` DECIMAL(18,2) COMMENT 'Category score assessing room cleanliness, housekeeping standards, turndown service, linen quality, and overall room presentation. Critical component for guest satisfaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this quality audit record was most recently updated. Used to track data currency and audit record lifecycle changes.',
    `major_deficiency_count` STRING COMMENT 'Number of major or medium-severity deficiencies identified that significantly impact guest experience or operational standards but do not pose immediate critical risk.',
    `minor_deficiency_count` STRING COMMENT 'Number of minor or low-severity deficiencies identified that represent opportunities for improvement but do not materially impact guest experience or compliance.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite quality score representing the overall audit result. Scale and interpretation vary by audit type (e.g., Forbes uses 0-100, AAA uses point system). This is the primary metric for property quality classification.',
    `pass_fail_determination` STRING COMMENT 'Final audit outcome indicating whether the property met the required quality standards. Pass means all standards met, fail indicates significant deficiencies, conditional pass requires minor corrective actions, and pending means determination is under review.. Valid values are `pass|fail|conditional_pass|pending`',
    `prior_audit_date` DATE COMMENT 'The date of the previous quality audit of the same type conducted at this property. Used to calculate audit frequency and track historical score trends.',
    `prior_certification_level` STRING COMMENT 'The quality classification or rating level held by the property before this audit. Used to track certification progression or regression over time.',
    `prior_overall_score` DECIMAL(18,2) COMMENT 'The overall quality score from the previous audit of the same type. Used to calculate score variance and track quality improvement or degradation trends over time.',
    `re_inspection_date` DATE COMMENT 'The scheduled or actual date of the follow-up audit conducted to verify that corrective actions have been effectively implemented and quality standards are now met.',
    `re_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit or re-inspection is required to verify corrective action effectiveness and validate quality improvement. True means re-inspection is mandatory, false means no follow-up audit needed.',
    `scheduled_end_date` DATE COMMENT 'The planned date when the audit is scheduled to conclude. Used for audit planning and resource allocation.',
    `scheduled_start_date` DATE COMMENT 'The planned date when the audit is scheduled to begin. Used for audit planning and resource allocation.',
    `score_variance` DECIMAL(18,2) COMMENT 'The change in overall score compared to the prior audit, calculated as current score minus prior score. Positive values indicate quality improvement, negative values indicate degradation.',
    `service_score` DECIMAL(18,2) COMMENT 'Category score evaluating service quality, staff professionalism, guest interaction, and service delivery standards. Key component of overall audit assessment.',
    `spa_score` DECIMAL(18,2) COMMENT 'Category score evaluating spa and wellness facilities, treatment quality, therapist professionalism, and spa service standards. Applicable only to properties with spa amenities.',
    CONSTRAINT pk_quality_audit PRIMARY KEY(`quality_audit_id`)
) COMMENT 'Master record for property quality inspections and audits conducted by Forbes Travel Guide evaluators, AAA Diamond inspectors, brand QA teams, and mystery shoppers. Captures audit type (Forbes, AAA, brand standard, mystery shop, internal QA), audit date, property, auditor identity, overall score, category scores (service, facility, amenity, F&B, spa, housekeeping), pass/fail determination, deficiency findings with severity classification, corrective action requirements, corrective action deadlines, corrective action completion status, re-inspection date, and historical score trend. Drives property classification maintenance (Forbes 5-Star, AAA 5-Diamond), brand compliance enforcement, and GM accountability for service standard adherence. Supports the quality improvement cycle from inspection through remediation to re-certification. Integrates with property domain for facility-related deficiencies and workforce domain for staff training gaps identified during audits.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` (
    `touchpoint_id` BIGINT COMMENT 'Unique identifier for the guest journey touchpoint. Primary key.',
    `parent_touchpoint_id` BIGINT COMMENT 'Reference to a parent touchpoint if this touchpoint is a sub-touchpoint or variant of a broader interaction (self-referential hierarchy).',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether this touchpoint meets Americans with Disabilities Act (ADA) accessibility requirements.',
    `automation_level` STRING COMMENT 'The degree of automation at this touchpoint (fully automated, semi-automated, manual, hybrid).. Valid values are `fully_automated|semi_automated|manual|hybrid`',
    `brand_code` STRING COMMENT 'The brand code if this touchpoint is brand-specific (e.g., luxury, premium, select-service brand identifiers).. Valid values are `^[A-Z]{2,10}$`',
    `touchpoint_category` STRING COMMENT 'The category or modality of the touchpoint (digital, physical, voice, self-service, staff-assisted, automated).. Valid values are `digital|physical|voice|self-service|staff-assisted|automated`',
    `touchpoint_code` STRING COMMENT 'Unique business code identifying the touchpoint type (e.g., PRE_ARRIVAL_EMAIL, CHECK_IN_DESK, IN_ROOM_DINING, CHECKOUT_KIOSK).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether this touchpoint requires compliance review for regulatory adherence (e.g., General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), Payment Card Industry Data Security Standard (PCI DSS)).',
    `cost_currency_code` STRING COMMENT 'The currency code for cost per interaction using ISO 4217 three-letter codes (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_per_interaction` DECIMAL(18,2) COMMENT 'The estimated or actual cost per guest interaction at this touchpoint, used for operational efficiency analysis.',
    `created_by_user` STRING COMMENT 'The user identifier or name of the person who created this touchpoint definition.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this touchpoint record was created in the system.',
    `data_privacy_sensitive_flag` BOOLEAN COMMENT 'Indicates whether this touchpoint involves collection or processing of privacy-sensitive guest data requiring special handling.',
    `default_language_code` STRING COMMENT 'The default language code for this touchpoint using ISO 639-1 two-letter codes (e.g., en, es, fr, de, zh).. Valid values are `^[a-z]{2}$`',
    `department_owner` STRING COMMENT 'The department or functional area responsible for managing and delivering this touchpoint (e.g., Front Office, Housekeeping, Food and Beverage (F&B), Concierge, Guest Services, Revenue Management).',
    `touchpoint_description` STRING COMMENT 'Detailed description of the touchpoint, its purpose, and the guest interaction it represents.',
    `effective_end_date` DATE COMMENT 'The date when this touchpoint definition expires or is no longer effective (null for indefinite).',
    `effective_start_date` DATE COMMENT 'The date when this touchpoint definition became or will become effective.',
    `feedback_collection_method` STRING COMMENT 'The method used to collect guest feedback at this touchpoint (survey, direct feedback, observation, system log, social media, review platform).. Valid values are `survey|direct_feedback|observation|system_log|social_media|review_platform`',
    `guest_effort_score_target` DECIMAL(18,2) COMMENT 'The target Guest Effort Score for this touchpoint, representing the desired ease of interaction (lower scores indicate less effort required).',
    `guest_segment_applicability` STRING COMMENT 'The guest segments to which this touchpoint applies (e.g., all guests, loyalty members only, VIP guests, business travelers, leisure travelers, group bookings). [ENUM-REF-CANDIDATE: all_guests|loyalty_members|vip_guests|business_travelers|leisure_travelers|group_bookings|families|couples — promote to reference product]',
    `interaction_channel` STRING COMMENT 'The specific channel through which the touchpoint interaction occurs (e.g., email, mobile app, front desk, in-room tablet, phone, SMS, chatbot, kiosk). [ENUM-REF-CANDIDATE: email|mobile_app|web_portal|front_desk|concierge|phone|sms|chatbot|kiosk|in_room_tablet|social_media — promote to reference product]',
    `is_csat_eligible` BOOLEAN COMMENT 'Indicates whether this touchpoint is eligible for Customer Satisfaction (CSAT) survey measurement.',
    `is_gss_eligible` BOOLEAN COMMENT 'Indicates whether this touchpoint is eligible for Guest Satisfaction Score (GSS) measurement.',
    `is_mandatory_touchpoint` BOOLEAN COMMENT 'Indicates whether this touchpoint is mandatory for all guests (e.g., check-in, check-out) or optional.',
    `is_nps_eligible` BOOLEAN COMMENT 'Indicates whether this touchpoint is eligible for Net Promoter Score (NPS) survey measurement.',
    `journey_stage` STRING COMMENT 'The stage of the guest journey lifecycle where this touchpoint occurs (pre-arrival, arrival, in-stay, departure, post-stay).. Valid values are `pre-arrival|arrival|in-stay|departure|post-stay`',
    `last_modified_by_user` STRING COMMENT 'The user identifier or name of the person who last modified this touchpoint definition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this touchpoint record was last modified.',
    `medallia_touchpoint_code` STRING COMMENT 'The corresponding touchpoint identifier in the Medallia experience analytics platform for integration and feedback mapping.',
    `multi_language_supported_flag` BOOLEAN COMMENT 'Indicates whether this touchpoint supports multiple languages for international guests.',
    `touchpoint_name` STRING COMMENT 'Human-readable name of the touchpoint (e.g., Pre-Arrival Welcome Email, Front Desk Check-In, In-Room Dining Order).',
    `priority_level` STRING COMMENT 'The business priority level assigned to this touchpoint for guest experience management (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `property_scope` STRING COMMENT 'Defines whether this touchpoint applies to all properties, specific brands, individual properties, or regions.. Valid values are `all_properties|brand_specific|property_specific|region_specific`',
    `salesforce_touchpoint_code` STRING COMMENT 'The corresponding touchpoint identifier in Salesforce Customer Relationship Management (CRM) for case management and guest interaction tracking.',
    `salt_program_linked_flag` BOOLEAN COMMENT 'Indicates whether this touchpoint is linked to the Satisfaction and Loyalty Tracking (SALT) program for performance measurement.',
    `sequence_order` STRING COMMENT 'The typical sequence order of this touchpoint within its journey stage, used for journey mapping and visualization.',
    `service_recovery_trigger_flag` BOOLEAN COMMENT 'Indicates whether negative feedback or issues at this touchpoint automatically trigger service recovery workflows.',
    `staff_training_required_flag` BOOLEAN COMMENT 'Indicates whether staff training is required to deliver this touchpoint effectively.',
    `touchpoint_status` STRING COMMENT 'Current operational status of the touchpoint (active, inactive, pilot, deprecated, seasonal).. Valid values are `active|inactive|pilot|deprecated|seasonal`',
    `typical_duration_minutes` STRING COMMENT 'The typical or expected duration of the guest interaction at this touchpoint, measured in minutes.',
    `version_number` STRING COMMENT 'The version number of this touchpoint definition, incremented when the touchpoint configuration is updated.',
    CONSTRAINT pk_touchpoint PRIMARY KEY(`touchpoint_id`)
) COMMENT 'Master definition of guest journey touchpoints across the stay lifecycle (pre-arrival, arrival, in-stay, departure, post-stay) used to map feedback and interactions to specific moments.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` (
    `program_treatment_inclusion_id` BIGINT COMMENT 'Unique identifier for this program-treatment inclusion record. Primary key.',
    `primary_experience_program_id` BIGINT COMMENT 'Foreign key to experience_program',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to the spa treatment included in this experience program',
    `blackout_dates` STRING COMMENT 'Specific dates or date ranges when this treatment is not available as part of this experience program (e.g., seasonal restrictions, therapist availability).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this program-treatment inclusion record was created.',
    `effective_end_date` DATE COMMENT 'Date when this treatment is no longer available for inclusion in this experience program. Null indicates ongoing availability.',
    `effective_start_date` DATE COMMENT 'Date when this treatment becomes available for inclusion in this experience program.',
    `inclusion_quantity` STRING COMMENT '',
    `inclusion_sequence` STRING COMMENT 'Order in which this treatment should be delivered within the experience program journey. Used for scheduling and guest communication.',
    `inclusion_status` STRING COMMENT 'Current status of this treatment inclusion in the program (active, suspended, discontinued). Allows temporary removal without deleting the inclusion record.',
    `inclusion_value` DECIMAL(18,2) COMMENT '',
    `is_complimentary` BOOLEAN COMMENT '',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this treatment is mandatory (must be taken) or optional (guest can choose) within the experience program.',
    `quantity_included` STRING COMMENT 'Number of sessions or instances of this treatment included in the experience program (e.g., 2 massages, 1 facial).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this program-treatment inclusion record was last modified.',
    `upgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether the guest can upgrade this treatment to a premium version within the program (e.g., upgrade 60-min massage to 90-min).',
    `program_id` BIGINT COMMENT '',
    `experience_program_id` BIGINT COMMENT '',
    `created_by` STRING COMMENT 'User or system identifier that created this inclusion record.',
    CONSTRAINT pk_program_treatment_inclusion PRIMARY KEY(`program_treatment_inclusion_id`)
) COMMENT 'This association product represents the inclusion relationship between experience programs and spa treatments. It captures which treatments are included in which experience programs, along with sequencing, quantities, upgrade eligibility, and temporal availability. Each record links one experience program to one treatment with attributes that exist only in the context of this program-treatment pairing.. Existence Justification: In hospitality operations, experience programs (wellness retreats, romance packages, SALT programs) are curated bundles that include multiple spa treatments, and each treatment can be included in multiple different programs. The business actively manages these inclusions with specific rules about sequencing, quantities, upgrade eligibility, and seasonal availability. This is an operational product composition relationship, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` (
    `program_fitness_inclusion_id` BIGINT COMMENT 'Unique identifier for this program-fitness class inclusion relationship. Primary key.',
    `fitness_class_id` BIGINT COMMENT 'Foreign key linking to the fitness class included in this experience program',
    `primary_experience_program_id` BIGINT COMMENT 'Foreign key to experience_program',
    `advance_booking_required_flag` BOOLEAN COMMENT 'Indicates whether guests enrolled in this program must book this fitness class in advance or can attend walk-in. This attribute was explicitly identified in the detection phase relationship data.',
    `blackout_dates` STRING COMMENT '',
    `class_selection_flexibility` STRING COMMENT 'Indicates whether guests must attend specific scheduled sessions (fixed), can choose any available session (flexible), or can choose from a subset (choice_of_n). This attribute was explicitly identified in the detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this program-fitness class inclusion relationship was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this fitness class is no longer included in this experience program. Nullable for ongoing inclusions. This attribute was explicitly identified in the detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when this fitness class becomes available as part of this experience program. This attribute was explicitly identified in the detection phase relationship data.',
    `inclusion_quantity` STRING COMMENT '',
    `inclusion_status` STRING COMMENT 'Current status of this fitness class inclusion in the experience program, allowing program managers to activate or deactivate specific class offerings without removing the relationship.',
    `is_complimentary` BOOLEAN COMMENT '',
    `priority_booking_flag` BOOLEAN COMMENT 'Indicates whether guests enrolled in this program receive priority booking access for this fitness class over non-program guests.',
    `session_credits` STRING COMMENT '',
    `sessions_included` STRING COMMENT 'Number of fitness class sessions included in the experience program for each enrolled guest. This attribute was explicitly identified in the detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this program-fitness class inclusion relationship was last modified.',
    `program_id` BIGINT COMMENT '',
    `experience_program_id` BIGINT COMMENT '',
    CONSTRAINT pk_program_fitness_inclusion PRIMARY KEY(`program_fitness_inclusion_id`)
) COMMENT 'This association product represents the inclusion relationship between experience programs and fitness classes. It captures which fitness classes are included in which experience programs, along with the number of sessions guests receive, booking requirements, and selection flexibility. Each record links one experience program to one fitness class with attributes that define the terms of inclusion.. Existence Justification: In travel hospitality operations, experience programs are curated packages that bundle multiple amenities and services, including fitness classes. A single experience program (e.g., Wellness Journey or VIP Welcome Package) includes multiple fitness class types (yoga, pilates, HIIT) to give guests variety and choice. Conversely, a popular fitness class like Morning Yoga can be included in multiple experience programs (Wellness Journey, SALT Recovery Program, Anniversary Package) with different terms for each program. Program managers actively configure and manage these inclusions, specifying how many sessions are included, booking rules, and guest selection flexibility for each program-class pairing.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` (
    `survey_template_id` BIGINT COMMENT 'Primary key for survey_template',
    `property_id` BIGINT COMMENT 'add column property_id (BIGINT) with FK to property.property.property_id - survey templates are property-scoped for branded surveys.',
    `superseded_survey_template_id` BIGINT COMMENT 'Self-referencing FK on survey_template (superseded_survey_template_id)',
    `allows_anonymous_responses` BOOLEAN COMMENT 'Indicates whether guests can submit responses to this survey without providing identifying information, supporting privacy preferences.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved this survey template for production use, supporting governance and quality control.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this survey template was approved for production use, supporting governance workflow tracking.',
    `auto_case_creation_enabled` BOOLEAN COMMENT 'Indicates whether low-scoring survey responses automatically create service recovery cases in Salesforce CRM for immediate guest outreach.',
    `compliance_review_date` DATE COMMENT 'Date when this survey template was last reviewed for regulatory compliance, supporting governance and audit requirements.',
    `compliance_reviewed` BOOLEAN COMMENT 'Indicates whether this survey template has been reviewed for compliance with privacy regulations and data protection requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this survey template record was first created in the system, supporting audit trail and version history.',
    `survey_template_description` STRING COMMENT 'Detailed description of the survey template purpose, target audience, and intended use cases within the guest experience management program.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the survey is delivered to guests, used for channel-specific optimization and response tracking.',
    `effective_end_date` DATE COMMENT 'Date when this survey template is retired or replaced, supporting template lifecycle management and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this survey template becomes active and available for distribution to guests, supporting version control and rollout planning.',
    `estimated_completion_minutes` STRING COMMENT 'Expected time in minutes for a guest to complete the survey, used for guest communication and response rate optimization.',
    `incentive_offered` STRING COMMENT 'Type of incentive offered to guests for completing this survey, used for response rate optimization and program cost tracking.',
    `incentive_value` DECIMAL(18,2) COMMENT 'Monetary or points value of the incentive offered for survey completion, used for program cost analysis and ROI measurement.',
    `includes_csat_question` BOOLEAN COMMENT 'Indicates whether this survey template includes a Customer Satisfaction (CSAT) rating question for overall satisfaction measurement.',
    `includes_nps_question` BOOLEAN COMMENT 'Indicates whether this survey template includes the standard NPS question for measuring guest loyalty and likelihood to recommend.',
    `includes_open_feedback` BOOLEAN COMMENT 'Indicates whether this survey template includes open-ended text fields for qualitative guest feedback and comments.',
    `is_default_template` BOOLEAN COMMENT 'Indicates whether this is the default survey template for its type and segment, used for automated survey distribution logic.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the survey template for localization and guest communication.',
    `last_used_date` DATE COMMENT 'Most recent date this survey template was distributed to a guest, used for template lifecycle management and archival decisions.',
    `medallia_template_code` STRING COMMENT 'External identifier for this survey template in the Medallia experience analytics platform, used for system integration and data synchronization.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this survey template record, supporting change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this survey template record was last modified, supporting audit trail and change management.',
    `notes` STRING COMMENT 'Additional notes, instructions, or context about this survey template for internal reference and knowledge management.',
    `owner_department` STRING COMMENT 'Business department or function responsible for maintaining and governing this survey template, supporting organizational accountability.',
    `property_tier` STRING COMMENT 'Hotel property tier or brand segment for which this survey template is designed, enabling tier-specific experience measurement.',
    `question_count` STRING COMMENT 'Total number of questions included in the survey template, used for completion time estimation and survey design optimization.',
    `response_window_days` STRING COMMENT 'Number of days the survey remains open for guest responses after distribution, balancing recency and response opportunity.',
    `salt_program_eligible` BOOLEAN COMMENT 'Indicates whether responses from this survey template are eligible for inclusion in SALT program metrics and service recovery workflows.',
    `service_recovery_threshold_score` DECIMAL(18,2) COMMENT 'Minimum satisfaction score below which a service recovery case is automatically triggered in Salesforce CRM for guest follow-up.',
    `survey_template_status` STRING COMMENT 'Current lifecycle status of the survey template indicating its availability for use in guest experience programs.',
    `tags` STRING COMMENT 'Comma-separated list of tags or keywords for categorizing and searching survey templates, supporting template library organization.',
    `target_segment` STRING COMMENT 'Intended guest segment or audience for this survey template, used for targeted experience measurement and personalized feedback collection.',
    `template_code` STRING COMMENT 'Unique business identifier code for the survey template, used for external references and system integration.',
    `template_name` STRING COMMENT 'Human-readable name of the survey template used for identification and selection purposes.',
    `template_type` STRING COMMENT 'Classification of the survey template by its primary purpose: Net Promoter Score (NPS), Customer Satisfaction (CSAT), Guest Satisfaction Score (GSS), post-stay feedback, pre-arrival expectations, or service recovery assessment.',
    `trigger_delay_hours` STRING COMMENT 'Number of hours to wait after the trigger event before sending the survey to the guest, optimizing response timing and quality.',
    `trigger_event` STRING COMMENT 'Guest journey event or touchpoint that triggers the distribution of this survey template, enabling timely feedback collection.',
    `usage_count` BIGINT COMMENT 'Total number of times this survey template has been distributed to guests, used for template effectiveness analysis and optimization.',
    `version_number` STRING COMMENT 'Version identifier for the survey template following semantic versioning to track template evolution and changes over time.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this survey template record, supporting audit trail and accountability.',
    CONSTRAINT pk_survey_template PRIMARY KEY(`survey_template_id`)
) COMMENT 'Master reference table for survey_template. Referenced by survey_template_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` (
    `review_topic_extraction_id` BIGINT COMMENT '',
    `online_review_id` BIGINT COMMENT 'add column online_review_id (BIGINT) with FK to experience.online_review.online_review_id - review topic extractions must link to the source review.',
    `profile_id` BIGINT COMMENT '',
    `review_id` BIGINT COMMENT '',
    `extracted_at` TIMESTAMP COMMENT '',
    `model_version` STRING COMMENT '',
    `topic_confidence_score` DECIMAL(18,2) COMMENT '',
    `topic_keywords` STRING COMMENT '',
    `topic_label` STRING COMMENT '',
    CONSTRAINT pk_review_topic_extraction PRIMARY KEY(`review_topic_extraction_id`)
) COMMENT 'Stores review topic extraction records for the experience domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` (
    `feedback_topic_id` BIGINT COMMENT 'Primary key for feedback_topic',
    `guest_feedback_id` BIGINT COMMENT '',
    `feedback_review_topic_assignment_id` BIGINT COMMENT '',
    `profile_id` BIGINT COMMENT '',
    `extracted_at` TIMESTAMP COMMENT '',
    `model_version` STRING COMMENT '',
    `sentiment_alignment` STRING COMMENT '',
    `topic_confidence_score` DECIMAL(18,2) COMMENT '',
    `topic_keywords` STRING COMMENT '',
    `topic_label` STRING COMMENT '',
    CONSTRAINT pk_feedback_topic PRIMARY KEY(`feedback_topic_id`)
) COMMENT 'Stores feedback topic records for the experience domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` (
    `feedback_review_topic_assignment_id` BIGINT COMMENT '',
    `guest_feedback_id` BIGINT COMMENT '',
    `online_review_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `extracted_timestamp` TIMESTAMP COMMENT '',
    `extraction_score` DECIMAL(18,2) COMMENT '',
    `model_version` STRING COMMENT 'Version of the NLP model used for extraction',
    `sentiment_score` STRING COMMENT '',
    `source_text_ref` STRING COMMENT '',
    `topic` STRING COMMENT '',
    `topic_confidence` STRING COMMENT '',
    `topic_label` STRING COMMENT '',
    CONSTRAINT pk_feedback_review_topic_assignment PRIMARY KEY(`feedback_review_topic_assignment_id`)
) COMMENT 'Records each feedback review topic assignment in the experience domain, capturing its key attributes and relationships.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic_extraction` (
    `feedback_topic_extraction_id` BIGINT COMMENT 'Primary key for feedback_topic_extraction',
    `guest_feedback_id` BIGINT COMMENT '',
    CONSTRAINT pk_feedback_topic_extraction PRIMARY KEY(`feedback_topic_extraction_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ADD CONSTRAINT `fk_experience_nps_survey_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ADD CONSTRAINT `fk_experience_nps_survey_survey_template_id` FOREIGN KEY (`survey_template_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`survey_template`(`survey_template_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ADD CONSTRAINT `fk_experience_nps_survey_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_online_review_id` FOREIGN KEY (`online_review_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`online_review`(`online_review_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_reputation_alert_id` FOREIGN KEY (`reputation_alert_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`reputation_alert`(`reputation_alert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_experience_special_request_id` FOREIGN KEY (`experience_special_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`experience_special_request`(`experience_special_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_guest_experience_enrollment_id` FOREIGN KEY (`guest_experience_enrollment_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment`(`guest_experience_enrollment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_online_review_id` FOREIGN KEY (`online_review_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`online_review`(`online_review_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_follow_up_quality_audit_id` FOREIGN KEY (`follow_up_quality_audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`quality_audit`(`quality_audit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ADD CONSTRAINT `fk_experience_touchpoint_parent_touchpoint_id` FOREIGN KEY (`parent_touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ADD CONSTRAINT `fk_experience_program_treatment_inclusion_primary_experience_program_id` FOREIGN KEY (`primary_experience_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ADD CONSTRAINT `fk_experience_program_fitness_inclusion_primary_experience_program_id` FOREIGN KEY (`primary_experience_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ADD CONSTRAINT `fk_experience_survey_template_superseded_survey_template_id` FOREIGN KEY (`superseded_survey_template_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`survey_template`(`survey_template_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ADD CONSTRAINT `fk_experience_review_topic_extraction_online_review_id` FOREIGN KEY (`online_review_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`online_review`(`online_review_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ADD CONSTRAINT `fk_experience_review_topic_extraction_review_id` FOREIGN KEY (`review_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`online_review`(`online_review_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ADD CONSTRAINT `fk_experience_feedback_topic_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ADD CONSTRAINT `fk_experience_feedback_topic_feedback_review_topic_assignment_id` FOREIGN KEY (`feedback_review_topic_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment`(`feedback_review_topic_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ADD CONSTRAINT `fk_experience_feedback_review_topic_assignment_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ADD CONSTRAINT `fk_experience_feedback_review_topic_assignment_online_review_id` FOREIGN KEY (`online_review_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`online_review`(`online_review_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic_extraction` ADD CONSTRAINT `fk_experience_feedback_topic_extraction_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`experience` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`experience` SET TAGS ('dbx_domain' = 'experience');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `channel_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Booking Transaction Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `amenities_rating` SET TAGS ('dbx_business_glossary_term' = 'Amenities Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `cleanliness_rating` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Complaint Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `feedback_number` SET TAGS ('dbx_business_glossary_term' = 'Feedback Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `feedback_number` SET TAGS ('dbx_value_regex' = '^FB-[0-9]{10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `fnb_rating` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `gss_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `location_rating` SET TAGS ('dbx_business_glossary_term' = 'Location Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `nps_classification` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `nps_classification` SET TAGS ('dbx_value_regex' = 'Promoter|Passive|Detractor');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `room_rating` SET TAGS ('dbx_business_glossary_term' = 'Room Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `sentiment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `sentiment_indicator` SET TAGS ('dbx_value_regex' = 'Positive|Neutral|Negative|Mixed');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `service_rating` SET TAGS ('dbx_business_glossary_term' = 'Service Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `service_recovery_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `stay_date_from` SET TAGS ('dbx_business_glossary_term' = 'Stay Date From');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `stay_date_to` SET TAGS ('dbx_business_glossary_term' = 'Stay Date To');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `survey_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Completion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `survey_completion_status` SET TAGS ('dbx_value_regex' = 'Complete|Partial|Abandoned');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `survey_invitation_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Invitation Sent Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `value_rating` SET TAGS ('dbx_business_glossary_term' = 'Value Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `would_recommend_flag` SET TAGS ('dbx_business_glossary_term' = 'Would Recommend Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ALTER COLUMN `would_return_flag` SET TAGS ('dbx_business_glossary_term' = 'Would Return Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_template_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Template ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `anonymous_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Response Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `compliance_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `detractor_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Detractor Threshold Maximum Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'one_time|daily|weekly|monthly|quarterly|event_triggered');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `follow_up_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `incentive_description` SET TAGS ('dbx_business_glossary_term' = 'Incentive Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `incentive_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `medallia_survey_code` SET TAGS ('dbx_business_glossary_term' = 'Medallia Survey ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `multi_language_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Language Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `multi_language_enabled_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `passive_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Passive Threshold Minimum Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `promoter_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Promoter Threshold Minimum Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `property_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `property_scope` SET TAGS ('dbx_value_regex' = 'enterprise_wide|regional|property_specific|brand_specific');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `response_collection_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Collection Window (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `salt_program_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'SALT (Satisfaction and Loyalty Tracking) Program Linked Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_description` SET TAGS ('dbx_business_glossary_term' = 'Survey Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'transactional|relationship|event_based|periodic');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `target_response_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Response Rate (Percent)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`nps_survey` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` SET TAGS ('dbx_subdomain' = 'service_recovery');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `channel_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Booking Transaction Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `tertiary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `tertiary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `tertiary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `actual_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_origin` SET TAGS ('dbx_business_glossary_term' = 'Case Origin Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_origin` SET TAGS ('dbx_value_regex' = 'front_desk|call_center|ota_review|social_media|survey|loyalty_desk');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `case_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Case Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `compensation_total_value` SET TAGS ('dbx_business_glossary_term' = 'Compensation Total Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `compensation_total_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `compensation_total_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'not_escalated|escalated_to_manager|escalated_to_gm|escalated_to_corporate');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `follow_up_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `grr_outcome_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Recovery Rate (GRR) Outcome Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `guest_lifetime_value_segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Lifetime Value (LTV) Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `guest_lifetime_value_segment` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `guest_satisfaction_post_resolution` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS) Post-Resolution');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `nps_post_resolution` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Post-Resolution');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'compensation|apology|service_recovery|refund|upgrade|points_credit');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `social_media_mention_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Media Mention Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ALTER COLUMN `source_system_case_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` SET TAGS ('dbx_subdomain' = 'service_recovery');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `case_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Case Activity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `online_review_id` SET TAGS ('dbx_business_glossary_term' = 'Online Review Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `activity_number` SET TAGS ('dbx_business_glossary_term' = 'Activity Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled|deferred');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `activity_subject` SET TAGS ('dbx_business_glossary_term' = 'Activity Subject');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `agent_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Offered Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_offered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_offered_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_value` SET TAGS ('dbx_business_glossary_term' = 'Compensation Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `compensation_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Activity Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'supervisor|manager|director|regional|corporate');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `guest_communication_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Communication Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `guest_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Guest Sentiment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `guest_sentiment` SET TAGS ('dbx_value_regex' = 'very_negative|negative|neutral|positive|very_positive');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Activity Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `resolution_commitment` SET TAGS ('dbx_business_glossary_term' = 'Resolution Commitment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `resolution_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resolution Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `sla_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Milestone Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `sla_milestone_type` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Milestone Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `sla_milestone_type` SET TAGS ('dbx_value_regex' = 'first_response|acknowledgment|resolution|follow_up|closure');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` SET TAGS ('dbx_subdomain' = 'service_recovery');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `reputation_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Reputation Alert Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `tertiary_service_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `tertiary_service_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `tertiary_service_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^SRA-[0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'front_desk|supervisor|manager|general_manager|regional_director');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `authorized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorized Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|sms|mobile_app|letter');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `follow_up_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `fulfillment_notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|fulfilled|cancelled|declined');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `guest_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Acceptance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `guest_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|declined|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `is_proactive` SET TAGS ('dbx_business_glossary_term' = 'Is Proactive Recovery');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `post_recovery_gss_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Recovery Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `post_recovery_nps_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Recovery Net Promoter Score (NPS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `recovery_action_category` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `recovery_action_category` SET TAGS ('dbx_value_regex' = 'monetary|non_monetary|experiential|recognition');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `recovery_action_type` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `recovery_action_type` SET TAGS ('dbx_value_regex' = 'room_upgrade|complimentary_night|fnb_credit|loyalty_points_award|amenity_delivery|written_apology');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ALTER COLUMN `recovery_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Recovery Effectiveness Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_subdomain' = 'guest_programs');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_reference' = 'reservation.reservation_special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_mvm_ssot_role' = 'referencing');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_concept' = 'special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_references' = 'reservation.reservation_special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_duplicate' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot' = 'alias');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_authority_defer_to' = 'reservation.reservation_special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_ref' = 'reservation.reservation_special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_group' = 'special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_canonical' = 'reservation.reservation_special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `experience_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Special Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Assessment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Service Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff Member ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `reservation_special_request_id` SET TAGS ('dbx_ssot_owner' = 'reservation.reservation_special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `reservation_special_request_id` SET TAGS ('dbx_ssot_entity' = 'special_request');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Fulfillment Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `actual_fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Fulfillment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `advance_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Hours Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `charge_to_guest_amount` SET TAGS ('dbx_business_glossary_term' = 'Guest Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fulfillment Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `fulfillment_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Deadline Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `fulfillment_location` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `fulfillment_notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `guest_feedback_comment` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Comment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `guest_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Request Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `is_loyalty_member_request` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Request Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `is_repeat_request` SET TAGS ('dbx_business_glossary_term' = 'Repeat Request Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `is_service_recovery` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Request Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'standard|silver|gold|platinum|diamond');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Request Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent|vip');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Acknowledged Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_description` SET TAGS ('dbx_business_glossary_term' = 'Request Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Special Request Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Fulfillment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_subtype` SET TAGS ('dbx_business_glossary_term' = 'Special Request Subtype');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Special Request Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `requires_advance_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` SET TAGS ('dbx_subdomain' = 'journey_touchpoints');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `amenity_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Fulfillment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `experience_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Special Request Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `food_safety_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Cert Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `guest_experience_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Experience Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `amenity_category` SET TAGS ('dbx_business_glossary_term' = 'Amenity Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `amenity_code` SET TAGS ('dbx_business_glossary_term' = 'Amenity Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `amenity_description` SET TAGS ('dbx_business_glossary_term' = 'Amenity Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `amenity_name` SET TAGS ('dbx_business_glossary_term' = 'Amenity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `charge_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Posted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `delivery_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Agent Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `delivery_agent_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'pre_arrival_setup|in_room_delivery|concierge_handoff|turndown_service|check_in_delivery');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `dietary_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restrictions');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `dietary_restrictions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `folio_reference` SET TAGS ('dbx_business_glossary_term' = 'Folio Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|in_progress|delivered|cancelled|failed');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `guest_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Acknowledgment Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `guest_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Acknowledgment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `guest_feedback` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `guest_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Is Complimentary');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `occasion_type` SET TAGS ('dbx_business_glossary_term' = 'Occasion Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `scheduled_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` SET TAGS ('dbx_subdomain' = 'journey_touchpoints');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `guest_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Interaction Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `tertiary_guest_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `tertiary_guest_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `tertiary_guest_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `amenity_description` SET TAGS ('dbx_business_glossary_term' = 'Amenity Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `amenity_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Amenity Offered Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `guest_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Initiated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `guest_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_language` SET TAGS ('dbx_business_glossary_term' = 'Interaction Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_language` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_location` SET TAGS ('dbx_business_glossary_term' = 'Interaction Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_value_regex' = '^INT-[0-9]{10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_outcome` SET TAGS ('dbx_value_regex' = 'resolved|escalated|pending|referred|acknowledged|no_action_required');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_source_system` SET TAGS ('dbx_business_glossary_term' = 'Interaction Source System');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_source_system` SET TAGS ('dbx_value_regex' = 'OPERA|SALESFORCE|MEDALLIA|MOBILE_APP|KIOSK|OTHER');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `nps_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_value_regex' = 'very_positive|positive|neutral|negative|very_negative|not_assessed');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `special_request_fulfilled_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Request Fulfilled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ALTER COLUMN `vip_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Status Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` SET TAGS ('dbx_subdomain' = 'guest_programs');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Program ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `amenity_package_code` SET TAGS ('dbx_business_glossary_term' = 'Amenity Package Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `amenity_package_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Benefits Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `blackout_dates` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `booking_window_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'Guest Recognition|Service Recovery|Loyalty Enhancement|Special Occasion|Wellness|Food and Beverage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Program Cost Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `csat_target_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Target Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `eligible_property_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Property List');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `eligible_rate_plans` SET TAGS ('dbx_business_glossary_term' = 'Eligible Rate Plans');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `eligible_room_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Room Types');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'Automatic|Opt-In|Staff Assigned|Invitation Only');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `external_partner_name` SET TAGS ('dbx_business_glossary_term' = 'External Partner Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `gss_target_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS) Target Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `loyalty_tier_requirement` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `marketing_channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `maximum_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `minimum_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `nps_target_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Target Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `owner_department` SET TAGS ('dbx_value_regex' = 'Guest Experience|Loyalty|Marketing|Revenue Management|Operations|Food and Beverage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `points_redemption_eligible` SET TAGS ('dbx_business_glossary_term' = 'Points Redemption Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `points_redemption_value` SET TAGS ('dbx_business_glossary_term' = 'Points Redemption Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Pilot|Retired');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'SALT|VIP Welcome|Anniversary Package|Wellness Journey|Culinary Experience|Romance Package');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `revenue_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `salt_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction and Loyalty Tracking (SALT) Program Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `service_recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `target_guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` SET TAGS ('dbx_subdomain' = 'guest_programs');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `guest_experience_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Experience Enrollment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Experience Host ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Program ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `amenity_fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Amenity Fulfillment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `amenity_fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_progress|completed|partially_completed|failed');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|front_desk|concierge|call_center|email');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^EXP-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'guest_initiated|staff_recommended|loyalty_offer|package_inclusion|upgrade|complimentary');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `feedback_received_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Received Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `fulfillment_progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Progress Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `fulfillment_progress_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Is Complimentary');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|authorized|paid|refunded|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `post_program_csat_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Program Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `post_program_gss_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Program Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `post_program_nps_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Program Net Promoter Score (NPS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ALTER COLUMN `total_program_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Program Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `online_review_id` SET TAGS ('dbx_business_glossary_term' = 'Online Review ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `channel_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Booking Transaction Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `ota_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ota Partner Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `amenities_rating` SET TAGS ('dbx_business_glossary_term' = 'Amenities Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `cleanliness_rating` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `competitive_set_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `location_rating` SET TAGS ('dbx_business_glossary_term' = 'Location Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `management_response_status` SET TAGS ('dbx_business_glossary_term' = 'Management Response Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `management_response_status` SET TAGS ('dbx_value_regex' = 'not_responded|responded|pending_response|no_response_needed');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `management_response_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `management_response_text` SET TAGS ('dbx_business_glossary_term' = 'Management Response Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `management_response_text` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `management_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Management Response Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `management_response_timestamp` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `normalized_rating` SET TAGS ('dbx_business_glossary_term' = 'Normalized Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `platform_native_rating` SET TAGS ('dbx_business_glossary_term' = 'Platform Native Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `platform_rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Platform Rating Scale');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `platform_rating_scale` SET TAGS ('dbx_value_regex' = '1-5|1-10|1-100|percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `platform_review_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Review ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `response_author_name` SET TAGS ('dbx_business_glossary_term' = 'Response Author Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_body_text` SET TAGS ('dbx_business_glossary_term' = 'Review Body Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_helpfulness_count` SET TAGS ('dbx_business_glossary_term' = 'Review Helpfulness Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_language_code` SET TAGS ('dbx_business_glossary_term' = 'Review Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_source_url` SET TAGS ('dbx_business_glossary_term' = 'Review Source URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_title` SET TAGS ('dbx_business_glossary_term' = 'Review Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_visibility_status` SET TAGS ('dbx_business_glossary_term' = 'Review Visibility Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `review_visibility_status` SET TAGS ('dbx_value_regex' = 'published|hidden|removed|flagged|pending_moderation');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `reviewer_alias` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Alias');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `reviewer_alias` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `reviewer_location` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `service_rating` SET TAGS ('dbx_business_glossary_term' = 'Service Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `stay_end_date` SET TAGS ('dbx_business_glossary_term' = 'Stay End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `stay_start_date` SET TAGS ('dbx_business_glossary_term' = 'Stay Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `traveler_type` SET TAGS ('dbx_business_glossary_term' = 'Traveler Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `traveler_type` SET TAGS ('dbx_value_regex' = 'business|leisure|family|couple|solo|group');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `value_rating` SET TAGS ('dbx_business_glossary_term' = 'Value Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ALTER COLUMN `verified_stay_flag` SET TAGS ('dbx_business_glossary_term' = 'Verified Stay Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `reputation_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Reputation Alert ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `online_review_id` SET TAGS ('dbx_business_glossary_term' = 'Online Review Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `actual_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Response Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^ALT-[0-9]{8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'new|acknowledged|in_progress|resolved|closed|escalated');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'low_nps_threshold_breach|negative_ota_review|repeat_complaint_pattern|gss_drop|csat_threshold_breach|social_media_escalation');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `department_responsible` SET TAGS ('dbx_business_glossary_term' = 'Department Responsible');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `escalated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Guest Contact Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|in_person|sms|letter|no_contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `guest_contacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Contacted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `guest_satisfaction_post_recovery` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Post-Recovery');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `guest_satisfaction_post_recovery` SET TAGS ('dbx_value_regex' = 'satisfied|neutral|dissatisfied|not_measured');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `loyalty_points_awarded` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Awarded');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `recovery_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `recovery_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `recovery_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Recovery Cost Currency');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `recovery_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `resolution_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `sla_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Triggered Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ALTER COLUMN `variance_from_threshold` SET TAGS ('dbx_business_glossary_term' = 'Variance from Threshold');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `gss_score_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS) Score ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `bottom_box_percent` SET TAGS ('dbx_business_glossary_term' = 'Bottom Box Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `brand_qa_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Quality Assurance (QA) Review Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Score Calculation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'MEDALLIA|SALESFORCE|MANUAL|INTEGRATED');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `detractor_percent` SET TAGS ('dbx_business_glossary_term' = 'Detractor Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `gm_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'General Manager (GM) Review Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `grr_percent` SET TAGS ('dbx_business_glossary_term' = 'Guest Recovery Rate (GRR) Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'TRANSIENT|GROUP|CONTRACT|WHOLESALE|COMPLEMENTARY');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `measurement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'DAILY|WEEKLY|MONTHLY|QUARTERLY|ANNUAL');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `measurement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Score Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `passive_percent` SET TAGS ('dbx_business_glossary_term' = 'Passive Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `prior_period_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `prior_period_variance` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Variance');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `promoter_percent` SET TAGS ('dbx_business_glossary_term' = 'Promoter Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `published_flag` SET TAGS ('dbx_business_glossary_term' = 'Score Published Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Score Published Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `response_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `salt_target_attained_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction and Loyalty Tracking (SALT) Target Attainment Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `salt_target_score` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction and Loyalty Tracking (SALT) Target Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Survey Sample Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `score_band` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS) Band Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `score_band` SET TAGS ('dbx_value_regex' = 'EXCELLENT|GOOD|NEEDS_IMPROVEMENT|CRITICAL');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `service_recovery_case_count` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Case Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `surveys_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Surveys Sent Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `top_box_percent` SET TAGS ('dbx_business_glossary_term' = 'Top Box Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS) Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `yoy_score` SET TAGS ('dbx_business_glossary_term' = 'Year-over-Year (YoY) Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ALTER COLUMN `yoy_variance` SET TAGS ('dbx_business_glossary_term' = 'Year-over-Year (YoY) Variance');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` SET TAGS ('dbx_subdomain' = 'service_recovery');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `quality_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `follow_up_quality_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Quality Audit Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `follow_up_quality_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `amenity_score` SET TAGS ('dbx_business_glossary_term' = 'Amenity Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|under_review|closed|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'forbes_travel_guide|aaa_diamond|brand_standard|mystery_shop|internal_qa|health_safety');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `auditor_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Auditor Certification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `brand_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `certification_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Certification Level Achieved');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `corrective_action_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `corrective_action_completion_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `critical_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `facility_score` SET TAGS ('dbx_business_glossary_term' = 'Facility Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `fnb_score` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `gm_accountability_flag` SET TAGS ('dbx_business_glossary_term' = 'General Manager (GM) Accountability Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `housekeeping_score` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `major_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Major Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `minor_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Determination');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `prior_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Audit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `prior_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Prior Certification Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `prior_overall_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Overall Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `re_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `re_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `score_variance` SET TAGS ('dbx_business_glossary_term' = 'Score Variance');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `service_score` SET TAGS ('dbx_business_glossary_term' = 'Service Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ALTER COLUMN `spa_score` SET TAGS ('dbx_business_glossary_term' = 'Spa Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` SET TAGS ('dbx_subdomain' = 'journey_touchpoints');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `parent_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Touchpoint Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'fully_automated|semi_automated|manual|hybrid');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_category` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_category` SET TAGS ('dbx_value_regex' = 'digital|physical|voice|self-service|staff-assisted|automated');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `cost_per_interaction` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Interaction');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `cost_per_interaction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `data_privacy_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Sensitive Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `data_privacy_sensitive_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `data_privacy_sensitive_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `default_language_code` SET TAGS ('dbx_business_glossary_term' = 'Default Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `default_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `department_owner` SET TAGS ('dbx_business_glossary_term' = 'Department Owner');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_description` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `feedback_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Feedback Collection Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `feedback_collection_method` SET TAGS ('dbx_value_regex' = 'survey|direct_feedback|observation|system_log|social_media|review_platform');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `guest_effort_score_target` SET TAGS ('dbx_business_glossary_term' = 'Guest Effort Score Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `guest_segment_applicability` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Applicability');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `interaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `is_csat_eligible` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `is_gss_eligible` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS) Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `is_mandatory_touchpoint` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Touchpoint Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `is_nps_eligible` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `journey_stage` SET TAGS ('dbx_business_glossary_term' = 'Journey Stage');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `journey_stage` SET TAGS ('dbx_value_regex' = 'pre-arrival|arrival|in-stay|departure|post-stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `medallia_touchpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Medallia Touchpoint Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `multi_language_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Language Supported Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `property_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `property_scope` SET TAGS ('dbx_value_regex' = 'all_properties|brand_specific|property_specific|region_specific');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `salesforce_touchpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Touchpoint Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `salt_program_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction and Loyalty Tracking (SALT) Program Linked Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `service_recovery_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Trigger Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `staff_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Staff Training Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_status` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `touchpoint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pilot|deprecated|seasonal');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `typical_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Typical Duration in Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`touchpoint` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` SET TAGS ('dbx_subdomain' = 'guest_programs');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` SET TAGS ('dbx_association_edges' = 'experience.experience_program,spa.treatment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `program_treatment_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Program Treatment Inclusion ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `program_treatment_inclusion_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `program_treatment_inclusion_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `primary_experience_program_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Program ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Treatment Inclusion - Treatment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `blackout_dates` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `inclusion_sequence` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `quantity_included` SET TAGS ('dbx_business_glossary_term' = 'Quantity Included');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `upgrade_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` SET TAGS ('dbx_subdomain' = 'guest_programs');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` SET TAGS ('dbx_association_edges' = 'experience.experience_program,spa.fitness_class');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `program_fitness_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Program Fitness Inclusion ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Program Fitness Inclusion - Fitness Class Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `primary_experience_program_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Program ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `advance_booking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `class_selection_flexibility` SET TAGS ('dbx_business_glossary_term' = 'Class Selection Flexibility');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `priority_booking_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Booking Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `sessions_included` SET TAGS ('dbx_business_glossary_term' = 'Sessions Included');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `survey_template_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Template Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `superseded_survey_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Survey Template Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `superseded_survey_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `allows_anonymous_responses` SET TAGS ('dbx_business_glossary_term' = 'Allows Anonymous Responses');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `auto_case_creation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Case Creation Enabled');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `compliance_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewed');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `survey_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `incentive_offered` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `incentive_value` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `includes_csat_question` SET TAGS ('dbx_business_glossary_term' = 'Includes Csat Question');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `includes_nps_question` SET TAGS ('dbx_business_glossary_term' = 'Includes Nps Question');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `includes_open_feedback` SET TAGS ('dbx_business_glossary_term' = 'Includes Open Feedback');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `is_default_template` SET TAGS ('dbx_business_glossary_term' = 'Is Default Template');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `medallia_template_code` SET TAGS ('dbx_business_glossary_term' = 'Medallia Template Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `property_tier` SET TAGS ('dbx_business_glossary_term' = 'Property Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `response_window_days` SET TAGS ('dbx_business_glossary_term' = 'Response Window Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `salt_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Salt Program Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `service_recovery_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Threshold Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `survey_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `trigger_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Trigger Delay Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `review_topic_extraction_id` SET TAGS ('dbx_business_glossary_term' = 'Review Topic Extraction Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `review_topic_extraction_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `profile_id` SET TAGS ('dbx_source' = 'guest_profile');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Review Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `review_id` SET TAGS ('dbx_source' = 'review');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `extracted_at` SET TAGS ('dbx_business_glossary_term' = 'Extracted At');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `extracted_at` SET TAGS ('dbx_ml_metadata' = 'extraction_time');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `model_version` SET TAGS ('dbx_ml_metadata' = 'model_version');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `topic_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Topic Confidence Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `topic_confidence_score` SET TAGS ('dbx_ml_output' = 'confidence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `topic_keywords` SET TAGS ('dbx_business_glossary_term' = 'Topic Keywords');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `topic_keywords` SET TAGS ('dbx_ml_output' = 'keywords');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `topic_label` SET TAGS ('dbx_business_glossary_term' = 'Topic Label');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ALTER COLUMN `topic_label` SET TAGS ('dbx_ml_output' = 'topic');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `feedback_topic_id` SET TAGS ('dbx_business_glossary_term' = 'feedback_topic Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Feedback Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_source' = 'feedback');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `feedback_review_topic_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Feedback Topic Extraction Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `feedback_review_topic_assignment_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `profile_id` SET TAGS ('dbx_source' = 'guest_profile');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `extracted_at` SET TAGS ('dbx_business_glossary_term' = 'Extracted At');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `extracted_at` SET TAGS ('dbx_ml_metadata' = 'extraction_time');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `model_version` SET TAGS ('dbx_ml_metadata' = 'model_version');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `sentiment_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Alignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `sentiment_alignment` SET TAGS ('dbx_ml_output' = 'sentiment_link');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `topic_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Topic Confidence Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `topic_confidence_score` SET TAGS ('dbx_ml_output' = 'confidence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `topic_keywords` SET TAGS ('dbx_business_glossary_term' = 'Topic Keywords');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `topic_keywords` SET TAGS ('dbx_ml_output' = 'keywords');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `topic_label` SET TAGS ('dbx_business_glossary_term' = 'Topic Label');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ALTER COLUMN `topic_label` SET TAGS ('dbx_ml_output' = 'topic');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` SET TAGS ('dbx_subdomain' = 'feedback_intelligence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `feedback_review_topic_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Topic Extraction Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `online_review_id` SET TAGS ('dbx_business_glossary_term' = 'Online Review Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `extracted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Extracted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `extraction_score` SET TAGS ('dbx_business_glossary_term' = 'Extraction Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `extraction_score` SET TAGS ('dbx_reviewer_directive' = 'VREQ-024');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `source_text_ref` SET TAGS ('dbx_business_glossary_term' = 'Source Text Ref');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `source_text_ref` SET TAGS ('dbx_reviewer_directive' = 'VREQ-024');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `topic` SET TAGS ('dbx_business_glossary_term' = 'Topic');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `topic` SET TAGS ('dbx_reviewer_directive' = 'VREQ-024');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `topic` SET TAGS ('dbx_supreme_authority' = 'section_2_reviewer_comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `topic_confidence` SET TAGS ('dbx_business_glossary_term' = 'Topic Confidence');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_review_topic_assignment` ALTER COLUMN `topic_label` SET TAGS ('dbx_business_glossary_term' = 'Topic Label');
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic_extraction` SET TAGS ('dbx_data_type' = 'transactional_data');
