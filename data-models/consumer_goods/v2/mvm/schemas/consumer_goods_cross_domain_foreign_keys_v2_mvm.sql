-- Cross-Domain Foreign Keys for Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:19
-- Total cross-domain FK constraints: 493
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: consumer, distribution, finance, logistics, manufacturing, marketing, procurement, product, quality, sales, supply

-- ========= consumer --> distribution (5 constraint(s)) =========
-- Requires: consumer schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= consumer --> finance (11 constraint(s)) =========
-- Requires: consumer schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= consumer --> marketing (11 constraint(s)) =========
-- Requires: consumer schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ADD CONSTRAINT `fk_consumer_shopper_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ADD CONSTRAINT `fk_consumer_household_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ADD CONSTRAINT `fk_consumer_segment_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= consumer --> procurement (1 constraint(s)) =========
-- Requires: consumer schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= consumer --> product (3 constraint(s)) =========
-- Requires: consumer schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= consumer --> sales (9 constraint(s)) =========
-- Requires: consumer schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ADD CONSTRAINT `fk_consumer_shopper_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);

-- ========= consumer --> supply (4 constraint(s)) =========
-- Requires: consumer schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= distribution --> finance (12 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= distribution --> logistics (6 constraint(s)) =========
-- Requires: distribution schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);

-- ========= distribution --> manufacturing (3 constraint(s)) =========
-- Requires: distribution schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= distribution --> marketing (1 constraint(s)) =========
-- Requires: distribution schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= distribution --> procurement (5 constraint(s)) =========
-- Requires: distribution schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= distribution --> product (8 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_label_spec_id` FOREIGN KEY (`label_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`label_spec`(`label_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= distribution --> quality (4 constraint(s)) =========
-- Requires: distribution schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`usage_decision`(`usage_decision_id`);

-- ========= distribution --> sales (6 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_return_order_id` FOREIGN KEY (`return_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`return_order`(`return_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);

-- ========= distribution --> supply (3 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_lane`(`network_lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_inventory_policy_id` FOREIGN KEY (`inventory_policy_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`inventory_policy`(`inventory_policy_id`);

-- ========= finance --> manufacturing (1 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= finance --> procurement (10 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= finance --> product (1 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= finance --> sales (5 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);

-- ========= logistics --> consumer (5 constraint(s)) =========
-- Requires: logistics schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_dtc_order_line_id` FOREIGN KEY (`dtc_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line`(`dtc_order_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_dtc_order_id` FOREIGN KEY (`dtc_order_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order`(`dtc_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= logistics --> distribution (11 constraint(s)) =========
-- Requires: logistics schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_origin_distribution_facility_id` FOREIGN KEY (`origin_distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_primary_logistics_distribution_facility_id` FOREIGN KEY (`primary_logistics_distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_inbound_receipt_line_id` FOREIGN KEY (`inbound_receipt_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line`(`inbound_receipt_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= logistics --> finance (10 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= logistics --> manufacturing (3 constraint(s)) =========
-- Requires: logistics schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= logistics --> procurement (5 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= logistics --> product (2 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_label_spec_id` FOREIGN KEY (`label_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`label_spec`(`label_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= logistics --> quality (2 constraint(s)) =========
-- Requires: logistics schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= logistics --> sales (12 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_return_order_id` FOREIGN KEY (`return_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`return_order`(`return_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= logistics --> supply (5 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_primary_lane_supply_network_node_id` FOREIGN KEY (`primary_lane_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_primary_shipment_network_node_id` FOREIGN KEY (`primary_shipment_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= manufacturing --> consumer (1 constraint(s)) =========
-- Requires: manufacturing schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_dtc_order_id` FOREIGN KEY (`dtc_order_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order`(`dtc_order_id`);

-- ========= manufacturing --> distribution (1 constraint(s)) =========
-- Requires: manufacturing schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= manufacturing --> finance (10 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= manufacturing --> marketing (6 constraint(s)) =========
-- Requires: manufacturing schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= manufacturing --> procurement (2 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);

-- ========= manufacturing --> product (11 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> quality (4 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);

-- ========= manufacturing --> sales (5 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);

-- ========= manufacturing --> supply (7 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);

-- ========= marketing --> consumer (1 constraint(s)) =========
-- Requires: marketing schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);

-- ========= marketing --> finance (9 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= marketing --> procurement (4 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ADD CONSTRAINT `fk_marketing_agency_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ADD CONSTRAINT `fk_marketing_agency_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= marketing --> product (12 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);

-- ========= marketing --> sales (1 constraint(s)) =========
-- Requires: marketing schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= procurement --> finance (19 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= procurement --> logistics (1 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= procurement --> manufacturing (10 constraint(s)) =========
-- Requires: procurement schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= procurement --> marketing (7 constraint(s)) =========
-- Requires: procurement schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`budget`(`budget_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= procurement --> product (11 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);

-- ========= procurement --> sales (1 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);

-- ========= procurement --> supply (4 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= product --> consumer (4 constraint(s)) =========
-- Requires: product schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_registration_product_shopper_id` FOREIGN KEY (`registration_product_shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= product --> finance (11 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ADD CONSTRAINT `fk_product_category_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> manufacturing (5 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= product --> marketing (2 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= product --> procurement (11 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> quality (5 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`batch_release`(`batch_release_id`);

-- ========= product --> sales (5 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);

-- ========= product --> supply (1 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= quality --> consumer (1 constraint(s)) =========
-- Requires: quality schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= quality --> distribution (9 constraint(s)) =========
-- Requires: quality schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inbound_receipt_line_id` FOREIGN KEY (`inbound_receipt_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line`(`inbound_receipt_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`(`outbound_order_line_id`);

-- ========= quality --> finance (8 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> logistics (3 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= quality --> manufacturing (9 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= quality --> marketing (3 constraint(s)) =========
-- Requires: quality schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= quality --> procurement (18 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);

-- ========= quality --> product (27 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_label_spec_id` FOREIGN KEY (`label_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`label_spec`(`label_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_label_spec_id` FOREIGN KEY (`label_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`label_spec`(`label_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_specification_sku_id` FOREIGN KEY (`specification_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= quality --> sales (4 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= sales --> distribution (3 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= sales --> finance (14 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= sales --> manufacturing (1 constraint(s)) =========
-- Requires: sales schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= sales --> marketing (1 constraint(s)) =========
-- Requires: sales schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= sales --> procurement (3 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= sales --> product (5 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= sales --> supply (1 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= supply --> finance (13 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= supply --> logistics (7 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);

-- ========= supply --> marketing (5 constraint(s)) =========
-- Requires: supply schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= supply --> procurement (2 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= supply --> product (16 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= supply --> quality (1 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);

-- ========= supply --> sales (4 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);

