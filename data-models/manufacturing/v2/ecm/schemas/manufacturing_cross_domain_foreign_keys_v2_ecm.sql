-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:59:05
-- Total cross-domain FK constraints: 1520
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, automation, billing, compliance, customer, engineering, finance, inventory, logistics, order, procurement, product, production, project, quality, sales, service, supplier, supply, workforce

-- ========= asset --> automation (11 constraint(s)) =========
-- Requires: asset schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_plc_program_id` FOREIGN KEY (`plc_program_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`plc_program`(`plc_program_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_tag_definition_id` FOREIGN KEY (`tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);

-- ========= asset --> compliance (5 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ADD CONSTRAINT `fk_asset_asset_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ADD CONSTRAINT `fk_asset_compliance_assessment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ADD CONSTRAINT `fk_asset_regulatory_applicability_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= asset --> customer (4 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= asset --> engineering (7 constraint(s)) =========
-- Requires: asset schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_engineering_project_id` FOREIGN KEY (`engineering_project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_project`(`engineering_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_engineering_project_id` FOREIGN KEY (`engineering_project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_project`(`engineering_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= asset --> finance (12 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ADD CONSTRAINT `fk_asset_reliability_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ADD CONSTRAINT `fk_asset_capex_asset_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ADD CONSTRAINT `fk_asset_asset_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= asset --> inventory (2 constraint(s)) =========
-- Requires: asset schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= asset --> logistics (4 constraint(s)) =========
-- Requires: asset schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` ADD CONSTRAINT `fk_asset_equipment_shipment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= asset --> order (2 constraint(s)) =========
-- Requires: asset schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ADD CONSTRAINT `fk_asset_equipment_allocation_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);

-- ========= asset --> procurement (1 constraint(s)) =========
-- Requires: asset schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ADD CONSTRAINT `fk_asset_asset_warranty_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= asset --> product (5 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_certification`(`product_certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ADD CONSTRAINT `fk_asset_asset_certification_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_certification`(`product_certification_id`);

-- ========= asset --> production (6 constraint(s)) =========
-- Requires: asset schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);

-- ========= asset --> project (9 constraint(s)) =========
-- Requires: asset schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ADD CONSTRAINT `fk_asset_reliability_record_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ADD CONSTRAINT `fk_asset_asset_warranty_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ADD CONSTRAINT `fk_asset_asset_certification_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= asset --> quality (1 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`notification`(`notification_id`);

-- ========= asset --> service (2 constraint(s)) =========
-- Requires: asset schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);

-- ========= asset --> supplier (8 constraint(s)) =========
-- Requires: asset schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ADD CONSTRAINT `fk_asset_capex_asset_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ADD CONSTRAINT `fk_asset_asset_warranty_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= asset --> supply (3 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);

-- ========= asset --> workforce (11 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_tertiary_asset_reported_by_employee_id` FOREIGN KEY (`tertiary_asset_reported_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ADD CONSTRAINT `fk_asset_capex_asset_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_tertiary_inspection_approved_by_employee_id` FOREIGN KEY (`tertiary_inspection_approved_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ADD CONSTRAINT `fk_asset_asset_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= automation --> asset (13 constraint(s)) =========
-- Requires: automation schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ADD CONSTRAINT `fk_automation_network_segment_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ADD CONSTRAINT `fk_automation_alarm_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ADD CONSTRAINT `fk_automation_device_connectivity_event_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);

-- ========= automation --> compliance (1 constraint(s)) =========
-- Requires: automation schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ADD CONSTRAINT `fk_automation_safety_function_process_hazard_id` FOREIGN KEY (`process_hazard_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`process_hazard`(`process_hazard_id`);

-- ========= automation --> customer (6 constraint(s)) =========
-- Requires: automation schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ADD CONSTRAINT `fk_automation_control_system_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ADD CONSTRAINT `fk_automation_edge_gateway_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ADD CONSTRAINT `fk_automation_edge_gateway_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= automation --> engineering (5 constraint(s)) =========
-- Requires: automation schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ADD CONSTRAINT `fk_automation_plc_program_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ADD CONSTRAINT `fk_automation_tag_definition_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);

-- ========= automation --> finance (6 constraint(s)) =========
-- Requires: automation schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ADD CONSTRAINT `fk_automation_control_system_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= automation --> inventory (1 constraint(s)) =========
-- Requires: automation schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= automation --> order (1 constraint(s)) =========
-- Requires: automation schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ADD CONSTRAINT `fk_automation_batch_schedule_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);

-- ========= automation --> product (5 constraint(s)) =========
-- Requires: automation schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ADD CONSTRAINT `fk_automation_control_system_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ADD CONSTRAINT `fk_automation_plc_program_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ADD CONSTRAINT `fk_automation_tag_definition_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ADD CONSTRAINT `fk_automation_recipe_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= automation --> production (13 constraint(s)) =========
-- Requires: automation schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ADD CONSTRAINT `fk_automation_alarm_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ADD CONSTRAINT `fk_automation_setpoint_change_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ADD CONSTRAINT `fk_automation_recipe_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ADD CONSTRAINT `fk_automation_device_connectivity_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ADD CONSTRAINT `fk_automation_device_connectivity_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ADD CONSTRAINT `fk_automation_batch_schedule_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);

-- ========= automation --> project (6 constraint(s)) =========
-- Requires: automation schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ADD CONSTRAINT `fk_automation_process_parameter_project_change_request_id` FOREIGN KEY (`project_change_request_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_change_request`(`project_change_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ADD CONSTRAINT `fk_automation_device_config_snapshot_project_change_request_id` FOREIGN KEY (`project_change_request_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_change_request`(`project_change_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ADD CONSTRAINT `fk_automation_firmware_update_project_change_request_id` FOREIGN KEY (`project_change_request_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_change_request`(`project_change_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ADD CONSTRAINT `fk_automation_io_mapping_project_change_request_id` FOREIGN KEY (`project_change_request_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_change_request`(`project_change_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_project_document_id` FOREIGN KEY (`project_document_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_document`(`project_document_id`);

-- ========= automation --> supplier (3 constraint(s)) =========
-- Requires: automation schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ADD CONSTRAINT `fk_automation_control_system_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ADD CONSTRAINT `fk_automation_opc_server_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= automation --> workforce (16 constraint(s)) =========
-- Requires: automation schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ADD CONSTRAINT `fk_automation_control_system_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ADD CONSTRAINT `fk_automation_alarm_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ADD CONSTRAINT `fk_automation_device_config_snapshot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ADD CONSTRAINT `fk_automation_firmware_update_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ADD CONSTRAINT `fk_automation_scada_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ADD CONSTRAINT `fk_automation_setpoint_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_tertiary_automation_change_review_by_employee_id` FOREIGN KEY (`tertiary_automation_change_review_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_tertiary_automation_approved_by_employee_id` FOREIGN KEY (`tertiary_automation_approved_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_tertiary_fat_approved_by_employee_id` FOREIGN KEY (`tertiary_fat_approved_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> asset (3 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= billing --> automation (1 constraint(s)) =========
-- Requires: billing schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_compliance_product_certification_id` FOREIGN KEY (`compliance_product_certification_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification`(`compliance_product_certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ADD CONSTRAINT `fk_billing_intercompany_invoice_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= billing --> customer (10 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ADD CONSTRAINT `fk_billing_credit_limit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= billing --> finance (12 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ADD CONSTRAINT `fk_billing_intercompany_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ADD CONSTRAINT `fk_billing_intercompany_invoice_sending_company_code_id` FOREIGN KEY (`sending_company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= billing --> inventory (3 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= billing --> logistics (1 constraint(s)) =========
-- Requires: billing schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= billing --> order (4 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= billing --> procurement (1 constraint(s)) =========
-- Requires: billing schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`intercompany_invoice` ADD CONSTRAINT `fk_billing_intercompany_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= billing --> product (3 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ADD CONSTRAINT `fk_billing_tax_determination_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= billing --> production (1 constraint(s)) =========
-- Requires: billing schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= billing --> project (4 constraint(s)) =========
-- Requires: billing schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= billing --> quality (2 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= billing --> sales (9 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= billing --> service (4 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);

-- ========= billing --> workforce (9 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ADD CONSTRAINT `fk_billing_credit_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> asset (6 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ADD CONSTRAINT `fk_compliance_safety_incident_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ADD CONSTRAINT `fk_compliance_cybersecurity_assessment_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ADD CONSTRAINT `fk_compliance_cybersecurity_assessment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ADD CONSTRAINT `fk_compliance_periodic_evaluation_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ADD CONSTRAINT `fk_compliance_process_hazard_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ADD CONSTRAINT `fk_compliance_facility_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);

-- ========= compliance --> automation (11 constraint(s)) =========
-- Requires: compliance schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ADD CONSTRAINT `fk_compliance_safety_inspection_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ADD CONSTRAINT `fk_compliance_environmental_aspect_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ADD CONSTRAINT `fk_compliance_emissions_record_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ADD CONSTRAINT `fk_compliance_compliance_product_certification_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_automation_project_id` FOREIGN KEY (`automation_project_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_project`(`automation_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ADD CONSTRAINT `fk_compliance_cybersecurity_control_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ADD CONSTRAINT `fk_compliance_cybersecurity_assessment_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ADD CONSTRAINT `fk_compliance_controlled_document_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);

-- ========= compliance --> customer (2 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ADD CONSTRAINT `fk_compliance_safety_incident_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);

-- ========= compliance --> finance (9 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ADD CONSTRAINT `fk_compliance_compliance_product_certification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ADD CONSTRAINT `fk_compliance_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= compliance --> inventory (1 constraint(s)) =========
-- Requires: compliance schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= compliance --> logistics (2 constraint(s)) =========
-- Requires: compliance schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ADD CONSTRAINT `fk_compliance_safety_inspection_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);

-- ========= compliance --> product (5 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ADD CONSTRAINT `fk_compliance_compliance_product_certification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);

-- ========= compliance --> production (1 constraint(s)) =========
-- Requires: compliance schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ADD CONSTRAINT `fk_compliance_process_hazard_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);

-- ========= compliance --> project (16 constraint(s)) =========
-- Requires: compliance schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ADD CONSTRAINT `fk_compliance_audit_plan_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ADD CONSTRAINT `fk_compliance_safety_incident_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ADD CONSTRAINT `fk_compliance_safety_inspection_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ADD CONSTRAINT `fk_compliance_environmental_aspect_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ADD CONSTRAINT `fk_compliance_emissions_record_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ADD CONSTRAINT `fk_compliance_compliance_product_certification_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ADD CONSTRAINT `fk_compliance_cybersecurity_control_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ADD CONSTRAINT `fk_compliance_cybersecurity_assessment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ADD CONSTRAINT `fk_compliance_periodic_evaluation_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ADD CONSTRAINT `fk_compliance_controlled_document_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= compliance --> quality (2 constraint(s)) =========
-- Requires: compliance schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= compliance --> supplier (2 constraint(s)) =========
-- Requires: compliance schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ADD CONSTRAINT `fk_compliance_hazardous_substance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= compliance --> workforce (20 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ADD CONSTRAINT `fk_compliance_audit_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ADD CONSTRAINT `fk_compliance_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ADD CONSTRAINT `fk_compliance_safety_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ADD CONSTRAINT `fk_compliance_environmental_aspect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ADD CONSTRAINT `fk_compliance_emissions_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ADD CONSTRAINT `fk_compliance_compliance_product_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ADD CONSTRAINT `fk_compliance_cybersecurity_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ADD CONSTRAINT `fk_compliance_cybersecurity_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ADD CONSTRAINT `fk_compliance_periodic_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ADD CONSTRAINT `fk_compliance_periodic_evaluation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ADD CONSTRAINT `fk_compliance_controlled_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ADD CONSTRAINT `fk_compliance_controlled_document_primary_controlled_employee_id` FOREIGN KEY (`primary_controlled_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> asset (1 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ADD CONSTRAINT `fk_customer_customer_entitlement_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= customer --> billing (1 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);

-- ========= customer --> finance (5 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= customer --> order (2 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ADD CONSTRAINT `fk_customer_customer_entitlement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= customer --> product (3 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ADD CONSTRAINT `fk_customer_customer_lead_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ADD CONSTRAINT `fk_customer_customer_certification_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_certification`(`product_certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ADD CONSTRAINT `fk_customer_customer_entitlement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= customer --> sales (10 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ADD CONSTRAINT `fk_customer_customer_lead_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ADD CONSTRAINT `fk_customer_customer_onboarding_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= customer --> service (1 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);

-- ========= customer --> supplier (2 constraint(s)) =========
-- Requires: customer schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= customer --> workforce (15 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ADD CONSTRAINT `fk_customer_customer_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ADD CONSTRAINT `fk_customer_customer_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_account_user_employee_id` FOREIGN KEY (`account_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ADD CONSTRAINT `fk_customer_customer_onboarding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_primary_customer_employee_id` FOREIGN KEY (`primary_customer_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= engineering --> asset (2 constraint(s)) =========
-- Requires: engineering schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ADD CONSTRAINT `fk_engineering_component_installation_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= engineering --> compliance (10 constraint(s)) =========
-- Requires: engineering schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ADD CONSTRAINT `fk_engineering_certification_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ADD CONSTRAINT `fk_engineering_configuration_baseline_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= engineering --> customer (8 constraint(s)) =========
-- Requires: engineering schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= engineering --> finance (10 constraint(s)) =========
-- Requires: engineering schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ADD CONSTRAINT `fk_engineering_certification_requirement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= engineering --> inventory (3 constraint(s)) =========
-- Requires: engineering schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ADD CONSTRAINT `fk_engineering_project_material_allocation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= engineering --> product (4 constraint(s)) =========
-- Requires: engineering schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ADD CONSTRAINT `fk_engineering_certification_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= engineering --> project (5 constraint(s)) =========
-- Requires: engineering schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`activity`(`activity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_project_document_id` FOREIGN KEY (`project_document_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_document`(`project_document_id`);

-- ========= engineering --> quality (7 constraint(s)) =========
-- Requires: engineering schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_apqp_project_id` FOREIGN KEY (`apqp_project_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`apqp_project`(`apqp_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_ppap_submission_id` FOREIGN KEY (`ppap_submission_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ppap_submission`(`ppap_submission_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ADD CONSTRAINT `fk_engineering_dfm_analysis_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_ppap_submission_id` FOREIGN KEY (`ppap_submission_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ppap_submission`(`ppap_submission_id`);

-- ========= engineering --> supplier (9 constraint(s)) =========
-- Requires: engineering schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ADD CONSTRAINT `fk_engineering_dfm_analysis_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ADD CONSTRAINT `fk_engineering_certification_requirement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= engineering --> workforce (15 constraint(s)) =========
-- Requires: engineering schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_primary_ecn_employee_id` FOREIGN KEY (`primary_ecn_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_tertiary_dfmea_team_lead_employee_id` FOREIGN KEY (`tertiary_dfmea_team_lead_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ADD CONSTRAINT `fk_engineering_dfm_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ADD CONSTRAINT `fk_engineering_engineering_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ADD CONSTRAINT `fk_engineering_configuration_baseline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> asset (3 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capex_asset_record_id` FOREIGN KEY (`capex_asset_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`capex_asset_record`(`capex_asset_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= finance --> billing (2 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> compliance (1 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`obligation`(`obligation_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= finance --> inventory (1 constraint(s)) =========
-- Requires: finance schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= finance --> order (1 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= finance --> procurement (1 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= finance --> product (1 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= finance --> project (6 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= finance --> supplier (2 constraint(s)) =========
-- Requires: finance schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`agreement`(`agreement_id`);

-- ========= finance --> workforce (13 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ADD CONSTRAINT `fk_finance_financial_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_cost_employee_id` FOREIGN KEY (`cost_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> asset (6 constraint(s)) =========
-- Requires: inventory schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ADD CONSTRAINT `fk_inventory_inventory_safety_stock_policy_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ADD CONSTRAINT `fk_inventory_inventory_plant_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);

-- ========= inventory --> billing (1 constraint(s)) =========
-- Requires: inventory schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= inventory --> compliance (5 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= inventory --> customer (9 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= inventory --> finance (7 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ADD CONSTRAINT `fk_inventory_inventory_plant_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= inventory --> logistics (4 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= inventory --> order (3 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= inventory --> procurement (3 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> product (2 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);

-- ========= inventory --> production (6 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= inventory --> project (6 constraint(s)) =========
-- Requires: inventory schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= inventory --> quality (5 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= inventory --> supplier (8 constraint(s)) =========
-- Requires: inventory schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= inventory --> supply (4 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);

-- ========= inventory --> workforce (16 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_tertiary_cycle_approved_by_employee_id` FOREIGN KEY (`tertiary_cycle_approved_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_tertiary_quinary_cycle_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_quinary_cycle_last_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_tertiary_replenishment_modified_by_user_employee_id` FOREIGN KEY (`tertiary_replenishment_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ADD CONSTRAINT `fk_inventory_inventory_safety_stock_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ADD CONSTRAINT `fk_inventory_supply_area_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ADD CONSTRAINT `fk_inventory_supply_area_supply_employee_id` FOREIGN KEY (`supply_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ADD CONSTRAINT `fk_inventory_supply_area_supply_responsible_manager_employee_id` FOREIGN KEY (`supply_responsible_manager_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= logistics --> asset (1 constraint(s)) =========
-- Requires: logistics schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);

-- ========= logistics --> compliance (2 constraint(s)) =========
-- Requires: logistics schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` ADD CONSTRAINT `fk_logistics_carrier_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= logistics --> customer (7 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= logistics --> finance (9 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ADD CONSTRAINT `fk_logistics_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= logistics --> inventory (4 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ADD CONSTRAINT `fk_logistics_delivery_appointment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= logistics --> order (6 constraint(s)) =========
-- Requires: logistics schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ADD CONSTRAINT `fk_logistics_delivery_appointment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= logistics --> procurement (6 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ADD CONSTRAINT `fk_logistics_delivery_appointment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= logistics --> product (5 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ADD CONSTRAINT `fk_logistics_trade_compliance_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= logistics --> project (6 constraint(s)) =========
-- Requires: logistics schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ADD CONSTRAINT `fk_logistics_delivery_appointment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= logistics --> quality (1 constraint(s)) =========
-- Requires: logistics schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= logistics --> supplier (5 constraint(s)) =========
-- Requires: logistics schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ADD CONSTRAINT `fk_logistics_node_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ADD CONSTRAINT `fk_logistics_node_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);

-- ========= logistics --> supply (3 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`allocation`(`allocation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_replenishment_proposal_id` FOREIGN KEY (`replenishment_proposal_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`replenishment_proposal`(`replenishment_proposal_id`);

-- ========= logistics --> workforce (14 constraint(s)) =========
-- Requires: logistics schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ADD CONSTRAINT `fk_logistics_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ADD CONSTRAINT `fk_logistics_delivery_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_logistics_dangerous_goods_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ADD CONSTRAINT `fk_logistics_trade_compliance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= order --> asset (1 constraint(s)) =========
-- Requires: order schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);

-- ========= order --> automation (2 constraint(s)) =========
-- Requires: order schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_automation_project_id` FOREIGN KEY (`automation_project_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_project`(`automation_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);

-- ========= order --> compliance (5 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_compliance_product_certification_id` FOREIGN KEY (`compliance_product_certification_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification`(`compliance_product_certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= order --> customer (12 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ADD CONSTRAINT `fk_order_fulfillment_sla_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ADD CONSTRAINT `fk_order_proof_of_delivery_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_amendment` ADD CONSTRAINT `fk_order_order_amendment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= order --> engineering (4 constraint(s)) =========
-- Requires: order schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= order --> finance (9 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= order --> inventory (8 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= order --> product (6 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= order --> production (1 constraint(s)) =========
-- Requires: order schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= order --> project (5 constraint(s)) =========
-- Requires: order schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= order --> sales (7 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= order --> supplier (5 constraint(s)) =========
-- Requires: order schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= order --> workforce (9 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ADD CONSTRAINT `fk_order_order_header_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ADD CONSTRAINT `fk_order_order_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_tertiary_order_updated_by_user_employee_id` FOREIGN KEY (`tertiary_order_updated_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_order_hold_releasing_user_employee_id` FOREIGN KEY (`order_hold_releasing_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_amendment` ADD CONSTRAINT `fk_order_order_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> asset (6 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);

-- ========= procurement --> automation (4 constraint(s)) =========
-- Requires: procurement schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);

-- ========= procurement --> billing (1 constraint(s)) =========
-- Requires: procurement schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= procurement --> compliance (6 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_compliance_product_certification_id` FOREIGN KEY (`compliance_product_certification_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification`(`compliance_product_certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= procurement --> customer (3 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);

-- ========= procurement --> engineering (4 constraint(s)) =========
-- Requires: procurement schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);

-- ========= procurement --> finance (16 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= procurement --> inventory (15 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ADD CONSTRAINT `fk_procurement_purchase_info_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= procurement --> order (1 constraint(s)) =========
-- Requires: procurement schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= procurement --> product (6 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= procurement --> project (7 constraint(s)) =========
-- Requires: procurement schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_project_document_id` FOREIGN KEY (`project_document_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_document`(`project_document_id`);

-- ========= procurement --> sales (3 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= procurement --> service (3 constraint(s)) =========
-- Requires: procurement schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);

-- ========= procurement --> supplier (16 constraint(s)) =========
-- Requires: procurement schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_contact_id` FOREIGN KEY (`supplier_contact_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier_contact`(`supplier_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_strategy` ADD CONSTRAINT `fk_procurement_sourcing_strategy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ADD CONSTRAINT `fk_procurement_purchase_info_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= procurement --> supply (5 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plan`(`supply_plan_id`);

-- ========= procurement --> workforce (25 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_tertiary_purchase_employee_id` FOREIGN KEY (`tertiary_purchase_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_tertiary_procurement_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_procurement_last_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_tertiary_procurement_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_procurement_last_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_primary_spend_employee_id` FOREIGN KEY (`primary_spend_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ADD CONSTRAINT `fk_procurement_commodity_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`commodity_category` ADD CONSTRAINT `fk_procurement_commodity_category_tertiary_commodity_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_commodity_last_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ADD CONSTRAINT `fk_procurement_purchase_info_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= product --> compliance (5 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ADD CONSTRAINT `fk_product_lifecycle_stage_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= product --> engineering (3 constraint(s)) =========
-- Requires: product schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);

-- ========= product --> finance (7 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_cost_estimate_id` FOREIGN KEY (`cost_estimate_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_estimate`(`cost_estimate_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= product --> procurement (1 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= product --> production (2 constraint(s)) =========
-- Requires: product schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= product --> supplier (2 constraint(s)) =========
-- Requires: product schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= product --> workforce (11 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ADD CONSTRAINT `fk_product_catalog_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_tertiary_bom_last_modified_by_employee_id` FOREIGN KEY (`tertiary_bom_last_modified_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ADD CONSTRAINT `fk_product_product_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ADD CONSTRAINT `fk_product_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= production --> asset (17 constraint(s)) =========
-- Requires: production schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_maintenance_strategy_id` FOREIGN KEY (`maintenance_strategy_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`maintenance_strategy`(`maintenance_strategy_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ADD CONSTRAINT `fk_production_shift_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ADD CONSTRAINT `fk_production_work_center_group_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ADD CONSTRAINT `fk_production_production_plant_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= production --> automation (6 constraint(s)) =========
-- Requires: production schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_alarm_definition_id` FOREIGN KEY (`alarm_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_definition`(`alarm_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_historian_config_id` FOREIGN KEY (`historian_config_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`historian_config`(`historian_config_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);

-- ========= production --> compliance (3 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`safety_incident`(`safety_incident_id`);

-- ========= production --> customer (2 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= production --> engineering (11 constraint(s)) =========
-- Requires: production schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ADD CONSTRAINT `fk_production_version_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);

-- ========= production --> finance (7 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ADD CONSTRAINT `fk_production_production_plant_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= production --> inventory (18 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ADD CONSTRAINT `fk_production_version_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= production --> order (5 constraint(s)) =========
-- Requires: production schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ADD CONSTRAINT `fk_production_work_order_allocation_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= production --> procurement (1 constraint(s)) =========
-- Requires: production schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= production --> product (8 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= production --> project (4 constraint(s)) =========
-- Requires: production schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= production --> quality (1 constraint(s)) =========
-- Requires: production schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= production --> sales (3 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= production --> supplier (5 constraint(s)) =========
-- Requires: production schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= production --> supply (3 constraint(s)) =========
-- Requires: production schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);

-- ========= production --> workforce (17 constraint(s)) =========
-- Requires: production schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ADD CONSTRAINT `fk_production_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ADD CONSTRAINT `fk_production_shift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_tertiary_production_recorded_by_employee_id` FOREIGN KEY (`tertiary_production_recorded_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_production_modified_by_user_employee_id` FOREIGN KEY (`production_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_run` ADD CONSTRAINT `fk_production_production_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= project --> asset (3 constraint(s)) =========
-- Requires: project schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ADD CONSTRAINT `fk_project_resource_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ADD CONSTRAINT `fk_project_timesheet_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ADD CONSTRAINT `fk_project_commissioning_checklist_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= project --> automation (5 constraint(s)) =========
-- Requires: project schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ADD CONSTRAINT `fk_project_commissioning_checklist_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_issue` ADD CONSTRAINT `fk_project_project_issue_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_event`(`alarm_event_id`);

-- ========= project --> billing (1 constraint(s)) =========
-- Requires: project schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ADD CONSTRAINT `fk_project_invoice_request_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= project --> customer (5 constraint(s)) =========
-- Requires: project schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ADD CONSTRAINT `fk_project_invoice_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= project --> finance (7 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);

-- ========= project --> procurement (4 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);

-- ========= project --> product (5 constraint(s)) =========
-- Requires: project schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= project --> production (2 constraint(s)) =========
-- Requires: project schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= project --> supplier (4 constraint(s)) =========
-- Requires: project schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ADD CONSTRAINT `fk_project_commissioning_checklist_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= project --> supply (7 constraint(s)) =========
-- Requires: project schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_capacity_plan_id` FOREIGN KEY (`capacity_plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`capacity_plan`(`capacity_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_replenishment_proposal_id` FOREIGN KEY (`replenishment_proposal_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`replenishment_proposal`(`replenishment_proposal_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ADD CONSTRAINT `fk_project_handover_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= project --> workforce (25 constraint(s)) =========
-- Requires: project schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_primary_project_employee_id` FOREIGN KEY (`primary_project_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_tertiary_cost_posting_user_employee_id` FOREIGN KEY (`tertiary_cost_posting_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ADD CONSTRAINT `fk_project_resource_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ADD CONSTRAINT `fk_project_project_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ADD CONSTRAINT `fk_project_project_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ADD CONSTRAINT `fk_project_project_change_request_tertiary_project_created_by_employee_id` FOREIGN KEY (`tertiary_project_created_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ADD CONSTRAINT `fk_project_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ADD CONSTRAINT `fk_project_timesheet_tertiary_timesheet_entered_by_employee_id` FOREIGN KEY (`tertiary_timesheet_entered_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ADD CONSTRAINT `fk_project_commissioning_checklist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ADD CONSTRAINT `fk_project_handover_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ADD CONSTRAINT `fk_project_handover_handover_org_unit_id` FOREIGN KEY (`handover_org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ADD CONSTRAINT `fk_project_handover_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ADD CONSTRAINT `fk_project_handover_tertiary_handover_updated_by_user_employee_id` FOREIGN KEY (`tertiary_handover_updated_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_primary_project_employee_id` FOREIGN KEY (`primary_project_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ADD CONSTRAINT `fk_project_progress_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ADD CONSTRAINT `fk_project_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_issue` ADD CONSTRAINT `fk_project_project_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_issue` ADD CONSTRAINT `fk_project_project_issue_project_issue_reporter_employee_id` FOREIGN KEY (`project_issue_reporter_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> asset (8 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`spc` ADD CONSTRAINT `fk_quality_spc_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`measurement_system` ADD CONSTRAINT `fk_quality_measurement_system_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= quality --> automation (7 constraint(s)) =========
-- Requires: quality schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_automation_change_request_id` FOREIGN KEY (`automation_change_request_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_change_request`(`automation_change_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`spc` ADD CONSTRAINT `fk_quality_spc_tag_definition_id` FOREIGN KEY (`tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`measurement_system` ADD CONSTRAINT `fk_quality_measurement_system_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);

-- ========= quality --> compliance (8 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit` ADD CONSTRAINT `fk_quality_supplier_quality_audit_audit_plan_id` FOREIGN KEY (`audit_plan_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`audit_plan`(`audit_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`measurement_system` ADD CONSTRAINT `fk_quality_measurement_system_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`audit_checklist` ADD CONSTRAINT `fk_quality_audit_checklist_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= quality --> customer (14 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`apqp_project` ADD CONSTRAINT `fk_quality_apqp_project_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= quality --> engineering (2 constraint(s)) =========
-- Requires: quality schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= quality --> finance (9 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit` ADD CONSTRAINT `fk_quality_supplier_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`spc` ADD CONSTRAINT `fk_quality_spc_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`measurement_system` ADD CONSTRAINT `fk_quality_measurement_system_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (9 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`spc` ADD CONSTRAINT `fk_quality_spc_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= quality --> logistics (2 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= quality --> order (6 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_order_rma_id` FOREIGN KEY (`order_rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_rma`(`order_rma_id`);

-- ========= quality --> procurement (7 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit` ADD CONSTRAINT `fk_quality_supplier_quality_audit_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= quality --> product (9 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`apqp_project` ADD CONSTRAINT `fk_quality_apqp_project_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= quality --> production (11 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_wip_lot_id` FOREIGN KEY (`wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_production_run_id` FOREIGN KEY (`production_run_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_run`(`production_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`spc` ADD CONSTRAINT `fk_quality_spc_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`spc` ADD CONSTRAINT `fk_quality_spc_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= quality --> project (7 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= quality --> sales (3 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= quality --> service (5 constraint(s)) =========
-- Requires: quality schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_service_rma_id` FOREIGN KEY (`service_rma_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_rma`(`service_rma_id`);

-- ========= quality --> supplier (12 constraint(s)) =========
-- Requires: quality schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit` ADD CONSTRAINT `fk_quality_supplier_quality_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`measurement_system` ADD CONSTRAINT `fk_quality_measurement_system_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= quality --> workforce (23 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_primary_ncr_reported_by_employee_id` FOREIGN KEY (`primary_ncr_reported_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_primary_capa_approved_by_employee_id` FOREIGN KEY (`primary_capa_approved_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit` ADD CONSTRAINT `fk_quality_supplier_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`apqp_project` ADD CONSTRAINT `fk_quality_apqp_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_primary_notification_reported_by_employee_id` FOREIGN KEY (`primary_notification_reported_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_primary_rma_authority_employee_id` FOREIGN KEY (`primary_rma_authority_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`measurement_system` ADD CONSTRAINT `fk_quality_measurement_system_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`audit_program` ADD CONSTRAINT `fk_quality_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> asset (3 constraint(s)) =========
-- Requires: sales schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= sales --> automation (3 constraint(s)) =========
-- Requires: sales schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_automation_project_id` FOREIGN KEY (`automation_project_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_project`(`automation_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ADD CONSTRAINT `fk_sales_device_contract_assignment_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);

-- ========= sales --> compliance (6 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_compliance_product_certification_id` FOREIGN KEY (`compliance_product_certification_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification`(`compliance_product_certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`permit`(`permit_id`);

-- ========= sales --> customer (10 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= sales --> engineering (4 constraint(s)) =========
-- Requires: sales schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_engineering_project_id` FOREIGN KEY (`engineering_project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_project`(`engineering_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ADD CONSTRAINT `fk_sales_opportunity_component_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= sales --> finance (10 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= sales --> inventory (4 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= sales --> product (9 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_tertiary_price_product_catalog_entry_id` FOREIGN KEY (`tertiary_price_product_catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= sales --> project (7 constraint(s)) =========
-- Requires: sales schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ADD CONSTRAINT `fk_sales_project_rep_assignment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= sales --> supplier (5 constraint(s)) =========
-- Requires: sales schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);

-- ========= sales --> workforce (23 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_tertiary_quota_last_modified_by_employee_id` FOREIGN KEY (`tertiary_quota_last_modified_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_tertiary_price_last_modified_by_employee_id` FOREIGN KEY (`tertiary_price_last_modified_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_tertiary_price_last_modified_by_employee_id` FOREIGN KEY (`tertiary_price_last_modified_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_channel_employee_id` FOREIGN KEY (`channel_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_channel_last_modified_by_user_employee_id` FOREIGN KEY (`channel_last_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ADD CONSTRAINT `fk_sales_sales_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ADD CONSTRAINT `fk_sales_sales_team_sales_employee_id` FOREIGN KEY (`sales_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ADD CONSTRAINT `fk_sales_sales_team_sales_manager_employee_id` FOREIGN KEY (`sales_manager_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ADD CONSTRAINT `fk_sales_quote_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ADD CONSTRAINT `fk_sales_quote_template_quote_employee_id` FOREIGN KEY (`quote_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ADD CONSTRAINT `fk_sales_quote_template_quote_updated_by_user_employee_id` FOREIGN KEY (`quote_updated_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= service --> asset (10 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ADD CONSTRAINT `fk_service_service_pm_schedule_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ADD CONSTRAINT `fk_service_service_pm_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ADD CONSTRAINT `fk_service_service_contract_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ADD CONSTRAINT `fk_service_contract_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= service --> automation (9 constraint(s)) =========
-- Requires: service schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ADD CONSTRAINT `fk_service_sla_milestone_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ADD CONSTRAINT `fk_service_engineer_assignment_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);

-- ========= service --> compliance (4 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_compliance_capa_record_id` FOREIGN KEY (`compliance_capa_record_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record`(`compliance_capa_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ADD CONSTRAINT `fk_service_service_contract_line_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= service --> customer (11 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ADD CONSTRAINT `fk_service_service_entitlement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ADD CONSTRAINT `fk_service_satisfaction_survey_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= service --> engineering (6 constraint(s)) =========
-- Requires: service schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_design_review_id` FOREIGN KEY (`design_review_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`design_review`(`design_review_id`);

-- ========= service --> finance (8 constraint(s)) =========
-- Requires: service schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ADD CONSTRAINT `fk_service_service_entitlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ADD CONSTRAINT `fk_service_zone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= service --> inventory (3 constraint(s)) =========
-- Requires: service schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= service --> logistics (7 constraint(s)) =========
-- Requires: service schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);

-- ========= service --> order (5 constraint(s)) =========
-- Requires: service schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ADD CONSTRAINT `fk_service_service_entitlement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= service --> product (8 constraint(s)) =========
-- Requires: service schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ADD CONSTRAINT `fk_service_service_entitlement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ADD CONSTRAINT `fk_service_bulletin_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ADD CONSTRAINT `fk_service_contract_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= service --> project (12 constraint(s)) =========
-- Requires: service schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ADD CONSTRAINT `fk_service_service_entitlement_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ADD CONSTRAINT `fk_service_sla_milestone_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ADD CONSTRAINT `fk_service_satisfaction_survey_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ADD CONSTRAINT `fk_service_service_pm_schedule_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= service --> sales (9 constraint(s)) =========
-- Requires: service schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= service --> supplier (3 constraint(s)) =========
-- Requires: service schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ADD CONSTRAINT `fk_service_service_contract_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= service --> workforce (10 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ADD CONSTRAINT `fk_service_engineer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ADD CONSTRAINT `fk_service_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_tertiary_service_corrective_action_owner_employee_id` FOREIGN KEY (`tertiary_service_corrective_action_owner_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ADD CONSTRAINT `fk_service_service_pm_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= supplier --> compliance (7 constraint(s)) =========
-- Requires: supplier schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ADD CONSTRAINT `fk_supplier_supplier_audit_finding_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ADD CONSTRAINT `fk_supplier_supplier_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_onboarding` ADD CONSTRAINT `fk_supplier_supplier_onboarding_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ADD CONSTRAINT `fk_supplier_change_notification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= supplier --> customer (2 constraint(s)) =========
-- Requires: supplier schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ADD CONSTRAINT `fk_supplier_tooling_asset_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= supplier --> engineering (1 constraint(s)) =========
-- Requires: supplier schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ADD CONSTRAINT `fk_supplier_change_notification_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= supplier --> finance (5 constraint(s)) =========
-- Requires: supplier schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ADD CONSTRAINT `fk_supplier_supplier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ADD CONSTRAINT `fk_supplier_supplier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ADD CONSTRAINT `fk_supplier_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supplier --> inventory (2 constraint(s)) =========
-- Requires: supplier schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ADD CONSTRAINT `fk_supplier_change_notification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= supplier --> procurement (2 constraint(s)) =========
-- Requires: supplier schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ADD CONSTRAINT `fk_supplier_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= supplier --> project (3 constraint(s)) =========
-- Requires: supplier schema, project schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_contact` ADD CONSTRAINT `fk_supplier_supplier_contact_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ADD CONSTRAINT `fk_supplier_supplier_certification_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= supplier --> quality (3 constraint(s)) =========
-- Requires: supplier schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ADD CONSTRAINT `fk_supplier_supplier_audit_finding_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ADD CONSTRAINT `fk_supplier_development_plan_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ADD CONSTRAINT `fk_supplier_corrective_action_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= supplier --> workforce (19 constraint(s)) =========
-- Requires: supplier schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier` ADD CONSTRAINT `fk_supplier_supplier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`site` ADD CONSTRAINT `fk_supplier_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_tertiary_qualification_modified_by_user_employee_id` FOREIGN KEY (`tertiary_qualification_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ADD CONSTRAINT `fk_supplier_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`scorecard` ADD CONSTRAINT `fk_supplier_scorecard_primary_scorecard_employee_id` FOREIGN KEY (`primary_scorecard_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding` ADD CONSTRAINT `fk_supplier_supplier_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`supplier_certification` ADD CONSTRAINT `fk_supplier_supplier_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ADD CONSTRAINT `fk_supplier_risk_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`risk_rating` ADD CONSTRAINT `fk_supplier_risk_rating_primary_risk_employee_id` FOREIGN KEY (`primary_risk_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ADD CONSTRAINT `fk_supplier_development_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`development_plan` ADD CONSTRAINT `fk_supplier_development_plan_primary_assigned_development_engineer_employee_id` FOREIGN KEY (`primary_assigned_development_engineer_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ADD CONSTRAINT `fk_supplier_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`corrective_action` ADD CONSTRAINT `fk_supplier_corrective_action_primary_corrective_employee_id` FOREIGN KEY (`primary_corrective_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`tooling_asset` ADD CONSTRAINT `fk_supplier_tooling_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`change_notification` ADD CONSTRAINT `fk_supplier_change_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> asset (1 constraint(s)) =========
-- Requires: supply schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ADD CONSTRAINT `fk_supply_supply_plant_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);

-- ========= supply --> automation (3 constraint(s)) =========
-- Requires: supply schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_safety_function_id` FOREIGN KEY (`safety_function_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`safety_function`(`safety_function_id`);

-- ========= supply --> billing (1 constraint(s)) =========
-- Requires: supply schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ADD CONSTRAINT `fk_supply_inventory_position_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice_line`(`invoice_line_id`);

-- ========= supply --> compliance (4 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= supply --> customer (4 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= supply --> engineering (3 constraint(s)) =========
-- Requires: supply schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);

-- ========= supply --> finance (5 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ADD CONSTRAINT `fk_supply_inventory_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supply --> inventory (15 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ADD CONSTRAINT `fk_supply_aps_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ADD CONSTRAINT `fk_supply_supply_safety_stock_policy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ADD CONSTRAINT `fk_supply_inventory_position_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ADD CONSTRAINT `fk_supply_inventory_position_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ADD CONSTRAINT `fk_supply_moq_constraint_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ADD CONSTRAINT `fk_supply_planning_parameter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= supply --> logistics (1 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);

-- ========= supply --> order (3 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);

-- ========= supply --> product (15 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ADD CONSTRAINT `fk_supply_aps_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ADD CONSTRAINT `fk_supply_supply_safety_stock_policy_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ADD CONSTRAINT `fk_supply_inventory_position_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ADD CONSTRAINT `fk_supply_moq_constraint_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ADD CONSTRAINT `fk_supply_planning_parameter_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= supply --> production (5 constraint(s)) =========
-- Requires: supply schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ADD CONSTRAINT `fk_supply_aps_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ADD CONSTRAINT `fk_supply_aps_schedule_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ADD CONSTRAINT `fk_supply_aps_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= supply --> quality (2 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= supply --> sales (3 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`forecast`(`forecast_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);

-- ========= supply --> service (4 constraint(s)) =========
-- Requires: supply schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ADD CONSTRAINT `fk_supply_inventory_position_service_warranty_id` FOREIGN KEY (`service_warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_warranty`(`service_warranty_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ADD CONSTRAINT `fk_supply_planning_calendar_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`holiday_calendar`(`holiday_calendar_id`);

-- ========= supply --> supplier (10 constraint(s)) =========
-- Requires: supply schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`site`(`site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ADD CONSTRAINT `fk_supply_supply_safety_stock_policy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ADD CONSTRAINT `fk_supply_moq_constraint_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

-- ========= supply --> workforce (16 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ADD CONSTRAINT `fk_supply_aps_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ADD CONSTRAINT `fk_supply_moq_constraint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ADD CONSTRAINT `fk_supply_moq_constraint_moq_last_modified_by_user_employee_id` FOREIGN KEY (`moq_last_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_tertiary_demand_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_demand_last_modified_by_user_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ADD CONSTRAINT `fk_supply_planning_parameter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> asset (6 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);

-- ========= workforce --> automation (3 constraint(s)) =========
-- Requires: workforce schema, automation schema
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);

-- ========= workforce --> compliance (2 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= workforce --> finance (8 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> production (5 constraint(s)) =========
-- Requires: workforce schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_production_run_id` FOREIGN KEY (`production_run_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_run`(`production_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ADD CONSTRAINT `fk_workforce_shift_pattern_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);

-- ========= workforce --> supplier (1 constraint(s)) =========
-- Requires: workforce schema, supplier schema
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_manufacturing_v1`.`supplier`.`supplier`(`supplier_id`);

