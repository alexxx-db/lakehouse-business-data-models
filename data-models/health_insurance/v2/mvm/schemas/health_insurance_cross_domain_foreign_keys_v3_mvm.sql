-- Cross-Domain Foreign Keys for Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:34
-- Total cross-domain FK constraints: 469
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, care, claim, compliance, contract, employer, enrollment, member, network, pharmacy, plan, provider, risk, utilization

-- ========= billing --> care (4 constraint(s)) =========
-- Requires: billing schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);

-- ========= billing --> compliance (4 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= billing --> employer (3 constraint(s)) =========
-- Requires: billing schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);

-- ========= billing --> enrollment (8 constraint(s)) =========
-- Requires: billing schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_cms_submission_id` FOREIGN KEY (`cms_submission_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`cms_submission`(`cms_submission_id`);

-- ========= billing --> member (8 constraint(s)) =========
-- Requires: billing schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= billing --> network (2 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= billing --> pharmacy (1 constraint(s)) =========
-- Requires: billing schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);

-- ========= billing --> plan (3 constraint(s)) =========
-- Requires: billing schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= billing --> provider (4 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);

-- ========= billing --> risk (1 constraint(s)) =========
-- Requires: billing schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`raps_submission`(`raps_submission_id`);

-- ========= care --> compliance (4 constraint(s)) =========
-- Requires: care schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ADD CONSTRAINT `fk_care_hedis_measure_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ADD CONSTRAINT `fk_care_hedis_measure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= care --> contract (3 constraint(s)) =========
-- Requires: care schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);

-- ========= care --> enrollment (3 constraint(s)) =========
-- Requires: care schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= care --> member (10 constraint(s)) =========
-- Requires: care schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= care --> provider (12 constraint(s)) =========
-- Requires: care schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ADD CONSTRAINT `fk_care_coordinator_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= care --> risk (7 constraint(s)) =========
-- Requires: care schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_rate_development_id` FOREIGN KEY (`rate_development_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`rate_development`(`rate_development_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= claim --> billing (5 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= claim --> care (2 constraint(s)) =========
-- Requires: claim schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);

-- ========= claim --> compliance (3 constraint(s)) =========
-- Requires: claim schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_fwa_case_id` FOREIGN KEY (`fwa_case_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`fwa_case`(`fwa_case_id`);

-- ========= claim --> contract (7 constraint(s)) =========
-- Requires: claim schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fee_schedule_rate_id` FOREIGN KEY (`fee_schedule_rate_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`(`fee_schedule_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_fee_schedule_rate_id` FOREIGN KEY (`fee_schedule_rate_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`(`fee_schedule_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);

