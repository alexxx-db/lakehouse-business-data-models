-- Cross-Domain Foreign Keys for Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:02
-- Total cross-domain FK constraints: 584
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, design, equipment, fabrication, inventory, invoice, order, packaging, process, product, quality, sales, test

-- ========= customer --> fabrication (1 constraint(s)) =========
-- Requires: customer schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);

-- ========= customer --> packaging (2 constraint(s)) =========
-- Requires: customer schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= customer --> product (3 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= customer --> sales (4 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);

-- ========= design --> customer (4 constraint(s)) =========
-- Requires: design schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_nda_agreement_id` FOREIGN KEY (`nda_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`nda_agreement`(`nda_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_nda_agreement_id` FOREIGN KEY (`nda_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`nda_agreement`(`nda_agreement_id`);

-- ========= design --> product (7 constraint(s)) =========
-- Requires: design schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ADD CONSTRAINT `fk_design_ip_core_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);

-- ========= equipment --> design (1 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);

-- ========= equipment --> fabrication (3 constraint(s)) =========
-- Requires: equipment schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);

-- ========= equipment --> inventory (1 constraint(s)) =========
-- Requires: equipment schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= equipment --> product (4 constraint(s)) =========
-- Requires: equipment schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);

-- ========= fabrication --> customer (8 constraint(s)) =========
-- Requires: fabrication schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= fabrication --> design (7 constraint(s)) =========
-- Requires: fabrication schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);

-- ========= fabrication --> equipment (13 constraint(s)) =========
-- Requires: fabrication schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= fabrication --> inventory (3 constraint(s)) =========
-- Requires: fabrication schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= fabrication --> order (1 constraint(s)) =========
-- Requires: fabrication schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);

