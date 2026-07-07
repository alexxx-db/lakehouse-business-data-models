-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:10:01
-- Total cross-domain FK constraints: 1272
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: bid, client, compliance, contract, design, equipment, finance, hr, material, procurement, project, quality, safety, schedule, site, subcontractor, sustainability, workforce

-- ========= bid --> client (8 constraint(s)) =========
-- Requires: bid schema, client schema
ALTER TABLE `vibe_construction_v1`.`bid`.`firm_profile` ADD CONSTRAINT `fk_bid_firm_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`jv_partner` ADD CONSTRAINT `fk_bid_jv_partner_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ADD CONSTRAINT `fk_bid_pursuit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ADD CONSTRAINT `fk_bid_bidder_prequalification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= bid --> compliance (5 constraint(s)) =========
-- Requires: bid schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_construction_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ADD CONSTRAINT `fk_bid_bidder_prequalification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= bid --> contract (2 constraint(s)) =========
-- Requires: bid schema, contract schema
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ADD CONSTRAINT `fk_bid_subcontractor_bond_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);

-- ========= bid --> design (5 constraint(s)) =========
-- Requires: bid schema, design schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_engineering_submittal_id` FOREIGN KEY (`engineering_submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`engineering_submittal`(`engineering_submittal_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);

-- ========= bid --> equipment (1 constraint(s)) =========
-- Requires: bid schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= bid --> finance (11 constraint(s)) =========
-- Requires: bid schema, finance schema
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ADD CONSTRAINT `fk_bid_bid_contract_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ADD CONSTRAINT `fk_bid_bid_payment_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ADD CONSTRAINT `fk_bid_bid_payment_application_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ADD CONSTRAINT `fk_bid_bid_payment_application_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit` ADD CONSTRAINT `fk_bid_pursuit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= bid --> hr (16 constraint(s)) =========
-- Requires: bid schema, hr schema
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ADD CONSTRAINT `fk_bid_subcontractor_prequalification_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ADD CONSTRAINT `fk_bid_bid_contract_agreement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ADD CONSTRAINT `fk_bid_bid_payment_application_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ADD CONSTRAINT `fk_bid_subcontractor_bond_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ADD CONSTRAINT `fk_bid_bid_team_assignment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_primary_bid_employee_id` FOREIGN KEY (`primary_bid_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_pursuit_bid_employee_id` FOREIGN KEY (`pursuit_bid_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ADD CONSTRAINT `fk_bid_bidder_prequalification_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= bid --> material (2 constraint(s)) =========
-- Requires: bid schema, material schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ADD CONSTRAINT `fk_bid_bid_pricing_line_material_boq_line_id` FOREIGN KEY (`material_boq_line_id`) REFERENCES `vibe_construction_v1`.`material`.`material_boq_line`(`material_boq_line_id`);

-- ========= bid --> procurement (2 constraint(s)) =========
-- Requires: bid schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ADD CONSTRAINT `fk_bid_vendor_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= bid --> project (16 constraint(s)) =========
-- Requires: bid schema, project schema
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_prequalification` ADD CONSTRAINT `fk_bid_subcontractor_prequalification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ADD CONSTRAINT `fk_bid_bid_contract_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_payment_application` ADD CONSTRAINT `fk_bid_bid_payment_application_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`subcontractor_bond` ADD CONSTRAINT `fk_bid_subcontractor_bond_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_team_assignment` ADD CONSTRAINT `fk_bid_bid_team_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bidder_prequalification` ADD CONSTRAINT `fk_bid_bidder_prequalification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= bid --> schedule (1 constraint(s)) =========
-- Requires: bid schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);

