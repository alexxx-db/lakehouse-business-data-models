-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:46
-- Total cross-domain FK constraints: 723
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: finance, foodsafety, franchise, guest, inventory, loyalty, marketing, menu, order, procurement, realestate, restaurant, supply, workforce

-- ========= finance --> franchise (8 constraint(s)) =========
-- Requires: finance schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= finance --> guest (4 constraint(s)) =========
-- Requires: finance schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_ar_profile_id` FOREIGN KEY (`ar_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= finance --> inventory (1 constraint(s)) =========
-- Requires: finance schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= finance --> marketing (3 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= finance --> procurement (12 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_vendor_procurement_supplier_id` FOREIGN KEY (`journal_vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ap_vendor_procurement_supplier_id` FOREIGN KEY (`ap_vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_tax_vendor_procurement_supplier_id` FOREIGN KEY (`tax_vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= finance --> realestate (2 constraint(s)) =========
-- Requires: finance schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`lease`(`lease_id`);

-- ========= finance --> restaurant (22 constraint(s)) =========
-- Requires: finance schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ap_unit_id` FOREIGN KEY (`ap_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_ap_unit_id` FOREIGN KEY (`ap_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_ar_unit_id` FOREIGN KEY (`ar_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_unit_id` FOREIGN KEY (`budget_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_unit_id` FOREIGN KEY (`budget_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_tax_unit_id` FOREIGN KEY (`tax_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_capex_unit_id` FOREIGN KEY (`capex_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`lease_liability` ADD CONSTRAINT `fk_finance_lease_liability_lease_unit_id` FOREIGN KEY (`lease_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ADD CONSTRAINT `fk_finance_pos_settlement_batch_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`pos_settlement_batch` ADD CONSTRAINT `fk_finance_pos_settlement_batch_pos_unit_id` FOREIGN KEY (`pos_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= finance --> supply (2 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);

-- ========= finance --> workforce (19 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_approver_user_employee_id` FOREIGN KEY (`approver_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_journal_employee_id` FOREIGN KEY (`journal_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_journal_last_modified_user_employee_id` FOREIGN KEY (`journal_last_modified_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ap_employee_id` FOREIGN KEY (`ap_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ap_modified_by_user_employee_id` FOREIGN KEY (`ap_modified_by_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_period_sign_off_user_employee_id` FOREIGN KEY (`period_sign_off_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= foodsafety --> finance (9 constraint(s)) =========
-- Requires: foodsafety schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ADD CONSTRAINT `fk_foodsafety_recall_unit_response_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ADD CONSTRAINT `fk_foodsafety_pest_control_log_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ADD CONSTRAINT `fk_foodsafety_receiving_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ADD CONSTRAINT `fk_foodsafety_food_safety_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= foodsafety --> guest (1 constraint(s)) =========
-- Requires: foodsafety schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= foodsafety --> inventory (10 constraint(s)) =========
-- Requires: foodsafety schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_lot_tracking_id` FOREIGN KEY (`lot_tracking_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`lot_tracking`(`lot_tracking_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ADD CONSTRAINT `fk_foodsafety_food_recall_lot_tracking_id` FOREIGN KEY (`lot_tracking_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`lot_tracking`(`lot_tracking_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ADD CONSTRAINT `fk_foodsafety_recall_unit_response_lot_tracking_id` FOREIGN KEY (`lot_tracking_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`lot_tracking`(`lot_tracking_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ADD CONSTRAINT `fk_foodsafety_pest_control_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ADD CONSTRAINT `fk_foodsafety_receiving_inspection_receiving_order_id` FOREIGN KEY (`receiving_order_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`receiving_order`(`receiving_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ADD CONSTRAINT `fk_foodsafety_environmental_monitoring_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= foodsafety --> loyalty (1 constraint(s)) =========
-- Requires: foodsafety schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);

-- ========= foodsafety --> menu (1 constraint(s)) =========
-- Requires: foodsafety schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= foodsafety --> order (1 constraint(s)) =========
-- Requires: foodsafety schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);

-- ========= foodsafety --> procurement (9 constraint(s)) =========
-- Requires: foodsafety schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ADD CONSTRAINT `fk_foodsafety_food_recall_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ADD CONSTRAINT `fk_foodsafety_food_recall_primary_food_procurement_supplier_id` FOREIGN KEY (`primary_food_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ADD CONSTRAINT `fk_foodsafety_pest_control_log_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ADD CONSTRAINT `fk_foodsafety_pest_control_log_pest_service_provider_procurement_supplier_id` FOREIGN KEY (`pest_service_provider_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ADD CONSTRAINT `fk_foodsafety_receiving_inspection_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= foodsafety --> realestate (6 constraint(s)) =========
-- Requires: foodsafety schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ADD CONSTRAINT `fk_foodsafety_recall_unit_response_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ADD CONSTRAINT `fk_foodsafety_pest_control_log_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);

-- ========= foodsafety --> restaurant (21 constraint(s)) =========
-- Requires: foodsafety schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_food_unit_id` FOREIGN KEY (`food_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_audit_unit_id` FOREIGN KEY (`audit_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_temperature_equipment_equipment_asset_id` FOREIGN KEY (`temperature_equipment_equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_sanitation_equipment_equipment_asset_id` FOREIGN KEY (`sanitation_equipment_equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_sanitation_unit_id` FOREIGN KEY (`sanitation_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_allergen_unit_id` FOREIGN KEY (`allergen_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ADD CONSTRAINT `fk_foodsafety_sop_document_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ADD CONSTRAINT `fk_foodsafety_recall_unit_response_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ADD CONSTRAINT `fk_foodsafety_pest_control_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ADD CONSTRAINT `fk_foodsafety_pest_control_log_pest_unit_id` FOREIGN KEY (`pest_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ADD CONSTRAINT `fk_foodsafety_food_safety_training_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ADD CONSTRAINT `fk_foodsafety_environmental_monitoring_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= foodsafety --> supply (5 constraint(s)) =========
-- Requires: foodsafety schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_supply_supplier_id` FOREIGN KEY (`supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ADD CONSTRAINT `fk_foodsafety_foodsafety_allergen_profile_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ADD CONSTRAINT `fk_foodsafety_foodsafety_supplier_certification_foodsafety_supply_supplier_id` FOREIGN KEY (`foodsafety_supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ADD CONSTRAINT `fk_foodsafety_foodsafety_supplier_certification_supply_supplier_id` FOREIGN KEY (`supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);

-- ========= foodsafety --> workforce (29 constraint(s)) =========
-- Requires: foodsafety schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_food_employee_id` FOREIGN KEY (`food_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_audit_responsible_party_employee_id` FOREIGN KEY (`audit_responsible_party_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_foodsafety_verified_by_employee_id` FOREIGN KEY (`foodsafety_verified_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_primary_foodsafety_employee_id` FOREIGN KEY (`primary_foodsafety_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_temperature_recorded_by_user_employee_id` FOREIGN KEY (`temperature_recorded_by_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ADD CONSTRAINT `fk_foodsafety_recall_unit_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ADD CONSTRAINT `fk_foodsafety_recall_unit_response_recall_manager_employee_id` FOREIGN KEY (`recall_manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ADD CONSTRAINT `fk_foodsafety_foodsafety_supplier_certification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ADD CONSTRAINT `fk_foodsafety_receiving_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ADD CONSTRAINT `fk_foodsafety_receiving_inspection_receiving_employee_id` FOREIGN KEY (`receiving_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ADD CONSTRAINT `fk_foodsafety_food_safety_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ADD CONSTRAINT `fk_foodsafety_food_safety_training_primary_food_employee_id` FOREIGN KEY (`primary_food_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= franchise --> finance (3 constraint(s)) =========
-- Requires: franchise schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_agreement_legal_entity_id` FOREIGN KEY (`agreement_legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= franchise --> foodsafety (1 constraint(s)) =========
-- Requires: franchise schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ADD CONSTRAINT `fk_franchise_franchise_corrective_action_foodsafety_corrective_action_id` FOREIGN KEY (`foodsafety_corrective_action_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action`(`foodsafety_corrective_action_id`);

-- ========= franchise --> loyalty (1 constraint(s)) =========
-- Requires: franchise schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);

-- ========= franchise --> realestate (3 constraint(s)) =========
-- Requires: franchise schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ADD CONSTRAINT `fk_franchise_franchise_remodel_project_remodel_project_id` FOREIGN KEY (`remodel_project_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`remodel_project`(`remodel_project_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ADD CONSTRAINT `fk_franchise_lease_agreement_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ADD CONSTRAINT `fk_franchise_lease_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);

-- ========= franchise --> restaurant (7 constraint(s)) =========
-- Requires: franchise schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_sales_unit_id` FOREIGN KEY (`sales_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ADD CONSTRAINT `fk_franchise_franchise_remodel_project_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ADD CONSTRAINT `fk_franchise_support_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ADD CONSTRAINT `fk_franchise_support_visit_support_unit_id` FOREIGN KEY (`support_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ADD CONSTRAINT `fk_franchise_lease_agreement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= franchise --> supply (2 constraint(s)) =========
-- Requires: franchise schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ADD CONSTRAINT `fk_franchise_territory_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);

-- ========= franchise --> workforce (13 constraint(s)) =========
-- Requires: franchise schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_nro_employee_id` FOREIGN KEY (`nro_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_compliance_employee_id` FOREIGN KEY (`compliance_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_training_employee_id` FOREIGN KEY (`training_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_training_trainer_employee_id` FOREIGN KEY (`training_trainer_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ADD CONSTRAINT `fk_franchise_transfer_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ADD CONSTRAINT `fk_franchise_transfer_event_transfer_employee_id` FOREIGN KEY (`transfer_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ADD CONSTRAINT `fk_franchise_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ADD CONSTRAINT `fk_franchise_support_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ADD CONSTRAINT `fk_franchise_support_visit_support_employee_id` FOREIGN KEY (`support_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= guest --> finance (1 constraint(s)) =========
-- Requires: guest schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= guest --> foodsafety (1 constraint(s)) =========
-- Requires: guest schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ADD CONSTRAINT `fk_guest_guest_allergen_profile_foodsafety_allergen_profile_id` FOREIGN KEY (`foodsafety_allergen_profile_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile`(`foodsafety_allergen_profile_id`);

-- ========= guest --> franchise (3 constraint(s)) =========
-- Requires: guest schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= guest --> loyalty (5 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ADD CONSTRAINT `fk_guest_identity_resolution_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` ADD CONSTRAINT `fk_guest_guest_segment_loyalty_segment_id` FOREIGN KEY (`loyalty_segment_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`loyalty_segment`(`loyalty_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);

-- ========= guest --> marketing (3 constraint(s)) =========
-- Requires: guest schema, marketing schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ADD CONSTRAINT `fk_guest_communication_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ADD CONSTRAINT `fk_guest_communication_content_template_id` FOREIGN KEY (`content_template_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`content_template`(`content_template_id`);

-- ========= guest --> menu (2 constraint(s)) =========
-- Requires: guest schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= guest --> order (2 constraint(s)) =========
-- Requires: guest schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);

-- ========= guest --> procurement (1 constraint(s)) =========
-- Requires: guest schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= guest --> restaurant (10 constraint(s)) =========
-- Requires: guest schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_location_profile_id` FOREIGN KEY (`location_profile_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`location_profile`(`location_profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_profile_unit_id` FOREIGN KEY (`profile_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ADD CONSTRAINT `fk_guest_survey_response_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ADD CONSTRAINT `fk_guest_communication_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_guest_unit_id` FOREIGN KEY (`guest_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= guest --> supply (2 constraint(s)) =========
-- Requires: guest schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ADD CONSTRAINT `fk_guest_guest_allergen_profile_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);

-- ========= guest --> workforce (6 constraint(s)) =========
-- Requires: guest schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_host_employee_id` FOREIGN KEY (`host_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> finance (12 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= inventory --> foodsafety (1 constraint(s)) =========
-- Requires: inventory schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_foodsafety_corrective_action_id` FOREIGN KEY (`foodsafety_corrective_action_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action`(`foodsafety_corrective_action_id`);

-- ========= inventory --> franchise (8 constraint(s)) =========
-- Requires: inventory schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ADD CONSTRAINT `fk_inventory_yield_record_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ADD CONSTRAINT `fk_inventory_inventory_ingredient_usage_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= inventory --> marketing (1 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= inventory --> menu (4 constraint(s)) =========
-- Requires: inventory schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ADD CONSTRAINT `fk_inventory_yield_record_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);

-- ========= inventory --> order (1 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ADD CONSTRAINT `fk_inventory_inventory_ingredient_usage_order_ingredient_usage_id` FOREIGN KEY (`order_ingredient_usage_id`) REFERENCES `vibe_restaurants_v1`.`order`.`order_ingredient_usage`(`order_ingredient_usage_id`);

-- ========= inventory --> procurement (12 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_item_specification_id` FOREIGN KEY (`item_specification_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`item_specification`(`item_specification_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_stock_procurement_supplier_id` FOREIGN KEY (`stock_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_waste_vendor_procurement_supplier_id` FOREIGN KEY (`waste_vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_primary_vendor_procurement_supplier_id` FOREIGN KEY (`primary_vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= inventory --> realestate (8 constraint(s)) =========
-- Requires: inventory schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);

-- ========= inventory --> restaurant (20 constraint(s)) =========
-- Requires: inventory schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_stock_equipment_equipment_asset_id` FOREIGN KEY (`stock_equipment_equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_on_unit_id` FOREIGN KEY (`on_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_receiving_unit_id` FOREIGN KEY (`receiving_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_physical_unit_id` FOREIGN KEY (`physical_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_waste_unit_id` FOREIGN KEY (`waste_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_restaurant_unit_id` FOREIGN KEY (`origin_restaurant_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ADD CONSTRAINT `fk_inventory_yield_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ADD CONSTRAINT `fk_inventory_inventory_ingredient_usage_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= inventory --> supply (5 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ADD CONSTRAINT `fk_inventory_inventory_ingredient_usage_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);

-- ========= inventory --> workforce (23 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_receiving_manager_employee_id` FOREIGN KEY (`receiving_manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_tertiary_stock_received_by_employee_id` FOREIGN KEY (`tertiary_stock_received_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_receiving_employee_id` FOREIGN KEY (`receiving_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_receiving_user_employee_id` FOREIGN KEY (`receiving_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_replenishment_cancelled_by_user_employee_id` FOREIGN KEY (`replenishment_cancelled_by_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_replenishment_created_by_user_employee_id` FOREIGN KEY (`replenishment_created_by_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_replenishment_employee_id` FOREIGN KEY (`replenishment_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_tertiary_replenishment_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_replenishment_cancelled_by_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ADD CONSTRAINT `fk_inventory_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_primary_inventory_adjusted_by_employee_id` FOREIGN KEY (`primary_inventory_adjusted_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_food_employee_id` FOREIGN KEY (`food_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_primary_food_employee_id` FOREIGN KEY (`primary_food_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= loyalty --> finance (3 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= loyalty --> franchise (6 constraint(s)) =========
-- Requires: loyalty schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_points_franchisee_id` FOREIGN KEY (`points_franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ADD CONSTRAINT `fk_loyalty_challenge_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= loyalty --> guest (6 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_profile_id` FOREIGN KEY (`member_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ADD CONSTRAINT `fk_loyalty_referral_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ADD CONSTRAINT `fk_loyalty_referral_referral_referred_guest_profile_id` FOREIGN KEY (`referral_referred_guest_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ADD CONSTRAINT `fk_loyalty_loyalty_segment_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ADD CONSTRAINT `fk_loyalty_loyalty_visit_guest_visit_id` FOREIGN KEY (`guest_visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`guest_visit`(`guest_visit_id`);

-- ========= loyalty --> marketing (13 constraint(s)) =========
-- Requires: loyalty schema, marketing schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ADD CONSTRAINT `fk_loyalty_challenge_enrollment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ADD CONSTRAINT `fk_loyalty_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ADD CONSTRAINT `fk_loyalty_program_campaign_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= loyalty --> menu (2 constraint(s)) =========
-- Requires: loyalty schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= loyalty --> order (7 constraint(s)) =========
-- Requires: loyalty schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_source_transaction_guest_order_id` FOREIGN KEY (`source_transaction_guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ADD CONSTRAINT `fk_loyalty_loyalty_visit_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);

-- ========= loyalty --> realestate (2 constraint(s)) =========
-- Requires: loyalty schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ADD CONSTRAINT `fk_loyalty_challenge_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);

-- ========= loyalty --> restaurant (17 constraint(s)) =========
-- Requires: loyalty schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_unit_id` FOREIGN KEY (`member_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_primary_member_preferred_location_unit_id` FOREIGN KEY (`primary_member_preferred_location_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_points_unit_id` FOREIGN KEY (`points_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_redemption_unit_id` FOREIGN KEY (`redemption_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ADD CONSTRAINT `fk_loyalty_challenge_enrollment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ADD CONSTRAINT `fk_loyalty_challenge_enrollment_challenge_unit_id` FOREIGN KEY (`challenge_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ADD CONSTRAINT `fk_loyalty_referral_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ADD CONSTRAINT `fk_loyalty_referral_referral_unit_id` FOREIGN KEY (`referral_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ADD CONSTRAINT `fk_loyalty_loyalty_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= loyalty --> workforce (9 constraint(s)) =========
-- Requires: loyalty schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_points_employee_id` FOREIGN KEY (`points_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ADD CONSTRAINT `fk_loyalty_loyalty_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ADD CONSTRAINT `fk_loyalty_loyalty_segment_owner_user_employee_id` FOREIGN KEY (`owner_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> finance (1 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ADD CONSTRAINT `fk_marketing_fund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= marketing --> foodsafety (2 constraint(s)) =========
-- Requires: marketing schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_food_recall_id` FOREIGN KEY (`food_recall_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_recall`(`food_recall_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);

-- ========= marketing --> franchise (5 constraint(s)) =========
-- Requires: marketing schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ADD CONSTRAINT `fk_marketing_fund_contribution_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= marketing --> guest (2 constraint(s)) =========
-- Requires: marketing schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= marketing --> inventory (1 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_item_category_id` FOREIGN KEY (`item_category_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`item_category`(`item_category_id`);

-- ========= marketing --> loyalty (1 constraint(s)) =========
-- Requires: marketing schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);

-- ========= marketing --> menu (1 constraint(s)) =========
-- Requires: marketing schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= marketing --> procurement (5 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_media_vendor_procurement_supplier_id` FOREIGN KEY (`media_vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ADD CONSTRAINT `fk_marketing_local_store_marketing_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_campaign_vendor_procurement_supplier_id` FOREIGN KEY (`campaign_vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= marketing --> realestate (2 constraint(s)) =========
-- Requires: marketing schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_trade_area_id` FOREIGN KEY (`trade_area_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`trade_area`(`trade_area_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);

-- ========= marketing --> restaurant (7 constraint(s)) =========
-- Requires: marketing schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ADD CONSTRAINT `fk_marketing_local_store_marketing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ADD CONSTRAINT `fk_marketing_local_store_marketing_local_unit_id` FOREIGN KEY (`local_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ADD CONSTRAINT `fk_marketing_fund_contribution_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ADD CONSTRAINT `fk_marketing_fund_contribution_fund_unit_id` FOREIGN KEY (`fund_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= marketing --> supply (3 constraint(s)) =========
-- Requires: marketing schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_supply_supplier_id` FOREIGN KEY (`supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_supply_supplier_id` FOREIGN KEY (`supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);

-- ========= marketing --> workforce (3 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= menu --> finance (3 constraint(s)) =========
-- Requires: menu schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= menu --> foodsafety (5 constraint(s)) =========
-- Requires: menu schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_foodsafety_allergen_profile_id` FOREIGN KEY (`foodsafety_allergen_profile_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile`(`foodsafety_allergen_profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_foodsafety_allergen_profile_id` FOREIGN KEY (`foodsafety_allergen_profile_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile`(`foodsafety_allergen_profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= menu --> franchise (4 constraint(s)) =========
-- Requires: menu schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= menu --> inventory (1 constraint(s)) =========
-- Requires: menu schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_item_category_id` FOREIGN KEY (`item_category_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`item_category`(`item_category_id`);

-- ========= menu --> marketing (3 constraint(s)) =========
-- Requires: menu schema, marketing schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= menu --> procurement (2 constraint(s)) =========
-- Requires: menu schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= menu --> realestate (4 constraint(s)) =========
-- Requires: menu schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);

-- ========= menu --> restaurant (7 constraint(s)) =========
-- Requires: menu schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_item_equipment_equipment_asset_id` FOREIGN KEY (`item_equipment_equipment_asset_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= menu --> supply (3 constraint(s)) =========
-- Requires: menu schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_primary_recipe_substitute_ingredient_id` FOREIGN KEY (`primary_recipe_substitute_ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);

-- ========= menu --> workforce (12 constraint(s)) =========
-- Requires: menu schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_item_employee_id` FOREIGN KEY (`item_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ADD CONSTRAINT `fk_menu_nutrition_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ADD CONSTRAINT `fk_menu_engineering_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ADD CONSTRAINT `fk_menu_engineering_review_engineering_employee_id` FOREIGN KEY (`engineering_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ADD CONSTRAINT `fk_menu_engineering_review_primary_engineering_employee_id` FOREIGN KEY (`primary_engineering_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= order --> finance (6 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= order --> foodsafety (1 constraint(s)) =========
-- Requires: order schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_illness_report_id` FOREIGN KEY (`illness_report_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`illness_report`(`illness_report_id`);

-- ========= order --> franchise (1 constraint(s)) =========
-- Requires: order schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= order --> guest (8 constraint(s)) =========
-- Requires: order schema, guest schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_primary_guest_profile_id` FOREIGN KEY (`primary_guest_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_catering_profile_id` FOREIGN KEY (`catering_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= order --> inventory (1 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ADD CONSTRAINT `fk_order_order_ingredient_usage_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= order --> loyalty (3 constraint(s)) =========
-- Requires: order schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);

-- ========= order --> marketing (7 constraint(s)) =========
-- Requires: order schema, marketing schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`coupon`(`coupon_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_local_store_marketing_id` FOREIGN KEY (`local_store_marketing_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`local_store_marketing`(`local_store_marketing_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_marketing_guest_segment_id` FOREIGN KEY (`marketing_guest_segment_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment`(`marketing_guest_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`promotion`(`promotion_id`);

-- ========= order --> menu (9 constraint(s)) =========
-- Requires: order schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu`(`menu_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_lto_id` FOREIGN KEY (`menu_lto_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_lto`(`menu_lto_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_modifier_id` FOREIGN KEY (`menu_modifier_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_modifier_group_id` FOREIGN KEY (`modifier_group_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`modifier_group`(`modifier_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_menu_modifier_id` FOREIGN KEY (`menu_modifier_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_primary_order_menu_modifier_id` FOREIGN KEY (`primary_order_menu_modifier_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= order --> realestate (10 constraint(s)) =========
-- Requires: order schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ADD CONSTRAINT `fk_order_drive_thru_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ADD CONSTRAINT `fk_order_sos_target_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);

-- ========= order --> restaurant (21 constraint(s)) =========
-- Requires: order schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`channel` ADD CONSTRAINT `fk_order_channel_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`daypart` ADD CONSTRAINT `fk_order_daypart_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ADD CONSTRAINT `fk_order_drive_thru_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ADD CONSTRAINT `fk_order_drive_thru_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ADD CONSTRAINT `fk_order_sos_target_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`sos_target` ADD CONSTRAINT `fk_order_sos_target_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= order --> supply (3 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_ingredient_usage` ADD CONSTRAINT `fk_order_order_ingredient_usage_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);

-- ========= order --> workforce (14 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`kds_ticket` ADD CONSTRAINT `fk_order_kds_ticket_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`drive_thru_event` ADD CONSTRAINT `fk_order_drive_thru_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_primary_refund_employee_id` FOREIGN KEY (`primary_refund_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_tertiary_refund_voided_by_employee_id` FOREIGN KEY (`tertiary_refund_voided_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> finance (4 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`budget_line`(`budget_line_id`);

-- ========= procurement --> franchise (3 constraint(s)) =========
-- Requires: procurement schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= procurement --> inventory (3 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= procurement --> restaurant (7 constraint(s)) =========
-- Requires: procurement schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_requisition_unit_id` FOREIGN KEY (`requisition_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_procurement_unit_id` FOREIGN KEY (`procurement_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= procurement --> supply (1 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ADD CONSTRAINT `fk_procurement_supply_agreement_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);

-- ========= procurement --> workforce (14 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_sourcing_stakeholder_employee_id` FOREIGN KEY (`sourcing_stakeholder_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_created_by_employee_id` FOREIGN KEY (`created_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_primary_requisition_approved_by_employee_id` FOREIGN KEY (`primary_requisition_approved_by_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_tertiary_requisition_employee_id` FOREIGN KEY (`tertiary_requisition_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= realestate --> finance (10 constraint(s)) =========
-- Requires: realestate schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ADD CONSTRAINT `fk_realestate_lease_amendment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ADD CONSTRAINT `fk_realestate_property_acquisition_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ADD CONSTRAINT `fk_realestate_property_acquisition_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ADD CONSTRAINT `fk_realestate_property_acquisition_property_legal_entity_id` FOREIGN KEY (`property_legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= realestate --> franchise (5 constraint(s)) =========
-- Requires: realestate schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ADD CONSTRAINT `fk_realestate_lease_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ADD CONSTRAINT `fk_realestate_site_selection_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ADD CONSTRAINT `fk_realestate_site_permit_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= realestate --> menu (1 constraint(s)) =========
-- Requires: realestate schema, menu schema
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ADD CONSTRAINT `fk_realestate_menu_item_site_offering_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= realestate --> procurement (3 constraint(s)) =========
-- Requires: realestate schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ADD CONSTRAINT `fk_realestate_maintenance_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= realestate --> restaurant (3 constraint(s)) =========
-- Requires: realestate schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= realestate --> workforce (3 constraint(s)) =========
-- Requires: realestate schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ADD CONSTRAINT `fk_realestate_site_selection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= restaurant --> finance (5 constraint(s)) =========
-- Requires: restaurant schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ADD CONSTRAINT `fk_restaurant_brand_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`department` ADD CONSTRAINT `fk_restaurant_department_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= restaurant --> foodsafety (1 constraint(s)) =========
-- Requires: restaurant schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_sop_document_id` FOREIGN KEY (`sop_document_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`sop_document`(`sop_document_id`);

-- ========= restaurant --> franchise (5 constraint(s)) =========
-- Requires: restaurant schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ADD CONSTRAINT `fk_restaurant_renovation_project_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_unit_franchisee_id` FOREIGN KEY (`unit_franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`department` ADD CONSTRAINT `fk_restaurant_department_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= restaurant --> loyalty (1 constraint(s)) =========
-- Requires: restaurant schema, loyalty schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);

-- ========= restaurant --> marketing (1 constraint(s)) =========
-- Requires: restaurant schema, marketing schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ADD CONSTRAINT `fk_restaurant_store_campaign_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= restaurant --> order (5 constraint(s)) =========
-- Requires: restaurant schema, order schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ADD CONSTRAINT `fk_restaurant_throughput_benchmark_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ADD CONSTRAINT `fk_restaurant_sos_measurement_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_restaurants_v1`.`order`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ADD CONSTRAINT `fk_restaurant_sos_measurement_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ADD CONSTRAINT `fk_restaurant_sos_measurement_sos_target_id` FOREIGN KEY (`sos_target_id`) REFERENCES `vibe_restaurants_v1`.`order`.`sos_target`(`sos_target_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ADD CONSTRAINT `fk_restaurant_table_turn_log_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `vibe_restaurants_v1`.`order`.`guest_order`(`guest_order_id`);

-- ========= restaurant --> procurement (1 constraint(s)) =========
-- Requires: restaurant schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= restaurant --> realestate (5 constraint(s)) =========
-- Requires: restaurant schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`lease`(`lease_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_trade_area_id` FOREIGN KEY (`trade_area_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`trade_area`(`trade_area_id`);

-- ========= restaurant --> workforce (19 constraint(s)) =========
-- Requires: restaurant schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_scheduling_template_id` FOREIGN KEY (`scheduling_template_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`scheduling_template`(`scheduling_template_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_operating_employee_id` FOREIGN KEY (`operating_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ADD CONSTRAINT `fk_restaurant_table_turn_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ADD CONSTRAINT `fk_restaurant_table_turn_log_table_server_employee_id` FOREIGN KEY (`table_server_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ADD CONSTRAINT `fk_restaurant_unit_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ADD CONSTRAINT `fk_restaurant_unit_status_history_unit_initiated_by_user_employee_id` FOREIGN KEY (`unit_initiated_by_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ADD CONSTRAINT `fk_restaurant_area_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ADD CONSTRAINT `fk_restaurant_area_management_primary_area_manager_employee_id` FOREIGN KEY (`primary_area_manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ADD CONSTRAINT `fk_restaurant_renovation_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ADD CONSTRAINT `fk_restaurant_renovation_project_renovation_employee_id` FOREIGN KEY (`renovation_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ADD CONSTRAINT `fk_restaurant_ops_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ADD CONSTRAINT `fk_restaurant_ops_visit_primary_ops_visitor_employee_id` FOREIGN KEY (`primary_ops_visitor_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ADD CONSTRAINT `fk_restaurant_ops_visit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ADD CONSTRAINT `fk_restaurant_ops_visit_finding_primary_ops_employee_id` FOREIGN KEY (`primary_ops_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_unit_employee_id` FOREIGN KEY (`unit_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_unit_last_modified_by_user_employee_id` FOREIGN KEY (`unit_last_modified_by_user_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> finance (5 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ADD CONSTRAINT `fk_supply_distribution_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= supply --> foodsafety (3 constraint(s)) =========
-- Requires: supply schema, foodsafety schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= supply --> franchise (1 constraint(s)) =========
-- Requires: supply schema, franchise schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ADD CONSTRAINT `fk_supply_supply_purchase_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= supply --> inventory (2 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= supply --> procurement (18 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ADD CONSTRAINT `fk_supply_supply_supplier_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_item_specification_id` FOREIGN KEY (`item_specification_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`item_specification`(`item_specification_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ADD CONSTRAINT `fk_supply_supply_purchase_order_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ADD CONSTRAINT `fk_supply_supplier_performance_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ADD CONSTRAINT `fk_supply_supply_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);

-- ========= supply --> realestate (4 constraint(s)) =========
-- Requires: supply schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ADD CONSTRAINT `fk_supply_supply_purchase_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ADD CONSTRAINT `fk_supply_supply_contract_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);

-- ========= supply --> restaurant (5 constraint(s)) =========
-- Requires: supply schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ADD CONSTRAINT `fk_supply_supply_purchase_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

-- ========= supply --> workforce (4 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> finance (1 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_restaurants_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> realestate (6 constraint(s)) =========
-- Requires: workforce schema, realestate schema
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);

-- ========= workforce --> restaurant (21 constraint(s)) =========
-- Requires: workforce schema, restaurant schema
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_employee_unit_id` FOREIGN KEY (`employee_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_employee_work_location_unit_id` FOREIGN KEY (`employee_work_location_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ADD CONSTRAINT `fk_workforce_labor_violation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ADD CONSTRAINT `fk_workforce_labor_violation_labor_unit_id` FOREIGN KEY (`labor_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_labor_unit_id` FOREIGN KEY (`labor_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ADD CONSTRAINT `fk_workforce_tip_compliance_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ADD CONSTRAINT `fk_workforce_workforce_department_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);

