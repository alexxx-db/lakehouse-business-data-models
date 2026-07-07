-- Cross-Domain Foreign Keys for Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:05
-- Total cross-domain FK constraints: 536
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: client, contract, design, equipment, finance, material, procurement, project, quality, safety, schedule, site, workforce

-- ========= client --> site (1 constraint(s)) =========
-- Requires: client schema, site schema
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ADD CONSTRAINT `fk_client_master_services_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= contract --> client (6 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_master_services_agreement_id` FOREIGN KEY (`master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_prequalification_id` FOREIGN KEY (`prequalification_id`) REFERENCES `vibe_construction_v1`.`client`.`prequalification`(`prequalification_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `vibe_construction_v1`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= contract --> design (4 constraint(s)) =========
-- Requires: contract schema, design schema
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ADD CONSTRAINT `fk_contract_scope_of_work_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);

-- ========= contract --> equipment (1 constraint(s)) =========
-- Requires: contract schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= contract --> finance (4 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ADD CONSTRAINT `fk_contract_scope_of_work_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= contract --> procurement (6 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= contract --> project (7 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`change_order`(`change_order_id`);

-- ========= contract --> safety (3 constraint(s)) =========
-- Requires: contract schema, safety schema
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ADD CONSTRAINT `fk_contract_scope_of_work_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);

-- ========= contract --> schedule (5 constraint(s)) =========
-- Requires: contract schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `vibe_construction_v1`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `vibe_construction_v1`.`schedule`.`delay_event`(`delay_event_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= contract --> site (4 constraint(s)) =========
-- Requires: contract schema, site schema
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= design --> client (2 constraint(s)) =========
-- Requires: design schema, client schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= design --> equipment (2 constraint(s)) =========
-- Requires: design schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);

-- ========= design --> finance (6 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`package` ADD CONSTRAINT `fk_design_package_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);

-- ========= design --> material (1 constraint(s)) =========
-- Requires: design schema, material schema
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= design --> procurement (2 constraint(s)) =========
-- Requires: design schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= design --> project (5 constraint(s)) =========
-- Requires: design schema, project schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`package` ADD CONSTRAINT `fk_design_package_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);

-- ========= design --> safety (3 constraint(s)) =========
-- Requires: design schema, safety schema
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= design --> workforce (1 constraint(s)) =========
-- Requires: design schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);

-- ========= equipment --> client (1 constraint(s)) =========
-- Requires: equipment schema, client schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= equipment --> contract (2 constraint(s)) =========
-- Requires: equipment schema, contract schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= equipment --> design (1 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= equipment --> finance (16 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ADD CONSTRAINT `fk_equipment_functional_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= equipment --> material (4 constraint(s)) =========
-- Requires: equipment schema, material schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= equipment --> procurement (7 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> project (12 constraint(s)) =========
-- Requires: equipment schema, project schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= equipment --> quality (4 constraint(s)) =========
-- Requires: equipment schema, quality schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= equipment --> safety (7 constraint(s)) =========
-- Requires: equipment schema, safety schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= equipment --> site (2 constraint(s)) =========
-- Requires: equipment schema, site schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= equipment --> workforce (6 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= finance --> client (4 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_master_services_agreement_id` FOREIGN KEY (`master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);

-- ========= finance --> contract (7 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_payment_schedule_id` FOREIGN KEY (`payment_schedule_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_schedule`(`payment_schedule_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_subcontract_payment_id` FOREIGN KEY (`subcontract_payment_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract_payment`(`subcontract_payment_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_payment_schedule_id` FOREIGN KEY (`payment_schedule_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_schedule`(`payment_schedule_id`);

-- ========= finance --> procurement (6 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> project (13 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= finance --> schedule (4 constraint(s)) =========
-- Requires: finance schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `vibe_construction_v1`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_activity_resource_assignment_id` FOREIGN KEY (`activity_resource_assignment_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity_resource_assignment`(`activity_resource_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `vibe_construction_v1`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);

-- ========= finance --> workforce (4 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `vibe_construction_v1`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_timesheet_line_id` FOREIGN KEY (`timesheet_line_id`) REFERENCES `vibe_construction_v1`.`workforce`.`timesheet_line`(`timesheet_line_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_timesheet_line_id` FOREIGN KEY (`timesheet_line_id`) REFERENCES `vibe_construction_v1`.`workforce`.`timesheet_line`(`timesheet_line_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `vibe_construction_v1`.`workforce`.`staffing_plan`(`staffing_plan_id`);

-- ========= material --> client (7 constraint(s)) =========
-- Requires: material schema, client schema
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `vibe_construction_v1`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_master_services_agreement_id` FOREIGN KEY (`master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);

-- ========= material --> contract (2 constraint(s)) =========
-- Requires: material schema, contract schema
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);

-- ========= material --> finance (21 constraint(s)) =========
-- Requires: material schema, finance schema
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= material --> procurement (1 constraint(s)) =========
-- Requires: material schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= material --> project (1 constraint(s)) =========
-- Requires: material schema, project schema
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);

-- ========= material --> safety (2 constraint(s)) =========
-- Requires: material schema, safety schema
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= material --> schedule (3 constraint(s)) =========
-- Requires: material schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= material --> site (1 constraint(s)) =========
-- Requires: material schema, site schema
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= material --> workforce (1 constraint(s)) =========
-- Requires: material schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= procurement --> client (6 constraint(s)) =========
-- Requires: procurement schema, client schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_master_services_agreement_id` FOREIGN KEY (`master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `vibe_construction_v1`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_master_services_agreement_id` FOREIGN KEY (`master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `vibe_construction_v1`.`client`.`rfp_issuance`(`rfp_issuance_id`);

-- ========= procurement --> design (4 constraint(s)) =========
-- Requires: procurement schema, design schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= procurement --> finance (15 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> material (7 constraint(s)) =========
-- Requires: procurement schema, material schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_mto_header_id` FOREIGN KEY (`mto_header_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_header`(`mto_header_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_line`(`mto_line_id`);

-- ========= procurement --> project (2 constraint(s)) =========
-- Requires: procurement schema, project schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);

-- ========= procurement --> safety (1 constraint(s)) =========
-- Requires: procurement schema, safety schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= procurement --> schedule (2 constraint(s)) =========
-- Requires: procurement schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= procurement --> workforce (3 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `vibe_construction_v1`.`workforce`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= project --> client (4 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_master_services_agreement_id` FOREIGN KEY (`master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= project --> contract (1 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= project --> design (2 constraint(s)) =========
-- Requires: project schema, design schema
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);

-- ========= project --> finance (11 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_construction_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= project --> material (3 constraint(s)) =========
-- Requires: project schema, material schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);

-- ========= project --> procurement (1 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= project --> quality (1 constraint(s)) =========
-- Requires: project schema, quality schema
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);

-- ========= project --> safety (3 constraint(s)) =========
-- Requires: project schema, safety schema
ALTER TABLE `vibe_construction_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= project --> schedule (3 constraint(s)) =========
-- Requires: project schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> client (4 constraint(s)) =========
-- Requires: quality schema, client schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= quality --> design (4 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_engineering_submittal_id` FOREIGN KEY (`engineering_submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`engineering_submittal`(`engineering_submittal_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);

-- ========= quality --> equipment (2 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);

-- ========= quality --> finance (8 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= quality --> material (4 constraint(s)) =========
-- Requires: quality schema, material schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `vibe_construction_v1`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= quality --> procurement (5 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= quality --> project (10 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);

-- ========= quality --> safety (9 constraint(s)) =========
-- Requires: quality schema, safety schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= quality --> schedule (1 constraint(s)) =========
-- Requires: quality schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> site (5 constraint(s)) =========
-- Requires: quality schema, site schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_concrete_pour_id` FOREIGN KEY (`concrete_pour_id`) REFERENCES `vibe_construction_v1`.`site`.`concrete_pour`(`concrete_pour_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_concrete_pour_id` FOREIGN KEY (`concrete_pour_id`) REFERENCES `vibe_construction_v1`.`site`.`concrete_pour`(`concrete_pour_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= quality --> workforce (4 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= safety --> client (5 constraint(s)) =========
-- Requires: safety schema, client schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_master_services_agreement_id` FOREIGN KEY (`master_services_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`master_services_agreement`(`master_services_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= safety --> contract (2 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);

-- ========= safety --> design (2 constraint(s)) =========
-- Requires: safety schema, design schema
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= safety --> equipment (1 constraint(s)) =========
-- Requires: safety schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= safety --> finance (12 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= safety --> material (3 constraint(s)) =========
-- Requires: safety schema, material schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= safety --> procurement (8 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> project (9 constraint(s)) =========
-- Requires: safety schema, project schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);

-- ========= safety --> quality (1 constraint(s)) =========
-- Requires: safety schema, quality schema
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);

-- ========= safety --> site (5 constraint(s)) =========
-- Requires: safety schema, site schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= safety --> workforce (8 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= schedule --> client (1 constraint(s)) =========
-- Requires: schedule schema, client schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);

-- ========= schedule --> design (2 constraint(s)) =========
-- Requires: schedule schema, design schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);

-- ========= schedule --> equipment (3 constraint(s)) =========
-- Requires: schedule schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_construction_v1`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);

-- ========= schedule --> finance (7 constraint(s)) =========
-- Requires: schedule schema, finance schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= schedule --> procurement (2 constraint(s)) =========
-- Requires: schedule schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= schedule --> project (8 constraint(s)) =========
-- Requires: schedule schema, project schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);

-- ========= schedule --> quality (2 constraint(s)) =========
-- Requires: schedule schema, quality schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);

-- ========= schedule --> safety (5 constraint(s)) =========
-- Requires: schedule schema, safety schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= schedule --> site (1 constraint(s)) =========
-- Requires: schedule schema, site schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= schedule --> workforce (1 constraint(s)) =========
-- Requires: schedule schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `vibe_construction_v1`.`workforce`.`staffing_plan`(`staffing_plan_id`);

-- ========= site --> client (4 constraint(s)) =========
-- Requires: site schema, client schema
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);

-- ========= site --> contract (5 constraint(s)) =========
-- Requires: site schema, contract schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= site --> design (4 constraint(s)) =========
-- Requires: site schema, design schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_construction_v1`.`design`.`package`(`package_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);

-- ========= site --> equipment (11 constraint(s)) =========
-- Requires: site schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_construction_v1`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_hours_id` FOREIGN KEY (`hours_id`) REFERENCES `vibe_construction_v1`.`equipment`.`hours`(`hours_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_construction_v1`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= site --> finance (13 constraint(s)) =========
-- Requires: site schema, finance schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= site --> material (5 constraint(s)) =========
-- Requires: site schema, material schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `vibe_construction_v1`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= site --> procurement (8 constraint(s)) =========
-- Requires: site schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_construction_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= site --> project (13 constraint(s)) =========
-- Requires: site schema, project schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);

-- ========= site --> quality (7 constraint(s)) =========
-- Requires: site schema, quality schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);

-- ========= site --> safety (8 constraint(s)) =========
-- Requires: site schema, safety schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= site --> schedule (8 constraint(s)) =========
-- Requires: site schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= site --> workforce (8 constraint(s)) =========
-- Requires: site schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`mobilization` ADD CONSTRAINT `fk_site_mobilization_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `vibe_construction_v1`.`workforce`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= workforce --> client (2 constraint(s)) =========
-- Requires: workforce schema, client schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_prequalification_id` FOREIGN KEY (`prequalification_id`) REFERENCES `vibe_construction_v1`.`client`.`prequalification`(`prequalification_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);

-- ========= workforce --> contract (2 constraint(s)) =========
-- Requires: workforce schema, contract schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);

-- ========= workforce --> equipment (1 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);

-- ========= workforce --> finance (10 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);

-- ========= workforce --> procurement (1 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= workforce --> project (5 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);

-- ========= workforce --> quality (1 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);

-- ========= workforce --> safety (3 constraint(s)) =========
-- Requires: workforce schema, safety schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= workforce --> schedule (2 constraint(s)) =========
-- Requires: workforce schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);

