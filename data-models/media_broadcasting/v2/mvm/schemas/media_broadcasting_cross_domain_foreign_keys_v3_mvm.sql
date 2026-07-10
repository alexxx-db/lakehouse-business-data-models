-- Cross-Domain Foreign Keys for Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:13
-- Total cross-domain FK constraints: 640
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: audience, billing, compliance, content, distribution, partner, production, rights, sales, scheduling, subscriber, talent

-- ========= audience --> billing (3 constraint(s)) =========
-- Requires: audience schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= audience --> compliance (13 constraint(s)) =========
-- Requires: audience schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`sweeps_period` ADD CONSTRAINT `fk_audience_sweeps_period_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`sweeps_period` ADD CONSTRAINT `fk_audience_sweeps_period_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`audience_profile` ADD CONSTRAINT `fk_audience_audience_profile_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= audience --> content (9 constraint(s)) =========
-- Requires: audience schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`audience_profile` ADD CONSTRAINT `fk_audience_audience_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);

-- ========= audience --> distribution (10 constraint(s)) =========
-- Requires: audience schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= audience --> partner (11 constraint(s)) =========
-- Requires: audience schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);

-- ========= audience --> production (5 constraint(s)) =========
-- Requires: audience schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= audience --> rights (1 constraint(s)) =========
-- Requires: audience schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= audience --> sales (11 constraint(s)) =========
-- Requires: audience schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);

-- ========= audience --> scheduling (14 constraint(s)) =========
-- Requires: audience schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`sweeps_period` ADD CONSTRAINT `fk_audience_sweeps_period_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_guarantee_network_channel_id` FOREIGN KEY (`guarantee_network_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= audience --> subscriber (3 constraint(s)) =========
-- Requires: audience schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`household`(`household_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= billing --> audience (4 constraint(s)) =========
-- Requires: billing schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`tax_record` ADD CONSTRAINT `fk_billing_tax_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`tax_record` ADD CONSTRAINT `fk_billing_tax_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= billing --> content (4 constraint(s)) =========
-- Requires: billing schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);

-- ========= billing --> partner (4 constraint(s)) =========
-- Requires: billing schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= billing --> rights (5 constraint(s)) =========
-- Requires: billing schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`tax_record` ADD CONSTRAINT `fk_billing_tax_record_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= billing --> sales (19 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);

-- ========= billing --> scheduling (2 constraint(s)) =========
-- Requires: billing schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= billing --> subscriber (8 constraint(s)) =========
-- Requires: billing schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= compliance --> content (1 constraint(s)) =========
-- Requires: compliance schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);

-- ========= compliance --> distribution (1 constraint(s)) =========
-- Requires: compliance schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);

-- ========= compliance --> partner (4 constraint(s)) =========
-- Requires: compliance schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license` ADD CONSTRAINT `fk_compliance_broadcast_license_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= compliance --> sales (1 constraint(s)) =========
-- Requires: compliance schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);

-- ========= compliance --> scheduling (3 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= compliance --> talent (1 constraint(s)) =========
-- Requires: compliance schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= content --> billing (1 constraint(s)) =========
-- Requires: content schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= content --> compliance (4 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);

-- ========= content --> distribution (7 constraint(s)) =========
-- Requires: content schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= content --> partner (7 constraint(s)) =========
-- Requires: content schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= content --> production (2 constraint(s)) =========
-- Requires: content schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= content --> rights (14 constraint(s)) =========
-- Requires: content schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_availability_window_id` FOREIGN KEY (`availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`availability_window`(`availability_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= content --> sales (2 constraint(s)) =========
-- Requires: content schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);

-- ========= content --> scheduling (3 constraint(s)) =========
-- Requires: content schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= content --> talent (3 constraint(s)) =========
-- Requires: content schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= distribution --> audience (4 constraint(s)) =========
-- Requires: distribution schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= distribution --> billing (8 constraint(s)) =========
-- Requires: distribution schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= distribution --> compliance (21 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= distribution --> partner (7 constraint(s)) =========
-- Requires: distribution schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= distribution --> rights (11 constraint(s)) =========
-- Requires: distribution schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);

-- ========= distribution --> sales (2 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);

-- ========= distribution --> scheduling (7 constraint(s)) =========
-- Requires: distribution schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= distribution --> subscriber (1 constraint(s)) =========
-- Requires: distribution schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= partner --> audience (1 constraint(s)) =========
-- Requires: partner schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= partner --> billing (6 constraint(s)) =========
-- Requires: partner schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= partner --> compliance (15 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= partner --> content (11 constraint(s)) =========
-- Requires: partner schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);

-- ========= partner --> distribution (8 constraint(s)) =========
-- Requires: partner schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);

-- ========= partner --> production (2 constraint(s)) =========
-- Requires: partner schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);

-- ========= partner --> rights (1 constraint(s)) =========
-- Requires: partner schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= partner --> scheduling (5 constraint(s)) =========
-- Requires: partner schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= partner --> talent (3 constraint(s)) =========
-- Requires: partner schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= production --> audience (2 constraint(s)) =========
-- Requires: production schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);