-- ========= fabrication --> process (6 constraint(s)) =========
-- Requires: fabrication schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`flow`(`flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);

-- ========= fabrication --> product (12 constraint(s)) =========
-- Requires: fabrication schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= fabrication --> quality (4 constraint(s)) =========
-- Requires: fabrication schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= fabrication --> test (2 constraint(s)) =========
-- Requires: fabrication schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);

-- ========= inventory --> customer (8 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= inventory --> design (1 constraint(s)) =========
-- Requires: inventory schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);

-- ========= inventory --> equipment (3 constraint(s)) =========
-- Requires: inventory schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);

-- ========= inventory --> fabrication (4 constraint(s)) =========
-- Requires: inventory schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);

-- ========= inventory --> invoice (1 constraint(s)) =========
-- Requires: inventory schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= inventory --> order (1 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= inventory --> packaging (5 constraint(s)) =========
-- Requires: inventory schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);

-- ========= inventory --> process (2 constraint(s)) =========
-- Requires: inventory schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);

-- ========= inventory --> product (8 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= inventory --> sales (1 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);

-- ========= inventory --> test (4 constraint(s)) =========
-- Requires: inventory schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);

-- ========= invoice --> customer (14 constraint(s)) =========
-- Requires: invoice schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ADD CONSTRAINT `fk_invoice_customer_credit_limit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ADD CONSTRAINT `fk_invoice_customer_credit_limit_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= invoice --> design (1 constraint(s)) =========
-- Requires: invoice schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_ip_core_id` FOREIGN KEY (`ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);

-- ========= invoice --> equipment (4 constraint(s)) =========
-- Requires: invoice schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);

-- ========= invoice --> fabrication (4 constraint(s)) =========
-- Requires: invoice schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_wafer_start_id` FOREIGN KEY (`wafer_start_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer_start`(`wafer_start_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_lot_hold_id` FOREIGN KEY (`lot_hold_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`lot_hold`(`lot_hold_id`);

-- ========= invoice --> order (3 constraint(s)) =========
-- Requires: invoice schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);

-- ========= invoice --> packaging (4 constraint(s)) =========
-- Requires: invoice schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_package_qualification_id` FOREIGN KEY (`package_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_qualification`(`package_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= invoice --> product (2 constraint(s)) =========
-- Requires: invoice schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= invoice --> quality (2 constraint(s)) =========
-- Requires: invoice schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);

-- ========= invoice --> sales (10 constraint(s)) =========
-- Requires: invoice schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= invoice --> test (5 constraint(s)) =========
-- Requires: invoice schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);

-- ========= order --> customer (22 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_shipment_ship_to_address_id` FOREIGN KEY (`shipment_ship_to_address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`credit_profile`(`credit_profile_id`);

-- ========= order --> design (1 constraint(s)) =========
-- Requires: order schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);

-- ========= order --> equipment (4 constraint(s)) =========
-- Requires: order schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);

-- ========= order --> fabrication (2 constraint(s)) =========
-- Requires: order schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= order --> inventory (11 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_origin_storage_location_id` FOREIGN KEY (`origin_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= order --> invoice (2 constraint(s)) =========
-- Requires: order schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= order --> packaging (8 constraint(s)) =========
-- Requires: order schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);

-- ========= order --> product (9 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= order --> quality (10 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_quality_hold_id` FOREIGN KEY (`quality_hold_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_hold`(`quality_hold_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_quality_hold_id` FOREIGN KEY (`quality_hold_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_hold`(`quality_hold_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_failure_analysis_report_id` FOREIGN KEY (`failure_analysis_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_quality_hold_id` FOREIGN KEY (`quality_hold_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_hold`(`quality_hold_id`);

-- ========= order --> sales (6 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= order --> test (2 constraint(s)) =========
-- Requires: order schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);

-- ========= packaging --> customer (5 constraint(s)) =========
-- Requires: packaging schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);

-- ========= packaging --> design (2 constraint(s)) =========
-- Requires: packaging schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);

-- ========= packaging --> equipment (4 constraint(s)) =========
-- Requires: packaging schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);

-- ========= packaging --> fabrication (3 constraint(s)) =========
-- Requires: packaging schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);

-- ========= packaging --> inventory (4 constraint(s)) =========
-- Requires: packaging schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);

-- ========= packaging --> process (2 constraint(s)) =========
-- Requires: packaging schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);

-- ========= packaging --> product (5 constraint(s)) =========
-- Requires: packaging schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= packaging --> quality (4 constraint(s)) =========
-- Requires: packaging schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);

-- ========= packaging --> sales (3 constraint(s)) =========
-- Requires: packaging schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);

-- ========= packaging --> test (3 constraint(s)) =========
-- Requires: packaging schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);

-- ========= process --> customer (5 constraint(s)) =========
-- Requires: process schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= process --> design (2 constraint(s)) =========
-- Requires: process schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= process --> equipment (24 constraint(s)) =========
-- Requires: process schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ADD CONSTRAINT `fk_process_step_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ADD CONSTRAINT `fk_process_step_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_equipment_process_recipe_id` FOREIGN KEY (`equipment_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`(`equipment_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= process --> fabrication (15 constraint(s)) =========
-- Requires: process schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ADD CONSTRAINT `fk_process_step_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_lot_hold_id` FOREIGN KEY (`lot_hold_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`lot_hold`(`lot_hold_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);

-- ========= process --> inventory (2 constraint(s)) =========
-- Requires: process schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= process --> invoice (3 constraint(s)) =========
-- Requires: process schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`dispute`(`dispute_id`);

-- ========= process --> product (10 constraint(s)) =========
-- Requires: process schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= process --> quality (10 constraint(s)) =========
-- Requires: process schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);

-- ========= process --> test (4 constraint(s)) =========
-- Requires: process schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);

-- ========= product --> fabrication (1 constraint(s)) =========
-- Requires: product schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);

-- ========= product --> packaging (10 constraint(s)) =========
-- Requires: product schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);

-- ========= product --> quality (1 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);

-- ========= product --> sales (1 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= quality --> customer (9 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);

-- ========= quality --> design (5 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_ip_core_id` FOREIGN KEY (`ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);

-- ========= quality --> equipment (29 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_equipment_process_recipe_id` FOREIGN KEY (`equipment_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`(`equipment_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);

-- ========= quality --> fabrication (6 constraint(s)) =========
-- Requires: quality schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);

-- ========= quality --> inventory (8 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= quality --> invoice (1 constraint(s)) =========
-- Requires: quality schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= quality --> packaging (7 constraint(s)) =========
-- Requires: quality schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);

-- ========= quality --> process (7 constraint(s)) =========
-- Requires: quality schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);

-- ========= quality --> product (17 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= quality --> sales (3 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);

-- ========= quality --> test (13 constraint(s)) =========
-- Requires: quality schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`limit`(`limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);

-- ========= sales --> customer (16 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_nda_agreement_id` FOREIGN KEY (`nda_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`nda_agreement`(`nda_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);

-- ========= sales --> design (2 constraint(s)) =========
-- Requires: sales schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ip_core_id` FOREIGN KEY (`ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= sales --> equipment (1 constraint(s)) =========
-- Requires: sales schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);

-- ========= sales --> fabrication (7 constraint(s)) =========
-- Requires: sales schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);

-- ========= sales --> invoice (3 constraint(s)) =========
-- Requires: sales schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);

-- ========= sales --> packaging (5 constraint(s)) =========
-- Requires: sales schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= sales --> process (1 constraint(s)) =========
-- Requires: sales schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`flow`(`flow_id`);

-- ========= sales --> product (13 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_compliance_cert_id` FOREIGN KEY (`compliance_cert_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`compliance_cert`(`compliance_cert_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= sales --> test (2 constraint(s)) =========
-- Requires: sales schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);

-- ========= test --> customer (3 constraint(s)) =========
-- Requires: test schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);

-- ========= test --> design (6 constraint(s)) =========
-- Requires: test schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);

-- ========= test --> equipment (16 constraint(s)) =========
-- Requires: test schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= test --> fabrication (7 constraint(s)) =========
-- Requires: test schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);

-- ========= test --> inventory (2 constraint(s)) =========
-- Requires: test schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= test --> packaging (7 constraint(s)) =========
-- Requires: test schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= test --> process (6 constraint(s)) =========
-- Requires: test schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);

-- ========= test --> product (9 constraint(s)) =========
-- Requires: test schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_spec`(`product_spec_id`);

