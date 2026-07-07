-- Cross-Domain Foreign Keys for Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-03 06:20:35
-- Total cross-domain FK constraints: 457
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: beneficiary, compliance, donor, field, grant, mel, partnership, program, safeguarding, supply

-- ========= beneficiary --> compliance (9 constraint(s)) =========
-- Requires: beneficiary schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= beneficiary --> donor (2 constraint(s)) =========
-- Requires: beneficiary schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);

-- ========= beneficiary --> field (11 constraint(s)) =========
-- Requires: beneficiary schema, field schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);

-- ========= beneficiary --> grant (9 constraint(s)) =========
-- Requires: beneficiary schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_award_budget_line_id` FOREIGN KEY (`award_budget_line_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget_line`(`award_budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_award_budget_line_id` FOREIGN KEY (`award_budget_line_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget_line`(`award_budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);

-- ========= beneficiary --> mel (12 constraint(s)) =========
-- Requires: beneficiary schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= beneficiary --> partnership (11 constraint(s)) =========
-- Requires: beneficiary schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_receiving_organization_partner_org_id` FOREIGN KEY (`receiving_organization_partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= beneficiary --> program (15 constraint(s)) =========
-- Requires: beneficiary schema, program schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= beneficiary --> safeguarding (2 constraint(s)) =========
-- Requires: beneficiary schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);

-- ========= beneficiary --> supply (6 constraint(s)) =========
-- Requires: beneficiary schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`cva_transfer` ADD CONSTRAINT `fk_beneficiary_cva_transfer_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);

-- ========= compliance --> field (6 constraint(s)) =========
-- Requires: compliance schema, field schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `vibe_ngo_v1`.`field`.`security_incident`(`security_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ADD CONSTRAINT `fk_compliance_statutory_registration_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);

-- ========= compliance --> grant (2 constraint(s)) =========
-- Requires: compliance schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= compliance --> partnership (1 constraint(s)) =========
-- Requires: compliance schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= compliance --> program (4 constraint(s)) =========
-- Requires: compliance schema, program schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= compliance --> safeguarding (6 constraint(s)) =========
-- Requires: compliance schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ADD CONSTRAINT `fk_compliance_governance_policy_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ADD CONSTRAINT `fk_compliance_statutory_registration_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);

-- ========= donor --> compliance (18 constraint(s)) =========
-- Requires: donor schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);

-- ========= donor --> field (15 constraint(s)) =========
-- Requires: donor schema, field schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ADD CONSTRAINT `fk_donor_constituent_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= donor --> grant (5 constraint(s)) =========
-- Requires: donor schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_ngo_v1`.`grant`.`proposal`(`proposal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_ngo_v1`.`grant`.`proposal`(`proposal_id`);

-- ========= donor --> mel (6 constraint(s)) =========
-- Requires: donor schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);

-- ========= donor --> program (1 constraint(s)) =========
-- Requires: donor schema, program schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= donor --> safeguarding (2 constraint(s)) =========
-- Requires: donor schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);

-- ========= field --> beneficiary (3 constraint(s)) =========
-- Requires: field schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= field --> compliance (2 constraint(s)) =========
-- Requires: field schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ADD CONSTRAINT `fk_field_country_office_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);

-- ========= field --> grant (6 constraint(s)) =========
-- Requires: field schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ADD CONSTRAINT `fk_field_team_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= field --> mel (6 constraint(s)) =========
-- Requires: field schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= field --> partnership (9 constraint(s)) =========
-- Requires: field schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ADD CONSTRAINT `fk_field_team_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= field --> program (8 constraint(s)) =========
-- Requires: field schema, program schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= field --> supply (3 constraint(s)) =========
-- Requires: field schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= grant --> compliance (8 constraint(s)) =========
-- Requires: grant schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);

-- ========= grant --> donor (11 constraint(s)) =========
-- Requires: grant schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `vibe_ngo_v1`.`donor`.`prospect`(`prospect_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= grant --> field (10 constraint(s)) =========
-- Requires: grant schema, field schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`amendment` ADD CONSTRAINT `fk_grant_amendment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= grant --> mel (11 constraint(s)) =========
-- Requires: grant schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= grant --> partnership (10 constraint(s)) =========
-- Requires: grant schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= grant --> program (7 constraint(s)) =========
-- Requires: grant schema, program schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= grant --> safeguarding (5 constraint(s)) =========
-- Requires: grant schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`incident`(`incident_id`);

-- ========= mel --> compliance (3 constraint(s)) =========
-- Requires: mel schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= mel --> field (14 constraint(s)) =========
-- Requires: mel schema, field schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);

