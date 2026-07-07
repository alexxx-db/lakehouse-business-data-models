-- Cross-Domain Foreign Keys for Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:19
-- Total cross-domain FK constraints: 394
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: channel, event, fnb, guest, housekeeping, inventory, loyalty, property, reservation, revenue, spa

-- ========= channel --> event (2 constraint(s)) =========
-- Requires: channel schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= channel --> fnb (1 constraint(s)) =========
-- Requires: channel schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);

-- ========= channel --> guest (2 constraint(s)) =========
-- Requires: channel schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= channel --> inventory (4 constraint(s)) =========
-- Requires: channel schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);

-- ========= channel --> loyalty (1 constraint(s)) =========
-- Requires: channel schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= channel --> property (7 constraint(s)) =========
-- Requires: channel schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= channel --> reservation (2 constraint(s)) =========
-- Requires: channel schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= channel --> revenue (5 constraint(s)) =========
-- Requires: channel schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_rate_restriction_id` FOREIGN KEY (`rate_restriction_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction`(`rate_restriction_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= channel --> spa (1 constraint(s)) =========
-- Requires: channel schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);

-- ========= event --> channel (2 constraint(s)) =========
-- Requires: event schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= event --> fnb (3 constraint(s)) =========
-- Requires: event schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);

-- ========= event --> guest (4 constraint(s)) =========
-- Requires: event schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= event --> inventory (1 constraint(s)) =========
-- Requires: event schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);

-- ========= event --> loyalty (6 constraint(s)) =========
-- Requires: event schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= event --> property (15 constraint(s)) =========
-- Requires: event schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);

-- ========= event --> reservation (3 constraint(s)) =========
-- Requires: event schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

-- ========= event --> revenue (6 constraint(s)) =========
-- Requires: event schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_negotiated_rate_id` FOREIGN KEY (`negotiated_rate_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate`(`negotiated_rate_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= event --> spa (3 constraint(s)) =========
-- Requires: event schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);

-- ========= fnb --> event (3 constraint(s)) =========
-- Requires: fnb schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);

