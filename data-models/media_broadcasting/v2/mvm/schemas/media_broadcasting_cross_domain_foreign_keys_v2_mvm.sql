-- Cross-Domain Foreign Keys for Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:05
-- Total cross-domain FK constraints: 374
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: advertising, audience, content, distribution, mediaasset, production, rights, sales, scheduling, subscriber, talent

-- ========= advertising --> audience (9 constraint(s)) =========
-- Requires: advertising schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`panel`(`panel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ADD CONSTRAINT `fk_advertising_creative_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` ADD CONSTRAINT `fk_advertising_targeting_rule_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_viewership_record_id` FOREIGN KEY (`viewership_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`viewership_record`(`viewership_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);

-- ========= advertising --> content (3 constraint(s)) =========
-- Requires: advertising schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ADD CONSTRAINT `fk_advertising_creative_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);

-- ========= advertising --> distribution (5 constraint(s)) =========
-- Requires: advertising schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);

-- ========= advertising --> production (1 constraint(s)) =========
-- Requires: advertising schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);

-- ========= advertising --> rights (3 constraint(s)) =========
-- Requires: advertising schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ADD CONSTRAINT `fk_advertising_creative_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`music_sync_license`(`music_sync_license_id`);

-- ========= advertising --> sales (5 constraint(s)) =========
-- Requires: advertising schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign` ADD CONSTRAINT `fk_advertising_advertising_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign` ADD CONSTRAINT `fk_advertising_advertising_campaign_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ADD CONSTRAINT `fk_advertising_creative_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` ADD CONSTRAINT `fk_advertising_placement_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);

-- ========= advertising --> scheduling (7 constraint(s)) =========
-- Requires: advertising schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` ADD CONSTRAINT `fk_advertising_placement_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);

-- ========= advertising --> subscriber (7 constraint(s)) =========
-- Requires: advertising schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` ADD CONSTRAINT `fk_advertising_placement_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` ADD CONSTRAINT `fk_advertising_targeting_rule_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`device_registration`(`device_registration_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` ADD CONSTRAINT `fk_advertising_click_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= advertising --> talent (1 constraint(s)) =========
-- Requires: advertising schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ADD CONSTRAINT `fk_advertising_creative_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= audience --> content (11 constraint(s)) =========
-- Requires: audience schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);

-- ========= audience --> distribution (8 constraint(s)) =========
-- Requires: audience schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`audience_profile` ADD CONSTRAINT `fk_audience_audience_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= audience --> mediaasset (4 constraint(s)) =========
-- Requires: audience schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= audience --> production (3 constraint(s)) =========
-- Requires: audience schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);

-- ========= audience --> sales (15 constraint(s)) =========
-- Requires: audience schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`audience_profile` ADD CONSTRAINT `fk_audience_audience_profile_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);

-- ========= audience --> scheduling (16 constraint(s)) =========
-- Requires: audience schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_epg_entry_id` FOREIGN KEY (`epg_entry_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry`(`epg_entry_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`audience_profile` ADD CONSTRAINT `fk_audience_audience_profile_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= audience --> subscriber (6 constraint(s)) =========
-- Requires: audience schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`household`(`household_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= content --> audience (2 constraint(s)) =========
-- Requires: content schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= content --> distribution (6 constraint(s)) =========
-- Requires: content schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);

-- ========= content --> mediaasset (7 constraint(s)) =========
-- Requires: content schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_ingest_job_id` FOREIGN KEY (`ingest_job_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`(`ingest_job_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_ingest_job_id` FOREIGN KEY (`ingest_job_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`(`ingest_job_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= content --> production (7 constraint(s)) =========
-- Requires: content schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= content --> rights (16 constraint(s)) =========
-- Requires: content schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= content --> sales (1 constraint(s)) =========
-- Requires: content schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);

