-- Cross-Domain Foreign Keys for Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:10
-- Total cross-domain FK constraints: 632
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, customer, engineering, inventory, order, procurement, product, production, quality, sales, service, supply

-- ========= asset --> billing (1 constraint(s)) =========
-- Requires: asset schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ADD CONSTRAINT `fk_asset_asset_plant_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= asset --> customer (16 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= asset --> engineering (14 constraint(s)) =========
-- Requires: asset schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= asset --> inventory (5 constraint(s)) =========
-- Requires: asset schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ADD CONSTRAINT `fk_asset_asset_plant_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);

-- ========= asset --> order (2 constraint(s)) =========
-- Requires: asset schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);

-- ========= asset --> product (8 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`certification`(`certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_lifecycle_stage_id` FOREIGN KEY (`lifecycle_stage_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`lifecycle_stage`(`lifecycle_stage_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= asset --> production (2 constraint(s)) =========
-- Requires: asset schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);

-- ========= asset --> quality (1 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= asset --> sales (1 constraint(s)) =========
-- Requires: asset schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= asset --> service (4 constraint(s)) =========
-- Requires: asset schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);

-- ========= asset --> supply (2 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= billing --> asset (5 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);

-- ========= billing --> customer (8 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ADD CONSTRAINT `fk_billing_credit_limit_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);

-- ========= billing --> engineering (5 constraint(s)) =========
-- Requires: billing schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);

-- ========= billing --> inventory (3 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= billing --> order (5 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_delivery_item_id` FOREIGN KEY (`delivery_item_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery_item`(`delivery_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);

-- ========= billing --> product (4 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ADD CONSTRAINT `fk_billing_tax_determination_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= billing --> production (1 constraint(s)) =========
-- Requires: billing schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_order_confirmation_id` FOREIGN KEY (`order_confirmation_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`order_confirmation`(`order_confirmation_id`);

-- ========= billing --> quality (4 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_compliance_test_id` FOREIGN KEY (`compliance_test_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`compliance_test`(`compliance_test_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= billing --> sales (6 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);

-- ========= billing --> service (4 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`warranty`(`warranty_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_part_consumption_id` FOREIGN KEY (`part_consumption_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`part_consumption`(`part_consumption_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);

-- ========= billing --> supply (1 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`tax_determination` ADD CONSTRAINT `fk_billing_tax_determination_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);

-- ========= customer --> order (1 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= customer --> product (2 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= customer --> sales (6 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);

-- ========= customer --> service (3 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);

-- ========= engineering --> asset (2 constraint(s)) =========
-- Requires: engineering schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= engineering --> customer (11 constraint(s)) =========
-- Requires: engineering schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= engineering --> inventory (5 constraint(s)) =========
-- Requires: engineering schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= engineering --> product (16 constraint(s)) =========
-- Requires: engineering schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`certification`(`certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`certification`(`certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);

-- ========= engineering --> production (1 constraint(s)) =========
-- Requires: engineering schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= engineering --> quality (1 constraint(s)) =========
-- Requires: engineering schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`capa`(`capa_id`);

-- ========= inventory --> asset (2 constraint(s)) =========
-- Requires: inventory schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);

-- ========= inventory --> customer (6 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= inventory --> order (3 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= inventory --> procurement (3 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> product (4 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= inventory --> production (2 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_run_id` FOREIGN KEY (`run_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`run`(`run_id`);

-- ========= inventory --> quality (3 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= inventory --> sales (1 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= inventory --> service (1 constraint(s)) =========
-- Requires: inventory schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);

-- ========= inventory --> supply (4 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= order --> customer (11 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= order --> engineering (7 constraint(s)) =========
-- Requires: order schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= order --> inventory (9 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= order --> product (7 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= order --> quality (4 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_inspection_result_id` FOREIGN KEY (`inspection_result_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_result`(`inspection_result_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= order --> sales (3 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= order --> service (4 constraint(s)) =========
-- Requires: order schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`warranty`(`warranty_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);

-- ========= order --> supply (1 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_capacity_plan_id` FOREIGN KEY (`capacity_plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`capacity_plan`(`capacity_plan_id`);

-- ========= procurement --> asset (12 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);

-- ========= procurement --> customer (5 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);

-- ========= procurement --> engineering (9 constraint(s)) =========
-- Requires: procurement schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= procurement --> inventory (9 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= procurement --> order (1 constraint(s)) =========
-- Requires: procurement schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);

-- ========= procurement --> product (9 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= procurement --> sales (1 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= procurement --> service (2 constraint(s)) =========
-- Requires: procurement schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);

-- ========= procurement --> supply (12 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_quotation` ADD CONSTRAINT `fk_procurement_supplier_quotation_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);

-- ========= product --> engineering (2 constraint(s)) =========
-- Requires: product schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);

-- ========= product --> inventory (1 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= product --> production (1 constraint(s)) =========
-- Requires: product schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= production --> asset (9 constraint(s)) =========
-- Requires: production schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ADD CONSTRAINT `fk_production_production_plant_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);

-- ========= production --> billing (1 constraint(s)) =========
-- Requires: production schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= production --> customer (6 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= production --> engineering (17 constraint(s)) =========
-- Requires: production schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= production --> inventory (18 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= production --> order (5 constraint(s)) =========
-- Requires: production schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);

-- ========= production --> procurement (2 constraint(s)) =========
-- Requires: production schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);

-- ========= production --> product (10 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_lifecycle_stage_id` FOREIGN KEY (`lifecycle_stage_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`lifecycle_stage`(`lifecycle_stage_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= production --> quality (4 constraint(s)) =========
-- Requires: production schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= production --> sales (4 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= production --> supply (5 constraint(s)) =========
-- Requires: production schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);

-- ========= quality --> asset (10 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= quality --> customer (20 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= quality --> engineering (15 constraint(s)) =========
-- Requires: quality schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= quality --> inventory (10 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= quality --> order (8 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);

-- ========= quality --> procurement (7 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= quality --> product (14 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`certification`(`certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);

-- ========= quality --> production (14 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_wip_lot_id` FOREIGN KEY (`wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_run_id` FOREIGN KEY (`run_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`run`(`run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_wip_lot_id` FOREIGN KEY (`wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= quality --> sales (3 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= quality --> service (9 constraint(s)) =========
-- Requires: quality schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`compliance_test` ADD CONSTRAINT `fk_quality_compliance_test_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);

-- ========= quality --> supply (1 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);

-- ========= sales --> asset (1 constraint(s)) =========
-- Requires: sales schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= sales --> billing (1 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`credit_limit`(`credit_limit_id`);

-- ========= sales --> customer (16 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);

-- ========= sales --> engineering (6 constraint(s)) =========
-- Requires: sales schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= sales --> inventory (5 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= sales --> product (13 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`certification`(`certification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_tertiary_price_product_catalog_entry_id` FOREIGN KEY (`tertiary_price_product_catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= sales --> service (2 constraint(s)) =========
-- Requires: sales schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);

-- ========= service --> asset (6 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);

-- ========= service --> customer (19 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ADD CONSTRAINT `fk_service_entitlement_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ADD CONSTRAINT `fk_service_entitlement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ADD CONSTRAINT `fk_service_entitlement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ADD CONSTRAINT `fk_service_entitlement_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);

-- ========= service --> engineering (11 constraint(s)) =========
-- Requires: service schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= service --> inventory (7 constraint(s)) =========
-- Requires: service schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= service --> order (12 constraint(s)) =========
-- Requires: service schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ADD CONSTRAINT `fk_service_entitlement_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`goods_issue`(`goods_issue_id`);

-- ========= service --> procurement (2 constraint(s)) =========
-- Requires: service schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= service --> product (7 constraint(s)) =========
-- Requires: service schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ADD CONSTRAINT `fk_service_entitlement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= service --> production (1 constraint(s)) =========
-- Requires: service schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_run_id` FOREIGN KEY (`run_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`run`(`run_id`);

-- ========= service --> sales (3 constraint(s)) =========
-- Requires: service schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ADD CONSTRAINT `fk_service_service_contract_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ADD CONSTRAINT `fk_service_warranty_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= service --> supply (2 constraint(s)) =========
-- Requires: service schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= supply --> customer (5 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= supply --> engineering (7 constraint(s)) =========
-- Requires: supply schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= supply --> inventory (7 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= supply --> order (1 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ADD CONSTRAINT `fk_supply_supply_plant_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);

-- ========= supply --> product (11 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= supply --> production (2 constraint(s)) =========
-- Requires: supply schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);

-- ========= supply --> sales (2 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);

-- ========= supply --> service (2 constraint(s)) =========
-- Requires: supply schema, service schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);