-- ========= production --> compliance (17 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= production --> content (7 constraint(s)) =========
-- Requires: production schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= production --> distribution (9 constraint(s)) =========
-- Requires: production schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_content_delivery_order_id` FOREIGN KEY (`content_delivery_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`content_delivery_order`(`content_delivery_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);

-- ========= production --> partner (7 constraint(s)) =========
-- Requires: production schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_delivery_obligation_id` FOREIGN KEY (`delivery_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation`(`delivery_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= production --> rights (9 constraint(s)) =========
-- Requires: production schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_statement`(`royalty_statement_id`);

-- ========= production --> sales (5 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);

-- ========= production --> scheduling (7 constraint(s)) =========
-- Requires: production schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_program_rundown_id` FOREIGN KEY (`program_rundown_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown`(`program_rundown_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= production --> talent (1 constraint(s)) =========
-- Requires: production schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= rights --> audience (4 constraint(s)) =========
-- Requires: rights schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);

-- ========= rights --> billing (3 constraint(s)) =========
-- Requires: rights schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= rights --> compliance (15 constraint(s)) =========
-- Requires: rights schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ADD CONSTRAINT `fk_rights_territory_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ADD CONSTRAINT `fk_rights_territory_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= rights --> content (2 constraint(s)) =========
-- Requires: rights schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);

-- ========= rights --> distribution (5 constraint(s)) =========
-- Requires: rights schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ADD CONSTRAINT `fk_rights_content_window_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= rights --> partner (10 constraint(s)) =========
-- Requires: rights schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_minimum_guarantee_id` FOREIGN KEY (`minimum_guarantee_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee`(`minimum_guarantee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= rights --> sales (2 constraint(s)) =========
-- Requires: rights schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);

-- ========= rights --> subscriber (3 constraint(s)) =========
-- Requires: rights schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`availability_window` ADD CONSTRAINT `fk_rights_availability_window_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);

-- ========= rights --> talent (5 constraint(s)) =========
-- Requires: rights schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= sales --> audience (8 constraint(s)) =========
-- Requires: sales schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);

-- ========= sales --> billing (7 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ADD CONSTRAINT `fk_sales_sales_agency_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= sales --> compliance (9 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= sales --> content (7 constraint(s)) =========
-- Requires: sales schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);

-- ========= sales --> distribution (16 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);

-- ========= sales --> partner (13 constraint(s)) =========
-- Requires: sales schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);

-- ========= sales --> production (2 constraint(s)) =========
-- Requires: sales schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= sales --> rights (4 constraint(s)) =========
-- Requires: sales schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= sales --> scheduling (8 constraint(s)) =========
-- Requires: sales schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= sales --> subscriber (3 constraint(s)) =========
-- Requires: sales schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= sales --> talent (3 constraint(s)) =========
-- Requires: sales schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= scheduling --> billing (4 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= scheduling --> compliance (7 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);

-- ========= scheduling --> content (10 constraint(s)) =========
-- Requires: scheduling schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);

-- ========= scheduling --> partner (3 constraint(s)) =========
-- Requires: scheduling schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= scheduling --> production (4 constraint(s)) =========
-- Requires: scheduling schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);

-- ========= scheduling --> rights (6 constraint(s)) =========
-- Requires: scheduling schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_availability_window_id` FOREIGN KEY (`availability_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`availability_window`(`availability_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);

-- ========= scheduling --> sales (2 constraint(s)) =========
-- Requires: scheduling schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);

-- ========= scheduling --> talent (3 constraint(s)) =========
-- Requires: scheduling schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= subscriber --> audience (9 constraint(s)) =========
-- Requires: subscriber schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscriber` ADD CONSTRAINT `fk_subscriber_subscriber_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`segment`(`segment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= subscriber --> billing (10 constraint(s)) =========
-- Requires: subscriber schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscriber` ADD CONSTRAINT `fk_subscriber_subscriber_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_subscription_invoice_id` FOREIGN KEY (`subscription_invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`subscription_invoice`(`subscription_invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`payment_instrument` ADD CONSTRAINT `fk_subscriber_payment_instrument_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= subscriber --> compliance (4 constraint(s)) =========
-- Requires: subscriber schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= subscriber --> content (14 constraint(s)) =========
-- Requires: subscriber schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_windowing_plan_id` FOREIGN KEY (`windowing_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`windowing_plan`(`windowing_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);

-- ========= subscriber --> distribution (10 constraint(s)) =========
-- Requires: subscriber schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= subscriber --> partner (7 constraint(s)) =========
-- Requires: subscriber schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= subscriber --> rights (6 constraint(s)) =========
-- Requires: subscriber schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscriber` ADD CONSTRAINT `fk_subscriber_subscriber_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);

-- ========= subscriber --> sales (2 constraint(s)) =========
-- Requires: subscriber schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);

-- ========= subscriber --> scheduling (1 constraint(s)) =========
-- Requires: subscriber schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= subscriber --> talent (1 constraint(s)) =========
-- Requires: subscriber schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= talent --> audience (2 constraint(s)) =========
-- Requires: talent schema, audience schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `vibe_media_broadcasting_v1`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= talent --> billing (4 constraint(s)) =========
-- Requires: talent schema, billing schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= talent --> compliance (1 constraint(s)) =========
-- Requires: talent schema, compliance schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= talent --> content (11 constraint(s)) =========
-- Requires: talent schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`content_episode`(`content_episode_id`);

-- ========= talent --> distribution (4 constraint(s)) =========
-- Requires: talent schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= talent --> partner (9 constraint(s)) =========
-- Requires: talent schema, partner schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= talent --> production (4 constraint(s)) =========
-- Requires: talent schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= talent --> sales (4 constraint(s)) =========
-- Requires: talent schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);

-- ========= talent --> scheduling (5 constraint(s)) =========
-- Requires: talent schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_playout_event_id` FOREIGN KEY (`playout_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`playout_event`(`playout_event_id`);