-- ========= claim --> employer (3 constraint(s)) =========
-- Requires: claim schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_stop_loss_policy_id` FOREIGN KEY (`stop_loss_policy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`stop_loss_policy`(`stop_loss_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= claim --> enrollment (3 constraint(s)) =========
-- Requires: claim schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_eligibility_verification_id` FOREIGN KEY (`eligibility_verification_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`(`eligibility_verification_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= claim --> member (12 constraint(s)) =========
-- Requires: claim schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_cob_record_id` FOREIGN KEY (`cob_record_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`cob_record`(`cob_record_id`);

-- ========= claim --> network (5 constraint(s)) =========
-- Requires: claim schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);

-- ========= claim --> pharmacy (9 constraint(s)) =========
-- Requires: claim schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_formulary_drug_tier_id` FOREIGN KEY (`formulary_drug_tier_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier`(`formulary_drug_tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_formulary_exception_id` FOREIGN KEY (`formulary_exception_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception`(`formulary_exception_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_dispensing_pharmacy_id` FOREIGN KEY (`dispensing_pharmacy_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`(`dispensing_pharmacy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);

-- ========= claim --> plan (20 constraint(s)) =========
-- Requires: claim schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`plan_service_area`(`plan_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);

-- ========= claim --> provider (12 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= claim --> risk (3 constraint(s)) =========
-- Requires: claim schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_radv_audit_id` FOREIGN KEY (`radv_audit_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`radv_audit`(`radv_audit_id`);

-- ========= claim --> utilization (9 constraint(s)) =========
-- Requires: claim schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);

-- ========= compliance --> billing (3 constraint(s)) =========
-- Requires: compliance schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);

-- ========= compliance --> claim (2 constraint(s)) =========
-- Requires: compliance schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_eob_id` FOREIGN KEY (`eob_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`eob`(`eob_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= compliance --> employer (2 constraint(s)) =========
-- Requires: compliance schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= compliance --> member (1 constraint(s)) =========
-- Requires: compliance schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= compliance --> plan (10 constraint(s)) =========
-- Requires: compliance schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`plan_service_area`(`plan_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_primary_mlr_product_health_plan_id` FOREIGN KEY (`primary_mlr_product_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);

-- ========= compliance --> provider (12 constraint(s)) =========
-- Requires: compliance schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_license_id` FOREIGN KEY (`license_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`license`(`license_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_affiliation_id` FOREIGN KEY (`affiliation_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`affiliation`(`affiliation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= contract --> compliance (3 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ADD CONSTRAINT `fk_contract_reimbursement_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= contract --> plan (5 constraint(s)) =========
-- Requires: contract schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ADD CONSTRAINT `fk_contract_reimbursement_policy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);

-- ========= contract --> provider (4 constraint(s)) =========
-- Requires: contract schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= contract --> risk (1 constraint(s)) =========
-- Requires: contract schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= employer --> network (1 constraint(s)) =========
-- Requires: employer schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);

-- ========= employer --> plan (11 constraint(s)) =========
-- Requires: employer schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`plan_service_area`(`plan_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);

-- ========= employer --> provider (1 constraint(s)) =========
-- Requires: employer schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);

-- ========= enrollment --> compliance (4 constraint(s)) =========
-- Requires: enrollment schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_breach_incident_id` FOREIGN KEY (`breach_incident_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_incident`(`breach_incident_id`);

-- ========= enrollment --> employer (1 constraint(s)) =========
-- Requires: enrollment schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);

-- ========= enrollment --> member (2 constraint(s)) =========
-- Requires: enrollment schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= enrollment --> pharmacy (2 constraint(s)) =========
-- Requires: enrollment schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);

-- ========= enrollment --> plan (10 constraint(s)) =========
-- Requires: enrollment schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);

-- ========= enrollment --> provider (4 constraint(s)) =========
-- Requires: enrollment schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= enrollment --> risk (1 constraint(s)) =========
-- Requires: enrollment schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= member --> care (2 constraint(s)) =========
-- Requires: member schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= member --> claim (1 constraint(s)) =========
-- Requires: member schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= member --> compliance (2 constraint(s)) =========
-- Requires: member schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= member --> contract (5 constraint(s)) =========
-- Requires: member schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);

-- ========= member --> employer (5 constraint(s)) =========
-- Requires: member schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_group_location_id` FOREIGN KEY (`group_location_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_location`(`group_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= member --> enrollment (1 constraint(s)) =========
-- Requires: member schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= member --> network (7 constraint(s)) =========
-- Requires: member schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_assignment_id` FOREIGN KEY (`provider_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_assignment`(`provider_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= member --> pharmacy (5 constraint(s)) =========
-- Requires: member schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_formulary_exception_id` FOREIGN KEY (`formulary_exception_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception`(`formulary_exception_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);

-- ========= member --> plan (15 constraint(s)) =========
-- Requires: member schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ADD CONSTRAINT `fk_member_address_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`plan_service_area`(`plan_service_area_id`);

-- ========= member --> provider (8 constraint(s)) =========
-- Requires: member schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= member --> utilization (2 constraint(s)) =========
-- Requires: member schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);

-- ========= network --> compliance (4 constraint(s)) =========
-- Requires: network schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ADD CONSTRAINT `fk_network_adequacy_standard_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ADD CONSTRAINT `fk_network_network_service_area_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= network --> contract (7 constraint(s)) =========
-- Requires: network schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);

-- ========= network --> employer (1 constraint(s)) =========
-- Requires: network schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= network --> pharmacy (1 constraint(s)) =========
-- Requires: network schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_dispensing_pharmacy_id` FOREIGN KEY (`dispensing_pharmacy_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`(`dispensing_pharmacy_id`);

-- ========= network --> plan (3 constraint(s)) =========
-- Requires: network schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ADD CONSTRAINT `fk_network_network_service_area_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`plan_service_area`(`plan_service_area_id`);

-- ========= network --> provider (9 constraint(s)) =========
-- Requires: network schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ADD CONSTRAINT `fk_network_tier_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= pharmacy --> billing (4 constraint(s)) =========
-- Requires: pharmacy schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= pharmacy --> care (8 constraint(s)) =========
-- Requires: pharmacy schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`gap`(`gap_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);

-- ========= pharmacy --> claim (2 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= pharmacy --> compliance (2 constraint(s)) =========
-- Requires: pharmacy schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= pharmacy --> contract (3 constraint(s)) =========
-- Requires: pharmacy schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= pharmacy --> employer (4 constraint(s)) =========
-- Requires: pharmacy schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= pharmacy --> enrollment (1 constraint(s)) =========
-- Requires: pharmacy schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= pharmacy --> member (2 constraint(s)) =========
-- Requires: pharmacy schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= pharmacy --> network (4 constraint(s)) =========
-- Requires: pharmacy schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);

-- ========= pharmacy --> plan (2 constraint(s)) =========
-- Requires: pharmacy schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= pharmacy --> provider (5 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= pharmacy --> risk (3 constraint(s)) =========
-- Requires: pharmacy schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= pharmacy --> utilization (5 constraint(s)) =========
-- Requires: pharmacy schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);

-- ========= plan --> compliance (6 constraint(s)) =========
-- Requires: plan schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= plan --> network (1 constraint(s)) =========
-- Requires: plan schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= plan --> pharmacy (2 constraint(s)) =========
-- Requires: plan schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= plan --> provider (1 constraint(s)) =========
-- Requires: plan schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= plan --> risk (1 constraint(s)) =========
-- Requires: plan schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_rate_development_id` FOREIGN KEY (`rate_development_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`rate_development`(`rate_development_id`);

-- ========= provider --> care (1 constraint(s)) =========
-- Requires: provider schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= provider --> compliance (2 constraint(s)) =========
-- Requires: provider schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= provider --> contract (4 constraint(s)) =========
-- Requires: provider schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);

-- ========= provider --> network (4 constraint(s)) =========
-- Requires: provider schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ADD CONSTRAINT `fk_provider_group_practice_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_directory_id` FOREIGN KEY (`provider_directory_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_directory`(`provider_directory_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= provider --> plan (2 constraint(s)) =========
-- Requires: provider schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= risk --> compliance (3 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ADD CONSTRAINT `fk_risk_rate_development_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ADD CONSTRAINT `fk_risk_ibnr_reserve_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= risk --> employer (3 constraint(s)) =========
-- Requires: risk schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ADD CONSTRAINT `fk_risk_rate_development_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ADD CONSTRAINT `fk_risk_ibnr_reserve_stop_loss_policy_id` FOREIGN KEY (`stop_loss_policy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`stop_loss_policy`(`stop_loss_policy_id`);

-- ========= risk --> enrollment (2 constraint(s)) =========
-- Requires: risk schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_cms_submission_id` FOREIGN KEY (`cms_submission_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`cms_submission`(`cms_submission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= risk --> member (3 constraint(s)) =========
-- Requires: risk schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= risk --> network (4 constraint(s)) =========
-- Requires: risk schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ADD CONSTRAINT `fk_risk_rate_development_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= risk --> plan (6 constraint(s)) =========
-- Requires: risk schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ADD CONSTRAINT `fk_risk_rate_development_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ADD CONSTRAINT `fk_risk_ibnr_reserve_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);

-- ========= risk --> provider (5 constraint(s)) =========
-- Requires: risk schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= utilization --> care (10 constraint(s)) =========
-- Requires: utilization schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);

-- ========= utilization --> compliance (3 constraint(s)) =========
-- Requires: utilization schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= utilization --> contract (3 constraint(s)) =========
-- Requires: utilization schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= utilization --> employer (1 constraint(s)) =========
-- Requires: utilization schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= utilization --> enrollment (4 constraint(s)) =========
-- Requires: utilization schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= utilization --> member (4 constraint(s)) =========
-- Requires: utilization schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= utilization --> network (5 constraint(s)) =========
-- Requires: utilization schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);

-- ========= utilization --> plan (2 constraint(s)) =========
-- Requires: utilization schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= utilization --> provider (8 constraint(s)) =========
-- Requires: utilization schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= utilization --> risk (6 constraint(s)) =========
-- Requires: utilization schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

