-- Cross-Domain Foreign Keys for Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:59
-- Total cross-domain FK constraints: 450
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: appeal, billing, care, claim, enrollment, member, network, pharmacy, plan, provider, risk, utilization

-- ========= appeal --> billing (12 constraint(s)) =========
-- Requires: appeal schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);

-- ========= appeal --> care (2 constraint(s)) =========
-- Requires: appeal schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);

-- ========= appeal --> claim (12 constraint(s)) =========
-- Requires: appeal schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_procedure_id` FOREIGN KEY (`procedure_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`procedure`(`procedure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_cob_id` FOREIGN KEY (`cob_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`cob`(`cob_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= appeal --> enrollment (9 constraint(s)) =========
-- Requires: appeal schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= appeal --> member (13 constraint(s)) =========
-- Requires: appeal schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_disenrollment_id` FOREIGN KEY (`disenrollment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`disenrollment`(`disenrollment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_lob_assignment_id` FOREIGN KEY (`lob_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`lob_assignment`(`lob_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_pcp_assignment_id` FOREIGN KEY (`pcp_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`pcp_assignment`(`pcp_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= appeal --> network (9 constraint(s)) =========
-- Requires: appeal schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_provider_assignment_id` FOREIGN KEY (`provider_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_assignment`(`provider_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= appeal --> pharmacy (4 constraint(s)) =========
-- Requires: appeal schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);

-- ========= appeal --> plan (10 constraint(s)) =========
-- Requires: appeal schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= appeal --> provider (9 constraint(s)) =========
-- Requires: appeal schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_participation_status_id` FOREIGN KEY (`participation_status_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`participation_status`(`participation_status_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_participation_status_id` FOREIGN KEY (`participation_status_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`participation_status`(`participation_status_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_participation_status_id` FOREIGN KEY (`participation_status_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`participation_status`(`participation_status_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= appeal --> utilization (5 constraint(s)) =========
-- Requires: appeal schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);

-- ========= billing --> enrollment (8 constraint(s)) =========
-- Requires: billing schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= billing --> member (11 constraint(s)) =========
-- Requires: billing schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= billing --> network (1 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_plan_association_id` FOREIGN KEY (`plan_association_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`plan_association`(`plan_association_id`);

-- ========= billing --> plan (7 constraint(s)) =========
-- Requires: billing schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= billing --> provider (2 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);

-- ========= care --> appeal (1 constraint(s)) =========
-- Requires: care schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= care --> claim (1 constraint(s)) =========
-- Requires: care schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= care --> enrollment (3 constraint(s)) =========
-- Requires: care schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= care --> member (11 constraint(s)) =========
-- Requires: care schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_dependent_id` FOREIGN KEY (`dependent_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_plan_care_subscriber_id` FOREIGN KEY (`plan_care_subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= care --> network (5 constraint(s)) =========
-- Requires: care schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_provider_assignment_id` FOREIGN KEY (`provider_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_assignment`(`provider_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= care --> pharmacy (1 constraint(s)) =========
-- Requires: care schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= care --> plan (7 constraint(s)) =========
-- Requires: care schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= care --> provider (9 constraint(s)) =========
-- Requires: care schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= care --> risk (8 constraint(s)) =========
-- Requires: care schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`plan_goal` ADD CONSTRAINT `fk_care_plan_goal_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= claim --> appeal (3 constraint(s)) =========
-- Requires: claim schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);

-- ========= claim --> billing (4 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= claim --> care (1 constraint(s)) =========
-- Requires: claim schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= claim --> enrollment (4 constraint(s)) =========
-- Requires: claim schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_eligibility_verification_id` FOREIGN KEY (`eligibility_verification_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`(`eligibility_verification_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= claim --> member (14 constraint(s)) =========
-- Requires: claim schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= claim --> network (11 constraint(s)) =========
-- Requires: claim schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= claim --> pharmacy (1 constraint(s)) =========
-- Requires: claim schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= claim --> plan (14 constraint(s)) =========
-- Requires: claim schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= claim --> provider (14 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_tertiary_rendering_provider_id` FOREIGN KEY (`tertiary_rendering_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_participation_status_id` FOREIGN KEY (`participation_status_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`participation_status`(`participation_status_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= claim --> risk (2 constraint(s)) =========
-- Requires: claim schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= claim --> utilization (16 constraint(s)) =========
-- Requires: claim schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);

-- ========= enrollment --> billing (2 constraint(s)) =========
-- Requires: enrollment schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);

-- ========= enrollment --> care (1 constraint(s)) =========
-- Requires: enrollment schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);

-- ========= enrollment --> member (11 constraint(s)) =========
-- Requires: enrollment schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= enrollment --> network (5 constraint(s)) =========
-- Requires: enrollment schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_provider_directory_id` FOREIGN KEY (`provider_directory_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_directory`(`provider_directory_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_provider_assignment_id` FOREIGN KEY (`provider_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_assignment`(`provider_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_plan_association_id` FOREIGN KEY (`plan_association_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`plan_association`(`plan_association_id`);

-- ========= enrollment --> pharmacy (2 constraint(s)) =========
-- Requires: enrollment schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);

-- ========= enrollment --> plan (10 constraint(s)) =========
-- Requires: enrollment schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= enrollment --> provider (4 constraint(s)) =========
-- Requires: enrollment schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_participation_status_id` FOREIGN KEY (`participation_status_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`participation_status`(`participation_status_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= enrollment --> risk (1 constraint(s)) =========
-- Requires: enrollment schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= member --> billing (1 constraint(s)) =========
-- Requires: member schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= member --> care (2 constraint(s)) =========
-- Requires: member schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ADD CONSTRAINT `fk_member_lob_assignment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= member --> network (4 constraint(s)) =========
-- Requires: member schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_assignment_id` FOREIGN KEY (`provider_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_assignment`(`provider_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= member --> pharmacy (1 constraint(s)) =========
-- Requires: member schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= member --> plan (13 constraint(s)) =========
-- Requires: member schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ADD CONSTRAINT `fk_member_lob_assignment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);

-- ========= member --> provider (6 constraint(s)) =========
-- Requires: member schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);

-- ========= network --> plan (4 constraint(s)) =========
-- Requires: network schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= network --> provider (8 constraint(s)) =========
-- Requires: network schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= pharmacy --> appeal (2 constraint(s)) =========
-- Requires: pharmacy schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= pharmacy --> care (9 constraint(s)) =========
-- Requires: pharmacy schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);

-- ========= pharmacy --> claim (1 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= pharmacy --> member (6 constraint(s)) =========
-- Requires: pharmacy schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= pharmacy --> network (4 constraint(s)) =========
-- Requires: pharmacy schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= pharmacy --> plan (10 constraint(s)) =========
-- Requires: pharmacy schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_rx_benefit_config_id` FOREIGN KEY (`rx_benefit_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rx_benefit_config`(`rx_benefit_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= pharmacy --> provider (6 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= pharmacy --> risk (1 constraint(s)) =========
-- Requires: pharmacy schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= pharmacy --> utilization (7 constraint(s)) =========
-- Requires: pharmacy schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);

-- ========= plan --> network (4 constraint(s)) =========
-- Requires: plan schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= plan --> pharmacy (3 constraint(s)) =========
-- Requires: plan schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= provider --> network (7 constraint(s)) =========
-- Requires: provider schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_directory_id` FOREIGN KEY (`provider_directory_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_directory`(`provider_directory_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);

-- ========= provider --> plan (2 constraint(s)) =========
-- Requires: provider schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= risk --> appeal (1 constraint(s)) =========
-- Requires: risk schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= risk --> claim (1 constraint(s)) =========
-- Requires: risk schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= risk --> member (4 constraint(s)) =========
-- Requires: risk schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= risk --> plan (4 constraint(s)) =========
-- Requires: risk schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ADD CONSTRAINT `fk_risk_score_run_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= risk --> provider (2 constraint(s)) =========
-- Requires: risk schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= utilization --> billing (1 constraint(s)) =========
-- Requires: utilization schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`grace_period`(`grace_period_id`);

-- ========= utilization --> care (7 constraint(s)) =========
-- Requires: utilization schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_member_risk_tier_id` FOREIGN KEY (`member_risk_tier_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`member_risk_tier`(`member_risk_tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);

-- ========= utilization --> enrollment (7 constraint(s)) =========
-- Requires: utilization schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`event`(`event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_eligibility_verification_id` FOREIGN KEY (`eligibility_verification_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`(`eligibility_verification_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= utilization --> member (8 constraint(s)) =========
-- Requires: utilization schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= utilization --> network (8 constraint(s)) =========
-- Requires: utilization schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= utilization --> plan (16 constraint(s)) =========
-- Requires: utilization schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= utilization --> provider (9 constraint(s)) =========
-- Requires: utilization schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);

-- ========= utilization --> risk (1 constraint(s)) =========
-- Requires: utilization schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

