-- Cross-Domain Foreign Keys for Business: Construction | Version: v2_mvm
-- Generated on: 2026-07-10 14:35:56
-- Total cross-domain FK constraints: 820
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: bid, client, contract, design, equipment, finance, procurement, project, quality, safety, schedule, site, workforce

-- ========= bid --> client (8 constraint(s)) =========
-- Requires: bid schema, client schema
ALTER TABLE `vibe_construction_v1`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `vibe_construction_v1`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= bid --> design (12 constraint(s)) =========
-- Requires: bid schema, design schema
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ADD CONSTRAINT `fk_bid_boq_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ADD CONSTRAINT `fk_bid_boq_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= bid --> equipment (3 constraint(s)) =========
-- Requires: bid schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= bid --> finance (5 constraint(s)) =========
-- Requires: bid schema, finance schema
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ADD CONSTRAINT `fk_bid_boq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= bid --> procurement (3 constraint(s)) =========
-- Requires: bid schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ADD CONSTRAINT `fk_bid_boq_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= bid --> project (3 constraint(s)) =========
-- Requires: bid schema, project schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= bid --> quality (1 constraint(s)) =========
-- Requires: bid schema, quality schema
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);

-- ========= bid --> schedule (1 constraint(s)) =========
-- Requires: bid schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);

-- ========= bid --> workforce (9 constraint(s)) =========
-- Requires: bid schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `vibe_construction_v1`.`workforce`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ADD CONSTRAINT `fk_bid_boq_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`boq_line` ADD CONSTRAINT `fk_bid_boq_line_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `vibe_construction_v1`.`workforce`.`staffing_plan`(`staffing_plan_id`);

-- ========= client --> bid (3 constraint(s)) =========
-- Requires: client schema, bid schema
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_construction_v1`.`bid`.`submission`(`submission_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`prequalification` ADD CONSTRAINT `fk_client_prequalification_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= client --> contract (1 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= client --> design (1 constraint(s)) =========
-- Requires: client schema, design schema
ALTER TABLE `vibe_construction_v1`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= client --> project (1 constraint(s)) =========
-- Requires: client schema, project schema
ALTER TABLE `vibe_construction_v1`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= client --> schedule (1 constraint(s)) =========
-- Requires: client schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);

-- ========= contract --> bid (7 constraint(s)) =========
-- Requires: contract schema, bid schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq`(`boq_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_bond_id` FOREIGN KEY (`bond_id`) REFERENCES `vibe_construction_v1`.`bid`.`bond`(`bond_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= contract --> client (4 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `vibe_construction_v1`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= contract --> design (1 constraint(s)) =========
-- Requires: contract schema, design schema
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= contract --> equipment (1 constraint(s)) =========
-- Requires: contract schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);

-- ========= contract --> procurement (6 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);

-- ========= contract --> project (3 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`insurance_register` ADD CONSTRAINT `fk_contract_insurance_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= contract --> quality (3 constraint(s)) =========
-- Requires: contract schema, quality schema
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= contract --> safety (4 constraint(s)) =========
-- Requires: contract schema, safety schema
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);

-- ========= contract --> schedule (1 constraint(s)) =========
-- Requires: contract schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);

