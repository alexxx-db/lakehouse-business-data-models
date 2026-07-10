-- Cross-Domain Foreign Keys for Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-03 07:50:08
-- Total cross-domain FK constraints: 487
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, customer, engineering, inventory, logistics, order, procurement, product, production, quality, sales, supply

-- ========= asset --> customer (5 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= asset --> engineering (18 constraint(s)) =========
-- Requires: asset schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= asset --> inventory (3 constraint(s)) =========
-- Requires: asset schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= asset --> logistics (1 constraint(s)) =========
-- Requires: asset schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= asset --> order (2 constraint(s)) =========
-- Requires: asset schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);

-- ========= asset --> procurement (1 constraint(s)) =========
-- Requires: asset schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_info_record`(`purchase_info_record_id`);

-- ========= asset --> product (3 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= asset --> production (9 constraint(s)) =========
-- Requires: asset schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);

-- ========= asset --> quality (4 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);

-- ========= asset --> sales (2 constraint(s)) =========
-- Requires: asset schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= asset --> supply (2 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_safety_stock_policy_id` FOREIGN KEY (`safety_stock_policy_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`safety_stock_policy`(`safety_stock_policy_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= billing --> asset (2 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= billing --> customer (6 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`credit_limit` ADD CONSTRAINT `fk_billing_credit_limit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= billing --> inventory (4 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= billing --> logistics (2 constraint(s)) =========
-- Requires: billing schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_delivery_note_id` FOREIGN KEY (`delivery_note_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`delivery_note`(`delivery_note_id`);

-- ========= billing --> order (2 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= billing --> procurement (4 constraint(s)) =========
-- Requires: billing schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= billing --> product (1 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= billing --> quality (2 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= billing --> sales (3 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= customer --> billing (1 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);

-- ========= customer --> product (4 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= customer --> sales (8 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);

-- ========= engineering --> customer (4 constraint(s)) =========
-- Requires: engineering schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= engineering --> inventory (3 constraint(s)) =========
-- Requires: engineering schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= engineering --> product (1 constraint(s)) =========
-- Requires: engineering schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);

-- ========= inventory --> asset (1 constraint(s)) =========
-- Requires: inventory schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);

-- ========= inventory --> customer (6 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= inventory --> engineering (2 constraint(s)) =========
-- Requires: inventory schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= inventory --> logistics (5 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_delivery_note_id` FOREIGN KEY (`delivery_note_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`delivery_note`(`delivery_note_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`inbound_delivery`(`inbound_delivery_id`);

-- ========= inventory --> order (2 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= inventory --> procurement (6 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> product (2 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);

-- ========= inventory --> quality (3 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= inventory --> sales (1 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= inventory --> supply (2 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_safety_stock_policy_id` FOREIGN KEY (`safety_stock_policy_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`safety_stock_policy`(`safety_stock_policy_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= logistics --> customer (4 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);

-- ========= logistics --> engineering (1 constraint(s)) =========
-- Requires: logistics schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= logistics --> inventory (6 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= logistics --> order (1 constraint(s)) =========
-- Requires: logistics schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= logistics --> procurement (5 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_contract_release_order_id` FOREIGN KEY (`contract_release_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`contract_release_order`(`contract_release_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= logistics --> product (7 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= logistics --> quality (1 constraint(s)) =========
-- Requires: logistics schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= logistics --> sales (1 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= logistics --> supply (3 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);

-- ========= order --> asset (1 constraint(s)) =========
-- Requires: order schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);

-- ========= order --> customer (9 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ADD CONSTRAINT `fk_order_fulfillment_sla_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= order --> engineering (5 constraint(s)) =========
-- Requires: order schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= order --> inventory (19 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_movement`(`stock_movement_id`);

-- ========= order --> procurement (1 constraint(s)) =========
-- Requires: order schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= order --> product (4 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= order --> production (1 constraint(s)) =========
-- Requires: order schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= order --> sales (7 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ADD CONSTRAINT `fk_order_fulfillment_sla_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= procurement --> asset (1 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);

-- ========= procurement --> customer (1 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);

-- ========= procurement --> engineering (5 constraint(s)) =========
-- Requires: procurement schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_bom_line_id` FOREIGN KEY (`bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom_line`(`bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);

-- ========= procurement --> inventory (13 constraint(s)) =========
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
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ADD CONSTRAINT `fk_procurement_purchase_info_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= procurement --> logistics (2 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`inbound_delivery`(`inbound_delivery_id`);

-- ========= procurement --> product (6 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`contract_release_order` ADD CONSTRAINT `fk_procurement_contract_release_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= procurement --> supply (5 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= product --> engineering (3 constraint(s)) =========
-- Requires: product schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= production --> asset (5 constraint(s)) =========
-- Requires: production schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_asset_downtime_event_id` FOREIGN KEY (`asset_downtime_event_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_downtime_event`(`asset_downtime_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);

-- ========= production --> customer (3 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= production --> engineering (29 constraint(s)) =========
-- Requires: production schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_bom_line_id` FOREIGN KEY (`bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom_line`(`bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= production --> inventory (19 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= production --> logistics (1 constraint(s)) =========
-- Requires: production schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`inbound_delivery`(`inbound_delivery_id`);

-- ========= production --> order (3 constraint(s)) =========
-- Requires: production schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);

-- ========= production --> procurement (3 constraint(s)) =========
-- Requires: production schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= production --> product (8 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_lifecycle_stage_id` FOREIGN KEY (`lifecycle_stage_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`lifecycle_stage`(`lifecycle_stage_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);

-- ========= production --> quality (5 constraint(s)) =========
-- Requires: production schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= production --> sales (4 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= production --> supply (3 constraint(s)) =========
-- Requires: production schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);

-- ========= quality --> asset (4 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);

-- ========= quality --> billing (2 constraint(s)) =========
-- Requires: quality schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= quality --> customer (17 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);

-- ========= quality --> engineering (20 constraint(s)) =========
-- Requires: quality schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= quality --> inventory (11 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= quality --> logistics (3 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= quality --> order (4 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_rma_line_id` FOREIGN KEY (`rma_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma_line`(`rma_line_id`);

-- ========= quality --> procurement (9 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_contract_release_order_id` FOREIGN KEY (`contract_release_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`contract_release_order`(`contract_release_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= quality --> product (10 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`rma_disposition` ADD CONSTRAINT `fk_quality_rma_disposition_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= quality --> production (12 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_production_goods_receipt_id` FOREIGN KEY (`production_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_goods_receipt`(`production_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_resource_tool_id` FOREIGN KEY (`resource_tool_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`resource_tool`(`resource_tool_id`);

-- ========= quality --> sales (3 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`certificate_of_conformance` ADD CONSTRAINT `fk_quality_certificate_of_conformance_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= quality --> supply (4 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= sales --> asset (1 constraint(s)) =========
-- Requires: sales schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= sales --> billing (1 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= sales --> customer (7 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= sales --> engineering (6 constraint(s)) =========
-- Requires: sales schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);

-- ========= sales --> inventory (3 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= sales --> procurement (2 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= sales --> product (10 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= supply --> billing (1 constraint(s)) =========
-- Requires: supply schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);

-- ========= supply --> customer (4 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);

-- ========= supply --> engineering (8 constraint(s)) =========
-- Requires: supply schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= supply --> inventory (6 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= supply --> logistics (2 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);

-- ========= supply --> procurement (2 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_source_list_id` FOREIGN KEY (`source_list_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`source_list`(`source_list_id`);

-- ========= supply --> product (13 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_lifecycle_stage_id` FOREIGN KEY (`lifecycle_stage_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`lifecycle_stage`(`lifecycle_stage_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

