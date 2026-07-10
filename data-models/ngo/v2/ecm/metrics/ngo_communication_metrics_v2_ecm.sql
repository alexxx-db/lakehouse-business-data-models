-- Metric views for domain: communication | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_advocacy_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for advocacy campaigns — tracks fundraising performance, spend efficiency, and reach attainment to guide campaign investment decisions."
  source: "`vibe_ngo_v1`.`communication`.`advocacy_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: advocacy_campaign_type
      comment: "Type of advocacy campaign (e.g. awareness, fundraising, policy) for segmenting performance."
    - name: "campaign_status"
      expr: advocacy_campaign_status
      comment: "Current lifecycle status of the campaign (e.g. active, closed, draft)."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic region or country the campaign targets, enabling regional performance comparison."
    - name: "primary_channel_mix"
      expr: primary_channel_mix
      comment: "Primary channel mix used (e.g. digital, events, media) to assess channel effectiveness."
    - name: "sdg_alignment_tags"
      expr: sdg_alignment_tags
      comment: "SDG goals the campaign is aligned to, supporting impact reporting and donor accountability."
    - name: "is_donor_restricted"
      expr: is_donor_restricted
      comment: "Flag indicating whether the campaign is subject to donor restrictions, affecting spend flexibility."
    - name: "launch_year_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of campaign launch for trend analysis over time."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency in which the campaign budget is denominated."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of advocacy campaigns — baseline volume metric for portfolio sizing."
    - name: "total_actual_fundraising_amount"
      expr: SUM(CAST(actual_fundraising_amount AS DOUBLE))
      comment: "Total funds raised across all campaigns — primary revenue outcome metric for campaign portfolio."
    - name: "total_target_fundraising_amount"
      expr: SUM(CAST(target_fundraising_amount AS DOUBLE))
      comment: "Total fundraising target across campaigns — used as denominator for attainment rate."
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across campaigns — key cost metric for budget management."
    - name: "total_budget_allocated_amount"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across campaigns — used to compute budget utilisation."
    - name: "fundraising_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_fundraising_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_fundraising_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising target achieved — critical KPI for campaign effectiveness review."
    - name: "budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget spent — signals over/under-spend and financial discipline."
    - name: "avg_fundraising_per_campaign"
      expr: AVG(CAST(actual_fundraising_amount AS DOUBLE))
      comment: "Average funds raised per campaign — benchmarks individual campaign productivity."
    - name: "avg_spend_per_campaign"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average spend per campaign — used to assess cost efficiency across the portfolio."
    - name: "return_on_spend"
      expr: ROUND(SUM(CAST(actual_fundraising_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend_amount AS DOUBLE)), 0), 4)
      comment: "Fundraising return per unit of spend — key efficiency ratio for campaign investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_campaign_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Constituent engagement and conversion KPIs at the touchpoint level — informs channel mix, conversion optimisation, and cost-per-outcome decisions."
  source: "`vibe_ngo_v1`.`communication`.`campaign_touchpoint`"
  dimensions:
    - name: "touchpoint_type"
      expr: campaign_touchpoint_type
      comment: "Type of touchpoint (e.g. email, event, social) for channel-level performance analysis."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the touchpoint — drives channel mix optimisation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the touchpoint occurred — enables geographic segmentation."
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion achieved (e.g. donation, sign-up) — links touchpoints to outcomes."
    - name: "device_type"
      expr: device_type
      comment: "Device used by the constituent — informs digital channel optimisation."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the touchpoint content — supports impact attribution reporting."
    - name: "touchpoint_month"
      expr: DATE_TRUNC('month', response_date)
      comment: "Month of touchpoint response for trend analysis."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Whether the constituent opted out — critical for consent and list health monitoring."
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of constituent touchpoints — baseline volume for engagement pipeline."
    - name: "total_conversions"
      expr: SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of touchpoints that resulted in a conversion — primary outcome metric."
    - name: "conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints that converted — key effectiveness KPI for campaign optimisation."
    - name: "total_conversion_value_usd"
      expr: SUM(CAST(conversion_value_usd AS DOUBLE))
      comment: "Total monetary value of all conversions in USD — links engagement activity to financial outcomes."
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_per_touchpoint_usd AS DOUBLE))
      comment: "Total cost of all touchpoints — used to compute cost efficiency ratios."
    - name: "avg_conversion_value_usd"
      expr: AVG(CAST(conversion_value_usd AS DOUBLE))
      comment: "Average conversion value per touchpoint — benchmarks quality of conversions across channels."
    - name: "avg_cost_per_touchpoint_usd"
      expr: AVG(CAST(cost_per_touchpoint_usd AS DOUBLE))
      comment: "Average cost per touchpoint — key efficiency metric for channel budget allocation."
    - name: "cost_per_conversion_usd"
      expr: ROUND(SUM(CAST(cost_per_touchpoint_usd AS DOUBLE)) / NULLIF(SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Cost incurred per successful conversion — critical ROI metric for campaign spend decisions."
    - name: "opt_out_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints resulting in opt-out — signals audience fatigue or message misalignment."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across touchpoints — proxy for constituent satisfaction and message resonance."
    - name: "unique_constituents_reached"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents touched — measures breadth of campaign reach."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_community_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field-level community engagement KPIs — tracks participation volumes, geographic reach, and event delivery to guide field programme decisions."
  source: "`vibe_ngo_v1`.`communication`.`community_engagement_event`"
  dimensions:
    - name: "event_type"
      expr: community_engagement_event_type
      comment: "Type of community engagement event (e.g. consultation, training, awareness) for programme segmentation."
    - name: "event_status"
      expr: community_engagement_event_status
      comment: "Lifecycle status of the event — distinguishes planned, completed, and cancelled events."
    - name: "country_code"
      expr: country_code
      comment: "Country where the event took place — enables geographic performance comparison."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level (e.g. province/state) for sub-national analysis."
    - name: "community_name"
      expr: community_name
      comment: "Name of the community engaged — supports community-level tracking."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language used at the event — informs language access and inclusion planning."
    - name: "translation_provided"
      expr: translation_provided
      comment: "Whether translation was provided — tracks language inclusion compliance."
    - name: "event_month"
      expr: DATE_TRUNC('month', community_engagement_event_date)
      comment: "Month of the event for trend and seasonality analysis."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of community engagement events — baseline delivery volume metric."
    - name: "events_with_translation"
      expr: SUM(CASE WHEN translation_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of events where translation was provided — measures language inclusion coverage."
    - name: "translation_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN translation_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with translation — KPI for language access and inclusion policy compliance."
    - name: "total_event_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total engagement time delivered in minutes — proxy for programme effort and community investment."
    - name: "avg_event_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average event duration in minutes — benchmarks event depth and facilitator time allocation."
    - name: "unique_communities_reached"
      expr: COUNT(DISTINCT community_name)
      comment: "Number of distinct communities engaged — measures geographic and community breadth of outreach."
    - name: "unique_project_sites"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites where events were held — tracks field coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_constituent_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management KPIs — tracks consent coverage, double opt-in compliance, and withdrawal rates to manage regulatory risk and communication eligibility."
  source: "`vibe_ngo_v1`.`communication`.`constituent_consent`"
  dimensions:
    - name: "consent_type"
      expr: constituent_consent_type
      comment: "Type of consent (e.g. marketing, data processing) — segments consent portfolio by purpose."
    - name: "consent_status"
      expr: constituent_consent_status
      comment: "Current status of the consent record (e.g. active, withdrawn, expired)."
    - name: "consent_basis"
      expr: basis
      comment: "Legal basis for consent (e.g. explicit, legitimate interest) — critical for regulatory compliance."
    - name: "consent_method"
      expr: method
      comment: "Method by which consent was obtained (e.g. online form, in-person) — informs consent quality."
    - name: "constituent_country_code"
      expr: constituent_country_code
      comment: "Country of the constituent — enables jurisdiction-level compliance monitoring."
    - name: "applicable_regulation"
      expr: applicable_regulation
      comment: "Regulation governing the consent (e.g. GDPR, CCPA) — supports regulatory reporting."
    - name: "is_minor"
      expr: is_minor
      comment: "Whether the constituent is a minor — flags records requiring parental consent."
    - name: "granted_month"
      expr: DATE_TRUNC('month', granted_date)
      comment: "Month consent was granted — tracks consent acquisition trends over time."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records — baseline for consent portfolio size and regulatory coverage."
    - name: "active_consents"
      expr: SUM(CASE WHEN constituent_consent_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active consents — determines eligible communication audience size."
    - name: "withdrawn_consents"
      expr: SUM(CASE WHEN constituent_consent_status = 'withdrawn' THEN 1 ELSE 0 END)
      comment: "Number of withdrawn consents — tracks opt-out volume and potential audience erosion."
    - name: "withdrawal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN constituent_consent_status = 'withdrawn' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that have been withdrawn — key risk indicator for audience retention."
    - name: "double_opt_in_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN double_opt_in_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents with confirmed double opt-in — measures regulatory compliance quality."
    - name: "parental_consent_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_minor = TRUE AND parental_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_minor = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of minor constituent records with parental consent obtained — critical child safeguarding compliance KPI."
    - name: "unique_constituents_with_consent"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents with at least one consent record — measures consented audience breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_crisis_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crisis communication response KPIs — tracks media response rates, regulatory reporting compliance, and crisis resolution to support executive crisis management decisions."
  source: "`vibe_ngo_v1`.`communication`.`crisis_communication`"
  dimensions:
    - name: "crisis_type"
      expr: crisis_type
      comment: "Type of crisis (e.g. security, natural disaster, reputational) — segments response performance by crisis category."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the crisis — enables prioritisation and resource allocation analysis."
    - name: "crisis_status"
      expr: crisis_communication_status
      comment: "Current status of the crisis communication (e.g. active, resolved) — tracks open vs closed crises."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the crisis — informs regional response capacity planning."
    - name: "post_crisis_review_status"
      expr: post_crisis_review_status
      comment: "Status of the post-crisis review — tracks organisational learning completion."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required — flags compliance-critical crises."
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month of crisis activation — enables trend analysis of crisis frequency."
  measures:
    - name: "total_crises"
      expr: COUNT(1)
      comment: "Total number of crisis communication events — baseline for crisis frequency monitoring."
    - name: "active_crises"
      expr: SUM(CASE WHEN crisis_communication_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active crises — real-time operational risk indicator for leadership."
    - name: "regulatory_reporting_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_required_flag = TRUE AND regulatory_report_submitted_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of crises requiring regulatory reports where a report was submitted — compliance KPI with direct legal risk implications."
    - name: "donor_notification_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN donor_notification_required_flag = TRUE AND donor_notification_sent_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN donor_notification_required_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of crises requiring donor notification where notification was sent — donor relationship risk KPI."
    - name: "post_crisis_review_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN post_crisis_review_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crises with completed post-crisis reviews — measures organisational learning discipline."
    - name: "key_messages_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN key_messages_approved IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crises with approved key messages — tracks communications governance compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_digital_content`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital content performance KPIs — tracks reach, engagement, and content production efficiency to guide digital communications investment."
  source: "`vibe_ngo_v1`.`communication`.`digital_content`"
  dimensions:
    - name: "content_type"
      expr: digital_content_type
      comment: "Type of digital content (e.g. blog, video, social post) — segments performance by format."
    - name: "content_status"
      expr: digital_content_status
      comment: "Publication status of the content (e.g. published, draft, archived)."
    - name: "platform"
      expr: platform
      comment: "Digital platform where content is published (e.g. website, Facebook, YouTube) — channel performance analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the content — supports multilingual reach analysis."
    - name: "moderation_status"
      expr: moderation_status
      comment: "Content moderation status — tracks brand safety and compliance review pipeline."
    - name: "is_brand_compliant"
      expr: is_brand_compliant
      comment: "Whether content meets brand guidelines — quality control dimension."
    - name: "is_accessibility_compliant"
      expr: is_accessibility_compliant
      comment: "Whether content meets accessibility standards — inclusion compliance dimension."
    - name: "publish_month"
      expr: DATE_TRUNC('month', actual_publish_timestamp)
      comment: "Month of content publication — enables content volume and performance trend analysis."
  measures:
    - name: "total_content_pieces"
      expr: COUNT(1)
      comment: "Total number of digital content pieces — baseline production volume metric."
    - name: "total_impressions"
      expr: SUM(CAST(impressions_count AS DOUBLE))
      comment: "Total impressions across all content — measures overall digital visibility."
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS DOUBLE))
      comment: "Total unique reach across all content — measures audience breadth of digital communications."
    - name: "total_video_views"
      expr: SUM(CAST(video_views_count AS DOUBLE))
      comment: "Total video views — key engagement metric for video content investment decisions."
    - name: "total_engagement_actions"
      expr: SUM(CAST(engagement_likes_count AS DOUBLE) + CAST(engagement_comments_count AS DOUBLE) + CAST(engagement_shares_count AS DOUBLE))
      comment: "Total engagement actions (likes + comments + shares) — composite engagement volume metric."
    - name: "total_click_throughs"
      expr: SUM(CAST(click_through_count AS DOUBLE))
      comment: "Total click-throughs across content — measures audience intent and content effectiveness."
    - name: "avg_engagement_per_content"
      expr: AVG(CAST(engagement_likes_count AS DOUBLE) + CAST(engagement_comments_count AS DOUBLE) + CAST(engagement_shares_count AS DOUBLE))
      comment: "Average engagement actions per content piece — benchmarks content quality and resonance."
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(click_through_count AS DOUBLE)) / NULLIF(SUM(CAST(impressions_count AS DOUBLE)), 0), 4)
      comment: "Click-through rate (CTR) — key digital effectiveness KPI for content and channel optimisation."
    - name: "brand_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_brand_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of published content that is brand compliant — governance and quality KPI."
    - name: "accessibility_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_accessibility_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of content meeting accessibility standards — inclusion and regulatory compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_donor_stewardship_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship effectiveness KPIs — tracks touchpoint volume, cost, sentiment, and follow-up compliance to guide donor retention and relationship investment."
  source: "`vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint`"
  dimensions:
    - name: "touchpoint_type"
      expr: donor_stewardship_touchpoint_type
      comment: "Type of stewardship touchpoint (e.g. impact report, call, event) — segments stewardship activity by method."
    - name: "touchpoint_status"
      expr: donor_stewardship_touchpoint_status
      comment: "Status of the touchpoint (e.g. completed, pending) — tracks delivery pipeline."
    - name: "channel"
      expr: channel
      comment: "Communication channel used — informs channel mix optimisation for donor stewardship."
    - name: "donor_tier"
      expr: donor_tier
      comment: "Tier of the donor — enables differentiated stewardship analysis by donor value segment."
    - name: "country_code"
      expr: country_code
      comment: "Country of the stewardship touchpoint — geographic segmentation for regional relationship management."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the stewardship content — supports impact-linked donor communication reporting."
    - name: "is_restricted_communication"
      expr: is_restricted_communication
      comment: "Whether the communication is restricted — flags compliance-sensitive touchpoints."
    - name: "touchpoint_month"
      expr: DATE_TRUNC('month', donor_stewardship_touchpoint_date)
      comment: "Month of the touchpoint — enables stewardship cadence trend analysis."
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total stewardship touchpoints delivered — baseline activity volume for relationship management."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities — key input for cost-per-donor-retained analysis."
    - name: "avg_cost_per_touchpoint"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship touchpoint — efficiency benchmark for stewardship programme."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average donor sentiment score across touchpoints — proxy for donor satisfaction and relationship health."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score — measures stewardship record completeness for CRM governance."
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints requiring follow-up — tracks outstanding relationship management actions."
    - name: "unique_donors_stewarded"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct donors receiving stewardship — measures breadth of active donor relationship management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_feedback_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accountability and feedback mechanism KPIs — tracks case volumes, resolution rates, SLA compliance, and escalation patterns to drive programme accountability improvements."
  source: "`vibe_ngo_v1`.`communication`.`feedback_case`"
  dimensions:
    - name: "feedback_case_type"
      expr: feedback_case_type
      comment: "Type of feedback case (e.g. complaint, suggestion, query) — segments accountability pipeline."
    - name: "feedback_case_status"
      expr: feedback_case_status
      comment: "Current status of the case (e.g. open, resolved, escalated) — tracks resolution pipeline."
    - name: "feedback_case_category"
      expr: feedback_case_category
      comment: "Category of the feedback — identifies systemic issues requiring programme-level response."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the case — enables triage and resource allocation analysis."
    - name: "escalation_tier"
      expr: escalation_tier
      comment: "Escalation tier reached — measures severity distribution of accountability cases."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which feedback was submitted — informs channel accessibility analysis."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether the submission was anonymous — tracks safe reporting channel usage."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month feedback was received — enables trend analysis of feedback volumes."
  measures:
    - name: "total_feedback_cases"
      expr: COUNT(1)
      comment: "Total feedback cases received — baseline accountability mechanism volume."
    - name: "resolved_cases"
      expr: SUM(CASE WHEN feedback_case_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Number of resolved feedback cases — measures accountability system throughput."
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN feedback_case_status = 'resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback cases resolved — primary accountability system effectiveness KPI."
    - name: "sensitive_case_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_sensitive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases flagged as sensitive — risk indicator for safeguarding and protection concerns."
    - name: "anonymous_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_anonymous = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of anonymous submissions — measures safe reporting channel utilisation."
    - name: "unique_registrants_with_cases"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of distinct beneficiaries with feedback cases — measures accountability reach."
    - name: "cases_linked_to_safeguarding"
      expr: SUM(CASE WHEN safeguarding_incident_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of feedback cases linked to safeguarding incidents — critical protection risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_feedback_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficiary feedback submission KPIs — tracks submission volumes, escalation rates, resolution quality, and geographic coverage to inform accountability and programme quality decisions."
  source: "`vibe_ngo_v1`.`communication`.`feedback_submission`"
  dimensions:
    - name: "feedback_category"
      expr: feedback_category
      comment: "Category of the feedback — identifies thematic patterns for programme improvement."
    - name: "feedback_subcategory"
      expr: feedback_subcategory
      comment: "Sub-category for granular issue classification — supports root cause analysis."
    - name: "channel"
      expr: channel
      comment: "Submission channel (e.g. hotline, in-person, digital) — informs channel accessibility planning."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the feedback — enables risk-based prioritisation."
    - name: "country_code"
      expr: country_code
      comment: "Country of submission — geographic segmentation for accountability coverage analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the submission — tracks accountability pipeline health."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether the submission was anonymous — measures safe reporting channel usage."
    - name: "submission_month"
      expr: DATE_TRUNC('month', feedback_submission_date)
      comment: "Month of submission — enables trend analysis of feedback volumes over time."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total feedback submissions received — baseline accountability mechanism volume."
    - name: "escalated_submissions"
      expr: SUM(CASE WHEN requires_escalation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of submissions requiring escalation — measures high-severity accountability burden."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_escalation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions escalated — key risk indicator for programme quality and protection concerns."
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions requiring follow-up — tracks outstanding accountability actions."
    - name: "sensitive_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_sensitive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sensitive submissions — protection risk indicator requiring leadership attention."
    - name: "safeguarding_linked_submissions"
      expr: SUM(CASE WHEN safeguarding_incident_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Submissions linked to safeguarding incidents — critical protection monitoring KPI."
    - name: "unique_registrants_submitting"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of distinct beneficiaries submitting feedback — measures accountability system reach."
    - name: "avg_submitter_satisfaction_rating"
      expr: AVG(CAST(submitter_satisfaction_rating AS DOUBLE))
      comment: "Average satisfaction rating from submitters — measures perceived accountability system quality."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_email_broadcast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email broadcast performance KPIs — tracks delivery, engagement, and compliance quality to guide email channel investment and list health management."
  source: "`vibe_ngo_v1`.`communication`.`email_broadcast`"
  dimensions:
    - name: "broadcast_type"
      expr: email_broadcast_type
      comment: "Type of email broadcast (e.g. newsletter, appeal, update) — segments performance by communication purpose."
    - name: "broadcast_status"
      expr: email_broadcast_status
      comment: "Status of the broadcast (e.g. sent, scheduled, draft) — tracks delivery pipeline."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance review status — tracks regulatory and consent compliance of broadcasts."
    - name: "country_code"
      expr: country_code
      comment: "Country of the broadcast — geographic segmentation for regional email performance."
    - name: "language_code"
      expr: language_code
      comment: "Language of the broadcast — multilingual reach analysis."
    - name: "esp_platform"
      expr: esp_platform
      comment: "Email service provider platform used — informs platform performance and vendor management."
    - name: "is_ab_test"
      expr: is_ab_test
      comment: "Whether the broadcast is an A/B test — segments optimisation experiments from standard sends."
    - name: "send_month"
      expr: DATE_TRUNC('month', send_date)
      comment: "Month of broadcast send — enables email volume and performance trend analysis."
  measures:
    - name: "total_broadcasts"
      expr: COUNT(1)
      comment: "Total email broadcasts sent — baseline email channel activity volume."
    - name: "consent_verified_broadcasts"
      expr: SUM(CASE WHEN consent_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of broadcasts with verified consent — measures consent compliance coverage."
    - name: "consent_verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of broadcasts with verified consent — critical regulatory compliance KPI."
    - name: "unique_segments_targeted"
      expr: COUNT(DISTINCT segment_id)
      comment: "Number of distinct audience segments targeted — measures segmentation breadth of email programme."
    - name: "unique_interventions_supported"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct programme interventions supported by email broadcasts — links communications to programme delivery."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_media_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media relations KPIs — tracks media value, reach, sentiment, and pickup rates to guide media engagement strategy and communications investment."
  source: "`vibe_ngo_v1`.`communication`.`media_activity`"
  dimensions:
    - name: "media_activity_type"
      expr: media_activity_type
      comment: "Type of media activity (e.g. press release, interview, op-ed) — segments media output by format."
    - name: "media_activity_status"
      expr: media_activity_status
      comment: "Status of the media activity (e.g. published, pending, cancelled)."
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of media outlet (e.g. print, broadcast, online) — channel-level media performance analysis."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the media activity — regional media coverage analysis."
    - name: "sentiment"
      expr: sentiment
      comment: "Sentiment of the media coverage (e.g. positive, neutral, negative) — reputational risk indicator."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the media content — supports impact communications reporting."
    - name: "language"
      expr: language
      comment: "Language of the media activity — multilingual media reach analysis."
    - name: "publication_month"
      expr: DATE_TRUNC('month', publication_date)
      comment: "Month of publication — enables media output trend analysis."
  measures:
    - name: "total_media_activities"
      expr: COUNT(1)
      comment: "Total media activities — baseline media output volume metric."
    - name: "total_media_value_usd"
      expr: SUM(CAST(media_value_usd AS DOUBLE))
      comment: "Total earned media value in USD — key ROI metric for communications investment justification."
    - name: "total_reach_estimate"
      expr: SUM(CAST(reach_estimate AS DOUBLE))
      comment: "Total estimated audience reach across all media activities — measures communications visibility."
    - name: "total_circulation_estimate"
      expr: SUM(CAST(circulation_estimate AS DOUBLE))
      comment: "Total circulation across media outlets — measures distribution breadth of media coverage."
    - name: "avg_media_value_usd"
      expr: AVG(CAST(media_value_usd AS DOUBLE))
      comment: "Average media value per activity — benchmarks media relations efficiency."
    - name: "positive_sentiment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of media activities with positive sentiment — reputational health KPI for executive review."
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of media activities with negative sentiment — reputational risk indicator requiring leadership action."
    - name: "beneficiary_feedback_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN beneficiary_feedback_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of media activities featuring beneficiary feedback — measures community voice inclusion in communications."
    - name: "unique_media_contacts_engaged"
      expr: COUNT(DISTINCT media_contact_id)
      comment: "Number of distinct media contacts engaged — measures breadth of media relationship portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_message_thread`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Constituent messaging KPIs — tracks thread volumes, resolution rates, complaint rates, and response timeliness to manage constituent communication quality."
  source: "`vibe_ngo_v1`.`communication`.`message_thread`"
  dimensions:
    - name: "thread_type"
      expr: message_thread_type
      comment: "Type of message thread (e.g. inquiry, complaint, support) — segments communication pipeline."
    - name: "thread_status"
      expr: message_thread_status
      comment: "Current status of the thread (e.g. open, resolved, archived) — tracks resolution pipeline."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the thread (e.g. email, WhatsApp, phone) — channel performance analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the thread — enables triage and SLA management."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached — measures severity distribution of constituent communications."
    - name: "country_code"
      expr: country_code
      comment: "Country of the thread — geographic segmentation for regional communication analysis."
    - name: "is_complaint"
      expr: is_complaint
      comment: "Whether the thread is a complaint — segments complaint volume from general communications."
    - name: "thread_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month thread was created — enables trend analysis of communication volumes."
  measures:
    - name: "total_threads"
      expr: COUNT(1)
      comment: "Total message threads — baseline constituent communication volume."
    - name: "complaint_threads"
      expr: SUM(CASE WHEN is_complaint = TRUE THEN 1 ELSE 0 END)
      comment: "Number of complaint threads — key accountability and satisfaction indicator."
    - name: "complaint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complaint = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of threads that are complaints — constituent satisfaction risk KPI."
    - name: "confidential_thread_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_confidential = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confidential threads — data protection and sensitivity management indicator."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across threads — constituent satisfaction proxy for relationship management."
    - name: "unique_constituents_messaging"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents with active message threads — measures communication engagement breadth."
    - name: "translation_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_translation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of threads requiring translation — informs language access resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication plan portfolio KPIs — tracks budget utilisation, approval compliance, and plan delivery to guide communications resource allocation and governance."
  source: "`vibe_ngo_v1`.`communication`.`plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of communication plan (e.g. campaign, crisis, advocacy) — segments portfolio by purpose."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the plan (e.g. approved, draft, active, closed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan — tracks governance compliance of communications planning."
    - name: "country_code"
      expr: country_code
      comment: "Country the plan covers — geographic segmentation for resource allocation analysis."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the plan budget — financial reporting segmentation."
    - name: "compliance_review_required"
      expr: compliance_review_required
      comment: "Whether a compliance review is required — flags regulated communications plans."
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Status of the compliance review — tracks regulatory compliance pipeline."
    - name: "plan_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the plan starts — enables planning pipeline trend analysis."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total communication plans — baseline portfolio volume metric."
    - name: "total_budget_allocated_amount"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all communication plans — key financial planning metric."
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across all communication plans — financial execution metric."
    - name: "budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget spent — financial discipline KPI for communications portfolio."
    - name: "avg_budget_per_plan"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per communication plan — benchmarks investment scale per initiative."
    - name: "compliance_review_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_review_required = TRUE AND compliance_review_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN compliance_review_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of plans requiring compliance review that have completed it — governance compliance KPI."
    - name: "approved_plans_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans with approved status — measures governance pipeline health."
    - name: "unique_interventions_covered"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct programme interventions covered by communication plans — measures communications-programme alignment."
$$;