-- ========= contract --> workforce (5 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `vibe_construction_v1`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= design --> bid (4 constraint(s)) =========
-- Requires: design schema, bid schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= design --> client (5 constraint(s)) =========
-- Requires: design schema, client schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`review` ADD CONSTRAINT `fk_design_review_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= design --> contract (9 constraint(s)) =========
-- Requires: design schema, contract schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_primary_agreement_id` FOREIGN KEY (`primary_agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`review` ADD CONSTRAINT `fk_design_review_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= design --> finance (2 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= design --> procurement (3 constraint(s)) =========
-- Requires: design schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= design --> project (2 constraint(s)) =========
-- Requires: design schema, project schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= design --> site (1 constraint(s)) =========
-- Requires: design schema, site schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);

-- ========= design --> workforce (2 constraint(s)) =========
-- Requires: design schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);

-- ========= equipment --> bid (3 constraint(s)) =========
-- Requires: equipment schema, bid schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= equipment --> client (1 constraint(s)) =========
-- Requires: equipment schema, client schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= equipment --> contract (13 constraint(s)) =========
-- Requires: equipment schema, contract schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= equipment --> design (8 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);

-- ========= equipment --> finance (12 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);

-- ========= equipment --> procurement (9 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> project (18 constraint(s)) =========
-- Requires: equipment schema, project schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= equipment --> safety (7 constraint(s)) =========
-- Requires: equipment schema, safety schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= equipment --> schedule (7 constraint(s)) =========
-- Requires: equipment schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `vibe_construction_v1`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `vibe_construction_v1`.`schedule`.`delay_event`(`delay_event_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= equipment --> site (2 constraint(s)) =========
-- Requires: equipment schema, site schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `vibe_construction_v1`.`site`.`site_mobilization`(`site_mobilization_id`);

-- ========= equipment --> workforce (12 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= finance --> client (7 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);

-- ========= finance --> contract (14 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_payment_schedule_id` FOREIGN KEY (`payment_schedule_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_schedule`(`payment_schedule_id`);

-- ========= finance --> equipment (2 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= finance --> procurement (4 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> project (30 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_evm_period_record_id` FOREIGN KEY (`evm_period_record_id`) REFERENCES `vibe_construction_v1`.`project`.`evm_period_record`(`evm_period_record_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_construction_v1`.`project`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_construction_v1`.`project`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_progress_measurement_id` FOREIGN KEY (`progress_measurement_id`) REFERENCES `vibe_construction_v1`.`project`.`progress_measurement`(`progress_measurement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `vibe_construction_v1`.`project`.`forecast`(`forecast_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `vibe_construction_v1`.`project`.`risk_register`(`risk_register_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= finance --> schedule (5 constraint(s)) =========
-- Requires: finance schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `vibe_construction_v1`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);

-- ========= procurement --> bid (6 constraint(s)) =========
-- Requires: procurement schema, bid schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq`(`boq_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_boq_line_id` FOREIGN KEY (`boq_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq_line`(`boq_line_id`);

-- ========= procurement --> client (2 constraint(s)) =========
-- Requires: procurement schema, client schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `vibe_construction_v1`.`client`.`rfp_issuance`(`rfp_issuance_id`);

-- ========= procurement --> contract (4 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= procurement --> design (9 constraint(s)) =========
-- Requires: procurement schema, design schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= procurement --> equipment (3 constraint(s)) =========
-- Requires: procurement schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= procurement --> finance (10 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_construction_v1`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= procurement --> project (11 constraint(s)) =========
-- Requires: procurement schema, project schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `vibe_construction_v1`.`project`.`project_change_order`(`project_change_order_id`);

-- ========= procurement --> schedule (1 constraint(s)) =========
-- Requires: procurement schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= procurement --> workforce (9 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `vibe_construction_v1`.`workforce`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);

-- ========= project --> bid (3 constraint(s)) =========
-- Requires: project schema, bid schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_boq_line_id` FOREIGN KEY (`boq_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq_line`(`boq_line_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_boq_line_id` FOREIGN KEY (`boq_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq_line`(`boq_line_id`);

-- ========= project --> client (7 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= project --> contract (7 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= project --> design (5 constraint(s)) =========
-- Requires: project schema, design schema
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= project --> procurement (1 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= project --> schedule (4 constraint(s)) =========
-- Requires: project schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `vibe_construction_v1`.`schedule`.`delay_event`(`delay_event_id`);

-- ========= quality --> bid (6 constraint(s)) =========
-- Requires: quality schema, bid schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= quality --> client (14 constraint(s)) =========
-- Requires: quality schema, client schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= quality --> contract (11 constraint(s)) =========
-- Requires: quality schema, contract schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);

-- ========= quality --> design (18 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= quality --> equipment (3 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= quality --> finance (8 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= quality --> procurement (11 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_construction_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= quality --> project (22 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= quality --> safety (9 constraint(s)) =========
-- Requires: quality schema, safety schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= quality --> schedule (2 constraint(s)) =========
-- Requires: quality schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> site (4 constraint(s)) =========
-- Requires: quality schema, site schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= quality --> workforce (10 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= safety --> bid (7 constraint(s)) =========
-- Requires: safety schema, bid schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= safety --> client (7 constraint(s)) =========
-- Requires: safety schema, client schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= safety --> contract (8 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);

-- ========= safety --> design (8 constraint(s)) =========
-- Requires: safety schema, design schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= safety --> equipment (6 constraint(s)) =========
-- Requires: safety schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= safety --> finance (3 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);

-- ========= safety --> procurement (9 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> project (15 constraint(s)) =========
-- Requires: safety schema, project schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);

-- ========= safety --> quality (3 constraint(s)) =========
-- Requires: safety schema, quality schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `vibe_construction_v1`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= safety --> workforce (13 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);

-- ========= schedule --> bid (3 constraint(s)) =========
-- Requires: schedule schema, bid schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `vibe_construction_v1`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `vibe_construction_v1`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_estimate_line_id` FOREIGN KEY (`estimate_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`estimate_line`(`estimate_line_id`);

-- ========= schedule --> contract (7 constraint(s)) =========
-- Requires: schedule schema, contract schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_eot_claim_id` FOREIGN KEY (`eot_claim_id`) REFERENCES `vibe_construction_v1`.`contract`.`eot_claim`(`eot_claim_id`);

-- ========= schedule --> design (4 constraint(s)) =========
-- Requires: schedule schema, design schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_review_id` FOREIGN KEY (`review_id`) REFERENCES `vibe_construction_v1`.`design`.`review`(`review_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= schedule --> equipment (2 constraint(s)) =========
-- Requires: schedule schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= schedule --> finance (5 constraint(s)) =========
-- Requires: schedule schema, finance schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);

-- ========= schedule --> procurement (3 constraint(s)) =========
-- Requires: schedule schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= schedule --> project (4 constraint(s)) =========
-- Requires: schedule schema, project schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= schedule --> quality (1 constraint(s)) =========
-- Requires: schedule schema, quality schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);

-- ========= schedule --> safety (7 constraint(s)) =========
-- Requires: schedule schema, safety schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);

-- ========= schedule --> site (3 constraint(s)) =========
-- Requires: schedule schema, site schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_field_progress_id` FOREIGN KEY (`field_progress_id`) REFERENCES `vibe_construction_v1`.`site`.`field_progress`(`field_progress_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);

-- ========= schedule --> workforce (2 constraint(s)) =========
-- Requires: schedule schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= site --> bid (11 constraint(s)) =========
-- Requires: site schema, bid schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_boq_line_id` FOREIGN KEY (`boq_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq_line`(`boq_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_estimate_line_id` FOREIGN KEY (`estimate_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`estimate_line`(`estimate_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_estimate_line_id` FOREIGN KEY (`estimate_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`estimate_line`(`estimate_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_boq_line_id` FOREIGN KEY (`boq_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq_line`(`boq_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_boq_line_id` FOREIGN KEY (`boq_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`boq_line`(`boq_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_estimate_line_id` FOREIGN KEY (`estimate_line_id`) REFERENCES `vibe_construction_v1`.`bid`.`estimate_line`(`estimate_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= site --> client (4 constraint(s)) =========
-- Requires: site schema, client schema
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= site --> contract (11 constraint(s)) =========
-- Requires: site schema, contract schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);

-- ========= site --> design (15 constraint(s)) =========
-- Requires: site schema, design schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);

-- ========= site --> equipment (14 constraint(s)) =========
-- Requires: site schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_hours_id` FOREIGN KEY (`hours_id`) REFERENCES `vibe_construction_v1`.`equipment`.`hours`(`hours_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `vibe_construction_v1`.`equipment`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_operator_certification_id` FOREIGN KEY (`operator_certification_id`) REFERENCES `vibe_construction_v1`.`equipment`.`operator_certification`(`operator_certification_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_construction_v1`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_operator_certification_id` FOREIGN KEY (`operator_certification_id`) REFERENCES `vibe_construction_v1`.`equipment`.`operator_certification`(`operator_certification_id`);

-- ========= site --> finance (16 constraint(s)) =========
-- Requires: site schema, finance schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `vibe_construction_v1`.`finance`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);

-- ========= site --> procurement (20 constraint(s)) =========
-- Requires: site schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_construction_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_construction_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= site --> project (39 constraint(s)) =========
-- Requires: site schema, project schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_material_site_construction_project_id` FOREIGN KEY (`material_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_shift_site_construction_project_id` FOREIGN KEY (`shift_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= site --> quality (11 constraint(s)) =========
-- Requires: site schema, quality schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_test_certificate_id` FOREIGN KEY (`test_certificate_id`) REFERENCES `vibe_construction_v1`.`quality`.`test_certificate`(`test_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= site --> safety (10 constraint(s)) =========
-- Requires: site schema, safety schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= site --> schedule (9 constraint(s)) =========
-- Requires: site schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= site --> workforce (13 constraint(s)) =========
-- Requires: site schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= workforce --> bid (5 constraint(s)) =========
-- Requires: workforce schema, bid schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `vibe_construction_v1`.`bid`.`tender`(`tender_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `vibe_construction_v1`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= workforce --> client (3 constraint(s)) =========
-- Requires: workforce schema, client schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= workforce --> contract (5 constraint(s)) =========
-- Requires: workforce schema, contract schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= workforce --> equipment (3 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);

-- ========= workforce --> finance (10 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_construction_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `vibe_construction_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= workforce --> procurement (8 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= workforce --> project (16 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_primary_labor_construction_project_id` FOREIGN KEY (`primary_labor_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);

-- ========= workforce --> quality (2 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);

-- ========= workforce --> safety (2 constraint(s)) =========
-- Requires: workforce schema, safety schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);

-- ========= workforce --> schedule (3 constraint(s)) =========
-- Requires: workforce schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);

-- ========= workforce --> site (1 constraint(s)) =========
-- Requires: workforce schema, site schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `vibe_construction_v1`.`site`.`site_mobilization`(`site_mobilization_id`);

