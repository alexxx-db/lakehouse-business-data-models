-- Cross-Domain Foreign Keys for Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:58
-- Total cross-domain FK constraints: 338
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: foodsafety, guest, inventory, loyalty, menu, order, restaurant, supply, workforce

-- ========= foodsafety --> guest (2 constraint(s)) =========
-- Requires: foodsafety schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);

-- ========= foodsafety --> inventory (4 constraint(s)) =========
-- Requires: foodsafety schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= foodsafety --> loyalty (1 constraint(s)) =========
-- Requires: foodsafety schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);

-- ========= foodsafety --> menu (2 constraint(s)) =========
-- Requires: foodsafety schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= foodsafety --> order (3 constraint(s)) =========
-- Requires: foodsafety schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_item`(`order_item_id`);

-- ========= foodsafety --> restaurant (17 constraint(s)) =========
-- Requires: foodsafety schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= foodsafety --> supply (4 constraint(s)) =========
-- Requires: foodsafety schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);

-- ========= foodsafety --> workforce (16 constraint(s)) =========
-- Requires: foodsafety schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_primary_food_employee_id` FOREIGN KEY (`primary_food_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_corrective_foodsafety_verified_by_employee_id` FOREIGN KEY (`corrective_foodsafety_verified_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_primary_foodsafety_employee_id` FOREIGN KEY (`primary_foodsafety_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);

-- ========= guest --> foodsafety (1 constraint(s)) =========
-- Requires: guest schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_allergen_incident_id` FOREIGN KEY (`allergen_incident_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`allergen_incident`(`allergen_incident_id`);

-- ========= guest --> inventory (1 constraint(s)) =========
-- Requires: guest schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= guest --> loyalty (9 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);

-- ========= guest --> menu (4 constraint(s)) =========
-- Requires: guest schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_allergen_declaration_id` FOREIGN KEY (`allergen_declaration_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`allergen_declaration`(`allergen_declaration_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= guest --> order (4 constraint(s)) =========
-- Requires: guest schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);

-- ========= guest --> restaurant (19 constraint(s)) =========
-- Requires: guest schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_location_profile_id` FOREIGN KEY (`location_profile_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`location_profile`(`location_profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_profile_unit_id` FOREIGN KEY (`profile_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_tertiary_satisfaction_unit_id` FOREIGN KEY (`tertiary_satisfaction_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_complaint_unit_id` FOREIGN KEY (`complaint_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_interaction_unit_id` FOREIGN KEY (`interaction_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= guest --> supply (2 constraint(s)) =========
-- Requires: guest schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);

-- ========= guest --> workforce (8 constraint(s)) =========
-- Requires: guest schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);

-- ========= inventory --> foodsafety (5 constraint(s)) =========
-- Requires: inventory schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= inventory --> menu (1 constraint(s)) =========
-- Requires: inventory schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);

-- ========= inventory --> order (2 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `vibe_restaurants_v1`.`order`.`refund`(`refund_id`);

-- ========= inventory --> restaurant (10 constraint(s)) =========
-- Requires: inventory schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_restaurant_unit_id` FOREIGN KEY (`origin_restaurant_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= inventory --> supply (5 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);

-- ========= inventory --> workforce (11 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_receiving_manager_employee_id` FOREIGN KEY (`receiving_manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_tertiary_stock_received_by_employee_id` FOREIGN KEY (`tertiary_stock_received_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= loyalty --> guest (2 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_profile_id` FOREIGN KEY (`member_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= loyalty --> menu (9 constraint(s)) =========
-- Requires: loyalty schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu`(`menu_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= loyalty --> order (6 constraint(s)) =========
-- Requires: loyalty schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_restaurants_v1`.`order`.`channel`(`channel_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_source_transaction_guest_order_id` FOREIGN KEY (`source_transaction_guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_restaurants_v1`.`order`.`channel`(`channel_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_restaurants_v1`.`order`.`channel`(`channel_id`);

-- ========= loyalty --> restaurant (11 constraint(s)) =========
-- Requires: loyalty schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_unit_id` FOREIGN KEY (`member_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_primary_member_preferred_location_unit_id` FOREIGN KEY (`primary_member_preferred_location_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_redemption_unit_id` FOREIGN KEY (`redemption_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ADD CONSTRAINT `fk_loyalty_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);

-- ========= loyalty --> supply (2 constraint(s)) =========
-- Requires: loyalty schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= loyalty --> workforce (5 constraint(s)) =========
-- Requires: loyalty schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= menu --> foodsafety (5 constraint(s)) =========
-- Requires: menu schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= menu --> inventory (5 constraint(s)) =========
-- Requires: menu schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= menu --> loyalty (1 constraint(s)) =========
-- Requires: menu schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);

-- ========= menu --> order (1 constraint(s)) =========
-- Requires: menu schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_restaurants_v1`.`order`.`channel`(`channel_id`);

-- ========= menu --> restaurant (8 constraint(s)) =========
-- Requires: menu schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_format_config_id` FOREIGN KEY (`format_config_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`format_config`(`format_config_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= menu --> supply (8 constraint(s)) =========
-- Requires: menu schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_contract_price_id` FOREIGN KEY (`contract_price_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`contract_price`(`contract_price_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_recipe_substitute_ingredient_id` FOREIGN KEY (`recipe_substitute_ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_contract_price_id` FOREIGN KEY (`contract_price_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`contract_price`(`contract_price_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);

-- ========= menu --> workforce (12 constraint(s)) =========
-- Requires: menu schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ADD CONSTRAINT `fk_menu_nutrition_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ADD CONSTRAINT `fk_menu_modifier_group_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= order --> foodsafety (1 constraint(s)) =========
-- Requires: order schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_allergen_incident_id` FOREIGN KEY (`allergen_incident_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`allergen_incident`(`allergen_incident_id`);

-- ========= order --> guest (10 constraint(s)) =========
-- Requires: order schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`address`(`address_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`address`(`address_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`address`(`address_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_refund_profile_id` FOREIGN KEY (`refund_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= order --> inventory (4 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);

-- ========= order --> loyalty (7 constraint(s)) =========
-- Requires: order schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ADD CONSTRAINT `fk_order_channel_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);

-- ========= order --> menu (15 constraint(s)) =========
-- Requires: order schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu`(`menu_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_allergen_declaration_id` FOREIGN KEY (`allergen_declaration_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`allergen_declaration`(`allergen_declaration_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_item_cost_id` FOREIGN KEY (`item_cost_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`item_cost`(`item_cost_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_item_price_id` FOREIGN KEY (`item_price_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`item_price`(`item_price_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_modifier_id` FOREIGN KEY (`menu_modifier_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_nutrition_profile_id` FOREIGN KEY (`nutrition_profile_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`nutrition_profile`(`nutrition_profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_modifier_group_id` FOREIGN KEY (`modifier_group_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`modifier_group`(`modifier_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_menu_modifier_id` FOREIGN KEY (`menu_modifier_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_source_modifier_menu_modifier_id` FOREIGN KEY (`source_modifier_menu_modifier_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu`(`menu_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= order --> restaurant (21 constraint(s)) =========
-- Requires: order schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ADD CONSTRAINT `fk_order_channel_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= order --> supply (4 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier_contract`(`supplier_contract_id`);

-- ========= order --> workforce (15 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_primary_refund_employee_id` FOREIGN KEY (`primary_refund_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_tertiary_refund_voided_by_employee_id` FOREIGN KEY (`tertiary_refund_voided_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= restaurant --> workforce (9 constraint(s)) =========
-- Requires: restaurant schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ADD CONSTRAINT `fk_restaurant_format_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> foodsafety (4 constraint(s)) =========
-- Requires: supply schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= supply --> inventory (11 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= supply --> restaurant (7 constraint(s)) =========
-- Requires: supply schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= supply --> workforce (9 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_primary_goods_employee_id` FOREIGN KEY (`primary_goods_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_receiving_user_employee_id` FOREIGN KEY (`receiving_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> foodsafety (1 constraint(s)) =========
-- Requires: workforce schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= workforce --> loyalty (1 constraint(s)) =========
-- Requires: workforce schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);

-- ========= workforce --> menu (1 constraint(s)) =========
-- Requires: workforce schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);

-- ========= workforce --> restaurant (12 constraint(s)) =========
-- Requires: workforce schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_employee_unit_id` FOREIGN KEY (`employee_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_employee_work_location_unit_id` FOREIGN KEY (`employee_work_location_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

