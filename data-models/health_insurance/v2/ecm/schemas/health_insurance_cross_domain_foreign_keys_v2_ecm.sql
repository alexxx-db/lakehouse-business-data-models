-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:33
-- Total cross-domain FK constraints: 989
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: appeal, billing, care, claim, compliance, contract, credential, employer, enrollment, finance, member, network, pharmacy, plan, provider, risk, utilization, vendor, workforce

-- ========= appeal --> billing (1 constraint(s)) =========
-- Requires: appeal schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);

-- ========= appeal --> claim (9 constraint(s)) =========
-- Requires: appeal schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ADD CONSTRAINT `fk_appeal_evidence_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= appeal --> compliance (7 constraint(s)) =========
-- Requires: appeal schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ADD CONSTRAINT `fk_appeal_iro_organization_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ADD CONSTRAINT `fk_appeal_penalty_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ADD CONSTRAINT `fk_appeal_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ADD CONSTRAINT `fk_appeal_regulatory_filing_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= appeal --> contract (4 constraint(s)) =========
-- Requires: appeal schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);

-- ========= appeal --> credential (3 constraint(s)) =========
-- Requires: appeal schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document` ADD CONSTRAINT `fk_appeal_appeal_document_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);

-- ========= appeal --> employer (6 constraint(s)) =========
-- Requires: appeal schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ADD CONSTRAINT `fk_appeal_regulatory_filing_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= appeal --> enrollment (2 constraint(s)) =========
-- Requires: appeal schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);

