-- Cross-Domain Foreign Keys for Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-07-10 22:20:57
-- Total cross-domain FK constraints: 359
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: channel, event, fnb, guest, inventory, loyalty, property, reservation, revenue

-- ========= channel --> guest (7 constraint(s)) =========
-- Requires: channel schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= channel --> inventory (2 constraint(s)) =========
-- Requires: channel schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= channel --> loyalty (2 constraint(s)) =========
-- Requires: channel schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);

-- ========= channel --> property (16 constraint(s)) =========
-- Requires: channel schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`ota_partner` ADD CONSTRAINT `fk_channel_ota_partner_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);

-- ========= channel --> reservation (4 constraint(s)) =========
-- Requires: channel schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

-- ========= channel --> revenue (7 constraint(s)) =========
-- Requires: channel schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`booking_source` ADD CONSTRAINT `fk_channel_booking_source_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_rate_restriction_id` FOREIGN KEY (`rate_restriction_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction`(`rate_restriction_id`);

-- ========= event --> channel (11 constraint(s)) =========
-- Requires: event schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);

-- ========= event --> fnb (8 constraint(s)) =========
-- Requires: event schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= event --> guest (6 constraint(s)) =========
-- Requires: event schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);

-- ========= event --> loyalty (8 constraint(s)) =========
-- Requires: event schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= event --> property (19 constraint(s)) =========
-- Requires: event schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= event --> reservation (1 constraint(s)) =========
-- Requires: event schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

-- ========= event --> revenue (5 constraint(s)) =========
-- Requires: event schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_negotiated_rate_id` FOREIGN KEY (`negotiated_rate_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate`(`negotiated_rate_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= fnb --> channel (1 constraint(s)) =========
-- Requires: fnb schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_booking`(`channel_booking_id`);

-- ========= fnb --> event (1 constraint(s)) =========
-- Requires: fnb schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);

-- ========= fnb --> guest (5 constraint(s)) =========
-- Requires: fnb schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);

-- ========= fnb --> inventory (3 constraint(s)) =========
-- Requires: fnb schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= fnb --> loyalty (6 constraint(s)) =========
-- Requires: fnb schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);

-- ========= fnb --> property (9 constraint(s)) =========
-- Requires: fnb schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ADD CONSTRAINT `fk_fnb_revenue_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= fnb --> reservation (3 constraint(s)) =========
-- Requires: fnb schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_group_block_id` FOREIGN KEY (`group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`group_block`(`group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_special_request_id` FOREIGN KEY (`special_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`special_request`(`special_request_id`);

-- ========= guest --> channel (1 constraint(s)) =========
-- Requires: guest schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= guest --> event (2 constraint(s)) =========
-- Requires: guest schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= guest --> inventory (5 constraint(s)) =========
-- Requires: guest schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= guest --> loyalty (4 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= guest --> property (11 constraint(s)) =========
-- Requires: guest schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= guest --> reservation (4 constraint(s)) =========
-- Requires: guest schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_group_block_id` FOREIGN KEY (`group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`group_block`(`group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= guest --> revenue (3 constraint(s)) =========
-- Requires: guest schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= inventory --> channel (5 constraint(s)) =========
-- Requires: inventory schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_channel_rate_plan_id` FOREIGN KEY (`channel_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`(`channel_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= inventory --> event (3 constraint(s)) =========
-- Requires: inventory schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_contract_id` FOREIGN KEY (`event_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_contract`(`event_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`proposal`(`proposal_id`);

-- ========= inventory --> guest (3 constraint(s)) =========
-- Requires: inventory schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= inventory --> loyalty (5 constraint(s)) =========
-- Requires: inventory schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);

-- ========= inventory --> property (13 constraint(s)) =========
-- Requires: inventory schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= inventory --> reservation (1 constraint(s)) =========
-- Requires: inventory schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= inventory --> revenue (7 constraint(s)) =========
-- Requires: inventory schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_rate_availability_id` FOREIGN KEY (`rate_availability_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`rate_availability`(`rate_availability_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_dynamic_rate_rule_id` FOREIGN KEY (`dynamic_rate_rule_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule`(`dynamic_rate_rule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= loyalty --> channel (6 constraint(s)) =========
-- Requires: loyalty schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= loyalty --> event (2 constraint(s)) =========
-- Requires: loyalty schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= loyalty --> fnb (2 constraint(s)) =========
-- Requires: loyalty schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);

-- ========= loyalty --> guest (2 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);

-- ========= loyalty --> inventory (6 constraint(s)) =========
-- Requires: loyalty schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= loyalty --> property (26 constraint(s)) =========
-- Requires: loyalty schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_property_id` FOREIGN KEY (`member_property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member_preference` ADD CONSTRAINT `fk_loyalty_member_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= loyalty --> reservation (1 constraint(s)) =========
-- Requires: loyalty schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= loyalty --> revenue (4 constraint(s)) =========
-- Requires: loyalty schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= property --> channel (2 constraint(s)) =========
-- Requires: property schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_gds_connection_id` FOREIGN KEY (`gds_connection_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`gds_connection`(`gds_connection_id`);

-- ========= property --> fnb (4 constraint(s)) =========
-- Requires: property schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`facility` ADD CONSTRAINT `fk_property_facility_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= property --> revenue (1 constraint(s)) =========
-- Requires: property schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ADD CONSTRAINT `fk_property_seasonal_calendar_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= reservation --> channel (10 constraint(s)) =========
-- Requires: reservation schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_gds_connection_id` FOREIGN KEY (`gds_connection_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`gds_connection`(`gds_connection_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);

-- ========= reservation --> event (3 constraint(s)) =========
-- Requires: reservation schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_event_contract_id` FOREIGN KEY (`event_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_contract`(`event_contract_id`);

-- ========= reservation --> fnb (1 constraint(s)) =========
-- Requires: reservation schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= reservation --> guest (12 constraint(s)) =========
-- Requires: reservation schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`preference`(`preference_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`vip_designation`(`vip_designation_id`);

-- ========= reservation --> inventory (5 constraint(s)) =========
-- Requires: reservation schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_allotment_id` FOREIGN KEY (`allotment_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`allotment`(`allotment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= reservation --> loyalty (1 constraint(s)) =========
-- Requires: reservation schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= reservation --> property (19 constraint(s)) =========
-- Requires: reservation schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ADD CONSTRAINT `fk_reservation_cancellation_policy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ADD CONSTRAINT `fk_reservation_cancellation_policy_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= reservation --> revenue (6 constraint(s)) =========
-- Requires: reservation schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_negotiated_rate_id` FOREIGN KEY (`negotiated_rate_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate`(`negotiated_rate_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= revenue --> channel (8 constraint(s)) =========
-- Requires: revenue schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= revenue --> event (3 constraint(s)) =========
-- Requires: revenue schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);

-- ========= revenue --> fnb (8 constraint(s)) =========
-- Requires: revenue schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);

-- ========= revenue --> guest (2 constraint(s)) =========
-- Requires: revenue schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= revenue --> inventory (12 constraint(s)) =========
-- Requires: revenue schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_allotment_id` FOREIGN KEY (`allotment_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`allotment`(`allotment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_allotment_id` FOREIGN KEY (`allotment_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`allotment`(`allotment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_allotment_id` FOREIGN KEY (`allotment_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`allotment`(`allotment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= revenue --> loyalty (7 constraint(s)) =========
-- Requires: revenue schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);

-- ========= revenue --> property (12 constraint(s)) =========
-- Requires: revenue schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= revenue --> reservation (3 constraint(s)) =========
-- Requires: revenue schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_group_block_id` FOREIGN KEY (`group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`group_block`(`group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