-- ========= mel --> grant (6 constraint(s)) =========
-- Requires: mel schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= mel --> partnership (13 constraint(s)) =========
-- Requires: mel schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_report_submission_id` FOREIGN KEY (`partner_report_submission_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_report_submission`(`partner_report_submission_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= mel --> program (22 constraint(s)) =========
-- Requires: mel schema, program schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_theory_of_change_id` FOREIGN KEY (`theory_of_change_id`) REFERENCES `vibe_ngo_v1`.`program`.`theory_of_change`(`theory_of_change_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_theory_of_change_id` FOREIGN KEY (`theory_of_change_id`) REFERENCES `vibe_ngo_v1`.`program`.`theory_of_change`(`theory_of_change_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);

-- ========= mel --> safeguarding (6 constraint(s)) =========
-- Requires: mel schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);

-- ========= mel --> supply (5 constraint(s)) =========
-- Requires: mel schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= partnership --> compliance (5 constraint(s)) =========
-- Requires: partnership schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ADD CONSTRAINT `fk_partnership_partner_org_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= partnership --> donor (1 constraint(s)) =========
-- Requires: partnership schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= partnership --> grant (7 constraint(s)) =========
-- Requires: partnership schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_donor_report_id` FOREIGN KEY (`donor_report_id`) REFERENCES `vibe_ngo_v1`.`grant`.`donor_report`(`donor_report_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);

-- ========= partnership --> mel (2 constraint(s)) =========
-- Requires: partnership schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= partnership --> program (7 constraint(s)) =========
-- Requires: partnership schema, program schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= partnership --> safeguarding (5 constraint(s)) =========
-- Requires: partnership schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ADD CONSTRAINT `fk_partnership_partner_org_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);

-- ========= program --> compliance (1 constraint(s)) =========
-- Requires: program schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= program --> donor (4 constraint(s)) =========
-- Requires: program schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ADD CONSTRAINT `fk_program_program_partnership_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= program --> field (7 constraint(s)) =========
-- Requires: program schema, field schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`logframe_row` ADD CONSTRAINT `fk_program_logframe_row_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ADD CONSTRAINT `fk_program_program_partnership_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);

-- ========= program --> grant (1 constraint(s)) =========
-- Requires: program schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= program --> partnership (3 constraint(s)) =========
-- Requires: program schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ADD CONSTRAINT `fk_program_program_partnership_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= program --> safeguarding (2 constraint(s)) =========
-- Requires: program schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);

-- ========= safeguarding --> beneficiary (3 constraint(s)) =========
-- Requires: safeguarding schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);

-- ========= safeguarding --> donor (1 constraint(s)) =========
-- Requires: safeguarding schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);

-- ========= safeguarding --> field (13 constraint(s)) =========
-- Requires: safeguarding schema, field schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);

-- ========= safeguarding --> grant (3 constraint(s)) =========
-- Requires: safeguarding schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= safeguarding --> partnership (2 constraint(s)) =========
-- Requires: safeguarding schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= safeguarding --> program (2 constraint(s)) =========
-- Requires: safeguarding schema, program schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`incident` ADD CONSTRAINT `fk_safeguarding_incident_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);

-- ========= supply --> beneficiary (5 constraint(s)) =========
-- Requires: supply schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_needs_assessment_id` FOREIGN KEY (`needs_assessment_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`needs_assessment`(`needs_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_needs_assessment_id` FOREIGN KEY (`needs_assessment_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`needs_assessment`(`needs_assessment_id`);

-- ========= supply --> compliance (5 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);

-- ========= supply --> donor (6 constraint(s)) =========
-- Requires: supply schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);

-- ========= supply --> field (20 constraint(s)) =========
-- Requires: supply schema, field schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);

-- ========= supply --> grant (11 constraint(s)) =========
-- Requires: supply schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget`(`award_budget_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= supply --> partnership (13 constraint(s)) =========
-- Requires: supply schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_due_diligence_record_id` FOREIGN KEY (`due_diligence_record_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`due_diligence_record`(`due_diligence_record_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= supply --> program (13 constraint(s)) =========
-- Requires: supply schema, program schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= supply --> safeguarding (4 constraint(s)) =========
-- Requires: supply schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_reporting_channel_id` FOREIGN KEY (`reporting_channel_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`reporting_channel`(`reporting_channel_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);

