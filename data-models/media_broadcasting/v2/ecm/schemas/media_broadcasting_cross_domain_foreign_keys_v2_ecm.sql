-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-06-30 04:18:33
-- Total cross-domain FK constraints: 1526
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: advertising, audience, billing, compliance, content, distribution, finance, mediaasset, partner, production, rights, sales, scheduling, subscriber, talent, technology, workforce

-- ========= advertising --> audience (3 constraint(s)) =========
-- Requires: advertising schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_targeting` ADD CONSTRAINT `fk_advertising_ad_targeting_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= advertising --> content (2 constraint(s)) =========
-- Requires: advertising schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_ad_title_id` FOREIGN KEY (`ad_title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= advertising --> distribution (2 constraint(s)) =========
-- Requires: advertising schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_placement` ADD CONSTRAINT `fk_advertising_ad_placement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= advertising --> mediaasset (1 constraint(s)) =========
-- Requires: advertising schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_creative` ADD CONSTRAINT `fk_advertising_ad_creative_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= advertising --> partner (1 constraint(s)) =========
-- Requires: advertising schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= advertising --> rights (1 constraint(s)) =========
-- Requires: advertising schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= advertising --> sales (9 constraint(s)) =========
-- Requires: advertising schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`exchange`(`exchange_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_ssp_id` FOREIGN KEY (`ssp_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ssp`(`ssp_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`campaign` ADD CONSTRAINT `fk_advertising_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ADD CONSTRAINT `fk_advertising_creative_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_sales_product_id` FOREIGN KEY (`sales_product_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_product`(`sales_product_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_creative` ADD CONSTRAINT `fk_advertising_ad_creative_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_campaign` ADD CONSTRAINT `fk_advertising_ad_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_campaign` ADD CONSTRAINT `fk_advertising_ad_campaign_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);

-- ========= advertising --> scheduling (4 constraint(s)) =========
-- Requires: advertising schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_placement` ADD CONSTRAINT `fk_advertising_ad_placement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= advertising --> workforce (1 constraint(s)) =========
-- Requires: advertising schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= audience --> compliance (21 constraint(s)) =========
-- Requires: audience schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`sweeps_period` ADD CONSTRAINT `fk_audience_sweeps_period_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`calendar`(`calendar_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`sweeps_period` ADD CONSTRAINT `fk_audience_sweeps_period_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`segment_regulatory_compliance` ADD CONSTRAINT `fk_audience_segment_regulatory_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= audience --> content (7 constraint(s)) =========
-- Requires: audience schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`dsp_usage_report` ADD CONSTRAINT `fk_audience_dsp_usage_report_master_recording_id` FOREIGN KEY (`master_recording_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`master_recording`(`master_recording_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`dsp_usage_report` ADD CONSTRAINT `fk_audience_dsp_usage_report_release_id` FOREIGN KEY (`release_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`release`(`release_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`content_feature_vector` ADD CONSTRAINT `fk_audience_content_feature_vector_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= audience --> distribution (4 constraint(s)) =========
-- Requires: audience schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);

-- ========= audience --> finance (5 constraint(s)) =========
-- Requires: audience schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= audience --> partner (4 constraint(s)) =========
-- Requires: audience schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`market_distribution_agreement` ADD CONSTRAINT `fk_audience_market_distribution_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= audience --> production (8 constraint(s)) =========
-- Requires: audience schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= audience --> sales (14 constraint(s)) =========
-- Requires: audience schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`clean_room_match` ADD CONSTRAINT `fk_audience_clean_room_match_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`clean_room_match` ADD CONSTRAINT `fk_audience_clean_room_match_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewability_record` ADD CONSTRAINT `fk_audience_viewability_record_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewability_record` ADD CONSTRAINT `fk_audience_viewability_record_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);

-- ========= audience --> scheduling (7 constraint(s)) =========
-- Requires: audience schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= audience --> subscriber (6 constraint(s)) =========
-- Requires: audience schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`household`(`household_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewer_feature_vector` ADD CONSTRAINT `fk_audience_viewer_feature_vector_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewer_feature_vector` ADD CONSTRAINT `fk_audience_viewer_feature_vector_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= audience --> talent (1 constraint(s)) =========
-- Requires: audience schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`talent_demographic_appeal` ADD CONSTRAINT `fk_audience_talent_demographic_appeal_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= audience --> technology (4 constraint(s)) =========
-- Requires: audience schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= audience --> workforce (4 constraint(s)) =========
-- Requires: audience schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> audience (4 constraint(s)) =========
-- Requires: billing schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`(`nielsen_rating_id`);

-- ========= billing --> compliance (9 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`tax_record` ADD CONSTRAINT `fk_billing_tax_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= billing --> content (5 constraint(s)) =========
-- Requires: billing schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_compliance_finding_id` FOREIGN KEY (`compliance_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`compliance_finding`(`compliance_finding_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= billing --> distribution (2 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);

-- ========= billing --> finance (26 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_product` ADD CONSTRAINT `fk_billing_billing_product_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= billing --> partner (9 constraint(s)) =========
-- Requires: billing schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);

-- ========= billing --> rights (3 constraint(s)) =========
-- Requires: billing schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= billing --> sales (24 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_makegood_id` FOREIGN KEY (`makegood_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`makegood`(`makegood_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_makegood_id` FOREIGN KEY (`makegood_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`makegood`(`makegood_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);

-- ========= billing --> subscriber (11 constraint(s)) =========
-- Requires: billing schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= billing --> talent (1 constraint(s)) =========
-- Requires: billing schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);

-- ========= billing --> technology (12 constraint(s)) =========
-- Requires: billing schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_satellite_transponder_id` FOREIGN KEY (`satellite_transponder_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`satellite_transponder`(`satellite_transponder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);

-- ========= billing --> workforce (19 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_tertiary_credit_modified_by_user_employee_id` FOREIGN KEY (`tertiary_credit_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`tax_record` ADD CONSTRAINT `fk_billing_tax_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> content (10 constraint(s)) =========
-- Requires: compliance schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`anti_piracy_takedown` ADD CONSTRAINT `fk_compliance_anti_piracy_takedown_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`correction_record` ADD CONSTRAINT `fk_compliance_correction_record_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`correction_record` ADD CONSTRAINT `fk_compliance_correction_record_news_story_id` FOREIGN KEY (`news_story_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`news_story`(`news_story_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_watermark_forensic_match` ADD CONSTRAINT `fk_compliance_compliance_watermark_forensic_match_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= compliance --> distribution (4 constraint(s)) =========
-- Requires: compliance schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_watermark_forensic_match` ADD CONSTRAINT `fk_compliance_compliance_watermark_forensic_match_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);

-- ========= compliance --> mediaasset (12 constraint(s)) =========
-- Requires: compliance schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`anti_piracy_takedown` ADD CONSTRAINT `fk_compliance_anti_piracy_takedown_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_watermark_forensic_match` ADD CONSTRAINT `fk_compliance_compliance_watermark_forensic_match_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= compliance --> partner (2 constraint(s)) =========
-- Requires: compliance schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= compliance --> rights (2 constraint(s)) =========
-- Requires: compliance schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`anti_piracy_takedown` ADD CONSTRAINT `fk_compliance_anti_piracy_takedown_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_watermark_forensic_match` ADD CONSTRAINT `fk_compliance_compliance_watermark_forensic_match_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= compliance --> sales (3 constraint(s)) =========
-- Requires: compliance schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);

-- ========= compliance --> scheduling (4 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= compliance --> subscriber (4 constraint(s)) =========
-- Requires: compliance schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_subscriber_consent_record_id` FOREIGN KEY (`subscriber_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber_consent_record`(`subscriber_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_compliance_subscriber_subscriber_consent_record_id` FOREIGN KEY (`compliance_subscriber_subscriber_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber_consent_record`(`subscriber_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= compliance --> talent (2 constraint(s)) =========
-- Requires: compliance schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= compliance --> technology (16 constraint(s)) =========
-- Requires: compliance schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ADD CONSTRAINT `fk_compliance_broadcast_license_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ADD CONSTRAINT `fk_compliance_broadcast_license_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance_obligation` ADD CONSTRAINT `fk_compliance_facility_compliance_obligation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ADD CONSTRAINT `fk_compliance_facility_compliance_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`correction_record` ADD CONSTRAINT `fk_compliance_correction_record_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= compliance --> workforce (22 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ADD CONSTRAINT `fk_compliance_broadcast_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`license_renewal` ADD CONSTRAINT `fk_compliance_license_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation` ADD CONSTRAINT `fk_compliance_accessibility_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`facility_compliance` ADD CONSTRAINT `fk_compliance_facility_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`correction_record` ADD CONSTRAINT `fk_compliance_correction_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= content --> advertising (1 constraint(s)) =========
-- Requires: content schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`podcast_dynamic_ad_insertion` ADD CONSTRAINT `fk_content_podcast_dynamic_ad_insertion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`campaign`(`campaign_id`);

-- ========= content --> billing (3 constraint(s)) =========
-- Requires: content schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`billing_line` ADD CONSTRAINT `fk_content_billing_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= content --> compliance (8 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ADD CONSTRAINT `fk_content_rating_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= content --> distribution (10 constraint(s)) =========
-- Requires: content schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= content --> finance (7 constraint(s)) =========
-- Requires: content schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`billing_line` ADD CONSTRAINT `fk_content_billing_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= content --> mediaasset (11 constraint(s)) =========
-- Requires: content schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_asset_usage` ADD CONSTRAINT `fk_content_title_asset_usage_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`sports_team` ADD CONSTRAINT `fk_content_sports_team_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`athlete` ADD CONSTRAINT `fk_content_athlete_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_provenance` ADD CONSTRAINT `fk_content_content_provenance_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= content --> partner (11 constraint(s)) =========
-- Requires: content schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`distribution_package` ADD CONSTRAINT `fk_content_distribution_package_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`composition` ADD CONSTRAINT `fk_content_composition_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`publisher`(`publisher_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`master_recording` ADD CONSTRAINT `fk_content_master_recording_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`release` ADD CONSTRAINT `fk_content_release_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`dubbing_session` ADD CONSTRAINT `fk_content_dubbing_session_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);

-- ========= content --> rights (23 constraint(s)) =========
-- Requires: content schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`master_recording` ADD CONSTRAINT `fk_content_master_recording_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);

-- ========= content --> sales (6 constraint(s)) =========
-- Requires: content schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ADD CONSTRAINT `fk_content_genre_buy_agreement_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);

-- ========= content --> scheduling (2 constraint(s)) =========
-- Requires: content schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ADD CONSTRAINT `fk_content_episode_transmission_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ADD CONSTRAINT `fk_content_episode_transmission_episode_channel_id` FOREIGN KEY (`episode_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= content --> talent (11 constraint(s)) =========
-- Requires: content schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ADD CONSTRAINT `fk_content_series_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_talent_credit` ADD CONSTRAINT `fk_content_series_talent_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`credit` ADD CONSTRAINT `fk_content_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`athlete` ADD CONSTRAINT `fk_content_athlete_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`voice_actor_assignment` ADD CONSTRAINT `fk_content_voice_actor_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`voice_actor_assignment` ADD CONSTRAINT `fk_content_voice_actor_assignment_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`voice_actor_assignment` ADD CONSTRAINT `fk_content_voice_actor_assignment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= content --> technology (14 constraint(s)) =========
-- Requires: content schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_satellite_transponder_id` FOREIGN KEY (`satellite_transponder_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`satellite_transponder`(`satellite_transponder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode_transmission` ADD CONSTRAINT `fk_content_episode_transmission_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`dubbing_session` ADD CONSTRAINT `fk_content_dubbing_session_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);

-- ========= content --> workforce (13 constraint(s)) =========
-- Requires: content schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement` ADD CONSTRAINT `fk_content_genre_buy_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series_crew_assignment` ADD CONSTRAINT `fk_content_series_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_provenance` ADD CONSTRAINT `fk_content_content_provenance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= distribution --> advertising (1 constraint(s)) =========
-- Requires: distribution schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`frequency_cap_state` ADD CONSTRAINT `fk_distribution_frequency_cap_state_creative_id` FOREIGN KEY (`creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`creative`(`creative_id`);

-- ========= distribution --> audience (17 constraint(s)) =========
-- Requires: distribution schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= distribution --> billing (8 constraint(s)) =========
-- Requires: distribution schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_billing_carriage_fee_invoice_id` FOREIGN KEY (`billing_carriage_fee_invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice`(`billing_carriage_fee_invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= distribution --> compliance (25 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`app_version` ADD CONSTRAINT `fk_distribution_app_version_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_technical_standard_cert_id` FOREIGN KEY (`technical_standard_cert_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert`(`technical_standard_cert_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_technical_standard_cert_id` FOREIGN KEY (`technical_standard_cert_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`technical_standard_cert`(`technical_standard_cert_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_compliance` ADD CONSTRAINT `fk_distribution_channel_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= distribution --> content (8 constraint(s)) =========
-- Requires: distribution schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_type_ref` ADD CONSTRAINT `fk_distribution_platform_type_ref_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`multi_angle_feed` ADD CONSTRAINT `fk_distribution_multi_angle_feed_sports_event_id` FOREIGN KEY (`sports_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`sports_event`(`sports_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`betting_data_feed` ADD CONSTRAINT `fk_distribution_betting_data_feed_sports_event_id` FOREIGN KEY (`sports_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`sports_event`(`sports_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`recommendation_event` ADD CONSTRAINT `fk_distribution_recommendation_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`clip_distribution_event` ADD CONSTRAINT `fk_distribution_clip_distribution_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_network_clearance` ADD CONSTRAINT `fk_distribution_distribution_network_clearance_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= distribution --> finance (13 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= distribution --> mediaasset (10 constraint(s)) =========
-- Requires: distribution schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout` ADD CONSTRAINT `fk_distribution_playout_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`multi_angle_feed` ADD CONSTRAINT `fk_distribution_multi_angle_feed_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`clip_distribution_event` ADD CONSTRAINT `fk_distribution_clip_distribution_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= distribution --> partner (6 constraint(s)) =========
-- Requires: distribution schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`platform_distribution_agreement` ADD CONSTRAINT `fk_distribution_platform_distribution_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`endpoint_allocation` ADD CONSTRAINT `fk_distribution_endpoint_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`betting_data_feed` ADD CONSTRAINT `fk_distribution_betting_data_feed_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`affiliate_station` ADD CONSTRAINT `fk_distribution_affiliate_station_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= distribution --> rights (12 constraint(s)) =========
-- Requires: distribution schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window`(`rights_availability_window_id`);

-- ========= distribution --> sales (17 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_dsp_id` FOREIGN KEY (`dsp_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`dsp`(`dsp_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`exchange`(`exchange_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_ssp_id` FOREIGN KEY (`ssp_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ssp`(`ssp_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`frequency_cap_state` ADD CONSTRAINT `fk_distribution_frequency_cap_state_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`frequency_cap_state` ADD CONSTRAINT `fk_distribution_frequency_cap_state_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);

-- ========= distribution --> scheduling (12 constraint(s)) =========
-- Requires: distribution schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`affiliate_station` ADD CONSTRAINT `fk_distribution_affiliate_station_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_network_clearance` ADD CONSTRAINT `fk_distribution_distribution_network_clearance_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_local_avail_inventory` ADD CONSTRAINT `fk_distribution_distribution_local_avail_inventory_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_local_avail_inventory` ADD CONSTRAINT `fk_distribution_distribution_local_avail_inventory_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);

-- ========= distribution --> subscriber (7 constraint(s)) =========
-- Requires: distribution schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`frequency_cap_state` ADD CONSTRAINT `fk_distribution_frequency_cap_state_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`household`(`household_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`frequency_cap_state` ADD CONSTRAINT `fk_distribution_frequency_cap_state_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`recommendation_event` ADD CONSTRAINT `fk_distribution_recommendation_event_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ab_test_assignment` ADD CONSTRAINT `fk_distribution_ab_test_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ab_test_assignment` ADD CONSTRAINT `fk_distribution_ab_test_assignment_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= distribution --> talent (3 constraint(s)) =========
-- Requires: distribution schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= distribution --> technology (43 constraint(s)) =========
-- Requires: distribution schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`device_type` ADD CONSTRAINT `fk_distribution_device_type_broadcast_standard_id` FOREIGN KEY (`broadcast_standard_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_standard`(`broadcast_standard_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_noc_monitor_id` FOREIGN KEY (`noc_monitor_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`noc_monitor`(`noc_monitor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_software_license_id` FOREIGN KEY (`software_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_tech_sla_id` FOREIGN KEY (`tech_sla_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_sla`(`tech_sla_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_broadcast_standard_id` FOREIGN KEY (`broadcast_standard_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_standard`(`broadcast_standard_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_tech_incident_id` FOREIGN KEY (`tech_incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_incident`(`tech_incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_noc_alert_id` FOREIGN KEY (`noc_alert_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`noc_alert`(`noc_alert_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_tech_incident_id` FOREIGN KEY (`tech_incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_incident`(`tech_incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_noc_monitor_id` FOREIGN KEY (`noc_monitor_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`noc_monitor`(`noc_monitor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_tech_sla_id` FOREIGN KEY (`tech_sla_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_sla`(`tech_sla_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_software_license_id` FOREIGN KEY (`software_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_satellite_transponder_id` FOREIGN KEY (`satellite_transponder_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`satellite_transponder`(`satellite_transponder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_noc_alert_id` FOREIGN KEY (`noc_alert_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`noc_alert`(`noc_alert_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`multi_angle_feed` ADD CONSTRAINT `fk_distribution_multi_angle_feed_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`affiliate_station` ADD CONSTRAINT `fk_distribution_affiliate_station_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= distribution --> workforce (19 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_definition` ADD CONSTRAINT `fk_distribution_sla_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`feature_flag` ADD CONSTRAINT `fk_distribution_feature_flag_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_sla` ADD CONSTRAINT `fk_distribution_delivery_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> billing (2 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> compliance (13 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ADD CONSTRAINT `fk_finance_ebitda_snapshot_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ADD CONSTRAINT `fk_finance_obligation_gl_mapping_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ADD CONSTRAINT `fk_finance_cost_center_obligation_allocation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= finance --> content (1 constraint(s)) =========
-- Requires: finance schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= finance --> partner (4 constraint(s)) =========
-- Requires: finance schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);

-- ========= finance --> production (4 constraint(s)) =========
-- Requires: finance schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ADD CONSTRAINT `fk_finance_project_assignment_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget_line`(`budget_line_id`);

-- ========= finance --> rights (1 constraint(s)) =========
-- Requires: finance schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= finance --> sales (2 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_ad_sales_order_id` FOREIGN KEY (`ad_sales_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order`(`ad_sales_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);

-- ========= finance --> subscriber (3 constraint(s)) =========
-- Requires: finance schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= finance --> talent (1 constraint(s)) =========
-- Requires: finance schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);

-- ========= finance --> technology (15 constraint(s)) =========
-- Requires: finance schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_equipment_procurement_id` FOREIGN KEY (`equipment_procurement_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`equipment_procurement`(`equipment_procurement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ADD CONSTRAINT `fk_finance_facility_legal_assignment_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ADD CONSTRAINT `fk_finance_facility_cost_allocation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= finance --> workforce (21 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ADD CONSTRAINT `fk_finance_project_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ADD CONSTRAINT `fk_finance_project_assignment_project_approved_by_employee_id` FOREIGN KEY (`project_approved_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ADD CONSTRAINT `fk_finance_project_assignment_project_employee_id` FOREIGN KEY (`project_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ADD CONSTRAINT `fk_finance_cost_center_obligation_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ADD CONSTRAINT `fk_finance_cost_center_obligation_allocation_cost_responsible_contact_employee_id` FOREIGN KEY (`cost_responsible_contact_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ADD CONSTRAINT `fk_finance_cost_center_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ADD CONSTRAINT `fk_finance_cost_center_authorization_cost_granted_by_employee_id` FOREIGN KEY (`cost_granted_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ADD CONSTRAINT `fk_finance_cost_center_authorization_cost_revoked_by_employee_id` FOREIGN KEY (`cost_revoked_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ADD CONSTRAINT `fk_finance_facility_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_recurring_employee_id` FOREIGN KEY (`recurring_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_recurring_last_modified_by_user_employee_id` FOREIGN KEY (`recurring_last_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= mediaasset --> compliance (1 constraint(s)) =========
-- Requires: mediaasset schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ADD CONSTRAINT `fk_mediaasset_mediaasset_watermark_forensic_match_anti_piracy_takedown_id` FOREIGN KEY (`anti_piracy_takedown_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`anti_piracy_takedown`(`anti_piracy_takedown_id`);

-- ========= mediaasset --> finance (10 constraint(s)) =========
-- Requires: mediaasset schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= mediaasset --> partner (6 constraint(s)) =========
-- Requires: mediaasset schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ADD CONSTRAINT `fk_mediaasset_asset_rights_grant_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license` ADD CONSTRAINT `fk_mediaasset_deal_asset_license_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);

-- ========= mediaasset --> sales (1 constraint(s)) =========
-- Requires: mediaasset schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory` ADD CONSTRAINT `fk_mediaasset_syndication_inventory_sales_syndication_deal_id` FOREIGN KEY (`sales_syndication_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal`(`sales_syndication_deal_id`);

-- ========= mediaasset --> subscriber (1 constraint(s)) =========
-- Requires: mediaasset schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ADD CONSTRAINT `fk_mediaasset_mediaasset_watermark_forensic_match_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= mediaasset --> talent (1 constraint(s)) =========
-- Requires: mediaasset schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold` ADD CONSTRAINT `fk_mediaasset_legal_hold_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= mediaasset --> technology (5 constraint(s)) =========
-- Requires: mediaasset schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_tech_change_request_id` FOREIGN KEY (`tech_change_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_change_request`(`tech_change_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ADD CONSTRAINT `fk_mediaasset_storage_location_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_tech_change_request_id` FOREIGN KEY (`tech_change_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`tech_change_request`(`tech_change_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_specification` ADD CONSTRAINT `fk_mediaasset_format_specification_broadcast_standard_id` FOREIGN KEY (`broadcast_standard_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_standard`(`broadcast_standard_id`);

-- ========= mediaasset --> workforce (11 constraint(s)) =========
-- Requires: mediaasset schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_primary_asset_employee_id` FOREIGN KEY (`primary_asset_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant` ADD CONSTRAINT `fk_mediaasset_asset_rights_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_legal_hold` ADD CONSTRAINT `fk_mediaasset_asset_legal_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match` ADD CONSTRAINT `fk_mediaasset_mediaasset_watermark_forensic_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= partner --> audience (9 constraint(s)) =========
-- Requires: partner schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= partner --> billing (5 constraint(s)) =========
-- Requires: partner schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_billing_billing_dispute_id` FOREIGN KEY (`billing_billing_dispute_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_dispute`(`billing_dispute_id`);

-- ========= partner --> compliance (20 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ADD CONSTRAINT `fk_partner_license_ownership_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ADD CONSTRAINT `fk_partner_deal_compliance_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= partner --> content (12 constraint(s)) =========
-- Requires: partner schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);

-- ========= partner --> distribution (1 constraint(s)) =========
-- Requires: partner schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);

-- ========= partner --> finance (18 constraint(s)) =========
-- Requires: partner schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ADD CONSTRAINT `fk_partner_partner_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= partner --> mediaasset (8 constraint(s)) =========
-- Requires: partner schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= partner --> production (2 constraint(s)) =========
-- Requires: partner schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= partner --> rights (6 constraint(s)) =========
-- Requires: partner schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_rights_audit_event_id` FOREIGN KEY (`rights_audit_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event`(`rights_audit_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_partner_rights_rights_audit_event_id` FOREIGN KEY (`partner_rights_rights_audit_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event`(`rights_audit_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`publisher` ADD CONSTRAINT `fk_partner_publisher_rights_pro_affiliation_id` FOREIGN KEY (`rights_pro_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_pro_affiliation`(`rights_pro_affiliation_id`);

-- ========= partner --> sales (5 constraint(s)) =========
-- Requires: partner schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_sales_deal_approval_id` FOREIGN KEY (`sales_deal_approval_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval`(`sales_deal_approval_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_partner_sales_sales_deal_approval_id` FOREIGN KEY (`partner_sales_sales_deal_approval_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval`(`sales_deal_approval_id`);

-- ========= partner --> scheduling (9 constraint(s)) =========
-- Requires: partner schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_affiliate_network_channel_id` FOREIGN KEY (`affiliate_network_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_primary_affiliate_station_channel_id` FOREIGN KEY (`primary_affiliate_station_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_scheduling_availability_window_id` FOREIGN KEY (`scheduling_availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window`(`scheduling_availability_window_id`);

-- ========= partner --> talent (5 constraint(s)) =========
-- Requires: partner schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ADD CONSTRAINT `fk_partner_payment_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);

-- ========= partner --> workforce (18 constraint(s)) =========
-- Requires: partner schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_tertiary_deal_legal_reviewer_employee_id` FOREIGN KEY (`tertiary_deal_legal_reviewer_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ADD CONSTRAINT `fk_partner_deal_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_quaternary_renewal_legal_reviewer_employee_id` FOREIGN KEY (`quaternary_renewal_legal_reviewer_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_tertiary_renewal_finance_approver_employee_id` FOREIGN KEY (`tertiary_renewal_finance_approver_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= production --> billing (1 constraint(s)) =========
-- Requires: production schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= production --> compliance (15 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_compliance_content_rating_id` FOREIGN KEY (`compliance_content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);

-- ========= production --> content (24 constraint(s)) =========
-- Requires: production schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_content_clearance_id` FOREIGN KEY (`content_clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_clearance`(`content_clearance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_production_content_content_clearance_id` FOREIGN KEY (`production_content_content_clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_clearance`(`content_clearance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_voice_actor_assignment` ADD CONSTRAINT `fk_production_production_voice_actor_assignment_dubbing_session_id` FOREIGN KEY (`dubbing_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`dubbing_session`(`dubbing_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_dubbing_session` ADD CONSTRAINT `fk_production_production_dubbing_session_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_dubbing_session` ADD CONSTRAINT `fk_production_production_dubbing_session_localization_id` FOREIGN KEY (`localization_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`localization`(`localization_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_dubbing_session` ADD CONSTRAINT `fk_production_production_dubbing_session_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= production --> distribution (9 constraint(s)) =========
-- Requires: production schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_content_delivery_order_id` FOREIGN KEY (`content_delivery_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order`(`content_delivery_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);

-- ========= production --> finance (12 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= production --> mediaasset (8 constraint(s)) =========
-- Requires: production schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= production --> partner (16 constraint(s)) =========
-- Requires: production schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ADD CONSTRAINT `fk_production_location_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ADD CONSTRAINT `fk_production_equipment_type_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ADD CONSTRAINT `fk_production_rental_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_dubbing_session` ADD CONSTRAINT `fk_production_production_dubbing_session_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);

-- ========= production --> rights (6 constraint(s)) =========
-- Requires: production schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ADD CONSTRAINT `fk_production_broadcast_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_content_window`(`rights_content_window_id`);

-- ========= production --> sales (7 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ADD CONSTRAINT `fk_production_episode_sponsorship_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ADD CONSTRAINT `fk_production_project_sponsorship_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);

-- ========= production --> scheduling (5 constraint(s)) =========
-- Requires: production schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ADD CONSTRAINT `fk_production_broadcast_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ADD CONSTRAINT `fk_production_broadcast_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= production --> talent (3 constraint(s)) =========
-- Requires: production schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_voice_actor_assignment` ADD CONSTRAINT `fk_production_production_voice_actor_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_voice_actor_assignment` ADD CONSTRAINT `fk_production_production_voice_actor_assignment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= production --> technology (9 constraint(s)) =========
-- Requires: production schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_dubbing_session` ADD CONSTRAINT `fk_production_production_dubbing_session_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);

-- ========= production --> workforce (26 constraint(s)) =========
-- Requires: production schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_primary_qc_employee_id` FOREIGN KEY (`primary_qc_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_tertiary_daily_submitted_by_user_employee_id` FOREIGN KEY (`tertiary_daily_submitted_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ADD CONSTRAINT `fk_production_episode_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_shoot_employee_id` FOREIGN KEY (`shoot_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_shoot_first_assistant_director_employee_id` FOREIGN KEY (`shoot_first_assistant_director_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= rights --> audience (5 constraint(s)) =========
-- Requires: rights schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_territory` ADD CONSTRAINT `fk_rights_rights_territory_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_cross_platform_measurement_id` FOREIGN KEY (`cross_platform_measurement_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement`(`cross_platform_measurement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_reach_frequency_report_id` FOREIGN KEY (`reach_frequency_report_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report`(`reach_frequency_report_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= rights --> compliance (11 constraint(s)) =========
-- Requires: rights schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= rights --> content (10 constraint(s)) =========
-- Requires: rights schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_composition_id` FOREIGN KEY (`composition_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`composition`(`composition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_composition_id` FOREIGN KEY (`composition_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`composition`(`composition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_composition_id` FOREIGN KEY (`composition_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`composition`(`composition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_master_recording_id` FOREIGN KEY (`master_recording_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`master_recording`(`master_recording_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_content_portfolio_id` FOREIGN KEY (`content_portfolio_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_portfolio`(`content_portfolio_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`event_blackout_rule` ADD CONSTRAINT `fk_rights_event_blackout_rule_sports_event_id` FOREIGN KEY (`sports_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`sports_event`(`sports_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`event_blackout_rule` ADD CONSTRAINT `fk_rights_event_blackout_rule_sports_league_id` FOREIGN KEY (`sports_league_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`sports_league`(`sports_league_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`event_blackout_rule` ADD CONSTRAINT `fk_rights_event_blackout_rule_sports_team_id` FOREIGN KEY (`sports_team_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`sports_team`(`sports_team_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`neighbouring_rights_claim` ADD CONSTRAINT `fk_rights_neighbouring_rights_claim_master_recording_id` FOREIGN KEY (`master_recording_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`master_recording`(`master_recording_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`mechanical_royalty_report` ADD CONSTRAINT `fk_rights_mechanical_royalty_report_composition_id` FOREIGN KEY (`composition_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`composition`(`composition_id`);

-- ========= rights --> distribution (1 constraint(s)) =========
-- Requires: rights schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= rights --> finance (10 constraint(s)) =========
-- Requires: rights schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule` ADD CONSTRAINT `fk_rights_license_fee_schedule_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_payable`(`accounts_payable_id`);

-- ========= rights --> mediaasset (12 constraint(s)) =========
-- Requires: rights schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= rights --> partner (10 constraint(s)) =========
-- Requires: rights schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_partner_content_window_id` FOREIGN KEY (`partner_content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_content_window`(`partner_content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_partner_content_window_id` FOREIGN KEY (`partner_content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_content_window`(`partner_content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_primary_licensee_party_partner_id` FOREIGN KEY (`primary_licensee_party_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_partner_partner_id` FOREIGN KEY (`partner_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_partner_pro_affiliation_id` FOREIGN KEY (`partner_pro_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_pro_affiliation`(`partner_pro_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_type_ref` ADD CONSTRAINT `fk_rights_rights_type_ref_partner_type_ref_id` FOREIGN KEY (`partner_type_ref_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_type_ref`(`partner_type_ref_id`);

-- ========= rights --> sales (2 constraint(s)) =========
-- Requires: rights schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);

-- ========= rights --> scheduling (1 constraint(s)) =========
-- Requires: rights schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= rights --> talent (3 constraint(s)) =========
-- Requires: rights schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= rights --> technology (2 constraint(s)) =========
-- Requires: rights schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= rights --> workforce (16 constraint(s)) =========
-- Requires: rights schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_tertiary_conflict_resolved_by_analyst_employee_id` FOREIGN KEY (`tertiary_conflict_resolved_by_analyst_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_primary_rights_employee_id` FOREIGN KEY (`primary_rights_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_rights_created_by_employee_id` FOREIGN KEY (`rights_created_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_rights_employee_id` FOREIGN KEY (`rights_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_rights_modified_by_employee_id` FOREIGN KEY (`rights_modified_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> advertising (5 constraint(s)) =========
-- Requires: sales schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`rate_card`(`rate_card_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`rate_card`(`rate_card_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`rate_card`(`rate_card_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`bid_response` ADD CONSTRAINT `fk_sales_bid_response_creative_id` FOREIGN KEY (`creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`creative`(`creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_local_avail_inventory` ADD CONSTRAINT `fk_sales_sales_local_avail_inventory_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`rate_card`(`rate_card_id`);

-- ========= sales --> audience (10 constraint(s)) =========
-- Requires: sales schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= sales --> billing (10 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_billing_billing_account_id` FOREIGN KEY (`billing_billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ADD CONSTRAINT `fk_sales_agency_commission_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ADD CONSTRAINT `fk_sales_sales_product_billing_product_id` FOREIGN KEY (`billing_product_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_product`(`billing_product_id`);

-- ========= sales --> compliance (11 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_ad_standards_clearance_id` FOREIGN KEY (`ad_standards_clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`ad_standards_clearance`(`ad_standards_clearance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);

-- ========= sales --> content (11 constraint(s)) =========
-- Requires: sales schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_ad_title_id` FOREIGN KEY (`ad_title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_content_library_id` FOREIGN KEY (`content_library_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_library`(`content_library_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= sales --> distribution (12 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`bid_request` ADD CONSTRAINT `fk_sales_bid_request_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_local_avail_inventory` ADD CONSTRAINT `fk_sales_sales_local_avail_inventory_affiliate_station_id` FOREIGN KEY (`affiliate_station_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`affiliate_station`(`affiliate_station_id`);

-- ========= sales --> finance (27 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= sales --> mediaasset (7 constraint(s)) =========
-- Requires: sales schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_dai_media_asset_id` FOREIGN KEY (`dai_media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= sales --> partner (8 constraint(s)) =========
-- Requires: sales schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_partner_contact_id` FOREIGN KEY (`partner_contact_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_sales_partner_partner_contact_id` FOREIGN KEY (`sales_partner_partner_contact_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= sales --> production (1 constraint(s)) =========
-- Requires: sales schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= sales --> rights (11 constraint(s)) =========
-- Requires: sales schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_rights_syndication_deal_id` FOREIGN KEY (`rights_syndication_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal`(`rights_syndication_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_sales_rights_syndication_deal_id` FOREIGN KEY (`sales_rights_syndication_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal`(`rights_syndication_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_territory`(`rights_territory_id`);

-- ========= sales --> scheduling (27 constraint(s)) =========
-- Requires: sales schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_scte_marker_id` FOREIGN KEY (`scte_marker_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker`(`scte_marker_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_scte_marker_id` FOREIGN KEY (`scte_marker_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker`(`scte_marker_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_local_avail_inventory` ADD CONSTRAINT `fk_sales_sales_local_avail_inventory_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_local_avail_inventory` ADD CONSTRAINT `fk_sales_sales_local_avail_inventory_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_local_avail_inventory` ADD CONSTRAINT `fk_sales_sales_local_avail_inventory_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= sales --> subscriber (4 constraint(s)) =========
-- Requires: sales schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= sales --> talent (4 constraint(s)) =========
-- Requires: sales schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ADD CONSTRAINT `fk_sales_sales_agency_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= sales --> technology (6 constraint(s)) =========
-- Requires: sales schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_broadcast_standard_id` FOREIGN KEY (`broadcast_standard_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_standard`(`broadcast_standard_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ADD CONSTRAINT `fk_sales_facility_service_agreement_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= sales --> workforce (37 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_tertiary_advertiser_updated_by_user_employee_id` FOREIGN KEY (`tertiary_advertiser_updated_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_tertiary_upfront_modified_by_user_employee_id` FOREIGN KEY (`tertiary_upfront_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_quaternary_sponsorship_modified_by_user_employee_id` FOREIGN KEY (`quaternary_sponsorship_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_tertiary_sponsorship_employee_id` FOREIGN KEY (`tertiary_sponsorship_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_sales_last_modified_by_user_employee_id` FOREIGN KEY (`sales_last_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_proposal_created_by_employee_id` FOREIGN KEY (`proposal_created_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` ADD CONSTRAINT `fk_sales_scatter_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` ADD CONSTRAINT `fk_sales_scatter_order_scatter_created_by_employee_id` FOREIGN KEY (`scatter_created_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_tertiary_upfront_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_upfront_last_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_tertiary_quinary_sales_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_quinary_sales_last_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_tertiary_sales_submitted_by_user_employee_id` FOREIGN KEY (`tertiary_sales_submitted_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ADD CONSTRAINT `fk_sales_proposal_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ADD CONSTRAINT `fk_sales_sales_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= scheduling --> audience (1 constraint(s)) =========
-- Requires: scheduling schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting` ADD CONSTRAINT `fk_scheduling_channel_targeting_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= scheduling --> billing (4 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_billing_carriage_fee_invoice_id` FOREIGN KEY (`billing_carriage_fee_invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_carriage_fee_invoice`(`billing_carriage_fee_invoice_id`);

-- ========= scheduling --> compliance (10 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);

-- ========= scheduling --> content (8 constraint(s)) =========
-- Requires: scheduling schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ADD CONSTRAINT `fk_scheduling_channel_license_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` ADD CONSTRAINT `fk_scheduling_scheduling_network_clearance_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= scheduling --> distribution (12 constraint(s)) =========
-- Requires: scheduling schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart` ADD CONSTRAINT `fk_scheduling_daypart_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_retransmission_consent_id` FOREIGN KEY (`retransmission_consent_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`retransmission_consent`(`retransmission_consent_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ADD CONSTRAINT `fk_scheduling_channel_carriage_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ADD CONSTRAINT `fk_scheduling_channel_abr_assignment_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` ADD CONSTRAINT `fk_scheduling_scheduling_network_clearance_affiliate_station_id` FOREIGN KEY (`affiliate_station_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`affiliate_station`(`affiliate_station_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` ADD CONSTRAINT `fk_scheduling_scheduling_local_avail_inventory_affiliate_station_id` FOREIGN KEY (`affiliate_station_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`affiliate_station`(`affiliate_station_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory` ADD CONSTRAINT `fk_scheduling_scheduling_local_avail_inventory_distribution_local_avail_inventory_id` FOREIGN KEY (`distribution_local_avail_inventory_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_local_avail_inventory`(`distribution_local_avail_inventory_id`);

-- ========= scheduling --> finance (6 constraint(s)) =========
-- Requires: scheduling schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= scheduling --> mediaasset (7 constraint(s)) =========
-- Requires: scheduling schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_asset_playout` ADD CONSTRAINT `fk_scheduling_channel_asset_playout_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= scheduling --> partner (3 constraint(s)) =========
-- Requires: scheduling schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= scheduling --> rights (6 constraint(s)) =========
-- Requires: scheduling schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_rights_blackout_rule_id` FOREIGN KEY (`rights_blackout_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule`(`rights_blackout_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_scheduling_rights_rights_blackout_rule_id` FOREIGN KEY (`scheduling_rights_rights_blackout_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_blackout_rule`(`rights_blackout_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`rights_availability_window`(`rights_availability_window_id`);

-- ========= scheduling --> sales (5 constraint(s)) =========
-- Requires: scheduling schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_affidavit_id` FOREIGN KEY (`affidavit_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`affidavit`(`affidavit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation` ADD CONSTRAINT `fk_scheduling_channel_allocation_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);

-- ========= scheduling --> talent (5 constraint(s)) =========
-- Requires: scheduling schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= scheduling --> technology (9 constraint(s)) =========
-- Requires: scheduling schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= scheduling --> workforce (15 constraint(s)) =========
-- Requires: scheduling schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_abr_assignment` ADD CONSTRAINT `fk_scheduling_channel_abr_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ADD CONSTRAINT `fk_scheduling_daypart_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ADD CONSTRAINT `fk_scheduling_daypart_assignment_daypart_backup_employee_id` FOREIGN KEY (`daypart_backup_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ADD CONSTRAINT `fk_scheduling_daypart_assignment_daypart_employee_id` FOREIGN KEY (`daypart_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`daypart_assignment` ADD CONSTRAINT `fk_scheduling_daypart_assignment_daypart_supervisor_employee_id` FOREIGN KEY (`daypart_supervisor_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scheduling_network_clearance` ADD CONSTRAINT `fk_scheduling_scheduling_network_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= subscriber --> audience (6 constraint(s)) =========
-- Requires: subscriber schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscriber` ADD CONSTRAINT `fk_subscriber_subscriber_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`communication_preference` ADD CONSTRAINT `fk_subscriber_communication_preference_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);

-- ========= subscriber --> billing (4 constraint(s)) =========
-- Requires: subscriber schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`payment_instrument` ADD CONSTRAINT `fk_subscriber_payment_instrument_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`add_on` ADD CONSTRAINT `fk_subscriber_add_on_billing_product_id` FOREIGN KEY (`billing_product_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_product`(`billing_product_id`);

-- ========= subscriber --> compliance (2 constraint(s)) =========
-- Requires: subscriber schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscriber_consent_record` ADD CONSTRAINT `fk_subscriber_subscriber_consent_record_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);

-- ========= subscriber --> content (9 constraint(s)) =========
-- Requires: subscriber schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_vod_library_id` FOREIGN KEY (`vod_library_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`vod_library`(`vod_library_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= subscriber --> distribution (7 constraint(s)) =========
-- Requires: subscriber schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_app_version_id` FOREIGN KEY (`app_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`app_version`(`app_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_personalization_engine_id` FOREIGN KEY (`personalization_engine_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`personalization_engine`(`personalization_engine_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);

-- ========= subscriber --> finance (7 constraint(s)) =========
-- Requires: subscriber schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= subscriber --> mediaasset (1 constraint(s)) =========
-- Requires: subscriber schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= subscriber --> partner (3 constraint(s)) =========
-- Requires: subscriber schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= subscriber --> sales (1 constraint(s)) =========
-- Requires: subscriber schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);

-- ========= subscriber --> technology (1 constraint(s)) =========
-- Requires: subscriber schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`outage_record`(`outage_record_id`);

-- ========= subscriber --> workforce (9 constraint(s)) =========
-- Requires: subscriber schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`payment_instrument` ADD CONSTRAINT `fk_subscriber_payment_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscriber_consent_record` ADD CONSTRAINT `fk_subscriber_subscriber_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`communication_preference` ADD CONSTRAINT `fk_subscriber_communication_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`support_case` ADD CONSTRAINT `fk_subscriber_support_case_assigned_employee_id` FOREIGN KEY (`assigned_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`support_case` ADD CONSTRAINT `fk_subscriber_support_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= talent --> billing (5 constraint(s)) =========
-- Requires: talent schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= talent --> compliance (2 constraint(s)) =========
-- Requires: talent schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= talent --> content (21 constraint(s)) =========
-- Requires: talent schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_content_clearance_id` FOREIGN KEY (`content_clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_clearance`(`content_clearance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_talent_content_content_clearance_id` FOREIGN KEY (`talent_content_content_clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_clearance`(`content_clearance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`participation_statement` ADD CONSTRAINT `fk_talent_participation_statement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`bonus_trigger` ADD CONSTRAINT `fk_talent_bonus_trigger_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deferred_compensation` ADD CONSTRAINT `fk_talent_deferred_compensation_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_sports_team` ADD CONSTRAINT `fk_talent_talent_sports_team_league_id` FOREIGN KEY (`league_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`sports_league`(`sports_league_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_sports_team` ADD CONSTRAINT `fk_talent_talent_sports_team_sports_league_id` FOREIGN KEY (`sports_league_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`sports_league`(`sports_league_id`);

-- ========= talent --> distribution (1 constraint(s)) =========
-- Requires: talent schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_athlete` ADD CONSTRAINT `fk_talent_talent_athlete_betting_data_feed_id` FOREIGN KEY (`betting_data_feed_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`betting_data_feed`(`betting_data_feed_id`);

-- ========= talent --> finance (7 constraint(s)) =========
-- Requires: talent schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= talent --> mediaasset (6 constraint(s)) =========
-- Requires: talent schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_sports_team` ADD CONSTRAINT `fk_talent_talent_sports_team_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= talent --> partner (4 constraint(s)) =========
-- Requires: talent schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`partner_relationship` ADD CONSTRAINT `fk_talent_partner_relationship_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= talent --> production (7 constraint(s)) =========
-- Requires: talent schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_production_clearance_id` FOREIGN KEY (`production_clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_clearance`(`production_clearance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ADD CONSTRAINT `fk_talent_talent_grievance_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= talent --> rights (3 constraint(s)) =========
-- Requires: talent schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= talent --> sales (6 constraint(s)) =========
-- Requires: talent schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_content_license_deal_id` FOREIGN KEY (`content_license_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`content_license_deal`(`content_license_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_content_license_deal_id` FOREIGN KEY (`content_license_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`content_license_deal`(`content_license_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_ad_sales_order_id` FOREIGN KEY (`ad_sales_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order`(`ad_sales_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ADD CONSTRAINT `fk_talent_endorsement_deal_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);

-- ========= talent --> technology (5 constraint(s)) =========
-- Requires: talent schema, technology schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ADD CONSTRAINT `fk_talent_facility_access_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= talent --> workforce (11 constraint(s)) =========
-- Requires: talent schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`cba_rate_card` ADD CONSTRAINT `fk_talent_cba_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract_amendment` ADD CONSTRAINT `fk_talent_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_grievance` ADD CONSTRAINT `fk_talent_talent_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`endorsement_deal` ADD CONSTRAINT `fk_talent_endorsement_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`facility_access` ADD CONSTRAINT `fk_talent_facility_access_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= technology --> compliance (4 constraint(s)) =========
-- Requires: technology schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`outage_record` ADD CONSTRAINT `fk_technology_outage_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`incident`(`incident_id`);

-- ========= technology --> partner (5 constraint(s)) =========
-- Requires: technology schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`transmission_equipment` ADD CONSTRAINT `fk_technology_transmission_equipment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`vendor_contract` ADD CONSTRAINT `fk_technology_vendor_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`equipment_procurement` ADD CONSTRAINT `fk_technology_equipment_procurement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`tech_asset_lifecycle` ADD CONSTRAINT `fk_technology_tech_asset_lifecycle_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= technology --> scheduling (3 constraint(s)) =========
-- Requires: technology schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`encoder_config` ADD CONSTRAINT `fk_technology_encoder_config_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= technology --> subscriber (1 constraint(s)) =========
-- Requires: technology schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= technology --> workforce (11 constraint(s)) =========
-- Requires: technology schema, workforce schema
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_tertiary_maintenance_approved_by_employee_id` FOREIGN KEY (`tertiary_maintenance_approved_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`maintenance_schedule` ADD CONSTRAINT `fk_technology_maintenance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`maintenance_schedule` ADD CONSTRAINT `fk_technology_maintenance_schedule_tertiary_maintenance_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_maintenance_last_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`vendor_contract` ADD CONSTRAINT `fk_technology_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`vendor_contract` ADD CONSTRAINT `fk_technology_vendor_contract_primary_vendor_employee_id` FOREIGN KEY (`primary_vendor_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_tertiary_tech_resolved_by_user_employee_id` FOREIGN KEY (`tertiary_tech_resolved_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`tech_asset_lifecycle` ADD CONSTRAINT `fk_technology_tech_asset_lifecycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`technology`.`tech_asset_lifecycle` ADD CONSTRAINT `fk_technology_tech_asset_lifecycle_tertiary_tech_created_by_user_employee_id` FOREIGN KEY (`tertiary_tech_created_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> billing (1 constraint(s)) =========
-- Requires: workforce schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`cycle`(`cycle_id`);

-- ========= workforce --> finance (2 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> production (2 constraint(s)) =========
-- Requires: workforce schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);

-- ========= workforce --> scheduling (6 constraint(s)) =========
-- Requires: workforce schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);

