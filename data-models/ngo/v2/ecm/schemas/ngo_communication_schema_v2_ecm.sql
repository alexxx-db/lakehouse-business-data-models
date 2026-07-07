-- Schema for Domain: communication | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`communication` COMMENT 'Systems of record: Salesforce Marketing Cloud (National Committees), Mailchimp, CiviCRM (advocacy), social media platforms, internal comms (MS Teams, Workplace). Covers constituent messaging, advocacy, media relations, and donor stewardship.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`constituent_message` (
    `constituent_message_id` BIGINT COMMENT 'Unique identifier for the constituent message record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Identifier of the originating campaign if this message was part of a fundraising or advocacy campaign.',
    `case_record_id` BIGINT COMMENT 'Identifier of the case record if this message is related to a beneficiary case or service request.',
    `constituent_id` BIGINT COMMENT 'Identifier of the constituent (donor, beneficiary, partner, volunteer, media contact) who sent or received this message.',
    `crisis_communication_id` BIGINT COMMENT 'Foreign key linking to communication.crisis_communication. Business justification: During crisis events, the organization sends messages to constituents (donors, partners, media) as part of crisis response. This optional FK links individual messages to the crisis communication event',
    `email_broadcast_id` BIGINT COMMENT 'Foreign key linking to communication.email_broadcast. Business justification: Individual constituent messages are often generated from bulk email broadcasts. This link enables attribution tracking (which broadcast generated this message), delivery analytics, and response tracki',
    `feedback_case_id` BIGINT COMMENT 'Foreign key linking to communication.feedback_case. Business justification: Constituent messages can be part of feedback case communication threads (e.g., case updates, resolution notifications, follow-up inquiries). This link enables tracking all communications related to a ',
    `message_thread_id` BIGINT COMMENT 'Identifier linking this message to a conversation thread or email chain.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.plan. Business justification: Individual constituent messages can be part of planned communication sequences (e.g., multi-touch stewardship campaigns, advocacy sequences). This optional FK links messages to their originating plan,',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Constituent messages may report or reference safeguarding incidents requiring investigation. Supports communication monitoring, incident reporting workflows, and audit trails for donor accountability ',
    `stewardship_activity_id` BIGINT COMMENT 'Identifier of the stewardship activity if this message is part of donor cultivation or acknowledgment.',
    `user_account_id` BIGINT COMMENT 'Identifier of the staff member or user assigned to respond to or follow up on this message.',
    `attachment_count` STRING COMMENT 'Number of attachments included with this message.',
    `body_excerpt` STRING COMMENT 'Excerpt or summary of the message body content. Full body may be stored in a separate content management system.',
    `bounce_reason` STRING COMMENT 'Reason code or description if the message bounced or failed delivery (e.g., invalid address, mailbox full, spam filter).',
    `channel` STRING COMMENT 'Channel through which the message was sent or received (email, SMS, WhatsApp, postal mail, phone, IVR, web form, social media). [ENUM-REF-CANDIDATE: email|sms|whatsapp|post|phone|ivr|web_form|social_media — 8 candidates stripped; promote to reference product]',
    `clicked_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the recipient clicked any link within the message.',
    `clicked_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient first clicked a link in the message, in ISO 8601 format.',
    `complaint_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this message is a complaint or feedback requiring follow-up per CHS Commitment 5.',
    `consent_reference` STRING COMMENT 'Reference to the consent record or consent ID that authorized this communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this message record was first created in the system, in ISO 8601 format.',
    `delivery_status` STRING COMMENT 'Current delivery status of the message (sent, delivered, failed, bounced, pending, queued).. Valid values are `sent|delivered|failed|bounced|pending|queued`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the message was successfully delivered to the recipient, in ISO 8601 format.',
    `external_message_code` STRING COMMENT 'Unique identifier from the external communication platform or email service provider (e.g., Salesforce Marketing Cloud message ID, Twilio SMS ID).',
    `language_code` STRING COMMENT 'ISO 639-3 three-letter language code indicating the language of the message content.. Valid values are `^[A-Z]{3}$`',
    `message_direction` STRING COMMENT 'Direction of the message flow: inbound (received from constituent) or outbound (sent to constituent).. Valid values are `inbound|outbound`',
    `message_type` STRING COMMENT 'Type or category of the message (acknowledgment, appeal, newsletter, survey, complaint, feedback, inquiry, program update, alert, event invitation). [ENUM-REF-CANDIDATE: acknowledgment|appeal|newsletter|survey|complaint|feedback|inquiry|update|alert|invitation — 10 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this message record was last modified, in ISO 8601 format.',
    `opened_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the recipient opened the message (tracked via pixel or read receipt).',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the message was first opened by the recipient, in ISO 8601 format.',
    `opt_out_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the recipient opted out or unsubscribed as a result of this message.',
    `opt_out_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient opted out or unsubscribed, in ISO 8601 format.',
    `priority` STRING COMMENT 'Priority level of the message (low, normal, high, urgent).. Valid values are `low|normal|high|urgent`',
    `recipient_email` STRING COMMENT 'Email address of the recipient (for outbound, constituent email; for inbound, organizational email).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_name` STRING COMMENT 'Name of the recipient (for outbound messages, the constituent name; for inbound, the organizational recipient).',
    `recipient_phone` STRING COMMENT 'Phone number of the recipient (for SMS, WhatsApp, phone, or IVR channels).',
    `replied_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the recipient replied to this message.',
    `replied_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient replied to the message, in ISO 8601 format.',
    `response_due_date` DATE COMMENT 'Target date by which a response to this message is due, in yyyy-MM-dd format.',
    `response_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this message requires a response or follow-up action.',
    `sender_email` STRING COMMENT 'Email address of the sender (for outbound, organizational email; for inbound, constituent email).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Name of the sender (for outbound messages, typically the organization or staff member; for inbound, the constituent name).',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the message was sent (for outbound) or received (for inbound), in ISO 8601 format.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score of the message content, ranging from -1.00 (negative) to +1.00 (positive).',
    `subject` STRING COMMENT 'Subject line or title of the message.',
    CONSTRAINT pk_constituent_message PRIMARY KEY(`constituent_message_id`)
) COMMENT 'Core transactional record of every outbound or inbound message exchanged with an individual constituent (donor, beneficiary, partner, volunteer, media contact). Captures channel (email, SMS, WhatsApp, post, phone, IVR), direction (inbound/outbound), subject, body excerpt, delivery status, open/click tracking, opt-out flags, consent reference, language, and linkage to the originating campaign, case, broadcast, or stewardship activity. Serves as the atomic communication event enabling full constituent interaction history and audit trail. Distinct from email_broadcast which is the batch-level record; constituent_message is the per-recipient delivery record. Sourced primarily from Salesforce Nonprofit Cloud constituent tracking and campaign management modules.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` (
    `advocacy_campaign_id` BIGINT COMMENT 'Unique identifier for the advocacy campaign. Primary key.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Advocacy campaigns must comply with donor restrictions (political activity limits, lobbying prohibitions, earmarking constraints). Real process: campaign compliance review validates campaign against d',
    `media_contact_id` BIGINT COMMENT 'Foreign key linking to communication.media_contact. Business justification: advocacy_campaign currently duplicates media contact details (media_contact_name, media_contact_email, media_contact_phone). The media_contact master product exists with PK media_contact_id. This FK n',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Advocacy campaigns are typically owned and budgeted at organizational unit level (country office, regional department) for accountability, budget tracking, and performance reporting. Nonprofit domain ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.communication_plan. Business justification: Advocacy campaigns are typically executed as part of broader communication plans. This link enables tracking campaign deliverables against plan objectives, budget allocation from plan to campaign, and',
    `actual_engagement_count` STRING COMMENT 'The actual number of meaningful engagements (clicks, shares, responses, sign-ups) generated by the campaign.',
    `actual_fundraising_amount` DECIMAL(18,2) COMMENT 'The actual fundraising revenue generated by the campaign to date, tracked through gift processing and donor management systems.',
    `actual_reach_count` STRING COMMENT 'The actual number of individuals or households reached or engaged by the campaign, measured through analytics and tracking systems.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total amount actually spent on the campaign to date, tracked for budget versus actual (BvA) reporting and financial stewardship.',
    `approval_date` DATE COMMENT 'The date when the campaign was formally approved by leadership or compliance team to proceed.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget allocated to the campaign for all activities, including creative development, media buys, event costs, and staff time.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount (e.g., USD, EUR, GBP).',
    `call_to_action` STRING COMMENT 'The specific action the campaign asks constituents to take, such as donate, sign a petition, attend an event, share content, or contact a legislator.',
    `campaign_code` STRING COMMENT 'Short alphanumeric code used for internal tracking, reporting, and integration with donor management and financial systems.',
    `campaign_description` STRING COMMENT 'Detailed narrative description of the campaign purpose, strategy, key messages, and expected impact.',
    `campaign_goal` STRING COMMENT 'Primary objective or intended outcome of the campaign, such as raising awareness for a specific issue, mobilizing advocacy actions, generating donations, or influencing policy change.',
    `campaign_name` STRING COMMENT 'The official name of the advocacy, awareness, or fundraising campaign as recognized by the communications team and stakeholders.',
    `campaign_owner_name` STRING COMMENT 'Name of the staff member or team responsible for managing and executing the campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign: planned (in design phase), active (currently running), paused (temporarily suspended), completed (finished and closed), cancelled (terminated before completion), or archived (historical record).. Valid values are `planned|active|paused|completed|cancelled|archived`',
    `campaign_type` STRING COMMENT 'Classification of the campaign delivery method: digital (social media, email, web), direct mail (postal outreach), event-based (conferences, rallies), media (TV, radio, press), grassroots (community organizing), or hybrid (multi-channel).. Valid values are `digital|direct_mail|event_based|media|grassroots|hybrid`',
    `closeout_date` DATE COMMENT 'The date when the campaign was formally closed out, including final reporting, financial reconciliation, and archival of materials.',
    `compliance_review_status` STRING COMMENT 'Status of internal compliance and legal review for campaign messaging and materials: pending (under review), approved (cleared for launch), rejected (requires revision), or not_required (no review needed).. Valid values are `pending|approved|rejected|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign record was first created in the system.',
    `end_date` DATE COMMENT 'The planned or actual date when the campaign concludes. Null for ongoing campaigns without a defined end.',
    `geographic_focus` STRING COMMENT 'Geographic scope or target region for the campaign, such as global, regional (e.g., Sub-Saharan Africa), national, or local (e.g., specific city or community).',
    `hashtag_primary` STRING COMMENT 'The primary social media hashtag used to promote and track the campaign on digital platforms.',
    `hashtag_secondary` STRING COMMENT 'Additional social media hashtags used in the campaign. Comma-separated list.',
    `is_donor_restricted` BOOLEAN COMMENT 'Indicates whether the campaign is funded by donor-restricted grants or contributions that limit how funds can be used. True if restricted, False if unrestricted.',
    `language_primary` STRING COMMENT 'The primary language in which campaign materials and messaging are delivered (e.g., English, Spanish, French, Arabic).',
    `language_secondary` STRING COMMENT 'Additional languages in which campaign materials are available, if applicable. Comma-separated list.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign record was last updated or modified.',
    `launch_date` DATE COMMENT 'The date when the campaign was officially launched to the public or target audience. May differ from start_date if there was a soft launch or pilot phase.',
    `partner_organization_names` STRING COMMENT 'Comma-separated list of partner organizations, Civil Society Organizations (CSO), Community-Based Organizations (CBO), or International Non-Governmental Organizations (INGO) collaborating on the campaign.',
    `primary_channel_mix` STRING COMMENT 'Comma-separated list or description of the primary communication channels used in the campaign (e.g., social media, email, direct mail, events, media relations).',
    `sdg_alignment_tags` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal (SDG) numbers or names that this campaign supports or aligns with (e.g., SDG 1: No Poverty, SDG 3: Good Health and Well-being).',
    `start_date` DATE COMMENT 'The date when the campaign officially begins or launched to the public.',
    `target_audience_segment` STRING COMMENT 'Description of the primary audience or constituent segment the campaign is designed to reach, such as major donors, youth advocates, policy makers, or general public.',
    `target_engagement_count` STRING COMMENT 'The planned number of meaningful engagements (clicks, shares, responses, sign-ups) the campaign aims to generate.',
    `target_fundraising_amount` DECIMAL(18,2) COMMENT 'The fundraising revenue goal for the campaign, if applicable. Null for non-fundraising campaigns.',
    `target_reach_count` STRING COMMENT 'The planned number of individuals or households the campaign aims to reach or engage.',
    `theme` STRING COMMENT 'The overarching theme or narrative of the campaign, such as humanitarian response, climate action, gender equality, or education access.',
    `website_url` STRING COMMENT 'The URL of the dedicated campaign landing page or microsite where constituents can learn more and take action.',
    CONSTRAINT pk_advocacy_campaign PRIMARY KEY(`advocacy_campaign_id`)
) COMMENT 'Advocacy or public engagement campaign. Source systems: Salesforce Marketing Cloud (National Committees), CiviCRM, Engaging Networks, social media management platforms. Systems-of-record: Salesforce Marketing Cloud, internal advocacy platforms. Framework: Grand Bargain commitments / IATI activity reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` (
    `campaign_touchpoint_id` BIGINT COMMENT 'Unique identifier for the campaign touchpoint record. Primary key.',
    `advocacy_campaign_id` BIGINT COMMENT 'Foreign key linking to communication.advocacy_campaign. Business justification: campaign_touchpoint currently has campaign_id pointing to communication.campaign (cross-domain, enterprise-wide campaigns). However, advocacy_campaign is the communication domains campaign master for advocac',
    `campaign_id` BIGINT COMMENT 'Identifier of the advocacy or fundraising campaign associated with this touchpoint. Links to the campaign master record.',
    `constituent_id` BIGINT COMMENT 'Identifier of the constituent (donor, volunteer, advocate, or beneficiary) who interacted with the campaign. Links to the constituent master record in Salesforce Nonprofit Cloud.',
    `appeal_code` STRING COMMENT 'The specific appeal or sub-campaign code associated with this touchpoint. Enables granular tracking of campaign variants and A/B testing results.',
    `attribution_source` STRING COMMENT 'The marketing source or referral channel that led the constituent to this touchpoint (e.g., Google Ads, Facebook Campaign, Email Newsletter, Partner Organization Referral). Supports multi-touch attribution modeling.',
    `campaign_member_status` STRING COMMENT 'The current status of the constituents membership in the campaign (e.g., Sent, Responded, Converted, Opted Out). Reflects the constituents position in the campaign lifecycle.',
    `channel` STRING COMMENT 'The communication channel through which the constituent interacted with the campaign. Supports multi-channel attribution analysis. [ENUM-REF-CANDIDATE: email|web|mobile_app|social_media|sms|direct_mail|phone|in_person — 8 candidates stripped; promote to reference product]',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether this touchpoint resulted in a conversion event (e.g., donation made, petition signed, event registration completed). True if converted, False otherwise.',
    `conversion_type` STRING COMMENT 'The type of conversion achieved through this touchpoint, if any. Null or none if no conversion occurred.. Valid values are `donation|petition|event_registration|volunteer_signup|advocacy_action|none`',
    `conversion_value_usd` DECIMAL(18,2) COMMENT 'The monetary value associated with the conversion, if applicable (e.g., donation amount). Expressed in US Dollars for standardized Return on Investment (ROI) analysis. Null for non-monetary conversions.',
    `cost_per_touchpoint_usd` DECIMAL(18,2) COMMENT 'The allocated marketing cost associated with generating this specific touchpoint, expressed in US Dollars. Used for campaign Return on Investment (ROI) and cost-effectiveness analysis.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country from which the constituent engaged. Standardized for international campaign reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this campaign touchpoint record was first created in the system. Used for data lineage and audit trail purposes.',
    `device_type` STRING COMMENT 'The type of device used by the constituent to interact with the campaign. Informs mobile-first design decisions and channel optimization.. Valid values are `desktop|mobile|tablet|unknown`',
    `engagement_score` STRING COMMENT 'A calculated score representing the depth and quality of constituent engagement with this touchpoint. Higher scores indicate more meaningful interactions. Used for constituent segmentation and predictive modeling.',
    `feedback_provided_flag` BOOLEAN COMMENT 'Indicates whether the constituent provided feedback or comments as part of this touchpoint interaction. Aligns with Core Humanitarian Standard (CHS) Commitment 5 on feedback and complaints mechanisms.',
    `feedback_text` DECIMAL(18,2) COMMENT 'The verbatim feedback or comment provided by the constituent during this touchpoint interaction. Supports qualitative analysis and constituent sentiment tracking.',
    `geographic_location` STRING COMMENT 'The geographic location (city, region, or country) from which the constituent engaged with the campaign. Supports geographic segmentation and localized campaign strategies.',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code representing the language in which the campaign communication was delivered. Supports multilingual campaign management.. Valid values are `^[a-z]{2}$`',
    `message_subject` STRING COMMENT 'The subject line or headline of the communication that generated this touchpoint (e.g., email subject, social media post headline). Used for content performance analysis.',
    `message_variant` STRING COMMENT 'The specific variant or version of the campaign message (e.g., Version A, Version B, Control Group). Supports A/B testing and multivariate campaign analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this campaign touchpoint record was last modified. Supports change tracking and data quality monitoring.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the constituent opted out of future campaign communications as a result of this touchpoint. True if opted out, False otherwise.',
    `partner_organization` STRING COMMENT 'The name of the partner Civil Society Organization (CSO), Community-Based Organization (CBO), or International Non-Governmental Organization (INGO) that facilitated or co-sponsored this touchpoint, if applicable.',
    `response_action` STRING COMMENT 'Detailed description of the specific action taken by the constituent (e.g., Signed petition for clean water access, Donated $50 to emergency relief fund, Registered for virtual advocacy training).',
    `response_date` DATE COMMENT 'The date on which the constituent responded to or interacted with the campaign. Used for time-series analysis and campaign velocity tracking.',
    `response_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the constituent interaction occurred. Enables granular engagement timing analysis and real-time campaign monitoring.',
    `sdg_alignment` STRING COMMENT 'The United Nations Sustainable Development Goal(s) that this campaign touchpoint supports (e.g., SDG 1: No Poverty, SDG 6: Clean Water and Sanitation). Enables impact reporting aligned with global development frameworks.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'A sentiment analysis score ranging from -1.00 (very negative) to +1.00 (very positive) derived from feedback text or interaction behavior. Used for constituent satisfaction monitoring.',
    `time_to_conversion_hours` STRING COMMENT 'The number of hours elapsed between the initial campaign exposure and this touchpoint conversion. Null if no conversion occurred. Used for campaign velocity and urgency analysis.',
    `touchpoint_sequence` STRING COMMENT 'The sequential order of this touchpoint within the constituents overall campaign journey. Enables path analysis and multi-touch attribution modeling.',
    `touchpoint_type` STRING COMMENT 'The type of interaction or engagement action taken by the constituent in response to the campaign. Examples include email opened, petition signed, event attended, donation made, social media share.. Valid values are `email_open|email_click|petition_sign|event_attend|donation|social_share`',
    `unsubscribe_reason` STRING COMMENT 'The reason provided by the constituent for opting out or unsubscribing from campaign communications. Null if no opt-out occurred.',
    CONSTRAINT pk_campaign_touchpoint PRIMARY KEY(`campaign_touchpoint_id`)
) COMMENT 'Transactional record linking a specific constituent to a specific advocacy campaign interaction — e.g., email opened, petition signed, event attended, donation made in response to a campaign appeal. Captures touchpoint type, channel, response action, response date, attribution source, and conversion flag. Enables multi-touch attribution and campaign ROI analysis at the constituent level. Sourced from Salesforce Nonprofit Cloud Campaign Member object.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` (
    `feedback_submission_id` BIGINT COMMENT 'Unique identifier for the feedback submission record. Primary key.',
    `feedback_case_id` BIGINT COMMENT 'Foreign key linking to communication.feedback_case. Business justification: Feedback submissions escalate into or are managed through feedback cases. This represents the lifecycle progression from initial submission to formal case management. N:1 relationship - many submissio',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that the feedback relates to, if applicable.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Beneficiary feedback often references specific partner organizations delivering services. Routes complaints/compliments to responsible partners, tracks partner-specific feedback trends for performance',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or case worker assigned to investigate and resolve the feedback.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project site or field location where the feedback originated.',
    `registrant_id` BIGINT COMMENT 'Reference to the registered beneficiary who submitted the feedback, if applicable and identifiable.',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Direct intake routing for protection-related submissions. Enables immediate escalation of safeguarding concerns reported through feedback channels, supporting duty of care and survivor-centered respon',
    `action_taken` STRING COMMENT 'Summary of the corrective or responsive action taken to address the feedback or complaint.',
    `actual_resolution_date` DATE COMMENT 'Actual date when the feedback was resolved and closed.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (state, province, governorate) where the feedback originated.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (district, county) where the feedback originated.',
    `assigned_date` DATE COMMENT 'Date when the feedback was assigned to a staff member for investigation and resolution.',
    `channel` STRING COMMENT 'Channel through which the feedback was received (hotline, SMS, email, web form, mobile app, community meeting, field worker, suggestion box). [ENUM-REF-CANDIDATE: hotline|sms|email|web_form|mobile_app|community_meeting|field_worker|suggestion_box — 8 candidates stripped; promote to reference product]',
    `community_name` STRING COMMENT 'Name of the community, village, or settlement where the feedback originated.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the feedback was submitted (e.g., USA, GBR, SYR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feedback submission record was first created in the data warehouse.',
    `escalation_date` DATE COMMENT 'Date when the feedback was escalated to a higher authority or specialized team.',
    `feedback_category` DECIMAL(18,2) COMMENT 'Primary classification of the feedback type: complaint, suggestion, appreciation, query, concern, or request.',
    `feedback_subcategory` DECIMAL(18,2) COMMENT 'Detailed subcategory or topic area of the feedback (e.g., service quality, staff behavior, distribution timing, program eligibility, safety concern).',
    `feedback_text` DECIMAL(18,2) COMMENT 'Full text content of the feedback, complaint, suggestion, or query as submitted by the beneficiary or community member.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up contact with the submitter to verify satisfaction and closure.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up contact with the submitter is required after initial resolution.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the feedback was submitted anonymously (true) or with identifying information (false).',
    `is_sensitive` BOOLEAN COMMENT 'Indicates whether the feedback involves sensitive topics such as Gender-Based Violence (GBV), Protection concerns, Sexual Exploitation and Abuse (SEA), or fraud allegations.',
    `language_code` STRING COMMENT 'ISO 639 language code in which the feedback was submitted (e.g., en, fr, ar, es).. Valid values are `^[a-z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this feedback submission record was last updated in the data warehouse.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the feedback submission location, if captured.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the feedback submission location, if captured.',
    `requires_escalation` BOOLEAN COMMENT 'Indicates whether the feedback requires escalation to senior management, protection specialists, or external authorities.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation, actions taken, and resolution outcome.',
    `resolution_status` STRING COMMENT 'Current status of the feedback resolution workflow: received, under review, investigating, action taken, resolved, closed, or escalated. [ENUM-REF-CANDIDATE: received|under_review|investigating|action_taken|resolved|closed|escalated — 7 candidates stripped; promote to reference product]',
    `severity_level` STRING COMMENT 'Urgency and severity classification of the feedback or complaint: critical, high, medium, low, or informational.. Valid values are `critical|high|medium|low|informational`',
    `source_record_reference` STRING COMMENT 'Unique identifier of the feedback record in the source operational system for traceability and reconciliation.',
    `submission_date` DATE COMMENT 'Date when the feedback or complaint was submitted by the beneficiary or community member.',
    `submission_reference_number` STRING COMMENT 'Externally-visible unique reference number for tracking and follow-up. Format: FB-YYYYMMDD-XXXXXX.. Valid values are `^FB-[0-9]{8}-[A-Z0-9]{6}$`',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the feedback was received, including timezone information.',
    `submitter_email` STRING COMMENT 'Email address of the submitter for follow-up communication. May be null if submission is anonymous.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `submitter_name` STRING COMMENT 'Name of the person submitting the feedback. May be null if submission is anonymous.',
    `submitter_phone` STRING COMMENT 'Contact phone number of the submitter for follow-up. May be null if submission is anonymous.',
    `submitter_satisfaction_rating` STRING COMMENT 'Satisfaction rating provided by the submitter regarding the resolution process and outcome, typically on a scale of 1-5.',
    `target_resolution_date` DATE COMMENT 'Target date by which the feedback should be resolved, based on severity and organizational Service Level Agreement (SLA).',
    `translated_feedback_text` DECIMAL(18,2) COMMENT 'Translation of the feedback text into the organizations primary working language, if translation was performed.',
    CONSTRAINT pk_feedback_submission PRIMARY KEY(`feedback_submission_id`)
) COMMENT 'Transactional record of beneficiary or community feedback and complaints received through any channel (hotline, SMS, community meeting, digital form, field worker). Aligned to CHS Commitment 5 (Complaints and Feedback Mechanisms). Captures submission date, channel, submitter anonymity flag, feedback category (complaint, suggestion, appreciation, query), severity, language, geographic location, and current resolution status. Sourced from KoboToolbox field data collection and CommCare mobile case management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`feedback_case` (
    `feedback_case_id` BIGINT COMMENT 'Unique identifier for the feedback case record. Primary key for the feedback case lifecycle management entity.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Serious feedback cases (fraud, abuse, misconduct allegations) escalate to formal compliance incidents. Real process: case-to-incident conversion when allegations meet incident threshold criteria per o',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Feedback cases trigger compliance obligations (safeguarding reporting, donor notification, regulatory disclosure). Real process: case escalation workflow determines which obligations must be fulfilled',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project to which the feedback or complaint relates. Enables program-level accountability reporting.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Cases requiring investigation or follow-up often involve partner-implemented activities. Assigns accountability, coordinates resolution with partners, and feeds into partner performance reviews and ri',
    `project_site_id` BIGINT COMMENT 'Identifier of the field site or location where the feedback or complaint originated. Supports geographic analysis of accountability trends.',
    `registrant_id` BIGINT COMMENT 'Identifier of the beneficiary or constituent who submitted the feedback or complaint. May be null for anonymous submissions.',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Feedback cases escalate to formal safeguarding incidents when involving abuse, exploitation, or protection concerns. Critical for feedback triage workflow, case management, and regulatory reporting re',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or volunteer assigned as the primary owner responsible for investigating and resolving the case.',
    `assigned_date` DATE COMMENT 'Date when the case was assigned to a case owner for investigation and resolution.',
    `case_category` STRING COMMENT 'Primary thematic category of the feedback or complaint. Enables aggregation and trend analysis by subject area. [ENUM-REF-CANDIDATE: program_quality|staff_conduct|access_barriers|communication|safeguarding|protection|service_delivery|accountability — 8 candidates stripped; promote to reference product]',
    `case_number` STRING COMMENT 'Externally-visible unique case identifier assigned to the feedback or complaint for tracking and reference purposes. Format: FC-YYYYNNNN.. Valid values are `^FC-[0-9]{8}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the feedback case. Tracks progression from initial receipt through resolution and closure.. Valid values are `new|assigned|in_progress|escalated|resolved|closed`',
    `case_subcategory` STRING COMMENT 'Detailed subcategory providing additional granularity within the primary case category. Supports root cause analysis and targeted improvement actions.',
    `case_summary` STRING COMMENT 'Concise summary of the feedback or complaint content, capturing the key issue or concern raised by the submitter.',
    `case_type` STRING COMMENT 'Classification of the case based on the nature of the submission. Distinguishes between positive feedback, complaints requiring action, suggestions for improvement, and general inquiries.. Valid values are `feedback|complaint|suggestion|inquiry|compliment|grievance`',
    `closed_date` DATE COMMENT 'Date when the case was formally closed after resolution confirmation and any follow-up activities completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the case record was first created in the system. Audit trail for record creation.',
    `escalation_tier` STRING COMMENT 'Current escalation level of the case. L1 represents frontline resolution, L2 represents supervisory escalation, L3 represents senior management or specialized team escalation.. Valid values are `L1|L2|L3`',
    `investigation_notes` STRING COMMENT 'Detailed notes documenting the investigation process, findings, and evidence gathered during case resolution.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the feedback or complaint was submitted anonymously without identifying information. True if anonymous, False if identified.',
    `is_sensitive` BOOLEAN COMMENT 'Indicates whether the case involves sensitive subject matter such as safeguarding, protection, Gender-Based Violence (GBV), or Sexual Exploitation and Abuse (SEA). Triggers restricted access and specialized handling protocols.',
    `language_of_submission` STRING COMMENT 'Language in which the feedback or complaint was originally submitted. Supports accessibility monitoring and language service planning.',
    `lessons_learned` STRING COMMENT 'Key lessons and insights derived from the case that can inform future program design, staff training, or policy development. Supports Monitoring Evaluation and Learning (MEL) frameworks.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the case record was last modified. Audit trail for record updates and case progression tracking.',
    `priority_level` STRING COMMENT 'Urgency and importance rating assigned to the case. Critical priority includes safeguarding and protection concerns requiring immediate escalation.. Valid values are `low|medium|high|critical`',
    `received_date` DATE COMMENT 'Date when the feedback or complaint was first received by the organization through any channel. Serves as the baseline for SLA tracking.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time when the feedback or complaint was first received. Provides granular tracking for time-sensitive cases.',
    `referral_organization` STRING COMMENT 'Name of the external organization or partner to which the case was referred for specialized support or services.',
    `referral_pathway` STRING COMMENT 'Specialized service pathway to which the case was referred for expert handling. Critical for protection and safeguarding cases requiring multi-agency coordination. [ENUM-REF-CANDIDATE: none|protection|safeguarding|gbv|sea|health|legal|psychosocial|programmatic — 9 candidates stripped; promote to reference product]',
    `requires_translation` BOOLEAN COMMENT 'Indicates whether the case requires translation services for processing or response. True if translation needed, False otherwise.',
    `resolution_action_taken` STRING COMMENT 'Primary action taken to resolve the case. Supports accountability reporting on organizational responsiveness and corrective measures. [ENUM-REF-CANDIDATE: no_action|information_provided|apology_issued|service_corrected|staff_counseled|policy_changed|referral_made|compensation_provided — 8 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Detailed description of the actions taken to resolve the case, including corrective measures, process improvements, and response provided to the submitter.',
    `resolved_date` DATE COMMENT 'Date when the case was marked as resolved with actions completed and response provided to the submitter.',
    `response_language` STRING COMMENT 'Language in which the response was provided to the submitter. May differ from submission language based on submitter preference.',
    `response_method` STRING COMMENT 'Method used to communicate the resolution response to the submitter. Aligns with submitter communication preferences.. Valid values are `phone_call|sms|email|in_person|letter|no_response_requested`',
    `response_sent_date` DATE COMMENT 'Date when the formal response was sent to the submitter communicating the investigation findings and resolution actions.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying systemic or process-level root cause that led to the issue raised in the feedback or complaint. Informs organizational learning and continuous improvement.',
    `satisfaction_follow_up_date` DATE COMMENT 'Date when satisfaction follow-up was conducted with the submitter to assess their satisfaction with the resolution.',
    `satisfaction_follow_up_outcome` STRING COMMENT 'Result of follow-up contact with the submitter to assess satisfaction with the case resolution. Measures effectiveness of the feedback response mechanism.. Valid values are `satisfied|partially_satisfied|not_satisfied|no_response|not_contacted`',
    `sla_due_date` DATE COMMENT 'Target date by which the case must be resolved to meet SLA commitments. Calculated from receipt date plus SLA target days.',
    `sla_target_days` STRING COMMENT 'Number of calendar days within which the case must be resolved according to organizational service level agreement commitments. Varies by case type and priority.',
    `submission_channel` STRING COMMENT 'Channel or mechanism through which the feedback or complaint was received. Supports channel effectiveness analysis and accessibility monitoring. [ENUM-REF-CANDIDATE: hotline|sms|email|web_form|mobile_app|in_person|suggestion_box|community_meeting|focus_group — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_feedback_case PRIMARY KEY(`feedback_case_id`)
) COMMENT 'Master record representing the lifecycle management of a beneficiary feedback or complaint from receipt through resolution, aligned to Core Humanitarian Standard (CHS) Commitment 5. Groups one or more feedback_submission records into a managed case with assigned owner, escalation tier (L1/L2/L3), SLA target days, resolution notes, closure date, satisfaction follow-up outcome, and referral pathway (protection, safeguarding, programmatic). Supports accountability reporting under CHS, Sphere Standards, and MEAL frameworks. Sourced from Microsoft Dynamics 365 Case Management module.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`media_contact` (
    `media_contact_id` BIGINT COMMENT 'Unique identifier for the media contact record. Primary key for the media contact entity.',
    `country_id` BIGINT COMMENT 'Connect field.media_contact by adding column country_id (BIGINT) with FK to field.country.country_id because media_contact has zero outbound FKs. P12: connect_table: field.media_contact** - add column country_id (BIGINT) wit',
    `beat_focus` STRING COMMENT 'Primary subject area or beat covered by the journalist (e.g., humanitarian affairs, international development, health, education, disaster relief, SDGs, refugee crisis, WASH, GBV).',
    `blacklist_reason` STRING COMMENT 'Explanation or justification for blacklisting the media contact, including date and nature of the incident.',
    `blacklist_status` BOOLEAN COMMENT 'Indicates whether the media contact is blacklisted or restricted from receiving organizational communications due to past misrepresentation, breach of embargo, or other policy violations (True if blacklisted, False otherwise).',
    `circulation_reach` STRING COMMENT 'Estimated audience size, circulation, or follower count of the media outlet or the individual media contacts platform.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the media contact record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated or manual assessment of the completeness and accuracy of the media contact record, typically on a scale of 0.00 to 100.00.',
    `embargo_agreement_date` DATE COMMENT 'Date on which the media contact signed or verbally agreed to embargo terms.',
    `embargo_agreement_flag` BOOLEAN COMMENT 'Indicates whether the media contact has signed or agreed to honor embargo terms for sensitive or time-restricted information releases (True if agreement exists, False otherwise).',
    `first_name` STRING COMMENT 'First name or given name of the journalist, editor, broadcaster, blogger, or media influencer.',
    `full_name` STRING COMMENT 'Complete display name of the media contact, typically concatenation of first and last name or preferred professional name.',
    `geographic_coverage` STRING COMMENT 'Geographic region or countries covered by the media contact (e.g., Sub-Saharan Africa, Middle East, Global, specific country ISO codes).',
    `influence_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the media contacts influence, reach, and impact in their coverage area, typically on a scale of 0.00 to 100.00.',
    `job_title` STRING COMMENT 'Professional title or role of the media contact (e.g., Senior Reporter, News Editor, Broadcast Producer, Freelance Journalist).',
    `last_engagement_date` DATE COMMENT 'Date of the most recent interaction, outreach, or engagement activity with the media contact (e.g., press release sent, interview conducted, event attendance).',
    `last_engagement_type` STRING COMMENT 'Type of the most recent engagement activity (press release, interview, briefing, event, email, phone call).. Valid values are `press_release|interview|briefing|event|email|phone_call`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the media contact record was most recently updated or modified.',
    `last_name` STRING COMMENT 'Last name or family name of the media contact.',
    `mobile_number` STRING COMMENT 'Mobile or cellular phone number for urgent or field-based contact.',
    `notes` STRING COMMENT 'Free-text field for additional context, relationship history, preferences, or special instructions related to the media contact.',
    `opt_in_date` DATE COMMENT 'Date on which the media contact provided consent to receive communications.',
    `opt_in_status` BOOLEAN COMMENT 'Indicates whether the media contact has explicitly opted in to receive press releases, media alerts, and organizational communications (True if opted in, False otherwise).',
    `outlet_name` STRING COMMENT 'Name of the media organization, publication, broadcast network, blog, or digital platform where the contact is employed or contributes.',
    `outlet_type` STRING COMMENT 'Classification of the media outlet format (newspaper, magazine, television, radio, online, blog, wire service, podcast). [ENUM-REF-CANDIDATE: newspaper|magazine|television|radio|online|blog|wire_service|podcast — 8 candidates stripped; promote to reference product]',
    `phone_number` STRING COMMENT 'Primary telephone number for voice contact with the media professional.',
    `preferred_contact_channel` STRING COMMENT 'The media contacts preferred method of communication (email, phone, mobile, social media, messaging app such as WhatsApp or Signal).. Valid values are `email|phone|mobile|social_media|messaging_app`',
    `primary_email` STRING COMMENT 'Primary email address for reaching the media contact for press releases, story pitches, and media inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_language` STRING COMMENT 'Primary language in which the media contact publishes or broadcasts content (ISO 639-1 two-letter language code preferred, e.g., EN, FR, ES, AR).',
    `record_status` STRING COMMENT 'Current lifecycle status of the media contact record (active, inactive, archived, duplicate).. Valid values are `active|inactive|archived|duplicate`',
    `relationship_tier` STRING COMMENT 'Classification of the strength and strategic importance of the relationship with the media contact (tier 1 strategic, tier 2 active, tier 3 occasional, tier 4 prospect).. Valid values are `tier_1_strategic|tier_2_active|tier_3_occasional|tier_4_prospect`',
    `secondary_email` STRING COMMENT 'Alternative or backup email address for the media contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `secondary_languages` STRING COMMENT 'Additional languages the media contact works in, stored as comma-separated ISO 639-1 codes.',
    `social_media_linkedin` STRING COMMENT 'LinkedIn profile URL for professional networking and relationship building.',
    `social_media_twitter` STRING COMMENT 'Twitter (X) username or handle of the media contact for social media engagement and monitoring.',
    `source_system_code` STRING COMMENT 'Unique identifier of the media contact record in the source system, used for data lineage and reconciliation.',
    `total_engagement_count` STRING COMMENT 'Cumulative number of documented engagements or interactions with this media contact since record creation.',
    CONSTRAINT pk_media_contact PRIMARY KEY(`media_contact_id`)
) COMMENT 'Master record for journalists, editors, broadcasters, bloggers, and media influencers maintained in the NGOs media relations database. Stores contact name, outlet, beat/topic focus, geographic coverage, preferred contact channel, language, relationship tier, last engagement date, embargo agreement flag, and blacklist status. Supports proactive media outreach and press release targeting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`media_activity` (
    `media_activity_id` BIGINT COMMENT 'Unique identifier for the media activity record. Primary key for tracking all media relations activities including outbound press releases and earned media coverage.',
    `campaign_id` BIGINT COMMENT 'Foreign key reference to the associated advocacy campaign, fundraising campaign, or strategic communications initiative. Links media activities to broader organizational campaigns tracked in Salesforce Nonprofit Cloud.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Press releases and media responses often address compliance incidents (investigations, audit findings, safeguarding cases). Real process: incident communication protocol requires media activity to ref',
    `crisis_communication_id` BIGINT COMMENT 'Foreign key reference to the humanitarian crisis, emergency response, or significant organizational event that prompted the media activity. Links to field operations and situation reporting (SitRep) systems.',
    `impact_story_id` BIGINT COMMENT 'Foreign key linking to communication.impact_story. Business justification: Media relations activities (press releases, media statements, interviews) frequently feature specific beneficiary impact stories. This optional FK allows tracking which impact story was showcased in e',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program or project featured in the media activity. Links media coverage to program outcomes and impact narratives for Monitoring Evaluation and Learning (MEL) reporting.',
    `media_contact_id` BIGINT COMMENT 'Foreign key linking to communication.media_contact. Business justification: Media activities involve specific journalists/media contacts. Currently journalist_name is stored as STRING; normalizing to FK allows proper relationship management, tracking engagement history, and m',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.plan. Business justification: Media relations activities (press releases, media briefings) can be planned deliverables within communication plans. This optional FK links media activities to their originating plan, supporting plan ',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers serve as spokespeople and subject matter experts for media engagement, advocacy campaigns, and public awareness initiatives. Tracking which volunteer participated in which media activity su',
    `activity_type` STRING COMMENT 'Classification of the media activity distinguishing between organization-initiated communications (outbound press releases, statements, announcements) and third-party coverage (earned media, mentions, broadcast segments). [ENUM-REF-CANDIDATE: outbound_press_release|outbound_statement|outbound_announcement|earned_coverage|media_mention|broadcast_segment|podcast_feature — 7 candidates stripped; promote to reference product]',
    `approval_date` TIMESTAMP COMMENT 'Date and time when the media activity received final approval for release. Tracks approval workflow completion. Null for earned media.',
    `approver_name` STRING COMMENT 'Name of the senior leader or communications director who provided final approval for release. Supports governance and accountability tracking. Null for earned media.',
    `author_name` STRING COMMENT 'Name of the staff member or communications professional who authored or drafted the press release or media statement. For earned media, this is the journalist or content creator byline.',
    `beneficiary_feedback_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this media activity includes or responds to beneficiary feedback, complaints, or community voices. Supports CHS Commitment 5 compliance and participatory communications tracking.',
    `chs_commitment_reference` STRING COMMENT 'Reference to the specific Core Humanitarian Standard commitment(s) addressed by the media activity, particularly CHS Commitment 5 on complaints and feedback mechanisms. Supports accountability and transparency reporting.',
    `circulation_estimate` BIGINT COMMENT 'Verified or estimated circulation, subscriber count, or audience size of the media outlet. Provides baseline for reach calculations and media value assessment.',
    `clipping_url` STRING COMMENT 'Web address or digital link to the published media coverage, press release archive, or media monitoring service clipping. Enables direct access to source content for verification and analysis.',
    `content_summary` STRING COMMENT 'Brief summary or abstract of the media content highlighting key messages, organizational mentions, and thematic focus. Supports content analysis and message tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this media activity record was first created in the system. Supports audit trail and data lineage tracking.',
    `distribution_channel` STRING COMMENT 'Primary channel or mechanism used to distribute the press release or statement to media contacts. Supports channel effectiveness analysis. Null for earned media. [ENUM-REF-CANDIDATE: wire_service|email_direct|website|social_media|media_portal|press_conference|multiple_channels — 7 candidates stripped; promote to reference product]',
    `embargo_date` TIMESTAMP COMMENT 'Date and time before which the media content must not be published or disclosed. Used for coordinated release timing with media partners and stakeholders. Null if no embargo applies.',
    `geographic_market` STRING COMMENT 'Primary geographic market or region served by the media outlet or targeted by the release. Supports geographic segmentation and regional communications strategy. Uses country codes or regional identifiers.',
    `key_messages` STRING COMMENT 'Comma-separated list or structured text of the primary strategic messages communicated in the release or reflected in the earned coverage. Supports message penetration analysis and communications effectiveness tracking.',
    `language` STRING COMMENT 'Primary language of the media content. Supports multilingual communications tracking and localization analysis. Uses ISO 639-1 two-letter language codes.',
    `language_versions` STRING COMMENT 'Comma-separated list of additional language versions produced for this media activity. Supports multilingual outreach tracking and localization coverage analysis.',
    `media_activity_status` STRING COMMENT 'Current lifecycle state of the media activity from initial draft through approval workflow to final release or publication. Tracks progression through communications governance process. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|embargoed|released|published|archived|cancelled — 8 candidates stripped; promote to reference product]',
    `media_value_usd` DECIMAL(18,2) COMMENT 'Estimated advertising equivalency value of the earned media coverage in US dollars. Calculated based on outlet rates, placement prominence, and reach. Used for communications return on investment (ROI) analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this media activity record was last updated or modified. Supports change tracking and data quality monitoring.',
    `outlet_name` STRING COMMENT 'Name of the media organization, publication, broadcast network, podcast, or digital platform that published the earned coverage or received the outbound release. Key dimension for share-of-voice analysis.',
    `outlet_type` STRING COMMENT 'Classification of the media outlet by format and delivery mechanism. Enables media mix analysis and channel strategy optimization. [ENUM-REF-CANDIDATE: newspaper|magazine|television|radio|podcast|online_news|blog|social_media|wire_service — 9 candidates stripped; promote to reference product]',
    `pickup_count` STRING COMMENT 'Number of additional media outlets or platforms that republished, syndicated, or referenced the original press release or coverage. Measures amplification and viral reach.',
    `prominence_score` STRING COMMENT 'Numeric score (1-10 scale) rating the visibility and prominence of the organizational mention within the media coverage. Considers placement (headline vs buried), length of mention, and inclusion of key messages.',
    `publication_date` DATE COMMENT 'Date when the earned media coverage appeared in the outlet or when the outbound release was published on organizational channels. Used for temporal analysis and pickup tracking.',
    `reach_estimate` BIGINT COMMENT 'Estimated number of individuals who were exposed to the media coverage based on outlet circulation, viewership, listenership, or digital analytics. Used for media value calculation and impact assessment.',
    `release_date` TIMESTAMP COMMENT 'Official date and time when the press release or statement was issued by the organization or when earned media coverage was published. Primary temporal reference for media tracking and analysis.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goals (SDGs) that the media content addresses or promotes. Supports impact narrative alignment and SDG reporting requirements.',
    `sentiment` STRING COMMENT 'Qualitative assessment of the tone and framing of the earned media coverage toward the organization. Supports reputation monitoring and brand perception analysis aligned to Core Humanitarian Standard (CHS) accountability principles.. Valid values are `positive|neutral|negative|mixed`',
    `social_shares` STRING COMMENT 'Total count of social media shares, retweets, and reposts of the media content across digital platforms. Measures digital engagement and content virality aligned to Information and Communication Technology for Development (ICT4D) principles.',
    `spokesperson_name` STRING COMMENT 'Name of the organizational spokesperson, executive, or subject matter expert quoted in the media activity. Tracks spokesperson visibility and media training effectiveness.',
    `target_media_list` STRING COMMENT 'Comma-separated list or identifier of the media contact lists or distribution groups targeted for this release. Supports segmentation analysis and outreach effectiveness tracking. Null for earned media.',
    `title` STRING COMMENT 'The headline or title of the press release, media statement, or earned media article. Primary identifier for human recognition and content indexing.',
    CONSTRAINT pk_media_activity PRIMARY KEY(`media_activity_id`)
) COMMENT 'Master record for all media relations activities including outbound press releases, media statements, and public announcements issued by the organization, as well as earned media coverage (articles, broadcast segments, social media mentions, podcast features) referencing the organization. Captures engagement direction (outbound/earned), title, embargo date, release date, author, approver, target media list, distribution channel, outlet name, journalist, publication date, sentiment (positive/neutral/negative), reach/circulation estimate, geographic market, language versions, associated campaign or crisis event, clipping URL, and post-release pickup tracking. Enables end-to-end media relations management from release to coverage tracking, share-of-voice analysis, and reputation monitoring. PK should be media_activity_id to reflect expanded scope beyond press releases.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`impact_story` (
    `impact_story_id` BIGINT COMMENT 'Unique identifier for the impact story record. Primary key.',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Impact stories are often fund-specific for restricted fund stewardship ("Your Water Fund donation built this well"). Donor reporting workflows require direct fund-to-story linkage to show fund-specifi',
    `intervention_id` BIGINT COMMENT 'Reference to the program context in which this impact story occurred.',
    `project_site_id` BIGINT COMMENT 'Reference to the geographic project site where the story took place.',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary featured in this impact story.',
    `volunteer_deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: Deployments generate impact stories for program visibility and donor reporting. Linking deployment context to published stories supports attribution, volunteer hour valuation, and program outcome docu',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Impact stories frequently feature volunteers as storytellers for donor communications and annual reports. Nonprofits track which volunteers narrative is being shared for consent management, recogniti',
    `anonymization_required` BOOLEAN COMMENT 'Indicates whether the story must use anonymized or pseudonymized identifiers to protect the storyteller.',
    `approval_date` DATE COMMENT 'The date on which the story received final approval for publication.',
    `approval_status` STRING COMMENT 'Current workflow status of the story in the editorial and compliance approval process.. Valid values are `draft|pending_review|approved|published|archived|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the staff member who approved the story for publication.',
    `archive_date` DATE COMMENT 'The date on which the story was archived and removed from active publication channels.',
    `author_name` STRING COMMENT 'Name of the staff member, journalist, or content creator who authored or compiled the story.',
    `consent_date` DATE COMMENT 'The date on which informed consent was obtained from the storyteller or beneficiary.',
    `consent_expiry_date` DATE COMMENT 'The date on which the consent expires and the story should no longer be used without renewal.',
    `consent_status` STRING COMMENT 'Current status of informed consent from the beneficiary or storyteller for use of their story and likeness.. Valid values are `obtained|pending|declined|withdrawn|not_required`',
    `content_format` STRING COMMENT 'The primary media format in which the impact story is captured and presented.. Valid values are `text|video|photo_essay|audio|multimedia|infographic`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter code representing the country where the story took place.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the impact story record was first created in the system.',
    `donor_visibility` STRING COMMENT 'Classification indicating which donor audiences are permitted to view this story.. Valid values are `public|donor_only|restricted|internal`',
    `embargo_flag` BOOLEAN COMMENT 'Indicates whether the story is under embargo and should not be published until a specified date.',
    `embargo_until_date` DATE COMMENT 'The date until which the story is embargoed and must not be published.',
    `geographic_scope` STRING COMMENT 'The geographic scale or reach of the impact described in the story.. Valid values are `community|district|region|country|multi_country|global`',
    `impact_metric` STRING COMMENT 'Quantitative or qualitative metric that the story illustrates (e.g., lives saved, children educated, wells constructed).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for search and categorization of the story.',
    `language_code` STRING COMMENT 'ISO 639-3 three-letter code representing the primary language in which the story is written or recorded.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the impact story record was last updated or modified.',
    `media_asset_url` STRING COMMENT 'URL or file path to the primary media asset (photo, video, audio) associated with this story.',
    `photographer_name` STRING COMMENT 'Name of the photographer or videographer who captured visual content for the story.',
    `protection_flag` BOOLEAN COMMENT 'Indicates whether the story involves protection concerns (e.g., GBV, child protection, IDP status) requiring special handling.',
    `publication_channels` STRING COMMENT 'Comma-separated list of channels where this story is approved for publication (e.g., website, annual report, social media, donor newsletter).',
    `publication_date` DATE COMMENT 'The date on which the story was first published or made publicly available.',
    `sdg_alignment` STRING COMMENT 'The United Nations Sustainable Development Goals that this story illustrates or supports, stored as comma-separated SDG numbers.',
    `sensitivity_level` STRING COMMENT 'Classification of the story based on the sensitivity of the content, particularly for protection concerns such as Gender-Based Violence (GBV) or child protection.. Valid values are `public|internal|sensitive|highly_sensitive`',
    `story_narrative` STRING COMMENT 'The full narrative text of the impact story, including quotes, context, and outcomes.',
    `story_summary` STRING COMMENT 'A brief executive summary or abstract of the impact story for quick reference and indexing.',
    `story_title` STRING COMMENT 'The headline or title of the impact story used for identification and indexing.',
    `story_type` STRING COMMENT 'Classification of the impact story format and purpose.. Valid values are `beneficiary_testimonial|case_study|human_interest|program_outcome|community_impact|donor_impact`',
    `storyteller_type` STRING COMMENT 'The role or relationship of the person telling or featured in the story.. Valid values are `beneficiary|staff|volunteer|community_member|partner|donor`',
    `thematic_area` STRING COMMENT 'The primary programmatic or sectoral theme that the story addresses. [ENUM-REF-CANDIDATE: health|education|wash|nutrition|protection|livelihoods|shelter|emergency_response — 8 candidates stripped; promote to reference product]',
    `translation_available` BOOLEAN COMMENT 'Indicates whether translations of this story are available in other languages.',
    `usage_rights` STRING COMMENT 'Legal usage rights and restrictions for the story and associated media assets.. Valid values are `unrestricted|attribution_required|non_commercial|restricted|copyright_protected`',
    CONSTRAINT pk_impact_story PRIMARY KEY(`impact_story_id`)
) COMMENT 'Master record for beneficiary impact narratives, human-interest stories, and case studies used in donor communications, annual reports, and advocacy materials. Stores story title, beneficiary consent status, program context, geographic location, storyteller (staff/beneficiary/community), content format (text, video, photo essay), publication channels, approval workflow status, and embargo/sensitivity flags. Supports ethical storytelling and donor stewardship.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`digital_content` (
    `digital_content_id` BIGINT COMMENT 'Unique identifier for the digital content asset. Primary key for the digital content product.',
    `campaign_id` BIGINT COMMENT 'Identifier linking the digital content to a specific fundraising, advocacy, or communications campaign.',
    `impact_story_id` BIGINT COMMENT 'Foreign key linking to communication.impact_story. Business justification: Digital content pieces are often based on or feature impact stories. This link enables tracking which stories are being amplified through digital channels, measuring story reach, and ensuring proper c',
    `intervention_id` BIGINT COMMENT 'Identifier linking the digital content to a specific program or project for which the content provides visibility or impact storytelling.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.plan. Business justification: Communication plans define deliverables including digital content (blog posts, social media, videos). This optional FK links digital content to the communication plan that specified it, supporting pla',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who authored or created the digital content asset.',
    `tertiary_digital_author_staff_staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `account_handle` STRING COMMENT 'The specific social media account handle or username from which the content was published (e.g., @OrganizationName).',
    `actual_publish_timestamp` TIMESTAMP COMMENT 'The actual date and time when the content was published or went live on the platform.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the content was approved for publication by the designated reviewer.',
    `body_text` STRING COMMENT 'The main textual content or narrative of the digital asset, including article body, post caption, or email message content.',
    `click_through_count` BIGINT COMMENT 'Total number of clicks on links embedded within the content, driving traffic to external pages or donation forms.',
    `content_reference_number` STRING COMMENT 'Externally-visible unique reference number for the digital content asset, used for tracking and citation purposes across communications channels.. Valid values are `^DC-[0-9]{8}-[A-Z]{3}$`',
    `content_status` STRING COMMENT 'Current lifecycle status of the digital content asset in the publication workflow (draft, scheduled, published, archived, expired, withdrawn).. Valid values are `draft|scheduled|published|archived|expired|withdrawn`',
    `content_type` STRING COMMENT 'Classification of the digital content asset by format and medium (website page, blog post, social media post, email newsletter, infographic, video, podcast). [ENUM-REF-CANDIDATE: website_page|blog_post|social_media_post|email_newsletter|infographic|video|podcast — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the digital content record was first created in the content management system.',
    `engagement_comments_count` BIGINT COMMENT 'Total number of comments, replies, or direct responses received on the content.',
    `engagement_likes_count` BIGINT COMMENT 'Total number of likes, favorites, or positive reactions received on the content across the publication platform.',
    `engagement_shares_count` BIGINT COMMENT 'Total number of shares, retweets, or forwards of the content by users on the platform.',
    `expiry_date` DATE COMMENT 'The date when the content is scheduled to expire or be removed from active publication, if applicable.',
    `hashtags` STRING COMMENT 'Comma-separated list of hashtags used with the content for social media discoverability and campaign tracking (e.g., #SDG, #WASH, #HumanitarianAid).',
    `impressions_count` BIGINT COMMENT 'Total number of times the content was displayed or viewed, including multiple views by the same user.',
    `is_accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the content meets accessibility standards (WCAG 2.1 AA) for users with disabilities, including alt text, captions, and screen reader compatibility.',
    `is_brand_compliant` BOOLEAN COMMENT 'Indicates whether the content adheres to organizational brand guidelines including logo usage, color palette, tone of voice, and messaging standards.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language of the content (e.g., en, fr, es, ar).. Valid values are `^[a-z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the content was last modified or updated after initial publication.',
    `media_file_url` STRING COMMENT 'The URL of the primary media file (video, audio, PDF) associated with the content, if applicable.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `moderation_status` STRING COMMENT 'Status of content review and approval process (pending review, approved, rejected, flagged for revision).. Valid values are `pending_review|approved|rejected|flagged`',
    `platform` STRING COMMENT 'The digital platform or channel where the content is published (website, Facebook, Twitter/X, Instagram, LinkedIn, YouTube, TikTok, email). [ENUM-REF-CANDIDATE: website|facebook|twitter|instagram|linkedin|youtube|tiktok|email — 8 candidates stripped; promote to reference product]',
    `reach_count` BIGINT COMMENT 'Total number of unique users who saw the content at least once, as reported by the platform analytics.',
    `scheduled_publish_timestamp` TIMESTAMP COMMENT 'The date and time when the content was scheduled to be published, as planned in the content calendar.',
    `seo_keywords` STRING COMMENT 'Comma-separated list of keywords targeted for search engine optimization and content discoverability.',
    `seo_meta_description` STRING COMMENT 'The meta description tag providing a concise summary for search engine results pages.',
    `seo_meta_title` STRING COMMENT 'The meta title tag optimized for search engine indexing and display in search results.',
    `source_record_reference` STRING COMMENT 'The unique identifier of the content record in the originating source system, used for data lineage and reconciliation.',
    `subtitle` STRING COMMENT 'Secondary headline or subtitle providing additional context for the digital content asset.',
    `summary` STRING COMMENT 'Brief summary or excerpt of the content used for previews, social sharing, and search engine descriptions.',
    `tags` STRING COMMENT 'Comma-separated list of topical or thematic tags for content categorization and search (e.g., health, education, emergency response).',
    `target_audience` STRING COMMENT 'Primary intended audience segment for the digital content (donors, beneficiaries, partners, media, general public, staff, volunteers). [ENUM-REF-CANDIDATE: donors|beneficiaries|partners|media|general_public|staff|volunteers — 7 candidates stripped; promote to reference product]',
    `thumbnail_url` STRING COMMENT 'The URL of the thumbnail or preview image associated with the content for display in feeds and previews.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `title` STRING COMMENT 'The headline or title of the digital content asset as displayed to the audience.',
    `url` STRING COMMENT 'The full web address (URL) where the content is published and accessible online.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `video_views_count` BIGINT COMMENT 'Total number of video views or plays for video content assets, as reported by the hosting platform.',
    CONSTRAINT pk_digital_content PRIMARY KEY(`digital_content_id`)
) COMMENT 'Master record for all digital content assets produced and published by the communications team, including website pages, blog posts, social media posts (across Facebook, X/Twitter, Instagram, LinkedIn, YouTube, TikTok), email newsletters, infographics, videos, and podcasts. Captures content type, platform, title, author, target audience, publication channel, account handle, publish date, scheduled vs. actual publish time, expiry date, language, hashtags/tags, SEO metadata, accessibility compliance flag, brand guideline adherence status, engagement metrics (likes, shares, comments, reach, impressions), moderation status, campaign linkage, and content calendar slot. Serves as the single source of truth for all published communications content including social media scheduling and performance tracking. Sourced from CMS, social media management tools (Hootsuite, Sprout Social), and Salesforce Nonprofit Cloud.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` (
    `email_broadcast_id` BIGINT COMMENT 'Unique identifier for the email broadcast campaign. Primary key.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project this broadcast is promoting or reporting on.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.communication_plan. Business justification: Email broadcasts are tactical executions of strategic communication plans. Linking broadcasts to their governing plans enables tracking plan deliverables, measuring plan effectiveness, and ensuring br',
    `campaign_id` BIGINT COMMENT 'Reference to the parent fundraising or advocacy campaign this email broadcast supports.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who created or authored the email broadcast.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to donor.donor_segment. Business justification: Email broadcasts target specific donor segments (major donors, lapsed donors, monthly givers). Segment-based email campaign reporting requires direct segment linkage to analyze segment response rates,',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant if this broadcast is part of a split test (e.g., A, B, Control, Variant 1).',
    `appeal_code` STRING COMMENT 'Fundraising appeal code used for gift attribution and campaign tracking when this broadcast is part of a fundraising appeal.',
    `approval_date` DATE COMMENT 'Date the email broadcast was approved for sending.',
    `bounce_count` STRING COMMENT 'Number of emails that bounced (hard or soft bounce) and were not delivered.',
    `broadcast_name` STRING COMMENT 'Internal name or title of the email broadcast for identification and reporting purposes.',
    `broadcast_status` STRING COMMENT 'Current lifecycle status of the email broadcast: draft (being prepared), scheduled (queued for future send), sending (in progress), sent (completed), cancelled (aborted before send), or failed (technical error prevented send).. Valid values are `draft|scheduled|sending|sent|cancelled|failed`',
    `broadcast_type` STRING COMMENT 'Classification of the email broadcast purpose: newsletter (regular updates), appeal (fundraising ask), update (program progress), stewardship (donor thank you and engagement), emergency alert (urgent humanitarian response), advocacy (policy campaign), or event invitation. [ENUM-REF-CANDIDATE: newsletter|appeal|update|stewardship|emergency_alert|advocacy|event_invitation — 7 candidates stripped; promote to reference product]',
    `click_count` STRING COMMENT 'Total number of clicks on links within the email (includes multiple clicks by same recipient).',
    `compliance_check_status` STRING COMMENT 'Status of pre-send compliance verification for CAN-SPAM, GDPR consent, and organizational communication policies.. Valid values are `passed|failed|pending|not_required`',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance review findings, exceptions, or special handling requirements.',
    `consent_verified` BOOLEAN COMMENT 'Indicates whether all recipients on the list have verified opt-in consent to receive this type of communication, per GDPR and CAN-SPAM requirements.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for geographic targeting or content focus.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the email broadcast record was first created in the system.',
    `delivered_count` STRING COMMENT 'Number of emails successfully delivered to recipient inboxes.',
    `esp_platform` STRING COMMENT 'Name of the email service provider platform used to send the broadcast (e.g., Mailchimp, SendGrid, Salesforce Marketing Cloud).',
    `hard_bounce_count` STRING COMMENT 'Number of emails that hard bounced due to invalid or non-existent email addresses.',
    `is_ab_test` BOOLEAN COMMENT 'Indicates whether this broadcast is part of an A/B testing experiment.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code for the primary language of the email content.. Valid values are `^[a-z]{2}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the email broadcast record was last modified.',
    `open_count` STRING COMMENT 'Total number of times the email was opened by recipients (includes multiple opens by same recipient).',
    `reply_to_email` STRING COMMENT 'Email address where recipient replies will be directed, may differ from sender email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal numbers this broadcast content aligns with (e.g., 1,2,3 for No Poverty, Zero Hunger, Good Health).',
    `send_date` DATE COMMENT 'The date the email broadcast was sent or scheduled to be sent.',
    `send_timestamp` TIMESTAMP COMMENT 'The precise date and time the email broadcast was sent or scheduled to be sent.',
    `sender_email` STRING COMMENT 'Email address used as the from address for the broadcast.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Display name of the sender as it appears in the recipients inbox (e.g., Executive Director name, organization name).',
    `soft_bounce_count` STRING COMMENT 'Number of emails that soft bounced due to temporary issues such as full inbox or server problems.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this email broadcast in the source system for traceability and reconciliation.',
    `spam_complaint_count` STRING COMMENT 'Number of recipients who marked the email as spam or junk.',
    `subject_line` STRING COMMENT 'The email subject line text displayed to recipients in their inbox.',
    `total_recipients` STRING COMMENT 'Total number of constituent email addresses targeted for this broadcast.',
    `unique_click_count` STRING COMMENT 'Number of unique recipients who clicked at least one link in the email.',
    `unique_open_count` STRING COMMENT 'Number of unique recipients who opened the email at least once.',
    `unsubscribe_count` STRING COMMENT 'Number of recipients who unsubscribed from the mailing list as a result of this broadcast.',
    CONSTRAINT pk_email_broadcast PRIMARY KEY(`email_broadcast_id`)
) COMMENT 'Master record for each bulk email communication (newsletter, appeal, update, stewardship message, emergency alert) sent to a defined constituent segment. Captures broadcast name, subject line, sender identity, target list segment criteria, send date, total recipients, delivery rate, open rate, click-through rate, unsubscribe count, bounce count, A/B test variant flag, linked campaign, and compliance check status (CAN-SPAM, GDPR consent verification). Distinct from constituent_message which tracks individual message delivery; email_broadcast represents the batch-level campaign execution record. Sourced from Salesforce Nonprofit Cloud email campaign module and integrated ESP (Mailchimp, SendGrid).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` (
    `constituent_consent_id` BIGINT COMMENT 'Unique identifier for the constituent consent record. Primary key.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Consent requirements are driven by compliance obligations (GDPR, CCPA, donor country privacy laws). Real process: obligation defines consent type, retention period, and withdrawal rights that consent ',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or fundraising campaign that prompted or collected this consent, enabling attribution and campaign effectiveness analysis.',
    `constituent_id` BIGINT COMMENT 'Reference to the constituent (donor, volunteer, beneficiary, or other stakeholder) whose consent preferences are tracked in this record.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or system user who created this consent record in the system.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Consent records support privacy regulatory filings (GDPR Article 30 records, CCPA disclosures). Real process: annual privacy compliance reporting aggregates consent data, filing references supporting ',
    `applicable_regulation` STRING COMMENT 'The primary data protection regulation governing this consent record based on the constituents jurisdiction: GDPR (EU General Data Protection Regulation), CCPA (California Consumer Privacy Act), POPIA (South Africa Protection of Personal Information Act), LGPD (Brazil Lei Geral de Proteção de Dados), PIPEDA (Canada Personal Information Protection and Electronic Documents Act), DPA_2018 (UK Data Protection Act 2018), or other jurisdiction-specific law. [ENUM-REF-CANDIDATE: GDPR|CCPA|POPIA|LGPD|PIPEDA|DPA_2018|other — 7 candidates stripped; promote to reference product]',
    `channel_email` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has consented to receive communications via email for this consent type. True = opted in, False = opted out.',
    `channel_in_person` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has consented to in-person contact (e.g., field visits, community meetings, door-to-door outreach) for this consent type.',
    `channel_phone` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has consented to receive voice calls for this consent type.',
    `channel_postal_mail` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has consented to receive physical mail communications for this consent type.',
    `channel_sms` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has consented to receive communications via SMS/text message for this consent type.',
    `channel_social_media` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has consented to receive communications via social media platforms (Facebook, Twitter, LinkedIn, etc.) for this consent type.',
    `channel_whatsapp` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has consented to receive communications via WhatsApp messaging for this consent type. Particularly relevant for ICT4D (Information and Communication Technology for Development) community engagement.',
    `consent_basis` STRING COMMENT 'The lawful basis under data protection regulations for processing this constituents data: explicit_consent (affirmative opt-in), legitimate_interest (business interest balanced against rights), contractual (necessary for service delivery), legal_obligation, vital_interest (life-or-death), public_task.. Valid values are `explicit_consent|legitimate_interest|contractual|legal_obligation|vital_interest|public_task`',
    `consent_expiry_date` DATE COMMENT 'The date on which this consent expires and must be re-confirmed. Null for consents with no expiration. Used for time-limited consent models required by some jurisdictions.',
    `consent_granted_date` DATE COMMENT 'The date on which the constituent provided their consent or opt-in for this communication type and channel.',
    `consent_granted_timestamp` TIMESTAMP COMMENT 'Precise timestamp (including time zone) when the constituent granted consent, used for audit and compliance verification.',
    `consent_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code (e.g., en, fr, es, ar, sw) indicating the language in which the consent notice was presented to the constituent. Critical for demonstrating informed consent in multilingual humanitarian contexts.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `consent_method` STRING COMMENT 'The method or channel through which the consent was originally collected (e.g., web form, mobile app, paper form signed in field, verbal consent recorded by staff, email confirmation link, SMS reply, third-party integration). [ENUM-REF-CANDIDATE: web_form|mobile_app|paper_form|verbal|email_confirmation|sms_reply|third_party_integration — 7 candidates stripped; promote to reference product]',
    `consent_proof_document_url` STRING COMMENT 'URL or file path to a stored copy of the signed consent form, email confirmation, or other documentary evidence of consent. Critical for audit and regulatory compliance.',
    `consent_reference_number` STRING COMMENT 'Human-readable unique reference number for this consent record, used for audit trails and constituent inquiries.. Valid values are `^CONSENT-[A-Z0-9]{8,12}$`',
    `consent_source_url` STRING COMMENT 'The full URL of the web page or form where the consent was collected, used for audit and user experience analysis.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent: opted_in (active consent), opted_out (explicit refusal), pending (awaiting confirmation), expired (time-limited consent lapsed), withdrawn (previously granted but revoked).. Valid values are `opted_in|opted_out|pending|expired|withdrawn`',
    `consent_type` STRING COMMENT 'The category of communication or data processing activity for which consent is being tracked (e.g., marketing, fundraising, program updates, advocacy campaigns, research participation).. Valid values are `marketing|fundraising|program_updates|advocacy|research|general`',
    `consent_version` STRING COMMENT 'Version identifier of the consent policy or privacy notice that was in effect when this consent was granted (e.g., v1.0, v2.3). Enables tracking of consent under different policy iterations.. Valid values are `^v[0-9]+.[0-9]+$`',
    `consent_withdrawn_date` DATE COMMENT 'The date on which the constituent withdrew their previously granted consent or opted out. Null if consent has not been withdrawn.',
    `consent_withdrawn_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the constituent withdrew consent, critical for ensuring no further processing occurs after this moment.',
    `constituent_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the constituents primary country of residence or jurisdiction, used to determine applicable data protection regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this consent record was first created in the database. Distinct from consent_granted_timestamp, which reflects the real-world consent event.',
    `double_opt_in_confirmation_date` DATE COMMENT 'The date on which the constituent confirmed their consent via double opt-in process. Null if double opt-in was not used or not yet confirmed.',
    `double_opt_in_confirmed` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent has completed a double opt-in process (e.g., clicked a confirmation link sent via email). True = confirmed, False = pending confirmation or single opt-in only.',
    `ip_address` STRING COMMENT 'The IP address from which the consent was submitted, captured for audit and fraud prevention purposes. May be considered PII in some jurisdictions.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `is_minor` BOOLEAN COMMENT 'Boolean flag indicating whether the constituent was a minor (under age of consent, typically under 16 or 18 depending on jurisdiction) at the time consent was granted. Triggers additional parental/guardian consent requirements under GDPR and COPPA.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this consent record was last updated in the database.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or notes related to this consent record (e.g., specific constituent requests, unusual circumstances, staff observations).',
    `parental_consent_date` DATE COMMENT 'The date on which parental or guardian consent was obtained for a minor constituent. Null if not applicable or not obtained.',
    `parental_consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether parental or guardian consent was obtained for a minor constituent. True = parental consent obtained, False = not obtained or not applicable (constituent is not a minor).',
    `preference_content_topics` STRING COMMENT 'Comma-separated list or free-text description of specific content topics or program areas the constituent is interested in receiving communications about (e.g., WASH, education, health, emergency response, SDG alignment). Supports targeted, relevant constituent engagement.',
    `preference_frequency` STRING COMMENT 'The constituents preferred frequency for receiving communications of this type: daily, weekly, monthly, quarterly, as_needed (event-driven), or never (opted out).. Valid values are `daily|weekly|monthly|quarterly|as_needed|never`',
    `source_record_reference` STRING COMMENT 'The unique identifier of this consent record in the source operational system, used for data lineage and reconciliation.',
    `third_party_source` STRING COMMENT 'Name of the third-party platform or partner organization through which this consent was collected (e.g., Facebook Lead Ads, partner NGO, event registration platform). Null if collected directly.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured at the time of consent submission, used for audit and device/platform analytics.',
    CONSTRAINT pk_constituent_consent PRIMARY KEY(`constituent_consent_id`)
) COMMENT 'Master record tracking each constituents communication consent and preference profile — opt-in/opt-out status per channel (email, SMS, post, phone), consent basis (explicit, legitimate interest), consent date, withdrawal date, consent version, and applicable data protection regulation (GDPR, CCPA, POPIA). Ensures lawful processing of constituent communications and supports regulatory compliance. Sourced from Salesforce Nonprofit Cloud preference management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` (
    `community_engagement_event_id` BIGINT COMMENT 'Unique identifier for the community engagement event record. Primary key.',
    `community_awareness_session_id` BIGINT COMMENT 'Foreign key linking to safeguarding.community_awareness_session. Business justification: Community engagement events may BE safeguarding awareness sessions. Links community mobilization activities to protection programming, enabling tracking of awareness-raising efforts, participant reach',
    `intervention_id` BIGINT COMMENT 'Identifier of the program under which this community engagement event was conducted.',
    `feedback_case_id` BIGINT COMMENT 'Identifier of a formal feedback or complaint case that was raised or discussed during this engagement event.',
    `implementation_plan_id` BIGINT COMMENT 'Identifier of a program activity or intervention that this engagement event is linked to or supports.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partners organize and facilitate community consultations, town halls, and participatory planning sessions. Tracks which partner conducted each engagement for accountability, reporting to donors, and d',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.plan. Business justification: Community engagement events (town halls, focus groups, community meetings) are often planned activities within communication plans. This optional FK links events to their originating plan, supporting ',
    `project_site_id` BIGINT COMMENT 'Identifier of the project site or field location where the community engagement event took place.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or community health worker who facilitated the engagement event.',
    `volunteer_deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: Volunteer deployments frequently include facilitation of community engagement events (focus groups, consultations, feedback sessions). Linking deployment to event supports volunteer hour attribution, ',
    `action_points` STRING COMMENT 'List of follow-up actions, commitments, or next steps agreed upon during the community engagement event.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., state, province, region) where the event took place.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county) where the event took place.',
    `community_action_plan_output` STRING COMMENT 'Summary of the community action plan or participatory assessment outputs generated during the event.',
    `community_name` STRING COMMENT 'Name of the community, village, or settlement where the engagement event took place.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the community engagement event took place.. Valid values are `^[A-Z]{3}$`',
    `data_collection_tool` STRING COMMENT 'Name or identifier of the digital data collection tool used to capture event data (e.g., KoboToolbox form, CommCare app).',
    `duration_minutes` STRING COMMENT 'Total duration of the community engagement event in minutes.',
    `event_date` DATE COMMENT 'The calendar date on which the community engagement event took place or is scheduled to take place. Format: yyyy-MM-dd.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the community engagement event concluded. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_reference_number` STRING COMMENT 'Externally-known business identifier for the community engagement event, used for tracking and reporting purposes.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the community engagement event started. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_status` STRING COMMENT 'Current lifecycle status of the community engagement event.. Valid values are `planned|in_progress|completed|cancelled|postponed`',
    `event_type` STRING COMMENT 'Classification of the community engagement activity. FGD = Focus Group Discussion; IVR = Interactive Voice Response; U-Report = UNICEF digital engagement platform. [ENUM-REF-CANDIDATE: town_hall|fgd|community_radio|beneficiary_forum|participatory_assessment|ivr_survey|chatbot_interaction|u_report_poll|community_meeting|listening_session — 10 candidates stripped; promote to reference product]',
    `facilitator_name` STRING COMMENT 'Full name of the facilitator who led the community engagement event.',
    `feedback_received` DECIMAL(18,2) COMMENT 'Detailed feedback, suggestions, or complaints received from participants during the event.',
    `key_themes_raised` STRING COMMENT 'Summary of the main themes, concerns, or topics raised by community members during the engagement event.',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the event location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the event location in decimal degrees.',
    `participants_adults` STRING COMMENT 'Number of adult participants (typically 25-59 years), supporting age-disaggregated reporting.',
    `participants_children` STRING COMMENT 'Number of child participants (typically under 18 years), supporting age-disaggregated reporting.',
    `participants_elderly` STRING COMMENT 'Number of elderly participants (typically 60+ years), supporting age-disaggregated reporting.',
    `participants_female` STRING COMMENT 'Number of female participants, supporting gender-disaggregated reporting.',
    `participants_male` STRING COMMENT 'Number of male participants, supporting gender-disaggregated reporting.',
    `participants_other_gender` STRING COMMENT 'Number of participants identifying as other or non-binary gender, supporting inclusive gender-disaggregated reporting.',
    `participants_with_disability` STRING COMMENT 'Number of participants with disabilities, supporting inclusive programming and disability-disaggregated reporting.',
    `participants_youth` STRING COMMENT 'Number of youth participants (typically 18-24 years), supporting age-disaggregated reporting.',
    `primary_language` STRING COMMENT 'Primary language used during the community engagement event.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this community engagement event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this community engagement event record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this record in the source operational system, used for data lineage and reconciliation.',
    `total_participants` STRING COMMENT 'Total number of community members who participated in the engagement event.',
    `translation_provided` BOOLEAN COMMENT 'Indicates whether translation or interpretation services were provided during the event.',
    `venue_name` STRING COMMENT 'Name or description of the physical or virtual venue where the event was held (e.g., community center, school, online platform).',
    CONSTRAINT pk_community_engagement_event PRIMARY KEY(`community_engagement_event_id`)
) COMMENT 'Transactional record of structured community engagement activities including town halls, Focus Group Discussions (FGDs), community radio broadcasts, beneficiary forums, participatory assessments, and ICT4D-enabled digital engagement sessions (IVR surveys, chatbot interactions, U-Report polls). Captures event type, location (GPS coordinates, admin level), date, facilitator, number of participants disaggregated by gender and age, key themes raised, follow-up commitments, linkage to feedback cases or program activities, and community action plan outputs. Supports two-way communication with affected populations per CHS Commitment 4 (participation) and Commitment 5 (complaints mechanisms). Sourced from KoboToolbox and CommCare.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` (
    `donor_stewardship_touchpoint_id` BIGINT COMMENT 'Unique identifier for each donor stewardship touchpoint interaction record.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign that this stewardship touchpoint is part of or acknowledging. Links to campaign master data.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor or funder who is the recipient of this stewardship touchpoint. Links to the constituent master record in Salesforce Nonprofit Cloud or Raisers Edge NXT.',
    `impact_story_id` BIGINT COMMENT 'Reference to the specific impact narrative or beneficiary story shared with the donor during this touchpoint. Links to communications content library.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this stewardship touchpoint is reporting on or related to. Links to program master data.',
    `gift_id` BIGINT COMMENT 'Reference to the specific gift or donation that this stewardship touchpoint is acknowledging or reporting on. Links to gift transaction records.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this stewardship touchpoint is related to, for institutional funders. Links to grant award records.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.plan. Business justification: Donor stewardship touchpoints (thank-you calls, impact updates, site visits) can be planned activities within donor communication plans. This optional FK links touchpoints to their originating plan, s',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or relationship manager responsible for executing this stewardship touchpoint. Links to workforce or staff master data.',
    `approval_date` DATE COMMENT 'Date on which this stewardship touchpoint content or approach was approved by management or compliance, if approval was required.',
    `channel` STRING COMMENT 'The medium or channel through which the stewardship touchpoint was delivered to the donor. [ENUM-REF-CANDIDATE: email|phone|postal_mail|in_person|video_conference|sms|social_media — 7 candidates stripped; promote to reference product]',
    `compliance_review_status` STRING COMMENT 'Status of compliance or legal review for this touchpoint, particularly relevant for major donor communications or grant reporting touchpoints.. Valid values are `not_required|pending|approved|rejected`',
    `content_used` STRING COMMENT 'Description or identifier of the content asset used in this touchpoint, such as impact story title, annual report edition, or presentation deck name.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred for executing this stewardship touchpoint, including materials, postage, event costs, or staff time allocation.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount associated with this touchpoint.. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the touchpoint occurred or where the donor is based.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stewardship touchpoint record was first created in the source system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data quality score ranging from 0.00 to 1.00, reflecting the completeness and accuracy of this touchpoint record based on validation rules.',
    `donor_feedback_text` DECIMAL(18,2) COMMENT 'Free-text notes capturing any verbal or written feedback provided by the donor during or after this stewardship touchpoint.',
    `donor_response` STRING COMMENT 'Categorical assessment of the donors response or reaction to this stewardship touchpoint, captured by the staff owner.. Valid values are `positive|neutral|negative|no_response|follow_up_requested`',
    `donor_tier` STRING COMMENT 'Segmentation tier of the donor at the time of this touchpoint, indicating their giving level and stewardship priority. [ENUM-REF-CANDIDATE: major|principal|leadership|mid_level|annual|planned_giving|corporate|foundation — 8 candidates stripped; promote to reference product]',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up action should be completed, if follow-up is required.',
    `follow_up_notes` STRING COMMENT 'Detailed notes describing the nature of the required follow-up action and any specific donor requests or commitments.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this touchpoint requires a subsequent follow-up action or additional stewardship engagement.',
    `geographic_location` STRING COMMENT 'Geographic location where the touchpoint occurred, relevant for in-person meetings, site visits, or regional stewardship events.',
    `is_restricted_communication` BOOLEAN COMMENT 'Boolean flag indicating whether this touchpoint involves donor-restricted funds or confidential program information requiring special handling.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which this stewardship touchpoint was delivered to the donor.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stewardship touchpoint record was most recently updated in the source system.',
    `record_status` STRING COMMENT 'Current status of this touchpoint record in the data warehouse, indicating whether it is active, archived, or logically deleted.. Valid values are `active|archived|deleted`',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal numbers that the content or program discussed in this touchpoint aligns with.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Quantitative sentiment score ranging from -1.00 (very negative) to +1.00 (very positive), reflecting the donors engagement and satisfaction with this touchpoint.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this touchpoint record in the source system, used for data lineage and reconciliation.',
    `touchpoint_date` DATE COMMENT 'The date on which the stewardship touchpoint occurred or is scheduled to occur. Primary business event date for this interaction.',
    `touchpoint_reference_number` STRING COMMENT 'Business-facing unique reference number or code for this stewardship touchpoint, used for tracking and reporting purposes.',
    `touchpoint_status` STRING COMMENT 'Current lifecycle status of the stewardship touchpoint, tracking whether it has been executed or is still pending.. Valid values are `planned|scheduled|completed|cancelled|deferred`',
    `touchpoint_timestamp` TIMESTAMP COMMENT 'Precise timestamp of when the stewardship touchpoint was executed, including time-of-day for scheduled calls or meetings.',
    `touchpoint_type` STRING COMMENT 'Classification of the stewardship interaction type, indicating the nature of the engagement with the donor. [ENUM-REF-CANDIDATE: thank_you_letter|impact_report|recognition_call|anniversary_acknowledgement|cultivation_meeting|site_visit|donor_briefing|annual_report_distribution|personalized_update|stewardship_event — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_donor_stewardship_touchpoint PRIMARY KEY(`donor_stewardship_touchpoint_id`)
) COMMENT 'Transactional record of each deliberate stewardship interaction with a donor or funder — thank-you letters, impact reports sent, recognition calls, anniversary acknowledgements, and cultivation meetings. Captures touchpoint type, date, channel, staff owner, donor tier, linked gift or grant, content used (impact story, annual report), and donor response/sentiment. Sourced from Salesforce Nonprofit Cloud and Raisers Edge NXT major gift tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`plan` (
    `plan_id` BIGINT COMMENT 'Primary key.',
    `campaign_id` BIGINT COMMENT 'FK to the campaign this plan supports.',
    `country_office_id` BIGINT COMMENT 'FK to the country office.',
    `staff_member_id` BIGINT COMMENT 'FK to the plan owner.',
    `approval_status` STRING COMMENT 'Approval status.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated.',
    `channels` STRING COMMENT 'Channels to be used.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `end_date` DATE COMMENT 'Plan end date.',
    `frequency` STRING COMMENT 'Communication frequency.',
    `kpi_targets` STRING COMMENT 'Key performance indicator targets.',
    `modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp.',
    `plan_name` STRING COMMENT 'Name of the plan.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the plan entity.',
    `objective` STRING COMMENT 'Plan objective.',
    `plan_status` STRING COMMENT 'Status (draft, active, completed, archived).',
    `plan_type` STRING COMMENT 'Type (stewardship, communication, engagement, crisis).',
    `start_date` DATE COMMENT 'Plan start date.',
    `target_audience` STRING COMMENT 'Target audience.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Communication plan defining objectives, target audiences, channels, frequency, and budget for stakeholder engagement, donor visibility, and crisis communication activities.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` (
    `crisis_communication_id` BIGINT COMMENT 'Unique identifier for the crisis communication event record. Primary key.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Crisis communications are triggered by compliance incidents (fraud, safeguarding breaches, financial misconduct). Real process: incident response protocol requires crisis communication plan activation',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Crisis communications are managed at organizational unit level (country office, regional office) for incident response coordination, escalation protocols, and organizational accountability. Required f',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.communication_plan. Business justification: Crisis communications are managed through structured communication plans. Each crisis event should reference its governing communication plan for coordinated messaging, stakeholder management, and res',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member serving as the overall crisis manager coordinating the response across all functions.',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Crisis communications often triggered by safeguarding incidents requiring stakeholder notification. Critical for incident response protocols, donor reporting obligations, media management, and regulat',
    `sitrep_id` BIGINT COMMENT 'Identifier linking this crisis communication event to the corresponding Situation Report (SitRep) in the field operations system.',
    `tertiary_crisis_communications_lead_staff_staff_member_id` BIGINT COMMENT 'Identifier of the communications team lead responsible for managing all communications activities during the crisis.',
    `activation_date` DATE COMMENT 'The date when the crisis communication response was officially activated and the crisis management protocol was triggered.',
    `activation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the crisis communication response was activated, including timezone information.',
    `affected_beneficiaries_estimated_count` STRING COMMENT 'Estimated number of beneficiaries (Persons of Concern, Internally Displaced Persons, program participants) affected by this crisis event.',
    `affected_countries` STRING COMMENT 'Comma-separated list of ISO 3-letter country codes for countries affected by this crisis (e.g., HTI,DOM for Haiti and Dominican Republic).',
    `affected_programs_count` STRING COMMENT 'Number of organizational programs impacted by this crisis event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crisis communication record was first created in the system.',
    `crisis_code` STRING COMMENT 'Short alphanumeric code used to reference the crisis internally and in communications systems (e.g., CRS-2024-001).',
    `crisis_communication_status` STRING COMMENT 'Current lifecycle status of the crisis communication response: monitoring (potential crisis being watched), activated (crisis response initiated), active (ongoing response), deactivating (winding down), closed (response complete), archived (historical record).. Valid values are `monitoring|activated|active|deactivating|closed|archived`',
    `crisis_description` STRING COMMENT 'Detailed narrative description of the crisis event, including background, context, timeline of events, and impact on organizational operations and beneficiaries.',
    `crisis_name` STRING COMMENT 'The official name or title assigned to the crisis communication event (e.g., Hurricane Maria Response 2023, Data Breach Incident Q2 2024).',
    `crisis_type` STRING COMMENT 'Classification of the crisis event: natural disaster (earthquake, flood, hurricane), security incident (armed conflict, kidnapping), reputational risk (media scandal, donor complaint), health emergency (disease outbreak, pandemic), operational disruption (system failure, supply chain breakdown), or safeguarding incident (Gender-Based Violence allegation, child protection concern).. Valid values are `natural_disaster|security_incident|reputational_risk|health_emergency|operational_disruption|safeguarding_incident`',
    `deactivation_date` DATE COMMENT 'The date when the crisis communication response was officially deactivated and normal operations resumed. Null if crisis is still active.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the crisis communication response was deactivated, including timezone information. Null if crisis is still active.',
    `donor_notification_required_flag` BOOLEAN COMMENT 'Indicates whether formal notification to donors was required for this crisis event due to program impact, fund restrictions, or contractual obligations.',
    `donor_notification_sent_date` DATE COMMENT 'The date when formal notification was sent to affected donors regarding the crisis and its impact on programs or operations.',
    `external_communications_channel_mix` STRING COMMENT 'Comma-separated list of external communication channels used during the crisis response (e.g., press_release,social_media,website,email,radio,community_meetings).',
    `geographic_scope` STRING COMMENT 'The geographic reach of the crisis impact: local (single community/district), regional (multiple districts/provinces), national (entire country), multi-country (multiple countries), global (worldwide impact).. Valid values are `local|regional|national|multi_country|global`',
    `internal_communications_channel_mix` STRING COMMENT 'Comma-separated list of internal communication channels used to keep staff and volunteers informed during the crisis (e.g., email,intranet,town_hall,team_meetings,instant_messaging).',
    `key_messages_approval_date` DATE COMMENT 'The date when the key messages were officially approved by leadership for use in crisis communications.',
    `key_messages_approved` STRING COMMENT 'The official approved key messages and talking points for use in all crisis communications. These messages are vetted by leadership and legal counsel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this crisis communication record was most recently updated or modified.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the crisis response, including what worked well, what could be improved, and recommendations for future crisis communications.',
    `media_inquiries_received_count` STRING COMMENT 'Total number of media inquiries received from journalists, news outlets, and media organizations during this crisis event.',
    `media_inquiries_responded_count` STRING COMMENT 'Total number of media inquiries that received an official response from the organization during this crisis event.',
    `post_crisis_review_date` DATE COMMENT 'The date when the post-crisis review meeting or assessment was conducted.',
    `post_crisis_review_status` STRING COMMENT 'Status of the post-crisis review and lessons learned process: not started, scheduled, in progress, completed (review done), published (findings shared).. Valid values are `not_started|scheduled|in_progress|completed|published`',
    `press_releases_issued_count` STRING COMMENT 'Total number of official press releases issued to media during this crisis event.',
    `regulatory_report_submitted_date` DATE COMMENT 'The date when required regulatory reports were submitted to relevant authorities regarding the crisis event.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory reporting to government agencies, charity commissions, or oversight bodies was required for this crisis event.',
    `response_actions_taken` STRING COMMENT 'Detailed narrative of the communications response actions taken during the crisis, including press releases issued, social media posts, stakeholder briefings, town halls, and other communication activities.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root causes that led to or exacerbated the crisis, used for organizational learning and prevention of future incidents.',
    `severity_level` STRING COMMENT 'The assessed severity of the crisis event: low (minimal impact, localized), medium (moderate impact, regional), high (significant impact, multi-country), critical (catastrophic impact, organization-wide threat).. Valid values are `low|medium|high|critical`',
    `social_media_posts_count` STRING COMMENT 'Total number of social media posts published across all organizational channels during this crisis event.',
    `spokesperson_name` STRING COMMENT 'Full name of the designated spokesperson for quick reference in communications materials and media coordination.',
    `stakeholder_briefings_count` STRING COMMENT 'Total number of stakeholder briefings conducted with donors, partners, board members, and other key stakeholders during this crisis event.',
    CONSTRAINT pk_crisis_communication PRIMARY KEY(`crisis_communication_id`)
) COMMENT 'Master record for crisis and emergency communications events managed by the communications team during humanitarian responses, organizational incidents, or reputational risks. Captures crisis name, crisis type (natural disaster, security incident, reputational), activation date, deactivation date, spokesperson assigned, key messages approved, media inquiries received, response actions taken, and post-crisis review status. Supports rapid response communications and organizational resilience.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` (
    `campaign_media_outreach_id` BIGINT COMMENT 'Unique identifier for this campaign-media contact engagement record. Primary key.',
    `advocacy_campaign_id` BIGINT COMMENT 'Foreign key linking to the advocacy campaign for which media outreach is being conducted',
    `media_contact_id` BIGINT COMMENT 'Foreign key linking to the media contact being engaged for this campaign',
    `contact_role` STRING COMMENT 'The role or capacity in which the media contact is engaged for this campaign (e.g., primary journalist, backup contact, spokesperson, technical expert for interviews)',
    `coverage_publication_date` DATE COMMENT 'The date when media coverage resulting from this engagement was published or broadcast',
    `coverage_type` STRING COMMENT 'The type of media coverage resulting from this engagement (e.g., news article, feature story, interview, broadcast segment, social media post, opinion piece, or none if no coverage resulted)',
    `coverage_url` STRING COMMENT 'URL or link to the published media coverage resulting from this campaign-contact engagement',
    `embargo_agreement_flag` BOOLEAN COMMENT 'Indicates whether an embargo agreement was established for this specific campaign-contact engagement (true if embargo terms apply to this outreach)',
    `engagement_date` DATE COMMENT 'The date when the media contact was first engaged or contacted for this specific campaign',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up action is required with this media contact for this campaign (true if follow-up needed, false if engagement is complete)',
    `interview_granted_flag` BOOLEAN COMMENT 'Indicates whether an interview with NGO spokesperson or subject matter expert was granted to this media contact for this campaign (true if interview occurred)',
    `media_kit_sent_date` DATE COMMENT 'The date when the campaign media kit, press release, or briefing materials were sent to this media contact',
    `notes` STRING COMMENT 'Free-text notes documenting the engagement interaction, conversation highlights, commitments made, or other relevant details about this campaign-contact relationship',
    `outreach_status` STRING COMMENT 'Current status of the media outreach activity for this campaign-contact pair (e.g., planned, contacted, responded, coverage secured, declined, no response, closed)',
    `response_date` DATE COMMENT 'The date when the media contact responded to the campaign outreach, if applicable',
    `response_received_flag` BOOLEAN COMMENT 'Indicates whether the media contact responded to the campaign outreach (true if response received, false if no response)',
    CONSTRAINT pk_campaign_media_outreach PRIMARY KEY(`campaign_media_outreach_id`)
) COMMENT 'This association product represents the media relations activity between advocacy campaigns and media contacts. It captures the proactive outreach, engagement tracking, and relationship management that communications teams perform when engaging journalists and media influencers for specific campaigns. Each record links one advocacy campaign to one media contact with attributes that track the engagement lifecycle, response outcomes, and follow-up activities.. Existence Justification: In nonprofit communications operations, media relations teams actively manage which journalists and media contacts to engage for each advocacy campaign. A single campaign requires outreach to multiple media contacts (regional journalists, national outlets, specialized beat reporters), and a single media contact is engaged across multiple campaigns over time. The relationship is operationally managed with tracking of engagement dates, response outcomes, coverage types, and follow-up requirements.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`communication`.`message_thread` (
    `message_thread_id` BIGINT COMMENT 'Primary key for message_thread',
    `campaign_id` BIGINT COMMENT 'Reference to the advocacy or fundraising campaign associated with this message thread, if applicable.',
    `component_id` BIGINT COMMENT 'Reference to the humanitarian program or project related to this message thread, if applicable.',
    `constituent_id` BIGINT COMMENT 'Reference to the primary contact or party involved in this message thread (donor, beneficiary, media contact, staff member).',
    `field_team_id` BIGINT COMMENT 'Reference to the team or department responsible for handling this message thread.',
    `parent_message_thread_id` BIGINT COMMENT 'Self-referencing FK on message_thread (parent_message_thread_id)',
    `user_account_id` BIGINT COMMENT 'Reference to the staff member or user currently responsible for managing and responding to this message thread.',
    `account_reference` BIGINT COMMENT 'Reference to the organizational account associated with this message thread, if applicable.',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when the message thread was archived. Null if not archived.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when the message thread was marked as closed or resolved. Null if still open.',
    `communication_channel` STRING COMMENT 'The channel or medium through which the message thread is conducted (email, SMS, WhatsApp, web portal, mobile app, phone).',
    `complaint_category` STRING COMMENT 'Classification of the complaint type if this thread is marked as a complaint (service quality, staff conduct, discrimination, safety concern, fraud, other).',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether explicit consent was obtained from the contact to store and process their communication data, required for data protection compliance.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country context for this message thread.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this message thread record was first created in the system.',
    `data_protection_classification` STRING COMMENT 'Data classification level assigned to the message thread content based on sensitivity and privacy requirements.',
    `escalation_level` STRING COMMENT 'Numeric indicator of how many times this thread has been escalated to higher management or specialized teams. Zero indicates no escalation.',
    `external_reference_code` STRING COMMENT 'Reference identifier from an external system or platform where this message thread originated or is synchronized.',
    `first_response_timestamp` TIMESTAMP COMMENT 'The date and time when the first response was provided to the initiating party, used to measure response time performance.',
    `geographic_region` STRING COMMENT 'The geographic region or operational area associated with this message thread, relevant for field operations and beneficiary communications.',
    `initiated_timestamp` TIMESTAMP COMMENT 'The date and time when the message thread was first created or initiated by the originating party.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the message thread has been archived and moved out of active communication management.',
    `is_complaint` BOOLEAN COMMENT 'Indicates whether this message thread represents a formal complaint or grievance requiring special handling per accountability standards.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the message thread contains confidential or sensitive information requiring restricted access and special handling.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language used in the message thread.',
    `last_message_timestamp` TIMESTAMP COMMENT 'The date and time when the most recent message was added to this thread.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this message thread record was last updated or modified.',
    `message_count` STRING COMMENT 'Total number of individual messages exchanged within this thread.',
    `priority_level` STRING COMMENT 'The urgency or importance level assigned to the message thread, determining response time requirements.',
    `requires_translation` BOOLEAN COMMENT 'Indicates whether the message thread requires translation services to facilitate communication between parties speaking different languages.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting how the message thread was resolved, actions taken, and outcomes achieved.',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when the issue or inquiry in the message thread was resolved to the satisfaction of all parties.',
    `response_due_date` DATE COMMENT 'The target date by which a response is expected based on service level agreements or accountability commitments.',
    `retention_end_date` DATE COMMENT 'The date after which this message thread should be archived or deleted according to data retention policies and regulatory requirements.',
    `satisfaction_rating` STRING COMMENT 'Numeric satisfaction rating provided by the contact after thread resolution, typically on a scale of 1 to 5, used to measure service quality.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score for the overall thread, ranging from -1.00 (very negative) to +1.00 (very positive), used to identify satisfaction or concerns.',
    `tags` STRING COMMENT 'Comma-separated list of keywords or tags applied to the message thread for categorization, search, and reporting purposes.',
    `thread_reference_number` STRING COMMENT 'Human-readable business identifier for the message thread, used in external communications and reporting.',
    `thread_status` STRING COMMENT 'Current lifecycle status of the message thread indicating its state in the communication workflow.',
    `thread_subject` STRING COMMENT 'The subject or title of the message thread, summarizing the topic or purpose of the conversation.',
    `thread_type` STRING COMMENT 'Classification of the message thread based on its purpose and audience (donor communication, advocacy campaign, beneficiary feedback, complaint, media inquiry, internal communication).',
    CONSTRAINT pk_message_thread PRIMARY KEY(`message_thread_id`)
) COMMENT 'Master reference table for message_thread. Referenced by thread_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_crisis_communication_id` FOREIGN KEY (`crisis_communication_id`) REFERENCES `vibe_ngo_v1`.`communication`.`crisis_communication`(`crisis_communication_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_email_broadcast_id` FOREIGN KEY (`email_broadcast_id`) REFERENCES `vibe_ngo_v1`.`communication`.`email_broadcast`(`email_broadcast_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_feedback_case_id` FOREIGN KEY (`feedback_case_id`) REFERENCES `vibe_ngo_v1`.`communication`.`feedback_case`(`feedback_case_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_message_thread_id` FOREIGN KEY (`message_thread_id`) REFERENCES `vibe_ngo_v1`.`communication`.`message_thread`(`message_thread_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ADD CONSTRAINT `fk_communication_advocacy_campaign_media_contact_id` FOREIGN KEY (`media_contact_id`) REFERENCES `vibe_ngo_v1`.`communication`.`media_contact`(`media_contact_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ADD CONSTRAINT `fk_communication_advocacy_campaign_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ADD CONSTRAINT `fk_communication_campaign_touchpoint_advocacy_campaign_id` FOREIGN KEY (`advocacy_campaign_id`) REFERENCES `vibe_ngo_v1`.`communication`.`advocacy_campaign`(`advocacy_campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ADD CONSTRAINT `fk_communication_feedback_submission_feedback_case_id` FOREIGN KEY (`feedback_case_id`) REFERENCES `vibe_ngo_v1`.`communication`.`feedback_case`(`feedback_case_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_crisis_communication_id` FOREIGN KEY (`crisis_communication_id`) REFERENCES `vibe_ngo_v1`.`communication`.`crisis_communication`(`crisis_communication_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_impact_story_id` FOREIGN KEY (`impact_story_id`) REFERENCES `vibe_ngo_v1`.`communication`.`impact_story`(`impact_story_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_media_contact_id` FOREIGN KEY (`media_contact_id`) REFERENCES `vibe_ngo_v1`.`communication`.`media_contact`(`media_contact_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ADD CONSTRAINT `fk_communication_digital_content_impact_story_id` FOREIGN KEY (`impact_story_id`) REFERENCES `vibe_ngo_v1`.`communication`.`impact_story`(`impact_story_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ADD CONSTRAINT `fk_communication_digital_content_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ADD CONSTRAINT `fk_communication_email_broadcast_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_feedback_case_id` FOREIGN KEY (`feedback_case_id`) REFERENCES `vibe_ngo_v1`.`communication`.`feedback_case`(`feedback_case_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_impact_story_id` FOREIGN KEY (`impact_story_id`) REFERENCES `vibe_ngo_v1`.`communication`.`impact_story`(`impact_story_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ADD CONSTRAINT `fk_communication_crisis_communication_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ADD CONSTRAINT `fk_communication_campaign_media_outreach_advocacy_campaign_id` FOREIGN KEY (`advocacy_campaign_id`) REFERENCES `vibe_ngo_v1`.`communication`.`advocacy_campaign`(`advocacy_campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ADD CONSTRAINT `fk_communication_campaign_media_outreach_media_contact_id` FOREIGN KEY (`media_contact_id`) REFERENCES `vibe_ngo_v1`.`communication`.`media_contact`(`media_contact_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ADD CONSTRAINT `fk_communication_message_thread_parent_message_thread_id` FOREIGN KEY (`parent_message_thread_id`) REFERENCES `vibe_ngo_v1`.`communication`.`message_thread`(`message_thread_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`communication` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`communication` SET TAGS ('pii_domain' = 'communication');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` SET TAGS ('pii_subdomain' = 'constituent_engagement');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `constituent_message_id` SET TAGS ('pii_business_glossary_term' = 'Constituent Message ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `case_record_id` SET TAGS ('pii_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `crisis_communication_id` SET TAGS ('pii_business_glossary_term' = 'Crisis Communication Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_business_glossary_term' = 'Email Broadcast Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `feedback_case_id` SET TAGS ('pii_business_glossary_term' = 'Feedback Case Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `message_thread_id` SET TAGS ('pii_business_glossary_term' = 'Thread ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `stewardship_activity_id` SET TAGS ('pii_business_glossary_term' = 'Stewardship Activity ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `body_excerpt` SET TAGS ('pii_business_glossary_term' = 'Message Body Excerpt');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `bounce_reason` SET TAGS ('pii_business_glossary_term' = 'Bounce Reason');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `clicked_flag` SET TAGS ('pii_business_glossary_term' = 'Clicked Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `clicked_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clicked Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `complaint_flag` SET TAGS ('pii_business_glossary_term' = 'Complaint Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `consent_reference` SET TAGS ('pii_business_glossary_term' = 'Consent Reference');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `delivery_status` SET TAGS ('pii_value_regex' = 'sent|delivered|failed|bounced|pending|queued');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `delivery_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `external_message_code` SET TAGS ('pii_business_glossary_term' = 'External Message ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `message_direction` SET TAGS ('pii_business_glossary_term' = 'Message Direction');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `message_direction` SET TAGS ('pii_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `message_type` SET TAGS ('pii_business_glossary_term' = 'Message Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `opened_flag` SET TAGS ('pii_business_glossary_term' = 'Opened Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `opened_timestamp` SET TAGS ('pii_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `opt_out_flag` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `opt_out_timestamp` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Message Priority');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_email` SET TAGS ('pii_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_name` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_name` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_phone` SET TAGS ('pii_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_phone` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `recipient_phone` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `replied_flag` SET TAGS ('pii_business_glossary_term' = 'Replied Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `replied_timestamp` SET TAGS ('pii_business_glossary_term' = 'Replied Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `response_required_flag` SET TAGS ('pii_business_glossary_term' = 'Response Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_email` SET TAGS ('pii_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_name` SET TAGS ('pii_business_glossary_term' = 'Sender Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sender_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `sentiment_score` SET TAGS ('pii_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Message Subject');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` SET TAGS ('pii_subdomain' = 'advocacy_outreach');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` SET TAGS ('pii_column_comment_framework' = 'Grand Bargain + IATI');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Advocacy Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `donor_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `media_contact_id` SET TAGS ('pii_business_glossary_term' = 'Media Contact Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Communication Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `actual_engagement_count` SET TAGS ('pii_business_glossary_term' = 'Actual Engagement Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `actual_fundraising_amount` SET TAGS ('pii_business_glossary_term' = 'Actual Fundraising Amount');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `actual_reach_count` SET TAGS ('pii_business_glossary_term' = 'Actual Reach Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `actual_spend_amount` SET TAGS ('pii_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `budget_allocated_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `call_to_action` SET TAGS ('pii_business_glossary_term' = 'Call to Action');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_code` SET TAGS ('pii_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_description` SET TAGS ('pii_business_glossary_term' = 'Campaign Description');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_goal` SET TAGS ('pii_business_glossary_term' = 'Campaign Goal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_name` SET TAGS ('pii_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_business_glossary_term' = 'Campaign Owner Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_person_type' = 'person_name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_masking_policy' = 'mask_non_prod');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_owner_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_status` SET TAGS ('pii_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_status` SET TAGS ('pii_value_regex' = 'planned|active|paused|completed|cancelled|archived');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_type` SET TAGS ('pii_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `campaign_type` SET TAGS ('pii_value_regex' = 'digital|direct_mail|event_based|media|grassroots|hybrid');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `closeout_date` SET TAGS ('pii_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `compliance_review_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `compliance_review_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `geographic_focus` SET TAGS ('pii_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `hashtag_primary` SET TAGS ('pii_business_glossary_term' = 'Primary Hashtag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `hashtag_secondary` SET TAGS ('pii_business_glossary_term' = 'Secondary Hashtag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `is_donor_restricted` SET TAGS ('pii_business_glossary_term' = 'Is Donor Restricted');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `language_primary` SET TAGS ('pii_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `language_secondary` SET TAGS ('pii_business_glossary_term' = 'Secondary Language');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `launch_date` SET TAGS ('pii_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `partner_organization_names` SET TAGS ('pii_business_glossary_term' = 'Partner Organization Names');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `partner_organization_names` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `partner_organization_names` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `primary_channel_mix` SET TAGS ('pii_business_glossary_term' = 'Primary Channel Mix');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `sdg_alignment_tags` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Tags');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `target_audience_segment` SET TAGS ('pii_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `target_engagement_count` SET TAGS ('pii_business_glossary_term' = 'Target Engagement Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `target_fundraising_amount` SET TAGS ('pii_business_glossary_term' = 'Target Fundraising Amount');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `target_reach_count` SET TAGS ('pii_business_glossary_term' = 'Target Reach Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `theme` SET TAGS ('pii_business_glossary_term' = 'Campaign Theme');
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Campaign Website URL');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` SET TAGS ('pii_subdomain' = 'advocacy_outreach');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `campaign_touchpoint_id` SET TAGS ('pii_business_glossary_term' = 'Campaign Touchpoint ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Advocacy Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `appeal_code` SET TAGS ('pii_business_glossary_term' = 'Appeal Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `attribution_source` SET TAGS ('pii_business_glossary_term' = 'Attribution Source');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `campaign_member_status` SET TAGS ('pii_business_glossary_term' = 'Campaign Member Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `conversion_flag` SET TAGS ('pii_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `conversion_type` SET TAGS ('pii_business_glossary_term' = 'Conversion Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `conversion_type` SET TAGS ('pii_value_regex' = 'donation|petition|event_registration|volunteer_signup|advocacy_action|none');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `conversion_value_usd` SET TAGS ('pii_business_glossary_term' = 'Conversion Value (USD)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `cost_per_touchpoint_usd` SET TAGS ('pii_business_glossary_term' = 'Cost Per Touchpoint (USD)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `device_type` SET TAGS ('pii_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `device_type` SET TAGS ('pii_value_regex' = 'desktop|mobile|tablet|unknown');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `engagement_score` SET TAGS ('pii_business_glossary_term' = 'Engagement Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `feedback_provided_flag` SET TAGS ('pii_business_glossary_term' = 'Feedback Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `feedback_text` SET TAGS ('pii_business_glossary_term' = 'Feedback Text');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `geographic_location` SET TAGS ('pii_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `geographic_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `language_preference` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `message_subject` SET TAGS ('pii_business_glossary_term' = 'Message Subject');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `message_variant` SET TAGS ('pii_business_glossary_term' = 'Message Variant');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `opt_out_flag` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `partner_organization` SET TAGS ('pii_business_glossary_term' = 'Partner Organization');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `response_action` SET TAGS ('pii_business_glossary_term' = 'Response Action');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `sentiment_score` SET TAGS ('pii_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `time_to_conversion_hours` SET TAGS ('pii_business_glossary_term' = 'Time to Conversion (Hours)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `touchpoint_sequence` SET TAGS ('pii_business_glossary_term' = 'Touchpoint Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `touchpoint_type` SET TAGS ('pii_business_glossary_term' = 'Touchpoint Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `touchpoint_type` SET TAGS ('pii_value_regex' = 'email_open|email_click|petition_sign|event_attend|donation|social_share');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ALTER COLUMN `unsubscribe_reason` SET TAGS ('pii_business_glossary_term' = 'Unsubscribe Reason');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` SET TAGS ('pii_subdomain' = 'constituent_engagement');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `feedback_submission_id` SET TAGS ('pii_business_glossary_term' = 'Feedback Submission ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `feedback_case_id` SET TAGS ('pii_business_glossary_term' = 'Feedback Case Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assigned To Staff ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `registrant_id` SET TAGS ('pii_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `action_taken` SET TAGS ('pii_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `actual_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `admin_level_1` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `admin_level_2` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `community_name` SET TAGS ('pii_business_glossary_term' = 'Community Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `community_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `community_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `feedback_category` SET TAGS ('pii_business_glossary_term' = 'Feedback Category');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `feedback_subcategory` SET TAGS ('pii_business_glossary_term' = 'Feedback Subcategory');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `feedback_text` SET TAGS ('pii_business_glossary_term' = 'Feedback Text');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `follow_up_required` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `is_anonymous` SET TAGS ('pii_business_glossary_term' = 'Anonymous Submission Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `is_sensitive` SET TAGS ('pii_business_glossary_term' = 'Sensitive Feedback Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `requires_escalation` SET TAGS ('pii_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submission_reference_number` SET TAGS ('pii_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submission_reference_number` SET TAGS ('pii_value_regex' = '^FB-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_email` SET TAGS ('pii_business_glossary_term' = 'Submitter Email Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_name` SET TAGS ('pii_business_glossary_term' = 'Submitter Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_name` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_name` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_phone` SET TAGS ('pii_business_glossary_term' = 'Submitter Phone Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_phone` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_phone` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `submitter_satisfaction_rating` SET TAGS ('pii_business_glossary_term' = 'Submitter Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `target_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ALTER COLUMN `translated_feedback_text` SET TAGS ('pii_business_glossary_term' = 'Translated Feedback Text');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` SET TAGS ('pii_subdomain' = 'constituent_engagement');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `feedback_case_id` SET TAGS ('pii_business_glossary_term' = 'Feedback Case ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `registrant_id` SET TAGS ('pii_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Case Owner ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_category` SET TAGS ('pii_business_glossary_term' = 'Case Category');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_number` SET TAGS ('pii_value_regex' = '^FC-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_status` SET TAGS ('pii_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_status` SET TAGS ('pii_value_regex' = 'new|assigned|in_progress|escalated|resolved|closed');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_subcategory` SET TAGS ('pii_business_glossary_term' = 'Case Subcategory');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_summary` SET TAGS ('pii_business_glossary_term' = 'Case Summary');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_type` SET TAGS ('pii_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `case_type` SET TAGS ('pii_value_regex' = 'feedback|complaint|suggestion|inquiry|compliment|grievance');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `closed_date` SET TAGS ('pii_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `escalation_tier` SET TAGS ('pii_business_glossary_term' = 'Escalation Tier');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `escalation_tier` SET TAGS ('pii_value_regex' = 'L1|L2|L3');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `investigation_notes` SET TAGS ('pii_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `is_anonymous` SET TAGS ('pii_business_glossary_term' = 'Is Anonymous');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `is_sensitive` SET TAGS ('pii_business_glossary_term' = 'Is Sensitive');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `language_of_submission` SET TAGS ('pii_business_glossary_term' = 'Language of Submission');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `referral_organization` SET TAGS ('pii_business_glossary_term' = 'Referral Organization');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `referral_pathway` SET TAGS ('pii_business_glossary_term' = 'Referral Pathway');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `requires_translation` SET TAGS ('pii_business_glossary_term' = 'Requires Translation');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `resolution_action_taken` SET TAGS ('pii_business_glossary_term' = 'Resolution Action Taken');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `resolved_date` SET TAGS ('pii_business_glossary_term' = 'Resolved Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `response_language` SET TAGS ('pii_business_glossary_term' = 'Response Language');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `response_method` SET TAGS ('pii_business_glossary_term' = 'Response Method');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `response_method` SET TAGS ('pii_value_regex' = 'phone_call|sms|email|in_person|letter|no_response_requested');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `response_sent_date` SET TAGS ('pii_business_glossary_term' = 'Response Sent Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `root_cause_analysis` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `satisfaction_follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Satisfaction Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `satisfaction_follow_up_outcome` SET TAGS ('pii_business_glossary_term' = 'Satisfaction Follow-Up Outcome');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `satisfaction_follow_up_outcome` SET TAGS ('pii_value_regex' = 'satisfied|partially_satisfied|not_satisfied|no_response|not_contacted');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `sla_due_date` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `sla_target_days` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ALTER COLUMN `submission_channel` SET TAGS ('pii_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` SET TAGS ('pii_subdomain' = 'media_relations');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `media_contact_id` SET TAGS ('pii_business_glossary_term' = 'Media Contact Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `beat_focus` SET TAGS ('pii_business_glossary_term' = 'Journalist Beat or Topic Focus');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `blacklist_reason` SET TAGS ('pii_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `blacklist_status` SET TAGS ('pii_business_glossary_term' = 'Blacklist Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `circulation_reach` SET TAGS ('pii_business_glossary_term' = 'Circulation or Audience Reach');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `embargo_agreement_date` SET TAGS ('pii_business_glossary_term' = 'Embargo Agreement Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `embargo_agreement_flag` SET TAGS ('pii_business_glossary_term' = 'Embargo Agreement Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Media Contact First Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `first_name` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `full_name` SET TAGS ('pii_business_glossary_term' = 'Media Contact Full Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `full_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `full_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `full_name` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `full_name` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Area');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `influence_score` SET TAGS ('pii_business_glossary_term' = 'Media Influence Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `job_title` SET TAGS ('pii_business_glossary_term' = 'Media Contact Job Title');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_engagement_date` SET TAGS ('pii_business_glossary_term' = 'Last Engagement Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_engagement_type` SET TAGS ('pii_business_glossary_term' = 'Last Engagement Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_engagement_type` SET TAGS ('pii_value_regex' = 'press_release|interview|briefing|event|email|phone_call');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Media Contact Last Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `last_name` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `mobile_number` SET TAGS ('pii_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `mobile_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `mobile_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `mobile_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `opt_in_date` SET TAGS ('pii_business_glossary_term' = 'Opt-In Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `opt_in_status` SET TAGS ('pii_business_glossary_term' = 'Opt-In Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `outlet_name` SET TAGS ('pii_business_glossary_term' = 'Media Outlet Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `outlet_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `outlet_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `outlet_type` SET TAGS ('pii_business_glossary_term' = 'Media Outlet Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_value_regex' = 'email|phone|mobile|social_media|messaging_app');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `primary_language` SET TAGS ('pii_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived|duplicate');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `relationship_tier` SET TAGS ('pii_business_glossary_term' = 'Relationship Tier');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `relationship_tier` SET TAGS ('pii_value_regex' = 'tier_1_strategic|tier_2_active|tier_3_occasional|tier_4_prospect');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_business_glossary_term' = 'Secondary Email Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `secondary_languages` SET TAGS ('pii_business_glossary_term' = 'Secondary Languages');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `social_media_linkedin` SET TAGS ('pii_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `social_media_twitter` SET TAGS ('pii_business_glossary_term' = 'Twitter Handle');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ALTER COLUMN `total_engagement_count` SET TAGS ('pii_business_glossary_term' = 'Total Engagement Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` SET TAGS ('pii_subdomain' = 'media_relations');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `media_activity_id` SET TAGS ('pii_business_glossary_term' = 'Media Activity ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `crisis_communication_id` SET TAGS ('pii_business_glossary_term' = 'Crisis Event ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `impact_story_id` SET TAGS ('pii_business_glossary_term' = 'Impact Story Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `media_contact_id` SET TAGS ('pii_business_glossary_term' = 'Media Contact Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Spokesperson Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Media Activity Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date and Time');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `approver_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `approver_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `author_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `author_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `beneficiary_feedback_flag` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Feedback Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `chs_commitment_reference` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Commitment Reference');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `circulation_estimate` SET TAGS ('pii_business_glossary_term' = 'Circulation Estimate');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `clipping_url` SET TAGS ('pii_business_glossary_term' = 'Media Clipping Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `content_summary` SET TAGS ('pii_business_glossary_term' = 'Content Summary');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `distribution_channel` SET TAGS ('pii_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `embargo_date` SET TAGS ('pii_business_glossary_term' = 'Embargo Date and Time');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `geographic_market` SET TAGS ('pii_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `key_messages` SET TAGS ('pii_business_glossary_term' = 'Key Messages');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `language_versions` SET TAGS ('pii_business_glossary_term' = 'Language Versions');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `media_activity_status` SET TAGS ('pii_business_glossary_term' = 'Media Activity Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `media_value_usd` SET TAGS ('pii_business_glossary_term' = 'Media Value in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `outlet_name` SET TAGS ('pii_business_glossary_term' = 'Media Outlet Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `outlet_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `outlet_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `outlet_type` SET TAGS ('pii_business_glossary_term' = 'Media Outlet Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `pickup_count` SET TAGS ('pii_business_glossary_term' = 'Media Pickup Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `prominence_score` SET TAGS ('pii_business_glossary_term' = 'Prominence Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `reach_estimate` SET TAGS ('pii_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `release_date` SET TAGS ('pii_business_glossary_term' = 'Release Date and Time');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `sentiment` SET TAGS ('pii_business_glossary_term' = 'Media Sentiment');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `sentiment` SET TAGS ('pii_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `social_shares` SET TAGS ('pii_business_glossary_term' = 'Social Media Shares');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `spokesperson_name` SET TAGS ('pii_business_glossary_term' = 'Spokesperson Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `spokesperson_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `spokesperson_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `target_media_list` SET TAGS ('pii_business_glossary_term' = 'Target Media List');
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Media Activity Title');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` SET TAGS ('pii_subdomain' = 'content_publishing');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `impact_story_id` SET TAGS ('pii_business_glossary_term' = 'Impact Story Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `donor_fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `registrant_id` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Deployment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `anonymization_required` SET TAGS ('pii_business_glossary_term' = 'Anonymization Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|pending_review|approved|published|archived|rejected');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `archive_date` SET TAGS ('pii_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `author_name` SET TAGS ('pii_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `author_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `author_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `consent_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `consent_status` SET TAGS ('pii_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `consent_status` SET TAGS ('pii_value_regex' = 'obtained|pending|declined|withdrawn|not_required');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `content_format` SET TAGS ('pii_business_glossary_term' = 'Content Format');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `content_format` SET TAGS ('pii_value_regex' = 'text|video|photo_essay|audio|multimedia|infographic');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `donor_visibility` SET TAGS ('pii_business_glossary_term' = 'Donor Visibility');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `donor_visibility` SET TAGS ('pii_value_regex' = 'public|donor_only|restricted|internal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `embargo_flag` SET TAGS ('pii_business_glossary_term' = 'Embargo Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `embargo_until_date` SET TAGS ('pii_business_glossary_term' = 'Embargo Until Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `geographic_scope` SET TAGS ('pii_value_regex' = 'community|district|region|country|multi_country|global');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `impact_metric` SET TAGS ('pii_business_glossary_term' = 'Impact Metric');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `keywords` SET TAGS ('pii_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `media_asset_url` SET TAGS ('pii_business_glossary_term' = 'Media Asset Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `photographer_name` SET TAGS ('pii_business_glossary_term' = 'Photographer Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `photographer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `photographer_name` SET TAGS ('pii_type' = 'photo');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `protection_flag` SET TAGS ('pii_business_glossary_term' = 'Protection Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `publication_channels` SET TAGS ('pii_business_glossary_term' = 'Publication Channels');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `sensitivity_level` SET TAGS ('pii_business_glossary_term' = 'Sensitivity Level');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `sensitivity_level` SET TAGS ('pii_value_regex' = 'public|internal|sensitive|highly_sensitive');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `story_narrative` SET TAGS ('pii_business_glossary_term' = 'Story Narrative');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `story_summary` SET TAGS ('pii_business_glossary_term' = 'Story Summary');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `story_title` SET TAGS ('pii_business_glossary_term' = 'Story Title');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `story_type` SET TAGS ('pii_business_glossary_term' = 'Story Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `story_type` SET TAGS ('pii_value_regex' = 'beneficiary_testimonial|case_study|human_interest|program_outcome|community_impact|donor_impact');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `storyteller_type` SET TAGS ('pii_business_glossary_term' = 'Storyteller Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `storyteller_type` SET TAGS ('pii_value_regex' = 'beneficiary|staff|volunteer|community_member|partner|donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `thematic_area` SET TAGS ('pii_business_glossary_term' = 'Thematic Area');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `translation_available` SET TAGS ('pii_business_glossary_term' = 'Translation Available Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `usage_rights` SET TAGS ('pii_business_glossary_term' = 'Usage Rights');
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ALTER COLUMN `usage_rights` SET TAGS ('pii_value_regex' = 'unrestricted|attribution_required|non_commercial|restricted|copyright_protected');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` SET TAGS ('pii_subdomain' = 'content_publishing');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `digital_content_id` SET TAGS ('pii_business_glossary_term' = 'Digital Content ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `impact_story_id` SET TAGS ('pii_business_glossary_term' = 'Impact Story Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Author Staff ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `tertiary_digital_author_staff_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary Digital Author Staff Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `tertiary_digital_author_staff_staff_member_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `tertiary_digital_author_staff_staff_member_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `account_handle` SET TAGS ('pii_business_glossary_term' = 'Social Media Account Handle');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `actual_publish_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Publish Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `body_text` SET TAGS ('pii_business_glossary_term' = 'Content Body Text');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `click_through_count` SET TAGS ('pii_business_glossary_term' = 'Click-Through Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `content_reference_number` SET TAGS ('pii_business_glossary_term' = 'Content Reference Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `content_reference_number` SET TAGS ('pii_value_regex' = '^DC-[0-9]{8}-[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `content_status` SET TAGS ('pii_business_glossary_term' = 'Content Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `content_status` SET TAGS ('pii_value_regex' = 'draft|scheduled|published|archived|expired|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `content_type` SET TAGS ('pii_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `engagement_comments_count` SET TAGS ('pii_business_glossary_term' = 'Engagement Comments Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `engagement_likes_count` SET TAGS ('pii_business_glossary_term' = 'Engagement Likes Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `engagement_shares_count` SET TAGS ('pii_business_glossary_term' = 'Engagement Shares Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Content Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `hashtags` SET TAGS ('pii_business_glossary_term' = 'Content Hashtags');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `impressions_count` SET TAGS ('pii_business_glossary_term' = 'Content Impressions Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `is_accessibility_compliant` SET TAGS ('pii_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `is_brand_compliant` SET TAGS ('pii_business_glossary_term' = 'Brand Guideline Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `media_file_url` SET TAGS ('pii_business_glossary_term' = 'Media File URL');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `media_file_url` SET TAGS ('pii_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `moderation_status` SET TAGS ('pii_business_glossary_term' = 'Content Moderation Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `moderation_status` SET TAGS ('pii_value_regex' = 'pending_review|approved|rejected|flagged');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `platform` SET TAGS ('pii_business_glossary_term' = 'Publication Platform');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `reach_count` SET TAGS ('pii_business_glossary_term' = 'Content Reach Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `scheduled_publish_timestamp` SET TAGS ('pii_business_glossary_term' = 'Scheduled Publish Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `seo_keywords` SET TAGS ('pii_business_glossary_term' = 'Search Engine Optimization (SEO) Keywords');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `seo_meta_description` SET TAGS ('pii_business_glossary_term' = 'Search Engine Optimization (SEO) Meta Description');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `seo_meta_title` SET TAGS ('pii_business_glossary_term' = 'Search Engine Optimization (SEO) Meta Title');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `subtitle` SET TAGS ('pii_business_glossary_term' = 'Content Subtitle');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `summary` SET TAGS ('pii_business_glossary_term' = 'Content Summary');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `tags` SET TAGS ('pii_business_glossary_term' = 'Content Tags');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `target_audience` SET TAGS ('pii_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `thumbnail_url` SET TAGS ('pii_business_glossary_term' = 'Thumbnail Image URL');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `thumbnail_url` SET TAGS ('pii_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Content Title');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `url` SET TAGS ('pii_business_glossary_term' = 'Content URL');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `url` SET TAGS ('pii_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ALTER COLUMN `video_views_count` SET TAGS ('pii_business_glossary_term' = 'Video Views Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` SET TAGS ('pii_subdomain' = 'content_publishing');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_business_glossary_term' = 'Email Broadcast ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `email_broadcast_id` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Communication Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `campaign_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `campaign_id` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `campaign_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `campaign_id` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `staff_member_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `staff_member_id` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `segment_id` SET TAGS ('pii_business_glossary_term' = 'Donor Segment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `ab_test_variant` SET TAGS ('pii_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `appeal_code` SET TAGS ('pii_business_glossary_term' = 'Appeal Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `bounce_count` SET TAGS ('pii_business_glossary_term' = 'Bounce Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `broadcast_name` SET TAGS ('pii_business_glossary_term' = 'Broadcast Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `broadcast_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `broadcast_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `broadcast_status` SET TAGS ('pii_business_glossary_term' = 'Broadcast Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `broadcast_status` SET TAGS ('pii_value_regex' = 'draft|scheduled|sending|sent|cancelled|failed');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `broadcast_type` SET TAGS ('pii_business_glossary_term' = 'Broadcast Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `click_count` SET TAGS ('pii_business_glossary_term' = 'Click Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `compliance_check_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `compliance_check_status` SET TAGS ('pii_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `consent_verified` SET TAGS ('pii_business_glossary_term' = 'Consent Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `delivered_count` SET TAGS ('pii_business_glossary_term' = 'Delivered Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `esp_platform` SET TAGS ('pii_business_glossary_term' = 'Email Service Provider (ESP) Platform');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `hard_bounce_count` SET TAGS ('pii_business_glossary_term' = 'Hard Bounce Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `is_ab_test` SET TAGS ('pii_business_glossary_term' = 'Is A/B Test Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `open_count` SET TAGS ('pii_business_glossary_term' = 'Open Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `reply_to_email` SET TAGS ('pii_business_glossary_term' = 'Reply-To Email Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `reply_to_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `reply_to_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `reply_to_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `reply_to_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `reply_to_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `send_date` SET TAGS ('pii_business_glossary_term' = 'Send Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `send_timestamp` SET TAGS ('pii_business_glossary_term' = 'Send Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_email` SET TAGS ('pii_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_name` SET TAGS ('pii_business_glossary_term' = 'Sender Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `sender_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `soft_bounce_count` SET TAGS ('pii_business_glossary_term' = 'Soft Bounce Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `spam_complaint_count` SET TAGS ('pii_business_glossary_term' = 'Spam Complaint Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `subject_line` SET TAGS ('pii_business_glossary_term' = 'Subject Line');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `total_recipients` SET TAGS ('pii_business_glossary_term' = 'Total Recipients');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `unique_click_count` SET TAGS ('pii_business_glossary_term' = 'Unique Click Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `unique_open_count` SET TAGS ('pii_business_glossary_term' = 'Unique Open Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ALTER COLUMN `unsubscribe_count` SET TAGS ('pii_business_glossary_term' = 'Unsubscribe Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` SET TAGS ('pii_subdomain' = 'constituent_engagement');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `constituent_consent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent Consent ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Consent Source Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Created By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `applicable_regulation` SET TAGS ('pii_business_glossary_term' = 'Applicable Data Protection Regulation');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_email` SET TAGS ('pii_business_glossary_term' = 'Email Channel Consent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_email` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_email` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_in_person` SET TAGS ('pii_business_glossary_term' = 'In-Person Channel Consent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_in_person` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_phone` SET TAGS ('pii_business_glossary_term' = 'Phone Channel Consent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_phone` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_phone` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_postal_mail` SET TAGS ('pii_business_glossary_term' = 'Postal Mail Channel Consent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_postal_mail` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_sms` SET TAGS ('pii_business_glossary_term' = 'SMS (Short Message Service) Channel Consent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_social_media` SET TAGS ('pii_business_glossary_term' = 'Social Media Channel Consent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `channel_whatsapp` SET TAGS ('pii_business_glossary_term' = 'WhatsApp Channel Consent');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_basis` SET TAGS ('pii_business_glossary_term' = 'Consent Legal Basis');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_basis` SET TAGS ('pii_value_regex' = 'explicit_consent|legitimate_interest|contractual|legal_obligation|vital_interest|public_task');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_granted_date` SET TAGS ('pii_business_glossary_term' = 'Consent Granted Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_granted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Consent Granted Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_language` SET TAGS ('pii_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Collection Method');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_proof_document_url` SET TAGS ('pii_business_glossary_term' = 'Consent Proof Document URL');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_reference_number` SET TAGS ('pii_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_reference_number` SET TAGS ('pii_value_regex' = '^CONSENT-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_source_url` SET TAGS ('pii_business_glossary_term' = 'Consent Source URL (Uniform Resource Locator)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_status` SET TAGS ('pii_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_status` SET TAGS ('pii_value_regex' = 'opted_in|opted_out|pending|expired|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_type` SET TAGS ('pii_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_type` SET TAGS ('pii_value_regex' = 'marketing|fundraising|program_updates|advocacy|research|general');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_version` SET TAGS ('pii_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_version` SET TAGS ('pii_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_withdrawn_date` SET TAGS ('pii_business_glossary_term' = 'Consent Withdrawn Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `consent_withdrawn_timestamp` SET TAGS ('pii_business_glossary_term' = 'Consent Withdrawn Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `constituent_country_code` SET TAGS ('pii_business_glossary_term' = 'Constituent Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `constituent_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `double_opt_in_confirmation_date` SET TAGS ('pii_business_glossary_term' = 'Double Opt-In Confirmation Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `double_opt_in_confirmed` SET TAGS ('pii_business_glossary_term' = 'Double Opt-In Confirmed Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `ip_address` SET TAGS ('pii_business_glossary_term' = 'IP (Internet Protocol) Address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `ip_address` SET TAGS ('pii_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `ip_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `ip_address` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `is_minor` SET TAGS ('pii_business_glossary_term' = 'Minor Status Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `parental_consent_date` SET TAGS ('pii_business_glossary_term' = 'Parental Consent Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `parental_consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Parental Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `preference_content_topics` SET TAGS ('pii_business_glossary_term' = 'Content Topics Preference');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `preference_frequency` SET TAGS ('pii_business_glossary_term' = 'Communication Frequency Preference');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `preference_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|as_needed|never');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `third_party_source` SET TAGS ('pii_business_glossary_term' = 'Third-Party Consent Source');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `user_agent` SET TAGS ('pii_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `user_agent` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ALTER COLUMN `user_agent` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` SET TAGS ('pii_subdomain' = 'constituent_engagement');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `community_engagement_event_id` SET TAGS ('pii_business_glossary_term' = 'Community Engagement Event ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `community_awareness_session_id` SET TAGS ('pii_business_glossary_term' = 'Community Awareness Session Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `feedback_case_id` SET TAGS ('pii_business_glossary_term' = 'Linked Feedback Case ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `implementation_plan_id` SET TAGS ('pii_business_glossary_term' = 'Linked Program Activity ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Facilitator Staff ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Deployment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `action_points` SET TAGS ('pii_business_glossary_term' = 'Action Points');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `admin_level_1` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `admin_level_2` SET TAGS ('pii_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `community_action_plan_output` SET TAGS ('pii_business_glossary_term' = 'Community Action Plan Output');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `community_name` SET TAGS ('pii_business_glossary_term' = 'Community Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `community_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `community_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `data_collection_tool` SET TAGS ('pii_business_glossary_term' = 'Data Collection Tool');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `event_date` SET TAGS ('pii_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `event_reference_number` SET TAGS ('pii_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `event_status` SET TAGS ('pii_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `event_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|cancelled|postponed');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `facilitator_name` SET TAGS ('pii_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `facilitator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `facilitator_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `feedback_received` SET TAGS ('pii_business_glossary_term' = 'Feedback Received');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `key_themes_raised` SET TAGS ('pii_business_glossary_term' = 'Key Themes Raised');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_adults` SET TAGS ('pii_business_glossary_term' = 'Participants Adults');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_children` SET TAGS ('pii_business_glossary_term' = 'Participants Children');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_elderly` SET TAGS ('pii_business_glossary_term' = 'Participants Elderly');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_female` SET TAGS ('pii_business_glossary_term' = 'Participants Female');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_male` SET TAGS ('pii_business_glossary_term' = 'Participants Male');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_other_gender` SET TAGS ('pii_business_glossary_term' = 'Participants Other Gender');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_other_gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_other_gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_other_gender` SET TAGS ('pii_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_other_gender` SET TAGS ('pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_with_disability` SET TAGS ('pii_business_glossary_term' = 'Participants with Disability');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_with_disability` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_with_disability` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `participants_youth` SET TAGS ('pii_business_glossary_term' = 'Participants Youth');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `primary_language` SET TAGS ('pii_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `record_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `total_participants` SET TAGS ('pii_business_glossary_term' = 'Total Participants');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `translation_provided` SET TAGS ('pii_business_glossary_term' = 'Translation Provided');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `venue_name` SET TAGS ('pii_business_glossary_term' = 'Venue Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `venue_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ALTER COLUMN `venue_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` SET TAGS ('pii_subdomain' = 'constituent_engagement');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `donor_stewardship_touchpoint_id` SET TAGS ('pii_business_glossary_term' = 'Donor Stewardship Touchpoint ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `impact_story_id` SET TAGS ('pii_business_glossary_term' = 'Impact Story ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `gift_id` SET TAGS ('pii_business_glossary_term' = 'Linked Gift ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Linked Grant ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Owner ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `compliance_review_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `compliance_review_status` SET TAGS ('pii_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `content_used` SET TAGS ('pii_business_glossary_term' = 'Content Used');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `donor_feedback_text` SET TAGS ('pii_business_glossary_term' = 'Donor Feedback Text');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `donor_response` SET TAGS ('pii_business_glossary_term' = 'Donor Response');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `donor_response` SET TAGS ('pii_value_regex' = 'positive|neutral|negative|no_response|follow_up_requested');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `donor_tier` SET TAGS ('pii_business_glossary_term' = 'Donor Tier');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `follow_up_notes` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `geographic_location` SET TAGS ('pii_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `geographic_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `is_restricted_communication` SET TAGS ('pii_business_glossary_term' = 'Is Restricted Communication Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|archived|deleted');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `sentiment_score` SET TAGS ('pii_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `touchpoint_date` SET TAGS ('pii_business_glossary_term' = 'Touchpoint Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `touchpoint_reference_number` SET TAGS ('pii_business_glossary_term' = 'Touchpoint Reference Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `touchpoint_status` SET TAGS ('pii_business_glossary_term' = 'Touchpoint Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `touchpoint_status` SET TAGS ('pii_value_regex' = 'planned|scheduled|completed|cancelled|deferred');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `touchpoint_timestamp` SET TAGS ('pii_business_glossary_term' = 'Touchpoint Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ALTER COLUMN `touchpoint_type` SET TAGS ('pii_business_glossary_term' = 'Touchpoint Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` SET TAGS ('pii_subdomain' = 'advocacy_outreach');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` SET TAGS ('pii_domain' = 'communication');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` SET TAGS ('pii_category' = 'planning');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `channels` SET TAGS ('pii_business_glossary_term' = 'Channels');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `kpi_targets` SET TAGS ('pii_business_glossary_term' = 'KPI Targets');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `plan_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `objective` SET TAGS ('pii_business_glossary_term' = 'Objective');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ALTER COLUMN `target_audience` SET TAGS ('pii_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` SET TAGS ('pii_subdomain' = 'media_relations');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_communication_id` SET TAGS ('pii_business_glossary_term' = 'Crisis Communication ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Communication Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Crisis Manager Staff ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `sitrep_id` SET TAGS ('pii_business_glossary_term' = 'Related Situation Report (SitRep) ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `tertiary_crisis_communications_lead_staff_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Communications Lead Staff ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `tertiary_crisis_communications_lead_staff_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `tertiary_crisis_communications_lead_staff_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `activation_date` SET TAGS ('pii_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `activation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `affected_beneficiaries_estimated_count` SET TAGS ('pii_business_glossary_term' = 'Affected Beneficiaries Estimated Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `affected_countries` SET TAGS ('pii_business_glossary_term' = 'Affected Countries');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `affected_programs_count` SET TAGS ('pii_business_glossary_term' = 'Affected Programs Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_code` SET TAGS ('pii_business_glossary_term' = 'Crisis Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_communication_status` SET TAGS ('pii_business_glossary_term' = 'Crisis Communication Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_communication_status` SET TAGS ('pii_value_regex' = 'monitoring|activated|active|deactivating|closed|archived');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_description` SET TAGS ('pii_business_glossary_term' = 'Crisis Description');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_name` SET TAGS ('pii_business_glossary_term' = 'Crisis Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_type` SET TAGS ('pii_business_glossary_term' = 'Crisis Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `crisis_type` SET TAGS ('pii_value_regex' = 'natural_disaster|security_incident|reputational_risk|health_emergency|operational_disruption|safeguarding_incident');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `deactivation_date` SET TAGS ('pii_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `deactivation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Deactivation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `donor_notification_sent_date` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Sent Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `external_communications_channel_mix` SET TAGS ('pii_business_glossary_term' = 'External Communications Channel Mix');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `geographic_scope` SET TAGS ('pii_value_regex' = 'local|regional|national|multi_country|global');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `internal_communications_channel_mix` SET TAGS ('pii_business_glossary_term' = 'Internal Communications Channel Mix');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `key_messages_approval_date` SET TAGS ('pii_business_glossary_term' = 'Key Messages Approval Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `key_messages_approved` SET TAGS ('pii_business_glossary_term' = 'Key Messages Approved');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `media_inquiries_received_count` SET TAGS ('pii_business_glossary_term' = 'Media Inquiries Received Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `media_inquiries_responded_count` SET TAGS ('pii_business_glossary_term' = 'Media Inquiries Responded Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `post_crisis_review_date` SET TAGS ('pii_business_glossary_term' = 'Post-Crisis Review Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `post_crisis_review_status` SET TAGS ('pii_business_glossary_term' = 'Post-Crisis Review Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `post_crisis_review_status` SET TAGS ('pii_value_regex' = 'not_started|scheduled|in_progress|completed|published');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `press_releases_issued_count` SET TAGS ('pii_business_glossary_term' = 'Press Releases Issued Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `regulatory_report_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Report Submitted Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `response_actions_taken` SET TAGS ('pii_business_glossary_term' = 'Response Actions Taken');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `root_cause_analysis` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `social_media_posts_count` SET TAGS ('pii_business_glossary_term' = 'Social Media Posts Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `spokesperson_name` SET TAGS ('pii_business_glossary_term' = 'Spokesperson Name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `spokesperson_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `spokesperson_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ALTER COLUMN `stakeholder_briefings_count` SET TAGS ('pii_business_glossary_term' = 'Stakeholder Briefings Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` SET TAGS ('pii_subdomain' = 'advocacy_outreach');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` SET TAGS ('pii_association_edges' = 'communication.advocacy_campaign,communication.media_contact');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `campaign_media_outreach_id` SET TAGS ('pii_business_glossary_term' = 'Campaign Media Outreach ID');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign Media Outreach - Advocacy Campaign Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `media_contact_id` SET TAGS ('pii_business_glossary_term' = 'Campaign Media Outreach - Media Contact Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `contact_role` SET TAGS ('pii_business_glossary_term' = 'Contact Role');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `coverage_publication_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Publication Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `coverage_url` SET TAGS ('pii_business_glossary_term' = 'Coverage URL');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `embargo_agreement_flag` SET TAGS ('pii_business_glossary_term' = 'Embargo Agreement Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `engagement_date` SET TAGS ('pii_business_glossary_term' = 'Engagement Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `interview_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Interview Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `media_kit_sent_date` SET TAGS ('pii_business_glossary_term' = 'Media Kit Sent Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Outreach Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `outreach_status` SET TAGS ('pii_business_glossary_term' = 'Outreach Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_media_outreach` ALTER COLUMN `response_received_flag` SET TAGS ('pii_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` SET TAGS ('pii_subdomain' = 'constituent_engagement');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `message_thread_id` SET TAGS ('pii_business_glossary_term' = 'Message Thread Identifier');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `component_id` SET TAGS ('pii_business_glossary_term' = 'Component Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Constituent Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `field_team_id` SET TAGS ('pii_business_glossary_term' = 'Assigned To Team Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `parent_message_thread_id` SET TAGS ('pii_business_glossary_term' = 'Parent Message Thread Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `parent_message_thread_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'User Account Id');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `account_reference` SET TAGS ('pii_business_glossary_term' = 'Account Reference');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `archived_timestamp` SET TAGS ('pii_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `communication_channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `complaint_category` SET TAGS ('pii_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `data_protection_classification` SET TAGS ('pii_business_glossary_term' = 'Data Protection Classification');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `escalation_level` SET TAGS ('pii_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `first_response_timestamp` SET TAGS ('pii_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `geographic_region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `initiated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Initiated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `is_archived` SET TAGS ('pii_business_glossary_term' = 'Is Archived');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `is_complaint` SET TAGS ('pii_business_glossary_term' = 'Is Complaint');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `last_message_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Message Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `message_count` SET TAGS ('pii_business_glossary_term' = 'Message Count');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `requires_translation` SET TAGS ('pii_business_glossary_term' = 'Requires Translation');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `resolution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `retention_end_date` SET TAGS ('pii_business_glossary_term' = 'Retention End Date');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `satisfaction_rating` SET TAGS ('pii_business_glossary_term' = 'Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `sentiment_score` SET TAGS ('pii_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `tags` SET TAGS ('pii_business_glossary_term' = 'Tags');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `thread_reference_number` SET TAGS ('pii_business_glossary_term' = 'Thread Reference Number');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `thread_status` SET TAGS ('pii_business_glossary_term' = 'Thread Status');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `thread_subject` SET TAGS ('pii_business_glossary_term' = 'Thread Subject');
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ALTER COLUMN `thread_type` SET TAGS ('pii_business_glossary_term' = 'Thread Type');