-- ========= content --> talent (5 constraint(s)) =========
-- Requires: content schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= distribution --> audience (1 constraint(s)) =========
-- Requires: distribution schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= distribution --> mediaasset (6 constraint(s)) =========
-- Requires: distribution schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= distribution --> rights (6 constraint(s)) =========
-- Requires: distribution schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= distribution --> sales (7 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ADD CONSTRAINT `fk_distribution_partner_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);

-- ========= distribution --> scheduling (10 constraint(s)) =========
-- Requires: distribution schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_epg_entry_id` FOREIGN KEY (`epg_entry_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry`(`epg_entry_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= distribution --> subscriber (1 constraint(s)) =========
-- Requires: distribution schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= distribution --> talent (1 constraint(s)) =========
-- Requires: distribution schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`clearance`(`clearance_id`);

-- ========= mediaasset --> advertising (1 constraint(s)) =========
-- Requires: mediaasset schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_creative_id` FOREIGN KEY (`creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`creative`(`creative_id`);

-- ========= mediaasset --> production (4 constraint(s)) =========
-- Requires: mediaasset schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);

-- ========= mediaasset --> rights (2 constraint(s)) =========
-- Requires: mediaasset schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);

-- ========= mediaasset --> sales (1 constraint(s)) =========
-- Requires: mediaasset schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);

-- ========= production --> advertising (1 constraint(s)) =========
-- Requires: production schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_creative_id` FOREIGN KEY (`creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`creative`(`creative_id`);

-- ========= production --> audience (2 constraint(s)) =========
-- Requires: production schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= production --> content (7 constraint(s)) =========
-- Requires: production schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= production --> distribution (9 constraint(s)) =========
-- Requires: production schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);

-- ========= production --> mediaasset (5 constraint(s)) =========
-- Requires: production schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= production --> rights (6 constraint(s)) =========
-- Requires: production schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);

-- ========= production --> sales (2 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);

-- ========= production --> scheduling (3 constraint(s)) =========
-- Requires: production schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= production --> talent (10 constraint(s)) =========
-- Requires: production schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_deal_memo_id` FOREIGN KEY (`deal_memo_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`deal_memo`(`deal_memo_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`clearance`(`clearance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);

-- ========= rights --> advertising (1 constraint(s)) =========
-- Requires: rights schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);

-- ========= rights --> audience (3 constraint(s)) =========
-- Requires: rights schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_reach_frequency_report_id` FOREIGN KEY (`reach_frequency_report_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report`(`reach_frequency_report_id`);

-- ========= rights --> content (4 constraint(s)) =========
-- Requires: rights schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= rights --> distribution (2 constraint(s)) =========
-- Requires: rights schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= rights --> mediaasset (7 constraint(s)) =========
-- Requires: rights schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_qc_inspection_id` FOREIGN KEY (`qc_inspection_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`(`qc_inspection_id`);

-- ========= rights --> production (3 constraint(s)) =========
-- Requires: rights schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);

-- ========= rights --> sales (2 constraint(s)) =========
-- Requires: rights schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);

-- ========= rights --> talent (7 constraint(s)) =========
-- Requires: rights schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= sales --> advertising (1 constraint(s)) =========
-- Requires: sales schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`rate_card`(`rate_card_id`);

-- ========= sales --> audience (5 constraint(s)) =========
-- Requires: sales schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= sales --> content (5 constraint(s)) =========
-- Requires: sales schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);

-- ========= sales --> mediaasset (2 constraint(s)) =========
-- Requires: sales schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= sales --> rights (2 constraint(s)) =========
-- Requires: sales schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);

-- ========= sales --> scheduling (10 constraint(s)) =========
-- Requires: sales schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_playout_event_id` FOREIGN KEY (`playout_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`playout_event`(`playout_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= sales --> subscriber (3 constraint(s)) =========
-- Requires: sales schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= sales --> talent (1 constraint(s)) =========
-- Requires: sales schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= scheduling --> content (10 constraint(s)) =========
-- Requires: scheduling schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ADD CONSTRAINT `fk_scheduling_channel_license_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ADD CONSTRAINT `fk_scheduling_channel_license_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= scheduling --> mediaasset (7 constraint(s)) =========
-- Requires: scheduling schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= scheduling --> production (1 constraint(s)) =========
-- Requires: scheduling schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);

-- ========= scheduling --> rights (7 constraint(s)) =========
-- Requires: scheduling schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_license` ADD CONSTRAINT `fk_scheduling_channel_license_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= scheduling --> talent (4 constraint(s)) =========
-- Requires: scheduling schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= subscriber --> advertising (1 constraint(s)) =========
-- Requires: subscriber schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);

-- ========= subscriber --> audience (5 constraint(s)) =========
-- Requires: subscriber schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscriber` ADD CONSTRAINT `fk_subscriber_subscriber_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= subscriber --> content (9 constraint(s)) =========
-- Requires: subscriber schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= subscriber --> distribution (9 constraint(s)) =========
-- Requires: subscriber schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`deal`(`deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);

-- ========= subscriber --> mediaasset (1 constraint(s)) =========
-- Requires: subscriber schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= subscriber --> production (1 constraint(s)) =========
-- Requires: subscriber schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);

-- ========= subscriber --> rights (1 constraint(s)) =========
-- Requires: subscriber schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);

-- ========= subscriber --> scheduling (1 constraint(s)) =========
-- Requires: subscriber schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= talent --> advertising (1 constraint(s)) =========
-- Requires: talent schema, advertising schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);

-- ========= talent --> content (10 constraint(s)) =========
-- Requires: talent schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);

-- ========= talent --> mediaasset (6 constraint(s)) =========
-- Requires: talent schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= talent --> production (1 constraint(s)) =========
-- Requires: talent schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= talent --> rights (5 constraint(s)) =========
-- Requires: talent schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= talent --> sales (3 constraint(s)) =========
-- Requires: talent schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`clearance` ADD CONSTRAINT `fk_talent_clearance_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);

