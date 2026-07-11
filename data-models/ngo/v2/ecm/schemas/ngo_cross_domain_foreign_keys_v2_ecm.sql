-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:48:28
-- Total cross-domain FK constraints: 1204
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: beneficiary, communication, compliance, donor, field, finance, grant, mel, partnership, program, safeguarding, supply, technology, volunteer, workforce

-- ========= beneficiary --> communication (5 constraint(s)) =========
-- Requires: beneficiary schema, communication schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_community_engagement_event_id` FOREIGN KEY (`community_engagement_event_id`) REFERENCES `vibe_ngo_v1`.`communication`.`community_engagement_event`(`community_engagement_event_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_constituent_message_id` FOREIGN KEY (`constituent_message_id`) REFERENCES `vibe_ngo_v1`.`communication`.`constituent_message`(`constituent_message_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_feedback_submission_id` FOREIGN KEY (`feedback_submission_id`) REFERENCES `vibe_ngo_v1`.`communication`.`feedback_submission`(`feedback_submission_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_constituent_message_id` FOREIGN KEY (`constituent_message_id`) REFERENCES `vibe_ngo_v1`.`communication`.`constituent_message`(`constituent_message_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_feedback_submission_id` FOREIGN KEY (`feedback_submission_id`) REFERENCES `vibe_ngo_v1`.`communication`.`feedback_submission`(`feedback_submission_id`);

-- ========= beneficiary --> compliance (10 constraint(s)) =========
-- Requires: beneficiary schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ADD CONSTRAINT `fk_beneficiary_biometric_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= beneficiary --> field (8 constraint(s)) =========
-- Requires: beneficiary schema, field schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= beneficiary --> grant (3 constraint(s)) =========
-- Requires: beneficiary schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ADD CONSTRAINT `fk_beneficiary_community_intervention_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= beneficiary --> mel (2 constraint(s)) =========
-- Requires: beneficiary schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_mel_needs_assessment_id` FOREIGN KEY (`mel_needs_assessment_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_needs_assessment`(`mel_needs_assessment_id`);

-- ========= beneficiary --> partnership (6 constraint(s)) =========
-- Requires: beneficiary schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_receiving_organization_partner_org_id` FOREIGN KEY (`receiving_organization_partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= beneficiary --> program (17 constraint(s)) =========
-- Requires: beneficiary schema, program schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ADD CONSTRAINT `fk_beneficiary_biometric_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ADD CONSTRAINT `fk_beneficiary_exit_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ADD CONSTRAINT `fk_beneficiary_community_intervention_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= beneficiary --> supply (3 constraint(s)) =========
-- Requires: beneficiary schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);

-- ========= beneficiary --> technology (5 constraint(s)) =========
-- Requires: beneficiary schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_entitlement_last_modified_by_user_user_account_id` FOREIGN KEY (`entitlement_last_modified_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_approving_user_account_id` FOREIGN KEY (`approving_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

-- ========= beneficiary --> volunteer (5 constraint(s)) =========
-- Requires: beneficiary schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ADD CONSTRAINT `fk_beneficiary_service_assignment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ADD CONSTRAINT `fk_beneficiary_household_volunteer_assignment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= beneficiary --> workforce (19 constraint(s)) =========
-- Requires: beneficiary schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_receiving_staff_staff_member_id` FOREIGN KEY (`receiving_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ADD CONSTRAINT `fk_beneficiary_biometric_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ADD CONSTRAINT `fk_beneficiary_displacement_history_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ADD CONSTRAINT `fk_beneficiary_exit_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ADD CONSTRAINT `fk_beneficiary_service_assignment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= communication --> beneficiary (4 constraint(s)) =========
-- Requires: communication schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ADD CONSTRAINT `fk_communication_feedback_submission_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ADD CONSTRAINT `fk_communication_impact_story_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= communication --> compliance (8 constraint(s)) =========
-- Requires: communication schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ADD CONSTRAINT `fk_communication_advocacy_campaign_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ADD CONSTRAINT `fk_communication_constituent_consent_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ADD CONSTRAINT `fk_communication_constituent_consent_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ADD CONSTRAINT `fk_communication_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ADD CONSTRAINT `fk_communication_crisis_communication_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);

-- ========= communication --> donor (18 constraint(s)) =========
-- Requires: communication schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_stewardship_activity_id` FOREIGN KEY (`stewardship_activity_id`) REFERENCES `vibe_ngo_v1`.`donor`.`stewardship_activity`(`stewardship_activity_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ADD CONSTRAINT `fk_communication_campaign_touchpoint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`campaign_touchpoint` ADD CONSTRAINT `fk_communication_campaign_touchpoint_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ADD CONSTRAINT `fk_communication_impact_story_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ADD CONSTRAINT `fk_communication_digital_content_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ADD CONSTRAINT `fk_communication_email_broadcast_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ADD CONSTRAINT `fk_communication_email_broadcast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_ngo_v1`.`donor`.`segment`(`segment_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ADD CONSTRAINT `fk_communication_constituent_consent_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ADD CONSTRAINT `fk_communication_constituent_consent_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_gift_id` FOREIGN KEY (`gift_id`) REFERENCES `vibe_ngo_v1`.`donor`.`gift`(`gift_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ADD CONSTRAINT `fk_communication_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ADD CONSTRAINT `fk_communication_message_thread_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ADD CONSTRAINT `fk_communication_message_thread_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= communication --> field (7 constraint(s)) =========
-- Requires: communication schema, field schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ADD CONSTRAINT `fk_communication_feedback_submission_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_contact` ADD CONSTRAINT `fk_communication_media_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ADD CONSTRAINT `fk_communication_impact_story_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ADD CONSTRAINT `fk_communication_crisis_communication_sitrep_id` FOREIGN KEY (`sitrep_id`) REFERENCES `vibe_ngo_v1`.`field`.`sitrep`(`sitrep_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ADD CONSTRAINT `fk_communication_message_thread_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);

-- ========= communication --> grant (1 constraint(s)) =========
-- Requires: communication schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= communication --> partnership (3 constraint(s)) =========
-- Requires: communication schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ADD CONSTRAINT `fk_communication_feedback_submission_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= communication --> program (11 constraint(s)) =========
-- Requires: communication schema, program schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ADD CONSTRAINT `fk_communication_feedback_submission_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ADD CONSTRAINT `fk_communication_impact_story_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ADD CONSTRAINT `fk_communication_digital_content_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ADD CONSTRAINT `fk_communication_email_broadcast_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ADD CONSTRAINT `fk_communication_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ADD CONSTRAINT `fk_communication_message_thread_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);

-- ========= communication --> safeguarding (5 constraint(s)) =========
-- Requires: communication schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ADD CONSTRAINT `fk_communication_feedback_submission_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_community_awareness_session_id` FOREIGN KEY (`community_awareness_session_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`community_awareness_session`(`community_awareness_session_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ADD CONSTRAINT `fk_communication_crisis_communication_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);

-- ========= communication --> technology (3 constraint(s)) =========
-- Requires: communication schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_message` ADD CONSTRAINT `fk_communication_constituent_message_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ADD CONSTRAINT `fk_communication_plan_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`message_thread` ADD CONSTRAINT `fk_communication_message_thread_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

-- ========= communication --> volunteer (4 constraint(s)) =========
-- Requires: communication schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`media_activity` ADD CONSTRAINT `fk_communication_media_activity_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ADD CONSTRAINT `fk_communication_impact_story_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`impact_story` ADD CONSTRAINT `fk_communication_impact_story_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);

-- ========= communication --> workforce (14 constraint(s)) =========
-- Requires: communication schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`communication`.`advocacy_campaign` ADD CONSTRAINT `fk_communication_advocacy_campaign_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_submission` ADD CONSTRAINT `fk_communication_feedback_submission_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`feedback_case` ADD CONSTRAINT `fk_communication_feedback_case_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ADD CONSTRAINT `fk_communication_digital_content_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`digital_content` ADD CONSTRAINT `fk_communication_digital_content_tertiary_digital_author_staff_staff_member_id` FOREIGN KEY (`tertiary_digital_author_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`email_broadcast` ADD CONSTRAINT `fk_communication_email_broadcast_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`constituent_consent` ADD CONSTRAINT `fk_communication_constituent_consent_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`community_engagement_event` ADD CONSTRAINT `fk_communication_community_engagement_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint` ADD CONSTRAINT `fk_communication_donor_stewardship_touchpoint_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ADD CONSTRAINT `fk_communication_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`plan` ADD CONSTRAINT `fk_communication_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ADD CONSTRAINT `fk_communication_crisis_communication_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ADD CONSTRAINT `fk_communication_crisis_communication_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`communication`.`crisis_communication` ADD CONSTRAINT `fk_communication_crisis_communication_tertiary_crisis_communications_lead_staff_staff_member_id` FOREIGN KEY (`tertiary_crisis_communications_lead_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= compliance --> donor (1 constraint(s)) =========
-- Requires: compliance schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= compliance --> field (5 constraint(s)) =========
-- Requires: compliance schema, field schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ADD CONSTRAINT `fk_compliance_chs_self_assessment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`statutory_registration` ADD CONSTRAINT `fk_compliance_statutory_registration_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`cognizant_agency` ADD CONSTRAINT `fk_compliance_cognizant_agency_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);

-- ========= compliance --> finance (1 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= compliance --> grant (5 constraint(s)) =========
-- Requires: compliance schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= compliance --> partnership (2 constraint(s)) =========
-- Requires: compliance schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ADD CONSTRAINT `fk_compliance_iati_publication_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= compliance --> program (5 constraint(s)) =========
-- Requires: compliance schema, program schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ADD CONSTRAINT `fk_compliance_chs_self_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= compliance --> safeguarding (5 constraint(s)) =========
-- Requires: compliance schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ADD CONSTRAINT `fk_compliance_chs_self_assessment_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ADD CONSTRAINT `fk_compliance_governance_policy_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);

-- ========= compliance --> technology (16 constraint(s)) =========
-- Requires: compliance schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_vulnerability_id` FOREIGN KEY (`vulnerability_id`) REFERENCES `vibe_ngo_v1`.`technology`.`vulnerability`(`vulnerability_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `vibe_ngo_v1`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`chs_self_assessment` ADD CONSTRAINT `fk_compliance_chs_self_assessment_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`iati_publication` ADD CONSTRAINT `fk_compliance_iati_publication_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`governance_policy` ADD CONSTRAINT `fk_compliance_governance_policy_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_it_incident_id` FOREIGN KEY (`it_incident_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_incident`(`it_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_security_assessment_id` FOREIGN KEY (`security_assessment_id`) REFERENCES `vibe_ngo_v1`.`technology`.`security_assessment`(`security_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);

-- ========= compliance --> workforce (11 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`obligation_schedule` ADD CONSTRAINT `fk_compliance_obligation_schedule_tertiary_obligation_assigned_officer_staff_member_id` FOREIGN KEY (`tertiary_obligation_assigned_officer_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_corrective_responsible_staff_member_id` FOREIGN KEY (`corrective_responsible_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_primary_corrective_staff_member_id` FOREIGN KEY (`primary_corrective_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_tertiary_corrective_responsible_manager_staff_member_id` FOREIGN KEY (`tertiary_corrective_responsible_manager_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_assigned_staff_member_id` FOREIGN KEY (`assigned_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_donor_responsible_staff_member_id` FOREIGN KEY (`donor_responsible_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_responsible_staff_member_id` FOREIGN KEY (`responsible_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= donor --> communication (3 constraint(s)) =========
-- Requires: donor schema, communication schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`portfolio_assignment` ADD CONSTRAINT `fk_donor_portfolio_assignment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_email_broadcast_id` FOREIGN KEY (`email_broadcast_id`) REFERENCES `vibe_ngo_v1`.`communication`.`email_broadcast`(`email_broadcast_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_digital_content_id` FOREIGN KEY (`digital_content_id`) REFERENCES `vibe_ngo_v1`.`communication`.`digital_content`(`digital_content_id`);

-- ========= donor --> compliance (11 constraint(s)) =========
-- Requires: donor schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`planned_giving` ADD CONSTRAINT `fk_donor_planned_giving_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= donor --> field (5 constraint(s)) =========
-- Requires: donor schema, field schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ADD CONSTRAINT `fk_donor_constituent_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= donor --> finance (8 constraint(s)) =========
-- Requires: donor schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`planned_giving` ADD CONSTRAINT `fk_donor_planned_giving_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= donor --> grant (1 constraint(s)) =========
-- Requires: donor schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= donor --> mel (6 constraint(s)) =========
-- Requires: donor schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_indicator_result_id` FOREIGN KEY (`indicator_result_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator_result`(`indicator_result_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`indicator_funding` ADD CONSTRAINT `fk_donor_indicator_funding_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);

-- ========= donor --> program (4 constraint(s)) =========
-- Requires: donor schema, program schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= donor --> safeguarding (3 constraint(s)) =========
-- Requires: donor schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_stewardship_safeguarding_safeguarding_incident_id` FOREIGN KEY (`stewardship_safeguarding_safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);

-- ========= donor --> supply (1 constraint(s)) =========
-- Requires: donor schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= donor --> technology (3 constraint(s)) =========
-- Requires: donor schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`soft_credit` ADD CONSTRAINT `fk_donor_soft_credit_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

-- ========= donor --> volunteer (1 constraint(s)) =========
-- Requires: donor schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`event_volunteer_assignment` ADD CONSTRAINT `fk_donor_event_volunteer_assignment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= donor --> workforce (13 constraint(s)) =========
-- Requires: donor schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`segment` ADD CONSTRAINT `fk_donor_segment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`segment` ADD CONSTRAINT `fk_donor_segment_primary_segment_created_by_staff_staff_member_id` FOREIGN KEY (`primary_segment_created_by_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`segment` ADD CONSTRAINT `fk_donor_segment_tertiary_segment_staff_member_id` FOREIGN KEY (`tertiary_segment_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`portfolio_assignment` ADD CONSTRAINT `fk_donor_portfolio_assignment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`soft_credit` ADD CONSTRAINT `fk_donor_soft_credit_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal_targeting` ADD CONSTRAINT `fk_donor_appeal_targeting_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`participation` ADD CONSTRAINT `fk_donor_participation_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`segment_membership` ADD CONSTRAINT `fk_donor_segment_membership_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= field --> beneficiary (8 constraint(s)) =========
-- Requires: field schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_assessment_respondent_registrant_id` FOREIGN KEY (`assessment_respondent_registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_respondent_registrant_id` FOREIGN KEY (`respondent_registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);

-- ========= field --> communication (6 constraint(s)) =========
-- Requires: field schema, communication schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_impact_story_id` FOREIGN KEY (`impact_story_id`) REFERENCES `vibe_ngo_v1`.`communication`.`impact_story`(`impact_story_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_crisis_communication_id` FOREIGN KEY (`crisis_communication_id`) REFERENCES `vibe_ngo_v1`.`communication`.`crisis_communication`(`crisis_communication_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_feedback_case_id` FOREIGN KEY (`feedback_case_id`) REFERENCES `vibe_ngo_v1`.`communication`.`feedback_case`(`feedback_case_id`);

-- ========= field --> compliance (8 constraint(s)) =========
-- Requires: field schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`cluster_coordination` ADD CONSTRAINT `fk_field_cluster_coordination_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);

-- ========= field --> finance (16 constraint(s)) =========
-- Requires: field schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ADD CONSTRAINT `fk_field_country_office_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_distribution_line` ADD CONSTRAINT `fk_field_field_distribution_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= field --> grant (9 constraint(s)) =========
-- Requires: field schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_distribution_line` ADD CONSTRAINT `fk_field_field_distribution_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= field --> mel (2 constraint(s)) =========
-- Requires: field schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);

-- ========= field --> partnership (16 constraint(s)) =========
-- Requires: field schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_coordination_meeting_id` FOREIGN KEY (`coordination_meeting_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`coordination_meeting`(`coordination_meeting_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`cluster_coordination` ADD CONSTRAINT `fk_field_cluster_coordination_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= field --> program (11 constraint(s)) =========
-- Requires: field schema, program schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= field --> safeguarding (4 constraint(s)) =========
-- Requires: field schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_safeguarding_training_completion_id` FOREIGN KEY (`safeguarding_training_completion_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion`(`safeguarding_training_completion_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);

-- ========= field --> supply (5 constraint(s)) =========
-- Requires: field schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`field`.`field_distribution_line` ADD CONSTRAINT `fk_field_field_distribution_line_supply_distribution_line_id` FOREIGN KEY (`supply_distribution_line_id`) REFERENCES `vibe_ngo_v1`.`supply`.`supply_distribution_line`(`supply_distribution_line_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_ngo_v1`.`supply`.`shipment`(`shipment_id`);

-- ========= field --> technology (8 constraint(s)) =========
-- Requires: field schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_network_site_id` FOREIGN KEY (`network_site_id`) REFERENCES `vibe_ngo_v1`.`technology`.`network_site`(`network_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ADD CONSTRAINT `fk_field_country_office_network_site_id` FOREIGN KEY (`network_site_id`) REFERENCES `vibe_ngo_v1`.`technology`.`network_site`(`network_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);

-- ========= field --> volunteer (4 constraint(s)) =========
-- Requires: field schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_participation` ADD CONSTRAINT `fk_field_assessment_participation_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_participation` ADD CONSTRAINT `fk_field_distribution_participation_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= field --> workforce (11 constraint(s)) =========
-- Requires: field schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`mobile_health_outreach` ADD CONSTRAINT `fk_field_mobile_health_outreach_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`wash_intervention` ADD CONSTRAINT `fk_field_wash_intervention_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`cluster_coordination` ADD CONSTRAINT `fk_field_cluster_coordination_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`pdm_survey` ADD CONSTRAINT `fk_field_pdm_survey_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= finance --> compliance (13 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ADD CONSTRAINT `fk_finance_nicra_rate_nicra_agreement_id` FOREIGN KEY (`nicra_agreement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`nicra_agreement`(`nicra_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_nicra_agreement_id` FOREIGN KEY (`nicra_agreement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`nicra_agreement`(`nicra_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ADD CONSTRAINT `fk_finance_fund_compliance_tracking_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= finance --> donor (10 constraint(s)) =========
-- Requires: finance schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= finance --> field (20 constraint(s)) =========
-- Requires: finance schema, field schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_deployment`(`field_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_wash_intervention_id` FOREIGN KEY (`wash_intervention_id`) REFERENCES `vibe_ngo_v1`.`field`.`wash_intervention`(`wash_intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_wash_intervention_id` FOREIGN KEY (`wash_intervention_id`) REFERENCES `vibe_ngo_v1`.`field`.`wash_intervention`(`wash_intervention_id`);

-- ========= finance --> grant (17 constraint(s)) =========
-- Requires: finance schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ADD CONSTRAINT `fk_finance_exchange_rate_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= finance --> program (5 constraint(s)) =========
-- Requires: finance schema, program schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);

-- ========= finance --> supply (6 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_ngo_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> technology (14 constraint(s)) =========
-- Requires: finance schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_tertiary_cost_approved_by_user_user_account_id` FOREIGN KEY (`tertiary_cost_approved_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tertiary_journal_created_by_user_user_account_id` FOREIGN KEY (`tertiary_journal_created_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_tertiary_bank_approved_by_user_user_account_id` FOREIGN KEY (`tertiary_bank_approved_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_bank_modified_by_user_user_account_id` FOREIGN KEY (`bank_modified_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_bank_reconciled_by_user_account_id` FOREIGN KEY (`bank_reconciled_by_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_initiating_user_account_id` FOREIGN KEY (`initiating_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

-- ========= finance --> workforce (15 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`nicra_rate` ADD CONSTRAINT `fk_finance_nicra_rate_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`exchange_rate` ADD CONSTRAINT `fk_finance_exchange_rate_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`fund_compliance_tracking` ADD CONSTRAINT `fk_finance_fund_compliance_tracking_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_created_by_staff_member_id` FOREIGN KEY (`payment_created_by_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_approving_staff_member_id` FOREIGN KEY (`approving_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= grant --> communication (2 constraint(s)) =========
-- Requires: grant schema, communication schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_impact_story_id` FOREIGN KEY (`impact_story_id`) REFERENCES `vibe_ngo_v1`.`communication`.`impact_story`(`impact_story_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_advocacy_campaign_id` FOREIGN KEY (`advocacy_campaign_id`) REFERENCES `vibe_ngo_v1`.`communication`.`advocacy_campaign`(`advocacy_campaign_id`);

-- ========= grant --> compliance (3 constraint(s)) =========
-- Requires: grant schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_nicra_agreement_id` FOREIGN KEY (`nicra_agreement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`nicra_agreement`(`nicra_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ADD CONSTRAINT `fk_grant_grant_closeout_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= grant --> donor (6 constraint(s)) =========
-- Requires: grant schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= grant --> field (7 constraint(s)) =========
-- Requires: grant schema, field schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_site_allocation` ADD CONSTRAINT `fk_grant_award_site_allocation_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= grant --> finance (4 constraint(s)) =========
-- Requires: grant schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);

-- ========= grant --> mel (9 constraint(s)) =========
-- Requires: grant schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ADD CONSTRAINT `fk_grant_grant_closeout_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);

-- ========= grant --> partnership (4 constraint(s)) =========
-- Requires: grant schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= grant --> program (10 constraint(s)) =========
-- Requires: grant schema, program schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= grant --> supply (1 constraint(s)) =========
-- Requires: grant schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_inkind_donation_id` FOREIGN KEY (`inkind_donation_id`) REFERENCES `vibe_ngo_v1`.`supply`.`inkind_donation`(`inkind_donation_id`);

-- ========= grant --> technology (1 constraint(s)) =========
-- Requires: grant schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`asset_allocation` ADD CONSTRAINT `fk_grant_asset_allocation_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);

-- ========= grant --> workforce (11 constraint(s)) =========
-- Requires: grant schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`prior_approval` ADD CONSTRAINT `fk_grant_prior_approval_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_closeout` ADD CONSTRAINT `fk_grant_grant_closeout_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_position_funding` ADD CONSTRAINT `fk_grant_award_position_funding_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ADD CONSTRAINT `fk_grant_grant_staff_assignment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ADD CONSTRAINT `fk_grant_grant_staff_assignment_grant_assigned_staff_member_id` FOREIGN KEY (`grant_assigned_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ADD CONSTRAINT `fk_grant_grant_staff_assignment_grant_workforce_staff_assignment_id` FOREIGN KEY (`grant_workforce_staff_assignment_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment`(`workforce_staff_assignment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ADD CONSTRAINT `fk_grant_grant_staff_assignment_workforce_staff_assignment_id` FOREIGN KEY (`workforce_staff_assignment_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment`(`workforce_staff_assignment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`grant_staff_assignment` ADD CONSTRAINT `fk_grant_grant_staff_assignment_assigned_staff_member_id` FOREIGN KEY (`assigned_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= mel --> beneficiary (1 constraint(s)) =========
-- Requires: mel schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= mel --> communication (4 constraint(s)) =========
-- Requires: mel schema, communication schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_advocacy_campaign_id` FOREIGN KEY (`advocacy_campaign_id`) REFERENCES `vibe_ngo_v1`.`communication`.`advocacy_campaign`(`advocacy_campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ADD CONSTRAINT `fk_mel_mel_needs_assessment_advocacy_campaign_id` FOREIGN KEY (`advocacy_campaign_id`) REFERENCES `vibe_ngo_v1`.`communication`.`advocacy_campaign`(`advocacy_campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_donor_stewardship_touchpoint_id` FOREIGN KEY (`donor_stewardship_touchpoint_id`) REFERENCES `vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint`(`donor_stewardship_touchpoint_id`);

-- ========= mel --> compliance (5 constraint(s)) =========
-- Requires: mel schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`single_audit`(`single_audit_id`);

-- ========= mel --> donor (1 constraint(s)) =========
-- Requires: mel schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= mel --> field (6 constraint(s)) =========
-- Requires: mel schema, field schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ADD CONSTRAINT `fk_mel_mel_needs_assessment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= mel --> finance (6 constraint(s)) =========
-- Requires: mel schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_ngo_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);

-- ========= mel --> grant (13 constraint(s)) =========
-- Requires: mel schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_donor_report_id` FOREIGN KEY (`donor_report_id`) REFERENCES `vibe_ngo_v1`.`grant`.`donor_report`(`donor_report_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ADD CONSTRAINT `fk_mel_mel_needs_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= mel --> partnership (30 constraint(s)) =========
-- Requires: mel schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_field_monitoring_visit_id` FOREIGN KEY (`field_monitoring_visit_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`field_monitoring_visit`(`field_monitoring_visit_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_report_submission_id` FOREIGN KEY (`partner_report_submission_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_report_submission`(`partner_report_submission_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_partner_report_submission_id` FOREIGN KEY (`partner_report_submission_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_report_submission`(`partner_report_submission_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_field_monitoring_visit_id` FOREIGN KEY (`field_monitoring_visit_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`field_monitoring_visit`(`field_monitoring_visit_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ADD CONSTRAINT `fk_mel_mel_needs_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_field_monitoring_visit_id` FOREIGN KEY (`field_monitoring_visit_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`field_monitoring_visit`(`field_monitoring_visit_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_partner_report_submission_id` FOREIGN KEY (`partner_report_submission_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_report_submission`(`partner_report_submission_id`);

-- ========= mel --> program (17 constraint(s)) =========
-- Requires: mel schema, program schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ADD CONSTRAINT `fk_mel_mel_needs_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);

-- ========= mel --> safeguarding (4 constraint(s)) =========
-- Requires: mel schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_donor_safeguarding_requirement_id` FOREIGN KEY (`donor_safeguarding_requirement_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement`(`donor_safeguarding_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);

-- ========= mel --> supply (2 constraint(s)) =========
-- Requires: mel schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_ngo_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);

-- ========= mel --> technology (11 constraint(s)) =========
-- Requires: mel schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_reporting_created_by_user_user_account_id` FOREIGN KEY (`reporting_created_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_reporting_modified_by_user_user_account_id` FOREIGN KEY (`reporting_modified_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_owner_user_account_id` FOREIGN KEY (`owner_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

-- ========= mel --> volunteer (3 constraint(s)) =========
-- Requires: mel schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= mel --> workforce (16 constraint(s)) =========
-- Requires: mel schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_tertiary_qualitative_translator_staff_staff_member_id` FOREIGN KEY (`tertiary_qualitative_translator_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`dhis2_aggregate_report` ADD CONSTRAINT `fk_mel_dhis2_aggregate_report_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`learning_agenda` ADD CONSTRAINT `fk_mel_learning_agenda_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_needs_assessment` ADD CONSTRAINT `fk_mel_mel_needs_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_reviewer_staff_staff_member_id` FOREIGN KEY (`reviewer_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`geographic_scope` ADD CONSTRAINT `fk_mel_geographic_scope_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= partnership --> communication (4 constraint(s)) =========
-- Requires: partnership schema, communication schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_advocacy_campaign_id` FOREIGN KEY (`advocacy_campaign_id`) REFERENCES `vibe_ngo_v1`.`communication`.`advocacy_campaign`(`advocacy_campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ADD CONSTRAINT `fk_partnership_coordination_meeting_crisis_communication_id` FOREIGN KEY (`crisis_communication_id`) REFERENCES `vibe_ngo_v1`.`communication`.`crisis_communication`(`crisis_communication_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ADD CONSTRAINT `fk_partnership_campaign_participation_advocacy_campaign_id` FOREIGN KEY (`advocacy_campaign_id`) REFERENCES `vibe_ngo_v1`.`communication`.`advocacy_campaign`(`advocacy_campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ADD CONSTRAINT `fk_partnership_consortium_communication_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_ngo_v1`.`communication`.`plan`(`plan_id`);

-- ========= partnership --> compliance (9 constraint(s)) =========
-- Requires: partnership schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ADD CONSTRAINT `fk_partnership_partner_org_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ADD CONSTRAINT `fk_partnership_partner_compliance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);

-- ========= partnership --> donor (1 constraint(s)) =========
-- Requires: partnership schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= partnership --> finance (4 constraint(s)) =========
-- Requires: partnership schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= partnership --> grant (11 constraint(s)) =========
-- Requires: partnership schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ADD CONSTRAINT `fk_partnership_partner_risk_register_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ADD CONSTRAINT `fk_partnership_mou_obligation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= partnership --> program (8 constraint(s)) =========
-- Requires: partnership schema, program schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ADD CONSTRAINT `fk_partnership_mou_obligation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= partnership --> safeguarding (2 constraint(s)) =========
-- Requires: partnership schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`training_program`(`training_program_id`);

-- ========= partnership --> technology (7 constraint(s)) =========
-- Requires: partnership schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ADD CONSTRAINT `fk_partnership_partner_contact_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ADD CONSTRAINT `fk_partnership_coordination_meeting_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);

-- ========= partnership --> volunteer (3 constraint(s)) =========
-- Requires: partnership schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ADD CONSTRAINT `fk_partnership_coordination_meeting_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= partnership --> workforce (14 constraint(s)) =========
-- Requires: partnership schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ADD CONSTRAINT `fk_partnership_partner_org_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ADD CONSTRAINT `fk_partnership_coordination_meeting_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ADD CONSTRAINT `fk_partnership_partner_risk_register_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ADD CONSTRAINT `fk_partnership_consortium_communication_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= program --> beneficiary (1 constraint(s)) =========
-- Requires: program schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);

-- ========= program --> compliance (14 constraint(s)) =========
-- Requires: program schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ADD CONSTRAINT `fk_program_theory_of_change_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ADD CONSTRAINT `fk_program_program_logframe_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ADD CONSTRAINT `fk_program_design_assessment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ADD CONSTRAINT `fk_program_program_closeout_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ADD CONSTRAINT `fk_program_intervention_compliance_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= program --> donor (5 constraint(s)) =========
-- Requires: program schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= program --> finance (6 constraint(s)) =========
-- Requires: program schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_ngo_v1`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= program --> grant (7 constraint(s)) =========
-- Requires: program schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `vibe_ngo_v1`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ADD CONSTRAINT `fk_program_program_closeout_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ADD CONSTRAINT `fk_program_program_closeout_grant_closeout_id` FOREIGN KEY (`grant_closeout_id`) REFERENCES `vibe_ngo_v1`.`grant`.`grant_closeout`(`grant_closeout_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= program --> mel (2 constraint(s)) =========
-- Requires: program schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ADD CONSTRAINT `fk_program_program_logframe_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component_indicator` ADD CONSTRAINT `fk_program_component_indicator_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);

-- ========= program --> partnership (8 constraint(s)) =========
-- Requires: program schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ADD CONSTRAINT `fk_program_program_closeout_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_partnership` ADD CONSTRAINT `fk_program_program_partnership_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= program --> safeguarding (2 constraint(s)) =========
-- Requires: program schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_partner_psea_assessment_id` FOREIGN KEY (`partner_psea_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment`(`partner_psea_assessment_id`);

-- ========= program --> technology (8 constraint(s)) =========
-- Requires: program schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_it_project_id` FOREIGN KEY (`it_project_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_it_project_id` FOREIGN KEY (`it_project_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_it_project_id` FOREIGN KEY (`it_project_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component_system_usage` ADD CONSTRAINT `fk_program_component_system_usage_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);

-- ========= program --> workforce (14 constraint(s)) =========
-- Requires: program schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`theory_of_change` ADD CONSTRAINT `fk_program_theory_of_change_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ADD CONSTRAINT `fk_program_program_logframe_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`design_assessment` ADD CONSTRAINT `fk_program_design_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program_closeout` ADD CONSTRAINT `fk_program_program_closeout_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention_compliance` ADD CONSTRAINT `fk_program_intervention_compliance_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= safeguarding --> beneficiary (5 constraint(s)) =========
-- Requires: safeguarding schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ADD CONSTRAINT `fk_safeguarding_support_service_referral_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ADD CONSTRAINT `fk_safeguarding_support_service_referral_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);

-- ========= safeguarding --> donor (4 constraint(s)) =========
-- Requires: safeguarding schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ADD CONSTRAINT `fk_safeguarding_donor_safeguarding_requirement_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= safeguarding --> field (16 constraint(s)) =========
-- Requires: safeguarding schema, field schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_focal_assigned_country_office_id` FOREIGN KEY (`focal_assigned_country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_assigned_country_office_id` FOREIGN KEY (`assigned_country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ADD CONSTRAINT `fk_safeguarding_misconduct_disclosure_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ADD CONSTRAINT `fk_safeguarding_psea_network_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);

-- ========= safeguarding --> finance (10 constraint(s)) =========
-- Requires: safeguarding schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ADD CONSTRAINT `fk_safeguarding_training_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);

-- ========= safeguarding --> grant (8 constraint(s)) =========
-- Requires: safeguarding schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ADD CONSTRAINT `fk_safeguarding_donor_safeguarding_requirement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= safeguarding --> partnership (8 constraint(s)) =========
-- Requires: safeguarding schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= safeguarding --> program (10 constraint(s)) =========
-- Requires: safeguarding schema, program schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= safeguarding --> supply (5 constraint(s)) =========
-- Requires: safeguarding schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= safeguarding --> technology (14 constraint(s)) =========
-- Requires: safeguarding schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ADD CONSTRAINT `fk_safeguarding_training_program_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ADD CONSTRAINT `fk_safeguarding_training_program_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ADD CONSTRAINT `fk_safeguarding_misconduct_disclosure_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

-- ========= safeguarding --> volunteer (3 constraint(s)) =========
-- Requires: safeguarding schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_volunteer_training_completion_id` FOREIGN KEY (`volunteer_training_completion_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion`(`volunteer_training_completion_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_volunteer_policy_acknowledgment_id` FOREIGN KEY (`volunteer_policy_acknowledgment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment`(`volunteer_policy_acknowledgment_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= safeguarding --> workforce (41 constraint(s)) =========
-- Requires: safeguarding schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ADD CONSTRAINT `fk_safeguarding_psea_policy_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_tertiary_survivor_last_modified_by_staff_staff_member_id` FOREIGN KEY (`tertiary_survivor_last_modified_by_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ADD CONSTRAINT `fk_safeguarding_support_service_referral_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_separation_event_id` FOREIGN KEY (`separation_event_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`separation_event`(`separation_event_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ADD CONSTRAINT `fk_safeguarding_training_program_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ADD CONSTRAINT `fk_safeguarding_training_program_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_safeguarding_acknowledging_staff_member_id` FOREIGN KEY (`safeguarding_acknowledging_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_acknowledging_staff_member_id` FOREIGN KEY (`acknowledging_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_tertiary_focal_reporting_line_staff_staff_member_id` FOREIGN KEY (`tertiary_focal_reporting_line_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_tertiary_quinary_focal_last_modified_by_staff_staff_member_id` FOREIGN KEY (`tertiary_quinary_focal_last_modified_by_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_tertiary_psea_focal_point_staff_staff_member_id` FOREIGN KEY (`tertiary_psea_focal_point_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ADD CONSTRAINT `fk_safeguarding_misconduct_disclosure_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ADD CONSTRAINT `fk_safeguarding_misconduct_disclosure_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ADD CONSTRAINT `fk_safeguarding_misconduct_disclosure_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_tertiary_audit_created_by_staff_staff_member_id` FOREIGN KEY (`tertiary_audit_created_by_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_tertiary_quinary_audit_responsible_owner_staff_staff_member_id` FOREIGN KEY (`tertiary_quinary_audit_responsible_owner_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ADD CONSTRAINT `fk_safeguarding_donor_safeguarding_requirement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ADD CONSTRAINT `fk_safeguarding_donor_safeguarding_requirement_tertiary_donor_last_modified_by_staff_staff_member_id` FOREIGN KEY (`tertiary_donor_last_modified_by_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_tertiary_partner_created_by_staff_staff_member_id` FOREIGN KEY (`tertiary_partner_created_by_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_tertiary_community_created_by_staff_staff_member_id` FOREIGN KEY (`tertiary_community_created_by_staff_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= supply --> beneficiary (6 constraint(s)) =========
-- Requires: supply schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_beneficiary_needs_assessment_id` FOREIGN KEY (`beneficiary_needs_assessment_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment`(`beneficiary_needs_assessment_id`);

-- ========= supply --> communication (3 constraint(s)) =========
-- Requires: supply schema, communication schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_impact_story_id` FOREIGN KEY (`impact_story_id`) REFERENCES `vibe_ngo_v1`.`communication`.`impact_story`(`impact_story_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_feedback_case_id` FOREIGN KEY (`feedback_case_id`) REFERENCES `vibe_ngo_v1`.`communication`.`feedback_case`(`feedback_case_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_crisis_communication_id` FOREIGN KEY (`crisis_communication_id`) REFERENCES `vibe_ngo_v1`.`communication`.`crisis_communication`(`crisis_communication_id`);

-- ========= supply --> compliance (8 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= supply --> donor (5 constraint(s)) =========
-- Requires: supply schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);

-- ========= supply --> field (14 constraint(s)) =========
-- Requires: supply schema, field schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);

-- ========= supply --> finance (20 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supply --> grant (9 constraint(s)) =========
-- Requires: supply schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= supply --> partnership (15 constraint(s)) =========
-- Requires: supply schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity_supply_agreement` ADD CONSTRAINT `fk_supply_commodity_supply_agreement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= supply --> program (9 constraint(s)) =========
-- Requires: supply schema, program schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ADD CONSTRAINT `fk_supply_commodity_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inkind_donation` ADD CONSTRAINT `fk_supply_inkind_donation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= supply --> technology (12 constraint(s)) =========
-- Requires: supply schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_tertiary_purchase_modified_by_user_user_account_id` FOREIGN KEY (`tertiary_purchase_modified_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_tertiary_procurement_last_modified_by_user_user_account_id` FOREIGN KEY (`tertiary_procurement_last_modified_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

-- ========= supply --> workforce (8 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`framework_agreement` ADD CONSTRAINT `fk_supply_framework_agreement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= technology --> field (3 constraint(s)) =========
-- Requires: technology schema, field schema
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ADD CONSTRAINT `fk_technology_network_site_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ADD CONSTRAINT `fk_technology_connectivity_log_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);

-- ========= technology --> grant (5 constraint(s)) =========
-- Requires: technology schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ADD CONSTRAINT `fk_technology_security_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= technology --> partnership (1 constraint(s)) =========
-- Requires: technology schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ADD CONSTRAINT `fk_technology_user_account_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= technology --> safeguarding (1 constraint(s)) =========
-- Requires: technology schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ADD CONSTRAINT `fk_technology_security_control_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);

-- ========= technology --> supply (1 constraint(s)) =========
-- Requires: technology schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= technology --> workforce (22 constraint(s)) =========
-- Requires: technology schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ADD CONSTRAINT `fk_technology_user_account_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_primary_access_staff_member_id` FOREIGN KEY (`primary_access_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_tertiary_access_compliance_signoff_by_staff_member_id` FOREIGN KEY (`tertiary_access_compliance_signoff_by_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_primary_it_staff_member_id` FOREIGN KEY (`primary_it_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_tertiary_it_business_sponsor_staff_member_id` FOREIGN KEY (`tertiary_it_business_sponsor_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_tertiary_it_staff_member_id` FOREIGN KEY (`tertiary_it_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_lead_staff_member_id` FOREIGN KEY (`lead_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ADD CONSTRAINT `fk_technology_platform_integration_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ADD CONSTRAINT `fk_technology_platform_integration_primary_platform_staff_member_id` FOREIGN KEY (`primary_platform_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_primary_it_staff_member_id` FOREIGN KEY (`primary_it_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ADD CONSTRAINT `fk_technology_cab_meeting_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_owner_staff_member_id` FOREIGN KEY (`owner_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_reviewer_staff_member_id` FOREIGN KEY (`reviewer_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_author_staff_member_id` FOREIGN KEY (`author_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= volunteer --> beneficiary (7 constraint(s)) =========
-- Requires: volunteer schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= volunteer --> compliance (13 constraint(s)) =========
-- Requires: volunteer schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_chs_self_assessment_id` FOREIGN KEY (`chs_self_assessment_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`chs_self_assessment`(`chs_self_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= volunteer --> donor (3 constraint(s)) =========
-- Requires: volunteer schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`donor_fund`(`donor_fund_id`);

-- ========= volunteer --> field (24 constraint(s)) =========
-- Requires: volunteer schema, field schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_deployment`(`field_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_mobile_health_outreach_id` FOREIGN KEY (`mobile_health_outreach_id`) REFERENCES `vibe_ngo_v1`.`field`.`mobile_health_outreach`(`mobile_health_outreach_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_wash_intervention_id` FOREIGN KEY (`wash_intervention_id`) REFERENCES `vibe_ngo_v1`.`field`.`wash_intervention`(`wash_intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_deployment`(`field_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `vibe_ngo_v1`.`field`.`security_incident`(`security_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_deployment`(`field_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_deployment`(`field_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_deployment`(`field_deployment_id`);

-- ========= volunteer --> finance (12 constraint(s)) =========
-- Requires: volunteer schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `vibe_ngo_v1`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_ngo_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_ngo_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= volunteer --> grant (3 constraint(s)) =========
-- Requires: volunteer schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= volunteer --> mel (5 constraint(s)) =========
-- Requires: volunteer schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ADD CONSTRAINT `fk_volunteer_tool_authorization_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);

-- ========= volunteer --> partnership (5 constraint(s)) =========
-- Requires: volunteer schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= volunteer --> program (12 constraint(s)) =========
-- Requires: volunteer schema, program schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ADD CONSTRAINT `fk_volunteer_role_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= volunteer --> safeguarding (7 constraint(s)) =========
-- Requires: volunteer schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ADD CONSTRAINT `fk_volunteer_role_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`training_program`(`training_program_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ADD CONSTRAINT `fk_volunteer_volunteer_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`training_program`(`training_program_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ADD CONSTRAINT `fk_volunteer_volunteer_policy_acknowledgment_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);

-- ========= volunteer --> supply (8 constraint(s)) =========
-- Requires: volunteer schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);

-- ========= volunteer --> technology (4 constraint(s)) =========
-- Requires: volunteer schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);

-- ========= volunteer --> workforce (16 constraint(s)) =========
-- Requires: volunteer schema, workforce schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_recognition_nominator_staff_member_id` FOREIGN KEY (`recognition_nominator_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_nominating_staff_member_id` FOREIGN KEY (`nominating_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ADD CONSTRAINT `fk_volunteer_volunteer_training_completion_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ADD CONSTRAINT `fk_volunteer_volunteer_policy_acknowledgment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ADD CONSTRAINT `fk_volunteer_tool_authorization_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= workforce --> compliance (2 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ADD CONSTRAINT `fk_workforce_staff_certification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_ngo_v1`.`compliance`.`obligation`(`obligation_id`);

-- ========= workforce --> field (3 constraint(s)) =========
-- Requires: workforce schema, field schema
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= workforce --> finance (2 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_ngo_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_ngo_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= workforce --> grant (7 constraint(s)) =========
-- Requires: workforce schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ADD CONSTRAINT `fk_workforce_expat_package_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= workforce --> program (7 constraint(s)) =========
-- Requires: workforce schema, program schema
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= workforce --> safeguarding (2 constraint(s)) =========
-- Requires: workforce schema, safeguarding schema
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_disciplinary_outcome_id` FOREIGN KEY (`disciplinary_outcome_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome`(`disciplinary_outcome_id`);

-- ========= workforce --> technology (10 constraint(s)) =========
-- Requires: workforce schema, technology schema
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_performance_modified_by_user_user_account_id` FOREIGN KEY (`performance_modified_by_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_review_closed_by_user_id` FOREIGN KEY (`review_closed_by_user_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_review_created_by_user_id` FOREIGN KEY (`review_created_by_user_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_review_modified_by_user_id` FOREIGN KEY (`review_modified_by_user_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);