-- ========= bid --> sustainability (7 constraint(s)) =========
-- Requires: bid schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`green_certification`(`green_certification_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_contract_agreement` ADD CONSTRAINT `fk_bid_bid_contract_agreement_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_embodied_carbon_assessment_id` FOREIGN KEY (`embodied_carbon_assessment_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment`(`embodied_carbon_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`vendor_quote` ADD CONSTRAINT `fk_bid_vendor_quote_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_pricing_line` ADD CONSTRAINT `fk_bid_bid_pricing_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`pursuit_risk` ADD CONSTRAINT `fk_bid_pursuit_risk_climate_risk_assessment_id` FOREIGN KEY (`climate_risk_assessment_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`climate_risk_assessment`(`climate_risk_assessment_id`);

-- ========= bid --> workforce (2 constraint(s)) =========
-- Requires: bid schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);

-- ========= client --> bid (2 constraint(s)) =========
-- Requires: client schema, bid schema
ALTER TABLE `vibe_construction_v1`.`client`.`client_opportunity` ADD CONSTRAINT `fk_client_client_opportunity_pursuit_id` FOREIGN KEY (`pursuit_id`) REFERENCES `vibe_construction_v1`.`bid`.`pursuit`(`pursuit_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`client_prequalification` ADD CONSTRAINT `fk_client_client_prequalification_bidder_prequalification_id` FOREIGN KEY (`bidder_prequalification_id`) REFERENCES `vibe_construction_v1`.`bid`.`bidder_prequalification`(`bidder_prequalification_id`);

-- ========= client --> contract (2 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `vibe_construction_v1`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= client --> hr (11 constraint(s)) =========
-- Requires: client schema, hr schema
ALTER TABLE `vibe_construction_v1`.`client`.`account` ADD CONSTRAINT `fk_client_account_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`segment` ADD CONSTRAINT `fk_client_segment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`client_opportunity` ADD CONSTRAINT `fk_client_client_opportunity_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`client_prequalification` ADD CONSTRAINT `fk_client_client_prequalification_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`account_credit_profile` ADD CONSTRAINT `fk_client_account_credit_profile_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`survey` ADD CONSTRAINT `fk_client_survey_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ADD CONSTRAINT `fk_client_master_services_agreement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= client --> procurement (1 constraint(s)) =========
-- Requires: client schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`client`.`master_services_agreement` ADD CONSTRAINT `fk_client_master_services_agreement_procurement_framework_agreement_id` FOREIGN KEY (`procurement_framework_agreement_id`) REFERENCES `vibe_construction_v1`.`procurement`.`procurement_framework_agreement`(`procurement_framework_agreement_id`);

-- ========= client --> project (4 constraint(s)) =========
-- Requires: client schema, project schema
ALTER TABLE `vibe_construction_v1`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`survey` ADD CONSTRAINT `fk_client_survey_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= client --> site (1 constraint(s)) =========
-- Requires: client schema, site schema
ALTER TABLE `vibe_construction_v1`.`client`.`address` ADD CONSTRAINT `fk_client_address_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= compliance --> bid (6 constraint(s)) =========
-- Requires: compliance schema, bid schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ADD CONSTRAINT `fk_compliance_regulatory_permit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ADD CONSTRAINT `fk_compliance_obligation_calendar_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= compliance --> client (4 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ADD CONSTRAINT `fk_compliance_regulatory_authority_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ADD CONSTRAINT `fk_compliance_regulatory_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= compliance --> contract (4 constraint(s)) =========
-- Requires: compliance schema, contract schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ADD CONSTRAINT `fk_compliance_waiver_exemption_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ADD CONSTRAINT `fk_compliance_obligation_calendar_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= compliance --> design (2 constraint(s)) =========
-- Requires: compliance schema, design schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);

-- ========= compliance --> finance (5 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);

-- ========= compliance --> hr (21 constraint(s)) =========
-- Requires: compliance schema, hr schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ADD CONSTRAINT `fk_compliance_leed_certification_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ADD CONSTRAINT `fk_compliance_leed_credit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ADD CONSTRAINT `fk_compliance_pci_assessment_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ADD CONSTRAINT `fk_compliance_iso_certification_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ADD CONSTRAINT `fk_compliance_iso_audit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ADD CONSTRAINT `fk_compliance_regulatory_permit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ADD CONSTRAINT `fk_compliance_obligation_calendar_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= compliance --> procurement (2 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ADD CONSTRAINT `fk_compliance_regulatory_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= compliance --> project (21 constraint(s)) =========
-- Requires: compliance schema, project schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_env_site_construction_project_id` FOREIGN KEY (`env_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ADD CONSTRAINT `fk_compliance_leed_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ADD CONSTRAINT `fk_compliance_leed_credit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ADD CONSTRAINT `fk_compliance_pci_control_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ADD CONSTRAINT `fk_compliance_pci_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ADD CONSTRAINT `fk_compliance_iso_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ADD CONSTRAINT `fk_compliance_iso_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ADD CONSTRAINT `fk_compliance_waiver_exemption_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ADD CONSTRAINT `fk_compliance_regulatory_permit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ADD CONSTRAINT `fk_compliance_obligation_calendar_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= compliance --> safety (1 constraint(s)) =========
-- Requires: compliance schema, safety schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);

-- ========= compliance --> schedule (2 constraint(s)) =========
-- Requires: compliance schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ADD CONSTRAINT `fk_compliance_obligation_calendar_schedule_calendar_id` FOREIGN KEY (`schedule_calendar_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_calendar`(`schedule_calendar_id`);

-- ========= contract --> bid (9 constraint(s)) =========
-- Requires: contract schema, bid schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_pursuit_id` FOREIGN KEY (`pursuit_id`) REFERENCES `vibe_construction_v1`.`bid`.`pursuit`(`pursuit_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_bid_payment_application_id` FOREIGN KEY (`bid_payment_application_id`) REFERENCES `vibe_construction_v1`.`bid`.`bid_payment_application`(`bid_payment_application_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ADD CONSTRAINT `fk_contract_insurance_certificate_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ADD CONSTRAINT `fk_contract_scope_of_work_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq`(`boq_id`);

-- ========= contract --> client (3 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= contract --> compliance (4 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);

-- ========= contract --> design (4 constraint(s)) =========
-- Requires: contract schema, design schema
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`prime_eot_claim` ADD CONSTRAINT `fk_contract_prime_eot_claim_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ADD CONSTRAINT `fk_contract_scope_of_work_design_scope_id` FOREIGN KEY (`design_scope_id`) REFERENCES `vibe_construction_v1`.`design`.`design_scope`(`design_scope_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ADD CONSTRAINT `fk_contract_scope_of_work_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= contract --> finance (2 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_financial_guarantee_id` FOREIGN KEY (`financial_guarantee_id`) REFERENCES `vibe_construction_v1`.`finance`.`financial_guarantee`(`financial_guarantee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`retention_account` ADD CONSTRAINT `fk_contract_retention_account_finance_retention_ledger_id` FOREIGN KEY (`finance_retention_ledger_id`) REFERENCES `vibe_construction_v1`.`finance`.`finance_retention_ledger`(`finance_retention_ledger_id`);

-- ========= contract --> hr (12 constraint(s)) =========
-- Requires: contract schema, hr schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ADD CONSTRAINT `fk_contract_dlp_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ADD CONSTRAINT `fk_contract_insurance_certificate_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`prime_eot_claim` ADD CONSTRAINT `fk_contract_prime_eot_claim_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`prime_eot_claim` ADD CONSTRAINT `fk_contract_prime_eot_claim_tertiary_contract_claim_updated_by_user_employee_id` FOREIGN KEY (`tertiary_contract_claim_updated_by_user_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`retention_account` ADD CONSTRAINT `fk_contract_retention_account_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= contract --> material (2 constraint(s)) =========
-- Requires: contract schema, material schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_approved_material_list_id` FOREIGN KEY (`approved_material_list_id`) REFERENCES `vibe_construction_v1`.`material`.`approved_material_list`(`approved_material_list_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= contract --> procurement (6 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ADD CONSTRAINT `fk_contract_advance_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= contract --> project (14 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ADD CONSTRAINT `fk_contract_dlp_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dlp_register` ADD CONSTRAINT `fk_contract_dlp_register_handover_certificate_id` FOREIGN KEY (`handover_certificate_id`) REFERENCES `vibe_construction_v1`.`project`.`handover_certificate`(`handover_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`advance_payment` ADD CONSTRAINT `fk_contract_advance_payment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ADD CONSTRAINT `fk_contract_change_order_activity_impact_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ADD CONSTRAINT `fk_contract_change_order_activity_impact_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_certificate` ADD CONSTRAINT `fk_contract_insurance_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_milestone` ADD CONSTRAINT `fk_contract_payment_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_milestone` ADD CONSTRAINT `fk_contract_payment_milestone_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`prime_eot_claim` ADD CONSTRAINT `fk_contract_prime_eot_claim_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope_of_work` ADD CONSTRAINT `fk_contract_scope_of_work_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= contract --> quality (1 constraint(s)) =========
-- Requires: contract schema, quality schema
ALTER TABLE `vibe_construction_v1`.`contract`.`prime_eot_claim` ADD CONSTRAINT `fk_contract_prime_eot_claim_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= contract --> schedule (1 constraint(s)) =========
-- Requires: contract schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`contract`.`change_order_activity_impact` ADD CONSTRAINT `fk_contract_change_order_activity_impact_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= contract --> site (2 constraint(s)) =========
-- Requires: contract schema, site schema
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_milestone` ADD CONSTRAINT `fk_contract_payment_milestone_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`commercial_change_order` ADD CONSTRAINT `fk_contract_commercial_change_order_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= contract --> sustainability (1 constraint(s)) =========
-- Requires: contract schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_waste_target_id` FOREIGN KEY (`waste_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`waste_target`(`waste_target_id`);

-- ========= design --> bid (6 constraint(s)) =========
-- Requires: design schema, bid schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_bid_contract_agreement_id` FOREIGN KEY (`bid_contract_agreement_id`) REFERENCES `vibe_construction_v1`.`bid`.`bid_contract_agreement`(`bid_contract_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_bid_contract_agreement_id` FOREIGN KEY (`bid_contract_agreement_id`) REFERENCES `vibe_construction_v1`.`bid`.`bid_contract_agreement`(`bid_contract_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `vibe_construction_v1`.`bid`.`trade_package`(`trade_package_id`);

-- ========= design --> client (6 constraint(s)) =========
-- Requires: design schema, client schema
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= design --> compliance (4 constraint(s)) =========
-- Requires: design schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_construction_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);

-- ========= design --> contract (22 constraint(s)) =========
-- Requires: design schema, contract schema
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ADD CONSTRAINT `fk_design_distribution_matrix_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`package` ADD CONSTRAINT `fk_design_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ADD CONSTRAINT `fk_design_clash_detection_run_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`review` ADD CONSTRAINT `fk_design_review_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ADD CONSTRAINT `fk_design_mep_coordination_zone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ADD CONSTRAINT `fk_design_design_scope_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= design --> equipment (6 constraint(s)) =========
-- Requires: design schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ADD CONSTRAINT `fk_design_equipment_installation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ADD CONSTRAINT `fk_design_interface_equipment_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ADD CONSTRAINT `fk_design_change_impact_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ADD CONSTRAINT `fk_design_zone_equipment_allocation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= design --> finance (5 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= design --> hr (32 constraint(s)) =========
-- Requires: design schema, hr schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_primary_revision_employee_id` FOREIGN KEY (`primary_revision_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_tertiary_workflow_escalated_to_employee_id` FOREIGN KEY (`tertiary_workflow_escalated_to_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_primary_correspondence_employee_id` FOREIGN KEY (`primary_correspondence_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_quaternary_quinary_access_created_by_user_employee_id` FOREIGN KEY (`quaternary_quinary_access_created_by_user_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_tertiary_access_approved_by_user_employee_id` FOREIGN KEY (`tertiary_access_approved_by_user_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_tertiary_quaternary_access_revoked_by_user_employee_id` FOREIGN KEY (`tertiary_quaternary_access_revoked_by_user_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_primary_drawing_employee_id` FOREIGN KEY (`primary_drawing_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`package` ADD CONSTRAINT `fk_design_package_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ADD CONSTRAINT `fk_design_clash_detection_run_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`review` ADD CONSTRAINT `fk_design_review_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ADD CONSTRAINT `fk_design_mep_coordination_zone_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ADD CONSTRAINT `fk_design_design_scope_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_primary_calculation_employee_id` FOREIGN KEY (`primary_calculation_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ADD CONSTRAINT `fk_design_equipment_installation_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= design --> material (7 constraint(s)) =========
-- Requires: design schema, material schema
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= design --> project (37 constraint(s)) =========
-- Requires: design schema, project schema
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`distribution_matrix` ADD CONSTRAINT `fk_design_distribution_matrix_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_team_member_id` FOREIGN KEY (`team_member_id`) REFERENCES `vibe_construction_v1`.`project`.`team_member`(`team_member_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`package` ADD CONSTRAINT `fk_design_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`clash_detection_run` ADD CONSTRAINT `fk_design_clash_detection_run_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`review` ADD CONSTRAINT `fk_design_review_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`mep_coordination_zone` ADD CONSTRAINT `fk_design_mep_coordination_zone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`design_scope` ADD CONSTRAINT `fk_design_design_scope_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ADD CONSTRAINT `fk_design_equipment_installation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`equipment_installation` ADD CONSTRAINT `fk_design_equipment_installation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_equipment_assignment` ADD CONSTRAINT `fk_design_interface_equipment_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`change_impact` ADD CONSTRAINT `fk_design_change_impact_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`zone_equipment_allocation` ADD CONSTRAINT `fk_design_zone_equipment_allocation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ADD CONSTRAINT `fk_design_drawing_requirement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ADD CONSTRAINT `fk_design_drawing_incident_link_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_template` ADD CONSTRAINT `fk_design_workflow_template_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`engineering_submittal` ADD CONSTRAINT `fk_design_engineering_submittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= design --> safety (1 constraint(s)) =========
-- Requires: design schema, safety schema
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_incident_link` ADD CONSTRAINT `fk_design_drawing_incident_link_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);

-- ========= design --> schedule (1 constraint(s)) =========
-- Requires: design schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_requirement` ADD CONSTRAINT `fk_design_drawing_requirement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= design --> sustainability (1 constraint(s)) =========
-- Requires: design schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`emission_factor`(`emission_factor_id`);

-- ========= design --> workforce (3 constraint(s)) =========
-- Requires: design schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= equipment --> bid (3 constraint(s)) =========
-- Requires: equipment schema, bid schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= equipment --> compliance (2 constraint(s)) =========
-- Requires: equipment schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_obligation_calendar_id` FOREIGN KEY (`obligation_calendar_id`) REFERENCES `vibe_construction_v1`.`compliance`.`obligation_calendar`(`obligation_calendar_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_construction_v1`.`compliance`.`permit_condition`(`permit_condition_id`);

-- ========= equipment --> contract (10 constraint(s)) =========
-- Requires: equipment schema, contract schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ADD CONSTRAINT `fk_equipment_insurance_policy_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= equipment --> design (1 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);

-- ========= equipment --> finance (8 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ADD CONSTRAINT `fk_equipment_asset_valuation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ADD CONSTRAINT `fk_equipment_asset_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= equipment --> hr (13 constraint(s)) =========
-- Requires: equipment schema, hr schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_tertiary_maintenance_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_maintenance_last_modified_by_user_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ADD CONSTRAINT `fk_equipment_asset_activity_assignment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= equipment --> material (3 constraint(s)) =========
-- Requires: equipment schema, material schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= equipment --> procurement (4 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> project (19 constraint(s)) =========
-- Requires: equipment schema, project schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_asset_current_location_site_construction_project_id` FOREIGN KEY (`asset_current_location_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ADD CONSTRAINT `fk_equipment_insurance_policy_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ADD CONSTRAINT `fk_equipment_asset_activity_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ADD CONSTRAINT `fk_equipment_asset_activity_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= equipment --> schedule (1 constraint(s)) =========
-- Requires: equipment schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ADD CONSTRAINT `fk_equipment_asset_activity_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= equipment --> site (6 constraint(s)) =========
-- Requires: equipment schema, site schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ADD CONSTRAINT `fk_equipment_fuel_point_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ADD CONSTRAINT `fk_equipment_functional_location_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= equipment --> workforce (3 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= finance --> client (4 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= finance --> compliance (2 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= finance --> contract (10 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ADD CONSTRAINT `fk_finance_financial_guarantee_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_payment_application` ADD CONSTRAINT `fk_finance_finance_payment_application_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_lien_waiver` ADD CONSTRAINT `fk_finance_finance_lien_waiver_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= finance --> equipment (1 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= finance --> hr (10 constraint(s)) =========
-- Requires: finance schema, hr schema
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ADD CONSTRAINT `fk_finance_financial_guarantee_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ADD CONSTRAINT `fk_finance_commitment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= finance --> procurement (9 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ADD CONSTRAINT `fk_finance_commitment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ADD CONSTRAINT `fk_finance_commitment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> project (33 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`financial_guarantee` ADD CONSTRAINT `fk_finance_financial_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`billing_period` ADD CONSTRAINT `fk_finance_billing_period_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment` ADD CONSTRAINT `fk_finance_commitment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= finance --> schedule (2 constraint(s)) =========
-- Requires: finance schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);

-- ========= finance --> sustainability (4 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_climate_risk_assessment_id` FOREIGN KEY (`climate_risk_assessment_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`climate_risk_assessment`(`climate_risk_assessment_id`);

-- ========= hr --> finance (1 constraint(s)) =========
-- Requires: hr schema, finance schema
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ADD CONSTRAINT `fk_hr_payroll_group_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= hr --> project (1 constraint(s)) =========
-- Requires: hr schema, project schema
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ADD CONSTRAINT `fk_hr_onboarding_checklist_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= material --> bid (4 constraint(s)) =========
-- Requires: material schema, bid schema
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq`(`boq_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);

-- ========= material --> client (6 constraint(s)) =========
-- Requires: material schema, client schema
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= material --> compliance (3 constraint(s)) =========
-- Requires: material schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ADD CONSTRAINT `fk_material_hazmat_register_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);

-- ========= material --> contract (2 constraint(s)) =========
-- Requires: material schema, contract schema
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);

-- ========= material --> design (1 constraint(s)) =========
-- Requires: material schema, design schema
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);

-- ========= material --> equipment (1 constraint(s)) =========
-- Requires: material schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= material --> finance (6 constraint(s)) =========
-- Requires: material schema, finance schema
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= material --> hr (11 constraint(s)) =========
-- Requires: material schema, hr schema
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ADD CONSTRAINT `fk_material_conformance_certificate_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_primary_requisition_employee_id` FOREIGN KEY (`primary_requisition_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ADD CONSTRAINT `fk_material_approved_material_list_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ADD CONSTRAINT `fk_material_hazmat_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= material --> procurement (4 constraint(s)) =========
-- Requires: material schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= material --> project (13 constraint(s)) =========
-- Requires: material schema, project schema
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ADD CONSTRAINT `fk_material_conformance_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ADD CONSTRAINT `fk_material_physical_inventory_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ADD CONSTRAINT `fk_material_approved_material_list_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_source_site_id` FOREIGN KEY (`source_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);

-- ========= material --> schedule (3 constraint(s)) =========
-- Requires: material schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= material --> site (4 constraint(s)) =========
-- Requires: material schema, site schema
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ADD CONSTRAINT `fk_material_hazmat_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= material --> sustainability (1 constraint(s)) =========
-- Requires: material schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainable_material`(`sustainable_material_id`);

-- ========= material --> workforce (3 constraint(s)) =========
-- Requires: material schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= procurement --> bid (6 constraint(s)) =========
-- Requires: procurement schema, bid schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq`(`boq_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_pursuit_id` FOREIGN KEY (`pursuit_id`) REFERENCES `vibe_construction_v1`.`bid`.`pursuit`(`pursuit_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_pursuit_id` FOREIGN KEY (`pursuit_id`) REFERENCES `vibe_construction_v1`.`bid`.`pursuit`(`pursuit_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ADD CONSTRAINT `fk_procurement_procurement_bid_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= procurement --> client (2 constraint(s)) =========
-- Requires: procurement schema, client schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= procurement --> contract (5 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ADD CONSTRAINT `fk_procurement_po_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= procurement --> design (5 constraint(s)) =========
-- Requires: procurement schema, design schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);

-- ========= procurement --> equipment (4 constraint(s)) =========
-- Requires: procurement schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= procurement --> finance (5 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> hr (14 constraint(s)) =========
-- Requires: procurement schema, hr schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_primary_vendor_evaluator_employee_id` FOREIGN KEY (`primary_vendor_evaluator_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ADD CONSTRAINT `fk_procurement_procurement_bid_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= procurement --> material (4 constraint(s)) =========
-- Requires: procurement schema, material schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= procurement --> project (15 constraint(s)) =========
-- Requires: procurement schema, project schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_rfq_site_construction_project_id` FOREIGN KEY (`rfq_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_amendment` ADD CONSTRAINT `fk_procurement_po_amendment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`procurement_bid` ADD CONSTRAINT `fk_procurement_procurement_bid_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= procurement --> schedule (1 constraint(s)) =========
-- Requires: procurement schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= procurement --> site (1 constraint(s)) =========
-- Requires: procurement schema, site schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_site_location_id` FOREIGN KEY (`site_location_id`) REFERENCES `vibe_construction_v1`.`site`.`site_location`(`site_location_id`);

-- ========= procurement --> sustainability (3 constraint(s)) =========
-- Requires: procurement schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_embodied_carbon_assessment_id` FOREIGN KEY (`embodied_carbon_assessment_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment`(`embodied_carbon_assessment_id`);

-- ========= procurement --> workforce (2 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= project --> client (5 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= project --> compliance (2 constraint(s)) =========
-- Requires: project schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`project`.`regulatory_oversight` ADD CONSTRAINT `fk_project_regulatory_oversight_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`regulatory_oversight` ADD CONSTRAINT `fk_project_regulatory_oversight_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);

-- ========= project --> contract (4 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= project --> design (1 constraint(s)) =========
-- Requires: project schema, design schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);

-- ========= project --> finance (1 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= project --> hr (15 constraint(s)) =========
-- Requires: project schema, hr schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_budget_revision` ADD CONSTRAINT `fk_project_project_budget_revision_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`commissioning_package` ADD CONSTRAINT `fk_project_commissioning_package_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`regulatory_oversight` ADD CONSTRAINT `fk_project_regulatory_oversight_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= project --> material (3 constraint(s)) =========
-- Requires: project schema, material schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= project --> procurement (1 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= project --> schedule (4 constraint(s)) =========
-- Requires: project schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `vibe_construction_v1`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> bid (12 constraint(s)) =========
-- Requires: quality schema, bid schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= quality --> client (4 constraint(s)) =========
-- Requires: quality schema, client schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= quality --> compliance (5 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_construction_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_construction_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);

-- ========= quality --> contract (12 constraint(s)) =========
-- Requires: quality schema, contract schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= quality --> design (17 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_engineering_submittal_id` FOREIGN KEY (`engineering_submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`engineering_submittal`(`engineering_submittal_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= quality --> equipment (5 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= quality --> finance (7 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= quality --> hr (10 constraint(s)) =========
-- Requires: quality schema, hr schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_tertiary_corrective_created_by_employee_id` FOREIGN KEY (`tertiary_corrective_created_by_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_tertiary_checklist_approved_by_employee_id` FOREIGN KEY (`tertiary_checklist_approved_by_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= quality --> procurement (6 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= quality --> project (39 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_checklist_site_construction_project_id` FOREIGN KEY (`checklist_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ADD CONSTRAINT `fk_quality_quality_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_plan` ADD CONSTRAINT `fk_quality_quality_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= quality --> safety (4 constraint(s)) =========
-- Requires: quality schema, safety schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= quality --> schedule (4 constraint(s)) =========
-- Requires: quality schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> site (1 constraint(s)) =========
-- Requires: quality schema, site schema
ALTER TABLE `vibe_construction_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_site_location_id` FOREIGN KEY (`site_location_id`) REFERENCES `vibe_construction_v1`.`site`.`site_location`(`site_location_id`);

-- ========= quality --> sustainability (3 constraint(s)) =========
-- Requires: quality schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_emission`(`carbon_emission_id`);

-- ========= quality --> workforce (9 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= safety --> bid (10 constraint(s)) =========
-- Requires: safety schema, bid schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ADD CONSTRAINT `fk_safety_incident_subcontractor_involvement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= safety --> client (6 constraint(s)) =========
-- Requires: safety schema, client schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= safety --> compliance (4 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_construction_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= safety --> contract (11 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ADD CONSTRAINT `fk_safety_incident_subcontractor_involvement_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);

-- ========= safety --> design (2 constraint(s)) =========
-- Requires: safety schema, design schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_interface_point_id` FOREIGN KEY (`interface_point_id`) REFERENCES `vibe_construction_v1`.`design`.`interface_point`(`interface_point_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_design_scope_id` FOREIGN KEY (`design_scope_id`) REFERENCES `vibe_construction_v1`.`design`.`design_scope`(`design_scope_id`);

-- ========= safety --> equipment (6 constraint(s)) =========
-- Requires: safety schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= safety --> finance (9 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= safety --> hr (15 constraint(s)) =========
-- Requires: safety schema, hr schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_tertiary_incident_approved_by_employee_id` FOREIGN KEY (`tertiary_incident_approved_by_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_tertiary_swms_prepared_by_employee_id` FOREIGN KEY (`tertiary_swms_prepared_by_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= safety --> material (4 constraint(s)) =========
-- Requires: safety schema, material schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= safety --> procurement (2 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> project (19 constraint(s)) =========
-- Requires: safety schema, project schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ADD CONSTRAINT `fk_safety_incident_subcontractor_involvement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= safety --> quality (1 constraint(s)) =========
-- Requires: safety schema, quality schema
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);

-- ========= safety --> schedule (1 constraint(s)) =========
-- Requires: safety schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= safety --> site (8 constraint(s)) =========
-- Requires: safety schema, site schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= safety --> sustainability (1 constraint(s)) =========
-- Requires: safety schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);

-- ========= safety --> workforce (6 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= schedule --> bid (4 constraint(s)) =========
-- Requires: schedule schema, bid schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_pursuit_risk_id` FOREIGN KEY (`pursuit_risk_id`) REFERENCES `vibe_construction_v1`.`bid`.`pursuit_risk`(`pursuit_risk_id`);

-- ========= schedule --> client (1 constraint(s)) =========
-- Requires: schedule schema, client schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ADD CONSTRAINT `fk_schedule_schedule_impact_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= schedule --> compliance (4 constraint(s)) =========
-- Requires: schedule schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= schedule --> contract (4 constraint(s)) =========
-- Requires: schedule schema, contract schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ADD CONSTRAINT `fk_schedule_scheduled_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ADD CONSTRAINT `fk_schedule_scheduled_event_payment_milestone_id` FOREIGN KEY (`payment_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_milestone`(`payment_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ADD CONSTRAINT `fk_schedule_schedule_impact_claim_prime_eot_claim_id` FOREIGN KEY (`prime_eot_claim_id`) REFERENCES `vibe_construction_v1`.`contract`.`prime_eot_claim`(`prime_eot_claim_id`);

-- ========= schedule --> design (3 constraint(s)) =========
-- Requires: schedule schema, design schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_engineering_submittal_id` FOREIGN KEY (`engineering_submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`engineering_submittal`(`engineering_submittal_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_interface_point_id` FOREIGN KEY (`interface_point_id`) REFERENCES `vibe_construction_v1`.`design`.`interface_point`(`interface_point_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_mep_coordination_zone_id` FOREIGN KEY (`mep_coordination_zone_id`) REFERENCES `vibe_construction_v1`.`design`.`mep_coordination_zone`(`mep_coordination_zone_id`);

-- ========= schedule --> equipment (3 constraint(s)) =========
-- Requires: schedule schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= schedule --> finance (4 constraint(s)) =========
-- Requires: schedule schema, finance schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= schedule --> hr (10 constraint(s)) =========
-- Requires: schedule schema, hr schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ADD CONSTRAINT `fk_schedule_scheduled_event_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ADD CONSTRAINT `fk_schedule_schedule_impact_claim_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= schedule --> material (1 constraint(s)) =========
-- Requires: schedule schema, material schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= schedule --> procurement (3 constraint(s)) =========
-- Requires: schedule schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= schedule --> project (16 constraint(s)) =========
-- Requires: schedule schema, project schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ADD CONSTRAINT `fk_schedule_schedule_calendar_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ADD CONSTRAINT `fk_schedule_scheduled_event_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ADD CONSTRAINT `fk_schedule_scheduled_event_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ADD CONSTRAINT `fk_schedule_schedule_impact_claim_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= schedule --> quality (1 constraint(s)) =========
-- Requires: schedule schema, quality schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);

-- ========= schedule --> safety (2 constraint(s)) =========
-- Requires: schedule schema, safety schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);

-- ========= schedule --> workforce (3 constraint(s)) =========
-- Requires: schedule schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ADD CONSTRAINT `fk_schedule_scheduled_event_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= site --> bid (11 constraint(s)) =========
-- Requires: site schema, bid schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_bid_pricing_line_id` FOREIGN KEY (`bid_pricing_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`bid_pricing_line`(`bid_pricing_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);

-- ========= site --> client (3 constraint(s)) =========
-- Requires: site schema, client schema
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ADD CONSTRAINT `fk_site_logistics_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= site --> compliance (7 constraint(s)) =========
-- Requires: site schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);

-- ========= site --> contract (5 constraint(s)) =========
-- Requires: site schema, contract schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= site --> design (6 constraint(s)) =========
-- Requires: site schema, design schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_design_scope_id` FOREIGN KEY (`design_scope_id`) REFERENCES `vibe_construction_v1`.`design`.`design_scope`(`design_scope_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_engineering_submittal_id` FOREIGN KEY (`engineering_submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`engineering_submittal`(`engineering_submittal_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_change_notice_id` FOREIGN KEY (`change_notice_id`) REFERENCES `vibe_construction_v1`.`design`.`change_notice`(`change_notice_id`);

-- ========= site --> equipment (8 constraint(s)) =========
-- Requires: site schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_hours_id` FOREIGN KEY (`hours_id`) REFERENCES `vibe_construction_v1`.`equipment`.`hours`(`hours_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= site --> finance (8 constraint(s)) =========
-- Requires: site schema, finance schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= site --> hr (20 constraint(s)) =========
-- Requires: site schema, hr schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ADD CONSTRAINT `fk_site_logistics_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_tertiary_lift_rigger_in_charge_employee_id` FOREIGN KEY (`tertiary_lift_rigger_in_charge_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_tertiary_site_close_out_by_employee_id` FOREIGN KEY (`tertiary_site_close_out_by_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_site_manager_employee_id` FOREIGN KEY (`site_manager_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ADD CONSTRAINT `fk_site_site_location_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= site --> procurement (5 constraint(s)) =========
-- Requires: site schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_procurement_framework_agreement_id` FOREIGN KEY (`procurement_framework_agreement_id`) REFERENCES `vibe_construction_v1`.`procurement`.`procurement_framework_agreement`(`procurement_framework_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= site --> project (25 constraint(s)) =========
-- Requires: site schema, project schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_work_site_construction_project_id` FOREIGN KEY (`work_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_daily_site_construction_project_id` FOREIGN KEY (`daily_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ADD CONSTRAINT `fk_site_logistics_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_material_site_construction_project_id` FOREIGN KEY (`material_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_lift_site_construction_project_id` FOREIGN KEY (`lift_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_shift_site_construction_project_id` FOREIGN KEY (`shift_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ADD CONSTRAINT `fk_site_work_front_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ADD CONSTRAINT `fk_site_site_location_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= site --> quality (2 constraint(s)) =========
-- Requires: site schema, quality schema
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);

-- ========= site --> safety (4 constraint(s)) =========
-- Requires: site schema, safety schema
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= site --> schedule (12 constraint(s)) =========
-- Requires: site schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= site --> workforce (6 constraint(s)) =========
-- Requires: site schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ADD CONSTRAINT `fk_site_work_front_assignment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ADD CONSTRAINT `fk_site_work_front_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= subcontractor --> bid (1 constraint(s)) =========
-- Requires: subcontractor schema, bid schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ADD CONSTRAINT `fk_subcontractor_performance_scorecard_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= subcontractor --> contract (8 constraint(s)) =========
-- Requires: subcontractor schema, contract schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ADD CONSTRAINT `fk_subcontractor_final_account_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ADD CONSTRAINT `fk_subcontractor_performance_scorecard_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ADD CONSTRAINT `fk_subcontractor_sub_time_extension_prime_eot_claim_id` FOREIGN KEY (`prime_eot_claim_id`) REFERENCES `vibe_construction_v1`.`contract`.`prime_eot_claim`(`prime_eot_claim_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ADD CONSTRAINT `fk_subcontractor_sub_time_extension_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_commercial_change_order_id` FOREIGN KEY (`commercial_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`commercial_change_order`(`commercial_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);

-- ========= subcontractor --> finance (2 constraint(s)) =========
-- Requires: subcontractor schema, finance schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= subcontractor --> hr (5 constraint(s)) =========
-- Requires: subcontractor schema, hr schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ADD CONSTRAINT `fk_subcontractor_final_account_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ADD CONSTRAINT `fk_subcontractor_performance_scorecard_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ADD CONSTRAINT `fk_subcontractor_sub_time_extension_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= subcontractor --> procurement (1 constraint(s)) =========
-- Requires: subcontractor schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ADD CONSTRAINT `fk_subcontractor_performance_scorecard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= subcontractor --> project (8 constraint(s)) =========
-- Requires: subcontractor schema, project schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ADD CONSTRAINT `fk_subcontractor_final_account_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ADD CONSTRAINT `fk_subcontractor_performance_scorecard_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ADD CONSTRAINT `fk_subcontractor_sub_time_extension_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_change_order` ADD CONSTRAINT `fk_subcontractor_sub_change_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= subcontractor --> schedule (1 constraint(s)) =========
-- Requires: subcontractor schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`sub_time_extension` ADD CONSTRAINT `fk_subcontractor_sub_time_extension_schedule_impact_claim_id` FOREIGN KEY (`schedule_impact_claim_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_impact_claim`(`schedule_impact_claim_id`);

-- ========= subcontractor --> sustainability (1 constraint(s)) =========
-- Requires: subcontractor schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` ADD CONSTRAINT `fk_subcontractor_performance_scorecard_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`esg_report`(`esg_report_id`);

-- ========= sustainability --> client (13 constraint(s)) =========
-- Requires: sustainability schema, client schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ADD CONSTRAINT `fk_sustainability_carbon_target_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ADD CONSTRAINT `fk_sustainability_green_certification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ADD CONSTRAINT `fk_sustainability_sustainability_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_carrier` ADD CONSTRAINT `fk_sustainability_waste_carrier_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`disposal_facility` ADD CONSTRAINT `fk_sustainability_disposal_facility_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= sustainability --> compliance (8 constraint(s)) =========
-- Requires: sustainability schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_construction_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_factor` ADD CONSTRAINT `fk_sustainability_emission_factor_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ADD CONSTRAINT `fk_sustainability_sustainability_plan_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `vibe_construction_v1`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_iso_audit_id` FOREIGN KEY (`iso_audit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`iso_audit`(`iso_audit_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);

-- ========= sustainability --> contract (1 constraint(s)) =========
-- Requires: sustainability schema, contract schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= sustainability --> design (1 constraint(s)) =========
-- Requires: sustainability schema, design schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ADD CONSTRAINT `fk_sustainability_sustainable_material_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);

-- ========= sustainability --> equipment (8 constraint(s)) =========
-- Requires: sustainability schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_target` ADD CONSTRAINT `fk_sustainability_carbon_target_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ADD CONSTRAINT `fk_sustainability_climate_risk_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= sustainability --> hr (13 constraint(s)) =========
-- Requires: sustainability schema, hr schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ADD CONSTRAINT `fk_sustainability_green_credit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ADD CONSTRAINT `fk_sustainability_climate_risk_item_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_plan` ADD CONSTRAINT `fk_sustainability_sustainability_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= sustainability --> procurement (3 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainable_material` ADD CONSTRAINT `fk_sustainability_sustainable_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= sustainability --> project (20 constraint(s)) =========
-- Requires: sustainability schema, project schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_target` ADD CONSTRAINT `fk_sustainability_waste_target_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_certification` ADD CONSTRAINT `fk_sustainability_green_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`green_credit` ADD CONSTRAINT `fk_sustainability_green_credit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment` ADD CONSTRAINT `fk_sustainability_embodied_carbon_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`climate_risk_item` ADD CONSTRAINT `fk_sustainability_climate_risk_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`social_value_record` ADD CONSTRAINT `fk_sustainability_social_value_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_sustainability_site_construction_project_id` FOREIGN KEY (`sustainability_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= sustainability --> schedule (5 constraint(s)) =========
-- Requires: sustainability schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= sustainability --> site (4 constraint(s)) =========
-- Requires: sustainability schema, site schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `vibe_construction_v1`.`site`.`site_mobilization`(`site_mobilization_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `vibe_construction_v1`.`site`.`site_mobilization`(`site_mobilization_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `vibe_construction_v1`.`site`.`site_mobilization`(`site_mobilization_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `vibe_construction_v1`.`site`.`site_mobilization`(`site_mobilization_id`);

-- ========= sustainability --> workforce (3 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= workforce --> bid (6 constraint(s)) =========
-- Requires: workforce schema, bid schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ADD CONSTRAINT `fk_workforce_site_access_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= workforce --> client (4 constraint(s)) =========
-- Requires: workforce schema, client schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ADD CONSTRAINT `fk_workforce_agency_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= workforce --> compliance (3 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);

-- ========= workforce --> contract (4 constraint(s)) =========
-- Requires: workforce schema, contract schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= workforce --> equipment (2 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= workforce --> finance (13 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= workforce --> hr (11 constraint(s)) =========
-- Requires: workforce schema, hr schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ADD CONSTRAINT `fk_workforce_skill_trade_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ADD CONSTRAINT `fk_workforce_site_access_record_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);

-- ========= workforce --> procurement (1 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= workforce --> project (21 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ADD CONSTRAINT `fk_workforce_site_access_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_primary_labor_construction_project_id` FOREIGN KEY (`primary_labor_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ADD CONSTRAINT `fk_workforce_carbon_reduction_participation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= workforce --> schedule (2 constraint(s)) =========
-- Requires: workforce schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= workforce --> sustainability (1 constraint(s)) =========
-- Requires: workforce schema, sustainability schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ADD CONSTRAINT `fk_workforce_carbon_reduction_participation_carbon_reduction_initiative_id` FOREIGN KEY (`carbon_reduction_initiative_id`) REFERENCES `vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative`(`carbon_reduction_initiative_id`);

