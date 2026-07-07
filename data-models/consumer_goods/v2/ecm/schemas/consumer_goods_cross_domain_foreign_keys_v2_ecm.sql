-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:14
-- Total cross-domain FK constraints: 1330
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: consumer, customer, distribution, finance, inventory, logistics, manufacturing, marketing, procurement, product, promotion, quality, regulatory, research, sales, shared, supply, sustainability, workforce

-- ========= consumer --> customer (1 constraint(s)) =========
-- Requires: consumer schema, customer schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= consumer --> distribution (4 constraint(s)) =========
-- Requires: consumer schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= consumer --> finance (5 constraint(s)) =========
-- Requires: consumer schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ADD CONSTRAINT `fk_consumer_loyalty_program_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= consumer --> inventory (3 constraint(s)) =========
-- Requires: consumer schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= consumer --> logistics (4 constraint(s)) =========
-- Requires: consumer schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= consumer --> marketing (23 constraint(s)) =========
-- Requires: consumer schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ADD CONSTRAINT `fk_consumer_segment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ADD CONSTRAINT `fk_consumer_cltv_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ADD CONSTRAINT `fk_consumer_communication_preference_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_market_research_study_id` FOREIGN KEY (`market_research_study_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`market_research_study`(`market_research_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ADD CONSTRAINT `fk_consumer_loyalty_program_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ADD CONSTRAINT `fk_consumer_loyalty_program_loyalty_owning_marketing_brand_id` FOREIGN KEY (`loyalty_owning_marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ADD CONSTRAINT `fk_consumer_preference_center_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ADD CONSTRAINT `fk_consumer_panel_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ADD CONSTRAINT `fk_consumer_survey_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ADD CONSTRAINT `fk_consumer_survey_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= consumer --> procurement (1 constraint(s)) =========
-- Requires: consumer schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= consumer --> product (6 constraint(s)) =========
-- Requires: consumer schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= consumer --> promotion (2 constraint(s)) =========
-- Requires: consumer schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= consumer --> quality (2 constraint(s)) =========
-- Requires: consumer schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);

-- ========= consumer --> regulatory (8 constraint(s)) =========
-- Requires: consumer schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ADD CONSTRAINT `fk_consumer_loyalty_program_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ADD CONSTRAINT `fk_consumer_consent_session_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ADD CONSTRAINT `fk_consumer_preference_center_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= consumer --> research (2 constraint(s)) =========
-- Requires: consumer schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_consumer_test_id` FOREIGN KEY (`consumer_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`consumer_test`(`consumer_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= consumer --> sales (11 constraint(s)) =========
-- Requires: consumer schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_account_call_id` FOREIGN KEY (`account_call_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_call`(`account_call_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ADD CONSTRAINT `fk_consumer_interaction_session_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ADD CONSTRAINT `fk_consumer_interaction_session_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);

-- ========= consumer --> supply (1 constraint(s)) =========
-- Requires: consumer schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_atp_record_id` FOREIGN KEY (`atp_record_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`atp_record`(`atp_record_id`);

-- ========= consumer --> sustainability (2 constraint(s)) =========
-- Requires: consumer schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident`(`environmental_incident_id`);

-- ========= consumer --> workforce (13 constraint(s)) =========
-- Requires: consumer schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ADD CONSTRAINT `fk_consumer_loyalty_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_data_employee_id` FOREIGN KEY (`data_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_data_handled_by_employee_id` FOREIGN KEY (`data_handled_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ADD CONSTRAINT `fk_consumer_panel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ADD CONSTRAINT `fk_consumer_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ADD CONSTRAINT `fk_consumer_interaction_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> sales (1 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ADD CONSTRAINT `fk_customer_channel_classification_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= distribution --> finance (4 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= distribution --> inventory (13 constraint(s)) =========
-- Requires: distribution schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ADD CONSTRAINT `fk_distribution_distribution_storage_location_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_inventory_replenishment_order_id` FOREIGN KEY (`inventory_replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order`(`inventory_replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_intransit_shipment_id` FOREIGN KEY (`intransit_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment`(`intransit_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_inventory_cycle_count_id` FOREIGN KEY (`inventory_cycle_count_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count`(`inventory_cycle_count_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`recall_event`(`recall_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= distribution --> logistics (16 constraint(s)) =========
-- Requires: distribution schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ADD CONSTRAINT `fk_distribution_dock_appointment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= distribution --> manufacturing (3 constraint(s)) =========
-- Requires: distribution schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= distribution --> marketing (2 constraint(s)) =========
-- Requires: distribution schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= distribution --> procurement (7 constraint(s)) =========
-- Requires: distribution schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ADD CONSTRAINT `fk_distribution_dock_appointment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= distribution --> product (9 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= distribution --> promotion (4 constraint(s)) =========
-- Requires: distribution schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= distribution --> regulatory (4 constraint(s)) =========
-- Requires: distribution schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);

-- ========= distribution --> research (2 constraint(s)) =========
-- Requires: distribution schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= distribution --> sales (13 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_outbound_sales_order_id` FOREIGN KEY (`outbound_sales_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_sales_dsd_route_id` FOREIGN KEY (`sales_dsd_route_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route`(`sales_dsd_route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_sales_dsd_delivery_id` FOREIGN KEY (`sales_dsd_delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery`(`sales_dsd_delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_return_order_id` FOREIGN KEY (`return_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`return_order`(`return_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= distribution --> supply (1 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= distribution --> sustainability (1 constraint(s)) =========
-- Requires: distribution schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ADD CONSTRAINT `fk_distribution_distribution_offset_allocation_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);

-- ========= distribution --> workforce (29 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_receiving_clerk_employee_id` FOREIGN KEY (`receiving_clerk_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_putaway_employee_id` FOREIGN KEY (`putaway_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_primary_pick_employee_id` FOREIGN KEY (`primary_pick_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_primary_pack_employee_id` FOREIGN KEY (`primary_pack_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_distribution_counted_by_employee_id` FOREIGN KEY (`distribution_counted_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_primary_distribution_counter_employee_id` FOREIGN KEY (`primary_distribution_counter_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_primary_distribution_employee_id` FOREIGN KEY (`primary_distribution_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_distribution_employee_id` FOREIGN KEY (`distribution_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ADD CONSTRAINT `fk_distribution_dock_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_primary_loading_supervisor_employee_id` FOREIGN KEY (`primary_loading_supervisor_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_receiving_clerk_employee_id` FOREIGN KEY (`receiving_clerk_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_returns_processed_by_employee_id` FOREIGN KEY (`returns_processed_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> manufacturing (3 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= finance --> marketing (1 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_marketing_budget_id` FOREIGN KEY (`marketing_budget_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_budget`(`marketing_budget_id`);

-- ========= finance --> procurement (6 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ADD CONSTRAINT `fk_finance_party_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= finance --> product (7 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_standard_sku_id` FOREIGN KEY (`standard_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= finance --> promotion (1 constraint(s)) =========
-- Requires: finance schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_promotion_accrual_id` FOREIGN KEY (`promotion_accrual_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual`(`promotion_accrual_id`);

-- ========= finance --> research (2 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= finance --> sales (11 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ADD CONSTRAINT `fk_finance_party_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= finance --> sustainability (3 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit`(`environmental_permit_id`);

-- ========= finance --> workforce (20 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_primary_finance_employee_id` FOREIGN KEY (`primary_finance_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_tertiary_finance_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_finance_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_sox_control_owner_employee_id` FOREIGN KEY (`sox_control_owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_tertiary_sox_tester_employee_id` FOREIGN KEY (`tertiary_sox_tester_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_created_by_user_employee_id` FOREIGN KEY (`payment_created_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_executed_by_employee_id` FOREIGN KEY (`payment_executed_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_revenue_contract_manager_employee_id` FOREIGN KEY (`revenue_contract_manager_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> distribution (3 constraint(s)) =========
-- Requires: inventory schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_distribution_cycle_count_id` FOREIGN KEY (`distribution_cycle_count_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count`(`distribution_cycle_count_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= inventory --> finance (12 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_material_ledger_posting_id` FOREIGN KEY (`material_ledger_posting_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting`(`material_ledger_posting_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= inventory --> logistics (5 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_third_party_provider_id` FOREIGN KEY (`third_party_provider_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`third_party_provider`(`third_party_provider_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= inventory --> manufacturing (8 constraint(s)) =========
-- Requires: inventory schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= inventory --> marketing (3 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= inventory --> procurement (8 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_procurement_vmi_agreement_id` FOREIGN KEY (`procurement_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement`(`procurement_vmi_agreement_id`);

-- ========= inventory --> product (15 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_bom_line_id` FOREIGN KEY (`bom_line_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= inventory --> promotion (1 constraint(s)) =========
-- Requires: inventory schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= inventory --> quality (2 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);

-- ========= inventory --> regulatory (4 constraint(s)) =========
-- Requires: inventory schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_dossier_id` FOREIGN KEY (`dossier_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`dossier`(`dossier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);

-- ========= inventory --> research (2 constraint(s)) =========
-- Requires: inventory schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);

-- ========= inventory --> sales (7 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= inventory --> supply (5 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_supply_replenishment_order_id` FOREIGN KEY (`supply_replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order`(`supply_replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_primary_intransit_network_node_id` FOREIGN KEY (`primary_intransit_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= inventory --> sustainability (2 constraint(s)) =========
-- Requires: inventory schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);

-- ========= inventory --> workforce (19 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_inventory_counted_by_employee_id` FOREIGN KEY (`inventory_counted_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_primary_inventory_counter_employee_id` FOREIGN KEY (`primary_inventory_counter_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_stock_placed_by_employee_id` FOREIGN KEY (`stock_placed_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_tertiary_inventory_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_inventory_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_stock_approved_by_employee_id` FOREIGN KEY (`stock_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_tertiary_stock_posted_by_user_employee_id` FOREIGN KEY (`tertiary_stock_posted_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= logistics --> distribution (9 constraint(s)) =========
-- Requires: logistics schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_origin_distribution_facility_id` FOREIGN KEY (`origin_distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_primary_logistics_distribution_facility_id` FOREIGN KEY (`primary_logistics_distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_primary_cold_distribution_facility_id` FOREIGN KEY (`primary_cold_distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ADD CONSTRAINT `fk_logistics_consolidation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= logistics --> finance (9 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= logistics --> inventory (2 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);

-- ========= logistics --> manufacturing (2 constraint(s)) =========
-- Requires: logistics schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= logistics --> marketing (1 constraint(s)) =========
-- Requires: logistics schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= logistics --> procurement (3 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ADD CONSTRAINT `fk_logistics_third_party_provider_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= logistics --> product (1 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= logistics --> promotion (2 constraint(s)) =========
-- Requires: logistics schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_event_sku_id` FOREIGN KEY (`event_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event_sku`(`event_sku_id`);

-- ========= logistics --> quality (1 constraint(s)) =========
-- Requires: logistics schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= logistics --> regulatory (4 constraint(s)) =========
-- Requires: logistics schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ADD CONSTRAINT `fk_logistics_transport_exception_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= logistics --> research (2 constraint(s)) =========
-- Requires: logistics schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_prototype_id` FOREIGN KEY (`prototype_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`prototype`(`prototype_id`);

-- ========= logistics --> sales (8 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= logistics --> shared (2 constraint(s)) =========
-- Requires: logistics schema, shared schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_origin_region_id` FOREIGN KEY (`origin_region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= logistics --> supply (6 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_primary_lane_supply_network_node_id` FOREIGN KEY (`primary_lane_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_shipment_network_node_id` FOREIGN KEY (`shipment_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_freight_supply_network_node_id` FOREIGN KEY (`freight_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= logistics --> sustainability (1 constraint(s)) =========
-- Requires: logistics schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`(`packaging_profile_id`);

-- ========= logistics --> workforce (10 constraint(s)) =========
-- Requires: logistics schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= manufacturing --> distribution (1 constraint(s)) =========
-- Requires: manufacturing schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= manufacturing --> finance (5 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= manufacturing --> inventory (1 constraint(s)) =========
-- Requires: manufacturing schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= manufacturing --> marketing (2 constraint(s)) =========
-- Requires: manufacturing schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= manufacturing --> procurement (3 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= manufacturing --> product (15 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_primary_manufacturing_sku_id` FOREIGN KEY (`primary_manufacturing_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_to_sku_id` FOREIGN KEY (`to_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> promotion (1 constraint(s)) =========
-- Requires: manufacturing schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= manufacturing --> quality (4 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);

-- ========= manufacturing --> regulatory (2 constraint(s)) =========
-- Requires: manufacturing schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);

-- ========= manufacturing --> research (2 constraint(s)) =========
-- Requires: manufacturing schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);

-- ========= manufacturing --> sales (5 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= manufacturing --> shared (1 constraint(s)) =========
-- Requires: manufacturing schema, shared schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= manufacturing --> supply (1 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= manufacturing --> sustainability (2 constraint(s)) =========
-- Requires: manufacturing schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);

-- ========= manufacturing --> workforce (21 constraint(s)) =========
-- Requires: manufacturing schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_tertiary_routing_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_routing_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_tertiary_yield_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_yield_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_gmp_reported_by_employee_id` FOREIGN KEY (`gmp_reported_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_primary_gmp_detected_by_employee_id` FOREIGN KEY (`primary_gmp_detected_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_confirmed_by_employee_id` FOREIGN KEY (`production_confirmed_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_employee_id` FOREIGN KEY (`production_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> consumer (4 constraint(s)) =========
-- Requires: marketing schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ADD CONSTRAINT `fk_marketing_event_participation_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= marketing --> distribution (2 constraint(s)) =========
-- Requires: marketing schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ADD CONSTRAINT `fk_marketing_marketing_offset_allocation_distribution_offset_allocation_id` FOREIGN KEY (`distribution_offset_allocation_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation`(`distribution_offset_allocation_id`);

-- ========= marketing --> finance (9 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ADD CONSTRAINT `fk_marketing_marketing_offset_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= marketing --> inventory (1 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= marketing --> procurement (2 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ADD CONSTRAINT `fk_marketing_agency_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= marketing --> product (20 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ADD CONSTRAINT `fk_marketing_sov_measurement_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_attribution_sku_id` FOREIGN KEY (`attribution_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ADD CONSTRAINT `fk_marketing_nielsen_panel_insight_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ADD CONSTRAINT `fk_marketing_nielsen_panel_insight_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= marketing --> promotion (1 constraint(s)) =========
-- Requires: marketing schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= marketing --> regulatory (2 constraint(s)) =========
-- Requires: marketing schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ADD CONSTRAINT `fk_marketing_campaign_submission_link_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`submission`(`submission_id`);

-- ========= marketing --> research (3 constraint(s)) =========
-- Requires: marketing schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= marketing --> sales (5 constraint(s)) =========
-- Requires: marketing schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ADD CONSTRAINT `fk_marketing_brand_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= marketing --> supply (1 constraint(s)) =========
-- Requires: marketing schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= marketing --> sustainability (5 constraint(s)) =========
-- Requires: marketing schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ADD CONSTRAINT `fk_marketing_marketing_offset_allocation_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);

-- ========= marketing --> workforce (27 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ADD CONSTRAINT `fk_marketing_consumer_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ADD CONSTRAINT `fk_marketing_sov_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ADD CONSTRAINT `fk_marketing_digital_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ADD CONSTRAINT `fk_marketing_nielsen_panel_insight_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ADD CONSTRAINT `fk_marketing_brand_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ADD CONSTRAINT `fk_marketing_brand_assignment_brand_employee_id` FOREIGN KEY (`brand_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ADD CONSTRAINT `fk_marketing_campaign_submission_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_campaign_employee_id` FOREIGN KEY (`campaign_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ADD CONSTRAINT `fk_marketing_event_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> distribution (1 constraint(s)) =========
-- Requires: procurement schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= procurement --> finance (10 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_requesting_cost_center_id` FOREIGN KEY (`purchase_requesting_cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= procurement --> inventory (3 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);

-- ========= procurement --> logistics (2 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= procurement --> manufacturing (6 constraint(s)) =========
-- Requires: procurement schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= procurement --> marketing (1 constraint(s)) =========
-- Requires: procurement schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= procurement --> product (7 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);

-- ========= procurement --> regulatory (6 constraint(s)) =========
-- Requires: procurement schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`sds`(`sds_id`);

-- ========= procurement --> research (7 constraint(s)) =========
-- Requires: procurement schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= procurement --> sales (2 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ADD CONSTRAINT `fk_procurement_vmi_agreement_type_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);

-- ========= procurement --> supply (5 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= procurement --> workforce (18 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rfq_buyer_employee_id` FOREIGN KEY (`rfq_buyer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_tertiary_rfq_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_rfq_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_requested_by_employee_id` FOREIGN KEY (`purchase_requested_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_created_by_employee_id` FOREIGN KEY (`purchase_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_primary_sourcing_employee_id` FOREIGN KEY (`primary_sourcing_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= product --> consumer (2 constraint(s)) =========
-- Requires: product schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ADD CONSTRAINT `fk_product_product_registration_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ADD CONSTRAINT `fk_product_product_registration_product_shopper_id` FOREIGN KEY (`product_shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= product --> distribution (2 constraint(s)) =========
-- Requires: product schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= product --> finance (3 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= product --> inventory (1 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_inventory_vmi_agreement_id` FOREIGN KEY (`inventory_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement`(`inventory_vmi_agreement_id`);

-- ========= product --> logistics (4 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_primary_carrier_contract_id` FOREIGN KEY (`primary_carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);

-- ========= product --> manufacturing (4 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= product --> marketing (3 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_sku_owning_marketing_brand_id` FOREIGN KEY (`sku_owning_marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= product --> procurement (9 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> regulatory (3 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ADD CONSTRAINT `fk_product_product_formulation_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_regulatory_claim_id` FOREIGN KEY (`regulatory_claim_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim`(`regulatory_claim_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ADD CONSTRAINT `fk_product_product_registration_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);

-- ========= product --> research (9 constraint(s)) =========
-- Requires: product schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_innovation_brief_id` FOREIGN KEY (`innovation_brief_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`innovation_brief`(`innovation_brief_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ADD CONSTRAINT `fk_product_product_formulation_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ADD CONSTRAINT `fk_product_product_formulation_ingredient_raw_material_spec_id` FOREIGN KEY (`raw_material_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`raw_material_spec`(`raw_material_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ADD CONSTRAINT `fk_product_product_formulation_ingredient_research_formulation_ingredient_id` FOREIGN KEY (`research_formulation_ingredient_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient`(`research_formulation_ingredient_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_research_packaging_spec_id` FOREIGN KEY (`research_packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_packaging_spec`(`research_packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_claim_substantiation_id` FOREIGN KEY (`claim_substantiation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`claim_substantiation`(`claim_substantiation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_raw_material_spec_id` FOREIGN KEY (`raw_material_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`raw_material_spec`(`raw_material_spec_id`);

-- ========= product --> sales (20 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ADD CONSTRAINT `fk_product_product_formulation_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ADD CONSTRAINT `fk_product_product_formulation_ingredient_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ADD CONSTRAINT `fk_product_sku_substitution_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ADD CONSTRAINT `fk_product_pack_hierarchy_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ADD CONSTRAINT `fk_product_product_registration_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_customer_vmi_agreement_id` FOREIGN KEY (`customer_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement`(`customer_vmi_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);

-- ========= product --> supply (1 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= product --> workforce (10 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ADD CONSTRAINT `fk_product_product_formulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ADD CONSTRAINT `fk_product_sku_substitution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= promotion --> consumer (3 constraint(s)) =========
-- Requires: promotion schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);

-- ========= promotion --> customer (6 constraint(s)) =========
-- Requires: promotion schema, customer schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= promotion --> finance (11 constraint(s)) =========
-- Requires: promotion schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_finance_accrual_id` FOREIGN KEY (`finance_accrual_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`finance_accrual`(`finance_accrual_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= promotion --> marketing (12 constraint(s)) =========
-- Requires: promotion schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_marketing_event_id` FOREIGN KEY (`marketing_event_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_event`(`marketing_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ADD CONSTRAINT `fk_promotion_flight_allocation_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign_flight`(`campaign_flight_id`);

-- ========= promotion --> procurement (1 constraint(s)) =========
-- Requires: promotion schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= promotion --> product (14 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_sku_group_id` FOREIGN KEY (`sku_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);

-- ========= promotion --> quality (1 constraint(s)) =========
-- Requires: promotion schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);

-- ========= promotion --> research (2 constraint(s)) =========
-- Requires: promotion schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= promotion --> sales (26 constraint(s)) =========
-- Requires: promotion schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_sales_deduction_id` FOREIGN KEY (`sales_deduction_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`sales_deduction`(`sales_deduction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_sales_rebate_agreement_id` FOREIGN KEY (`sales_rebate_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement`(`sales_rebate_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ADD CONSTRAINT `fk_promotion_rebate_settlement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ADD CONSTRAINT `fk_promotion_flight_allocation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= promotion --> sustainability (1 constraint(s)) =========
-- Requires: promotion schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);

-- ========= promotion --> workforce (27 constraint(s)) =========
-- Requires: promotion schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_owner_user_employee_id` FOREIGN KEY (`owner_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_primary_trade_employee_id` FOREIGN KEY (`primary_trade_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_tertiary_trade_created_by_employee_id` FOREIGN KEY (`tertiary_trade_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_tertiary_promotion_modified_by_user_employee_id` FOREIGN KEY (`tertiary_promotion_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_tertiary_deduction_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_deduction_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_tertiary_promotion_created_by_employee_id` FOREIGN KEY (`tertiary_promotion_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ADD CONSTRAINT `fk_promotion_rebate_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_tertiary_promoted_last_modified_by_employee_id` FOREIGN KEY (`tertiary_promoted_last_modified_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_tertiary_tpo_approved_by_user_employee_id` FOREIGN KEY (`tertiary_tpo_approved_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_tertiary_baseline_created_by_user_employee_id` FOREIGN KEY (`tertiary_baseline_created_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> consumer (1 constraint(s)) =========
-- Requires: quality schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= quality --> distribution (3 constraint(s)) =========
-- Requires: quality schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inbound_receipt_line_id` FOREIGN KEY (`inbound_receipt_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line`(`inbound_receipt_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`(`outbound_order_line_id`);

-- ========= quality --> finance (5 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (11 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= quality --> logistics (4 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_transport_exception_id` FOREIGN KEY (`transport_exception_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`transport_exception`(`transport_exception_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= quality --> manufacturing (17 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ADD CONSTRAINT `fk_quality_audit_program_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= quality --> marketing (3 constraint(s)) =========
-- Requires: quality schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= quality --> procurement (14 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= quality --> product (20 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_specification_sku_id` FOREIGN KEY (`specification_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= quality --> regulatory (6 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_action_id` FOREIGN KEY (`action_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`action`(`action_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_action_id` FOREIGN KEY (`action_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`action`(`action_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`change`(`change_id`);

-- ========= quality --> research (3 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= quality --> sales (2 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= quality --> sustainability (1 constraint(s)) =========
-- Requires: quality schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);

-- ========= quality --> workforce (57 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_primary_inspection_employee_id` FOREIGN KEY (`primary_inspection_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_tertiary_inspection_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_inspection_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_primary_inspection_employee_id` FOREIGN KEY (`primary_inspection_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_primary_usage_employee_id` FOREIGN KEY (`primary_usage_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_usage_decided_by_employee_id` FOREIGN KEY (`usage_decided_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_primary_nonconformance_closed_by_user_employee_id` FOREIGN KEY (`primary_nonconformance_closed_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_primary_capa_closed_by_employee_id` FOREIGN KEY (`primary_capa_closed_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_quaternary_capa_last_modified_by_employee_id` FOREIGN KEY (`quaternary_capa_last_modified_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_quinary_capa_verified_by_employee_id` FOREIGN KEY (`quinary_capa_verified_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_tertiary_capa_employee_id` FOREIGN KEY (`tertiary_capa_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_batch_released_by_employee_id` FOREIGN KEY (`batch_released_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_certificate_issued_by_employee_id` FOREIGN KEY (`certificate_issued_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_quality_study_director_employee_id` FOREIGN KEY (`quality_study_director_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_stability_tested_by_employee_id` FOREIGN KEY (`stability_tested_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_supplier_assessor_employee_id` FOREIGN KEY (`supplier_assessor_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_product_handled_by_employee_id` FOREIGN KEY (`product_handled_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_product_handler_employee_id` FOREIGN KEY (`product_handler_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_product_investigation_assigned_employee_id` FOREIGN KEY (`product_investigation_assigned_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_primary_specification_approved_by_employee_id` FOREIGN KEY (`primary_specification_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_lab_requestor_employee_id` FOREIGN KEY (`lab_requestor_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_notification_raised_by_employee_id` FOREIGN KEY (`notification_raised_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_notification_recipient_employee_id` FOREIGN KEY (`notification_recipient_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_primary_notification_closed_by_user_employee_id` FOREIGN KEY (`primary_notification_closed_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_change_initiator_employee_id` FOREIGN KEY (`change_initiator_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_change_requested_by_employee_id` FOREIGN KEY (`change_requested_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ADD CONSTRAINT `fk_quality_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ADD CONSTRAINT `fk_quality_audit_checklist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_laboratory_manager_employee_id` FOREIGN KEY (`laboratory_manager_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_sample_collected_by_employee_id` FOREIGN KEY (`sample_collected_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= regulatory --> finance (6 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= regulatory --> inventory (1 constraint(s)) =========
-- Requires: regulatory schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= regulatory --> logistics (1 constraint(s)) =========
-- Requires: regulatory schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= regulatory --> manufacturing (4 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ADD CONSTRAINT `fk_regulatory_epa_registration_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= regulatory --> procurement (1 constraint(s)) =========
-- Requires: regulatory schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ADD CONSTRAINT `fk_regulatory_reach_substance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= regulatory --> product (21 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_registration`(`product_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ADD CONSTRAINT `fk_regulatory_sds_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ADD CONSTRAINT `fk_regulatory_ifra_compliance_record_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ADD CONSTRAINT `fk_regulatory_ifra_compliance_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_product_claim_id` FOREIGN KEY (`product_claim_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_claim`(`product_claim_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ADD CONSTRAINT `fk_regulatory_epa_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= regulatory --> research (1 constraint(s)) =========
-- Requires: regulatory schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= regulatory --> shared (1 constraint(s)) =========
-- Requires: regulatory schema, shared schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction` ADD CONSTRAINT `fk_regulatory_jurisdiction_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= regulatory --> sustainability (1 constraint(s)) =========
-- Requires: regulatory schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);

-- ========= regulatory --> workforce (27 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_primary_contact_employee_id` FOREIGN KEY (`primary_contact_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ADD CONSTRAINT `fk_regulatory_sds_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_label_approved_by_employee_id` FOREIGN KEY (`label_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_compliance_responsible_owner_employee_id` FOREIGN KEY (`compliance_responsible_owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_primary_compliance_assessor_employee_id` FOREIGN KEY (`primary_compliance_assessor_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ADD CONSTRAINT `fk_regulatory_ifra_compliance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_surveillance_reported_by_employee_id` FOREIGN KEY (`surveillance_reported_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_product_responsible_employee_id` FOREIGN KEY (`product_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_regulatory_compliance_reviewer_employee_id` FOREIGN KEY (`regulatory_compliance_reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_primary_regulatory_action_responsible_party_employee_id` FOREIGN KEY (`primary_regulatory_action_responsible_party_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_cpsc_submitted_by_employee_id` FOREIGN KEY (`cpsc_submitted_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_change_requested_by_employee_id` FOREIGN KEY (`change_requested_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_primary_regulatory_change_responsible_owner_employee_id` FOREIGN KEY (`primary_regulatory_change_responsible_owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= research --> consumer (6 constraint(s)) =========
-- Requires: research schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ADD CONSTRAINT `fk_research_consumer_test_result_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ADD CONSTRAINT `fk_research_respondent_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ADD CONSTRAINT `fk_research_respondent_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ADD CONSTRAINT `fk_research_panel_session_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);

-- ========= research --> manufacturing (2 constraint(s)) =========
-- Requires: research schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= research --> marketing (2 constraint(s)) =========
-- Requires: research schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= research --> procurement (4 constraint(s)) =========
-- Requires: research schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ADD CONSTRAINT `fk_research_inci_library_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ADD CONSTRAINT `fk_research_raw_material_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ADD CONSTRAINT `fk_research_research_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ADD CONSTRAINT `fk_research_research_sample_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= research --> product (19 constraint(s)) =========
-- Requires: research schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ADD CONSTRAINT `fk_research_research_formulation_ingredient_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ADD CONSTRAINT `fk_research_research_formulation_ingredient_product_formulation_ingredient_id` FOREIGN KEY (`product_formulation_ingredient_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient`(`product_formulation_ingredient_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ADD CONSTRAINT `fk_research_research_stability_study_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ADD CONSTRAINT `fk_research_prototype_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ADD CONSTRAINT `fk_research_raw_material_spec_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ADD CONSTRAINT `fk_research_research_packaging_spec_product_packaging_spec_id` FOREIGN KEY (`product_packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_packaging_spec`(`product_packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);

-- ========= research --> quality (4 constraint(s)) =========
-- Requires: research schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ADD CONSTRAINT `fk_research_research_stability_study_quality_stability_study_id` FOREIGN KEY (`quality_stability_study_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`quality_stability_study`(`quality_stability_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`sample`(`sample_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_stability_result_id` FOREIGN KEY (`stability_result_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`stability_result`(`stability_result_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ADD CONSTRAINT `fk_research_research_sample_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`sample`(`sample_id`);

-- ========= research --> regulatory (1 constraint(s)) =========
-- Requires: research schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_regulatory_claim_id` FOREIGN KEY (`regulatory_claim_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim`(`regulatory_claim_id`);

-- ========= research --> sustainability (3 constraint(s)) =========
-- Requires: research schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ADD CONSTRAINT `fk_research_prototype_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);

-- ========= research --> workforce (35 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_rd_project_lead_employee_id` FOREIGN KEY (`rd_project_lead_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ADD CONSTRAINT `fk_research_stage_gate_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ADD CONSTRAINT `fk_research_stage_gate_milestone_primary_stage_employee_id` FOREIGN KEY (`primary_stage_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ADD CONSTRAINT `fk_research_stage_gate_milestone_tertiary_stage_modified_by_user_employee_id` FOREIGN KEY (`tertiary_stage_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_research_responsible_employee_id` FOREIGN KEY (`research_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ADD CONSTRAINT `fk_research_research_formulation_ingredient_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_primary_lab_employee_id` FOREIGN KEY (`primary_lab_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ADD CONSTRAINT `fk_research_research_stability_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ADD CONSTRAINT `fk_research_research_stability_study_research_study_lead_employee_id` FOREIGN KEY (`research_study_lead_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ADD CONSTRAINT `fk_research_sensory_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_primary_patent_employee_id` FOREIGN KEY (`primary_patent_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_tertiary_claim_regulatory_reviewer_employee_id` FOREIGN KEY (`tertiary_claim_regulatory_reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_primary_innovation_employee_id` FOREIGN KEY (`primary_innovation_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_tertiary_innovation_approved_by_employee_id` FOREIGN KEY (`tertiary_innovation_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_tertiary_quinary_innovation_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_quinary_innovation_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ADD CONSTRAINT `fk_research_raw_material_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ADD CONSTRAINT `fk_research_research_packaging_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_safety_responsible_employee_id` FOREIGN KEY (`safety_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ADD CONSTRAINT `fk_research_study_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ADD CONSTRAINT `fk_research_study_protocol_study_responsible_employee_id` FOREIGN KEY (`study_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ADD CONSTRAINT `fk_research_patent_family_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ADD CONSTRAINT `fk_research_panel_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> customer (1 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= sales --> distribution (7 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_distribution_dsd_route_id` FOREIGN KEY (`distribution_dsd_route_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route`(`distribution_dsd_route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_distribution_dsd_delivery_id` FOREIGN KEY (`distribution_dsd_delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery`(`distribution_dsd_delivery_id`);

-- ========= sales --> finance (7 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= sales --> inventory (1 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_inventory_vmi_agreement_id` FOREIGN KEY (`inventory_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement`(`inventory_vmi_agreement_id`);

-- ========= sales --> logistics (3 constraint(s)) =========
-- Requires: sales schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);

-- ========= sales --> manufacturing (2 constraint(s)) =========
-- Requires: sales schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= sales --> marketing (9 constraint(s)) =========
-- Requires: sales schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ADD CONSTRAINT `fk_sales_planogram_compliance_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= sales --> procurement (6 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ADD CONSTRAINT `fk_sales_customer_vmi_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_procurement_vmi_agreement_id` FOREIGN KEY (`procurement_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement`(`procurement_vmi_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= sales --> product (9 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ADD CONSTRAINT `fk_sales_account_assortment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= sales --> promotion (4 constraint(s)) =========
-- Requires: sales schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_promotion_deduction_id` FOREIGN KEY (`promotion_deduction_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction`(`promotion_deduction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= sales --> quality (1 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);

-- ========= sales --> regulatory (5 constraint(s)) =========
-- Requires: sales schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ADD CONSTRAINT `fk_sales_account_compliance_record_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ADD CONSTRAINT `fk_sales_account_compliance_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ADD CONSTRAINT `fk_sales_compliance_assignment_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);

-- ========= sales --> research (3 constraint(s)) =========
-- Requires: sales schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= sales --> shared (3 constraint(s)) =========
-- Requires: sales schema, shared schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= sales --> supply (3 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_lane`(`network_lane_id`);

-- ========= sales --> sustainability (5 constraint(s)) =========
-- Requires: sales schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ADD CONSTRAINT `fk_sales_account_assortment_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ADD CONSTRAINT `fk_sales_account_assortment_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ADD CONSTRAINT `fk_sales_account_pricing_agreement_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ADD CONSTRAINT `fk_sales_account_compliance_record_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_waste_generation_id` FOREIGN KEY (`waste_generation_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`waste_generation`(`waste_generation_id`);

-- ========= sales --> workforce (31 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ADD CONSTRAINT `fk_sales_customer_vmi_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ADD CONSTRAINT `fk_sales_customer_vmi_agreement_tertiary_customer_modified_by_user_employee_id` FOREIGN KEY (`tertiary_customer_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ADD CONSTRAINT `fk_sales_account_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ADD CONSTRAINT `fk_sales_account_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ADD CONSTRAINT `fk_sales_account_assortment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ADD CONSTRAINT `fk_sales_account_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ADD CONSTRAINT `fk_sales_account_pricing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ADD CONSTRAINT `fk_sales_account_pricing_agreement_primary_account_manager_employee_id` FOREIGN KEY (`primary_account_manager_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ADD CONSTRAINT `fk_sales_account_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ADD CONSTRAINT `fk_sales_account_compliance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ADD CONSTRAINT `fk_sales_planogram_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ADD CONSTRAINT `fk_sales_account_onboarding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ADD CONSTRAINT `fk_sales_compliance_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ADD CONSTRAINT `fk_sales_compliance_assignment_compliance_assigned_by_employee_id` FOREIGN KEY (`compliance_assigned_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ADD CONSTRAINT `fk_sales_account_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= shared --> regulatory (1 constraint(s)) =========
-- Requires: shared schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ADD CONSTRAINT `fk_shared_region_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= supply --> customer (2 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= supply --> distribution (3 constraint(s)) =========
-- Requires: supply schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= supply --> finance (6 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supply --> inventory (2 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_inventory_replenishment_order_id` FOREIGN KEY (`inventory_replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order`(`inventory_replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= supply --> logistics (8 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);

-- ========= supply --> manufacturing (5 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= supply --> marketing (2 constraint(s)) =========
-- Requires: supply schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= supply --> procurement (3 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= supply --> product (18 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ADD CONSTRAINT `fk_supply_forecast_accuracy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ADD CONSTRAINT `fk_supply_inventory_projection_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_primary_demand_sku_id` FOREIGN KEY (`primary_demand_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ADD CONSTRAINT `fk_supply_otif_target_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ADD CONSTRAINT `fk_supply_atp_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= supply --> promotion (4 constraint(s)) =========
-- Requires: supply schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= supply --> quality (1 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= supply --> regulatory (4 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);

-- ========= supply --> research (1 constraint(s)) =========
-- Requires: supply schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= supply --> sales (3 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ADD CONSTRAINT `fk_supply_otif_target_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= supply --> sustainability (2 constraint(s)) =========
-- Requires: supply schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);

-- ========= supply --> workforce (30 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_primary_forecast_employee_id` FOREIGN KEY (`primary_forecast_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_tertiary_forecast_modified_by_user_employee_id` FOREIGN KEY (`tertiary_forecast_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ADD CONSTRAINT `fk_supply_forecast_accuracy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_primary_sop_employee_id` FOREIGN KEY (`primary_sop_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_tertiary_quinary_sop_last_modified_by_employee_id` FOREIGN KEY (`tertiary_quinary_sop_last_modified_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_tertiary_sop_supply_planner_employee_id` FOREIGN KEY (`tertiary_sop_supply_planner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_tertiary_consensus_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_consensus_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_primary_risk_owner_employee_id` FOREIGN KEY (`primary_risk_owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_tertiary_risk_created_by_user_employee_id` FOREIGN KEY (`tertiary_risk_created_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_primary_planning_employee_id` FOREIGN KEY (`primary_planning_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_tertiary_planning_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_planning_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ADD CONSTRAINT `fk_supply_inventory_projection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ADD CONSTRAINT `fk_supply_otif_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ADD CONSTRAINT `fk_supply_planning_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ADD CONSTRAINT `fk_supply_planning_run_planning_triggered_by_employee_id` FOREIGN KEY (`planning_triggered_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ADD CONSTRAINT `fk_supply_drp_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= sustainability --> logistics (1 constraint(s)) =========
-- Requires: sustainability schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= sustainability --> manufacturing (10 constraint(s)) =========
-- Requires: sustainability schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ADD CONSTRAINT `fk_sustainability_environmental_permit_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ADD CONSTRAINT `fk_sustainability_energy_certificate_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ADD CONSTRAINT `fk_sustainability_esg_audit_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= sustainability --> procurement (8 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_sourcing_supplier_id` FOREIGN KEY (`sourcing_supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ADD CONSTRAINT `fk_sustainability_supplier_esg_eval_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ADD CONSTRAINT `fk_sustainability_deforestation_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ADD CONSTRAINT `fk_sustainability_esg_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= sustainability --> product (3 constraint(s)) =========
-- Requires: sustainability schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ADD CONSTRAINT `fk_sustainability_packaging_profile_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`product_lca` ADD CONSTRAINT `fk_sustainability_product_lca_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= sustainability --> quality (1 constraint(s)) =========
-- Requires: sustainability schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);

-- ========= sustainability --> regulatory (3 constraint(s)) =========
-- Requires: sustainability schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ADD CONSTRAINT `fk_sustainability_esg_commitment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ADD CONSTRAINT `fk_sustainability_environmental_permit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_surveillance_event_id` FOREIGN KEY (`surveillance_event_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event`(`surveillance_event_id`);

-- ========= sustainability --> research (1 constraint(s)) =========
-- Requires: sustainability schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_raw_material_spec_id` FOREIGN KEY (`raw_material_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`raw_material_spec`(`raw_material_spec_id`);

-- ========= sustainability --> shared (1 constraint(s)) =========
-- Requires: sustainability schema, shared schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= sustainability --> supply (1 constraint(s)) =========
-- Requires: sustainability schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= sustainability --> workforce (11 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ADD CONSTRAINT `fk_sustainability_circular_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ADD CONSTRAINT `fk_sustainability_supplier_esg_eval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ADD CONSTRAINT `fk_sustainability_social_impact_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ADD CONSTRAINT `fk_sustainability_esg_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_materiality_responsible_employee_id` FOREIGN KEY (`materiality_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> finance (4 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> manufacturing (3 constraint(s)) =========
-- Requires: workforce schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);