-- ========= fnb --> guest (3 constraint(s)) =========
-- Requires: fnb schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= fnb --> inventory (3 constraint(s)) =========
-- Requires: fnb schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_room_amenity_id` FOREIGN KEY (`room_amenity_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_amenity`(`room_amenity_id`);

-- ========= fnb --> loyalty (3 constraint(s)) =========
-- Requires: fnb schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= fnb --> property (8 constraint(s)) =========
-- Requires: fnb schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= fnb --> reservation (1 constraint(s)) =========
-- Requires: fnb schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= fnb --> spa (1 constraint(s)) =========
-- Requires: fnb schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);

-- ========= guest --> channel (1 constraint(s)) =========
-- Requires: guest schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= guest --> event (2 constraint(s)) =========
-- Requires: guest schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= guest --> inventory (4 constraint(s)) =========
-- Requires: guest schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= guest --> loyalty (3 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= guest --> property (10 constraint(s)) =========
-- Requires: guest schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= guest --> reservation (4 constraint(s)) =========
-- Requires: guest schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= guest --> spa (1 constraint(s)) =========
-- Requires: guest schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);

-- ========= housekeeping --> event (5 constraint(s)) =========
-- Requires: housekeeping schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= housekeeping --> fnb (3 constraint(s)) =========
-- Requires: housekeeping schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= housekeeping --> guest (6 constraint(s)) =========
-- Requires: housekeeping schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`preference`(`preference_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= housekeeping --> inventory (8 constraint(s)) =========
-- Requires: housekeeping schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_room_amenity_id` FOREIGN KEY (`room_amenity_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_room_amenity_id` FOREIGN KEY (`room_amenity_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= housekeeping --> loyalty (2 constraint(s)) =========
-- Requires: housekeeping schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_benefit_entitlement_id` FOREIGN KEY (`benefit_entitlement_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement`(`benefit_entitlement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_benefit_entitlement_id` FOREIGN KEY (`benefit_entitlement_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement`(`benefit_entitlement_id`);

-- ========= housekeeping --> property (19 constraint(s)) =========
-- Requires: housekeeping schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= housekeeping --> reservation (9 constraint(s)) =========
-- Requires: housekeeping schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_special_request_id` FOREIGN KEY (`special_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`special_request`(`special_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_special_request_id` FOREIGN KEY (`special_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`special_request`(`special_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= housekeeping --> revenue (1 constraint(s)) =========
-- Requires: housekeeping schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`budget`(`budget_id`);

-- ========= housekeeping --> spa (7 constraint(s)) =========
-- Requires: housekeeping schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);

-- ========= inventory --> channel (3 constraint(s)) =========
-- Requires: inventory schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= inventory --> event (3 constraint(s)) =========
-- Requires: inventory schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_contract_id` FOREIGN KEY (`event_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_contract`(`event_contract_id`);

-- ========= inventory --> guest (2 constraint(s)) =========
-- Requires: inventory schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= inventory --> housekeeping (3 constraint(s)) =========
-- Requires: inventory schema, housekeeping schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`inspection`(`inspection_id`);

-- ========= inventory --> loyalty (5 constraint(s)) =========
-- Requires: inventory schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);

-- ========= inventory --> property (10 constraint(s)) =========
-- Requires: inventory schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= inventory --> reservation (1 constraint(s)) =========
-- Requires: inventory schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= inventory --> revenue (8 constraint(s)) =========
-- Requires: inventory schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`budget`(`budget_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= loyalty --> channel (8 constraint(s)) =========
-- Requires: loyalty schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);

-- ========= loyalty --> event (5 constraint(s)) =========
-- Requires: loyalty schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_catering_menu_id` FOREIGN KEY (`catering_menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`catering_menu`(`catering_menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= loyalty --> fnb (3 constraint(s)) =========
-- Requires: loyalty schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu_item`(`menu_item_id`);

-- ========= loyalty --> guest (4 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);

-- ========= loyalty --> property (13 constraint(s)) =========
-- Requires: loyalty schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);

-- ========= loyalty --> revenue (1 constraint(s)) =========
-- Requires: loyalty schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= loyalty --> spa (6 constraint(s)) =========
-- Requires: loyalty schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);

-- ========= property --> channel (3 constraint(s)) =========
-- Requires: property schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_gds_connection_id` FOREIGN KEY (`gds_connection_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`gds_connection`(`gds_connection_id`);

-- ========= property --> fnb (1 constraint(s)) =========
-- Requires: property schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= reservation --> channel (7 constraint(s)) =========
-- Requires: reservation schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= reservation --> event (2 constraint(s)) =========
-- Requires: reservation schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= reservation --> fnb (2 constraint(s)) =========
-- Requires: reservation schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= reservation --> guest (8 constraint(s)) =========
-- Requires: reservation schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= reservation --> inventory (4 constraint(s)) =========
-- Requires: reservation schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= reservation --> loyalty (5 constraint(s)) =========
-- Requires: reservation schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ADD CONSTRAINT `fk_reservation_cancellation_policy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_benefit_entitlement_id` FOREIGN KEY (`benefit_entitlement_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement`(`benefit_entitlement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= reservation --> property (9 constraint(s)) =========
-- Requires: reservation schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ADD CONSTRAINT `fk_reservation_cancellation_policy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= reservation --> revenue (5 constraint(s)) =========
-- Requires: reservation schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_negotiated_rate_id` FOREIGN KEY (`negotiated_rate_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate`(`negotiated_rate_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block` ADD CONSTRAINT `fk_reservation_group_block_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= revenue --> channel (5 constraint(s)) =========
-- Requires: revenue schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= revenue --> event (3 constraint(s)) =========
-- Requires: revenue schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);

-- ========= revenue --> fnb (6 constraint(s)) =========
-- Requires: revenue schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);

-- ========= revenue --> guest (2 constraint(s)) =========
-- Requires: revenue schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= revenue --> inventory (6 constraint(s)) =========
-- Requires: revenue schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= revenue --> loyalty (10 constraint(s)) =========
-- Requires: revenue schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);

-- ========= revenue --> property (23 constraint(s)) =========
-- Requires: revenue schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_gds_profile_id` FOREIGN KEY (`gds_profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`gds_profile`(`gds_profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_gds_profile_id` FOREIGN KEY (`gds_profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`gds_profile`(`gds_profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_gds_profile_id` FOREIGN KEY (`gds_profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`gds_profile`(`gds_profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= revenue --> reservation (3 constraint(s)) =========
-- Requires: revenue schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_group_block_id` FOREIGN KEY (`group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`group_block`(`group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

-- ========= revenue --> spa (1 constraint(s)) =========
-- Requires: revenue schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_treatment_menu_id` FOREIGN KEY (`treatment_menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_menu`(`treatment_menu_id`);

-- ========= spa --> channel (1 constraint(s)) =========
-- Requires: spa schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= spa --> event (1 constraint(s)) =========
-- Requires: spa schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= spa --> fnb (2 constraint(s)) =========
-- Requires: spa schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);

-- ========= spa --> guest (6 constraint(s)) =========
-- Requires: spa schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= spa --> inventory (3 constraint(s)) =========
-- Requires: spa schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= spa --> loyalty (7 constraint(s)) =========
-- Requires: spa schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);

-- ========= spa --> property (12 constraint(s)) =========
-- Requires: spa schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= spa --> reservation (4 constraint(s)) =========
-- Requires: spa schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_group_block_id` FOREIGN KEY (`group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`group_block`(`group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= spa --> revenue (3 constraint(s)) =========
-- Requires: spa schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