-- ========= appeal --> finance (2 constraint(s)) =========
-- Requires: appeal schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ADD CONSTRAINT `fk_appeal_penalty_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ADD CONSTRAINT `fk_appeal_regulatory_filing_finance_regulatory_filing_id` FOREIGN KEY (`finance_regulatory_filing_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing`(`finance_regulatory_filing_id`);

-- ========= appeal --> member (16 constraint(s)) =========
-- Requires: appeal schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ADD CONSTRAINT `fk_appeal_penalty_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_member_grievance_id` FOREIGN KEY (`member_grievance_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_grievance`(`member_grievance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ADD CONSTRAINT `fk_appeal_appeal_document2_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ADD CONSTRAINT `fk_appeal_appeal_communication2_member_communication_id` FOREIGN KEY (`member_communication_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_communication`(`member_communication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ADD CONSTRAINT `fk_appeal_appeal_communication2_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`regulatory_filing` ADD CONSTRAINT `fk_appeal_regulatory_filing_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ADD CONSTRAINT `fk_appeal_appeal_communication_member_communication_id` FOREIGN KEY (`member_communication_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_communication`(`member_communication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication` ADD CONSTRAINT `fk_appeal_appeal_communication_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance` ADD CONSTRAINT `fk_appeal_appeal_grievance_member_grievance_id` FOREIGN KEY (`member_grievance_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_grievance`(`member_grievance_id`);

-- ========= appeal --> network (1 constraint(s)) =========
-- Requires: appeal schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= appeal --> pharmacy (2 constraint(s)) =========
-- Requires: appeal schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);

-- ========= appeal --> plan (4 constraint(s)) =========
-- Requires: appeal schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ADD CONSTRAINT `fk_appeal_penalty_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= appeal --> provider (10 constraint(s)) =========
-- Requires: appeal schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`penalty` ADD CONSTRAINT `fk_appeal_penalty_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ADD CONSTRAINT `fk_appeal_evidence_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_document2` ADD CONSTRAINT `fk_appeal_appeal_document2_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= appeal --> utilization (2 constraint(s)) =========
-- Requires: appeal schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`evidence` ADD CONSTRAINT `fk_appeal_evidence_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);

-- ========= appeal --> vendor (1 constraint(s)) =========
-- Requires: appeal schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`iro_organization` ADD CONSTRAINT `fk_appeal_iro_organization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= appeal --> workforce (5 constraint(s)) =========
-- Requires: appeal schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2` ADD CONSTRAINT `fk_appeal_appeal_grievance2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`appeal_communication2` ADD CONSTRAINT `fk_appeal_appeal_communication2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> claim (1 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= billing --> compliance (8 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ADD CONSTRAINT `fk_billing_collection_case_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ADD CONSTRAINT `fk_billing_cobra_billing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ADD CONSTRAINT `fk_billing_mlr_rebate_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= billing --> contract (1 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_contract_dispute_id` FOREIGN KEY (`contract_dispute_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_dispute`(`contract_dispute_id`);

-- ========= billing --> credential (2 constraint(s)) =========
-- Requires: billing schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_application_id` FOREIGN KEY (`application_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`application`(`application_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_application_id` FOREIGN KEY (`application_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`application`(`application_id`);

-- ========= billing --> employer (6 constraint(s)) =========
-- Requires: billing schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ADD CONSTRAINT `fk_billing_cobra_billing_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= billing --> enrollment (6 constraint(s)) =========
-- Requires: billing schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ADD CONSTRAINT `fk_billing_cobra_billing_cobra_election_id` FOREIGN KEY (`cobra_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`cobra_election`(`cobra_election_id`);

-- ========= billing --> finance (9 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payer_billing_role` ADD CONSTRAINT `fk_billing_payer_billing_role_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= billing --> member (17 constraint(s)) =========
-- Requires: billing schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ADD CONSTRAINT `fk_billing_collection_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ADD CONSTRAINT `fk_billing_cobra_billing_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ADD CONSTRAINT `fk_billing_edi_820_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ADD CONSTRAINT `fk_billing_premium_statement_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= billing --> network (1 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= billing --> plan (12 constraint(s)) =========
-- Requires: billing schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cobra_billing` ADD CONSTRAINT `fk_billing_cobra_billing_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`mlr_rebate` ADD CONSTRAINT `fk_billing_mlr_rebate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ADD CONSTRAINT `fk_billing_premium_statement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_rate_health_plan_id` FOREIGN KEY (`rate_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_rate_plan_health_plan_id` FOREIGN KEY (`rate_plan_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= billing --> provider (4 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`edi_820` ADD CONSTRAINT `fk_billing_edi_820_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= billing --> risk (2 constraint(s)) =========
-- Requires: billing schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_adjustment_payment_id` FOREIGN KEY (`adjustment_payment_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`adjustment_payment`(`adjustment_payment_id`);

-- ========= billing --> vendor (2 constraint(s)) =========
-- Requires: billing schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ADD CONSTRAINT `fk_billing_collection_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= billing --> workforce (10 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_refund` ADD CONSTRAINT `fk_billing_premium_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`collection_case` ADD CONSTRAINT `fk_billing_collection_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_reconciliation` ADD CONSTRAINT `fk_billing_premium_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ADD CONSTRAINT `fk_billing_premium_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_statement` ADD CONSTRAINT `fk_billing_premium_statement_premium_statement_generator_employee_id` FOREIGN KEY (`premium_statement_generator_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= care --> claim (1 constraint(s)) =========
-- Requires: care schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= care --> compliance (5 constraint(s)) =========
-- Requires: care schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ADD CONSTRAINT `fk_care_hedis_measure_compliance_regulatory_obligation_id` FOREIGN KEY (`compliance_regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ADD CONSTRAINT `fk_care_hedis_measure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ADD CONSTRAINT `fk_care_program_obligation_mapping_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_accreditation` ADD CONSTRAINT `fk_care_program_accreditation_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ADD CONSTRAINT `fk_care_measure_obligation_mapping_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_program`(`accreditation_program_id`);

-- ========= care --> contract (7 constraint(s)) =========
-- Requires: care schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ADD CONSTRAINT `fk_care_dme_coordination_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`star_rating_result` ADD CONSTRAINT `fk_care_star_rating_result_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_obligation_mapping` ADD CONSTRAINT `fk_care_program_obligation_mapping_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`measure_obligation_mapping` ADD CONSTRAINT `fk_care_measure_obligation_mapping_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap_obligation` ADD CONSTRAINT `fk_care_gap_obligation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);

-- ========= care --> credential (1 constraint(s)) =========
-- Requires: care schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ADD CONSTRAINT `fk_care_coordinator_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);

-- ========= care --> employer (2 constraint(s)) =========
-- Requires: care schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ADD CONSTRAINT `fk_care_program_enrollment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ADD CONSTRAINT `fk_care_care_enrollment2_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= care --> finance (2 constraint(s)) =========
-- Requires: care schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);

-- ========= care --> member (20 constraint(s)) =========
-- Requires: care schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_member_enrollment2_id` FOREIGN KEY (`member_enrollment2_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_enrollment2`(`member_enrollment2_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ADD CONSTRAINT `fk_care_dme_coordination_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ADD CONSTRAINT `fk_care_barrier_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program_enrollment` ADD CONSTRAINT `fk_care_program_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ADD CONSTRAINT `fk_care_care_enrollment2_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ADD CONSTRAINT `fk_care_care_enrollment2_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_plan_care_subscriber_id` FOREIGN KEY (`plan_care_subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_enrollment`(`member_enrollment_id`);

-- ========= care --> network (3 constraint(s)) =========
-- Requires: care schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= care --> pharmacy (1 constraint(s)) =========
-- Requires: care schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= care --> plan (5 constraint(s)) =========
-- Requires: care schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ADD CONSTRAINT `fk_care_population_segment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= care --> provider (7 constraint(s)) =========
-- Requires: care schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ADD CONSTRAINT `fk_care_dme_coordination_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= care --> risk (7 constraint(s)) =========
-- Requires: care schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ADD CONSTRAINT `fk_care_population_segment_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ADD CONSTRAINT `fk_care_population_segment_score_run_id` FOREIGN KEY (`score_run_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`score_run`(`score_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment2` ADD CONSTRAINT `fk_care_care_enrollment2_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= care --> utilization (4 constraint(s)) =========
-- Requires: care schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`snf_stay` ADD CONSTRAINT `fk_care_snf_stay_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`dme_coordination` ADD CONSTRAINT `fk_care_dme_coordination_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);

-- ========= care --> vendor (10 constraint(s)) =========
-- Requires: care schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ADD CONSTRAINT `fk_care_coordinator_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ADD CONSTRAINT `fk_care_barrier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`transition` ADD CONSTRAINT `fk_care_transition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= care --> workforce (9 constraint(s)) =========
-- Requires: care schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`coordinator` ADD CONSTRAINT `fk_care_coordinator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`population_segment` ADD CONSTRAINT `fk_care_population_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`barrier` ADD CONSTRAINT `fk_care_barrier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`team` ADD CONSTRAINT `fk_care_team_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`questionnaire` ADD CONSTRAINT `fk_care_questionnaire_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= claim --> appeal (2 constraint(s)) =========
-- Requires: claim schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_outcome_id` FOREIGN KEY (`outcome_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`outcome`(`outcome_id`);

-- ========= claim --> billing (2 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ADD CONSTRAINT `fk_claim_payer_claim_role_payer_billing_role_id` FOREIGN KEY (`payer_billing_role_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`payer_billing_role`(`payer_billing_role_id`);

-- ========= claim --> care (1 constraint(s)) =========
-- Requires: claim schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= claim --> contract (5 constraint(s)) =========
-- Requires: claim schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ADD CONSTRAINT `fk_claim_adjudication_rate_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ADD CONSTRAINT `fk_claim_adjudication_rate_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);

-- ========= claim --> credential (5 constraint(s)) =========
-- Requires: claim schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);

-- ========= claim --> employer (1 constraint(s)) =========
-- Requires: claim schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= claim --> enrollment (2 constraint(s)) =========
-- Requires: claim schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= claim --> finance (4 constraint(s)) =========
-- Requires: claim schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);

-- ========= claim --> member (13 constraint(s)) =========
-- Requires: claim schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_member_communication_id` FOREIGN KEY (`member_communication_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_communication`(`member_communication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_cob_record_id` FOREIGN KEY (`cob_record_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`cob_record`(`cob_record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`subrogation` ADD CONSTRAINT `fk_claim_subrogation_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_authorization_document_id` FOREIGN KEY (`authorization_document_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`authorization_document`(`authorization_document_id`);

-- ========= claim --> network (2 constraint(s)) =========
-- Requires: claim schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);

-- ========= claim --> plan (12 constraint(s)) =========
-- Requires: claim schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`plan_service_area`(`plan_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ADD CONSTRAINT `fk_claim_ibnr_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ADD CONSTRAINT `fk_claim_ibnr_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication_rate` ADD CONSTRAINT `fk_claim_adjudication_rate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ADD CONSTRAINT `fk_claim_payer_claim_role_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` ADD CONSTRAINT `fk_claim_claim_payer_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` ADD CONSTRAINT `fk_claim_claim_payer_primary_health_plan_id` FOREIGN KEY (`primary_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= claim --> provider (8 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_header_rendering_provider_id` FOREIGN KEY (`header_rendering_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_tertiary_rendering_provider_id` FOREIGN KEY (`tertiary_rendering_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= claim --> risk (4 constraint(s)) =========
-- Requires: claim schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ADD CONSTRAINT `fk_claim_ibnr_actuarial_assumption_set_id` FOREIGN KEY (`actuarial_assumption_set_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set`(`actuarial_assumption_set_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ADD CONSTRAINT `fk_claim_ibnr_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= claim --> utilization (6 constraint(s)) =========
-- Requires: claim schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_episode_of_care_id` FOREIGN KEY (`episode_of_care_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`episode_of_care`(`episode_of_care_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_episode_of_care_id` FOREIGN KEY (`episode_of_care_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`episode_of_care`(`episode_of_care_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ADD CONSTRAINT `fk_claim_drg_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);

-- ========= claim --> vendor (3 constraint(s)) =========
-- Requires: claim schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payer_claim_role` ADD CONSTRAINT `fk_claim_payer_claim_role_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`claim_payer` ADD CONSTRAINT `fk_claim_claim_payer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= claim --> workforce (7 constraint(s)) =========
-- Requires: claim schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`ibnr` ADD CONSTRAINT `fk_claim_ibnr_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`status_event` ADD CONSTRAINT `fk_claim_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> claim (1 constraint(s)) =========
-- Requires: compliance schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= compliance --> contract (4 constraint(s)) =========
-- Requires: compliance schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`audit`(`audit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= compliance --> credential (1 constraint(s)) =========
-- Requires: compliance schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ADD CONSTRAINT `fk_compliance_compliance_attestation_credential_attestation_id` FOREIGN KEY (`credential_attestation_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_attestation`(`credential_attestation_id`);

-- ========= compliance --> employer (3 constraint(s)) =========
-- Requires: compliance schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ADD CONSTRAINT `fk_compliance_erisa_filing_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= compliance --> finance (1 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> member (5 constraint(s)) =========
-- Requires: compliance schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_member_communication_id` FOREIGN KEY (`member_communication_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_communication`(`member_communication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ADD CONSTRAINT `fk_compliance_phi_disclosure_log_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ADD CONSTRAINT `fk_compliance_state_fair_hearing_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= compliance --> plan (4 constraint(s)) =========
-- Requires: compliance schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_mlr_reporting_entity_health_plan_id` FOREIGN KEY (`mlr_reporting_entity_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= compliance --> vendor (4 constraint(s)) =========
-- Requires: compliance schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= compliance --> workforce (29 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ADD CONSTRAINT `fk_compliance_cap_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ADD CONSTRAINT `fk_compliance_cap_milestone_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ADD CONSTRAINT `fk_compliance_phi_disclosure_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ADD CONSTRAINT `fk_compliance_accreditation_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ADD CONSTRAINT `fk_compliance_accreditation_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_primary_policy_employee_id` FOREIGN KEY (`primary_policy_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ADD CONSTRAINT `fk_compliance_policy_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ADD CONSTRAINT `fk_compliance_policy_review_primary_policy_employee_id` FOREIGN KEY (`primary_policy_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_last_updated_by_employee_id` FOREIGN KEY (`training_last_updated_by_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_trainee_employee_id` FOREIGN KEY (`training_trainee_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ADD CONSTRAINT `fk_compliance_erisa_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ADD CONSTRAINT `fk_compliance_state_fair_hearing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`compliance_attestation` ADD CONSTRAINT `fk_compliance_compliance_attestation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= contract --> compliance (4 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ADD CONSTRAINT `fk_contract_contract_amendment_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` ADD CONSTRAINT `fk_contract_party_regulatory_obligation_compliance_compliance_attestation_id` FOREIGN KEY (`compliance_attestation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`compliance_attestation`(`compliance_attestation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance` ADD CONSTRAINT `fk_contract_party_regulatory_obligation_compliance_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ADD CONSTRAINT `fk_contract_audit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= contract --> credential (3 constraint(s)) =========
-- Requires: contract schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);

-- ========= contract --> finance (5 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ADD CONSTRAINT `fk_contract_financial_summary_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ADD CONSTRAINT `fk_contract_financial_summary_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);

-- ========= contract --> network (5 constraint(s)) =========
-- Requires: contract schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ADD CONSTRAINT `fk_contract_contract_amendment_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ADD CONSTRAINT `fk_contract_contract_lifecycle_event2_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= contract --> plan (6 constraint(s)) =========
-- Requires: contract schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= contract --> provider (11 constraint(s)) =========
-- Requires: contract schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`financial_summary` ADD CONSTRAINT `fk_contract_financial_summary_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_provider_provider_id` FOREIGN KEY (`provider_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ADD CONSTRAINT `fk_contract_audit_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= contract --> risk (5 constraint(s)) =========
-- Requires: contract schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`vbc_performance_period` ADD CONSTRAINT `fk_contract_vbc_performance_period_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`reimbursement_policy` ADD CONSTRAINT `fk_contract_reimbursement_policy_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= contract --> vendor (1 constraint(s)) =========
-- Requires: contract schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= contract --> workforce (8 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_amendment` ADD CONSTRAINT `fk_contract_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2` ADD CONSTRAINT `fk_contract_contract_lifecycle_event2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`audit` ADD CONSTRAINT `fk_contract_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= credential --> appeal (1 constraint(s)) =========
-- Requires: credential schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ADD CONSTRAINT `fk_credential_credential_document_appeal_document2_id` FOREIGN KEY (`appeal_document2_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`appeal_document2`(`appeal_document2_id`);

-- ========= credential --> compliance (4 constraint(s)) =========
-- Requires: credential schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ADD CONSTRAINT `fk_credential_credential_attestation2_compliance_attestation_id` FOREIGN KEY (`compliance_attestation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`compliance_attestation`(`compliance_attestation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ADD CONSTRAINT `fk_credential_credential_appeal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ADD CONSTRAINT `fk_credential_credential_attestation_compliance_attestation_id` FOREIGN KEY (`compliance_attestation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`compliance_attestation`(`compliance_attestation_id`);

-- ========= credential --> contract (3 constraint(s)) =========
-- Requires: credential schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` ADD CONSTRAINT `fk_credential_contract_link_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` ADD CONSTRAINT `fk_credential_obligation_mapping_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_contract_lifecycle_event2_id` FOREIGN KEY (`contract_lifecycle_event2_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2`(`contract_lifecycle_event2_id`);

-- ========= credential --> finance (1 constraint(s)) =========
-- Requires: credential schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ADD CONSTRAINT `fk_credential_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= credential --> plan (2 constraint(s)) =========
-- Requires: credential schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ADD CONSTRAINT `fk_credential_application_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ADD CONSTRAINT `fk_credential_cvo_relationship_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= credential --> provider (12 constraint(s)) =========
-- Requires: credential schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ADD CONSTRAINT `fk_credential_application_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ADD CONSTRAINT `fk_credential_record_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ADD CONSTRAINT `fk_credential_psv_verification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ADD CONSTRAINT `fk_credential_sanction_screening_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ADD CONSTRAINT `fk_credential_npdb_query_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ADD CONSTRAINT `fk_credential_recredential_cycle_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ADD CONSTRAINT `fk_credential_expedited_credential_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ADD CONSTRAINT `fk_credential_credential_document_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ADD CONSTRAINT `fk_credential_credential_outreach_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ADD CONSTRAINT `fk_credential_credential_attestation2_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ADD CONSTRAINT `fk_credential_credential_appeal_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= credential --> vendor (4 constraint(s)) =========
-- Requires: credential schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ADD CONSTRAINT `fk_credential_psv_verification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ADD CONSTRAINT `fk_credential_sanction_screening_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ADD CONSTRAINT `fk_credential_npdb_query_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ADD CONSTRAINT `fk_credential_delegated_entity_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= credential --> workforce (16 constraint(s)) =========
-- Requires: credential schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ADD CONSTRAINT `fk_credential_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ADD CONSTRAINT `fk_credential_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ADD CONSTRAINT `fk_credential_psv_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ADD CONSTRAINT `fk_credential_sanction_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ADD CONSTRAINT `fk_credential_npdb_query_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ADD CONSTRAINT `fk_credential_committee_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ADD CONSTRAINT `fk_credential_recredential_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ADD CONSTRAINT `fk_credential_delegation_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ADD CONSTRAINT `fk_credential_cvo_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ADD CONSTRAINT `fk_credential_expedited_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ADD CONSTRAINT `fk_credential_decision_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ADD CONSTRAINT `fk_credential_decision_document_decision_document_author_employee_id` FOREIGN KEY (`decision_document_author_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ADD CONSTRAINT `fk_credential_credential_outreach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation2` ADD CONSTRAINT `fk_credential_credential_attestation2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ADD CONSTRAINT `fk_credential_credential_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= employer --> contract (1 constraint(s)) =========
-- Requires: employer schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ADD CONSTRAINT `fk_employer_regulatory_compliance_record_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);

-- ========= employer --> network (2 constraint(s)) =========
-- Requires: employer schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);

-- ========= employer --> plan (6 constraint(s)) =========
-- Requires: employer schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_tertiary_group_epo_plan_health_plan_id` FOREIGN KEY (`tertiary_group_epo_plan_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ADD CONSTRAINT `fk_employer_erisa_plan_document_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= employer --> provider (1 constraint(s)) =========
-- Requires: employer schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);

-- ========= employer --> risk (1 constraint(s)) =========
-- Requires: employer schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ADD CONSTRAINT `fk_employer_group_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= employer --> vendor (6 constraint(s)) =========
-- Requires: employer schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ADD CONSTRAINT `fk_employer_wellness_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_broker_vendor_vendor_id` FOREIGN KEY (`broker_vendor_vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ADD CONSTRAINT `fk_employer_tpa_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ADD CONSTRAINT `fk_employer_tpa_tpa_vendor_vendor_id` FOREIGN KEY (`tpa_vendor_vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ADD CONSTRAINT `fk_employer_employer_contract2_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= employer --> workforce (4 constraint(s)) =========
-- Requires: employer schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ADD CONSTRAINT `fk_employer_group_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ADD CONSTRAINT `fk_employer_group_group_underwriter_employee_id` FOREIGN KEY (`group_underwriter_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ADD CONSTRAINT `fk_employer_employer_contract2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ADD CONSTRAINT `fk_employer_employer_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= enrollment --> billing (1 constraint(s)) =========
-- Requires: enrollment schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);

-- ========= enrollment --> care (1 constraint(s)) =========
-- Requires: enrollment schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);

-- ========= enrollment --> compliance (1 constraint(s)) =========
-- Requires: enrollment schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= enrollment --> employer (13 constraint(s)) =========
-- Requires: enrollment schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_group_contact_id` FOREIGN KEY (`group_contact_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_contact`(`group_contact_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ADD CONSTRAINT `fk_enrollment_pend_queue_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_group_location_id` FOREIGN KEY (`group_location_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_location`(`group_location_id`);

-- ========= enrollment --> member (16 constraint(s)) =========
-- Requires: enrollment schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_member_lifecycle_event_id` FOREIGN KEY (`member_lifecycle_event_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_lifecycle_event`(`member_lifecycle_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ADD CONSTRAINT `fk_enrollment_pend_queue_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_lob_assignment_id` FOREIGN KEY (`lob_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`lob_assignment`(`lob_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= enrollment --> network (4 constraint(s)) =========
-- Requires: enrollment schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= enrollment --> plan (15 constraint(s)) =========
-- Requires: enrollment schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_open_health_plan_id` FOREIGN KEY (`open_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_open_plan_health_plan_id` FOREIGN KEY (`open_plan_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`submission_batch` ADD CONSTRAINT `fk_enrollment_submission_batch_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`cms_submission` ADD CONSTRAINT `fk_enrollment_cms_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= enrollment --> provider (2 constraint(s)) =========
-- Requires: enrollment schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= enrollment --> risk (3 constraint(s)) =========
-- Requires: enrollment schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`raps_submission`(`raps_submission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= enrollment --> vendor (1 constraint(s)) =========
-- Requires: enrollment schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= enrollment --> workforce (8 constraint(s)) =========
-- Requires: enrollment schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`pend_queue` ADD CONSTRAINT `fk_enrollment_pend_queue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`reconciliation` ADD CONSTRAINT `fk_enrollment_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> appeal (3 constraint(s)) =========
-- Requires: finance schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= finance --> billing (1 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ADD CONSTRAINT `fk_finance_premium_revenue_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);

-- ========= finance --> compliance (5 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`baa`(`baa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`baa`(`baa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ADD CONSTRAINT `fk_finance_mlr_financial_entry_mlr_calculation_id` FOREIGN KEY (`mlr_calculation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`mlr_calculation`(`mlr_calculation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ADD CONSTRAINT `fk_finance_finance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ADD CONSTRAINT `fk_finance_finance_regulatory_filing_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= finance --> contract (3 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ADD CONSTRAINT `fk_finance_vbc_settlement_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);

-- ========= finance --> employer (3 constraint(s)) =========
-- Requires: finance schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ADD CONSTRAINT `fk_finance_premium_revenue_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= finance --> member (1 constraint(s)) =========
-- Requires: finance schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ADD CONSTRAINT `fk_finance_premium_revenue_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= finance --> network (1 constraint(s)) =========
-- Requires: finance schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ADD CONSTRAINT `fk_finance_vbc_settlement_vbc_program_id` FOREIGN KEY (`vbc_program_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`vbc_program`(`vbc_program_id`);

-- ========= finance --> plan (3 constraint(s)) =========
-- Requires: finance schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ADD CONSTRAINT `fk_finance_mlr_financial_entry_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`submission`(`submission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ADD CONSTRAINT `fk_finance_premium_revenue_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= finance --> provider (1 constraint(s)) =========
-- Requires: finance schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ADD CONSTRAINT `fk_finance_vbc_settlement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= finance --> risk (6 constraint(s)) =========
-- Requires: finance schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ADD CONSTRAINT `fk_finance_actuarial_reserve_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ADD CONSTRAINT `fk_finance_premium_revenue_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ADD CONSTRAINT `fk_finance_reinsurance_transaction_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);

-- ========= finance --> vendor (7 constraint(s)) =========
-- Requires: finance schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ADD CONSTRAINT `fk_finance_reinsurance_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= finance --> workforce (16 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_primary_cost_employee_id` FOREIGN KEY (`primary_cost_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ADD CONSTRAINT `fk_finance_vbc_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ADD CONSTRAINT `fk_finance_premium_revenue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ADD CONSTRAINT `fk_finance_reinsurance_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= member --> appeal (1 constraint(s)) =========
-- Requires: member schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ADD CONSTRAINT `fk_member_member_grievance2_appeal_grievance2_id` FOREIGN KEY (`appeal_grievance2_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`appeal_grievance2`(`appeal_grievance2_id`);

-- ========= member --> billing (1 constraint(s)) =========
-- Requires: member schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= member --> care (2 constraint(s)) =========
-- Requires: member schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ADD CONSTRAINT `fk_member_member_enrollment2_care_enrollment2_id` FOREIGN KEY (`care_enrollment2_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_enrollment2`(`care_enrollment2_id`);

-- ========= member --> contract (2 constraint(s)) =========
-- Requires: member schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ADD CONSTRAINT `fk_member_member_lifecycle_event_contract_lifecycle_event2_id` FOREIGN KEY (`contract_lifecycle_event2_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_lifecycle_event2`(`contract_lifecycle_event2_id`);

-- ========= member --> credential (1 constraint(s)) =========
-- Requires: member schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ADD CONSTRAINT `fk_member_member_lifecycle_event_credential_lifecycle_event_id` FOREIGN KEY (`credential_lifecycle_event_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event`(`credential_lifecycle_event_id`);

-- ========= member --> employer (3 constraint(s)) =========
-- Requires: member schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= member --> enrollment (1 constraint(s)) =========
-- Requires: member schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= member --> network (2 constraint(s)) =========
-- Requires: member schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ADD CONSTRAINT `fk_member_member_grievance2_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= member --> plan (13 constraint(s)) =========
-- Requires: member schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ADD CONSTRAINT `fk_member_household_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ADD CONSTRAINT `fk_member_assignment_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ADD CONSTRAINT `fk_member_member_enrollment2_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ADD CONSTRAINT `fk_member_member_lifecycle_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ADD CONSTRAINT `fk_member_member_communication_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ADD CONSTRAINT `fk_member_member_grievance2_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ADD CONSTRAINT `fk_member_member_grievance2_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= member --> provider (5 constraint(s)) =========
-- Requires: member schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ADD CONSTRAINT `fk_member_authorization_document_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ADD CONSTRAINT `fk_member_member_communication_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ADD CONSTRAINT `fk_member_member_grievance2_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= member --> vendor (2 constraint(s)) =========
-- Requires: member schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ADD CONSTRAINT `fk_member_member_communication_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= member --> workforce (11 constraint(s)) =========
-- Requires: member schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_consent_witness_employee_id` FOREIGN KEY (`consent_witness_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ADD CONSTRAINT `fk_member_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ADD CONSTRAINT `fk_member_authorized_representative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ADD CONSTRAINT `fk_member_member_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ADD CONSTRAINT `fk_member_member_communication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ADD CONSTRAINT `fk_member_member_grievance2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= network --> appeal (2 constraint(s)) =========
-- Requires: network schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ADD CONSTRAINT `fk_network_termination_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= network --> compliance (6 constraint(s)) =========
-- Requires: network schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ADD CONSTRAINT `fk_network_adequacy_standard_compliance_regulatory_obligation_id` FOREIGN KEY (`compliance_regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ADD CONSTRAINT `fk_network_adequacy_standard_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ADD CONSTRAINT `fk_network_change_event_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ADD CONSTRAINT `fk_network_access_standard_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ADD CONSTRAINT `fk_network_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= network --> contract (7 constraint(s)) =========
-- Requires: network schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ADD CONSTRAINT `fk_network_change_event_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ADD CONSTRAINT `fk_network_termination_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= network --> credential (2 constraint(s)) =========
-- Requires: network schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);

-- ========= network --> finance (6 constraint(s)) =========
-- Requires: network schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ADD CONSTRAINT `fk_network_aco_provider_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ADD CONSTRAINT `fk_network_termination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= network --> member (1 constraint(s)) =========
-- Requires: network schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ADD CONSTRAINT `fk_network_access_survey_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= network --> plan (11 constraint(s)) =========
-- Requires: network schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ADD CONSTRAINT `fk_network_filing_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ADD CONSTRAINT `fk_network_vbc_program_vbc_health_plan_id` FOREIGN KEY (`vbc_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ADD CONSTRAINT `fk_network_vbc_program_vbc_plan_health_plan_id` FOREIGN KEY (`vbc_plan_health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ADD CONSTRAINT `fk_network_vbc_program_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ADD CONSTRAINT `fk_network_network_directory_verification_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= network --> provider (7 constraint(s)) =========
-- Requires: network schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ADD CONSTRAINT `fk_network_aco_provider_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ADD CONSTRAINT `fk_network_access_survey_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ADD CONSTRAINT `fk_network_termination_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ADD CONSTRAINT `fk_network_network_directory_verification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= network --> risk (2 constraint(s)) =========
-- Requires: network schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= network --> vendor (4 constraint(s)) =========
-- Requires: network schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ADD CONSTRAINT `fk_network_provider_network_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ADD CONSTRAINT `fk_network_network_directory_verification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= network --> workforce (8 constraint(s)) =========
-- Requires: network schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ADD CONSTRAINT `fk_network_tier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ADD CONSTRAINT `fk_network_change_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ADD CONSTRAINT `fk_network_access_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ADD CONSTRAINT `fk_network_termination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ADD CONSTRAINT `fk_network_network_directory_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= pharmacy --> appeal (3 constraint(s)) =========
-- Requires: pharmacy schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= pharmacy --> care (1 constraint(s)) =========
-- Requires: pharmacy schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ADD CONSTRAINT `fk_pharmacy_mtm_service_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= pharmacy --> claim (1 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= pharmacy --> compliance (5 constraint(s)) =========
-- Requires: pharmacy schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`baa`(`baa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ADD CONSTRAINT `fk_pharmacy_part_d_submission_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= pharmacy --> contract (3 constraint(s)) =========
-- Requires: pharmacy schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= pharmacy --> credential (3 constraint(s)) =========
-- Requires: pharmacy schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);

-- ========= pharmacy --> employer (1 constraint(s)) =========
-- Requires: pharmacy schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= pharmacy --> enrollment (1 constraint(s)) =========
-- Requires: pharmacy schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);

-- ========= pharmacy --> finance (4 constraint(s)) =========
-- Requires: pharmacy schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_ap_payment_id` FOREIGN KEY (`ap_payment_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);

-- ========= pharmacy --> member (6 constraint(s)) =========
-- Requires: pharmacy schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ADD CONSTRAINT `fk_pharmacy_mtm_service_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= pharmacy --> network (3 constraint(s)) =========
-- Requires: pharmacy schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ADD CONSTRAINT `fk_pharmacy_pharmacy_contract_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= pharmacy --> plan (12 constraint(s)) =========
-- Requires: pharmacy schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_rx_benefit_config_id` FOREIGN KEY (`rx_benefit_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rx_benefit_config`(`rx_benefit_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ADD CONSTRAINT `fk_pharmacy_specialty_drug_program_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ADD CONSTRAINT `fk_pharmacy_mtm_service_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ADD CONSTRAINT `fk_pharmacy_part_d_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ADD CONSTRAINT `fk_pharmacy_part_d_submission_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= pharmacy --> provider (3 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ADD CONSTRAINT `fk_pharmacy_pharmacy_contract_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= pharmacy --> risk (1 constraint(s)) =========
-- Requires: pharmacy schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= pharmacy --> utilization (3 constraint(s)) =========
-- Requires: pharmacy schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);

-- ========= pharmacy --> vendor (4 constraint(s)) =========
-- Requires: pharmacy schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ADD CONSTRAINT `fk_pharmacy_drug_rebate_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ADD CONSTRAINT `fk_pharmacy_mac_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= pharmacy --> workforce (8 constraint(s)) =========
-- Requires: pharmacy schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ADD CONSTRAINT `fk_pharmacy_specialty_drug_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= plan --> care (1 constraint(s)) =========
-- Requires: plan schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` ADD CONSTRAINT `fk_plan_program_coverage_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= plan --> compliance (2 constraint(s)) =========
-- Requires: plan schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ADD CONSTRAINT `fk_plan_regulatory_obligation_link_primary_legacy_compliance_regulatory_obligation_id` FOREIGN KEY (`primary_legacy_compliance_regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ADD CONSTRAINT `fk_plan_regulatory_obligation_link_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= plan --> contract (7 constraint(s)) =========
-- Requires: plan schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ADD CONSTRAINT `fk_plan_plan_amendment2_contract_amendment_id` FOREIGN KEY (`contract_amendment_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ADD CONSTRAINT `fk_plan_provider_contract_link_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ADD CONSTRAINT `fk_plan_provider_contract_link_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ADD CONSTRAINT `fk_plan_provider_contract_link_tertiary_provider_contract_id` FOREIGN KEY (`tertiary_provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` ADD CONSTRAINT `fk_plan_plan_provider_contract_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ADD CONSTRAINT `fk_plan_plan_amendment_contract_amendment_id` FOREIGN KEY (`contract_amendment_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` ADD CONSTRAINT `fk_plan_plan_regulatory_obligation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);

-- ========= plan --> employer (1 constraint(s)) =========
-- Requires: plan schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= plan --> finance (3 constraint(s)) =========
-- Requires: plan schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ADD CONSTRAINT `fk_plan_submission_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= plan --> network (4 constraint(s)) =========
-- Requires: plan schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ADD CONSTRAINT `fk_plan_provider_contract_link_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` ADD CONSTRAINT `fk_plan_plan_provider_contract_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);

-- ========= plan --> pharmacy (3 constraint(s)) =========
-- Requires: plan schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= plan --> provider (1 constraint(s)) =========
-- Requires: plan schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ADD CONSTRAINT `fk_plan_provider_contract_link_provider_network_participation2_id` FOREIGN KEY (`provider_network_participation2_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider_network_participation2`(`provider_network_participation2_id`);

-- ========= plan --> risk (1 constraint(s)) =========
-- Requires: plan schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= plan --> vendor (3 constraint(s)) =========
-- Requires: plan schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ADD CONSTRAINT `fk_plan_hsa_hra_config_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= plan --> workforce (8 constraint(s)) =========
-- Requires: plan schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ADD CONSTRAINT `fk_plan_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ADD CONSTRAINT `fk_plan_submission_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ADD CONSTRAINT `fk_plan_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ADD CONSTRAINT `fk_plan_plan_amendment2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ADD CONSTRAINT `fk_plan_plan_amendment2_amendment_updated_by_user_employee_id` FOREIGN KEY (`amendment_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ADD CONSTRAINT `fk_plan_plan_amendment2_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ADD CONSTRAINT `fk_plan_regulatory_obligation_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` ADD CONSTRAINT `fk_plan_plan_regulatory_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= provider --> contract (8 constraint(s)) =========
-- Requires: provider schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` ADD CONSTRAINT `fk_provider_obligation_compliance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` ADD CONSTRAINT `fk_provider_audit_assignment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`audit`(`audit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ADD CONSTRAINT `fk_provider_provider_outreach_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ADD CONSTRAINT `fk_provider_provider_network_participation2_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ADD CONSTRAINT `fk_provider_provider_network_participation2_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);

-- ========= provider --> credential (2 constraint(s)) =========
-- Requires: provider schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ADD CONSTRAINT `fk_provider_license_recredential_cycle_id` FOREIGN KEY (`recredential_cycle_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`recredential_cycle`(`recredential_cycle_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` ADD CONSTRAINT `fk_provider_obligation_compliance_obligation_mapping_id` FOREIGN KEY (`obligation_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`obligation_mapping`(`obligation_mapping_id`);

-- ========= provider --> finance (3 constraint(s)) =========
-- Requires: provider schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ADD CONSTRAINT `fk_provider_group_practice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ADD CONSTRAINT `fk_provider_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= provider --> network (7 constraint(s)) =========
-- Requires: provider schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_directory_id` FOREIGN KEY (`provider_directory_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_directory`(`provider_directory_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ADD CONSTRAINT `fk_provider_outreach_campaign_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ADD CONSTRAINT `fk_provider_provider_network_participation2_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ADD CONSTRAINT `fk_provider_provider_network_participation2_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);

-- ========= provider --> plan (2 constraint(s)) =========
-- Requires: provider schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= provider --> vendor (3 constraint(s)) =========
-- Requires: provider schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ADD CONSTRAINT `fk_provider_npi_registry_sync_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ADD CONSTRAINT `fk_provider_provider_outreach_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= provider --> workforce (9 constraint(s)) =========
-- Requires: provider schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ADD CONSTRAINT `fk_provider_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ADD CONSTRAINT `fk_provider_group_practice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` ADD CONSTRAINT `fk_provider_audit_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ADD CONSTRAINT `fk_provider_outreach_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ADD CONSTRAINT `fk_provider_provider_directory_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ADD CONSTRAINT `fk_provider_provider_outreach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= risk --> claim (1 constraint(s)) =========
-- Requires: risk schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= risk --> compliance (3 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ADD CONSTRAINT `fk_risk_pool_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ADD CONSTRAINT `fk_risk_risk_cms_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= risk --> credential (1 constraint(s)) =========
-- Requires: risk schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);

-- ========= risk --> employer (1 constraint(s)) =========
-- Requires: risk schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= risk --> member (5 constraint(s)) =========
-- Requires: risk schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ADD CONSTRAINT `fk_risk_adjustment_payment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= risk --> plan (3 constraint(s)) =========
-- Requires: risk schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ADD CONSTRAINT `fk_risk_adjustment_payment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ADD CONSTRAINT `fk_risk_risk_cms_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= risk --> vendor (2 constraint(s)) =========
-- Requires: risk schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ADD CONSTRAINT `fk_risk_reinsurance_arrangement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= risk --> workforce (7 constraint(s)) =========
-- Requires: risk schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ADD CONSTRAINT `fk_risk_adjustment_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ADD CONSTRAINT `fk_risk_prospective_risk_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ADD CONSTRAINT `fk_risk_score_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ADD CONSTRAINT `fk_risk_risk_cms_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= utilization --> care (6 constraint(s)) =========
-- Requires: utilization schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`gap`(`gap_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);

-- ========= utilization --> claim (3 constraint(s)) =========
-- Requires: utilization schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ADD CONSTRAINT `fk_utilization_peer_to_peer_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= utilization --> compliance (7 constraint(s)) =========
-- Requires: utilization schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ADD CONSTRAINT `fk_utilization_tat_compliance_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= utilization --> contract (6 constraint(s)) =========
-- Requires: utilization schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ADD CONSTRAINT `fk_utilization_um_delegation_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_bundled_payment_episode_id` FOREIGN KEY (`bundled_payment_episode_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`bundled_payment_episode`(`bundled_payment_episode_id`);

-- ========= utilization --> credential (4 constraint(s)) =========
-- Requires: utilization schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ADD CONSTRAINT `fk_utilization_um_reviewer_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_delegation` ADD CONSTRAINT `fk_utilization_um_delegation_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);

-- ========= utilization --> employer (3 constraint(s)) =========
-- Requires: utilization schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= utilization --> enrollment (3 constraint(s)) =========
-- Requires: utilization schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);

-- ========= utilization --> finance (3 constraint(s)) =========
-- Requires: utilization schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= utilization --> member (12 constraint(s)) =========
-- Requires: utilization schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ADD CONSTRAINT `fk_utilization_tat_compliance_event_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program_enrollment` ADD CONSTRAINT `fk_utilization_um_program_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= utilization --> network (6 constraint(s)) =========
-- Requires: utilization schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ADD CONSTRAINT `fk_utilization_tat_compliance_event_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= utilization --> plan (14 constraint(s)) =========
-- Requires: utilization schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= utilization --> provider (13 constraint(s)) =========
-- Requires: utilization schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ADD CONSTRAINT `fk_utilization_peer_to_peer_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`tat_compliance_event` ADD CONSTRAINT `fk_utilization_tat_compliance_event_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`bed_day_review` ADD CONSTRAINT `fk_utilization_bed_day_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_episode_provider_id` FOREIGN KEY (`episode_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= utilization --> risk (1 constraint(s)) =========
-- Requires: utilization schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= utilization --> vendor (4 constraint(s)) =========
-- Requires: utilization schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= utilization --> workforce (10 constraint(s)) =========
-- Requires: utilization schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review` ADD CONSTRAINT `fk_utilization_peer_to_peer_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ADD CONSTRAINT `fk_utilization_um_reviewer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_reviewer` ADD CONSTRAINT `fk_utilization_um_reviewer_um_workforce_employee_id` FOREIGN KEY (`um_workforce_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_notification` ADD CONSTRAINT `fk_utilization_pa_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= vendor --> appeal (1 constraint(s)) =========
-- Requires: vendor schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);

-- ========= vendor --> billing (1 constraint(s)) =========
-- Requires: vendor schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`dispute`(`dispute_id`);

-- ========= vendor --> claim (1 constraint(s)) =========
-- Requires: vendor schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= vendor --> compliance (2 constraint(s)) =========
-- Requires: vendor schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ADD CONSTRAINT `fk_vendor_vendor_audit_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= vendor --> contract (1 constraint(s)) =========
-- Requires: vendor schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_contract_dispute_id` FOREIGN KEY (`contract_dispute_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_dispute`(`contract_dispute_id`);

-- ========= vendor --> credential (4 constraint(s)) =========
-- Requires: vendor schema, credential schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ADD CONSTRAINT `fk_vendor_performance_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);

-- ========= vendor --> employer (1 constraint(s)) =========
-- Requires: vendor schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= vendor --> enrollment (1 constraint(s)) =========
-- Requires: vendor schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= vendor --> finance (4 constraint(s)) =========
-- Requires: vendor schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ADD CONSTRAINT `fk_vendor_purchase_order_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ADD CONSTRAINT `fk_vendor_spend_category_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);

-- ========= vendor --> network (1 constraint(s)) =========
-- Requires: vendor schema, network schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= vendor --> plan (3 constraint(s)) =========
-- Requires: vendor schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= vendor --> provider (2 constraint(s)) =========
-- Requires: vendor schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= vendor --> workforce (12 constraint(s)) =========
-- Requires: vendor schema, workforce schema
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ADD CONSTRAINT `fk_vendor_contract_term_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ADD CONSTRAINT `fk_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ADD CONSTRAINT `fk_vendor_rfp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ADD CONSTRAINT `fk_vendor_rfp_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ADD CONSTRAINT `fk_vendor_insurance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ADD CONSTRAINT `fk_vendor_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ADD CONSTRAINT `fk_vendor_vendor_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> compliance (3 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_rbac_policy_document_id` FOREIGN KEY (`rbac_policy_document_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_employee_screening_id` FOREIGN KEY (`employee_screening_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`employee_screening`(`employee_screening_id`);

-- ========= workforce --> employer (2 constraint(s)) =========
-- Requires: workforce schema, employer schema
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);

-- ========= workforce --> finance (1 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> member (1 constraint(s)) =========
-- Requires: workforce schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ADD CONSTRAINT `fk_workforce_employee_benefit_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= workforce --> plan (1 constraint(s)) =========
-- Requires: workforce schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ADD CONSTRAINT `fk_workforce_employee_benefit_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= workforce --> vendor (3 constraint(s)) =========
-- Requires: workforce schema, vendor schema
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ADD CONSTRAINT `fk_workforce_compliance_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

