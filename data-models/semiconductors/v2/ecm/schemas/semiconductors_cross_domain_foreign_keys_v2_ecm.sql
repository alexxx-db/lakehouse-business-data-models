-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:51
-- Total cross-domain FK constraints: 1543
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: compliance, customer, design, equipment, fabrication, finance, inventory, invoice, order, packaging, process, product, quality, research, sales, shared, supply, test, workforce

-- ========= compliance --> customer (4 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ADD CONSTRAINT `fk_compliance_export_license_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ADD CONSTRAINT `fk_compliance_restricted_party_screening_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= compliance --> product (6 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ADD CONSTRAINT `fk_compliance_reach_svhc_declaration_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ADD CONSTRAINT `fk_compliance_conflict_minerals_declaration_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ADD CONSTRAINT `fk_compliance_declaration_substance_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= compliance --> shared (6 constraint(s)) =========
-- Requires: compliance schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ADD CONSTRAINT `fk_compliance_chips_act_obligation_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= compliance --> supply (3 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ADD CONSTRAINT `fk_compliance_reach_svhc_declaration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ADD CONSTRAINT `fk_compliance_substance_inventory_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ADD CONSTRAINT `fk_compliance_conflict_minerals_declaration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= compliance --> workforce (15 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ADD CONSTRAINT `fk_compliance_export_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ADD CONSTRAINT `fk_compliance_eccn_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ADD CONSTRAINT `fk_compliance_restricted_party_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ADD CONSTRAINT `fk_compliance_reach_svhc_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ADD CONSTRAINT `fk_compliance_substance_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ADD CONSTRAINT `fk_compliance_chips_act_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ADD CONSTRAINT `fk_compliance_conflict_minerals_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> compliance (2 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);

-- ========= customer --> design (1 constraint(s)) =========
-- Requires: customer schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= customer --> equipment (2 constraint(s)) =========
-- Requires: customer schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ADD CONSTRAINT `fk_customer_tool_allocation_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ADD CONSTRAINT `fk_customer_tool_allocation_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);

-- ========= customer --> fabrication (2 constraint(s)) =========
-- Requires: customer schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);

-- ========= customer --> finance (7 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= customer --> packaging (2 constraint(s)) =========
-- Requires: customer schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= customer --> product (12 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_authoritative_product_sample_request_id` FOREIGN KEY (`authoritative_product_sample_request_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_sample_request`(`product_sample_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_product_sample_request_id` FOREIGN KEY (`product_sample_request_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_sample_request`(`product_sample_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ADD CONSTRAINT `fk_customer_customer_ltb_notification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ADD CONSTRAINT `fk_customer_customer_ltb_notification_authoritative_product_ltb_notification_id` FOREIGN KEY (`authoritative_product_ltb_notification_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_ltb_notification`(`product_ltb_notification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ADD CONSTRAINT `fk_customer_customer_ltb_notification_product_ltb_notification_id` FOREIGN KEY (`product_ltb_notification_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_ltb_notification`(`product_ltb_notification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ADD CONSTRAINT `fk_customer_tool_allocation_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= customer --> research (2 constraint(s)) =========
-- Requires: customer schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= customer --> sales (9 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_authoritative_sales_design_win_id` FOREIGN KEY (`authoritative_sales_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_authoritative_sales_design_registration_id` FOREIGN KEY (`authoritative_sales_design_registration_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_design_registration`(`sales_design_registration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_sales_design_registration_id` FOREIGN KEY (`sales_design_registration_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_design_registration`(`sales_design_registration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ADD CONSTRAINT `fk_customer_distributor_agreement_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);

-- ========= customer --> shared (1 constraint(s)) =========
-- Requires: customer schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= customer --> supply (3 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= customer --> workforce (21 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_primary_qualification_owner_employee_id` FOREIGN KEY (`primary_qualification_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ADD CONSTRAINT `fk_customer_distributor_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_price_approved_by_employee_id` FOREIGN KEY (`price_approved_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ADD CONSTRAINT `fk_customer_customer_ltb_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ADD CONSTRAINT `fk_customer_tool_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ADD CONSTRAINT `fk_customer_tool_allocation_tool_approved_by_employee_id` FOREIGN KEY (`tool_approved_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= design --> compliance (3 constraint(s)) =========
-- Requires: design schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);

-- ========= design --> customer (2 constraint(s)) =========
-- Requires: design schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);

-- ========= design --> fabrication (1 constraint(s)) =========
-- Requires: design schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`mask_set`(`mask_set_id`);

-- ========= design --> finance (15 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ADD CONSTRAINT `fk_design_design_milestone_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= design --> packaging (1 constraint(s)) =========
-- Requires: design schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ADD CONSTRAINT `fk_design_package_compatibility_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= design --> process (2 constraint(s)) =========
-- Requires: design schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);

-- ========= design --> product (7 constraint(s)) =========
-- Requires: design schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ADD CONSTRAINT `fk_design_eda_tool_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`license_agreement`(`license_agreement_id`);

-- ========= design --> research (7 constraint(s)) =========
-- Requires: design schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_ip_core_development_id` FOREIGN KEY (`ip_core_development_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`ip_core_development`(`ip_core_development_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ADD CONSTRAINT `fk_design_design_milestone_research_milestone_id` FOREIGN KEY (`research_milestone_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_milestone`(`research_milestone_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= design --> supply (5 constraint(s)) =========
-- Requires: design schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ADD CONSTRAINT `fk_design_eda_tool_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= design --> workforce (21 constraint(s)) =========
-- Requires: design schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ADD CONSTRAINT `fk_design_rule_set_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ADD CONSTRAINT `fk_design_rule_set_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ADD CONSTRAINT `fk_design_design_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ADD CONSTRAINT `fk_design_package_compatibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_change_approved_by_employee_id` FOREIGN KEY (`change_approved_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_change_employee_id` FOREIGN KEY (`change_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_change_requested_by_employee_id` FOREIGN KEY (`change_requested_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_change_requestor_employee_id` FOREIGN KEY (`change_requestor_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_requester_id` FOREIGN KEY (`requester_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= equipment --> compliance (10 constraint(s)) =========
-- Requires: equipment schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ADD CONSTRAINT `fk_equipment_tool_installation_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ADD CONSTRAINT `fk_equipment_tool_capex_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ADD CONSTRAINT `fk_equipment_tool_safety_cert_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ADD CONSTRAINT `fk_equipment_part_substance_composition_declaration_substance_id` FOREIGN KEY (`declaration_substance_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`declaration_substance`(`declaration_substance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ADD CONSTRAINT `fk_equipment_part_substance_composition_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);

-- ========= equipment --> design (5 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= equipment --> fabrication (10 constraint(s)) =========
-- Requires: equipment schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ADD CONSTRAINT `fk_equipment_equipment_fab_fab_site_id` FOREIGN KEY (`fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);

-- ========= equipment --> finance (7 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ADD CONSTRAINT `fk_equipment_tool_capex_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`capex_request`(`capex_request_id`);

-- ========= equipment --> inventory (1 constraint(s)) =========
-- Requires: equipment schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= equipment --> process (7 constraint(s)) =========
-- Requires: equipment schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_change_notification_id` FOREIGN KEY (`change_notification_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`change_notification`(`change_notification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ADD CONSTRAINT `fk_equipment_equipment_site_map_process_site_map_id` FOREIGN KEY (`process_site_map_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_site_map`(`process_site_map_id`);

-- ========= equipment --> product (1 constraint(s)) =========
-- Requires: equipment schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);

-- ========= equipment --> quality (1 constraint(s)) =========
-- Requires: equipment schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_spc_chart_id` FOREIGN KEY (`spc_chart_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`spc_chart`(`spc_chart_id`);

-- ========= equipment --> research (1 constraint(s)) =========
-- Requires: equipment schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_process_integration_run_id` FOREIGN KEY (`process_integration_run_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`process_integration_run`(`process_integration_run_id`);

-- ========= equipment --> shared (2 constraint(s)) =========
-- Requires: equipment schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ADD CONSTRAINT `fk_equipment_sensor_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ADD CONSTRAINT `fk_equipment_equipment_fab_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= equipment --> supply (8 constraint(s)) =========
-- Requires: equipment schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ADD CONSTRAINT `fk_equipment_tool_warranty_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ADD CONSTRAINT `fk_equipment_tool_capex_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ADD CONSTRAINT `fk_equipment_tool_capex_tool_supplier_id` FOREIGN KEY (`tool_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ADD CONSTRAINT `fk_equipment_maintenance_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ADD CONSTRAINT `fk_equipment_maintenance_contract_maintenance_vendor_supplier_id` FOREIGN KEY (`maintenance_vendor_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= equipment --> workforce (36 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_tool_qualified_by_employee_id` FOREIGN KEY (`tool_qualified_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_pm_employee_id` FOREIGN KEY (`pm_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_maintenance_technician_employee_id` FOREIGN KEY (`maintenance_technician_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_tool_reported_by_employee_id` FOREIGN KEY (`tool_reported_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_calibration_employee_id` FOREIGN KEY (`calibration_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_calibration_technician_employee_id` FOREIGN KEY (`calibration_technician_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ADD CONSTRAINT `fk_equipment_tool_alarm_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ADD CONSTRAINT `fk_equipment_tool_alarm_tool_employee_id` FOREIGN KEY (`tool_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_equipment_employee_id` FOREIGN KEY (`equipment_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_recipe_operator_employee_id` FOREIGN KEY (`recipe_operator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_primary_spc_employee_id` FOREIGN KEY (`primary_spc_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_metrology_operator_employee_id` FOREIGN KEY (`metrology_operator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ADD CONSTRAINT `fk_equipment_tool_installation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ADD CONSTRAINT `fk_equipment_tool_installation_tool_installed_by_employee_id` FOREIGN KEY (`tool_installed_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ADD CONSTRAINT `fk_equipment_tool_installation_tool_installer_employee_id` FOREIGN KEY (`tool_installer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ADD CONSTRAINT `fk_equipment_tool_installation_tool_project_manager_employee_id` FOREIGN KEY (`tool_project_manager_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ADD CONSTRAINT `fk_equipment_tool_capex_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ADD CONSTRAINT `fk_equipment_tool_capex_tool_requested_by_employee_id` FOREIGN KEY (`tool_requested_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ADD CONSTRAINT `fk_equipment_tool_safety_cert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ADD CONSTRAINT `fk_equipment_equipment_fab_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ADD CONSTRAINT `fk_equipment_maintenance_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ADD CONSTRAINT `fk_equipment_maintenance_contract_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= fabrication --> compliance (1 constraint(s)) =========
-- Requires: fabrication schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);

-- ========= fabrication --> customer (4 constraint(s)) =========
-- Requires: fabrication schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= fabrication --> design (11 constraint(s)) =========
-- Requires: fabrication schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ADD CONSTRAINT `fk_fabrication_fabrication_process_flow_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ADD CONSTRAINT `fk_fabrication_fabrication_process_flow_rule_set_id` FOREIGN KEY (`rule_set_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`rule_set`(`rule_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ADD CONSTRAINT `fk_fabrication_reticle_set_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= fabrication --> equipment (10 constraint(s)) =========
-- Requires: fabrication schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_equipment_process_recipe_id` FOREIGN KEY (`equipment_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`(`equipment_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_equipment_fab_id` FOREIGN KEY (`equipment_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= fabrication --> finance (6 constraint(s)) =========
-- Requires: fabrication schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= fabrication --> inventory (3 constraint(s)) =========
-- Requires: fabrication schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_inventory_lot_hold_id` FOREIGN KEY (`inventory_lot_hold_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold`(`inventory_lot_hold_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_inventory_lot_genealogy_id` FOREIGN KEY (`inventory_lot_genealogy_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy`(`inventory_lot_genealogy_id`);

-- ========= fabrication --> order (2 constraint(s)) =========
-- Requires: fabrication schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= fabrication --> process (7 constraint(s)) =========
-- Requires: fabrication schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ADD CONSTRAINT `fk_fabrication_fabrication_process_flow_cooling_process_flow_id` FOREIGN KEY (`cooling_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`cooling_process_flow`(`cooling_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ADD CONSTRAINT `fk_fabrication_fabrication_technology_node_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ADD CONSTRAINT `fk_fabrication_spc_control_plan_process_spc_control_plan_id` FOREIGN KEY (`process_spc_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_spc_control_plan`(`process_spc_control_plan_id`);

-- ========= fabrication --> product (9 constraint(s)) =========
-- Requires: fabrication schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= fabrication --> quality (1 constraint(s)) =========
-- Requires: fabrication schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);

-- ========= fabrication --> research (2 constraint(s)) =========
-- Requires: fabrication schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ADD CONSTRAINT `fk_fabrication_fabrication_technology_node_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);

-- ========= fabrication --> shared (1 constraint(s)) =========
-- Requires: fabrication schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ADD CONSTRAINT `fk_fabrication_plant_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= fabrication --> supply (3 constraint(s)) =========
-- Requires: fabrication schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= fabrication --> workforce (11 constraint(s)) =========
-- Requires: fabrication schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ADD CONSTRAINT `fk_fabrication_fabrication_process_step_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ADD CONSTRAINT `fk_fabrication_fabrication_process_flow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_primary_fabrication_employee_id` FOREIGN KEY (`primary_fabrication_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> compliance (5 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= finance --> design (2 constraint(s)) =========
-- Requires: finance schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);

-- ========= finance --> equipment (2 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_equipment_fab_id` FOREIGN KEY (`equipment_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_equipment_fab_id` FOREIGN KEY (`equipment_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);

-- ========= finance --> fabrication (4 constraint(s)) =========
-- Requires: finance schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_fabrication_fab_id` FOREIGN KEY (`fabrication_fab_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab`(`fabrication_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);

-- ========= finance --> invoice (1 constraint(s)) =========
-- Requires: finance schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= finance --> order (3 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ADD CONSTRAINT `fk_finance_finance_nre_milestone_order_nre_milestone_id` FOREIGN KEY (`order_nre_milestone_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_nre_milestone`(`order_nre_milestone_id`);

-- ========= finance --> product (4 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= finance --> research (5 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ADD CONSTRAINT `fk_finance_finance_nre_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= finance --> sales (2 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_sales_nre_agreement_id` FOREIGN KEY (`sales_nre_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`(`sales_nre_agreement_id`);

-- ========= finance --> shared (1 constraint(s)) =========
-- Requires: finance schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);

-- ========= finance --> supply (3 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= finance --> workforce (32 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_profit_employee_id` FOREIGN KEY (`profit_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_journal_posted_by_employee_id` FOREIGN KEY (`journal_posted_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_capex_requestor_employee_id` FOREIGN KEY (`capex_requestor_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_wbs_responsible_employee_id` FOREIGN KEY (`wbs_responsible_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_primary_finance_employee_id` FOREIGN KEY (`primary_finance_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_tertiary_finance_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_finance_last_modified_by_user_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ADD CONSTRAINT `fk_finance_finance_nre_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_depreciation_employee_id` FOREIGN KEY (`depreciation_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_depreciation_executed_by_employee_id` FOREIGN KEY (`depreciation_executed_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_depreciation_updated_by_user_employee_id` FOREIGN KEY (`depreciation_updated_by_user_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ADD CONSTRAINT `fk_finance_consolidation_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ADD CONSTRAINT `fk_finance_consolidation_group_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ADD CONSTRAINT `fk_finance_consolidation_group_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ADD CONSTRAINT `fk_finance_amortization_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> compliance (9 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_export_license_usage_id` FOREIGN KEY (`export_license_usage_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license_usage`(`export_license_usage_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_trade_compliance_hold_id` FOREIGN KEY (`trade_compliance_hold_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold`(`trade_compliance_hold_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_primary_inventory_quality_kgd_certification_id` FOREIGN KEY (`primary_inventory_quality_kgd_certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_primary_quality_kgd_certification_id` FOREIGN KEY (`primary_quality_kgd_certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);

-- ========= inventory --> customer (7 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= inventory --> design (11 constraint(s)) =========
-- Requires: inventory schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= inventory --> equipment (5 constraint(s)) =========
-- Requires: inventory schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_equipment_fab_id` FOREIGN KEY (`equipment_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= inventory --> fabrication (18 constraint(s)) =========
-- Requires: inventory schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_reticle_set_id` FOREIGN KEY (`reticle_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`reticle_set`(`reticle_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_primary_inventory_fabrication_wafer_lot_id` FOREIGN KEY (`primary_inventory_fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`plant`(`plant_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_fabrication_lot_hold_id` FOREIGN KEY (`fabrication_lot_hold_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold`(`fabrication_lot_hold_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_fabrication_lot_genealogy_id` FOREIGN KEY (`fabrication_lot_genealogy_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy`(`fabrication_lot_genealogy_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_inventory_fabrication_lot_genealogy_id` FOREIGN KEY (`inventory_fabrication_lot_genealogy_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy`(`fabrication_lot_genealogy_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_primary_fabrication_lot_genealogy_id` FOREIGN KEY (`primary_fabrication_lot_genealogy_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy`(`fabrication_lot_genealogy_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_primary_inventory_fabrication_lot_genealogy_id` FOREIGN KEY (`primary_inventory_fabrication_lot_genealogy_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy`(`fabrication_lot_genealogy_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);

-- ========= inventory --> finance (7 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= inventory --> invoice (1 constraint(s)) =========
-- Requires: inventory schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= inventory --> order (6 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_allocation_record_id` FOREIGN KEY (`allocation_record_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`allocation_record`(`allocation_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_reservation_sales_order_id` FOREIGN KEY (`reservation_sales_order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= inventory --> packaging (4 constraint(s)) =========
-- Requires: inventory schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);

-- ========= inventory --> product (13 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= inventory --> quality (4 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_quality_notification_id` FOREIGN KEY (`quality_notification_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_notification`(`quality_notification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_quality_kgd_certification_id` FOREIGN KEY (`quality_kgd_certification_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification`(`quality_kgd_certification_id`);

-- ========= inventory --> research (5 constraint(s)) =========
-- Requires: inventory schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_device_architecture_id` FOREIGN KEY (`device_architecture_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`device_architecture`(`device_architecture_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_tapeout_experiment_id` FOREIGN KEY (`tapeout_experiment_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`tapeout_experiment`(`tapeout_experiment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= inventory --> shared (1 constraint(s)) =========
-- Requires: inventory schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= inventory --> supply (17 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_primary_stock_material_master_id` FOREIGN KEY (`primary_stock_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_primary_goods_material_master_id` FOREIGN KEY (`primary_goods_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_consignment_agreement_id` FOREIGN KEY (`consignment_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`consignment_agreement`(`consignment_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_stock_material_master_id` FOREIGN KEY (`stock_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= inventory --> test (2 constraint(s)) =========
-- Requires: inventory schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`probe_card`(`probe_card_id`);

-- ========= inventory --> workforce (19 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_goods_performed_by_employee_id` FOREIGN KEY (`goods_performed_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_inventory_released_by_employee_id` FOREIGN KEY (`inventory_released_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_primary_inventory_employee_id` FOREIGN KEY (`primary_inventory_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_primary_physical_counter_employee_id` FOREIGN KEY (`primary_physical_counter_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_primary_inventory_employee_id` FOREIGN KEY (`primary_inventory_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_reservation_reserved_by_employee_id` FOREIGN KEY (`reservation_reserved_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= invoice --> compliance (3 constraint(s)) =========
-- Requires: invoice schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`audit_event`(`audit_event_id`);

-- ========= invoice --> customer (16 constraint(s)) =========
-- Requires: invoice schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ADD CONSTRAINT `fk_invoice_customer_credit_limit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_primary_credit_customer_account_id` FOREIGN KEY (`primary_credit_customer_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ADD CONSTRAINT `fk_invoice_pricing_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ADD CONSTRAINT `fk_invoice_performance_obligation_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= invoice --> design (5 constraint(s)) =========
-- Requires: invoice schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);

-- ========= invoice --> equipment (1 constraint(s)) =========
-- Requires: invoice schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= invoice --> fabrication (1 constraint(s)) =========
-- Requires: invoice schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= invoice --> finance (11 constraint(s)) =========
-- Requires: invoice schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= invoice --> order (6 constraint(s)) =========
-- Requires: invoice schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_authoritative_order_line_id` FOREIGN KEY (`authoritative_order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= invoice --> packaging (3 constraint(s)) =========
-- Requires: invoice schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= invoice --> product (7 constraint(s)) =========
-- Requires: invoice schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`royalty_billing` ADD CONSTRAINT `fk_invoice_royalty_billing_product_ip_core_id` FOREIGN KEY (`product_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_ip_core`(`product_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ADD CONSTRAINT `fk_invoice_pricing_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= invoice --> quality (1 constraint(s)) =========
-- Requires: invoice schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= invoice --> research (1 constraint(s)) =========
-- Requires: invoice schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= invoice --> sales (9 constraint(s)) =========
-- Requires: invoice schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_sales_nre_agreement_id` FOREIGN KEY (`sales_nre_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`(`sales_nre_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ADD CONSTRAINT `fk_invoice_pricing_agreement_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ADD CONSTRAINT `fk_invoice_performance_obligation_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`performance_obligation` ADD CONSTRAINT `fk_invoice_performance_obligation_performance_customer_contract_id` FOREIGN KEY (`performance_customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= invoice --> supply (3 constraint(s)) =========
-- Requires: invoice schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`po_line`(`po_line_id`);

-- ========= invoice --> test (2 constraint(s)) =========
-- Requires: invoice schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);

-- ========= invoice --> workforce (21 constraint(s)) =========
-- Requires: invoice schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`ar_invoice` ADD CONSTRAINT `fk_invoice_ar_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`invoice_line` ADD CONSTRAINT `fk_invoice_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone` ADD CONSTRAINT `fk_invoice_nre_billing_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`adjustment_memo` ADD CONSTRAINT `fk_invoice_adjustment_memo_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_receipt` ADD CONSTRAINT `fk_invoice_payment_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`payment_term` ADD CONSTRAINT `fk_invoice_payment_term_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ADD CONSTRAINT `fk_invoice_customer_credit_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`customer_credit_limit` ADD CONSTRAINT `fk_invoice_customer_credit_limit_customer_employee_id` FOREIGN KEY (`customer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`credit_hold` ADD CONSTRAINT `fk_invoice_credit_hold_primary_credit_employee_id` FOREIGN KEY (`primary_credit_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event` ADD CONSTRAINT `fk_invoice_revenue_recognition_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`pricing_agreement` ADD CONSTRAINT `fk_invoice_pricing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`tax_determination` ADD CONSTRAINT `fk_invoice_tax_determination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_primary_write_employee_id` FOREIGN KEY (`primary_write_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_tertiary_write_updated_by_user_employee_id` FOREIGN KEY (`tertiary_write_updated_by_user_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= order --> compliance (6 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_restricted_party_screening_id` FOREIGN KEY (`restricted_party_screening_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening`(`restricted_party_screening_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_trade_compliance_hold_id` FOREIGN KEY (`trade_compliance_hold_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold`(`trade_compliance_hold_id`);

-- ========= order --> customer (24 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_shipment_ship_to_address_id` FOREIGN KEY (`shipment_ship_to_address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= order --> design (11 constraint(s)) =========
-- Requires: order schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);

-- ========= order --> equipment (2 constraint(s)) =========
-- Requires: order schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= order --> fabrication (7 constraint(s)) =========
-- Requires: order schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_fab_site_id` FOREIGN KEY (`fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_reticle_set_id` FOREIGN KEY (`reticle_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`reticle_set`(`reticle_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= order --> finance (3 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ADD CONSTRAINT `fk_order_order_nre_milestone_authoritative_finance_nre_milestone_id` FOREIGN KEY (`authoritative_finance_nre_milestone_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone`(`finance_nre_milestone_id`);

-- ========= order --> inventory (13 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_delivery_ship_to_location_id` FOREIGN KEY (`delivery_ship_to_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_assigned_storage_location_id` FOREIGN KEY (`assigned_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= order --> invoice (2 constraint(s)) =========
-- Requires: order schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= order --> packaging (5 constraint(s)) =========
-- Requires: order schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);

-- ========= order --> product (12 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= order --> quality (2 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_failure_analysis_report_id` FOREIGN KEY (`failure_analysis_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= order --> research (3 constraint(s)) =========
-- Requires: order schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);

-- ========= order --> sales (10 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_sales_nre_agreement_id` FOREIGN KEY (`sales_nre_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`(`sales_nre_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ADD CONSTRAINT `fk_order_order_nre_milestone_sales_nre_agreement_id` FOREIGN KEY (`sales_nre_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`(`sales_nre_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= order --> shared (1 constraint(s)) =========
-- Requires: order schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);

-- ========= order --> supply (3 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`carrier`(`carrier_id`);

-- ========= order --> test (3 constraint(s)) =========
-- Requires: order schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);

-- ========= order --> workforce (23 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_status_employee_id` FOREIGN KEY (`status_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_wafer_authorized_by_employee_id` FOREIGN KEY (`wafer_authorized_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ADD CONSTRAINT `fk_order_order_nre_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_nre_milestone` ADD CONSTRAINT `fk_order_order_nre_milestone_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_primary_order_employee_id` FOREIGN KEY (`primary_order_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_tertiary_order_escalation_owner_employee_id` FOREIGN KEY (`tertiary_order_escalation_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`lot_assignment` ADD CONSTRAINT `fk_order_lot_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= packaging --> compliance (7 constraint(s)) =========
-- Requires: packaging schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_export_license_usage_id` FOREIGN KEY (`export_license_usage_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license_usage`(`export_license_usage_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= packaging --> customer (6 constraint(s)) =========
-- Requires: packaging schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ADD CONSTRAINT `fk_packaging_customer_requirement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= packaging --> design (6 constraint(s)) =========
-- Requires: packaging schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= packaging --> equipment (6 constraint(s)) =========
-- Requires: packaging schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= packaging --> fabrication (2 constraint(s)) =========
-- Requires: packaging schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ADD CONSTRAINT `fk_packaging_packaging_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`plant`(`plant_id`);

-- ========= packaging --> finance (10 constraint(s)) =========
-- Requires: packaging schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= packaging --> inventory (3 constraint(s)) =========
-- Requires: packaging schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);

-- ========= packaging --> invoice (1 constraint(s)) =========
-- Requires: packaging schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ADD CONSTRAINT `fk_packaging_packaging_line_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`invoice_line`(`invoice_line_id`);

-- ========= packaging --> process (7 constraint(s)) =========
-- Requires: packaging schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ADD CONSTRAINT `fk_packaging_package_type_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);

-- ========= packaging --> product (12 constraint(s)) =========
-- Requires: packaging schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_primary_material_substrate_bom_id` FOREIGN KEY (`primary_material_substrate_bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ADD CONSTRAINT `fk_packaging_customer_requirement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= packaging --> quality (6 constraint(s)) =========
-- Requires: packaging schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`reliability_test`(`reliability_test_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_spc_chart_id` FOREIGN KEY (`spc_chart_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`spc_chart`(`spc_chart_id`);

-- ========= packaging --> sales (2 constraint(s)) =========
-- Requires: packaging schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);

-- ========= packaging --> shared (1 constraint(s)) =========
-- Requires: packaging schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ADD CONSTRAINT `fk_packaging_osat_vendor_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= packaging --> supply (6 constraint(s)) =========
-- Requires: packaging schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ADD CONSTRAINT `fk_packaging_osat_vendor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= packaging --> test (1 constraint(s)) =========
-- Requires: packaging schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);

-- ========= packaging --> workforce (22 constraint(s)) =========
-- Requires: packaging schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ADD CONSTRAINT `fk_packaging_package_type_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ADD CONSTRAINT `fk_packaging_osat_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_assembly_process_owner_employee_id` FOREIGN KEY (`assembly_process_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_package_program_manager_employee_id` FOREIGN KEY (`package_program_manager_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_assembly_employee_id` FOREIGN KEY (`assembly_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ADD CONSTRAINT `fk_packaging_customer_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_assembly_operator_employee_id` FOREIGN KEY (`assembly_operator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ADD CONSTRAINT `fk_packaging_packaging_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ADD CONSTRAINT `fk_packaging_qualification_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ADD CONSTRAINT `fk_packaging_qualification_plan_qualification_plan_owner_employee_id` FOREIGN KEY (`qualification_plan_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= process --> compliance (7 constraint(s)) =========
-- Requires: process schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ADD CONSTRAINT `fk_process_deposition_condition_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ADD CONSTRAINT `fk_process_etch_condition_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ADD CONSTRAINT `fk_process_cmp_condition_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ADD CONSTRAINT `fk_process_litho_condition_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ADD CONSTRAINT `fk_process_cooling_condition_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);

-- ========= process --> customer (4 constraint(s)) =========
-- Requires: process schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ADD CONSTRAINT `fk_process_flow_qualification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= process --> design (1 constraint(s)) =========
-- Requires: process schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ADD CONSTRAINT `fk_process_process_flow_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);

-- ========= process --> equipment (19 constraint(s)) =========
-- Requires: process schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_metrology_run_id` FOREIGN KEY (`metrology_run_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`metrology_run`(`metrology_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ADD CONSTRAINT `fk_process_process_site_map_equipment_site_map_id` FOREIGN KEY (`equipment_site_map_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_site_map`(`equipment_site_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ADD CONSTRAINT `fk_process_process_site_map_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ADD CONSTRAINT `fk_process_cooling_condition_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= process --> fabrication (54 constraint(s)) =========
-- Requires: process schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ADD CONSTRAINT `fk_process_opc_rule_set_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ADD CONSTRAINT `fk_process_meef_parameter_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ADD CONSTRAINT `fk_process_meef_parameter_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ADD CONSTRAINT `fk_process_meef_parameter_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ADD CONSTRAINT `fk_process_implant_condition_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ADD CONSTRAINT `fk_process_implant_condition_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ADD CONSTRAINT `fk_process_deposition_condition_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ADD CONSTRAINT `fk_process_etch_condition_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ADD CONSTRAINT `fk_process_cmp_condition_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ADD CONSTRAINT `fk_process_litho_condition_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_authoritative_fabrication_technology_node_id` FOREIGN KEY (`authoritative_fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_fabrication_technology_node_ref_id` FOREIGN KEY (`fabrication_technology_node_ref_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ADD CONSTRAINT `fk_process_doe_experiment_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ADD CONSTRAINT `fk_process_doe_experiment_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ADD CONSTRAINT `fk_process_flow_qualification_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ADD CONSTRAINT `fk_process_process_supply_agreement_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ADD CONSTRAINT `fk_process_process_spc_control_plan_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ADD CONSTRAINT `fk_process_metrology_plan_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ADD CONSTRAINT `fk_process_cooling_process_flow_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ADD CONSTRAINT `fk_process_cooling_condition_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);

-- ========= process --> finance (4 constraint(s)) =========
-- Requires: process schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ADD CONSTRAINT `fk_process_process_flow_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ADD CONSTRAINT `fk_process_process_flow_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= process --> invoice (3 constraint(s)) =========
-- Requires: process schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= process --> order (1 constraint(s)) =========
-- Requires: process schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= process --> product (13 constraint(s)) =========
-- Requires: process schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ADD CONSTRAINT `fk_process_deposition_condition_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ADD CONSTRAINT `fk_process_etch_condition_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ADD CONSTRAINT `fk_process_doe_experiment_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= process --> quality (2 constraint(s)) =========
-- Requires: process schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ADD CONSTRAINT `fk_process_process_spc_control_plan_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);

-- ========= process --> research (5 constraint(s)) =========
-- Requires: process schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= process --> supply (4 constraint(s)) =========
-- Requires: process schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ADD CONSTRAINT `fk_process_process_supply_agreement_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ADD CONSTRAINT `fk_process_process_supply_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= process --> workforce (23 constraint(s)) =========
-- Requires: process schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ADD CONSTRAINT `fk_process_process_flow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ADD CONSTRAINT `fk_process_process_flow_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_fab_operator_qualification_id` FOREIGN KEY (`fab_operator_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification`(`fab_operator_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ADD CONSTRAINT `fk_process_implant_condition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ADD CONSTRAINT `fk_process_etch_condition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_tertiary_ocap_assigned_engineer_employee_id` FOREIGN KEY (`tertiary_ocap_assigned_engineer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ADD CONSTRAINT `fk_process_doe_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ADD CONSTRAINT `fk_process_flow_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ADD CONSTRAINT `fk_process_process_spc_control_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ADD CONSTRAINT `fk_process_cooling_process_flow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ADD CONSTRAINT `fk_process_cooling_process_flow_cooling_employee_id` FOREIGN KEY (`cooling_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ADD CONSTRAINT `fk_process_cooling_process_flow_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ADD CONSTRAINT `fk_process_cooling_condition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= product --> compliance (3 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ADD CONSTRAINT `fk_product_license_allocation_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);

-- ========= product --> customer (7 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ADD CONSTRAINT `fk_product_product_ltb_notification_customer_ltb_notification_id` FOREIGN KEY (`customer_ltb_notification_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification`(`customer_ltb_notification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_customer_sample_request_id` FOREIGN KEY (`customer_sample_request_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_sample_request`(`customer_sample_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_product_customer_sample_request_id` FOREIGN KEY (`product_customer_sample_request_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_sample_request`(`customer_sample_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ADD CONSTRAINT `fk_product_license_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= product --> design (1 constraint(s)) =========
-- Requires: product schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);

-- ========= product --> fabrication (2 constraint(s)) =========
-- Requires: product schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);

-- ========= product --> finance (6 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= product --> order (1 constraint(s)) =========
-- Requires: product schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= product --> packaging (2 constraint(s)) =========
-- Requires: product schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= product --> process (1 constraint(s)) =========
-- Requires: product schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_change_notification_id` FOREIGN KEY (`change_notification_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`change_notification`(`change_notification_id`);

-- ========= product --> quality (1 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);

-- ========= product --> supply (3 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= product --> test (1 constraint(s)) =========
-- Requires: product schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_test_case_id` FOREIGN KEY (`test_case_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_case`(`test_case_id`);

-- ========= product --> workforce (15 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ADD CONSTRAINT `fk_product_process_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ADD CONSTRAINT `fk_product_product_ltb_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> compliance (3 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_trade_compliance_hold_id` FOREIGN KEY (`trade_compliance_hold_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold`(`trade_compliance_hold_id`);

-- ========= quality --> customer (10 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);

-- ========= quality --> design (2 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);

-- ========= quality --> equipment (12 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ADD CONSTRAINT `fk_quality_quality_metrology_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ADD CONSTRAINT `fk_quality_defect_cluster_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= quality --> fabrication (29 constraint(s)) =========
-- Requires: quality schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ADD CONSTRAINT `fk_quality_quality_metrology_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_zone` ADD CONSTRAINT `fk_quality_wafer_zone_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ADD CONSTRAINT `fk_quality_defect_cluster_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_cluster` ADD CONSTRAINT `fk_quality_defect_cluster_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ADD CONSTRAINT `fk_quality_mrb_meeting_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);

-- ========= quality --> finance (6 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (8 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_inventory_kgd_certification_id` FOREIGN KEY (`inventory_kgd_certification_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification`(`inventory_kgd_certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ADD CONSTRAINT `fk_quality_quality_metrology_measurement_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= quality --> order (2 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order_line`(`order_line_id`);

-- ========= quality --> packaging (2 constraint(s)) =========
-- Requires: quality schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= quality --> process (16 constraint(s)) =========
-- Requires: quality schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ADD CONSTRAINT `fk_quality_quality_metrology_measurement_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ADD CONSTRAINT `fk_quality_quality_metrology_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);

-- ========= quality --> product (25 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ADD CONSTRAINT `fk_quality_quality_metrology_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= quality --> research (8 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_research_test_plan_id` FOREIGN KEY (`research_test_plan_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_test_plan`(`research_test_plan_id`);

-- ========= quality --> sales (3 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`sales_design_win`(`sales_design_win_id`);

-- ========= quality --> supply (5 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ADD CONSTRAINT `fk_quality_supplier_quality_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= quality --> test (4 constraint(s)) =========
-- Requires: quality schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_reliability_test_run_id` FOREIGN KEY (`reliability_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`reliability_test_run`(`reliability_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);

-- ========= quality --> workforce (42 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_spc_employee_id` FOREIGN KEY (`spc_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_quality_program_owner_employee_id` FOREIGN KEY (`quality_program_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_kgd_certification` ADD CONSTRAINT `fk_quality_quality_kgd_certification_quality_certifying_engineer_employee_id` FOREIGN KEY (`quality_certifying_engineer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_nonconformance_reported_by_employee_id` FOREIGN KEY (`nonconformance_reported_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_nonconformance_reporter_employee_id` FOREIGN KEY (`nonconformance_reporter_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_audit_finding` ADD CONSTRAINT `fk_quality_quality_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_primary_lead_auditor_employee_id` FOREIGN KEY (`primary_lead_auditor_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement` ADD CONSTRAINT `fk_quality_quality_metrology_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard` ADD CONSTRAINT `fk_quality_supplier_quality_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_quality_placed_by_employee_id` FOREIGN KEY (`quality_placed_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_quality_requested_by_employee_id` FOREIGN KEY (`quality_requested_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_quality_created_by_employee_id` FOREIGN KEY (`quality_created_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_quality_employee_id` FOREIGN KEY (`quality_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_notification` ADD CONSTRAINT `fk_quality_quality_notification_quality_review_owner_employee_id` FOREIGN KEY (`quality_review_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_qualification_author_employee_id` FOREIGN KEY (`qualification_author_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_customer_employee_id` FOREIGN KEY (`customer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ADD CONSTRAINT `fk_quality_mrb_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`mrb_meeting` ADD CONSTRAINT `fk_quality_mrb_meeting_mrb_chairperson_employee_id` FOREIGN KEY (`mrb_chairperson_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_document` ADD CONSTRAINT `fk_quality_quality_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= research --> compliance (7 constraint(s)) =========
-- Requires: research schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ADD CONSTRAINT `fk_research_materials_research_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ADD CONSTRAINT `fk_research_government_grant_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ADD CONSTRAINT `fk_research_compliance_assessment_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ADD CONSTRAINT `fk_research_compliance_assessment_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`obligation_register`(`obligation_register_id`);

-- ========= research --> customer (2 constraint(s)) =========
-- Requires: research schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ADD CONSTRAINT `fk_research_collaboration_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ADD CONSTRAINT `fk_research_program_partner_collaboration_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= research --> design (4 constraint(s)) =========
-- Requires: research schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ADD CONSTRAINT `fk_research_research_milestone_authoritative_design_milestone_id` FOREIGN KEY (`authoritative_design_milestone_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_milestone`(`design_milestone_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ADD CONSTRAINT `fk_research_research_milestone_design_milestone_id` FOREIGN KEY (`design_milestone_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_milestone`(`design_milestone_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);

-- ========= research --> equipment (2 constraint(s)) =========
-- Requires: research schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ADD CONSTRAINT `fk_research_test_structure_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= research --> fabrication (15 constraint(s)) =========
-- Requires: research schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ADD CONSTRAINT `fk_research_research_technology_node_fab_site_id` FOREIGN KEY (`fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ADD CONSTRAINT `fk_research_device_architecture_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ADD CONSTRAINT `fk_research_materials_research_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ADD CONSTRAINT `fk_research_pdk_development_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ADD CONSTRAINT `fk_research_packaging_research_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ADD CONSTRAINT `fk_research_research_test_plan_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= research --> finance (8 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ADD CONSTRAINT `fk_research_research_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ADD CONSTRAINT `fk_research_research_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ADD CONSTRAINT `fk_research_ip_core_development_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ADD CONSTRAINT `fk_research_pdk_development_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ADD CONSTRAINT `fk_research_budget_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= research --> packaging (5 constraint(s)) =========
-- Requires: research schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ADD CONSTRAINT `fk_research_technology_roadmap_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ADD CONSTRAINT `fk_research_device_architecture_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ADD CONSTRAINT `fk_research_packaging_research_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= research --> process (3 constraint(s)) =========
-- Requires: research schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ADD CONSTRAINT `fk_research_research_technology_node_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ADD CONSTRAINT `fk_research_technology_roadmap_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);

-- ========= research --> product (9 constraint(s)) =========
-- Requires: research schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ADD CONSTRAINT `fk_research_research_program_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ADD CONSTRAINT `fk_research_research_technology_node_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ADD CONSTRAINT `fk_research_device_architecture_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ADD CONSTRAINT `fk_research_ip_core_development_product_ip_core_id` FOREIGN KEY (`product_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_ip_core`(`product_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= research --> sales (1 constraint(s)) =========
-- Requires: research schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ADD CONSTRAINT `fk_research_program_partner_collaboration_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);

-- ========= research --> supply (1 constraint(s)) =========
-- Requires: research schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= research --> workforce (47 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ADD CONSTRAINT `fk_research_research_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ADD CONSTRAINT `fk_research_research_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ADD CONSTRAINT `fk_research_research_program_research_director_employee_id` FOREIGN KEY (`research_director_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_tertiary_project_principal_investigator_employee_id` FOREIGN KEY (`tertiary_project_principal_investigator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ADD CONSTRAINT `fk_research_technology_roadmap_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_process_engineer_employee_id` FOREIGN KEY (`process_engineer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ADD CONSTRAINT `fk_research_device_architecture_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ADD CONSTRAINT `fk_research_materials_research_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ADD CONSTRAINT `fk_research_materials_research_materials_researcher_employee_id` FOREIGN KEY (`materials_researcher_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ADD CONSTRAINT `fk_research_ip_core_development_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ADD CONSTRAINT `fk_research_ip_core_development_ip_lead_employee_id` FOREIGN KEY (`ip_lead_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_primary_inventor_employee_id` FOREIGN KEY (`primary_inventor_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ADD CONSTRAINT `fk_research_collaboration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_characterization_engineer_employee_id` FOREIGN KEY (`characterization_engineer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ADD CONSTRAINT `fk_research_pdk_development_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ADD CONSTRAINT `fk_research_research_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ADD CONSTRAINT `fk_research_research_milestone_primary_research_approving_authority_employee_id` FOREIGN KEY (`primary_research_approving_authority_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_publication_author_employee_id` FOREIGN KEY (`publication_author_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ADD CONSTRAINT `fk_research_budget_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ADD CONSTRAINT `fk_research_budget_allocation_tertiary_budget_employee_id` FOREIGN KEY (`tertiary_budget_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ADD CONSTRAINT `fk_research_packaging_research_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ADD CONSTRAINT `fk_research_packaging_research_packaging_researcher_employee_id` FOREIGN KEY (`packaging_researcher_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ADD CONSTRAINT `fk_research_packaging_research_primary_packaging_principal_investigator_employee_id` FOREIGN KEY (`primary_packaging_principal_investigator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_yield_engineer_employee_id` FOREIGN KEY (`yield_engineer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ADD CONSTRAINT `fk_research_competitive_benchmark_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ADD CONSTRAINT `fk_research_competitive_benchmark_competitive_employee_id` FOREIGN KEY (`competitive_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ADD CONSTRAINT `fk_research_government_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ADD CONSTRAINT `fk_research_government_grant_government_principal_investigator_employee_id` FOREIGN KEY (`government_principal_investigator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_primary_process_author_employee_id` FOREIGN KEY (`primary_process_author_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_process_engineer_employee_id` FOREIGN KEY (`process_engineer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ADD CONSTRAINT `fk_research_compliance_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ADD CONSTRAINT `fk_research_compliance_assessment_compliance_remediation_owner_employee_id` FOREIGN KEY (`compliance_remediation_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ADD CONSTRAINT `fk_research_test_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ADD CONSTRAINT `fk_research_research_test_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ADD CONSTRAINT `fk_research_research_test_plan_test_plan_owner_employee_id` FOREIGN KEY (`test_plan_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ADD CONSTRAINT `fk_research_test_suite_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ADD CONSTRAINT `fk_research_test_suite_test_suite_owner_employee_id` FOREIGN KEY (`test_suite_owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> compliance (4 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);

-- ========= sales --> customer (22 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sales_customer_design_win_id` FOREIGN KEY (`sales_customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_customer_design_registration_id` FOREIGN KEY (`customer_design_registration_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_registration`(`customer_design_registration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ADD CONSTRAINT `fk_sales_rebate_program_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);

-- ========= sales --> design (7 constraint(s)) =========
-- Requires: sales schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ADD CONSTRAINT `fk_sales_opportunity_project_assignment_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= sales --> fabrication (3 constraint(s)) =========
-- Requires: sales schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);

-- ========= sales --> finance (6 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_finance_nre_agreement_id` FOREIGN KEY (`finance_nre_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement`(`finance_nre_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ADD CONSTRAINT `fk_sales_rebate_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= sales --> inventory (2 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ADD CONSTRAINT `fk_sales_partner_inventory_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);

-- ========= sales --> invoice (1 constraint(s)) =========
-- Requires: sales schema, invoice schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_semiconductors_v1`.`invoice`.`ar_invoice`(`ar_invoice_id`);

-- ========= sales --> packaging (3 constraint(s)) =========
-- Requires: sales schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= sales --> process (5 constraint(s)) =========
-- Requires: sales schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);

-- ========= sales --> product (18 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ADD CONSTRAINT `fk_sales_partner_inventory_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ADD CONSTRAINT `fk_sales_partner_inventory_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ADD CONSTRAINT `fk_sales_lead_program_interest_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);

-- ========= sales --> research (4 constraint(s)) =========
-- Requires: sales schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ADD CONSTRAINT `fk_sales_opportunity_project_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ADD CONSTRAINT `fk_sales_lead_program_interest_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);

-- ========= sales --> supply (3 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= sales --> test (1 constraint(s)) =========
-- Requires: sales schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);

-- ========= sales --> workforce (25 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sales_employee_id` FOREIGN KEY (`sales_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_sales_employee_id` FOREIGN KEY (`sales_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_price_employee_id` FOREIGN KEY (`price_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_manager_employee_id` FOREIGN KEY (`territory_manager_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`rebate_program` ADD CONSTRAINT `fk_sales_rebate_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`partner_inventory` ADD CONSTRAINT `fk_sales_partner_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ADD CONSTRAINT `fk_sales_opportunity_project_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ADD CONSTRAINT `fk_sales_opportunity_project_assignment_opportunity_assigned_by_employee_id` FOREIGN KEY (`opportunity_assigned_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity_project_assignment` ADD CONSTRAINT `fk_sales_opportunity_project_assignment_opportunity_employee_id` FOREIGN KEY (`opportunity_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`lead_program_interest` ADD CONSTRAINT `fk_sales_lead_program_interest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> compliance (6 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ADD CONSTRAINT `fk_supply_supplier_audit_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ADD CONSTRAINT `fk_supply_product_change_notification_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= supply --> customer (2 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= supply --> fabrication (2 constraint(s)) =========
-- Requires: supply schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);

-- ========= supply --> finance (2 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= supply --> product (5 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ADD CONSTRAINT `fk_supply_supplier_quotation_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= supply --> quality (1 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ADD CONSTRAINT `fk_supply_supplier_corrective_action_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`defect_record`(`defect_record_id`);

-- ========= supply --> research (6 constraint(s)) =========
-- Requires: supply schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ADD CONSTRAINT `fk_supply_risk_assessment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_materials_research_id` FOREIGN KEY (`materials_research_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`materials_research`(`materials_research_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ADD CONSTRAINT `fk_supply_supplier_quotation_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= supply --> shared (2 constraint(s)) =========
-- Requires: supply schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= supply --> workforce (12 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_purchase_buyer_employee_id` FOREIGN KEY (`purchase_buyer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ADD CONSTRAINT `fk_supply_supplier_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ADD CONSTRAINT `fk_supply_supplier_audit_supplier_employee_id` FOREIGN KEY (`supplier_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ADD CONSTRAINT `fk_supply_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ADD CONSTRAINT `fk_supply_supplier_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ADD CONSTRAINT `fk_supply_supplier_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ADD CONSTRAINT `fk_supply_disruption_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= test --> compliance (2 constraint(s)) =========
-- Requires: test schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);

-- ========= test --> customer (2 constraint(s)) =========
-- Requires: test schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= test --> design (7 constraint(s)) =========
-- Requires: test schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ADD CONSTRAINT `fk_test_correlation_study_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= test --> equipment (7 constraint(s)) =========
-- Requires: test schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= test --> fabrication (9 constraint(s)) =========
-- Requires: test schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_parametric_wafer_id` FOREIGN KEY (`parametric_wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= test --> finance (4 constraint(s)) =========
-- Requires: test schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);

-- ========= test --> inventory (6 constraint(s)) =========
-- Requires: test schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= test --> packaging (1 constraint(s)) =========
-- Requires: test schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= test --> process (7 constraint(s)) =========
-- Requires: test schema, process schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ADD CONSTRAINT `fk_test_insertion_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ADD CONSTRAINT `fk_test_adaptive_test_flow_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);

-- ========= test --> product (12 constraint(s)) =========
-- Requires: test schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_coverage_ic_catalog_id` FOREIGN KEY (`coverage_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ADD CONSTRAINT `fk_test_test_case_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= test --> research (3 constraint(s)) =========
-- Requires: test schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ADD CONSTRAINT `fk_test_correlation_study_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= test --> shared (1 constraint(s)) =========
-- Requires: test schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= test --> supply (3 constraint(s)) =========
-- Requires: test schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ADD CONSTRAINT `fk_test_correlation_study_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= test --> workforce (15 constraint(s)) =========
-- Requires: test schema, workforce schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_wafer_operator_employee_id` FOREIGN KEY (`wafer_operator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_final_operator_employee_id` FOREIGN KEY (`final_operator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_reliability_operator_employee_id` FOREIGN KEY (`reliability_operator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ADD CONSTRAINT `fk_test_correlation_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_program_assigned_by_employee_id` FOREIGN KEY (`program_assigned_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_program_employee_id` FOREIGN KEY (`program_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> compliance (3 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ADD CONSTRAINT `fk_workforce_export_control_export_technology_control_plan_id` FOREIGN KEY (`export_technology_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ADD CONSTRAINT `fk_workforce_export_control_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);

-- ========= workforce --> equipment (1 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= workforce --> fabrication (7 constraint(s)) =========
-- Requires: workforce schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_fab_site_id` FOREIGN KEY (`fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ADD CONSTRAINT `fk_workforce_cleanroom_access_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ADD CONSTRAINT `fk_workforce_cleanroom_access_fab_site_id` FOREIGN KEY (`fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_fab_site_id` FOREIGN KEY (`fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);

-- ========= workforce --> finance (1 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> research (1 constraint(s)) =========
-- Requires: workforce schema, research schema
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);

-- ========= workforce --> shared (10 constraint(s)) =========
-- Requires: workforce schema, shared schema
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ADD CONSTRAINT `fk_workforce_site_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ADD CONSTRAINT `fk_workforce_cleanroom_access_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ADD CONSTRAINT `fk_workforce_job_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);

-- ========= workforce --> supply (1 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ADD CONSTRAINT `fk_workforce_contractor_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

